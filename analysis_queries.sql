
-- 1. WHAT IS THE AVERAGE LOAN AMOUNT FOR BORROWERS WHO ARE MORE THAN 5 DAYS PAST DUE

-- Displaying the Average loan amount by checking the delayed payment as yes and
-- due payment more than 5 days
Select avg(`Loan Amount`) As average_loan_amount
From borrowers
Where `Delayed Payment` = 'Yes'
	And `Due Payment` > 5;
    
    

-- 2. WHO ARE THE TOP 10 BORROWERS WITH THE HIGHEST OUTSTANDING BALANCE

-- Calculating the outstanding amount by firstly adding the principal amount and the Simple Interest
-- then Subtracting the multiplication of EMI and the number of times it has been payed 
-- and also checking if the number of payments is zero then just subtracting the EMI
Select `Name`, `Email Address`, `Geographical Location`, `Number of Payments`, `Loan Type`,
 `Loan Amount`, `EMI`, `Loan Purpose`, (`Loan Amount` + (`Loan Amount` * `Interest Rate`) - 
(Case When `Number of Payments` > 0 Then (`EMI` * `Number of Payments`) 
Else `EMI` END)) As Outstanding_Balance
From borrowers
order by Outstanding_Balance Desc
LIMIT 10;


-- 3. LIST OF ALL THE BORROWERS WITH GOOD REPAYMENT HISTORY

-- Creating a CTE to take out Average Loan Term
With Average_Loan_Term As(
	 Select avg(`Loan Term`) as AvgLoanTerm
     from borrowers
)
-- Checking if the Number of times EMI is given is more than Average Loan term
-- Checking there is no delayed payments to determine good repayment history
-- And also checking if the credit card score is more than 750 to show overall 
-- good repayment past of the borrower
Select `Name`, `Credit Score`,`Number of Payments`,`Loan Term`
from borrowers, Average_Loan_Term
Where `Number of Payments` > Average_Loan_Term.AvgLoanTerm
	And `Delayed Payment` = 'No'
    And `Credit Score` >=  750
Order By `Credit Score` DESC;
    
    

-- 4. BRIEF ANALYSIS WITH RESPECT TO LOAN TYPE

-- Creating CTE to take out Average Loan term
With Average_Loan_Term As(
	 Select avg(`Loan Term`) as AvgLoanTerm
     from borrowers
),
-- Creating 2nd CTE to Calculated distinct Loan Type Borrowers and Also Sum the Borrowers 
-- Who have given the EMI mor than the Average Loan Term to determine Good Borrower
Repayment_History As(
	Select `Loan Type`, Count(*) As Total_Borrowers,
    Sum(Case When `Number of Payments` > (Select AvgLoanTerm from Average_Loan_Term )
		Then 1 Else 0 End) As Good_Borrowers
	from borrowers
    Group by `Loan Type`
),
-- Creating 3rd CTE to take out frequency of borrowers who have Credit score more than 750
Good_Credit_Scorers As(
	Select `Loan Type`, Count(*) As Good_Credit_Score_Borrowers
    from borrowers
    Where `Credit Score` > 750
    Group By `Loan Type`
)
-- Here Showing all the loan type, its Total number of Borrowers, Number of Good Borrowers,
-- there percentage and also the total number of good credit score borrower according to the total borrowers
Select RH.`Loan Type`, RH.Total_Borrowers, RH.Good_Borrowers,
		(RH.Good_Borrowers/RH.Total_Borrowers) * 100 As Good_Borrowers_Percentage,
        GCS.Good_Credit_Score_Borrowers
From Repayment_History RH
Left Join Good_Credit_Scorers GCS On RH.`Loan Type` = GCS.`Loan Type`;
