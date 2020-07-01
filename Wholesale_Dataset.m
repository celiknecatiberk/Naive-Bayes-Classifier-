%User enters classification data.
fprintf('Please, Enter Classification Data!!!');
fprintf('\n');
%User enters first classification data.
f_data=input('Enter First Classification Data!:');
fprintf('\n');
%User enters second classification data.
s_data=input('Enter Second Classification Data!:');
 
%This command reads data from excel file.
D = xlsread('Wholesale_Customer.xlsx');
 
%Calculates the number of columns (attributes) and the number of rows.
w_width=length(D(1,:))
h_height=length(D(:,1))
 
%Returns all rows, according to the number of columns in the dataset.
D(:,1:w_width);
%Returns all columns, according to the number of rows in the dataset.
W = (D(:,w_width));
 
%Returns unique values in W.
u_unique=unique(W);
%Number of all rows in the first column.
num_arr= numel(D(:,1));
n1=0;
n2=0;
 
%We have created an empty matrices -firstClass -secondClass.
firstClass = [ ];
secondClass = [ ];

Check1=1;
%That check is only used for fill correct data for
%classificated data set
 
%If all rows in the width column are equal to the first classification data
%entered, firstClass will equal the values in all rows from 1 to width-1 in the data set.
for i=1:h_height
   if (D(i,w_width)== f_data)
        firstClass(Check1,1:(w_width-1))=D(i,1:(w_width-1));
        n1=n1+1;%Increases the number of n1 by one
	    Check1=Check1+1;
    end
end
 
%If all rows in the width column are equal to the second classification
%data entered, secondClass will equal the values in all rows from 1 to width-1 in the data set.
Check2=1
%That check is only used for fill correct data for
%classificated data set

for j=1:h_height
    if (D(j,w_width)== s_data)
            secondClass(check2,1:(w_width-1))=D(k,1:(w_width-1));
    n2=n2+1;%%Increases the number of n2 by one.
    Check2=check2+1;
    end 
end 
 
%Estimating the prior probability -pC1.
pC1=n1/num_arr
%Estimating the prior probability -pC2.
pC2=n2/num_arr
 
%We calculate the mean of the first class.
m_First =mean(firstClass(:,:))
%We calculate the mean of the second class.
m_Second =mean(secondClass(:,:))
%We calculate the standard deviation of the first class.
s_First = std(firstClass(:,:))
%We calculate the standard deviation of the second class.
s_Second = std(firstClass(:,:))
%We calculate the variance of the first class.
v_First = var(firstClass(:,:))
%We calculate the variance of the second class.
v_Second =var(secondClass(:,:))
 
%The user is prompted to enter the starting row for the classification
%data.
start_row=input('Enter Starting  Row!!!:');
%The user is prompted to enter the ending row for the classification data.
end_row=input('Enter Ending Row!!!:');
fprintf('\n');
%If the starting row is less than the ending row, it returns all rows until 1 to width-1 from starting row to ending row
if(start_row<end_row)
     x=D(start_row:end_row,1:(w_width-1));
t=1;
%All rows 1 through width-1 are calculated using the conditional probability formula1. 
for p=1:w_width-1
f_formula1 =(1/(sqrt(2*pi * (s_First(1,p)^2))))*(exp(-1*(((x(1,p)-m_First(1,p))^2)/(2*v_First(1,p)^2)))) ;
% t is multiplied with the calculated conditional probability and becomes the new t value.
t = f_formula1*t;
end
%Calculated prior probability value multiplied by calculated conditional probability value.
fFirst= pC1*t;
fFirst
 
%All rows 1 through width-1 are calculated using the conditional probability formula2.
r=1;
for s=1:w_width-1
s_formula2 =(1/(sqrt(2*pi * (s_Second(1,s)^2 ))))*(exp(-1*(((x(1,s)-m_Second(1,s))^2)/(2*v_Second(1,s)^2)))) ;% r is multiplied with the calculated conditional probability and becomes the new r value.
r = s_formula2*r;
end
%Calculated prior probability value multiplied by calculated conditional probability value.
fSecond= pC2*r;
fSecond
 
%If first is greater than fSecond, this dataset belongs to the first class.
if fFirst>fSecond
    disp('Data set belongs to First Class!!!')
%In other cases belongs to the second class.
else
    disp('Data set belongs to Second Class!!!')
end
 
%If the starting row is greater than the ending row, it prompts the user to enter a value again. It must comply with this condition.
else
    fprintf('Ending row must not be less than starting row!!!!');
end
