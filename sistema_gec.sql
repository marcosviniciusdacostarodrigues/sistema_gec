drop database if exists sistema_gec;

create database sistema_gec;

use sistema_gec;



create table tb_condominio
(
cnpj varchar(14) not null primary key,
nome varchar(80) not null
);

create table tb_portaria
(
cod_portaria varchar(2) not null,
telefone varchar(11) not null,
cnpj varchar(14) not null,
primary key (cod_portaria),
foreign key (cnpj) references tb_condominio (cnpj)
);

create table tb_porteiro
(
matricula varchar(6) not null,
nome varchar(80) not null,
cod_portaria varchar(2) not null,
primary key (matricula),
foreign key (cod_portaria) references tb_portaria (cod_portaria)
);

create table tb_recebedor
(
cpf_recebedor varchar(14) not null,
nome varchar(80) not null,
primary key (cpf_recebedor)
);

create table tb_destinatario
(
cpf_destinatario varchar(14) not null,
nome varchar(80) not null,
primary key (cpf_destinatario)
);

create table tb_entrega
(
num_entrega varchar(10) not null,
dt_entrega datetime,
cpf_do_destinatario varchar(14) null,
cpf_recebedor varchar(14) null,
cpf_destinatario varchar(14) null,
primary key (num_entrega),
foreign key (cpf_recebedor) references tb_recebedor (cpf_recebedor),
foreign key (cpf_destinatario) references tb_destinatario (cpf_destinatario)
);

create table tb_encomenda
(
cod_rastreio varchar(14) not null,
nome_destinatario varchar(80) not null,
dt_entrada datetime null,
status enum ('entregue', 'na portaria') not null default 'na portaria',
matricula varchar(6) not null,
num_entrega varchar(10) not null,
primary key (cod_rastreio),
foreign key (matricula) references tb_porteiro (matricula),
foreign key (num_entrega) references tb_entrega (num_entrega)
);

create table tb_telefone
(
id_telefone varchar(5) not null,
ddd varchar(2) not null,
numero varchar(9) not null,
cpf_destinatario varchar(14) not null,
primary key (id_telefone),
foreign key (cpf_destinatario) references tb_destinatario (cpf_destinatario)
);

create table tb_endereco
(
cod_imovel varchar(4) not null,
quadra varchar(1) not null,
conjunto varchar(1) not null,
lote varchar(3) not null,
primary key (cod_imovel)
);

create table endereco_destinatario
(
cod_imovel varchar (4) not null,
cpf_destinatario varchar (14) not null,
primary key (cod_imovel, cpf_destinatario),
foreign key (cod_imovel) references tb_endereco (cod_imovel),
foreign key (cpf_destinatario) references tb_destinatario (cpf_destinatario)
);

alter table tb_encomenda add column cod_imovel varchar(4) not null;

alter table tb_encomenda add foreign key (cod_imovel) references tb_endereco (cod_imovel);



insert into tb_condominio
(cnpj, nome) values
(12345678900000, 'Nota 10');

insert into tb_portaria
(cod_portaria, telefone, cnpj) values
(01, 61911111111, 12345678900000),
(04, 61944444444, 12345678900000);

insert into tb_porteiro
(matricula, nome, cod_portaria) values
(111111, 'Lucas', 01),
(222222, 'Ana', 01),
(333333, 'Pedro', 01),
(444444, 'Marcos', 01),
(555555, 'Maria', 01),
(666666, 'Daniela', 04),
(777777, 'Geovana', 04),
(888888, 'Bruno', 04),
(999999, 'Felipe', 04);

insert into tb_recebedor
(cpf_recebedor, nome) values
(02154685456495, 'Marcos'),
(02154685453852, 'Jonata'),
(02154685756321, 'Lucia'),
(02154685354680, 'Lucio'),
(02154685665431, 'Mariana'),
(02154685045367, 'kelly'),
(02154685775314, 'Sara'),
(02154685025463, 'Eduarda'),
(02154685002345, 'Eduardo'),
(02154685055386, 'Daniel'),
(02154685025274, 'Yago'),
(02154685000245, 'Fernando'),
(02154685405533, 'Rebeca'),
(02154685405252, 'Fernanda'),
(02154685787777, 'Bruna'),
(02154685455689, 'Vinicius');

insert into tb_destinatario
(cpf_destinatario, nome) values
(02154685442535, 'Isabela'),
(02154685442400, 'Pedro'),
(02154680555550, 'Rafael'),
(02154685425525, 'Rafaela'),
(02154685405052, 'Tais'),
(02154685425105, 'Lais'),
(02154685634232, 'Raissa'),
(02154685078788, 'Talita'),
(02154685450563, 'Gabriel'),
(02154685407899, 'Gabriela'),
(02154685453788, 'Alisson'),
(02154685450537, 'Vitoria'),
(02154685402523, 'Vitor'),
(02154685450440, 'Luciana'),
(02154685450533, 'Valma'),
(02154685485046, 'Rodrigo'),
(02154685456445, 'Artur');

insert into tb_endereco
(cod_imovel, quadra, conjunto, lote) values
(0123, 1, 'a', 01), (0122, 1, 'b', 01), (0121, 1, 'c', 01),
(0124, 1, 'a', 02), (0132, 1, 'b', 02), (0222, 1, 'c', 02),
(0125, 1, 'a', 03), (0149, 1, 'b', 03), (0322, 1, 'c', 03),
(0126, 2, 'a', 01), (0152, 2, 'b', 01), (0422, 2, 'c', 01),
(0127, 2, 'a', 02), (0662, 2, 'b', 02), (0522, 2, 'c', 02),
(0128, 2, 'a', 03), (0172, 2, 'b', 03), (0622, 2, 'c', 03),
(0129, 2, 'a', 04), (0182, 2, 'b', 04), (0722, 2, 'c', 04),
(0130, 3, 'a', 01), (0192, 3, 'b', 01), (0822, 3, 'c', 01),
(0131, 3, 'a', 02), (0202, 3, 'b', 02), (0922, 3, 'c', 02),
(0162, 3, 'a', 03), (0212, 3, 'b', 03), (0102, 3, 'c', 03),
(0134, 3, 'a', 04), (0629, 3, 'b', 04), (0100, 3, 'c', 04),
(0135, 4, 'a', 01), (0232, 4, 'b', 01), (0402, 4, 'c', 01),
(0136, 4, 'a', 02), (0242, 4, 'b', 02), (0412, 4, 'c', 02),
(0137, 4, 'a', 03), (0252, 4, 'b', 03), (0429, 4, 'c', 03),
(0138, 4, 'a', 04), (0262, 4, 'b', 04), (0432, 4, 'c', 04),
(0139, 4, 'a', 05), (0272, 4, 'b', 05), (0442, 4, 'c', 05),
(0140, 4, 'a', 06), (0282, 4, 'b', 06), (0452, 4, 'c', 06),
(0141, 4, 'a', 07), (0292, 4, 'b', 07), (0462, 4, 'c', 07),
(0142, 4, 'a', 08), (0302, 4, 'b', 08), (0472, 4, 'c', 08),
(0143, 4, 'a', 09), (0312, 4, 'b', 09), (0482, 4, 'c', 09);

insert into tb_entrega
(num_entrega, dt_entrega, cpf_do_destinatario, cpf_recebedor, cpf_destinatario) values
(0103564655, '2023-01-02', 02154685442535, 02154685456495, null),
(0103525055, '2023-01-01', 02154680555550, null, 02154680555550),
(0103054654, '2023-01-16', 02154685425525, 02154685455689, null),
(0103560545, '2023-01-14', 02154685405052, null, 02154685405052),
(0103560785, '2023-01-20', 02154685425105, null, 02154685425105),
(0103504544, '2023-01-19', 02154685634232, 02154685045367, null),
(0103560456, '2023-01-24', 02154685078788, null, 02154685078788),
(0103560453, '2023-01-28', 02154685450563, null, 02154685450563),
(0103564453, '2023-01-27', 02154685407899, null, 02154685407899),
(0103560953, '2023-01-26', 02154685407899, null, 02154685407899),
(0103564045, '2023-01-25', 02154685453788, null, 02154685453788),
(0103564055, '2023-01-16', 02154685453788, 02154685025463, null),
(0103564523, '2023-01-18', 02154685453788, null, 02154685453788),
(0103504565, '2023-01-05', 2154685402523, 02154685025463, null),
(0103564455, '2023-01-17', 02154685450440, null, 02154685450440),
(0103567865, '2023-01-22', 02154685450440, null, 02154685450440),
(0103562456, '2023-01-03', 02154685450440, 02154685405533, null),
(0103564555, '2023-01-21', 02154685456445, null, 02154685456445),
(0103564786, '2023-01-20', 02154685456445, null, 02154685456445),
(0103564865, '2023-01-10', 02154685456445, 02154685405533, null);

insert into tb_encomenda
(cod_rastreio, nome_destinatario, dt_entrada, status, matricula, num_entrega,
cod_imovel) values
('ch5e45645f4fbr', 'Rafael',  '2022-12-20', 'na portaria', 333333, 103525055,
132),
('ch5edff45kk7br', 'Rafael', '2022-11-19', 'entregue', 111111, 103560456, 322),
('ch5edff47itubr', 'Gabriel', '2022-12-22', 'entregue', 222222, 103560453, 132),
('ch5edff87ii7br', 'Raissa', '2022-11-22', 'na portaria', 222222,
103504544, 100),
('chuuuuf45f4fbr', 'Luciana', '2022-12-17', 'na portaria', 999999, 103562456,
302),
('ch2ff45f34fgbr',  'Artur', '2022-12-05', 'entregue', 999999, 103564555,
312),
('ch99hff45f4fbr', 'Artur', '2022-12-15', 'entregue', 777777, 103564786, 322),
('ch5edf5s4f4fbr', 'Isabela', '2022-12-28', 'na portaria', 777777, 103564655,
402),
('chkf56f45f4fbr', 'Artur', '2022-12-06', 'na portaria', 888888,
103564555, 412),
('chh45ff45f4fbr', 'Alisson', '2022-12-13', 'entregue', 888888, 103564523, 422),
('ch94hff45f4fbr', 'Luciana', '2022-12-12', 'na portaria', 666666, 103564455,
429),
('ch5h6hjgjt77br', 'Gabriela', '2022-12-22','na portaria', 666666, 103564453,
432),
('ch35fff45f4fbr', 'Alisson', '2022-12-11', 'entregue', 555555, 103564055, 442),
('ch99yif45f4fbr', 'Alisson', '2022-12-20', 'entregue', 444444, 103564045, 452),
('chkf5ff45f4fbr', 'Luciana', '2022-12-29', 'na portaria', 444444, 103562456,
462),
('ch85htu45f4fbr', 'Gabriela', '2022-12-21', 'na portaria', 444444, 103560953,
472),
('ch5ed87kuiuibr', 'Lais', '2022-12-15', 'entregue', 222222, 103560785,
482),
('ch5edfiii67ibr', 'Tais', '2022-12-09', 'na portaria', 222222, 103560545, 522);

insert into tb_telefone
(id_telefone, ddd, numero, cpf_destinatario) values
(07560, 61, 999845361, 2154680555550),
(07870, 61, 999845645, 2154685078788),
(07524, 61, 999845545, 2154685402523),
(07280, 61, 999844578, 2154685405052),
(07350, 61, 999847551, 2154685407899),
(07520, 61, 999845574, 2154685425105),
(07670, 61, 999845562, 2154685425525),
(07210, 61, 999847855, 2154685442400),
(07410, 61, 999856621, 2154685442535),
(07610, 61, 999845221, 2154685450440),
(07710, 61, 999845621, 2154685450533),
(07660, 61, 999847621, 2154685450537),
(07470, 61, 999888621, 2154685450563),
(07880, 61, 999856621, 2154685453788),
(07990, 61, 999843331, 2154685453788),
(07110, 61, 999847231, 2154685453788),
(07220, 61, 999842561, 2154685456445),
(07330, 61, 999845555, 2154685485046),
(07440, 61, 999845632, 2154685634232),
(07550, 61, 999847532, 2154685634232);

insert into endereco_destinatario
(cpf_destinatario, cod_imovel) values
(2154685456445, 312), (2154685453788, 442), (2154680555550, 132),
(2154685425105, 482), (2154685442535, 402), (2154680555550, 322),
(2154685450563, 132), (2154685634232, 100), (2154685405052, 522),
(2154685407899, 432), (2154685407899, 472), (2154685450440, 429),
(2154685456445, 322), (2154685453788, 452), (2154685453788, 422),
(2154685456445, 412), (2154685450440, 462), (2154685450440, 302);



select max(dt_entrada) as 'data da ultima encomenda' from tb_encomenda;

select max(dt_entrega) as 'data da ultima entrega' from tb_entrega;

select min(dt_entrada) as 'data da primeria encomeda' from tb_encomenda;

select min(dt_entrega) as 'data da primeria entrega'from tb_entrega;

select count(matricula) as 'numero de porteiros' from tb_porteiro;

select count(cpf_destinatario) as 'recebidos pelos destinatario', count(cpf_recebedor) as
'recebidos por outros' from tb_entrega;

select count(status) as 'qtd de encomendas entregues' from tb_encomenda where status
= 'entregue';

select count(status) as 'qtd de encomendas na portaria' from tb_encomenda where status
= 'na portaria';

select count(quadra) as 'qtd de imoveis na quadra 3' from tb_endereco where quadra = 3;

select avg(timestampdiff(day, enco.dt_entrada, ent.dt_entrega)) as
media_dias_ate_entrega
from tb_entrega as ent inner join tb_encomenda as enco on ent.num_entrega =
enco.num_entrega;



select num_entrega, cpf_do_destinatario, dt_entrega, cpf_destinatario as
'assinatura do destinatario', rec.cpf_recebedor as 'assinatura do recebedor', rec.nome as
'nome do recebedor' from tb_entrega as ent
inner join tb_recebedor as rec
on ent.cpf_recebedor = rec.cpf_recebedor
order by ent.dt_entrega desc;

select porte.nome as porteiros, porte.cod_portaria as portaria, porta.telefone from
tb_porteiro as porte
left join tb_portaria as porta
on porta.cod_portaria = porte.cod_portaria
where porte.cod_portaria = 4;

select por.matricula, enco.cod_rastreio, enco.dt_entrada, enco.status, enco.num_entrega
from tb_porteiro as por
right join tb_encomenda as enco on por.matricula = enco.matricula
where por.matricula = 222222
order by enco.dt_entrada desc;



select * from tb_endereco
where quadra = '4' and conjunto = 'B';
select * from tb_entrega
where cpf_do_destinatario in (2154685453788);
select nome from tb_destinatario
where nome like 'r%';
select quadra, conjunto, lote, cod_imovel from tb_endereco
where quadra = '4' or quadra = '3'
order by quadra desc;

select nome_destinatario, count(nome_destinatario) as 'qtd de encomendas por destinatario'
from tb_encomenda group by nome_destinatario;

select dt_entrada, num_entrega, nome_destinatario, cod_rastreio,
dt_entrada, status
from tb_encomenda order by dt_entrada;

select conjunto, count(conjunto) as 'qtd de casas nos conjutos C'
from tb_endereco group by conjunto having conjunto = 'c';



delimiter $$
drop procedure if exists nova_encomenda;
create procedure nova_encomenda
(
in inome_destinatario varchar(80), in icod_rastreio varchar(14),
in imatricula varchar(6),          in inum_entrega varchar(10),   
in icod_imovel varchar(4)
)
begin
      insert into tb_entrega
	  (num_entrega, dt_entrega, cpf_do_destinatario, cpf_recebedor, cpf_destinatario) 
      values (inum_entrega, null, null, null, null);
	  insert into tb_encomenda
	  (nome_destinatario, cod_rastreio, dt_entrada, matricula, num_entrega,
	  cod_imovel)
      values (inome_destinatario, icod_rastreio, now(), imatricula, inum_entrega,
      icod_imovel);
end $$
delimiter ;

call nova_encomenda ('Rafael', 'ch5e45611111br', '333333', '103511111', '132');


delimiter $$
drop trigger if exists tr_status;
create trigger tr_status after update on tb_entrega
for each row
begin
if new.cpf_recebedor is not null then
update tb_encomenda set status = 'entregue'
where num_entrega = new.num_entrega;
end if;
if new.cpf_destinatario is not null then
update tb_encomenda set status = 'entregue'
where num_entrega = new.num_entrega;
end if;
end $$
delimiter ;


delimiter $$
drop procedure if exists assinatura_destinatario $$
create procedure assinatura_destinatario
(
in icpf_destinatario varchar(14),
in inum_entrega varchar(10)
)
begin
update tb_entrega  set cpf_do_destinatario = icpf_destinatario where num_entrega = inum_entrega;
update tb_entrega  set cpf_destinatario = icpf_destinatario where num_entrega = inum_entrega;
update tb_entrega  set dt_entrega = now() where num_entrega = inum_entrega;
end $$
delimiter ;

call nova_encomenda ('Rafael', 'ch5e45622222br', '333333', '103522222', '132');

call assinatura_destinatario ('2154680555550', '103522222');


delimiter $$
drop procedure if exists assinatura_recebedor $$
create procedure assinatura_recebedor
(
in icpf_do_destinatario varchar(14), in icpf_recebedor varchar(14),
in inum_entrega varchar(10)
)
begin
update tb_entrega  set cpf_do_destinatario = icpf_do_destinatario  where num_entrega = inum_entrega;
update tb_entrega  set cpf_recebedor = icpf_recebedor where num_entrega = inum_entrega;
update tb_entrega  set dt_entrega = now() where num_entrega = inum_entrega;
end $$
delimiter ;

call nova_encomenda ('Rafael', 'ch5e45633333br', '333333', '103533333', '132');

call assinatura_recebedor ('2154680555550', '2154685002345', '103533333');


delimiter $$
drop function if exists dias_esquecida $$
create function dias_esquecida (cod varchar(14))
returns int
deterministic
begin
declare encomenda_esquecida int;
select timestampdiff( day,dt_entrada, curdate()) into encomenda_esquecida
from tb_encomenda
where status = 'na portaria'
and timestampdiff( day,dt_entrada, curdate()) >= 45 and cod_rastreio= cod;
return encomenda_esquecida;
end $$
delimiter ;

select dias_esquecida ('ch5edf5s4f4fbr');

call nova_encomenda ('Rafael', 'ch5e45644444br', '333333', '103544444', '132');
select dias_esquecida ('ch5e45644444br');


create view encomendas_quadra_4 as 
select enco.nome_destinatario, enco.dt_entrada, enco.num_entrega, quadra from tb_encomenda as enco
right join tb_endereco as ende on enco.cod_imovel = ende.cod_imovel
where quadra = '4' and num_entrega is not null;

select * from encomendas_quadra_4;


create view encomendas_entregues as 
select enco.nome_destinatario, enco.cod_rastreio, enco.num_entrega, enco.status, 
ent.cpf_recebedor as assinatura_recebedor, ent.cpf_destinatario as assinatura_destinatario, ent.dt_entrega 
from tb_encomenda as enco 
left join tb_entrega as ent on enco.num_entrega = ent.num_entrega 
where status = 'entregue';

select * from encomendas_entregues;
