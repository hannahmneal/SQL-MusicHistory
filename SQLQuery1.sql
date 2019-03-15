--1. Query all of the entries in the Genre table

--SELECT 
--	Id,
--	Label
--FROM Genre;

--2. Using the INSERT statement, add one of your favorite artists to the Artist table.

--INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Metallica', 1981);

--SELECT 
--	ArtistName,
--	YearEstablished
--FROM Artist;

--3. Using the INSERT statement, add one, or more, albums by your artist to the Album table.

--INSERT INTO Album
--	(Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Ride the Lightning', '1983', 47, 'Megaforce', 28, 5)
--INSERT INTO Album
--	(Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) 
--	  VALUES ('Master of Puppets', '1983', 55, 'Megaforce', 28, 5)
--INSERT INTO Album
--	(Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) 
--	  VALUES ('Metallica', '1991', 63, 'Elektra', 28, 5);

--SELECT * FROM Album;


--4. Using the INSERT statement, add some songs that are on that album to the Song table.

--INSERT INTO Song
--(Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId)
--VALUES ('For Whom the Bell Tolls', 5, '08/31/1985', 5, 28, 23);

--INSERT INTO Song
--(Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId)
--VALUES ('Master of Puppets', 8, '07/02/1986', 5, 28, 25);

--INSERT INTO Song
--(Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId)
--VALUES ('Enter Sandman', 5, '07/30/1991', 5, 28, 26);

--SELECT * FROM Song;

--5. Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added.

-- SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON a.Id = a.Id;
-- This returns a table with a col. of Albums on the left and Songs in that album on the right
-- SELECT s.Title, a.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.Id;
-- This returns a table with a col. of Songs on the left and their Album on the right. 

-- The FROM clause specifies an INNER JOIN between the Album and Song tables based on the Album.Id/AlbumId in both tables.

--SELECT * FROM Artist;
--SELECT * FROM Album;
--SELECT * FROM Song;

--SELECT a.title AS 'Album Title', s.title AS 'Song Title' FROM Song s LEFT JOIN Album a ON a.Id = s.AlbumId;


--SELECT DISTINCT a.title AS 'AlbumTitle', s.title AS 'Song Title', art.ArtistName AS 'Artist Name' FROM Song s LEFT JOIN Album a ON a.Id = s.AlbumId LEFT JOIN Artist art ON art.Id = s.ArtistId WHERE art.ArtistName = 'Metallica' ORDER BY s.title asc;


--6. Write a SELECT statement to display how many songs exist for each album. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

--SELECT COUNT(s.title) AS 'Songs', a.title AS 'Album Title' FROM Song s LEFT JOIN Album a ON a.Id = s.AlbumId GROUP BY (a.title);

--7. Write a SELECT statement to display how many songs exist for each artist. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

--SELECT COUNT(s.title) AS 'Songs', art.ArtistName AS 'Artist Name' FROM Song s LEFT JOIN Artist art ON art.Id = s.ArtistId GROUP BY (art.ArtistName);

--8. Write a SELECT statement to display how many songs exist for each genre. You'll need to use the COUNT() function and the GROUP BY keyword sequence.

--SELECT COUNT(s.title) AS 'Songs', g.Label AS 'Genre' FROM Song s LEFT JOIN Genre g ON g.Id = s.GenreId GROUP BY (g.Label);

--9. Using MAX() function, write a select statement to find the album with the longest duration. The result should display the album title and the duration.

--SELECT MAX(AlbumLength) AS 'Max Duration', title FROM Album GROUP BY (title);

--10. Using MAX() function, write a select statement to find the song with the longest duration. The result should display the song title and the duration.

--SELECT title AS 'Song Title', MAX(SongLength) AS 'Song Length' FROM Song GROUP BY (title); 

--11. Modify the previous query to also display the title of the album.
