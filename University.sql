-- 1 Il nome e l’anno di nascita degli studenti iscritti a SBC, in ordine rispetto al nome
SELECT NomeS, AnnoN 
FROM Studenti
WHERE CorsoLaurea = "SBC"
;
-- 2 Il nome ed il Dipartimento dei docenti di “Basi di Dati e Sistemi Informativi” o di “Informatica Generale”
SELECT NomeD, Dipartimento 
FROM Docenti
JOIN Corsi ON Docenti.CodDocente =Corsi.CodDocente
;
-- 3 Matricola e nome degli studenti di un corso di laurea triennale (tipoLaurea =
-- 'L') che seguono un corso di un docente di nome Felice.
SELECT Studenti.Matricola,NomeS
FROM Studenti
JOIN CORSIDILAUREA ON Studenti.CorsoLaurea = CorsiDILaurea.CorsoLaurea
JOIN Frequenta ON Studenti.Matricola = Frequenta.Matricola 
JOIN Corsi ON Corsi.CodCorso = Frequenta.CodCorso
JOIN Docenti ON Corsi.CodDocente = Docenti.CodDocente
WHERE tipoLaurea ='L'
AND NomeD = "Felice"
;
-- 4- Per ogni tipo di laurea, il tipoLaurea e l’età media degli studenti
SELECT TipoLaurea, avg(AnnoN) AS MediaDataDiIscrizione FROM Studenti
JOIN CORSIDILAUREA ON CORSIDILAUREA.CorsoLaurea = Studenti.CorsoLaurea
group by TipoLaurea
;
-- 5 Di ogni corso di un docente di nome Leoni, il CodCorso e il numero degli studenti che lo frequentano
SELECT Corsi.CodCorso, Count(Studenti.Matricola) AS NumeroStudenti FROM Studenti
JOIN CORSIDILAUREA ON Studenti.CorsoLaurea = CorsiDILaurea.CorsoLaurea
JOIN Frequenta ON Studenti.Matricola = Frequenta.Matricola 
JOIN Corsi ON Corsi.CodCorso = Frequenta.CodCorso
JOIN Docenti ON Corsi.CodDocente = Docenti.CodDocente
WHERE  NomeD = "Leoni"
Group By CodCorso
;
-- 6 Il codice dei corsi frequentati da più di 5 studenti e tenuti da docenti del
-- Dipartimento di Informatica
SELECT Corsi.CodCorso From Corsi
JOIN Frequenta ON Corsi.CodCorso = Frequenta.CodCorso
JOIN Docenti ON Corsi.CodDocente = Docenti.CodDocente
WHERE Dipartimento = "Informatica"
GROUP BY CodCorso
Having Count(Frequenta.Matricola) >= 5
;
-- 7- Per ogni studente della Facoltà di Lettere e Filisofia, la matricola ed il numero
-- di corsi seguiti
SELECT Studenti.Matricola, Count(CodCorso) AS NumeroCorsi FROM Studenti
JOIN Frequenta ON Studenti.Matricola = Frequenta.Matricola 
WHERE (CorsoLaurea= "Lettera"
OR CorsoLaurea="Filisofia")
GROUP BY Studenti.Matricola
;
-- Nome e CodDocente dei docenti che insegnano qualche corso seguito da più
-- di 5 studenti
SELECT NomeD,Docenti.CodDocente From Docenti
JOIN Corsi ON Corsi.CodDocente = Docenti.CodDocente
JOIN Frequenta ON Corsi.CodCorso = Frequenta.CodCorso
GROUP BY Docenti.CodDocente
Having Count(Frequenta.Matricola) >= 5

--