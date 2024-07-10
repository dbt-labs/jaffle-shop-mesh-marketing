with cust as (

    select *     
    from {{ ref('customers') }}

)

, ord as (

  select *     
   from {{ ref('jaffle_shop_mesh_finance', 'orders') }}

)

, cust_ord as ( 

    select c.customer_id, sum(order_total) as total_price_usd 
            from ord o 
            inner join cust c 
            on o.customer_id = c.customer_id
            where true 
            group by 1

)

, business_logic as (
select 
  customer_id
, case when total_price_usd >= 2500 then 'gold'
       when total_price_usd between 1000 and 2499 then 'silver'
       else 'bronze'
   end as medallion_level
,  round(total_price_usd / 100) as points_amount

   from cust_ord 
)

select * from business_logic
