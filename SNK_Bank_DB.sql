IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'SNK_Bank_DB')
CREATE DATABASE SNK_Bank_DB;
GO

USE SNK_Bank_DB;
GO

-- Create Locations table
CREATE TABLE Locations (  
  location_id INT IDENTITY(1,1) PRIMARY KEY,
  location_name VARCHAR(255) NOT NULL,  
  location_city VARCHAR(255) NOT NULL, 
  location_type VARCHAR(20) NOT NULL 
);
GO

-- Create Branches table
CREATE TABLE Branches (
  branch_id INT IDENTITY(1,1) PRIMARY KEY,
  branch_name VARCHAR(255) NOT NULL, 
  location_id INT NOT NULL,
  total_deposits DECIMAL(10, 2),
  total_loans DECIMAL(10, 2),
  FOREIGN KEY (location_id) REFERENCES Locations (location_id)
);
GO

-- Create Employees table
CREATE TABLE Employees (
  employee_id INT IDENTITY(1,1) PRIMARY KEY,
  employee_name VARCHAR(255) NOT NULL, 
  employee_address VARCHAR(255) NOT NULL,  
  start_date DATE,
  manager_id INT,  -- Assuming that the manager_id can be NULL due not every employee has a manager or the employee is the actual manager
  location_id INT NOT NULL, 
  FOREIGN KEY (location_id) REFERENCES Locations (location_id),
  FOREIGN KEY (manager_id) REFERENCES Employees (employee_id) 
);
GO

-- Create Customers table
CREATE TABLE Customers (
  customer_id INT IDENTITY(1,1) PRIMARY KEY,
  customer_name VARCHAR(255) NOT NULL,  
  customer_address VARCHAR(255) NOT NULL, 
  branch_id INT NOT NULL, 
  employee_id INT NOT NULL, 
  FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
  FOREIGN KEY (employee_id) REFERENCES Employees (employee_id) 
);
GO

-- Create Accounts table
CREATE TABLE Accounts (
  account_id INT IDENTITY(1,1) PRIMARY KEY,
  account_type VARCHAR(20) NOT NULL, 
  account_balance DECIMAL(10, 2) NOT NULL,  
  last_access_date DATE,
  interest_rate DECIMAL(5, 2),  -- Assuming that interest_rate can be NULL because not all accounts accrue interest
  customer_id INT NOT NULL, 
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) 
);
GO

-- Create Loans table
CREATE TABLE Loans (
  loan_id INT IDENTITY(1,1) PRIMARY KEY,
  loan_amount DECIMAL(10, 2) NOT NULL,
  branch_id INT NOT NULL, 
  customer_id INT NOT NULL, 
  FOREIGN KEY (branch_id) REFERENCES Branches (branch_id), 
  FOREIGN KEY (customer_id) REFERENCES Customers (customer_id)
);
GO

-- Create Payments table
CREATE TABLE Payments (
  payment_id INT IDENTITY(1,1) PRIMARY KEY,
  loan_id INT NOT NULL, 
  payment_date DATE NOT NULL,
  payment_amount DECIMAL(10, 2) NOT NULL,  
  FOREIGN KEY (loan_id) REFERENCES Loans (loan_id)
);
GO

-- Insert data into Locations
INSERT INTO Locations (location_name, location_city, location_type) VALUES 
('Main Street Branch', 'Toronto', 'branch'),
('Elm Street Branch', 'Vancouver', 'branch'),
('Pine Street Branch', 'Montreal', 'branch'),
('Oak Street Branch', 'Calgary', 'branch'),
('Maple Street Office', 'Ottawa', 'office'),
('Birch Street Branch', 'Edmonton', 'branch'),
('Cedar Street Branch', 'Mississauga', 'branch'),
('Walnut Street Branch', 'Winnipeg', 'branch'),
('Spruce Street Branch', 'Saskatoon', 'branch'),
('Ash Street Office', 'Quebec City', 'office');
GO

-- Insert data into Branches
INSERT INTO Branches (branch_name, location_id, total_deposits, total_loans) VALUES 
('Toronto B1', 1, 1000000.00, 400000.00),
('Vancouver B2', 2, 1500000.00, 450000.00),
('Montreal B3', 3, 1250000.00, 500000.00),
('Calbary B4', 4, 1400000.00, 480000.00),
('Ottawa O5', 5, 1300000.00, 470000.00),
('Edmonton B6', 6, 1200000.00, 460000.00),
('Mississauga B7', 7, 1100000.00, 450000.00),
('Winnipeg B8', 8, 1600000.00, 440000.00),
('Saskatoon B9', 9, 1700000.00, 430000.00),
('Quebec O10', 10, 1800000.00, 420000.00);
GO

-- Insert data into Employees
INSERT INTO Employees (employee_name, employee_address, start_date, manager_id, location_id) VALUES 
('John Lock', '123 Royal Ave, Toronto', '20220101', NULL, 1),
('Jane Martin', '456 Queen St, Vancouver', '20220201', 1, 2),
('Emily Johnson', '789 King St, Montreal', '20220301', 1, 3),
('Michael Brown', '1011 Central Blvd, Calgary', '20220401', 2, 4),
('Jessica Jones', '1213 Market St, Ottawa', '20220501', 2, 5),
('Chris Davis', '1415 Broadview Ave, Edmonton', '20220601', 3, 6),
('Ashley Wilson', '1617 Westview Blvd, Mississauga', '20220701', 3, 7),
('Brandon Miller', '1819 Eastview Blvd, Winnipeg', '20220801', 4, 8),
('Megan Taylor', '2021 Northview Blvd, Saskatoon', '20220901', 4, 9),
('Tyler Anderson', '2223 Southview Blvd, Quebec City', '20221001', 5, 10);
GO

-- Insert data into Customers
INSERT INTO Customers (customer_name, customer_address, branch_id, employee_id) VALUES 
('Alice Martin', '123 Water St, Toronto', 1, 1),
('George Thompson', '456 Mountain St, Vancouver', 2, 2),
('Sarah White', '789 Pacific Ave, Montreal', 3, 3),
('Frank Harris', '1011 Forest St, Calgary', 4, 4),
('Betty Clark', '1213 River St, Ottawa', 5, 5),
('Ray Wilson', '1415 Green Ave, Edmonton', 6, 6),
('Cheryl Robinson', '1617 Park Ave, Mississauga', 7, 7),
('Samuel Walker', '1819 Hill St, Winnipeg', 8, 8),
('Denise Allen', '2021 Lake Blvd, Saskatoon', 9, 9),
('Jerry Scott', '2223 Valley Blvd, Quebec City', 10, 10);
GO

-- Insert data into Accounts
INSERT INTO Accounts (account_type, account_balance, last_access_date, interest_rate, customer_id) VALUES 
('savings', 5000.00, '20230101', 1.5, 1),
('checking', 1500.00, '20230201', 0, 2),
('savings', 10000.00, '20230301', 2.0, 3),
('savings', 7500.00, '20230401', 1.8, 4),
('checking', 2000.00, '20230501', 0, 5),
('checking', 3000.00, '20230601', 0, 6),
('savings', 5500.00, '20230701', 1.6, 7),
('savings', 12000.00, '20230801', 2.2, 8),
('checking', 2500.00, '20230901', 0, 9),
('savings', 6000.00, '20231001', 1.7, 10);
GO

-- Insert data into Loans
INSERT INTO Loans (loan_amount, branch_id, customer_id) VALUES 
(15000.00, 1, 1),
(24000.00, 2, 2),
(10000.00, 3, 3),
(18000.00, 4, 4),
(5000.00, 5, 5),
(30000.00, 6, 6),
(20000.00, 7, 7),
(28000.00, 8, 8),
(25000.00, 9, 9),
(12000.00, 10, 10);
GO

-- Insert data into Payments
INSERT INTO Payments (loan_id, payment_date, payment_amount) VALUES 
(1, '20230115', 500.00),
(2, '20230215', 800.00),
(3, '20230315', 250.00),
(4, '20230415', 700.00),
(5, '20230515', 150.00),
(6, '20230615', 1000.00),
(7, '20230715', 600.00),
(8, '20230815', 900.00),
(9, '20230915', 750.00),
(10, '20231015', 400.00);
GO