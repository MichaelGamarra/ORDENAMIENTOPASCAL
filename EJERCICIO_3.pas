{Una librería requiere el procesamiento de la información de sus productos. De cada
producto se conoce el código del producto, código de rubro (del 1 al 8) y precio.
Implementar un programa modularizado que:
a. Lea los datos de los productos y los almacene ordenados por código de producto y
agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos
finaliza cuando se lee el precio 0.
Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
b. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3.
Considerar que puede haber más o menos de 30 productos del rubro 3. Si la cantidad de
productos del rubro 3 es mayor a 30, almacenar los primeros 30 que están en la lista e
c. Ordene, por precio, los elementos del vector generado en b) utilizando alguno de
los dos métodos vistos en la teoría.
d. Muestre los precios del vector ordenado. }
program EJERCICIO3;
const
 df= 8;
 
type
	producto= record
	codigoProducto : integer;
	CodigoRubro	   : integer;
	precio		   : integer;
	end;

lista=^nodo;
	nodo = record
	dato 	: producto;
	sig	: lista;
	end;

vector = array [1..8] of lista;
vector2 = array [1..30] of producto;

//____________________________________________________
procedure Leer( var p: producto );
begin
	writeln('Ingrese Precio ');
	Readln(p.precio);
	if (p.precio <> 0)then begin
		writeln('Ingrese Rubro ');
		Readln(p.codigoRubro);
		writeln('Ingrese Codigo Producto ');
		Readln(p.codigoProducto);
		
	end;
end;
//____________________________________________________
 

//____________________________________________________
Procedure Vector_CrearVectorDeListas(var v: vector);

	//_______________INICIALIZAR_______________________________
	procedure Vector_Inicializar (var v:vector);
	var i:integer;
	begin
	for i:=1 to DF do
	  v[i]:= nil ;
	end;
	//_________________LEER___________________________________
	procedure Leer( var p: producto );
	var
	x:integer;
	begin
		randomize;
		write('Ingrese Precio  ');
		Readln(p.precio);
		if (p.precio <> 0)then begin
			x := random (9);
			if ( x > 0 ) then begin 
				p.codigoRubro := x;
				writeln('Ingrese Rubro  ',x);
				end
			else begin
				p.codigoRubro:= 3;
				writeln('Ingrese Rubro  ',3);
		end;
		p.codigoProducto:= random(9);
		writeln('Ingrese Codigo Producto  ',p.codigoProducto);
		
	end;
end;
	
	//_______________INSERTAR________________________________
	Procedure Lista_insertarOrdenado ( var l: lista ; x: producto);
	var ant, nue, act : lista ;
	begin
		new (nue);
		nue^.dato := x;
		act := l;
		ant := l;
		while (act<>L) and (act^.dato.codigoProducto < x.codigoProducto) do begin
		  ant := act;
		  act := act^.sig ;
		end;
		if (ant = act  )then 
			l:= nue 
		else  
		ant^.sig  :=nue; 
		nue^.sig := act ;
	end;	
 
Var p:producto;  
Begin
  Vector_Inicializar(v);
  Leer(p);
  while(p.precio <> 0) do begin
    Lista_InsertarOrdenado(v[p.codigoRubro],p);
    Leer(p);
  end;
End;	


//_______________________________________________
procedure Vector_Mostrar2(v:vector);
  procedure Lista_Imprimir(l:lista);  
  begin
    while(l <> nil) do begin
      writeln(' *  PRODUCTO |');
      write(' Codigo De Producto '); writeln(l^.dato.codigoProducto);
      write(' Precio '); writeln(l^.dato.precio);
      writeln('');
	l:=l^.sig;
    end;
  end;
 
var i:integer;
begin
	for i:=1 to df do begin
		writeln(' /// ///// ///// ///// ///// |RUBRO: ',i,'. | ///// ///// ///// ///// ///// ');
		writeln(' ');
		Lista_Imprimir(v[i]);
		writeln(' <<<<<');
	end;
end;

//_______________GENERAR VECTOR 2________________________________
procedure generarVector2 ( var v2 : vector2; v : vector; var dl: integer);
	procedure carga( var v2 :vector2 ; x : producto; var dl : integer );
	begin 
	dl:=dl+1;
	 v2[dl]:= x;
	 
	 end;
var
 l:lista;
begin 
	l:=v[3];
	dl:=0;
	while (l <> nil ) and (dl < 30) do begin
		carga(v2,l^.dato,dl);
		l:=l^.sig;
	end;
		
end;	

//_______________ORDENAR________________________________

procedure OrdenarPorInsercion( var v : vector2;dl:integer);
var
i,j : integer;
actual:producto;
begin
	for i:= 2 to dl do begin
		actual:= v[i];
		j:=i-1;
		while(j > 0) and (v[j].precio > actual.precio) do begin
			v[j+1]:= v[j];
			j:=j-1;
		end;
	v[j+1]:= actual;
end;

end;

//_______________IMPRIMIR________________________________
procedure imprimirVec (v2 : vector2 ; dl : integer);
var
i : integer;
begin
writeln('//////////////VECTOR 2///////////////////');
	for i:= 1 to dl do begin
		writeln('CODIGO ',v2[i].codigoProducto);
		writeln('RUBRO ',v2[i].codigoRubro);
		writeln('PRECIO ',v2[i].precio);
		
	end;
end;

//_____________________________________________________	
VAR
v:vector;
v2:vector2;
dl:integer;
BEGIN
	
Vector_CrearVectorDeListas(v);
Vector_Mostrar2(v);
generarVector2(v2,v,dl);
imprimirVec(v2,dl);
OrdenarPorInsercion(v2,dl);
imprimirVec(v2,dl);

	

end.
