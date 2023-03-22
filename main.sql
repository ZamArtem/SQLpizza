.open pizza.db
SELECT '------------------------------------------------------------------------';
SELECT '01. -- Hogy hívják az egyes pizzafutárokat?';
SELECT Fnev FROM Futar;
SELECT '------------------------------------------------------------------------';
SELECT '02. -- Milyen pizzák közül lehet rendelni, és mennyibe kerülnek?';
SELECT Pnev,Par FROM pizza; 
SELECT '------------------------------------------------------------------------';
SELECT '03. -- Mennyibe kerül átlagosan egy pizza?';
SELECT SUM(Par)/COUNT(Par) FROM pizza;
SELECT '------------------------------------------------------------------------';
SELECT '04. -- Mely pizzák olcsóbbak 1000 Ft-nál?';
SELECT Pnev FROM pizza 
WHERE par < 1000;
SELECT '------------------------------------------------------------------------';
SELECT '05. -- Ki szállította házhoz az első (egyes sorszámú) rendelést?';
SELECT Fnev FROM Futar
INNER JOIN Rendeles ON Rendeles.Fazon = Futar.Fazon
WHERE Razon = 1;
SELECT '------------------------------------------------------------------------';
SELECT '06. -- Kik rendeltek pizzát délelőtt?';
SELECT Vnev,substring((substring(Rendeles.Idopont,12,13)),1,2) FROM Vevo
INNER JOIN Rendeles 
ON Rendeles.Vazon = Vevo.Vazon
WHERE (substring((substring(Rendeles.Idopont,12,13)),1,2)) < "12";
SELECT '------------------------------------------------------------------------';
SELECT '07. -- Milyen pizzákat evett Morgó?';
SELECT Pnev FROM Pizza
INNER JOIN Tetel 
ON Pizza.Pazon = Tetel.Pazon
INNER JOIN Rendeles
ON Rendeles.Razon = Tetel.Razon
INNER JOIN Vevo
ON Vevo.Vazon = Rendeles.Vazon
WHERE Vevo.Vnev = 'Morgó';
SELECT '------------------------------------------------------------------------';
SELECT DISTINCT Pnev FROM Pizza, Tetel, Rendeles, Vevo
WHERE Pizza.Pazon = Tetel.Pazon
AND Rendeles.Razon = Tetel.Razon
AND Vevo.Vazon = Rendeles.Vazon
AND Vevo.Vnev = 'Morgó';
SELECT '------------------------------------------------------------------------';
SELECT '08. -- Ki szállított házhoz Tudornak?';
SELECT Fnev FROM Futar
INNER JOIN Rendeles
ON Futar.Fazon = Rendeles.Fazon
INNER JOIN Vevo
ON Rendeles.Vazon = Vevo.Vazon
WHERE Vevo.Vnev = 'Tudor';
SELECT '------------------------------------------------------------------------';
SELECT '09. -- Az egyes rendelések alkalmával ki kinek szállított házhoz?';
SELECT Fnev,Vevo.Vnev FROM Futar
INNER JOIN Rendeles
ON Futar.Fazon = Rendeles.Fazon
INNER JOIN Vevo
ON Rendeles.Vazon = Vevo.Vazon;
SELECT '------------------------------------------------------------------------';
SELECT '10. -- Mennyit költött pizzára Vidor?';
SELECT SUM(Par*Tetel.Db) FROM Pizza
INNER JOIN Tetel 
ON Pizza.Pazon = Tetel.Pazon
INNER JOIN Rendeles
ON Rendeles.Razon = Tetel.Razon
INNER JOIN Vevo
ON Vevo.Vazon = Rendeles.Vazon
WHERE Vnev = 'Vidor';
SELECT '------------------------------------------------------------------------';
SELECT '11. -- Hány alkalommal rendelt Sorrento pizzát Kuka?';
SELECT COUNT(Vnev) FROM Pizza
INNER JOIN Tetel 
ON Pizza.Pazon = Tetel.Pazon
INNER JOIN Rendeles
ON Rendeles.Razon = Tetel.Razon
INNER JOIN Vevo
ON Vevo.Vazon = Rendeles.Vazon
WHERE Vnev = 'Kuka'
AND Pnev = "Sorrento"; 
SELECT '------------------------------------------------------------------------';
SELECT '12. -- Hány pizzát evett Szende?';
SELECT SUM(Tetel.Db) FROM Pizza
INNER JOIN Tetel 
ON Pizza.Pazon = Tetel.Pazon
INNER JOIN Rendeles
ON Rendeles.Razon = Tetel.Razon
INNER JOIN Vevo
ON Vevo.Vazon = Rendeles.Vazon
WHERE Vnev LIKE '%Szende%'; 
SELECT '------------------------------------------------------------------------';
SELECT '13. -- Hányszor rendelt pizzát Hapci?';
SELECT COUNT(vnev) FROM Rendeles
INNER JOIN Vevo
ON Rendeles.Vazon = Vevo.Vazon
WHERE Vevo.Vnev = "Hapci";
SELECT '------------------------------------------------------------------------';
SELECT '14. -- Hány darab Hawaii pizza fogyott összesen?';
SELECT SUM(Tetel.Db), "amugy 0" FROM Pizza
INNER JOIN Tetel
ON Pizza.Pazon = Tetel.Pazon
WHERE Pizza.Pnev = "Hawaii";
SELECT '------------------------------------------------------------------------';
SELECT '15. -- Mennyit költöttek pizzára az egyes vevők?';
SELECT Vevo.Vnev,SUM(Par*Tetel.Db) FROM Pizza
INNER JOIN Tetel 
ON Pizza.Pazon = Tetel.Pazon
INNER JOIN Rendeles
ON Rendeles.Razon = Tetel.Razon
INNER JOIN Vevo
ON Vevo.Vazon = Rendeles.Vazon
GROUP BY Vnev;
SELECT '------------------------------------------------------------------------';
SELECT '16. -- Mennyit vettek az egyes vevők a különböző pizzákból?';
SELECT Vevo.Vnev,Pizza.Pnev,Tetel.Db FROM Pizza
INNER JOIN Tetel
ON Pizza.Pazon = Tetel.Pazon
INNER JOIN Rendeles
ON Tetel.Razon = Rendeles.Razon
INNER JOIN Vevo
On Rendeles.Vazon = Vevo.Vazon
GROUP BY Vnev, Pnev
ORDER by Vnev;
SELECT '------------------------------------------------------------------------';
SELECT '17. -- Ki hány pizzát szállított házhoz az egyes napokon?';
SELECT (substring(Rendeles.Idopont,0,11)),Futar.Fnev, SUM(Tetel.db) FROM Tetel
INNER JOIN Rendeles
ON Tetel.Razon = Rendeles.Razon
INNER JOIN Futar
ON Rendeles.Fazon = Futar.Fazon
GROUP BY (substring(Rendeles.Idopont,0,11)), Fnev;
SELECT '------------------------------------------------------------------------';
SELECT '18. -- Ki hány pizzát rendelt az egyes napokon?';
SELECT (substring(Rendeles.Idopont,0,11)),Vnev,SUM(Tetel.Db) FROM Vevo
INNER JOIN Rendeles
ON Rendeles.Vazon = Vevo.Vazon
INNER JOIN Tetel
ON Tetel.Razon = Rendeles.Razon
GROUP BY (substring(Rendeles.Idopont,0,11)), Vnev;
SELECT '------------------------------------------------------------------------';
SELECT '19. -- Mennyi volt a bevétel az egyes napokon?';
SELECT (substring(Rendeles.Idopont,0,11)), SUM(Pizza.Par*Tetel.Db) FROM Pizza
INNER JOIN Tetel
ON Pizza.Pazon = Tetel.Pazon
INNER JOIN Rendeles
ON Tetel.Razon = Rendeles.Razon
GROUP BY (substring(Rendeles.Idopont,0,11));
SELECT '------------------------------------------------------------------------';
SELECT '20. -- Hány pizza fogyott naponta?';
SELECT (substring(Rendeles.Idopont,0,11)), SUM(Tetel.Db) FROM Pizza
INNER JOIN Tetel
ON Pizza.Pazon = Tetel.Pazon
INNER JOIN Rendeles
ON Tetel.Razon = Rendeles.Razon
GROUP BY (substring(Rendeles.Idopont,0,11));
SELECT '------------------------------------------------------------------------';
SELECT '21. -- Mennyi pizza fogyott átlagosan naponta?';
SELECT (SUM(Tetel.Db) / (COUNT(distinct(substring(Rendeles.Idopont,0,11))) + 0.0)) FROM Pizza
INNER JOIN Tetel
ON Tetel.Pazon = Pizza.Pazon
INNER JOIN Rendeles
ON Tetel.Razon = Rendeles.Razon;;
SELECT '------------------------------------------------------------------------';
/*
	  Pizza		Futar		Vevo		Rendeles	Tetel
		-----		-----		----		--------	-----
		Pazon		Fazon		Vazon		Razon		  Razon
		Pnev		Fnev		Vnev		Vazon		  Pazon
		Par		  Ftel	  Vcim	  Fazon		    Db
					                  Idopont	
*/
SELECT '22. -- Hány pizzát rendeltek átlagosan egyszerre?';
SELECT AVG(Db) FROM Rendeles
INNER JOIN Tetel
ON Rendeles.Razon = Tetel.Razon;
SELECT '------------------------------------------------------------------------';
/*
SELECT * FROM Pizza
INNER JOIN Tetel
ON Tetel.Pazon = Pizza.Pazon
INNER JOIN Rendeles
ON Tetel.Razon = Rendeles.Razon
INNER JOIN Futar
ON Futar.Fazon = Rendeles.Fazon
INNER JOIN Vevo
ON Vevo.Vazon = Rendeles.Vazon;
*/
SELECT '23. -- Hány házhoz szállítása volt az egyes futároknak?';
SELECT (substring(Rendeles.Idopont,0,11)),Futar.Fnev,COUNT(Futar.Fnev) FROM Tetel
INNER JOIN Rendeles
ON Tetel.Razon = Rendeles.Razon
INNER JOIN Futar
ON Rendeles.Fazon = Futar.Fazon
GROUP BY Fnev;
SELECT '------------------------------------------------------------------------';
SELECT '24. -- A fogyasztás alapján mi a pizzák népszerűségi sorrendje?';
SELECT Pnev,SUM(Tetel.Db) FROM Pizza
INNER JOIN Tetel
ON Tetel.Pazon = Pizza.Pazon
GROUP BY Tetel.Db;
SELECT '------------------------------------------------------------------------';
SELECT '25. -- A rendelések összértéke alapján mi a vevők sorrendje?';
SELECT Vevo.Vnev, COUNT(Vevo.Vnev) FROM Pizza
INNER JOIN Tetel
ON Tetel.Pazon = Pizza.Pazon
INNER JOIN Rendeles
ON Rendeles.Razon = Tetel.Razon
INNER JOIN Vevo
ON Rendeles.Vazon = Vevo.Vazon
GROUP BY Vevo.Vnev
ORDER BY COUNT(Vevo.Vnev) DESC;
SELECT '------------------------------------------------------------------------';
SELECT '26. -- Melyik a legdrágább pizza?';
SELECT Pnev,MAX(Par) FROM Pizza;
SELECT '------------------------------------------------------------------------';
SELECT '27. -- Ki szállította házhoz a legtöbb pizzát?';
SELECT Futar.Fnev , SUM(Tetel.Db) FROM Futar
INNER JOIN Rendeles
ON Rendeles.Fazon = Futar.Fazon
INNER JOIN Tetel
ON Rendeles.Razon = Tetel.Razon
GROUP BY Futar.Fnev
ORDER BY SUM(Tetel.Db) DESC
LIMIT 1;
SELECT '------------------------------------------------------------------------';
SELECT '28. -- Ki ette a legtöbb pizzát?';
SELECT Vevo.Vnev, SUM(Tetel.Db) FROM Vevo
INNER JOIN Rendeles
ON Rendeles.Vazon = Vevo.Vazon
INNER JOIN Tetel
ON Rendeles.Razon = Tetel.Razon
GROUP BY Vevo.Vnev
ORDER BY SUM(Tetel.Db) DESC
LIMIT 1;
SELECT '------------------------------------------------------------------------';
SELECT '29. -- Melyik nap fogyott a legtöbb pizza?';
SELECT (substring(Rendeles.Idopont,0,11)) FROM Rendeles
INNER JOIN Tetel
ON Tetel.Razon = Rendeles.Razon
GROUP BY (substring(Rendeles.Idopont,0,11))
ORDER BY SUM(Tetel.Db) DESC 
LIMIT 1;
SELECT '------------------------------------------------------------------------';
SELECT '30. -- Melyik nap fogyott a legtöbb Hawaii pizza?';
SELECT (substring(Rendeles.Idopont,0,11)),SUM(Tetel.Db),"NEM VETTEK HAWAII PIZZAT" FROM Rendeles
INNER JOIN Tetel
ON Tetel.Razon = Rendeles.Razon
INNER JOIN Pizza
ON Pizza.Pazon = Tetel.Pazon
WHERE Pnev LIKE "%Hawaii%"; 
SELECT '------------------------------------------------------------------------';
SELECT '31. -- Hány pizza fogyott a legforgalmasabb napon?';
SELECT SUM(Tetel.Db) FROM Rendeles
INNER JOIN Tetel
ON Tetel.Razon = Rendeles.Razon
GROUP BY (substring(Rendeles.Idopont,0,11))
ORDER BY SUM(Tetel.Db) DESC 
LIMIT 1;
SELECT '------------------------------------------------------------------------';
SELECT '32. -- Mennyi volt a bevétel a legjobb napon?';
SELECT SUM(Pizza.Par)*(Tetel.Db) FROM Pizza
INNER JOIN Tetel
ON Pizza.Pazon = Tetel.Pazon
INNER JOIN Rendeles
ON Tetel.Razon = Rendeles.Razon
GROUP BY (substring(Rendeles.Idopont,0,11))
ORDER BY SUM(Pizza.Par)*(Tetel.Db) DESC
LIMIT 1;
SELECT '------------------------------------------------------------------------';
SELECT '33. -- Mi Szundi kedvenc pizzája?';
SELECT Pizza.Pnev,(substring(Rendeles.Idopont,0,11)) FROM Pizza
INNER JOIN Tetel
ON Tetel.Pazon = Pizza.Pazon
INNER JOIN Rendeles
ON Rendeles.Razon = Tetel.Razon
INNER JOIN Vevo
ON Vevo.Vazon = Rendeles.Vazon
WHERE Vevo.Vnev LIKE "%Szundi%"
GROUP BY Pnev
ORDER BY SUM(Db) DESC
LIMIT 1;
SELECT '------------------------------------------------------------------------';
SELECT '34. -- Kik rendeltek pizzát a nyitás napján?';
SELECT Vevo.Vnev FROM Pizza
INNER JOIN Tetel
ON Tetel.Pazon = Pizza.Pazon
INNER JOIN Rendeles
ON Rendeles.Razon = Tetel.Razon
INNER JOIN Vevo
ON Rendeles.Vazon = Vevo.Vazon
WHERE (substring(Rendeles.Idopont,0,11)) = "2016-10-01"
GROUP BY Idopont
ORDER BY (substring(Rendeles.Idopont,0,11));
SELECT '------------------------------------------------------------------------';
SELECT '35. -- Mely pizzák olcsóbbak a Capricciosa pizzánál?';
SELECT Pnev,Par FROM Pizza
WHERE Par < (SELECT Par FROM Pizza WHERE Pnev LIKE "%Capricciosa%");
SELECT '------------------------------------------------------------------------';
SELECT '36. -- Mely pizzák drágábbak az átlagosnál?';
SELECT Pnev FROM Pizza
WHERE Par > (SELECT AVG(Par) FROM Pizza);
SELECT '------------------------------------------------------------------------';
SELECT '37. -- Mely pizza ára van legközelebb az átlagárhoz?';
-- Top 2
SELECT Pnev,(Par)-(SELECT AVG(Par) FROM Pizza) FROM Pizza
WHERE (Par)-(SELECT AVG(Par) FROM Pizza) > 0
GROUP BY Pnev
ORDER BY (Par)-(SELECT AVG(Par) FROM Pizza)
LIMIT 2;
SELECT '------------------------------------------------------------------------';
SELECT '38. -- Mely futárok mentek többet házhoz az átlagosnál?';
SELECT Fnev,(COUNT(Futar.Fnev)/COUNT(DISTINCT Futar.Fnev)) FROM Futar
INNER JOIN Rendeles
ON Rendeles.Fazon = Futar.Fazon
GROUP BY Fnev;
SELECT '------------------------------------------------------------------------';
SELECT '39. -- Kik rendeltek legalább háromszor annyi pizzát, mint egy átlagos vevő?';
SELECT '------------------------------------------------------------------------';
SELECT '40. -- Kik szállítottak házhoz legalább tízszer?';
SELECT Fnev,COUNT(Rendeles.Fazon) FROM Futar
INNER JOIN Rendeles
ON Rendeles.Fazon = Futar.Fazon
GROUP BY Fnev
HAVING COUNT(Rendeles.Fazon) > 10;
SELECT "Nincs ilyen ember";
SELECT '------------------------------------------------------------------------';
SELECT '41. -- Mely pizzából fogyott legalább 50 db?';
SELECT Pnev FROM Pizza
INNER JOIN Tetel
ON Tetel.Pazon = Pizza.Pazon
WHERE (SELECT SUM(Db) FROM Tetel INNER JOIN Pizza ON Tetel.Pazon = Pizza.Pazon GROUP BY Pnev) > 50
GROUP BY Pnev;
SELECT "Nincs ilyen pizza";
SELECT '------------------------------------------------------------------------';
SELECT '42. -- Mely vevők nem rendeltek legalább háromszor?';
SELECT Vnev FROM Vevo
INNER JOIN Rendeles
ON Rendeles.Vazon = Vevo.Vazon
GROUP BY Vnev
HAVING COUNT(Rendeles.Vazon) < 3;
SELECT '------------------------------------------------------------------------';
SELECT '43. -- Kik rendeltek legalább 5 Hawaii pizzát?';
SELECT Vnev,COUNT(Pizza.Pnev) FROM Vevo
INNER JOIN Rendeles
ON Rendeles.Vazon = Vevo.Vazon
INNER JOIN Tetel
ON Tetel.Razon = Rendeles.Razon
INNER JOIN Pizza
ON Tetel.Pazon = Pizza.Pazon
WHERE Pnev = "Hawaii"
GROUP BY Vnev
HAVING COUNT(Pizza.Pnev) > 5;
SELECT "NEM RENDELTEK HAWAII PIZZAT";
SELECT '------------------------------------------------------------------------';
SELECT '44. -- Milyen pizzából nem rendelt soha Tudor?';
SELECT Pnev FROM Pizza
LEFT JOIN Tetel
ON Pizza.Pazon = Tetel.Pazon
LEFT JOIN Rendeles
ON Rendeles.Razon = Tetel.Razon
LEFT JOIN Vevo
ON Vevo.Vazon = Rendeles.Vazon
WHERE Pnev NOT IN (SELECT Pnev FROM Pizza LEFT JOIN Tetel
ON Pizza.Pazon = Tetel.Pazon
LEFT JOIN Rendeles
ON Rendeles.Razon = Tetel.Razon
LEFT JOIN Vevo
ON Vevo.Vazon = Rendeles.Vazon
WHERE Vevo.Vnev = "Tudor")
GROUP BY Pnev;
SELECT '------------------------------------------------------------------------';
SELECT '45. -- Van-e olyan pizza, amelyből soha nem rendeltek?';
SELECT Pnev FROM Pizza
WHERE Pnev NOT IN (SELECT Pnev FROM Pizza
INNER JOIN Tetel
ON Tetel.Pazon = Pizza.Pazon);
SELECT '------------------------------------------------------------------------';
SELECT '46. -- Ki nem rendelt soha Vesuvio pizzát?';
SELECT Vnev FROM Vevo
WHERE Vnev NOT IN (SELECT Vnev FROM Vevo
INNER JOIN Rendeles
ON Rendeles.Vazon = Vevo.Vazon
INNER JOIN Tetel
ON Rendeles.Razon = Tetel.Razon
INNER JOIN Pizza
ON Tetel.Pazon = Pizza.Pazon
WHERE Pnev = "Vesuvio"
GROUP BY Vnev);
SELECT '------------------------------------------------------------------------';
SELECT '47. -- Mely pizzafutárokkal nem találkoztak az egyes vevők?';
SELECT Fnev||" "||Vnev FROM Vevo,Futar
GROUP BY Fnev||""||Vnev
HAVING Fnev||""||Vnev NOT IN (SELECT Fnev||""||Vnev FROM Vevo
INNER JOIN Rendeles
ON Rendeles.Vazon = Vevo.Vazon
INNER JOIN Futar
ON Futar.Fazon = Rendeles.Fazon)
ORDER BY Fnev||""||Vnev;
/*
SELECT "------------";
SELECT DISTINCT  Vnev,Fnev FROM Vevo
INNER JOIN Rendeles
ON Rendeles.Vazon = Vevo.Vazon
INNER JOIN Futar
ON Futar.Fazon = Rendeles.Fazon
GROUP BY Rendeles.Razon
ORDER BY Fnev;
*/
SELECT '------------------------------------------------------------------------';
SELECT '48. -- Kik rendeltek több Sorrento pizzát, mint Vesuviot?';
SELECT Vnev FROM Vevo
INNER JOIN Rendeles
ON Rendeles.Vazon = Vevo.Vazon
INNER JOIN Tetel
ON Tetel.Razon = Rendeles.Razon
INNER JOIN Pizza
ON Pizza.Pazon = Tetel.Pazon
WHERE Pnev = "Sorrento"
GROUP BY Vnev
HAVING SUM(DB) > (SELECT SUM(DB) FROM Vevo
INNER JOIN Rendeles
ON Rendeles.Vazon = Vevo.Vazon
INNER JOIN Tetel
ON Tetel.Razon = Rendeles.Razon
INNER JOIN Pizza
ON Pizza.Pazon = Tetel.Pazon
WHERE Pnev = "Vesuvio"
GROUP BY Vnev,Pnev);
SELECT '------------------------------------------------------------------------';
/*
    Pazon	N 3	a pizza azonosítója
		Pnev	C 15	a pizza neve
		Par	N 4	a pizza ára
		Fazon	N 3	a pizzafutár azonosítója
		Fnev	C 25	a pizzafutár neve
		Ftel	C 12	a pizzafutár telefonszáma
		Vazon	N 6	a megrendelő azonosítója
		Vnev	C 30	a megrendelő neve
		Vcim	C 30	a megrendelő lakcíme
		Razon	N 8	a rendelés sorszáma
		Idopont	DT	a rendelés ideje
		Db	N 3	egy rendelési tétel darabszáma
      1      5/4     4/5       3        2
	  Pizza		Futar		Vevo		Rendeles	Tetel
		-----		-----		----		--------	-----
		Pazon		Fazon		Vazon		Razon		  Razon
		Pnev		Fnev		Vnev		Vazon		  Pazon
		Par		  Ftel	  Vcim	  Fazon		    Db
					                  Idopont	
*/
SELECT '49. -- Kik rendeltek legalább 5 Capricciosa vagy 8 Frutti di Mare pizzát?';
SELECT "Senki!";
SELECT Vnev FROM Vevo
INNER JOIN Rendeles
ON Rendeles.Vazon = Vevo.Vazon
INNER JOIN Tetel
ON Tetel.Razon = Rendeles.Razon
INNER JOIN Pizza
ON Pizza.Pazon = Tetel.Pazon
WHERE Pnev = "Capricciosa"
GROUP BY Vnev
HAVING SUM(DB) >= 5 AND (SELECT SUM(DB) FROM Tetel 
  INNER JOIN Pizza
  ON Pizza.Pazon = Tetel.Pazon
  INNER JOIN Rendeles
  ON Rendeles.Razon = Tetel.Razon
  INNER JOIN Vevo
  ON Vevo.Vazon = Rendeles.Vazon
  WHERE Pnev = "Frutti di Mare"
  GROUP BY Vnev) >= 8;
SELECT '------------------------------------------------------------------------';
SELECT '50. -- Kik rendeltek kétfajta pizzából is legalább 10 darabot?';
SELECT "Senki!";
SELECT Vnev FROM Vevo
INNER JOIN Rendeles
ON Rendeles.Vazon = Vevo.Vazon
INNER JOIN Tetel
ON Tetel.Razon = Rendeles.Razon
INNER JOIN Pizza
ON Pizza.Pazon = Tetel.Pazon
GROUP BY Vnev,pnev
HAVING COUNT(distinct Pizza.Pnev) >= 2 AND (SELECT SUM(Db) FROM Pizza
                                            INNER JOIN Tetel
                                            ON Pizza.Pazon = Tetel.Pazon 
                                            INNER JOIN Rendeles
                                            ON Tetel.Razon = Rendeles.Razon 
                                            INNER JOIN Vevo
                                            ON Rendeles.Vazon = Vevo.Vazon
                                            GROUP BY vnev,pnev
                                            order by vnev,SUM(Db)
                                            ) > 10;
/* 
SELECT "----------------nem a megoldas resze";
SELECT Vnev,COUNT(distinct Pnev) FROM Pizza
  INNER JOIN Tetel
  ON Pizza.Pazon = Tetel.Pazon
  INNER JOIN Rendeles
  ON Rendeles.Razon = Tetel.Razon
  INNER JOIN Vevo
  ON Vevo.Vazon = Rendeles.Vazon
  GROUP BY Vnev
  ORDER BY vnev;
SELECT "-------------";
SELECT Vnev,SUM(Tetel.Db)FROM Tetel 
INNER JOIN Rendeles
ON Rendeles.Razon = Tetel.Razon
INNER JOIN Vevo
ON Vevo.Vazon = Rendeles.Vazon
INNER JOIN Pizza
ON Pizza.Pazon = Tetel.Pazon
GROUP BY Vnev;
*/
/*
	  Pizza		Futar		Vevo		Rendeles	Tetel
		-----		-----		----		--------	-----
		Pazon		Fazon		Vazon		Razon		  Razon
		Pnev		Fnev		Vnev		Vazon		  Pazon
		Par		  Ftel	  Vcim	  Fazon		    Db
					                  Idopont	

*/