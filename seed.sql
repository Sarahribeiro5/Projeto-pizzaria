CREATE DATABASE pizzaria
\c pizzaria

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(50) NOT NULL,
    tipo VARCHAR(20) DEFAULT 'comum'
);

CREATE TABLE pizzas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    PRECO DECIMAL(10,2) NOT NULL,
    ESTOQUE INTEGER DEFAULT 0
);

CREATE TABLE vendas (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    pizza_id INT REFERENCES pizzas(id),
    quantidade INT NOT NULL,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

INSERT INTO usuarios (NOME, EMAIL, SENHA, TIPO) VALUES 
('Ademir','admin@pizzaria.com', 'admin123', 'admin'),
('Seu Zé','funcionario@pizzaria.com', '123', 'comum');

INSERT INTO pizzas (NOME, PRECO, ESTOQUE) VALUES
('Margheritta' 66.50, 10),
('Pepperoni' 64.00, 15),
('Chocolate' 75.00, 12);

INSERT INTO vendas (usuario_id, pizza_id, quantidade) VALUES
(2, 1, 2),
(2, 3, 1),

UPDATE PIZZAS 
SET ESTOQUE = ESTOQUE - (
    SELECT SUM(QUANTIDADE)
    FROM VENDAS 
    WHERE VENDAS.PIZZA_ID = PIZZAS.ID
);