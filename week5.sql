insert into coffees values (3,"mocha",100,3);
alter table orders_details rename column menu_id to coffee_id;
drop procedure if exists week5()
delimiter //
create procedure week5()
begin 
declare sql_error int default false;
declare continue handler for sqlexception set sql_error = true;
start transaction;
insert into orders values (2,"2023-01-01",500,1);
insert into orders_details values (2,1,2,2);

insert into orders values (3,"2023-01-01",200,1);
insert into orders_details values (3,1,3,3);
if sql_error = false then commit; select "success";
else rollback; select "fail" ; end if;
end //
delimiter ;
call week5();

select customers_name ,options_sweet,count(options_sweet) AS count 
from customers 
join orders using (customers_id)
join orders_details using (orders_id)
join coffees using(coffee_id)
join optionz using (options_id)
group by customers_name,options_sweet;
