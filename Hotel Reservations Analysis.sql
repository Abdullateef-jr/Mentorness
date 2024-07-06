 # Creating database Hotel_reservation #
 
Create schema Hotel_reservation;
select * from `hotel reservation dataset`;

# Checking for duplicate values #
Select
Booking_ID,
count(*) as counting
from `hotel reservation dataset`
group by Booking_ID
having counting > 1
;


# Updating the table to change the date format #

update `hotel reservation dataset`
set arrival_date = str_to_date(arrival_date,'%d-%m-%Y');

# Getting the booking_date #

alter table `hotel reservation dataset`
add column Booking_date Date;
update `hotel reservation dataset`
set Booking_date = date_sub(arrival_date,interval lead_time Day);

--  Q1 TOTAL NUMBER OF RESERVATIONS --
Select 
count(Booking_ID) as Total_reservations
from `hotel reservation dataset`
;

-- Q2 THE MOST POPULAR MEAL PLAN AMONGST GUESTS --
select type_of_meal_plan,
count(type_of_meal_plan) as No_of_orders
from `hotel reservation dataset`
where booking_status = 'Not_Canceled'
group by type_of_meal_plan
order by No_of_orders desc
limit 1
;

-- Q3 AVERAGE PRICE PER ROOM INVOLVING CHILDREN --
Select concat('$',
round(
avg(avg_price_per_room),2))as Average_price_per_room
from `hotel reservation dataset`
where no_of_children > 0
;

-- Q4 HOW MANY RESERVATION WERE MADE FOR THE YEAR 2018 --
alter table `hotel reservation dataset`
add column Year_of_reservation Int
;

update `hotel reservation dataset`
set Year_of_reservation = year(Booking_date);

Select 2018 as Year, 
count(Booking_ID) as Reservations
from `hotel reservation dataset`
where Year_of_reservation = 2018
;

-- Q5 MOST COMMONLY BOOKED ROOM TYPE --
Select room_type_reserved,
count(room_type_reserved) as No_of_bookings
from `hotel reservation dataset`
group by room_type_reserved
order by No_of_bookings desc
limit 1
;

-- Q6 HOW MANY RESERVATIONS FALLS ON A WEEKEND --
Select count(Booking_ID) as Weekend_reservations
from `hotel reservation dataset`
where no_of_weekend_nights > 0
;

-- Q7 WHAT IS THE HEIGHEST AND LOWEST LEAD TIME FOR RESERVATIONS --
Select max(lead_time) as Heighest,
min(lead_time) as Lowest
from `hotel reservation dataset`
;

-- Q8 MOST COMMON MARKET SEGMEENT TYPE FOR RESERVATIONS --
Select market_segment_type,
count(market_segment_type) as Reservations
from `hotel reservation dataset`
group by market_segment_type
order by Reservations desc
limit 1
;

-- Q9 HOW MANY RESERVATIONS HAS A BOOKING STATUS OF CONFIRMED --
Select 
count(Booking_ID) Reservations
from `hotel reservation dataset`
where booking_status = 'Not_Canceled'
;

-- Q10 TOTAL NUMBER OF ADULTS AND CHILDREN ACROSS ALL RESERVATIONS --
Select sum(no_of_adults) as Number_of_Adults,
sum(no_of_children) as Number_of_Children,
sum((no_of_adults) + (no_of_children)) as Total_number
from `hotel reservation dataset`
;

-- Q11 AVERAGE NUMBER OF WEEKEND NIGHTS FOR RESERVATIONS INVOLVING CHILDREN --
Select  round(avg(no_of_weekend_nights),2) as Average_no_of_weekend_nights
from `hotel reservation dataset`
where no_of_children > 0
;

-- Q12 HOW MANY RESERVATIONS WERE MADE IN EACH MONTH OF THE YEAR --
Alter table `hotel reservation dataset`
add column Month_reservations text;

update `hotel reservation dataset`
set Month_reservations = monthname(Booking_date);

select Month(Booking_date) as Month_number,
Month_reservations, 
count(Booking_ID) as Reservations
from `hotel reservation dataset`
group by Month_reservations
order by Month_number Asc;


-- Q13 AVERAGE NUMBER OF NIGHTS (WEEKENDS AND WEEKDAYS) SPENT BY GUESTS FOR EACH ROOM TYPE --

select room_type_reserved,
round(
avg((no_of_weekend_nights)+(no_of_week_nights)),2)
 as Average_no_of_nights
from `hotel reservation dataset`
where booking_status ='Not_Canceled'
group by room_type_reserved
order by 1
;


-- Q14 FOR RESERVATION INVOLVING CHILDREN, WHAT IS THE COMMON ROOM TYPE AND THE AVRAGE PRICE --
Select room_type_reserved,
count(room_type_reserved) as Reservations,
concat('$',
round(avg(avg_price_per_room),2)) as Avgrage_price
from `hotel reservation dataset`
where no_of_children > 0
group by room_type_reserved
order by Reservations desc
limit 1
;

-- Q15 MARKET SEGMENT THAT GENERATE THE HIGHEST AVRAGE PRICE PER ROOM --
Select market_segment_type,
concat('$',
max(avg_price_per_room)) as Average_price_per_room
from `hotel reservation dataset`
group by market_segment_type
order by Average_price_per_room desc
limit 1
offset 1;




