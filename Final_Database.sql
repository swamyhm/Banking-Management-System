Create database banking_system_FINAL;
Use banking_system_FINAL


-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Test_PhoneNumer';



-- Create certificate to protect symmetric key
CREATE CERTIFICATE BankingCertificate
WITH SUBJECT = 'AdventureWorks Test Certificate',
EXPIRY_DATE = '2026-10-31';



-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY BankSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE BankingCertificate;


-- Open symmetric key
OPEN SYMMETRIC KEY BankSymmetricKey
DECRYPTION BY CERTIFICATE BankingCertificate;


--encrypted phone number
create table dbo.Employee
(
emp_id int identity(101,1) primary key,
emp_firstname varchar(45),
emp_lastname varchar(45),
emp_address_street varchar(45),
emp_address_street2 varchar(45),
emp_address_city varchar(20),
emp_address_state varchar(45),
emp_address_country varchar(45),
emp_address_postal_code int,
emp_email varchar(255),
emp_mobile int,
emp_designation varchar(45)
);

ALTER TABLE dbo.Employee ALTER COLUMN emp_mobile bigint;


select * from dbo.Employee;

--drop table dbo.Employee;

--The Email Column is encrypted using the symmetric key "BankSymmetricKey"
insert into dbo.Employee (emp_firstname,emp_lastname,emp_address_street,emp_address_street2,emp_address_city,emp_address_state,emp_address_country,emp_address_postal_code,emp_email,emp_mobile,emp_designation)
values 
('John','Walker','123 St','apt1','Boston','MA','USA',12214,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'walker_j@gmail.com'),4532656843,'Branch Manager'),
('Lisa','Ray','Tremont St','apt 2','Cambridge','MA','USA',33210,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'ray.l@yahoo.com'),8768905643,'ATM Specialist'),
('Judie','Roy','25 Smith St','apt 3','Cambridge','MA','USA',42219,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'roy.j@yahoo.com'),5608905643,'Branch Coordinater'),
('Harvey','Spectre','20 Boylston St','apt 30','New England','MA','USA',12226,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'spectre.h@gmail.com'),5608901234,'Loan Executive'),
('Rana','Reddy','78 Peterborough','apt 4C','Boston','MA','USA',32227,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'reddy.k@gmail.com'),9246778055,'Taxation Executive'),
('Rahul','Rathore','23 Mission Main','apt 74','Brookline','MA','USA',22230,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'rathore.ra@gmail.com'),9246789055,'Card Operations Specialist'),
('Soumya','Gumalla','23 Main St','apt 90','Boston','MA','USA',42222,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'gumalla.s@gmail.com'),9246661958,'Financial Planning Manager'),
('Aravind','Anthony','1525 Street','apt 5G','Cambridge','MA','USA',63315,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'ara.a@gmail.com'),9552347890,'Cheque Processing Officer'),
('Mahita','Koduru','12 Mission Hill','apt 36','Boston','MA','USA',66734,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'mahita.k@gmail.com'),8907652341,'Commercial Loan Manager'),
('Madhuri','Vemulapaty','8 Parker Hill','apt 39','Boston','MA','USA',32234,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'vemulapaty.m@gmail.com'),7651234567,'Card Operations Manager'),
('Mike','Ross','7 Mission main','apt 27','Bedford','MA','USA',99923,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'ross.m@gmail.com'),2899023456,'Compliance Officer'),
('Louis','Litt','12 Chestnut St','apt 23','Belmont','MA','USA',31123,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'louis.k@gmail.com'),9246123678,'Foreign Exchange Trader'),
('Jessica','Pearson','20 Boylston St','apt 20','Boston','MA','USA',72215,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'jessica.p@yahoo.com'),1023456789, 'Loan Executive'),
('Harold','Gunderson','78 Tremont St','apt 29','Bedford','MA','USA',21987,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'gundersonharold@gmail.com'),9246778055,'Credit Card Fraud Analyst'),
('Shivi','Nigam','12 Mission Hill','apt 7N','Boston','MA','USA',23409,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'nigam123@yahoo.com'),9246778055,'Consumer Loan Executive'),
('John','Troy','123 St','apt3','Boston','MA','USA',12214,EncryptByKey(Key_GUID(N'BankSymmetricKey'),'troy_j@gmail.com'),867453256,'Branch Manager');


-- as we see we cannot see the emp_email records since its encrypted
select * from dbo.Employee;


-- we see the values in binary format 
select emp_firstname, DecryptByKey(emp_email) as [Email Address]
from dbo.Employee;


-- Now we need to convert to Varchar format to see the correct format of the table;
select emp_firstname, convert(varchar, DecryptByKey(emp_email)) as [Email Address]
from dbo.Employee;




--drop table dbo.Employee


--Loan table
create table dbo.Loan
(
loan_type_id int primary key,
loan_type_name varchar(45),
loan_period varchar(45),
loan_rateOfInterest float(20),
loan_amount bigint,
);

select * from dbo.Loan

insert into dbo.Loan(loan_type_id,loan_type_name,loan_period,loan_rateOfInterest, loan_amount)
values
(701,'Education loan','3 years',10.0,10000),
(702,'Vehicle loan','5 years',12.3,20000),
(703,'Education loan','2years',10.0,30000),
(704,'Home loan','10 years',13.5,40000),
(705,'Personal loan','1 year',10.5,50000),
(706,'Education loan','2 years',10.0,60000),
(707,'Home loan','10 years',13.5,70000),
(708,'Personal loan','1 year',10.5,80000),
(709,'Education loan','2years',10.0,90000),
(710,'Vehicle loan','5 years',12.3,100000),
(711,'Education loan','2years',10.0,110000),
(712,'Home loan','10 years',13.5,120000),
(713,'Personal loan','1 year',10.5,130000),
(714,'Education loan','2 years',10.0,140000),
(715,'Vehicle loan','5 years',12.3,150000);

select * from dbo.Loan


--drop table dbo.Loan

--select * from dbo.Employee

--employee's Loan table
create table dbo.Employee_has_Loan
(
Loan_loan_type_id int,
Employee_emp_id int
constraint pk_Employee_has_Loan primary key (Employee_emp_id,Loan_loan_type_id),
constraint fk1_Employee_has_Loan foreign key (Employee_emp_id) references  dbo.Employee(emp_id),
constraint fk2_Employee_has_Loan foreign key (Loan_loan_type_id ) references dbo.Loan(loan_type_id),
);

--drop table dbo.Employee_has_Loan;

--inserting values to employee table;
insert into dbo.Employee_has_Loan(Loan_loan_type_id,Employee_emp_id )
values
(701,101),
(701,102),
(704,103),
(712,104),
(705,104),
(711,104),
(709,104),
(702,104),
(703,105),
(704,106),
(704,105),
(704,101),
(703,101),
(704,107),
(701,108);


--display all
select * from dbo.Employee_has_Loan

--drop table dbo.Employee_has_Loan



--Computed colunms below to see the loan count of each Employee
CREATE FUNCTION fn_CalcLoanCount_v2(@emp_id INT)
RETURNS INT
AS
   BEGIN
      DECLARE @total INT =
         (SELECT COUNT(Loan_loan_type_id)
          FROM dbo.Employee_has_Loan
          WHERE Employee_emp_id =@emp_id);
      SET @total = ISNULL(@total, 0);
      RETURN @total;
END

-- Add a computed column to the Sales.Customer

ALTER TABLE dbo.Employee
ADD Total_Loan_Count AS (dbo.fn_CalcLoanCount_v2(emp_id));

-- See what the computed column looks like
SELECT * from dbo.Employee;

-- Clean up what we just created

-- Must drop the computed column before dropping the function

ALTER TABLE dbo.Employee DROP COLUMN Total_Loan_Count;

DROP FUNCTION dbo.fn_CalcLoanCount_v2;

--After Removal of computed columns
SELECT * from dbo.Employee;




--Now encrypting the email id of email id of customer table
--Customer Table
create table dbo.Customer
(
cust_id int identity(1001,1) primary key,
cust_firstName varchar(45),
cust_lastName varchar(45),
cust_email varchar(255),
cust_mobile int,
cust_address_street varchar(45),
cust_address_street2 varchar(45),
cust_address_city varchar(45),
cust_address_state varchar(45),
cust_address_country varchar(45),
cust_address_postal_code int,
);

ALTER TABLE dbo.Customer ALTER COLUMN cust_mobile bigint

INSERT INTO dbo.Customer (cust_firstName, cust_lastName, cust_email, cust_mobile, cust_address_street, cust_address_street2, cust_address_city, cust_address_state, cust_address_country, cust_address_postal_code)

VALUES

('Simon', 'Dart', EncryptByKey(Key_GUID(N'BankSymmetricKey'),'dart.simon@gmail.com '), 7653245689, '1134 Camarosa Circle', 'Apt 45', 'San Diego','California', 'USA', 94115),
('Chaudhary', 'Parul',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'Chaudhary.parul@gmail.com '), 9804562135, '600 Garson Drive', 'apt 03', 'Atlanta','Georgia', 'USA', 34516),
('Singh', 'Jyoti',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'jyotisingh89@ymail.com '), 6548970921, 'Smith St', 'Apt 56C', 'Boston','MA', 'USA', 02120),
('Pandey', 'Gauri',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'gauripandey67@gmail.com '), 3246780954, 'Hudson St', 'Apt 43', 'Brookline','MA', 'USA', 03167),
('Lamba', 'Agam',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'lamba_a@gmail.com '), 9854320101, 'Nestle St', 'Building 2C', 'Allston','MA', 'USA', 03467),
('Raghu', 'Dixit',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'dixit.raghu6543@gmail.com '), 4578905432, 'Tremont St', 'Apt 76', 'Boston','MA', 'USA', 02168),
('Ramona', 'shey',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'romshey23@gmail.com '), 6548905421, '1267 yard st', 'Apt 1', 'Dallas','Texas', 'USA', 65321),
('Rads', 'Doxer',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'doxerrads23@gmail.com '), 7653245689, 'Gruilder Lane', 'Apt 2', 'San Diego','California', 'USA', 94115),
('Bora', 'Katy',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'katybora@gmail.com '), 7654210689, 'Camader St', 'Apt 2', 'Chelsea','MA', 'USA', 02287),
('Bakshi', 'Sam',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'bakshi.sam@gmail.com '), 3275245689, 'Gordan St', 'Apt 45', 'Miami','Florida', 'USA', 21654),
('Sanam', 'Joshi',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'joshsanam@gmail.com '), 9821247621, 'Jader St', 'Apt 1B', 'San Diego','California', 'USA', 94115),
('Kosher', 'Tart',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'tart.k@gmail.com '), 9873216666, 'Sawler Lane', 'Apt 32', 'San Francisco','California', 'USA', 85115),
('Bora', 'Hassan',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'hassan.bora@gmail.com '), 9873217777, 'Collor St', 'Apt 21', 'Atlanta','Georgia', 'USA', 324786),
('Megha', 'Sharma',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'megha.sharma@gmail.com '), 5428750009, '2134 Ganesh St', 'Apt 0965', 'San Diego','California', 'USA', 94115),
('Bunter', 'Fox',EncryptByKey(Key_GUID(N'BankSymmetricKey'), 'fox.bunter@gmail.com '), 3427860932, '54 Fax St', 'Apt 2', 'Boston','MA', 'USA', 02134);


-- we cannot see the email address since its encrypted and converted to binary form
select * from dbo.Customer


--now email in binary form
select cust_firstname, DecryptByKey(cust_email) as [Email Address]
from dbo.Customer;


-- Now we need to convert to Varchar format to see the correct format of the table;
select cust_firstname, convert(varchar, DecryptByKey(cust_email)) as [Email Address]
from dbo.Customer;



--customer has Loan table
create table dbo.Customers_has_Loan
(
Customers_cust_id int,
Loan_loan_type_id int
constraint pk_Customers_has_Loan primary key (Customers_cust_id,Loan_loan_type_id),
constraint fk1_Customers_has_Loan foreign key (Customers_cust_id) references Customer (cust_id),
constraint fk2_Customers_has_Loan foreign key (Loan_loan_type_id ) references Loan (loan_type_id)
);

INSERT INTO dbo.Customers_has_Loan (Customers_cust_id, Loan_loan_type_id)
VALUES
(1003,701),
(1004,705),
(1002,708),
(1008,709),
(1010,714),
(1014,712),
(1012,710),
(1004,714),
(1003,707),
(1011,701),
(1008,708),
(1002,702);

select * from dbo.Customers_has_Loan 


--computed Coulmns to see how many loans each customer has taken
CREATE FUNCTION fn_CalcLoanCountCust_v2(@cust_id INT)
RETURNS INT
AS
   BEGIN
      DECLARE @total INT =
         (SELECT COUNT(Loan_loan_type_id)
          FROM dbo.Customers_has_Loan
          WHERE Customers_cust_id =@cust_id);
      SET @total = ISNULL(@total, 0);
      RETURN @total;
END

-- Add a computed column to the Sales.Customer

ALTER TABLE dbo.Customer
ADD Total_Loan_Count AS (dbo.fn_CalcLoanCountCust_v2(cust_id));

-- See what the computed column looks like
SELECT * from dbo.Customer;

-- Clean up what we just created

-- Must drop the computed column before dropping the function

ALTER TABLE dbo.Customer DROP COLUMN Total_Loan_Count;

DROP FUNCTION dbo.fn_CalcLoanCountCust_v2;

--after removal of computed coulmns
SELECT * from dbo.Customer;


--insurance Table

create table dbo.Insurance
(
insurance_id int primary key,
insurance_period varchar(45),
insurance_cost bigint,
insurance_type_name varchar(45),
);


INSERT INTO dbo.Insurance (insurance_id, insurance_period, insurance_cost, insurance_type_name)
VALUES
(601,'1 year',10000, 'Health Insurance'),
(602, '10 years', 50000, 'Life Insurance'),
(603, '5 years', 100000, 'Home Insurance'),
(604, '1 year', 10000, 'Automobile Insurance'),
(605, '3 years', 5000, 'Social Security Insurance');

select * from dbo.Insurance


--bank branch info Table

create table dbo.Bank_Branch_Info
(
branch_id int primary key,
branch_name varchar(45),
branch_address varchar(45),
branch_state varchar(45),
Branch_zipcode varchar(45),
);

ALTER TABLE dbo.Bank_Branch_Info
ADD branch_country VARCHAR(45);



INSERT INTO dbo.Bank_Branch_Info (branch_id, branch_name, branch_address, branch_state, branch_zipcode)
VALUES 

(501, 'Capital City', '23 Limo St,dertuv', 'Iowa' , 02128),
(502, 'Lowell Branch', '45 Trexas St,Lowell',' Nevada', 02178),
(503, 'Supreme branch 42', '42 Supreme St,San Diego','California',92158 ),
(504, 'Mass Ave', '7 Mass Ave,Atlanta', 'Georgia', 31365),
(505, 'Noxel Branch', '62 Noxel St,Chelsea',' Texas', 89324),
(506, 'Red Branch', '44 Redton Lane,Somerville', 'Florida', 56021),
(507, 'Burrata Branch', 'Burrata St 2,Hunber','Arizona', 87456),
(508, 'Fretta Branch', '8 Fretta St,Lunfre', 'Chicago',56432),
(509, 'Tumi', '23 Tumi St,Baradot', 'Maine', 03479),
(510, 'Jumbo Branch', '52 Lexie St,Lexington', 'Washington', 54875),
(511, 'Capitalone City', '96 Capital St,Wallow', 'Utah', 87321),
(512, 'Summer Branch', '09 Summer St,Junfer', 'Oregon',98345);

UPDATE  dbo.Bank_Branch_Info  SET branch_country='USA'


 select * from dbo.Bank_Branch_Info

  
--card Service Infro Table
create table dbo.Card_Service_Info
(
card_service_id int primary key,
card_service_type varchar(45),
);

INSERT INTO dbo.Card_Service_Info (card_service_id , card_service_type)
VALUES

(801, 'Debit Card'),
(802, 'Credit Card'),
(803, 'Forex Card'),
(804, 'Charge Card'),
(805, 'Fleet Card'),
(806, 'Stored Value Card'),
(807,'ATM Card'),
(808, 'Embossing Card'),
(809, 'Shopping Card'),
(810, 'Gift Card');

select * from dbo.Card_Service_Info 


--Alert Service Table
create table dbo.Alert_services
(
service_id int primary key,
service_type varchar(45),
service_cost int,
);

INSERT INTO dbo.Alert_Services (service_id, service_type, service_cost)
VALUES
(001,'Text',0),
(002, 'Email',0),
(003,'Text and Email',0);

select * from dbo.Alert_Services


--Employees who have Alert Services
create table dbo.Alert_services_has_Employee
(
Alert_services_service_id int,
Employee_emp_id int
constraint pk_Alert_services_has_Employee primary key (Employee_emp_id,Alert_services_service_id),
constraint fk1_Alert_services_has_Employee foreign key (Employee_emp_id) references Employee(emp_id),
constraint fk2_Alert_services_has_Employee foreign key (Alert_services_service_id ) references Alert_services(service_id),
);

--drop table dbo.Alert_services_has_Employee;


insert into dbo.Alert_services_has_Employee(Alert_services_service_id,Employee_emp_id )
values
(001,101),
(001,102),
(002,115),
(001,103),
(003,104),
(003,105),
(002,106),
(001,107),
(002,108),
(001,109),
(003,110),
(003,112);

select * from dbo.Alert_services_has_Employee

--drop table dbo.Alert_services_has_Employee


create table dbo.Account_Info
(
account_number int primary key,
account_type varchar(45),
account_balance float,
Employee_emp_id int,
Customers_cust_id int,
Bank_Branch_Info_branch_id int
constraint fk1_Account_Info foreign key (Employee_emp_id) references Employee (emp_id),
constraint fk2_Account_Info foreign key (Customers_cust_id) references Customer (cust_id),
constraint fk3_Account_Info foreign key (Bank_Branch_Info_branch_id) references Bank_Branch_Info (branch_id)
);

insert into dbo.Account_Info(account_number,account_type,account_balance,Employee_emp_id,Customers_cust_id ,Bank_Branch_Info_branch_id)
values 
(2300,'Checking Account',45000,101,1001,501),
(2301,'Checking Account',15000,109,1005,512),
(2302,'Savings Account',5000,102,1002,501),
(2303,'Checking Account',445000,108,1015,509),
(2304,'Checking Account',53837,109,1011,506),
(2305,'Savings Account',20789,106,1010,510),
(2306,'Checking Account',1735,115,1009,505),
(2307,'savings Account',90432,104,1003,508),
(2308,'Checking Account',45123,111,1008,501),
(2309,'Checking Account',35000,111,1006,502),
(2310,'Savings Account',4950,107,1004,511),
(2311,'Savings Account',98642,107,1007,501),
(2312,'Checking Account',23445,108,1012,509),
(2313,'Checking Account',35000,104,1013,503),
(2314,'Checking Account',500,113,1014,510);

select * from dbo.Account_Info
order by Employee_emp_id;

--Creating View to see savings accounts with balance less than 50000.
DROP view V_Account_Info
GO
CREATE
VIEW V_Account_Info AS
select * from dbo.Account_Info
WHERE account_type <> 'Checking Account' and account_balance < 50000;
GO

select * from V_Account_Info 

--reporting Services
create table dbo.Reporting_Services
(
report_id int primary key,
report_type varchar(45),
report_cost int,
);

insert into dbo.Reporting_Services(report_id,report_type,report_cost)
values 
(400,'Monthly Account Reporting',100),
(401,'Weekly Account Reporting',200),
(403,'Insurance Reporting',124),
(404,'Deposit Reporting',130),
(406,'Card Type Reporting',125);

select * from dbo.Reporting_Services


--employee has reporting serives
create table dbo.Reporting_Services_has_Employee
(
Reporting_Services_report_id int,
Employee_emp_id int
constraint pk_Reporting_Services_has_Employee primary key (Employee_emp_id,Reporting_Services_report_id)
constraint fk1_Reporting_Services_has_Employee foreign key (Employee_emp_id) references Employee (emp_id),
constraint fk2_Reporting_Services_has_Employee foreign key (Reporting_Services_report_id) references Reporting_Services (report_id), 
);

INSERT INTO dbo.Reporting_Services_has_Employee (Reporting_Services_report_id , Employee_emp_id)
VALUES

(400,101),
(401,102),
(400,103),
(406,104),
(403,105),
(403,106),
(404,107),
(400,108),
(400,109),
(401,110),
(406,111),
(404,113),
(403,115);

select * from dbo.Reporting_Services_has_Employee

--customers Reporting Services
create table dbo.Reporting_Services_has_Customers
(
Reporting_Services_report_id int,
Customers_cust_id int
constraint pk_Reporting_Services_has_Customers primary key (Customers_cust_id,Reporting_Services_report_id),
constraint fk1_Reporting_Services_has_Customers foreign key (Customers_cust_id) references Customer (cust_id),
constraint fk2_Reporting_Services_has_Customers foreign key (Reporting_Services_report_id ) references Reporting_Services (report_id),
);

INSERT INTO dbo.Reporting_Services_has_Customers (Reporting_Services_report_id , Customers_cust_id)
VALUES
(400,1001),
(403,1015),
(401,1011),
(403,1012),
(406,1013),
(404,1014),
(401,1015),
(400,1005),
(403,1013),
(406,1009),
(400,1008),
(401,1007),
(404,1009),
(403,1010);

select * from dbo.Reporting_Services_has_Customers 


--custerm's Alert Services
create table dbo.Alert_services_has_Customers
(
Customers_cust_id int,
Alert_services_service_id int
constraint pk_Alert_services_has_Customers primary key (Customers_cust_id,Alert_services_service_id),
constraint fk1_Alert_services_has_Customers foreign key (Customers_cust_id) references Customer (cust_id),
constraint fk2_Alert_services_has_Customers foreign key (Alert_services_service_id) references Alert_services (service_id)
);


INSERT INTO dbo.Alert_services_has_Customers (Alert_services_service_id, Customers_cust_id)
VALUES

(001,1001),
(002,1002),
(001,1003),
(002,1004),
(002,1005),
(003,1006),
(001,1007),
(003,1008),
(001,1009),
(001,1010),
(002,1011),
(001,1012),
(003,1013),
(001,1014),
(002,1015)
;

select * from dbo.Alert_services_has_Customers 


--Transaction Details
create table dbo.Transactions
(
transaction_type int,
Account_info_account_number int,
transaction_amount int,
transaction_timestamp varchar(45)
constraint fk1_Transactions foreign key (Account_info_account_number) references Account_Info(account_number),
);

insert into dbo.Transactions(transaction_type,Account_info_account_number,transaction_amount,transaction_timestamp )
values 
(550,2300,1200,'2:45pm'),
(551,2302,9200,'1:45pm'),
(552,2301,2200,'10:45am'),
(553,2303,2345,'9:45am'),
(554,2306,2340,'2:12pm'),
(555,2304,1906,'1:05pm'),
(556,2301,3240,'3:45pm'),
(557,2314,46467,'11:00am'),
(558,2309,2837,'12:20pm'),
(559,2308,36372,'11:23am'),
(560,2310,92635,'10:45am');

select * from dbo.Transactions

--Creating View to see savings accounts with balance less than 50000.
DROP view V_Transactions
GO
CREATE
VIEW V_Transactions AS
select transaction_type,Account_info_account_number,transaction_amount from dbo.Transactions
WHERE transaction_amount > 50000;
GO

select * from V_Transactions 

--Customers has insurance

create table dbo.Customers_has_Insurance
(
Insurance_insurance_id int,
Customers_cust_id int
constraint pk_Customers_has_Insurance primary key (Customers_cust_id,Insurance_insurance_id),
constraint fk1_Customers_has_Insurance foreign key (Customers_cust_id) references Customer (cust_id),
constraint fk2_Customers_has_Insurance foreign key (Insurance_insurance_id ) references Insurance (insurance_id),
);

INSERT INTO dbo.Customers_has_Insurance (Customers_cust_id, Insurance_insurance_id)
VALUES
(1006,601),
(1004,604),
(1010,605),
(1012,604),
(1011,603),
(1015,602),
(1014,604),
(1008,602),
(1003,601),
(1009,602),
(1014,602),
(1003,605),
(1007,601);

select * from dbo.Customers_has_Insurance 


--card service Info Employees

create table dbo.Employee_has_Card_Service_info
(
Card_Service_info_card_service_id int,
Employee_emp_id int
constraint pk_Employee_has_Card_Service_info primary key (Employee_emp_id,Card_Service_info_card_service_id),
constraint fk1_Employee_has_Card_Service_info foreign key (Employee_emp_id) references Employee (emp_id),
constraint fk2_Employee_has_Card_Service_info foreign key (Card_Service_info_card_service_id ) references Card_Service_Info (card_service_id),
);

INSERT INTO dbo.Employee_has_Card_Service_Info (Employee_emp_id, Card_Service_info_card_service_id)
VALUES

(101,801),
(102,805),
(103,806),
(104,810),
(105,804),
(106,805),
(107,802),
(108,801),
(109,802),
(110,803),
(111,801),
(112,806),
(113,803);

select * from dbo.Employee_has_Card_Service_Info 


--customers have card service Infromation

create table dbo.Card_Service_info_has_Customers
(
Card_Service_info_card_service_id int,
Customers_cust_id int
constraint pk_Card_Service_info_has_Customers primary key (Customers_cust_id,Card_Service_info_card_service_id),
constraint fk1_Card_Service_info_has_Customers foreign key (Customers_cust_id) references Customer (cust_id),
constraint fk2_Card_Service_info_has_Customers foreign key (Card_Service_info_card_service_id ) references Card_Service_Info (card_service_id),
);

insert into dbo.Card_Service_info_has_Customers(Card_Service_info_card_service_id,Customers_cust_id)
values 
(801,1001),
(802,1006),
(804,1002),
(803,1009),
(809,1015),
(808,1012),
(810,1006),
(805,1010),
(806,1013),
(807,1015);

select * from dbo.Card_Service_info_has_Customers

--Stored Procedure for deposit amount
CREATE PROCEDURE dbo.DepositAmount (@type_name INT,@accno INT,@amount FLOAT)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO dbo.Transactions (transaction_type, Account_info_account_number,transaction_amount, transaction_timestamp)
VALUES
(@type_name,@accno,@amount,GETDATE());
UPDATE dbo.Account_Info
SET account_balance = (@amount+account_balance)
WHERE account_number=@accno;
END;
GO

select * from dbo.Account_Info;

EXEC dbo.DepositAmount 550, 2300, 12000;
EXEC dbo.DepositAmount 551,2302,6200;
EXEC dbo.DepositAmount 552,2301,13400;
EXEC dbo.DepositAmount 553,2303,23545;
EXEC dbo.DepositAmount 554,2306,12340;
EXEC dbo.DepositAmount 555,2304,11906;
EXEC dbo.DepositAmount 556,2301,32040;
EXEC dbo.DepositAmount 557,2314,6467;
EXEC dbo.DepositAmount 558,2309,2837;
EXEC dbo.DepositAmount 559,2308,16372;
EXEC dbo.DepositAmount 560,2310,2635;

select * from dbo.Transactions;

select * from dbo.Account_Info;

--stored procedure for Withdraw amount
CREATE   PROCEDURE dbo.WithdrawAmount (@type_name INT, @accno INT, @amount FLOAT)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO dbo.Transactions (transaction_type, Account_info_account_number,transaction_amount, transaction_timestamp)
VALUES
(@type_name,@accno,@amount,GETDATE());
UPDATE dbo.Account_Info
SET account_balance = (account_balance - @amount)
WHERE account_number=@accno;
END;
GO

select * from dbo.Account_Info;

EXEC dbo.WithdrawAmount 550,2300,1900;
EXEC dbo.WithdrawAmount 551,2302,200;
EXEC dbo.WithdrawAmount 552,2301,13465;
EXEC dbo.WithdrawAmount 553,2303,2354;
EXEC dbo.WithdrawAmount 554,2306,1230;
EXEC dbo.WithdrawAmount 555,2304,1906;
EXEC dbo.WithdrawAmount 556,2301,40;
EXEC dbo.WithdrawAmount 557,2314,646;
EXEC dbo.WithdrawAmount 558,2309,287;
EXEC dbo.WithdrawAmount 559,2308,172;
EXEC dbo.WithdrawAmount 560,2310,265;


select * from dbo.Transactions;

select * from dbo.Account_Info;


