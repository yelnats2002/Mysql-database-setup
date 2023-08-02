#1.
SELECT *
FROM (
    SELECT  distinct supplierid,productid,
           SUM((product.unitprice * orderitem.quantity)-(orderitem.unitprice * orderitem.quantity)) OVER (PARTITION BY supplierid) AS revenue
    FROM orderitem
    INNER JOIN product ON orderitem.productid = product.id
) AS subquery
order by revenue desc
;

#2
select * from
(select  concat(firstname,'   ',lastname) as customername,count(orders.id) over(partition by customerid) as no_of_orders ,totalamount as totalordervalue from orders
inner join customer on orders.customerid = customer.id
where totalamount > 5000) as subquery
order by no_of_orders desc;

#3
SELECT *
FROM (
    SELECT CONCAT(firstname, ' ', lastname) AS customername,
           COUNT(orders.id) OVER (PARTITION BY customerid) AS no_of_orders,
           totalamount AS totalordervalue,
           AVG(totalamount) OVER (PARTITION BY customerid) AS average_ordervalue
    FROM orders
    INNER JOIN customer ON orders.customerid = customer.id
    WHERE totalamount > 1000
) AS subquery
HAVING no_of_orders > 10
ORDER BY no_of_orders DESC;


# for getting unique value of last question
SELECT distinct customername,no_of_orders,average_ordervalue
FROM (
    SELECT CONCAT(firstname, ' ', lastname) AS customername,
           COUNT(orders.id) OVER (PARTITION BY customerid) AS no_of_orders,
           totalamount AS totalordervalue,
           AVG(totalamount) OVER (PARTITION BY customerid) AS average_ordervalue
    FROM orders
    INNER JOIN customer ON orders.customerid = customer.id
    WHERE totalamount > 1000
) AS subquery
HAVING no_of_orders > 10
ORDER BY no_of_orders DESC;