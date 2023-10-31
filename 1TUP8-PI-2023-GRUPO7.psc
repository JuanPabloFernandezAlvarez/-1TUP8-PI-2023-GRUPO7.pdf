Algoritmo FerreteriaElTornilloLoco
	definir cantArt,articulo,i,opc,rubro ,valido, ArtEncontrado Como Entero
	definir descripcion como caracter
	//dimensionamos rubro con sus respectivos valores
	dimension rubro[5]
	rubro[1]<-100
	rubro[2]<-300
	rubro[3]<-450
	rubro[4]<-680
	rubro[5]<-720
	//pedimos al usuario que ingrese los articulos a cargar siendo 0 provocante de bucle
	Escribir "Ingrese la cantidad de articulos que desea cargar:"
    Repetir
        leer cantArt
    Hasta Que cantArt > 0
	//Dimensionamos articulo segun el numero de articulos ingresando el dato que guardan
	dimension articulo[cantArt,9]
	//descripcion requiere una dimension apartertada ya que luego se utiliza como variable independiente
	dimension descripcion[cantArt]
	Dimension ArtEncontrado[cantArt,6]
	// Comienzo del bucle principal para recorrer productos+
	Para i = 1 hasta cantArt  hacer
		Repetir
			escribir "Ingrese los 3 primeros digitos de su codigo que indican el rubro de su articulo:"
			leer articulo[i,1]
			valido = ValidacionRubro(cantArt,i,articulo,rubro)
		Hasta Que valido == 1
		Escribir "Ingrese el codigo del articulo[",i,"]:"
		Repetir
			leer articulo[i,2]
		hasta que longitud(ConvertirATexto(articulo[i,2])) == 5
		Escribir "Ingrese la descripcion[",i,"]:"
		leer descripcion[i]
		Escribir "Ingrese el precio[",i,"]:"
		leer articulo[i,3]
		
		Escribir "Ingrese el stock[",i,"]:"
		leer articulo[i,4]
		//validamos que los valores dentro de la primera quincena sean superiores a 0 y que sea mayor o igual a el stock disponible
		Repetir
			Escribir "Ingrese la cantidad vendida del articulo [", i, "] en la primera quincena"
			leer articulo[i,5]
		Hasta Que articulo[i,5] > 0 y articulo[i,5] <= articulo[i,4]
		//validamos que los valores dentro de la segunda quincena sean superiores a 0 y a la resta entre el stock y la primera quincena 
		Repetir
		Escribir "Ingrese la cantidad vendida del producto [", i, "] en la segunda quincena"
		leer articulo[i,6]
		Hasta Que articulo[i,6] > 0 y articulo[i,6] <= (articulo[i,4] - articulo[i,5])
		//representa cantidad vendida el mes completo = la primera quincena + la segunda quincena
		articulo[i,7] = articulo[i,5] + articulo[i,6]
		//representa el total ventas = cantidad vendida el mes completo * el precio del articulo
		articulo[i,8] = articulo[i,7] * articulo[i,3]
		//representa stock actualizado= cantidad de stock - cantidad vendida el mes completo
		articulo[i,9] = articulo[i,4] - articulo[i,7]
	FinPara
	//Realizamos un "menu de opciones" tal cual lo pide el enunciado.
	Escribir ".MENU DE OPCIONES."
	Escribir "1.Mostrar lista de artículos ordenada por descripción." 
	Escribir "2.Mostrar lista de artículos ordenada por cantidad vendida." .
	Escribir "3. Mostrar stock actual de artículos."
	Escribir "4. Buscar artículo por código."
	Escribir "5. Mostrar estadísticas."
	Escribir "6. Salir."
	Leer opc
	Repetir
		Segun opc Hacer
			1:
				OrdenarPorDescripcion(cantArt,i,articulo,descripcion)
			2:
				ordenarPorCantVendida(cantArt, i, articulo, descripcion)
			3:
				stockActual(cantArt, i, articulo, descripcion)
			4:
				buscarPorRubro(cantArt, i, articulo, descripcion, valido, rubro, articuloEncontrado)
			5:
				estadisticas(cantArt, articulo, rubro)
			6:
				escribir"Usted a salido del programa. Muchas gracias por utilizar nuestro sistema"
			De Otro Modo:
				Escribir "La opcion es incorrecta, ingrese un numero del 1 al 6"
		Fin Segun
	Hasta Que opc <> 6
FinAlgoritmo

Funcion valido = ValidacionRubro(cantArt,i,articulo,rubro)
	valido = 0
	si articulo[i,1] == rubro[1] o articulo[i,1] == rubro[2] o articulo[i,1] == rubro[3] o articulo[i,1] == rubro[4] o articulo[i,1] == rubro[5] Entonces
		valido = 1
	SiNo
		escribir "El codigo ingresado no es valido, vuelva a ingresar"
		Escribir "100 para el rubro: Tornillos y Tuercas"
		Escribir "300 para el rubro: Adhesivos"
		Escribir "450 para el rubro: Herrajes"
		Escribir "680 para el rubro: Pinturas"
		Escribir "720 para el rubro: Electricidad"
	FinSi
FinFuncion
SubProceso OrdenarPorDescripcion(cantArt,i,articulo,descripcion)
	definir j, temporal,m3nor Como Entero
	definir caract Como Caracter
	Para i = 1 Hasta cantArt-1 Con Paso 1 Hacer
		m3nor = i
		para j = i+1 Hasta cantArt Con Paso 1 Hacer
			si descripcion[j] <= descripcion[m3nor] Entonces
				m3nor = j
			FinSi
		FinPara
		
		temporal <- articulo[i,1]
		articulo[i,1] <- articulo[m3nor,1]
		articulo[m3nor,1] <- temporal
		temporal <- articulo[i,2]
		articulo[i,2] <- articulo[m3nor,2]
		articulo[m3nor,2] <- temporal
		
		caract <- descripcion[i]
		descripcion[i] <- descripcion[m3nor]
		descripcion[m3nor] <- caract
		
		temporal <- articulo[i,3]
		articulo[i,3] <- articulo[m3nor,3]
		articulo[m3nor,3] <- temporal
		
	FinPara
	Escribir "Lista de articulos ordenada por descripcion:"
	Para i = 1 Hasta cantArt Hacer
		Escribir "Codigo: ", Concatenar(ConvertirATexto(articulo[i,1]),ConvertirATexto(articulo[i,2]))
        Escribir "Descripcion: ", descripcion[i]
		Escribir "Precio venta: ", articulo[i,3]
    FinPara
FinSubProceso
SubProceso ordenarPorCantVendida(cantArt, i, articulo, descripcion)
	definir j, temporal, m3nor Como Entero
	definir Caract como caracter
	
	Para i = 1 Hasta cantArt-1 con paso 1 Hacer
		m3nor = i
		Para j = i+1 Hasta cantArt Con Paso 1 Hacer
			si articulo[j,7] > articulo[m3nor,7] Entonces
				m3nor = j
			FinSi
		FinPara
		
		temporal = articulo[i,1]
		articulo[i,1] = articulo[m3nor,1]
		articulo[m3nor,1] = temporal
		
		temporal = articulo[i,2]
		articulo[i,2] = articulo[m3nor,2]
		articulo[m3nor,2] = temporal
		
		Caract = descripcion[i]
		descripcion[i] = descripcion[m3nor]
		descripcion[m3nor] = Caract
		
		temporal = articulo[i,4]
		articulo[i,4] = articulo[m3nor,4]
		articulo[m3nor,4] = temporal
		
		temporal = articulo[i,7]
		articulo[i,7] = articulo[m3nor,7]
		articulo[m3nor,7] = temporal
		
		temporal = articulo[i,8]
		articulo[i,8] = articulo[m3nor,8]
		articulo[m3nor,8] = temporal
		
		temporal = articulo[i,3]
		articulo[i,3] = articulo[m3nor,3]
		articulo[m3nor,3] = temporal
	FinPara
	
	Escribir "Lista de articulos ordenada por cantidad vendida:"
    Para i = 1 Hasta cantArt Hacer
		Escribir "Codigo del articulo: ", Concatenar(ConvertirATexto(articulo[i,1]),ConvertirATexto(articulo[i,2]))
        Escribir "Descripcion del articulo: ", descripcion[i]
		Escribir "Cantidad total vendida en el mes: ", articulo[i,7]
		Escribir "Importe total venta: $", articulo[i,8]
    FinPara
FinSubProceso

SubProceso stockActual(cantArt, i, articulo, descripcion)
	para i = 1 Hasta cantArt Con Paso 1 Hacer
		Escribir "Codigo: ", Concatenar(ConvertirATexto(articulo[i,1]),ConvertirATexto(articulo[i,2]))
        Escribir "Descripcion: ", descripcion[i]
		Escribir "Stock actual: ", articulo[i,9]
	FinPara
FinSubProceso
SubProceso buscarPorRubro(cantArt, i, articulo, descripcion, valido, rubro, articuloEncontrado)
	definir j, temporal, aux Como Entero
	temporal = 0
	i = 1
	valido = 0
	Repetir
		Escribir "Ingrese los 3 primeros digitos de su codigo que indican el rubro de su articulo:"
		leer articuloEncontrado[i,1]
		valido = validacionRubro(cantArt, i, articuloEncontrado, rubro)
	Hasta Que valido == 1
	
	Para i = 1 Hasta cantArt Hacer
		si articulo[i,1] == articuloEncontrado[0,1] Entonces	
			temporal = 1
			aux = i
			Escribir "Codigo: ", Concatenar(ConvertirATexto(articulo[temporal,1]),ConvertirATexto(articulo[temporal,2]))
			Escribir "Descripcion: ", descripcion[temporal]
			Escribir "Primera quincena: ", articulo[temporal,5]
			Escribir "Segunda quincena: ", articulo[temporal,6]
			Escribir "Stock actual: ", articulo[temporal,9]
			Escribir "EL importe total vendido es: $", articulo[temporal,8]
		FinSi
	FinPara
	si temporal <> 1 Entonces
		i = cantArt - 1
		escribir "El codigo ingresado no es valido, vuelva a ingresar"
		Escribir "100 para el rubro: Tornillos y Tuercas"
		Escribir "300 para el rubro: Adhesivos"
		Escribir "450 para el rubro: Herrajes"
		Escribir "680 para el rubro: Pinturas"
		Escribir "720 para el rubro: Electricidad"
	FinSi
FinSubProceso
subProceso estadisticas(cantArt, articulo, rubro)
    Definir PorcentajeRubro como Real 
    Definir RubroVentas como Entero
    Dimension PorcentajeRubro[5,3]
	Dimension  RubroVentas[5]
    Para i = 1 Hasta 5 Hacer
        PorcentajeRubro[i,2] <- 0
        PorcentajeRubro[i,2] <- 0
        RubroVentas[i] <- 0
    FinPara
    
    TotalVentas <- 0
    
    Para i = 1 Hasta cantArt  Hacer
        rubroActual <- articulo[i,1]
        cantidadVendida <- articulo[i,7]
        precioArticulo <- articulo[i,3]
		Si articulo[i,5] > 0 Entonces 
			quincena <- 1
		Sino 
			quincena<-2 
		FinSi
			
			PorcentajeRubro[rubroActual / 100 ,quincena] <- PorcentajeRubro[rubroActual / 100 ,quincena] + cantidadVendida * precioArticulo
			RubroVentas[rubroActual / 100 ] <- RubroVentas[rubroActual / 100 ] + cantidadVendida
			
			TotalVentas <- TotalVentas + cantidadVendida
		FinPara
		
		Escribir "Porcentaje de cantidad vendida por rubro:"
		
		Para i = 1 Hasta 5 Hacer
			PorcentajeQuincena1 <- PorcentajeRubro[i,2] / TotalVentas * 100
			PorcentajeQuincena2 <- PorcentajeRubro[i,3] / TotalVentas * 100
			Escribir "Rubro ", (i + 1) * 100, ":"
			Escribir "  Quincena 1: ", redon(PorcentajeQuincena1), "%"
			Escribir "  Quincena 2: ", redon(PorcentajeQuincena2), "%"
		FinPara
		
		RubroMasVendidoQuincena1 <- RubroVentas[1]
		RubroMasVendidoQuincena2 <- RubroVentas[1]
		
		PosicionRubroMasVendido1 <- 0
		PosicionRubroMasVendido2 <- 0
		
		Para i = 1 Hasta 5 Hacer
			Si RubroVentas[i] > RubroMasVendidoQuincena1 Entonces
				RubroMasVendidoQuincena1 <- RubroVentas[i]
				PosicionRubroMasVendido1 <- i
			FinSi
			
			Si RubroVentas[i] > RubroMasVendidoQuincena2 Entonces
				RubroMasVendidoQuincena2 <- RubroVentas[i]
				PosicionRubroMasVendido2 <- i
			FinSi
		FinPara
		
		Escribir "Rubro más vendido en la quincena 1: ", RubroMasVendidoQuincena1, " rubro ", (PosicionRubroMasVendido1 + 1) * 100
		Escribir "Rubro más vendido en la quincena 2: ", RubroMasVendidoQuincena2, " rubro ", (PosicionRubroMasVendido2 + 1) * 100
FinSubProceso


