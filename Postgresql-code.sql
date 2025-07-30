create procedure o_puni_masterbetrieb (p_mjesec int, p_godina  int)
language plpgsql    
as 
$$
begin
insert into meisterbetrieb
select
extract('year' from rental_date) as year,
extract('month' from rental_date) as month,
c.customer_id,
title,
address
from rental r
inner join inventory i
on r.inventory_id=i.inventory_id
inner join film f
on i.film_id=f.film_id
inner join customer c
on r.customer_id=c.customer_id
inner join address a
on c.address_id=a.address_id
where extract('year' from rental_date)=p_godina
and extract('month' from rental_date)=p_mjesec;
end;
$$

call o_puni_masterbetrieb(02,2017)
select * from meisterbetrieb
