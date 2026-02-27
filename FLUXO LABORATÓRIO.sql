-- ============================
-- CRIAÇÃO DAS TABELAS
-- ============================

CREATE TABLE PACIENTE (
    ID_Paciente SERIAL PRIMARY KEY,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    Data_nascimento DATE NOT NULL
);

CREATE TABLE SALA (
    ID_Sala SERIAL PRIMARY KEY,
    Numero VARCHAR(10) NOT NULL
);

CREATE TABLE TIPO_EXAME (
    ID_Exame SERIAL PRIMARY KEY,
    Nome_Exame VARCHAR(100) NOT NULL,
    Resultado TEXT
);

CREATE TABLE EXAME (
    ID_Exame SERIAL PRIMARY KEY,
    Data_Realizacao DATE NOT NULL,
    ID_Paciente INT REFERENCES PACIENTE(ID_Paciente),
    ID_Sala INT REFERENCES SALA(ID_Sala),
    ID_Tipo_Exame INT REFERENCES TIPO_EXAME(ID_Exame)
);

-- ============================
-- INSERÇÃO DE DADOS
-- ============================

INSERT INTO PACIENTE (CPF, Data_nascimento) VALUES
('12345678901', '1985-06-15'),
('98765432102', '1990-12-01'),
('45678912303', '1978-03-22');

INSERT INTO SALA (Numero) VALUES
('101'),
('102'),
('103');

INSERT INTO TIPO_EXAME (Nome_Exame, Resultado) VALUES
('Hemograma', 'Normal'),
('Raio-X', 'Fratura detectada'),
('Eletrocardiograma', 'Arritmia leve');

INSERT INTO EXAME (Data_Realizacao, ID_Paciente, ID_Sala, ID_Tipo_Exame) VALUES
('2025-11-01', 1, 1, 1),
('2025-11-02', 2, 2, 2),
('2025-11-03', 3, 3, 3);

-- ============================
-- CONSULTAS SELECT
-- ============================

-- 1. Pacientes com exames após 01/11/2025
SELECT P.CPF, E.Data_Realizacao
FROM PACIENTE P
JOIN EXAME E ON P.ID_Paciente = E.ID_Paciente
WHERE E.Data_Realizacao > '2025-11-01';

-- 2. Exames ordenados por data decrescente
SELECT ID_Exame, Data_Realizacao
FROM EXAME
ORDER BY Data_Realizacao DESC;

-- 3. Detalhes dos exames com nome do exame e número da sala
SELECT T.Nome_Exame, S.Numero, E.Data_Realizacao
FROM EXAME E
JOIN TIPO_EXAME T ON E.ID_Tipo_Exame = T.ID_Exame
JOIN SALA S ON E.ID_Sala = S.ID_Sala;

-- 4. Pacientes que realizaram exames na sala 102
SELECT P.ID_Paciente, P.CPF
FROM PACIENTE P
JOIN EXAME E ON P.ID_Paciente = E.ID_Paciente
JOIN SALA S ON E.ID_Sala = S.ID_Sala
WHERE S.Numero = '102';

-- 5. Exames mais recentes (limite de 2)
SELECT *
FROM EXAME
ORDER BY Data_Realizacao DESC
LIMIT 2;

-- ============================
-- COMANDOS UPDATE
-- ============================

UPDATE TIPO_EXAME SET Resultado = 'Alterado' WHERE ID_Exame = 1;
UPDATE TIPO_EXAME SET Resultado = 'Sem alterações' WHERE Nome_Exame = 'Eletrocardiograma';
UPDATE PACIENTE SET CPF = '11122233344' WHERE ID_Paciente = 3;

-- ============================
-- COMANDOS DELETE
-- ============================

DELETE FROM EXAME WHERE Data_Realizacao < '2025-11-01';
DELETE FROM PACIENTE WHERE CPF = '98765432101';
DELETE FROM SALA WHERE Numero = '101';