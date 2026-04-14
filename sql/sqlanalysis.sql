-- =========================================
-- FOOD DELIVERY ANALYSIS
-- =========================================

-- 1. Total Orders & Revenue
SELECT 
    COUNT(*) AS total_orders,
    SUM(order_value) AS total_revenue
FROM orders;

-- 2. Average Delivery Time
SELECT 
    AVG(delivery_time) AS avg_delivery_time
FROM orders;

-- 3. Orders by City
SELECT 
    city,
    COUNT(*) AS total_orders
FROM orders
GROUP BY city
ORDER BY total_orders DESC;

-- 4. Peak Order Hours
SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY total_orders DESC;

-- 5. High Value Orders (>500)
SELECT *
FROM orders
WHERE order_value > 500;

-- 6. Customer Ranking (Window Function)
SELECT 
    customer_id,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS rank_no
FROM (
    SELECT 
        customer_id,
        SUM(order_value) AS total_spent
    FROM orders
    GROUP BY customer_id
) t;

-- 7. Daily Order Trend (LAG Function)
SELECT 
    order_date,
    total_orders,
    LAG(total_orders) OVER (ORDER BY order_date) AS prev_day_orders
FROM (
    SELECT 
        DATE(order_time) AS order_date,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY DATE(order_time)
) t;

-- 8. Late Deliveries (>30 mins)
SELECT *
FROM orders
WHERE delivery_time > 30;