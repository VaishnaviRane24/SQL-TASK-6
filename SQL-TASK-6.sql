CREATE DATABASE Employees_Details_DB;
USE Employees_Details_DB;

CREATE TABLE Departments (
		dept_id INT AUTO_INCREMENT PRIMARY KEY,
        dept_name VARCHAR(50) NOT NULL
);

INSERT INTO Departments (dept_name) VALUES
('HR'), ('Finance'), ('IT'), ('Marketing');

CREATE TABLE Employees (
		emp_id INT AUTO_INCREMENT PRIMARY KEY,
        emp_name VARCHAR(50) NOT NULL,
        dept_id INT,
        salary DECIMAL(10,2),
        FOREIGN KEY(dept_id) REFERENCES Departments(dept_id)
);

INSERT INTO Employees (emp_name, dept_id, salary) VALUES
('Manish', 1, 50000.99),
('Priya', 4, 45000.99),
('Kabir', 2, 66000.99),
('Sanya', 1, 75000.99),
('Rohit', 3, 88000.99);

CREATE TABLE Projects (
		project_id INT AUTO_INCREMENT PRIMARY KEY,
        emp_id INT,
        project_name VARCHAR(50) NOT NULL,
        FOREIGN KEY(emp_id) REFERENCES Employees(emp_id)
);

INSERT INTO Projects (emp_id, project_name) VALUES
(1, 'Email Signature Setup'),
(4, 'Employee Feedback Form'),
(2, 'website Redesign'),
(1, 'Database Migration'),
(3, 'Financial Audit');

-- Subquery in SELECT (Scalar Subquery)
SELECT emp_name, 
			(SELECT dept_name FROM Departments d WHERE d.dept_id = e.dept_id) 
AS dept_name 
FROM Employees e;

-- Subquery in WHERE (Simple Filtering)
SELECT emp_name, salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- Subquery in FROM (Derived Table)
SELECT dept_id, avg_salary
FROM (
		SELECT dept_id, AVG(salary) AS avg_salary
        FROM Employees
        GROUP BY dept_id
) AS dept_avg
WHERE avg_salary > 50000;

-- Correlated Subquery
SELECT emp_name, salary
FROM Employees e
WHERE salary > (SELECT AVG(salary) FROM Employees WHERE dept_id = e.dept_id);

-- Using EXISTS 
SELECT emp_name
FROM Employees e
WHERE EXISTS (
	SELECT 1
    FROM Projects p
    WHERE p.emp_id = e.emp_id
);
