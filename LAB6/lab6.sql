--PART 1: Database Setup
--Step 1.1
-- Create table: employees
CREATE TABLE employees (
 emp_id INT PRIMARY KEY,
 emp_name VARCHAR(50),
 dept_id INT,
 salary DECIMAL(10, 2)
);
-- Create table: departments
CREATE TABLE departments (
 dept_id INT PRIMARY KEY,
 dept_name VARCHAR(50),
 location VARCHAR(50)
);
-- Create table: projects
CREATE TABLE projects (
 project_id INT PRIMARY KEY,
 project_name VARCHAR(50),
 dept_id INT,
 budget DECIMAL(10, 2)
);

--Step 1.2
-- Insert data into employees
INSERT INTO employees (emp_id, emp_name, dept_id, salary) VALUES
(1, 'John Smith', 101, 50000),
(2, 'Jane Doe', 102, 60000),
(3, 'Mike Johnson', 101, 55000),
(4, 'Sarah Williams', 103, 65000),
(5, 'Tom Brown', NULL, 45000);
-- Insert data into departments
INSERT INTO departments (dept_id, dept_name, location) VALUES
(101, 'IT', 'Building A'),
(102, 'HR', 'Building B'),
(103, 'Finance', 'Building C'),
(104, 'Marketing', 'Building D');
-- Insert data into projects
INSERT INTO projects (project_id, project_name, dept_id, budget) VALUES
(1, 'Website Redesign', 101, 100000),
(2, 'Employee Training', 102, 50000),
(3, 'Budget Analysis', 103, 75000),
(4, 'Cloud Migration', 101, 150000),
(5, 'AI Research', NULL, 200000);


--PART 2: CROSS JOIN Exercises
-- Exercise 2.1
SELECT e.emp_name, d.dept_name
FROM employees e CROSS JOIN departments d;
-- 5 employees × 4 departments = 20 rows

-- Exercise 2.2
-- a:
SELECT e.emp_name, d.dept_name
FROM employees e, departments d;
-- b:
SELECT e.emp_name, d.dept_name
FROM employees e INNER JOIN departments d ON TRUE;

-- Exercise 2.3
SELECT e.emp_name, p.project_name
FROM employees e CROSS JOIN projects p;


--PART 3: INNER JOIN Exercises
--Exercise 3.1
SELECT e.emp_name, d.dept_name, d.location
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;
-- 4 rows are returned. Tom Brown missing because dept_id is NULL

--Exercise 3.2
SELECT emp_name, dept_name, location
FROM employees
INNER JOIN departments USING (dept_id);
-- Difference: dept_id is shown only once

--Exercise 3.3
SELECT emp_name, dept_name, location
FROM employees
NATURAL INNER JOIN departments;

--Exercise 3.4
SELECT e.emp_name, d.dept_name, p.project_name
FROM employees e
INNER JOIN departments d ON d.dept_id = e.dept_id
INNER JOIN projects p ON d.dept_id = p.dept_id;


--PART 4: LEFT JOIN exercises
--Exercise 4.1
SELECT e.emp_name, e.dept_id AS emp_dept, d.dept_id AS dept_dept, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;
--Tom Brown is included, but with NULL values for dept_dept and dept_name

--Exercise 4.2
SELECT emp_name, dept_id, dept_name
FROM employees
LEFT JOIN departments USING (dept_id);

--Exercise 4.3
SELECT e.emp_name, d.dept_id
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

--Exercise 4.4
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY employee_count DESC;


--PART 5: RIGHT JOIN exercises
--Exercise 5.1
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

--Exercise 5.2
SELECT e.emp_name, d.dept_name
FROM departments d
LEFT JOIN employees e ON e.dept_id = d.dept_id;

--Exercise 5.3
SELECT d.dept_name, d.location
FROM employees e
RIGHT JOIN departments d ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;


--PART 6: FULL JOIN exercises
--Exercise 6.1
SELECT e.emp_name, e.dept_id AS emp_dept, d.dept_id AS dept_dept, d.dept_name
FROM employees e
FULL JOIN departments d ON e.dept_id = d.dept_id;

--Exercise 6.2
SELECT d.dept_name, p.project_name, p.budget
FROM departments d
FULL JOIN projects p ON p.dept_id = d.dept_id;

--Exercise 6.3
SELECT CASE
    WHEN e.emp_id IS NULL THEN 'Department without employees'
    WHEN d.dept_id IS NULL THEN 'Employee without department'
    ELSE 'Matched'
END AS record_status,
    e.emp_name,
    d.dept_name
FROM employees e
FULL JOIN departments d ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL OR d.dept_id IS NULL;


--PART 7: ON vs WHERE clause
--Exercise 7.1
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id AND d.location = 'Building A';

--Exercise 7.2
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
LEFT JOIN departments d ON d.dept_id = e.dept_id
WHERE d.location = 'Building A';
-- ON clause: Applies the filter BEFORE the join, so all employees are included, but
-- only departments in Building A are matched.
-- WHERE clause: Applies the filter AFTER the join, so employees are excluded if
-- their department is not in Building A.

--Exercise 7.3
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id AND d.location = 'Building A';

SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE d.location = 'Building A';
--No difference in results. INNER JOIN discards non-matches before the WHERE filter,
--so ON and WHERE behave similarly for filtering.


--PART 8: Complex JOIN scenarios
--Exercise 8.1
SELECT d.dept_name, e.emp_name, e.salary, p.project_name, p.budget
FROM departments d
LEFT JOIN employees e ON e.dept_id = d.dept_id
LEFT JOIN projects p ON p.dept_id = d.dept_id
ORDER BY d.dept_name, e.emp_name;

--Exercise 8.2
-- Add manager_id column
ALTER TABLE employees ADD COLUMN manager_id INT;

-- Update with sample data
UPDATE employees SET manager_id = 3 WHERE emp_id = 1;
UPDATE employees SET manager_id = 3 WHERE emp_id = 2;
UPDATE employees SET manager_id = NULL WHERE emp_id = 3;
UPDATE employees SET manager_id = 3 WHERE emp_id = 4;
UPDATE employees SET manager_id = 3 WHERE emp_id = 5;

-- Self join query
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

--Exercise 8.3
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM departments d
INNER JOIN employees e ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING AVG(e.salary) > 50000;


--LAB Questions

-- 1) INNER JOIN returns only matching rows from both tables.
-- LEFT JOIN returns all rows from the left table and matching rows from the right (with NULLs for non-matches)
--
-- 2) We use CROSS JOIN in practical scenarios like generating all possible combinations
--
-- 3) For outer joins, ON filters before the join (preserving non-matches with NULLs), while WHERE filters after
--
-- 4) 5 × 10 = 50
--
-- 5) It automatically joins on all columns with the same names in both tables
--
-- 6) It can join on unintended columns if names match accidentally,
-- leading to incorrect results or errors if column types differ.
--
-- 7) RIGHT JOIN: SELECT * FROM B RIGHT JOIN A ON A.id = B.id;
--
-- 8) When we need all records from both tables, including non-matches

