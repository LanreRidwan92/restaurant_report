# A restaurant services international cuisines seeks to analyze its sales for the first Quarter of the year 2023 to know which items and categories customers order most and the ones with the least orders as well as the time of the day they received more orders to know which of the cuisines they would develop more menu items for based on the Q1 sales.

# Data Preparation Process 
* Having loaded the datasets into the MYSQL database, I created a duplicate table from the two tables and loaded the datasets into them in order not to tamper with the original dataset given to me.
* Thereafter, I used the Row_Number function to check if there were any duplicate values, of which there weren't.
* I rename columns with incorrect spellings, such as order details columns.
* The two tables were joined together by the item_id column.
* I checked the distinct values of the item category and the item name column.
* An order period column was created to categorize the time of the day customers ordered most.


# Insights 

* There are a total number of 32 items and four different cuisine categories which are American, Asian, Mexican and Italian cuisine.
* A total order of 12,234 was made through the period, while the most ordered items were Hamburgers with 622, Edamame with 620, Korean Beef bowls, Cheeseburgers with 583 and Fresh Fries with 571.
* The least ordered items are Chicken Tacos at 123, Potstickers at 205, Cheese Lasagna at 207, Steak Tacos at 214 and Cheese Quesadillas at 233.
* Edamame was the most ordered item with a total order of 620, followed by Korean Beef bowl with 588 and Cheeseburger with 583 orders.
* The top 5 highest order ID are (440, 2075, 1957, 330 and 2675)
* Italian cuisine was the most ordered items by the top 5 highest buyers with a total of 26 orders, follow by Asian cuisine with 17 orders.
* There were more orders at the evening period than the morning period and afternoon, as a total number of 8,032 orders were received at the evening period, while 2,530 orders received in the morning and 1,672 in the afternoon.

# Conclusion

* The analysis of the restaurant's order data reveals valuable insights into customer preferences and ordering patterns.  The data encompasses 32 items across four cuisines (American, Asian, Mexican, and Italian) and a total of 12,234 orders.  A clear preference for certain items emerges, with Hamburgers, Edamame, Korean Beef Bowls, Cheeseburgers, and Fresh Fries leading in popularity. Conversely, Chicken Tacos, Potstickers, Cheese Lasagna, Steak Tacos, and Cheese Quesadillas are significantly less popular.
  
* While Edamame saw the highest individual order count (620), the top five ordering customers favoured Italian cuisine, followed by Asian, suggesting that while individual items might be popular, customer segments may have different cuisine preferences. Finally, the data strongly indicates that evening is the restaurant's busiest period, accounting for a substantial majority of orders compared to morning and afternoon.

# Recommendations

* Optimize Inventory and Preparation:  Given the high demand for Hamburgers, Edamame, Korean Beef Bowls, Cheeseburgers, and Fresh Fries, the restaurant should ensure sufficient stock of ingredients and streamline preparation processes for these items to meet customer demand efficiently, especially during peak evening hours. Conversely, consider reducing inventory for less popular items like Chicken Tacos, Potstickers, Cheese Lasagna, Steak Tacos, and Cheese Quesadillas to minimize waste and optimize storage.
 
* Targeted Marketing:  While Edamame is popular individually, the top customers prefer Italian and Asian cuisine.  The restaurant could implement targeted marketing campaigns to promote these cuisines to different customer segments.  For example, special promotions or combo deals featuring Italian or Asian dishes could attract more orders from high-value customers.
  
* Evening Rush Management:  The significantly higher volume of orders during the evening necessitates optimized staffing and operational efficiency.  The restaurant should consider strategies to manage the evening rush effectively, such as staggered staffing, streamlined order processing, and potentially offering incentives for orders placed during off-peak hours to distribute demand.
