
{2. Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
diciembre de 2021. De cada película se conoce: código de película, código de género (1:
acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror)
y puntaje promedio otorgado por las críticas.
Implementar un programa modularizado que:
a. Lea los datos de películas y los almacene por orden de llegada y agrupados por
código de género, en una estructura de datos adecuada. La lectura finaliza cuando se lee
el código de la película -1.
b. Una vez almacenada la información, genere un vector que guarde, para cada
género, el código de película con mayor puntaje obtenido entre todas las críticas.
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de
los dos métodos vistos en la teoría.
d. Luego de ordenar el vector, muestre el código de película con mayor puntaje y el
código de película con menor puntaje.}

program ejercicio2;
const
	df= 8;

type
	pelicula= record
	codigoPelicula	: integer;
	codigoGenero 	: integer;
	puntajePromedio	: integer;
	end;
	
	peli= record
	cod:integer;
	puntaje:integer;
	end;
	
lista=^nodo;
	nodo = record
	dato 	: pelicula;
	sig	: lista;
	end;

vector = array [1..8] of lista;
VContador = array[1..8] of peli;



//____________________________________________________
procedure Leer( var p: pelicula );
begin
	writeln('Codigo Genero 1..8 ');
	readln(p.codigoGenero);
	if (p.codigoGenero <> -1) then begin
		writeln('Codigo pelicula ');
		readln(p.codigoPelicula);
		writeln('Puntaje Promedio ');
		readln(p.puntajePromedio);
	end;
end;

procedure agregarAtras (var l, ult: lista; p: pelicula);
	var 
	nue  : lista;
	begin
		new(nue);
		nue^.dato:= p;
		nue^.sig:= nil;
		if ( l <> nil) then
			ult^.sig:= nue
		else
			l:= nue;
	ult:= nue;
	end;


//____________________________________________________

Procedure Vector_CrearVectorDeListas(var v: vector);

	//_______________INICIALIZAR_____________________________________
	procedure Vector_Inicializar (var v:vector);
	var i:integer;
	begin
	for i:=1 to DF do
	  v[i]:= nil ;
	end;
	//_________________LEER___________________________________
	procedure Leer( var p: pelicula );
	begin
		writeln('Codigo Genero 1..8 ');
		readln(p.codigoGenero);
		if (p.codigoGenero <> -1) then begin
			writeln('Codigo pelicula ');
			readln(p.codigoPelicula);
			writeln('Puntaje Promedio ');
			readln(p.puntajePromedio);
		end;
	end;
	//_________________AGREGAR A LA LISTA___________________________________
	procedure agregarAtras (var l, ult: lista; p: pelicula);
	var 
	nue  : lista;
	begin
		new(nue);
		nue^.dato:= p;
		nue^.sig:= nil;
		if ( l <> nil) then
			ult^.sig:= nue
		else
			l:= nue;
	ult:= nue;
	end;
  
 
Var p:pelicula; ult: lista;  //'ULT'  tiene punteros al ultimo elemento de cada pos del vector. en  ULT[1] hay un puntero al ultimo elemento de V[1]
Begin
  Vector_Inicializar(v);
  Leer(p);
  while(p.codigoGenero <> -1) do begin
    agregarAtras(v[p.codigoGenero],ult,p);
    Leer(p);
  end;
End;

//____________________________________________________

//____________________________________________________



	
procedure Vector_Mostrar(v:vector);
  procedure Lista_Imprimir_recursivo_PreOrden(l:lista);  //imprimir lista en orden.
  begin
    if (l<>nil) then begin
      writeln(' *  Pelicula |');
      write(' Codigo de pelicula '); writeln(l^.dato.codigoPelicula);
      write(' Puntaje '); writeln(l^.dato.puntajePromedio);
      writeln('');
      Lista_Imprimir_recursivo_PreOrden(l^.sig);
    end;
  end;
var i:integer;
begin
	for i:=1 to DF do begin
		writeln(' ///// ///// ///// ///// ///// |GENERO: ',i,'. | ///// ///// ///// ///// ///// ');
		writeln(' ');
		Lista_Imprimir_recursivo_PreOrden(v[i]);
		writeln(' <<<<<');
	end;
end;

//____________________________________________________
procedure Vector_Crear(v1:vector; var v2:VContador);
	procedure inicializar( var v2:VContador);
	var
	i:integer;
	begin
		for i := 1 to 8 do begin
			v2[i].cod:= 0;
			v2[i].puntaje:= 0;
		end;
	end;
			
	procedure calcularMax(act:pelicula; var maxPuntaje:integer; var MaxCodPelicula:integer);
	begin
		if (act.puntajePromedio > maxPuntaje) then begin
			maxCodPelicula:= act.codigoPelicula;
			maxPuntaje:=act.puntajePromedio;
		end;
	end;
	
var
	i:integer; maxPuntaje:integer; maxCodPelicula:integer; act:lista;
begin
	inicializar (v2);
      for i:=1 to DF do begin
		maxPuntaje:=-1;
		act:=v1[i];
		while(act<>nil) do begin
			calcularMax(act^.dato,maxPuntaje,MaxCodPelicula);
			act:=act^.sig;
		end;	
	v2[i].cod:= maxCodPelicula;
	v2[i].puntaje:= maxPuntaje;
	end;
end;

procedure imprimirArreglo(v : VContador);
var
  i : integer;
begin
  for i := 1 to df do begin
	writeln('____________________________________________________');
	writeln('GENERO ',i);
	writeln('codigo pelicula ',v[i].cod,' puntaje ',v[i].puntaje);
end;
end;

procedure imprimirArreglo2(v : VContador);
var
  i : integer;
begin
	writeln('ORDEN DE PUNTAJES Y CODIGOS DE PELICULA');
	
  for i := 1 to df do begin
	writeln('____________________________________________________');
	writeln('codigo pelicula ',v[i].cod,' puntaje ',v[i].puntaje);
end;
end;

Procedure Vector_Max_min(v:VContador; var codigoMin:integer; var codigoMax:integer); 
var
	i, punmax,punmin: integer;
begin
	punmax:=-1;
	punmin:= 9999;
 for i:= 1 to 8 do begin
	if (v[i].puntaje > punmax) then begin
		punmax:=v[i].puntaje;
		codigoMax:= v[i].cod;
		end;
	if (v[i].puntaje < punmin) then begin
		punmin:=v[i].puntaje;
		codigoMin:= v[i].cod;
	end;
		
		
  end;
end;



//____________________________________________________
procedure OrdenarPorInsercion( var v : VContador);
var
i,j : integer;
actual:peli;
begin
	for i:= 2 to 8 do begin
		actual:= v[i];
		j:=i-1;
		while(j >0) and (v[j].puntaje > actual.puntaje) do begin
			v[j+1]:= v[j];
			j:=j-1;
		end;
	v[j+1]:= actual;
end;

end;
//____________________________________________________
var 
v:vector;
v2:VContador;
min,max:integer;
BEGIN
	max:=0;
	min:=0;
	Vector_CrearVectorDeListas(v);
	Vector_Mostrar(v);
	Vector_Crear(v,v2);
	imprimirArreglo(v2);
	OrdenarPorInsercion(v2);
	Writeln('IMPRESION ORDENADO POR PUNTAJE');
	imprimirArreglo2(v2);
	Vector_Max_min(v2,min,max);
	writeln('____________________________________________________');
	writeln('el codigo de pelicula con mayor puntaje es ',max);
	writeln('____________________________________________________');
	writeln('el codigo de pelicula con menor puntaje es ',min);
	
END.

