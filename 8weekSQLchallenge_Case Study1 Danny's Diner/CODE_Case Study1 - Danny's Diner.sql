SELECT * FROM dannys_diner.sales;

SELECT * FROM dannys_diner.members;

SELECT * FROM dannys_diner.menu;

SELECT 
	s.customer_id, 
    s.order_date, 
    s.product_id,
    m.price,
    s.product_id*m.price as revenue
FROM sales as s
JOIN menu as m on s.product_id = m.product_id;

-- 1.What is the total amount each customer spent at the restaurant? -- 
SELECT
    s.customer_id,
    sum(s.product_id*m.price)  as revenue
FROM sales as s
JOIN menu as m on s.product_id = m.product_id
GROUP BY s.customer_id;

-- 2.How many days has each customer visited the restaurant? --
SELECT 
	customer_id,
	COUNT(distinct(order_date))
FROM sales
GROUP BY customer_id;

-- 3.What was the first item from the menu purchased by each customer? --
SELECT 
	customer_id,
    order_date,
    product_id
FROM sales
GROUP BY customer_id
ORDER BY order_date asc, customer_id asc;

--?4. What is the most purchased item on the menu and how many times was it purchased by all customers?--
SELECT
    m.product_name,
    count(s.product_id) as count_product
FROM sales as s
JOIN menu as m on s.product_id = m.product_id
GROUP by m.product_name
ORDER by count_product desc
limit 1;

--?5. Which item was the most popular for each customer?--
SELECT 
customer_id,
product_id,
count(product_id) as count_product
FROM sales
GROUP BY customer_id, product_id;

--?6. Which item was purchased first by the customer after they became a member?--
SELECT
	s.customer_id,
    s.order_date,
    s.product_id,
    m.join_date,
    u.product_name
FROM sales as s
JOIN members as m ON s.customer_ID = m.customer_ID
JOIN menu as u on s.product_id = u.product_id
WHERE order_date > join_date
ORDER BY order_date;

--?7. Which item was purchased just before the customer became a member?
SELECT
	s.customer_id,
    s.order_date,
    s.product_id,
    m.join_date,
    u.product_name
FROM sales as s
JOIN members as m ON s.customer_ID = m.customer_ID
JOIN menu as u on s.product_id = u.product_id
WHERE order_date < join_date
ORDER BY order_date;

--8. What is the total items and amount spent for each member before they became a member?
SELECT
	s.customer_id,
    COUNT(s.product_id) as quantity,
    SUM(u.price) as total_sales
FROM sales as s
JOIN menu as u ON s.product_id = u.product_id
JOIN members as m ON s.customer_id = m.customer_id
WHERE s.order_date < m.join_date
GROUP BY s.customer_id;