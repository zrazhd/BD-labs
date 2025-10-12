--Student Name: Denis Zrazhevskiy
--Student ID: 24B031042

--PART 1: CHECK Constrains
--TASK 1.1
CREATE TABLE employees(
    employee_id INTEGER,
    first_name TEXT,
    last_name TEXT,
    age INTEGER CHECK(age BETWEEN 18 AND 65),
    salary NUMERIC CHECK(salary > 0)
);

--TASK 1.2
CREATE TABLE products_catalog(
    product_id INTEGER,
    product_name TEXT,
    regular_price NUMERIC,
    discount_price NUMERIC,
    CONSTRAINT valid_discount CHECK(regular_price > 0 AND discount_price > 0 AND discount_price < regular_price)
);

--TASK 1.3
CREATE TABLE bookings(
    booking_id INTEGER,
    check_in_date DATE,
    check_out_date DATE,
    num_guests INTEGER,
    CHECK(num_guests BETWEEN 1 AND 10),
    CHECK(check_out_date > check_in_date)
);

--TASK 1.4
--Correct data for TABLE employees
INSERT INTO employees(employee_id, first_name, last_name, age, salary)
VALUES(1,'Johnny','Depp',25,100000);
INSERT INTO employees(employee_id, first_name, last_name, age, salary)
VALUES(2,'Jim','Carrey',30,140000);

--Incorrect data because: age is not BETWEEN 18 AND 65
-- INSERT INTO employees(employee_id, first_name, last_name, age, salary)
-- VALUES(3, 'Tom', 'Cruise', 80, 130000);

--Incorrect data because: salary <= 0
-- INSERT INTO employees(employee_id, first_name, last_name, age, salary)
-- VALUES(4, 'Brad', 'Pitt', 80, 0);

--Correct data for TABLE products_catalog
INSERT INTO products_catalog(product_id, product_name, regular_price, discount_price)
VALUES(1,'Iphone',1000,900);
INSERT INTO products_catalog(product_id, product_name, regular_price, discount_price)
VALUES(2,'Samsung',800,700);

--Incorrect data: because regular_price < discount_price
-- INSERT INTO products_catalog(product_id, product_name, regular_price, discount_price)
-- VALUES(3, 'Xiaomi', 500, 600);

--Incorrect data: because regular_price <= 0
-- INSERT INTO products_catalog(product_id, product_name, regular_price, discount_price)
-- VALUES(4, 'Vivo', 0, 600);

--Incorrect data: because discount_price <= 0
-- INSERT INTO products_catalog(product_id, product_name, regular_price, discount_price)
-- VALUES(5, 'Poco', 500, 0);

--Correct data
INSERT INTO bookings(booking_id, check_in_date, check_out_date, num_guests)
VALUES(1,'2025-01-01','2025-01-02', 3);
INSERT INTO bookings(booking_id, check_in_date, check_out_date, num_guests)
VALUES(2,'2025-01-03','2025-01-04', 7);

--Incorrect data because num_guests NOT BETWEEN 1 ADN 10
-- INSERT INTO bookings(booking_id, check_in_date, check_out_date, num_guests)
-- VALUES(2, '2025-02-01', '2025-02-04', 15);

--Incorrect data because check_out_date <= check_in_date
-- INSERT INTO bookings(booking_id, check_in_date, check_out_date, num_guests)
-- VALUES(2, '2025-04-05', '2025-04-01', 5);





--PART 2: NOT NULL Constraints
--TASK 2.1
CREATE TABLE customers_task2_1(
    customer_id INTEGER NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    registration_date DATE NOT NULL
);

--TASK 2.2
CREATE TABLE inventory(
    item_id INTEGER NOT NULL,
    item_name TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK(quantity >= 0),
    unit_price NUMERIC NOT NULL CHECK (unit_price > 0),
    last_updated TIMESTAMP NOT NULL
);

--TASK 2.3
--Correct data for TABLE customers
INSERT INTO customers_task2_1(customer_id, email, phone, registration_date)
VALUES(1, 'some@gmail.com', 774956323, '2025-01-01');
INSERT INTO customers_task2_1(customer_id, email, phone, registration_date)
VALUES(2, 'thing@gmail.com', NULL, '2025-01-01');

--Incorrect data: customer_id IS NULL
-- INSERT INTO customers_task2_1(customer_id, email, phone, registration_date)
-- VALUES(NULL, 'deadsaD@gmail.com', 771523531, '2023-01-01');

--Incorrect data: because email IS NULL
-- INSERT INTO customers_task2_1(customer_id, email, phone, registration_date)
-- VALUES(4, NULL, 775853741, '2007-01-08');

--Incorrect data: because registration_date IS NULL
-- INSERT INTO customers_task2_1(customer_id, email, phone, registration_date)
-- VALUES(5, 'sdfsdgs@gmail.com', 777456321, NULL);


--Correct data for TABLE inventory
INSERT INTO inventory(item_id, item_name, quantity, unit_price, last_updated)
VALUES(1, 'mouse', 5, 100, '2025-10-12 10:00:00');
INSERT INTO inventory(item_id, item_name, quantity, unit_price, last_updated)
VALUES(2, 'keyboard', 5, 150, '2025-10-15 09:10:00');

--Incorrect data: item_id IS NULL
-- INSERT INTO inventory(item_id, item_name, quantity, unit_price, last_updated)
-- VALUES(NULL, 'cable', 9, 10, '2025-09-09 11:55:00');

--Incorrect data: unit_price <= 0
-- INSERT INTO inventory(item_id, item_name, quantity, unit_price, last_updated)
-- VALUES(4, 'table', 10, -100, '2025-03-07 05:05:00');

--Incorrect data: last_updated IS NULL
-- INSERT INTO inventory(item_id, item_name, quantity, unit_price, last_updated)
-- VALUES(5, 'chair', 20, 150, NULL);





--PART 3: UNIQUE Constraints
--TASK 3.1
CREATE TABLE users(
    user_id INTEGER,
    username TEXT UNIQUE,
    email TEXT UNIQUE,
    created_at TIMESTAMP
);

--TASK 3.2
CREATE TABLE course_enrollments(
    enrollment_id INTEGER,
    student_id INTEGER,
    course_code TEXT,
    semester TEXT,
    UNIQUE(student_id, course_code, semester)
);

--TASK 3.3
ALTER TABLE users
    ADD CONSTRAINT unique_username UNIQUE(username),
    ADD CONSTRAINT unique_email UNIQUE(email);

--INSERTing duplicate usernames and emails:
INSERT INTO users (user_id, username, email, created_at)
VALUES (1, 'user1', 'user1@gmail.com', '2025-01-01 05:05:00');
INSERT INTO users (user_id, username, email, created_at)
VALUES (2, 'user2', 'user2@gmail.com', '2025-09-09 10:00:00');

--Incorrect data: username is not unique
-- INSERT INTO users (user_id, username, email, created_at)
-- VALUES (3, 'user2', 'user123@gmail.com', '2025-12-09 10:50:00');

--Incorrect data: email is not unique
-- INSERT INTO users (user_id, username, email, created_at)
-- VALUES (4, 'user4', 'user1@gmail.com', '2025-12-09 04:30:00');





--PART 4: PRIMARY KEY Constraints
--TASK 4.1
CREATE TABLE departments(
    dept_id INTEGER PRIMARY KEY,
    dept_name TEXT NOT NULL,
    location TEXT
);

--Correct data
INSERT INTO departments(dept_id, dept_name, location)
VALUES(1, 'IT', 'Almaty');
INSERT INTO departments(dept_id, dept_name, location)
VALUES(2, 'Sales', 'Astana');

--Incorrect data: dept_id is dublicated
-- INSERT INTO departments(dept_id, dept_name, location) VALUES(2, 'HR', 'Shymkent');

--Incorrect data: dept_id IS NULL
-- INSERT INTO departments(dept_id, dept_name, location) VALUES(NULL, 'IT', 'Astana');

--TASK 4.2
CREATE TABLE student_courses(
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date DATE,
    grade TEXT,
    PRIMARY KEY (student_id, course_id)
);

--TASK 4.3: Comparison Exercise
-- 1. The difference between UNIQUE and PRIMARY KEY
--    UNIQUE ensures no duplicates in the column, allows NULL per column
--    PRIMARY KEY is UNIQUE + NOT NULL, and there's only one per table.
-- 2. When to use a single-column vs. composite PRIMARY KEY
--    Use a single-column PRIMARY KEY when one column can uniquely identify each record.
--    Use a composite PRIMARY KEY when multiple columns are needed to guarantee uniqueness
-- 3. Why a table can have only one PRIMARY KEY but multiple UNIQUE constraints
--    PRIMARY KEY is the main identifier for the table, used for referencing.
--    Multiple UNIQUE for additional uniqueness requirements on other columns.





--PART 5: FOREIGN KEY Constraints
--TASK 5.1
CREATE TABLE employees_dept(
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT NOT NULL,
    dept_id INTEGER REFERENCES departments(dept_id),
    hire_date DATE
);
--Correct data
INSERT INTO employees_dept(emp_id, emp_name, dept_id, hire_date)
VALUES(1, 'Matt', 1, '2025-02-01');
INSERT INTO employees_dept(emp_id, emp_name, dept_id, hire_date)
VALUES(2, 'Will', 2, '2025-01-01');

--Incorrect data: non-existent dept_id
-- INSERT INTO employees_dept(emp_id, emp_name, dept_id, hire_date)
-- VALUES(3, 'George', 15, '2024-10-10');


--TASK 5.2
CREATE TABLE authors(
    author_id INTEGER PRIMARY KEY,
    author_name TEXT NOT NULL,
    country TEXT
);

CREATE TABLE publishers(
    publisher_id INTEGER PRIMARY KEY,
    publisher_name TEXT NOT NULL,
    city TEXT
);

CREATE TABLE books(
    book_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    author_id INTEGER REFERENCES authors(author_id),
    publisher_id INTEGER REFERENCES publishers(publisher_id),
    publication_year INTEGER,
    isbn TEXT UNIQUE
);

INSERT INTO authors(author_id, author_name, country) VALUES (1, 'Steven', 'Poland');
INSERT INTO authors(author_id, author_name, country) VALUES (2, 'Robert', 'USA');

INSERT INTO publishers(publisher_id, publisher_name, city) VALUES (1, 'Liam', 'Almaty');
INSERT INTO publishers(publisher_id, publisher_name, city) VALUES (2, 'Kate', 'Astana');

INSERT INTO books(book_id, title, author_id, publisher_id, publication_year, isbn)
VALUES (1, 'title1', 1, 2, 2024, 'isbn1');
INSERT INTO books(book_id, title, author_id, publisher_id, publication_year, isbn)
VALUES (2, 'title2', 2, 1, 2025, 'isbn2');

--TASK 5.3
CREATE TABLE categories(
    category_id INTEGER PRIMARY KEY,
    category_name TEXT NOT NULL
);

CREATE TABLE products_fk(
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category_id INTEGER REFERENCES categories(category_id) ON DELETE RESTRICT
);

CREATE TABLE orders_task5_3(
    order_id INTEGER PRIMARY KEY,
    order_date DATE NOT NULL
);

CREATE TABLE order_items(
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER REFERENCES orders_task5_3(order_id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products_fk(product_id),
    quantity INTEGER CHECK (quantity > 0)
);

INSERT INTO categories (category_id, category_name) VALUES (1, 'Gadgets');
INSERT INTO categories (category_id, category_name) VALUES (2, 'something');
INSERT INTO products_fk (product_id, product_name, category_id) VALUES (1, 'Laptop', 1);
INSERT INTO products_fk (product_id, product_name, category_id) VALUES (2, 'Smartphone', 2);
INSERT INTO orders_task5_3 (order_id, order_date) VALUES (1, '2025-08-15');
INSERT INTO orders_task5_3 (order_id, order_date) VALUES (2, '2025-10-02');
INSERT INTO order_items (item_id, order_id, product_id, quantity) VALUES (1, 1, 1, 5);
INSERT INTO order_items (item_id, order_id, product_id, quantity) VALUES (2, 2, 2, 10);

--Test 1: Try to delete a category that has products
--DELETE FROM categories WHERE category_id = 1;
--Result: Fail because products_fk has product referencing it.

--Test 2: Delete an order and observe that order_items are automatically deleted
DELETE FROM orders_task5_3 WHERE order_id = 1;
--Result: Order deleted, and order_items with order_id=1 are automatically deleted.

--Test 3:
-- In the 1st test Fail because products_fk has product referencing it.
-- In hte 2nd test Order deleted, and order_items with order_id=1 are automatically deleted.





--PART 6: Practical Application
--TASK 6.1
CREATE TABLE customers_task6_1 (
    customer_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT,
    registration_date DATE NOT NULL
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT,
    price NUMERIC NOT NULL CHECK(price >= 0),
    stock_quantity INTEGER NOT NULL CHECK(stock_quantity >= 0)
);

CREATE TABLE orders_task6_1 (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER REFERENCES customers_task6_1(customer_id) ON DELETE SET NULL,
    order_date DATE NOT NULL,
    total_amount INTEGER NOT NUll CHECK(total_amount >= 0),
    status TEXT NOT NULL CHECK(status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled'))
);

CREATE TABLE order_details (
    order_detail_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders_task6_1(order_id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    quantity INTEGER NOT NULL CHECK(quantity > 0),
    unit_price INTEGER NOT NULL CHECK(unit_price >= 0)
);
--INSERTing into TABLE customers
INSERT INTO customers_task6_1(customer_id, name, email, phone, registration_date) VALUES (1, 'Mark', 'cus1@gmail.com', 777111333, '2025-01-01');
INSERT INTO customers_task6_1(customer_id, name, email, phone, registration_date) VALUES (2, 'Keanu', 'cus2@gmail.com', 777888999, '2025-01-02');
INSERT INTO customers_task6_1(customer_id, name, email, phone, registration_date) VALUES (3, 'Dwayne', 'cus3@gmail.com', 777555444, '2025-01-03');
INSERT INTO customers_task6_1(customer_id, name, email, phone, registration_date) VALUES (4, 'Adam', 'cus4@gmail.com', 777999000, '2025-01-04');
INSERT INTO customers_task6_1(customer_id, name, email, phone, registration_date) VALUES (5, 'Anne', 'cus5@gmail.com', 777222111, '2025-01-05');

--INSERTing into TABLE products
INSERT INTO products(product_id, name, description, price, stock_quantity) VALUES (1, 'Laptop', 'laptop-some', 1000, 100);
INSERT INTO products(product_id, name, description, price, stock_quantity) VALUES (2, 'Phone', 'phone-some', 800, 500);
INSERT INTO products(product_id, name, description, price, stock_quantity) VALUES (3, 'Light', 'light-some', 10, 1300);
INSERT INTO products(product_id, name, description, price, stock_quantity) VALUES (4, 'Mouse', 'mouse-some', 50, 600);
INSERT INTO products(product_id, name, description, price, stock_quantity) VALUES (5, 'Keyboard', 'keyboard-some', 100, 600);

--INSERTing into TABLE orders
INSERT INTO orders_task6_1(order_id, customer_id, order_date, total_amount, status) VALUES (1, 1, '2025-02-09', 950, 'pending');
INSERT INTO orders_task6_1(order_id, customer_id, order_date, total_amount, status) VALUES (2, 2, '2025-02-08', 750, 'processing');
INSERT INTO orders_task6_1(order_id, customer_id, order_date, total_amount, status) VALUES (3, 3, '2025-03-07', 8, 'shipped');
INSERT INTO orders_task6_1(order_id, customer_id, order_date, total_amount, status) VALUES (4, 4, '2025-04-06', 45, 'delivered');
INSERT INTO orders_task6_1(order_id, customer_id, order_date, total_amount, status) VALUES (5, 5, '2025-05-05', 50, 'cancelled');

--INSERTing into TABLE order_details
INSERT INTO order_details(order_detail_id, order_id, product_id, quantity, unit_price) VALUES (1, 1, 1, 1, 100);
INSERT INTO order_details(order_detail_id, order_id, product_id, quantity, unit_price) VALUES (2, 2, 2, 5, 800);
INSERT INTO order_details(order_detail_id, order_id, product_id, quantity, unit_price) VALUES (3, 3, 3, 2, 10);
INSERT INTO order_details(order_detail_id, order_id, product_id, quantity, unit_price) VALUES (4, 4, 4, 1, 50);
INSERT INTO order_details(order_detail_id, order_id, product_id, quantity, unit_price) VALUES (5, 5, 5, 1, 100);


--Incorrect data: email is NOT UNIQUE
-- INSERT INTO customers_task6_1 (customer_id, name, email, phone, registration_date) VALUES (6, 'Frank', 'cus2@gmail.com', '345', '2025-06-01');

--Incorrect data: test CHECK on price, price < 0
-- INSERT INTO products (product_id, name, description, price, stock_quantity) VALUES (6, 'cable', 'Test', -1, 10);

--Incorrect data: test CHECK on status
-- INSERT INTO orders_task6_1 (order_id, customer_id, order_date, total_amount, status) VALUES (6, 1, '2025-10-06', 100, 'something');

--Incorrect data: test CHECK on quantity, quantity <= 0
-- INSERT INTO order_details (order_detail_id, order_id, product_id, quantity, unit_price) VALUES (6, 1, 1, 0, 1000);

--Incorrect data: test FOREIGN KEY in customer_id, non-exist customer with this id
-- INSERT INTO orders_task6_1 (order_id, customer_id, order_date, total_amount, status) VALUES (7, 99, '2025-10-07', 100, 'pending');

--Test ON DELETE SET NULL: Delete customer
DELETE FROM customers_task6_1 WHERE customer_id = 1;
-- Result: customer_id in table orders will be NULL

--Test ON DELETE CASCADE: Delete order
DELETE FROM orders_task6_1 WHERE order_id = 2;
-- Result: Order deleted, order_details with order_id=2 deleted automatically.

--Test ON DELETE: Delete product
-- DELETE FROM products WHERE product_id = 1;
-- Result: Fail because order_details reference it.