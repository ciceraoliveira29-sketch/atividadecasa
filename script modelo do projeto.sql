-- drop database vendas_dimensional;
create database vendas_dimensional;
 use vendas_dimensional;

create table dim_categoria(
  id bigint primary key comment 'Indentificador categoria',
  categoria varchar(200) not null comment 'nome da categoria'
 );

 -- Criando relacionamento entre a tabela fat_item e dim_categoria
alter table fat_item
	add constraint fk_item_categoria
	foreign key (idcategoria) 
    references dim_categoria(id);
    
create table dim_cliente(
id bigint primary key comment 'Indentificador cliente',
    nome_cliente varchar(200) not null,
    sexo_codigo char(1) not null,
    sexo_descricao varchar(45) not null,
    profissao varchar(200) not null,
    email varchar(400) not null,
    provedor_do_cliente varchar(45) not null,
    nascimento date not null,
    cadastro date not null,
    endereco_completo varchar(450) not null,
    cod_nacionalidade varchar(45) not null,
    nacionalidade varchar(45) not null
    );
    
    -- Criando relacionamento entre a tabela fat_item e dim_cliente    
 alter table fat_item
    add constraint fk_item_cliente 
	foreign key (idcliente) 
    references dim_cliente(id);
    
create table dim_fornecedor(
     id bigint primary key comment 'Identificador do fornecedor',
	 fornecedor varchar(200) not null comment 'nome da empresa',
	 contato varchar(200) not null comment 'Telefone do fornecedor'
    );
   
-- Criando relacionamento entre a tabela fat_item e dim_fornecedor
alter table fat_item
  add constraint fk_item_fornecedor
  foreign key (pais_fornecedor)
  references dim_fornecedor(id);

create table fat_item(
    id bigint primary key comment 'Identificador da venda',
    qtd_vendida int not null comment 'Quantidade de venda do item',
    preco_unitario_na_venda float not null comment 'preço unitario no momento da venda',
    valor_frete float default 0 comment 'Valor pago pelo frete',
    valor_desconto float default 0 comment 'Valor concedido de desconto',
    valor_comissao float default 0 comment 'Valor recebido de comissao',
	
    tempo_pedido bigint not null comment 'Data do pedido',
    tempo_de_pagamento bigint comment 'Data do pagamento',
    tempo_previsao bigint comment ' Previsao de entrega',
    tempo_de_envio bigint comment ' data de envio',
    tempo_de_entrega bigint comment 'data da entrega',
   
    idcliente bigint not null comment ' Cliente que realizou a compra',
    pais_moradia_cliente bigint comment 'Pais onde o cliente mora',
    pais_nacionalidade_cliente bigint comment 'Pais de nacionallidade',
    pais_destino bigint not null comment 'Pais de destino',
    pais_transportadora bigint not null comment 'Transportadora responsavel pela entrega',
    pais_vendedor bigint not null comment 'Vendedor responsavel pela venda',
    pais_fornecedor bigint not null comment 'Fornecedor do produto',
    
    idcategoria bigint not null comment 'Categoria do produto',
    idproduto bigint not null comment 'Produto vendido'
    );
    
alter table fat_item
modify idproduto int not null;
    
create table dim_pais(
    id bigint primary key comment 'Indentificador único pais',
    sigla char(2) not null,
    pais varchar(100) not null
    );
    
-- Criando relacionamento entre a tabela fat_item e pais_moradia_cliente e pais_nacionalidade_cliente e pais_destino  
alter table fat_item
	add constraint fk_item_moradia
	foreign key (pais_moradia_cliente) 
    references dim_pais(id);
    
alter table fat_item
	add constraint fk_item_nacionalidade
	foreign key (pais_nacionalidade_cliente) 
    references dim_pais(id);

alter table fat_item
	add constraint fk_item_destino
	foreign key (pais_destino) 
    references dim_pais(id);
 
create table dim_produto (
	id int primary key comment 'Indentificador único do item',
	produto varchar(200) not null comment 'Nome do produto',
    preco_unitario float,
    descontinuado tinyint);

-- Criando relacionamento entre a tabela fat_item e dim_produto      
alter table fat_item
	add constraint fk_item_produto
	foreign key (idproduto) 
    references dim_produto(id);
    
-- erro 3780 no relacionamento acima
    
    describe dim_produto;
    describe fat_item;
    
create table dim_tempo(
    id bigint primary key comment 'Indentificador unico e obrigátorio',
	data date not null,
	dia int not null,
    mes int not null,
	ano int not null,
	data_juliana varchar(45) not null,
	semestre int not null,
	quadrimestre int not null,
	trimestre int not null,
	bimestre int not null,
	nome_mes varchar(45) not null,
	dia_da_semana int not null,
	nome_dia_da_semana varchar(45) not null,
	semana_do_ano varchar(45) not null,
	data_string char(10) not null,
	dia_no_ano int not null,
	ultimo_dia_mes int not null,
    fim_de_semana tinyint not null
    );
    
     -- Criando relacionamento dim_tempo com acompanhamento de pedidos do cliente
    alter table fat_item
	add constraint fk_item_tempo_pedido
	foreign key (tempo_pedido) 
    references dim_tempo(id);
    
    alter table fat_item
	add constraint fk_item_tempo_pag
	foreign key (tempo_de_pagamento) 
    references dim_tempo(id);
    
    alter table fat_item
	add constraint fk_item_tempo_prev
	foreign key (tempo_previsao) 
    references dim_tempo(id);

	alter table fat_item
	add constraint fk_item_tempo_envio
	foreign key (tempo_de_envio) 
    references dim_tempo(id);

	alter table fat_item
	add constraint fk_item_tempo_entrega
	foreign key (tempo_de_entrega) 
    references dim_tempo(id);

create table dim_transportadora(
  id bigint primary key comment 'Indentificador da transportadora',
  transportadora varchar(200) not null comment 'Nome da transportadora',
  contato varchar(200) not null comment 'Tem ligação com fornecedores'
);

-- Criando relacionamento entre a tabela fat_item e dim_transportadora
 alter table fat_item
	add constraint fk_item_transportadora
	foreign key (pais_transportadora) 
    references dim_transportadora(id); 

create table dim_vendedor(
  id bigint primary key comment 'Indentificador do vendedor',
  nome varchar(200) not null comment 'Nome do vendedor',
  sexo_codigo char(1) not null comment 'M/F/N',
  sexo_descricao varchar(400) not null comment 'Descrição do sexo',
  nascimento date not null,
  contrato date not null comment 'Data do contrato',
  supervisor varchar(200) not null comment 'Nome do supervisor'
);
    
-- Criando relacionamento entre a tabela fat_item e dim_vendedor
alter table fat_item
	add constraint fk_item_vendedor
	foreign key (pais_vendedor) 
    references dim_vendedor(id);
    
    
    
    
    

    
   
    

 
 
