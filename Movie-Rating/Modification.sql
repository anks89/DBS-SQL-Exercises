-- Question 1
-- Add the reviewer Roger Ebert to your database, with an rID of 209. 
Insert into Reviewer values (209, 'Roger Ebert');

-- Question 2
-- Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL. 
Insert into Rating
Select rID, M.mID, '5', null
From Rating R, Movie M
where rID is (select rID from Reviewer where name = 'James Cameron');

-- Question 3
-- For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.) 
update Movie
Set year = year + 25
Where mID in
    (select M.mID
    from Movie M join Rating R on M.mID = R.mID 
    group by M.mID
    having avg(stars) >=4);

-- Question 4
-- Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars.
Delete From Rating
Where mID in
(Select mID
From Movie
Where year <1970 or year >2000)
and stars <4;
