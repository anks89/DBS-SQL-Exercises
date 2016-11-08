-- Question 1
-- Find the titles of all movies directed by Steven Spielberg
Select title
From Movie
Where director = 'Steven Spielberg';

-- Question 2
-- Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order
Select distinct year
From Movie, Rating using(mID)
Where stars >= 4;

-- Question 3
-- Find the titles of all movies that have no ratings
select distinct title
from movie left join rating using(mID)
where stars is null;

-- Question 4
-- Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date
select name
from reviewer, rating using(rID)
where ratingdate is null;

-- Question 5
-- Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars
select name as 'Reviewer Name', title as 'Movie Title', stars, ratingDate
from Movie, Rating, Reviewer
where Movie.mID = Rating.mID and Reviewer.rID = Rating.rID
order by name, title, stars;

-- Question 6
-- For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie
Select distinct RW1.name, RW1.title
From 
    (select *
    from Movie, Rating, Reviewer
    where Movie.mID = Rating.mID and Reviewer.rID = Rating.rID) RW1, 
    Rating RW2
where RW1.rID = RW2.rID and RW1.mID = RW2.mID and RW1.ratingdate>RW2.ratingdate;

-- Question 7
-- For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title. 
Select distinct M1.title, M1.stars
From
    (select *
    From Movie, Rating using(mID)) M1, Rating M2
Where M1.mID = M2.mID and not M1.rID = 204 and M1.stars > M2.stars
Order by M1.title;

-- Question 8
-- For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. 
Select distinct Movie.title, M1.stars - M2.stars as Spread
From Movie,
    (Select distinct *
    From Rating MA, Rating MB
    Where MA.stars > MB.stars) M1,
    (Select *
    From Rating MC, Rating MD
    Where MC.stars < MD.stars) M2
Where Movie.mID = M1.mID and Movie.mID = M2.mID and not Spread <= 0 
    and not M1.rID = 204 and not M2.rid=204
Order by Spread desc

-- Question 9
-- Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)
Select M1.L-M2.G
From
    (select avg(G1980) as G
    From
        (Select mID, year, avg(stars) as 'G1980'
        From Rating, Movie using(mID)
        Group By mID) M
     where M.year > 1980) M2,
     (select avg(L1980) as L
    From
        (Select mID, year, avg(stars) as 'L1980'
        From Rating, Movie using(mID)
        Group By mID) N
     where N.year < 1980) M1;
