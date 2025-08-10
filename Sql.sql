create database hmdb;
-- Step 1: Create Database
DROP DATABASE IF EXISTS ecommerce_db;
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Step 2: Create Tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 3: Insert Data
INSERT INTO customers (customer_name, city, country) VALUES
('John Smith', 'New York', 'USA'),
('Sara Khan', 'London', 'UK'),
('Amit Sharma', 'Mumbai', 'India'),
('Linda Green', 'Sydney', 'Australia');

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1200.00),
('Smartphone', 'Electronics', 800.00),
('T-shirt', 'Clothing', 25.00),
('Shoes', 'Clothing', 50.00),
('Headphones', 'Electronics', 150.00);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-07-01', 1250.00),
(2, '2025-07-02', 800.00),
(3, '2025-07-03', 75.00),
(1, '2025-07-05', 150.00);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 5, 1),
(2, 2, 1),
(3, 3, 1),
(3, 4, 1),
(4, 5, 1);

-- Step 4: Example Queries for Output Screenshots

-- 1. SELECT + WHERE + ORDER BY
SELECT product_name, price
FROM products
WHERE price > 100
ORDER BY price DESC;

-- 2. GROUP BY + Aggregate
SELECT category, COUNT(*) AS total_products, AVG(price) AS avg_price
FROM products
GROUP BY category;

-- 3. INNER JOIN
SELECT o.order_id, c.customer_name, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 4. LEFT JOIN
SELECT c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 5. Subquery
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 6. View
CREATE VIEW high_value_customers AS
SELECT c.customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING total_spent > 1000;

-- 7. Show View Data
SELECT * FROM high_value_customers;

-- 8. Index
CREATE INDEX idx_product_name ON products(product_name);

