/*
Given the schema below, write BigQuery compatible SQL to generate a report with the top 10 users by total price of all purchases.

CREATE TABLE users (
id SERIAL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE orders (
id SERIAL PRIMARY KEY,
user_id INTEGER REFERENCES users (id) ON DELETE CASCADE,
date TIMESTAMP NOT NULL,
shipping_destination VARCHAR(255) NOT NULL,
model_number VARCHAR(255) NOT NULL,
price DECIMAL(10,2) NOT NULL
);
*/

/*
INSERT INTO users (name, email) VALUES
  ('John Doe', 'johndoe@example.com'),
  ('Jane Smith', 'janesmith@example.com'),
  ('Alice Johnson', 'alicejohnson@example.com'),
  ('Bob Williams', 'bobwilliams@example.com'),
  ('Charlie Brown', 'charliebrown@example.com'),
  ('David Lee', 'davidlee@example.com'),
  ('Emily Wilson', 'emilywilson@example.com'),
  ('Frank Taylor', 'franktaylor@example.com'),
  ('Grace Baker', 'gracebaker@example.com'),
  ('Henry Clark', 'henryclark@example.com'),
  ('Isabella Adams', 'isabellaadams@example.com'),
  ('Jack Harris', 'jackharris@example.com'),
  ('Kate Hill', 'katehill@example.com'),
  ('Leo Jones', 'leojones@example.com'),
  ('Maria King', 'mariaking@example.com'),
  ('Nathan Miller', 'nathanmiller@example.com'),
  ('Olivia Moore', 'oliviamoore@example.com'),
  ('Paul Nelson', 'paulnelson@example.com'),
  ('Queen Parker', 'queenparker@example.com'),
  ('Richard Roberts', 'richardroberts@example.com'),
  ('Sarah Russell', 'sarahrussell@example.com'),
  ('Thomas Stevens', 'thomasstevens@example.com'),
  ('Ursula Underwood', 'ursulounderwood@example.com'),
  ('Victor Valentine', 'victorvalentine@example.com'),
  ('Wendy Walker', 'wendywalker@example.com');
*/

/*
INSERT INTO orders (user_id, date, shipping_destination, model_number, price) VALUES
  (1, '2023-01-01 12:00:00', '123 Main St', 'Model A', 19.99),
  (2, '2023-02-02 13:00:00', '456 Elm St', 'Model B', 29.99),
  (3, '2023-03-03 14:00:00', '789 Oak St', 'Model C', 39.99),
  (4, '2023-04-04 15:00:00', '101 Pine St', 'Model D', 49.99),
  (5, '2023-05-05 16:00:00', '202 Maple St', 'Model E', 59.99),
  (6, '2023-06-06 17:00:00', '303 Birch St', 'Model F', 69.99),
  (7, '2023-07-07 18:00:00', '404 Willow St', 'Model G', 79.99),
  (8, '2023-08-08 19:00:00', '505 Cedar St', 'Model H', 89.99),
  (9, '2023-09-09 20:00:00', '606 Chestnut St', 'Model I', 99.99),
  (10, '2023-10-10 21:00:00', '707 Oak St', 'Model J', 109.99),
  (11, '2023-11-11 22:00:00', '808 Walnut St', 'Model K', 119.99),
  (12, '2023-12-12 23:00:00', '909 Hickory St', 'Model L', 129.99),
  (13, '2024-01-13 00:00:00', '1000 Maple St', 'Model M', 139.99),
  (14, '2024-02-14 01:00:00', '1100 Birch St', 'Model N', 149.99),
  (15, '2024-03-15 02:00:00', '1200 Willow St', 'Model O', 159.99),
  (16, '2024-04-16 03:00:00', '1300 Cedar St', 'Model P', 169.99),
  (17, '2024-05-17 04:00:00', '1400 Chestnut St', 'Model Q', 179.99),
  (18, '2024-06-18 05:00:00', '1500 Oak St', 'Model R', 189.99),
  (19, '2024-07-19 06:00:00', '1600 Walnut St', 'Model S', 199.99),
  (20, '2024-08-20 07:00:00', '1700 Hickory St', 'Model T', 209.99),
  (21, '2024-09-21 08:00:00', '1800 Maple St', 'Model U', 219.99),
  (22, '2024-10-22 09:00:00', '1900 Birch St', 'Model V', 229.99),
  (23, '2024-11-23 10:00:00', '2000 Willow St', 'Model W', 239.99),
  (24, '2024-12-24 11:00:00', '2100 Cedar St', 'Model X', 249.99),
  (25, '2025-01-25 12:00:00', '2200 Chestnut St', 'Model Y', 259.99);
  */

  /*
  Join the users and orders tables based on the user_id column, calculate the total price for each user, and then order the results by total price in descending order. Finally, it limits the results to the top 10 users.
  */
  SELECT
  u.name AS user_name,
  SUM(o.price) AS total_price
FROM
  users u
JOIN
  orders o ON u.id = o.user_id
GROUP BY
  u.name
ORDER BY
  total_price DESC
LIMIT 10;

-- Find the average price of orders placed by each user.
SELECT
  u.name AS user_name,
  ROUND(avg(o.price),2) AS avg_price
FROM
  users u
JOIN
  orders o ON u.id = o.user_id
GROUP BY
  u.name
ORDER BY
  avg_price DESC;

-- Find the total number of orders placed by each user and the total amount spent
SELECT
  u.name AS user_name,
  COUNT(o.user_id) AS order_count,
  SUM(o.price) AS total_price
FROM
  users u
JOIN
  orders o ON u.id = o.user_id
GROUP BY
  u.name
ORDER BY
  total_price DESC;