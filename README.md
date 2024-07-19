# Loan Borrowers ETL and Analysis Project
By Aayush Mishra

## Project Proposal
Based upon the data given as "5k_borrowers.csv", the data needed to be Extracted, Transformed and Loaded into a Mysql database from a .CSV file to perform different analysis and get the answers of given questions.

## Project Description
Loaded the .CSV data using python "Pandas" library and performed Several cleaning and standardizing methods to transform the data and loaded the data using
"Sqlalchemy" into a mysql database and performed different analysis.

## Data Cleanup and Analysis
* TRANSFORMATION STEPS:
Needed to clean the data to make it readable, presentable, and easy to query in the later stages. The steps taken as follows:

  * 'pip install pandas' in cmd then imported Pandas and read the .CSV file using 'import pandas as pd'.
  *  Checked for NULL values in all the columns of the data, Duplicated the original data to perform data cleaning and Standardization on the duplicated data.
  *  Parsed the JSON column 'Repayment History' and splitted in three columns 'Number of Payments', 'First Payment Date'and 'Last Payment Date'
    to perform better analysis.
  * Converted Datatypes, Standardized texts of Columns like 'Email Address' to lowercase and provided countrycode to all the phone numbers.
  * Splitted and Deleted Columns Like 'Days Left to Pay Current EMI' into 'Due Payment' and 'Days left to pay' for better analysis.

* DATA LOADING STEPS:

  * Established a connection to a local MySql server in my desktop to store the data in Borrowersdb Database.
  * Used 'pip install sqlalchemy' to install in my pc and then used 'from sqlalchemy import create_engine, VARCHAR, Integer, Float, DateTime'
   to import create engine and diffrent datatypes for loading
  * Pushed the Pandas DataFrame to the local Mysql server so the data could easily retrieved and  would be able to query the data in Workbench Mysql

* Analysis / SQL Queries
In this part, given question to find:

  * WHAT IS THE AVERAGE LOAN AMOUNT FOR BORROWERS WHO ARE MORE THAN 5 DAYS PAST DUE
  * WHO ARE THE TOP 10 BORROWERS WITH THE HIGHEST OUTSTANDING BALANCE
  * LIST OF ALL THE BORROWERS WITH GOOD REPAYMENT HISTORY
  * BRIEF ANALYSIS WITH RESPECT TO LOAN TYPE
