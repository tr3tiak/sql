-- Третьяк А.П.
-- Вариант 18
-- Описание предметной области
-- Описание экскурсионных туров. Включает в себя: маршруты, экскурсии, туры.
-- Маршрут характеризуется названием, городом отправления, описанием маршрута, базовой ценой (без экскурсий) в рублях,
-- указанием списка всех возможных для посещения городов и количеством дней пребывания в них.
-- Экскурсия характеризуется: указанием города (в каждом городе может быть несколько экскурсий), названием, описанием и ценой в рублях.
-- Тур характеризуется: указанием маршрута, датой отъезда, количеством дней тура, дополнительными взносами, дополнительным описанием.
-- Одна и та же экскурсия может быть связана с несколькими городами.

create table city (
id integer serial primary key,
name varchar(100) not null unique
);

create table route (
id integer serial primary key,
name varchar(200) not null unique,
departure_city_id integer not null
references city(id) on update cascade on delete restrict,
description text not null default '',
base_price numeric(12,2) not null default 0
check (base_price >= 0)
);

create table route_city (
route_id integer not null
references route(id) on update cascade on delete cascade,
city_id integer not null
references city(id) on update cascade on delete restrict,
stay_days integer not null default 1
check (stay_days > 0),
primary key (route_id, city_id)
);

create table excursion (
id integer serial primary key,
name varchar(200) not null,
description text not null default '',
price numeric(12,2) not null default 0
check (price >= 0)
);

create table excursion_city (
excursion_id integer not null
references excursion(id) on update cascade on delete cascade,
city_id integer not null
references city(id) on update cascade on delete restrict,
primary key (excursion_id, city_id)
);

create table tour (
id integer serial primary key,
route_id integer not null
references route(id) on update cascade on delete restrict,
departure_date date not null,
days_count integer not null
check (days_count > 0),
extra_fee numeric(12,2) not null default 0
check (extra_fee >= 0),
description text not null default '',
unique (route_id, departure_date)
);
