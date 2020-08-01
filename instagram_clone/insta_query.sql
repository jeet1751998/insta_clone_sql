-- 1. finding 5 oldest users --

select * from users order by created_at 
limit 5;

-- 2. most popular registration date --

select 
username,
dayname(created_at) as days,
count(*) as total
from users
group by days
order by total desc;


-- 3 indentify inactive users --
select username, image_url from users 
left join photos on users.id=photos.user_id
where photos.id is null;

-- 4 single most like photo -- 

select username,photos.id, photos.image_url, count(*) as total from photos 
inner join likes
on likes.photo_id = photos.id
inner join users
on photos.user_id = users.id
group by photos.id
order by total desc
limit 1;

-- 5. calculate average number of photos per user --

-- total nmber of photos / total number of users --

select 
(select count(*) from photos) /  (select count(*) from users);


-- 6. 5 most commenly used hashtags -- 
select tags.tag_name, count(*) as total from photo_tags join tags on photo_tags.tag_id = tags.id
group by tags.id order by total desc limit 5;


-- 7 finding bots -- user who likes every single photo -- 

select username,count(*) as num_like from  users inner join likes
on users.id = likes.user_id
group by likes.user_id 
having num_like = (select count(*) from photos);