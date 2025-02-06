SELECT * FROM restaurant_db.menu_items;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                              -- CREATING DUPLICACTE TABLES FOR EDA --
------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE order_dup
LIKE order_details;

INSERT INTO order_dup
SELECT *
FROM order_details ;

CREATE TABLE menu_dup
LIKE menu_items;

INSERT INTO menu_dup
SELECT *
FROM menu_items ;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                          --  CHECKING DUPLICATES VALUES IN THE TWO TABLES ---
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Order Table --

SELECT *, 
	ROW_NUMBER() OVER (
	PARTITION BY `ï»¿order_details_id`, order_id, order_date, order_time, item_id ) AS Row_Num
    FROM order_dup;
    
WITH CTE_check_duporder 
AS
(
SELECT *, 
	ROW_NUMBER() OVER (
	PARTITION BY `ï»¿order_details_id`, order_id, order_date, order_time, item_id ) AS Row_Num
    FROM order_dup
)
SELECT *
FROM CTE_check_duporder
WHERE Row_Num > 1;

-- Menu Table --

SELECT *, 
	ROW_NUMBER() OVER (
	PARTITION BY `ï»¿menu_item_id`, item_name, category, price ) AS Row_Num
    FROM menu_dup;
    
WITH CTE_check_dupmenu 
AS
(
SELECT *, 
	ROW_NUMBER() OVER (
	PARTITION BY `ï»¿menu_item_id`, item_name, category, price ) AS Row_Num
    FROM menu_dup
)
SELECT *
FROM CTE_check_dupmenu
WHERE Row_Num > 1;



-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                          -- RENAME THE THE ITEM COLUMNS AND OTHER COLUMNS FROM THE TWO TABLES --
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE menu_dup
RENAME COLUMN ï»¿menu_item_id TO item_id;

ALTER TABLE order_dup
RENAME COLUMN ï»¿order_details_id TO order_detail_id;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
									-- CHECKING THE DISTINCT VALUES IN ITEMS NAME & CATEGORY --
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT(item_name)
	FROM menu_dup;
    
SELECT DISTINCT(category)
	FROM menu_dup;
  
  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
											   -- THE DATE RANGE OF THE ORDER MADE --
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

    
SELECT MIN(order_date), MAX(order_date)
FROM order_dup;
    
 
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------
											   -- TOTAL ORDER MADE BETWEEN THE DATE RANGE--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT COUNT(DISTINCT order_id) AS Total_Order_Made
	FROM order_dup;
   
SELECT COUNT(order_detail_id) AS Total_Items_Ordered
	FROM order_dup;

    

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
									-- JOINING THE TWO TABLES TOGETHER FOR EXPLORATORY DATA ANALYSIS --
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM menu_dup AS md
	LEFT JOIN
    order_dup AS od
    ON md.item_id = od.item_id;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
											   -- TOTAL ORDER ITEMS --
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
 
-- Total item orded

SELECT DISTINCT COUNT(order_id) FROM order_dup;
 
-- Item ordered by item_name and category --

SELECT category, item_name,
	COUNT(order_id) AS Tot_Order_Item
FROM menu_dup AS md
	LEFT JOIN
    order_dup AS od
    ON md.item_id = od.item_id
    GROUP BY category, item_name
    ORDER BY Tot_Order_Item DESC ;

-- The most ordered items --

SELECT category, item_name, 
	COUNT(order_id) AS Tot_Order_Item
FROM menu_dup AS md
	LEFT JOIN
    order_dup AS od
    ON md.item_id = od.item_id
    GROUP BY category, item_name
    ORDER BY Tot_Order_Item DESC 
    LIMIT 5;
    
-- The least items ordered

SELECT category, item_name, 
	COUNT(order_id) AS Tot_Order_Item
FROM menu_dup AS md
	LEFT JOIN
    order_dup AS od
    ON md.item_id = od.item_id
    GROUP BY category, item_name
    ORDER BY Tot_Order_Item 
    LIMIT 5;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
											   -- TOP 5 HIGHEST ORDER_ID --
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
 
SELECT order_id, SUM(price) AS total_spent
FROM menu_dup AS md
	LEFT JOIN order_dup AS od
    ON md.item_id = od.item_id
    GROUP BY order_id
	ORDER BY total_spent DESC
    LIMIT 5;
    
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                             -- TOP 5 FIVE HIGHEST ORDER_ID AND ITEMS ORDERED --
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT category,  
	COUNT(order_id) AS total_item_ordered
FROM menu_dup AS md LEFT JOIN order_dup AS od
    ON md.item_id = od.item_id
    WHERE order_id IN (440, 2075, 1957, 330, 2675)
    GROUP BY category
    ORDER BY total_item_ordered DESC ;


SELECT category, item_name, COUNT(order_id) AS total_item_ordered
FROM menu_dup AS md LEFT JOIN order_dup AS od
    ON md.item_id = od.item_id
    WHERE order_id IN (440, 2075, 1957, 330, 2675)
    GROUP BY category, item_name
    ORDER BY total_item_ordered DESC;
    
    
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
													--   MAX, MIN AND AVERAGE PRICE -- 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT MAX(price) AS Maximum_Price,
	MIN(price) AS Minimum_Price,
	AVG(price) AS Average_Price
FROM menu_dup;
	

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
											   -- MOST ORDERED CUISINES CATEGORY AND ITMES --
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Cuisine Category --
SELECT category, 
	COUNT(order_id) AS Tot_Category_Ordered
FROM menu_dup AS md
	LEFT JOIN order_dup AS od
    ON md.item_id = od.item_id
    GROUP BY category
    ORDER BY Tot_Category_Ordered DESC;
    
    
-- Most Ordered Cuisines Items --
SELECT item_name,
	COUNT(order_id) AS Tot_Item_Ordered
FROM menu_dup AS md
	LEFT JOIN
    order_dup AS od
    ON md.item_id = od.item_id
    GROUP BY item_name
    ORDER BY Tot_Item_Ordered DESC;



------------------------------------------------------------------------------------------------------------------------------------------------------------------
											  -- TIMES WITH MORE AND LESS ORDERED -- 
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Create
ALTER TABLE order_dup
ADD COLUMN order_period VARCHAR(15);

-- Create Case Statement --

SELECT order_time,
	CASE
	WHEN order_time BETWEEN "00:00:00 AM" AND "11:59:59 AM" THEN "Morning"
	WHEN order_time BETWEEN ":12:00:00 PM" AND "16:00:00 PM" THEN "Afternoon"
    ELSE "Evening"
    END AS order_period
FROM order_dup;

-- Update the case statement in the order_period column

UPDATE order_dup
SET order_period = CASE
	WHEN order_time BETWEEN "00:00:00 AM" AND "11:59:59 AM" THEN "Morning"
	WHEN order_time BETWEEN ":12:00:00 PM" AND "16:00:00 PM" THEN "Afternoon"
    ELSE "Evening"
    END ;


------------------------------------------------------------------------------------------------------------------------------------------------------------------
											  -- TIMES WITH MORE AND LESS ORDERED -- 
------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT order_period, 
	COUNT(order_id) AS Total_Orders
FROM order_dup
	GROUP BY order_period
	ORDER BY Total_Orders DESC;


SELECT order_period, category, item_name,
	COUNT(order_id) AS Total_Orders
FROM order_dup AS od LEFT JOIN menu_dup AS md
	ON od.item_id = md.item_id
	GROUP BY order_period, category, item_name
	ORDER BY Total_Orders DESC;


SELECT * FROM order_dup;
SELECT MIN(order_time), MAX(order_time) FROM order_dup;

SELECT DISTINCT HOUR(order_time) FROM order_dup;


		



