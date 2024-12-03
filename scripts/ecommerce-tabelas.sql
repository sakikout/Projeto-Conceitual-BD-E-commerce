-- criando banco de dados para cenário e-commerce

drop database ecommerce;

create database ecommerce;
use ecommerce;

-- criar tabela clientes
create table clientes(
	idCliente int auto_increment primary key,
    Pnome varchar(10),
    Minicial varchar(3),
    sobrenome varchar(20),
    endereco varchar(255),
    tipo_cliente varchar(3)
);

desc clientes;

alter table clientes auto_increment=1;

-- criar tabela clientes pj
create table clientes_pj(
	CNPJ varchar(15),
    razao_social varchar(45),
	cliente_id int,
    
    constraint unique_cnpj_client unique(CNPJ),
    constraint fk_cliente_pj_id foreign key (cliente_id) references clientes (idCliente)

);

-- criar tabelas cliente pf
create table clientes_pf(
	CPF varchar(11),
	cliente_id int,
    
    constraint unique_cpf_client unique(CPF),
    constraint fk_cliente_pf_id foreign key (cliente_id) references clientes (idCliente)

);

-- criar tabela tipo de pagamento

create table tipo_pagamento(
	idPagamento int auto_increment primary key,
    tipo_pagamento enum('Crédito','Débito', 'Pix', 'Dinheiro') not null,
    detalhes varchar(100),
    cliente_id int,
    
     constraint fk_cliente_pag_id foreign key (cliente_id) references clientes (idCliente)

);

-- criar tabela fornecedores

create table fornecedores(
idFornecedor int auto_increment primary key,
razao_social varchar(45),
CNPJ varchar(15),

 constraint unique_cnpj_fornecedor unique(CNPJ)
);

-- criar tabela de estoque

create table estoques(
	idEstoque int auto_increment primary key,
    local_estoque varchar(45)

);

-- criar tabela produtos
create table produtos(
	idProduto int auto_increment primary key,
    prodNome varchar(20),
	categoria enum('Alimentos', 'Materiais','Carnes', 'Brinquedos', 'Cosméticos', 'Higiene') not null,
    descricao varchar(45),
    valor double,
    fornecedor_id int,
    
    constraint fk_fornecedor_id foreign key (fornecedor_id) references fornecedores (idFornecedor)
    
);


-- criar tabela pedidos

create table pedidos (
	idPedido int auto_increment primary key,
    status_pedido varchar(45),
    descricao varchar(45),
    frete float,
    cliente_id int,
    
     constraint fk_cliente_pedidos_id foreign key (cliente_id) references clientes (idCliente)

);

-- criar tabela relação de pedidos e produtos

create table produtos_em_pedidos(
	pedido_id int,
    produto_id int,
    quantidade int,
    subtotal float,
    
	constraint fk_produto_id foreign key (produto_id) references produtos (idProduto),
	constraint fk_pedido_id foreign key (pedido_id) references pedidos (idPedido)

);

-- criar tabela de produtos em estoques

create table produtos_em_estoque(
	estoque_id int,
    produto_id int,
    quantidade int,
    
    constraint fk_pd_estoque_id foreign key (estoque_id) references estoques (idEstoque),
	constraint fk_pd_produto_id foreign key (produto_id) references produtos (idProduto)
);

-- criar tabela de entregas

create table entregas(
	idEntrega int auto_increment primary key,
    status_entrega varchar(45),
    codigo_rastreamento varchar(20),
    pedido_id int,
    
    constraint fk_pedido_entregas_id foreign key (pedido_id) references pedidos (idPedido)
);

show tables;