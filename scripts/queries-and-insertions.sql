-- escolhendo o db
use ecommerce;

-- povoando clientes

INSERT INTO clientes (Pnome, Minicial, sobrenome, endereco, tipo_cliente)
VALUES 	('João', 'A', 'Silva', 'Rua das Flores, 123', 'PF'),
		('Maria', 'S', 'Souza', 'Rua Rio Ouro Preto, 55', 'PF'),
        ('José', 'H', 'Pereira', 'Rua JK, 134', 'PF'),
        ('Claúdia', 'R', 'Ferreira', 'Rua Castelo Branco, 188', 'PF'),
        ('Lívia', 'E', 'Rocha', 'Rua São Paulo, 2499', 'PF'),
        ('Empresa', 'Ltda', 'Comércio', 'Av. Central, 456', 'PJ'),
        ('HortiFruti', NULL, 'Dois Irmãos', 'Av. Albuquerque, 1356', 'PJ'),
        ('Mercearia', NULL, 'Rezende', 'Av. Albuquerque, 2490', 'PJ');

INSERT INTO clientes_pf (CPF, cliente_id)
VALUES 	('12345678901', 1),
		('12244678900', 2),
        ('18546978100', 3),
        ('29546576502', 4),
        ('33356389313', 5);
        
INSERT INTO clientes_pj(CNPJ, razao_social, cliente_id)
VALUES 	('12345678000199', 'Comércio Central Ltda', 6),
		('13345658800130', 'Hortifruti Dois Irmãos', 7),
        ('25545667500150', 'Mercearia Rezende', 8);
        
-- povoando fornecedores

INSERT INTO fornecedores (razao_social, CNPJ)
VALUES 	('SA Alimentos', '98765432000177'),
		('Comércio Central Ltda', '12345678000199'),
        ('Higienicos Ltda', '15695432000188'),
        ('Brinquedos Playbom', '33295443000100');
        
-- povoando produtos
        
INSERT INTO produtos (prodNome, categoria, descricao, valor, fornecedor_id)
VALUES
    ('Arroz', 'Alimentos', 'Arroz branco tipo 1', 25.00, 1),
    ('Feijão', 'Alimentos', 'Feijão carioca 1kg', 8.50, 1),
    ('Macarrão', 'Alimentos', 'Macarrão espaguete 500g', 4.20, 1),
    ('Shampoo', 'Higiene', 'Shampoo anticaspa 300ml', 15.90, 3),
    ('Sabonete', 'Higiene', 'Sabonete glicerinado', 2.50, 3),
    ('Fralda Infantil', 'Higiene', 'Fralda descartável tamanho G', 35.00, 3),
    ('Bola de Futebol', 'Brinquedos', 'Bola oficial tamanho 5', 60.00, 4),
    ('Quebra-Cabeça', 'Brinquedos', 'Quebra-cabeça 500 peças', 25.00, 4),
    ('Carrinho de Controle Remoto', 'Brinquedos', 'Carrinho elétrico com controle remoto', 120.00, 4),
    ('Escova de Dente', 'Higiene', 'Escova com cerdas macias', 4.50, 3);

-- povoando pedidos

INSERT INTO pedidos (status_pedido, descricao, frete, cliente_id)
VALUES 	('Processando', 'Pedido de higiene pessoal', 5.00, 1),
		('Finalizado', 'Pedido de alimentos', 8.00, 4),
		('Processando', 'Pedido de alimentos', 8.00, 4),
        ('Processando', 'Restoque de produtos', 12.00, 8),
        ('Processando', 'Pedido de higiene pessoal', 12.00, 8),
        ('Processando', 'Pedido de brinquedos', 4.00, 2);
        
-- povoando produtos em pedidos
INSERT INTO produtos_em_pedidos (pedido_id, produto_id, quantidade, subtotal)
VALUES 	(1, 4, 2, 31.8),
		(1, 5, 10, 25.00),
        (2, 1, 1, 25.00),
        (2, 2, 1, 8.50),
        (3, 3, 4, 12.60),
        (4, 1, 15, 375.00),
        (4, 2, 25, 212.50),
		(4, 3, 35, 147.00),
        (5, 4, 15, 238.50),
        (5, 4, 50, 125.00),
        (6, 7, 2, 120.00),
        (6, 9, 1, 120.00);
        
-- povoando entregas
INSERT INTO entregas (status_entrega, codigo_rastreamento, pedido_id)
VALUES 	('Em transporte', 'TRACK12345', 1),
		('Entregue', 'TRACK12346', 2),
        ('Em espera', 'TRACK12347', 3),
        ('Em transporte', 'TRACK12348', 4),
        ('Em espera', 'TRACK12349', 5),
        ('Em espera', 'TRACK12350', 6);

-- queries

-- mostrando todos os clientes
SELECT idCliente, Pnome, sobrenome, tipo_cliente
FROM clientes;

-- mostrando todos os clientes pf
SELECT p.Pnome, p.sobrenome, pf.CPF
FROM clientes p, clientes_pf pf
WHERE p.idCliente = pf.cliente_id;

-- mostrando todos os clientes pj
SELECT p.Pnome, p.sobrenome, pj.CNPJ
FROM clientes p, clientes_pj pj
WHERE p.idCliente = pj.cliente_id;

-- listando os produtos com seus fornecedores
SELECT p.prodNome, p.categoria, p.valor, f.razao_social
FROM produtos p
JOIN fornecedores f ON p.fornecedor_id = f.idFornecedor;


-- listando pedidos e os clientes que os pediram
SELECT p.idPedido, p.descricao, p.frete, c.Pnome, c.sobrenome
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.idCliente;

-- pedidos feitos por cada cliente
SELECT c.Pnome AS Nome, 
    c.sobrenome AS Sobrenome, 
    COUNT(p.idPedido) AS Total_Pedidos
FROM clientes c
LEFT JOIN pedidos p 
ON c.idCliente = p.cliente_id
GROUP BY c.idCliente
ORDER BY Total_Pedidos DESC;


-- mostrando fornecedores que também são clientes
SELECT c.Pnome AS Nome, 
    c.sobrenome AS Sobrenome, 
    f.razao_social AS Nome_Fornecedor, 
    f.CNPJ AS CNPJ_Fornecedor
FROM clientes c
JOIN clientes_pj pj ON c.idCliente = pj.cliente_id
JOIN fornecedores f ON pj.CNPJ = f.CNPJ;

-- relação de produtos, fornecedores e estoques
SELECT p.prodNome AS Produto, 
	f.razao_social AS Fornecedor, 
    e.local_estoque AS Local_Estoque,
    pe.quantidade AS Quantidade
FROM produtos p
JOIN fornecedores f ON p.fornecedor_id = f.idFornecedor
JOIN produtos_em_estoque pe ON p.idProduto = pe.produto_id
JOIN estoques e ON pe.estoque_id = e.idEstoque;


-- relação nome dos fornecedores e nome dos produtos
SELECT f.razao_social AS Fornecedor, p.prodNome AS Produto
FROM fornecedores f
JOIN produtos p ON f.idFornecedor = p.fornecedor_id
ORDER BY f.razao_social, p.prodNome;

-- mostrando todos os brinquedos com preço acima de 50 reais
SELECT prodNome, categoria, valor 
FROM produtos
WHERE categoria = 'Brinquedos' AND valor > 50;

-- mostrando todos os fornecedores com mais de 2 produtos registrados
SELECT f.razao_social AS Fornecedor, 
    COUNT(p.idProduto) AS Total_Produtos
FROM fornecedores f
JOIN produtos p ON f.idFornecedor = p.fornecedor_id
GROUP BY f.idFornecedor
HAVING COUNT(p.idProduto) > 2;





