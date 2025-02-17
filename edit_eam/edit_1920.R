source("./edit_eam/eam_1920.R")
source("./edit_eam/dependencies.R")

### Data cleaning

readEDIT2("1920.csv$")

edit1920 <- simplify(edit_1920.csv, varNamesEDIT)
edit1920 <- edit1920[-2,]

edit <- edit1920

mergeCriteriaEDIT <- c("NORDEMP")
edit <- inner_join(edit, main1920, by = mergeCriteriaEDIT)

### Mutates

## Tipo de innovacion
# Numericas

edit$I1R4C2[is.na(edit$I1R4C2)] <- 0
edit <- edit %>% mutate(innProceso = I1R4C2) # numero de procesos

edit$I1R6C2[is.na(edit$I1R6C2)] <- 0
edit <- edit %>% mutate(innProducto = I1R6C2) # numero de productos

edit$I1R5C2[is.na(edit$I1R5C2)] <- 0
edit <- edit %>% mutate(innOrganizacional = I1R5C2) # numero de organizacionales

## Impacto de la innovacion
# Dummys

edit$I2R1C1[is.na(edit$I2R1C1)] <- 3
edit <- edit %>% mutate(mejoraBS = ifelse(I2R1C1 != 3, 1, 0)) #1 = Hay mejoras B/S

edit$I2R2C1[is.na(edit$I2R2C1)] <- 3
edit <- edit %>% mutate(aumentaBS = ifelse(I2R2C1 != 3, 1, 0)) #1 = Aumenta gama B/S

edit$I2R3C1[is.na(edit$I2R3C1)] <- 3
edit$I2R4C1[is.na(edit$I2R4C1)] <- 3
edit <- edit %>% mutate(mantienePosicion = ifelse(I2R3C1 != 3 | I2R4C1 != 3, 1, 0)) #1 = Le ayuda a mantener posicion de mercado

edit$I2R5C1[is.na(edit$I2R5C1)] <- 3
edit <- edit %>% mutate(aumentaProductividad = ifelse(I2R5C1 !=3, 1, 0)) #1 = Le aumento la productividad

edit$I2R6C1[is.na(edit$I2R6C1)] <- 3
edit$I2R7C1[is.na(edit$I2R7C1)] <- 3
edit$I2R8C1[is.na(edit$I2R8C1)] <- 3
edit$I2R9C1[is.na(edit$I2R9C1)] <- 3
edit <- edit %>% mutate(reduceCostoFactores = ifelse(I2R6C1 != 3 | I2R7C1 != 3 | I2R8C1 != 3 | I2R9C1 != 3, 1, 0)) #1 = Reduce costo de factores

edit$I2R10C1[is.na(edit$I2R10C1)] <- 3
edit$I2R11C1[is.na(edit$I2R11C1)] <- 3
edit$I2R12C1[is.na(edit$I2R12C1)] <- 3
edit <- edit %>% mutate(reduceCostoLogistico = ifelse(I2R10C1 != 3 | I2R11C1 != 3 | I2R12C1 != 3, 1, 0)) #1 = Reduce costos transporte/com/reparacion

edit$I2R13C1[is.na(edit$I2R13C1)] <- 3
edit$I2R14C1[is.na(edit$I2R14C1)] <- 3
edit$I2R15C1[is.na(edit$I2R15C1)] <- 3
edit <- edit %>% mutate(reduceCostoOtros = ifelse(I2R13C1 != 3 | I2R14C1 != 3 | I2R15C1 != 3, 1, 0)) #1 = Reduce otros costos (regulaciones, reciclaje, impuestos)

## Taxonomia de la innovacion
# Numeric

edit$I1R4C2N[is.na(edit$I1R4C2N)] <- 0
edit <- edit %>% mutate(innRadical = I1R4C2N) # numero de radicales

edit$I1R4C2M[is.na(edit$I1R4C2M)] <- 0
edit <- edit %>% mutate(innIncremental = I1R4C2M) # numero de incrementales

## Tipo de empresa innovadora
# Dummys

edit <- edit %>% mutate(innovadorAmplio = ifelse(TIPOLO == "AMPLIA", 1, 0)) #1 = Innovador amplio
edit <- edit %>% mutate(noInnovadora = ifelse(TIPOLO == "NOINNO", 1, 0)) #1 = No innovadora
edit <- edit %>% mutate(innovadorEstricto = ifelse(TIPOLO == "ESTRIC", 1, 0)) #1 = Innovador estricto
edit <- edit %>% mutate(innovadorPotencial = ifelse(TIPOLO == "POTENC", 1, 0)) #1 = Innovador potencial
edit <- edit %>% mutate(otroTipo = ifelse(innovadorAmplio + noInnovadora + innovadorEstricto + innovadorPotencial == 0, 1, 0)) #1 = Otro tipo

## Uso de TICs
# Dummy

edit$II1R4C1[is.na(edit$II1R4C1)] <- 0
edit$II1R4C2[is.na(edit$II1R4C2)] <- 0
edit <- edit %>% mutate(usaTICs = ifelse(II1R4C1 > 0 | II1R4C2 > 0, 1,0)) #1 = Gasta en TICs

## Networking de innovacion
# Dummys

edit$V3R3C1[is.na(edit$V3R3C1)] <- 0
edit$V3R5C1[is.na(edit$V3R5C1)] <- 0
edit$V3R6C1[is.na(edit$V3R6C1)] <- 0
edit$V3R7C1[is.na(edit$V3R7C1)] <- 0
edit$V3R8C1[is.na(edit$V3R8C1)] <- 0
edit$V3R9C1[is.na(edit$V3R9C1)] <- 0
edit$V3R10C1[is.na(edit$V3R10C1)] <- 0
edit$V3R11C1[is.na(edit$V3R11C1)] <- 0
edit$V3R12C1[is.na(edit$V3R12C1)] <- 0

edit <- edit %>% mutate(networkNoEmpresa = ifelse(V3R3C1 == 1 | V3R5C1 == 1 | V3R6C1 == 1 | V3R7C1 == 1 | V3R8C1 == 1 | V3R9C1 == 1 | V3R10C1 == 1 | V3R11C1 == 1 | V3R12C1 == 1, 1, 0)) #1 = Hizo networking con no-empresas

edit$V3R1C1[is.na(edit$V3R1C1)] <- 0
edit$V3R2C1[is.na(edit$V3R2C1)] <- 0
edit$V3R4C1[is.na(edit$V3R4C1)] <- 0

edit <- edit %>% mutate(networkEmpresas = ifelse(V3R1C1 == 1| V3R4C1 == 1 | V3R2C1 == 1, 1, 0)) #1 = Hizo networking con empresas

edit$V3R1C8[is.na(edit$V3R1C8)] <- 0
edit$V3R2C8[is.na(edit$V3R2C8)] <- 0
edit$V3R4C8[is.na(edit$V3R4C8)] <- 0

edit <- edit %>% mutate(modificaOtros = ifelse(V3R4C8 == 1 | V3R2C8 == 1 | V3R1C8 == 1, 1, 0)) #1 = Modificaciones de otras empresas

edit <- edit %>% mutate(sinNetwork = ifelse(modificaOtros + networkEmpresas + networkNoEmpresa == 0, 1, 0)) #1 = No hay networking (Innova solo la empresa)

# Cuando hagas dicc revisa las organizaciones de cada coso

## Propiedad de la empresa
# Dummy

edit <- edit %>% mutate(propietarioActual = VIII1R1C1) # 1 = Fundador; 2 = Familiar del fundador; 3 = Otro

## Personal ocupado
# Numerics + Categories

edit <- edit %>% mutate(totOcupados2019 = IV1R11C1)
edit <- edit %>% mutate(totOcupados2020 = IV1R11C2)

edit <- edit %>% mutate(catOcupados2019 = ifelse(IV1R11C1 <= 10, 1, 
    ifelse(IV1R11C1 > 10 & IV1R11C1 <= 50, 2,
    ifelse(IV1R11C1 > 50 & IV1R11C1 <= 200, 3, 
    ifelse(IV1R11C1 > 200, 4, 0))))
) # 1 = Menos de 10. 2 = Entre 10 y 50. 3 = Entre 50 y 200. 4 = Mas de 200 

edit <- edit %>% mutate(catOcupados2020 = ifelse(IV1R11C2 <= 10, 1, 
    ifelse(IV1R11C2 > 10 & IV1R11C2 <= 50, 2,
    ifelse(IV1R11C2 > 50 & IV1R11C2 <= 200, 3, 
    ifelse(IV1R11C2 > 200, 4, 0))))
) # 1 = Menos de 10. 2 = Entre 10 y 50. 3 = Entre 50 y 200. 4 = Mas de 200 

## CIIU
# Categories, pero numericas

edit <- edit %>% mutate(ciiu4Digitos = CIIU4)

## Personal en ACTI
# Numerics

edit$IV1R11C3[is.na(edit$IV1R11C3)] <- 0
edit$IV1R11C4[is.na(edit$IV1R11C4)] <- 0

edit <- edit %>% mutate(ocupadosACTI2019 = IV1R11C3)
edit <- edit %>% mutate(ocupadosACTI2020 = IV1R11C4)

edit <- edit %>% mutate(ratioActi2019 = ocupadosACTI2019/totOcupados2019)
edit <- edit %>% mutate(ratioActi2020 = ocupadosACTI2020/totOcupados2020)

edit[isNaN(edit)] <- 0

## Capital humano educacion
# Numerics

edit$IV1R7C1[is.na(edit$IV1R7C1)] <- 0
edit$IV1R8C1[is.na(edit$IV1R8C1)] <- 0

edit$IV1R7C2[is.na(edit$IV1R7C2)] <- 0
edit$IV1R8C2[is.na(edit$IV1R8C2)] <- 0

edit <- edit %>% mutate(educadosColegio2019 = IV1R7C1 + IV1R8C1)
edit <- edit %>% mutate(educadosColegio2020 = IV1R7C2 + IV1R8C2)

edit$IV1R4C1[is.na(edit$IV1R4C1)] <- 0
edit$IV1R5C1[is.na(edit$IV1R5C1)] <- 0
edit$IV1R6C1[is.na(edit$IV1R6C1)] <- 0
edit$IV1R9C1[is.na(edit$IV1R9C1)] <- 0

edit$IV1R4C2[is.na(edit$IV1R4C2)] <- 0
edit$IV1R5C2[is.na(edit$IV1R5C2)] <- 0
edit$IV1R6C2[is.na(edit$IV1R6C2)] <- 0
edit$IV1R9C2[is.na(edit$IV1R9C2)] <- 0

edit <- edit %>% mutate(educadosSuperior2019 = IV1R4C1 + IV1R5C1 + IV1R6C1 + IV1R9C1)
edit <- edit %>% mutate(educadosSuperior2020 = IV1R4C2 + IV1R5C2 + IV1R6C2 + IV1R9C2)

edit$IV1R1C1[is.na(edit$IV1R1C1)] <- 0
edit$IV1R2C1[is.na(edit$IV1R2C1)] <- 0
edit$IV1R3C1[is.na(edit$IV1R3C1)] <- 0

edit$IV1R1C2[is.na(edit$IV1R1C2)] <- 0
edit$IV1R2C2[is.na(edit$IV1R2C2)] <- 0
edit$IV1R3C2[is.na(edit$IV1R3C2)] <- 0

edit <- edit %>% mutate(educadosPosgrado2019 = IV1R1C1 + IV1R2C1 + IV1R3C1)
edit <- edit %>% mutate(educadosPosgrado2020 = IV1R1C2 + IV1R2C2 + IV1R3C2)

edit$IV1R10C1[is.na(edit$IV1R10C1)] <- 0
edit$IV1R10C2[is.na(edit$IV1R10C2)] <- 0

edit <- edit %>% mutate(educadosOtro2019 = IV1R10C1)
edit <- edit %>% mutate(educadosOtro2020 = IV1R10C2)

## Ratio de ocupacion del capital humano
# Numerics
# Nota: la encuesta solo tiene ratios para 2020

edit$IV4R4C3[is.na(edit$IV4R4C3)] <- 0

edit <- edit %>% mutate(ocupadosProduccion = IV4R4C3)
edit <- edit %>% mutate(ratioProduccion = ocupadosProduccion/totOcupados2020)

edit$IV4R11C3[is.na(edit$IV4R11C3)] <- 0

edit <- edit %>% mutate(ocupadosID = IV4R11C3)
edit <- edit %>% mutate(ratioID = ocupadosID/totOcupados2020)

edit$IV4R1C3[is.na(edit$IV4R1C3)] <- 0
edit$IV4R2C3[is.na(edit$IV4R2C3)] <- 0
edit$IV4R5C3[is.na(edit$IV4R5C3)] <- 0

edit <- edit %>% mutate(ocupadosAdmin = IV4R1C3 + IV4R2C3 + IV4R5C3)
edit <- edit %>% mutate(ratioAdmin = ocupadosAdmin/totOcupados2020)

edit$IV4R3C3[is.na(edit$IV4R3C3)] <- 0
edit <- edit %>% mutate(ocupadosMarketing = IV4R3C3)
edit <- edit %>% mutate(ratioMarketing = ocupadosMarketing/totOcupados2020)

edit[isNaN(edit)] <- 0

## Genero de ocupados
# Dummy

edit$IV4R11C2[is.na(edit$IV4R11C2)] <- 0
edit <- edit %>% mutate(hayMujeres = ifelse(IV4R11C2 > 0, 1 ,0)) #1= Hay mujeres involucradas en ACTI

## Fuentes de financiamiento
# Numerics, miles de pesos

edit$III1R1C1[is.na(edit$III1R1C1)] <- 0
edit$III1R1C2[is.na(edit$III1R1C2)] <- 0

edit <- edit %>% mutate(recursosPropio2019 = III1R1C1)
edit <- edit %>% mutate(recursosPropio2020 = III1R1C2)

edit$III1R4C1[is.na(edit$III1R4C1)] <- 0
edit$III1R4C2[is.na(edit$III1R4C2)] <- 0
edit$III1R4C3[is.na(edit$III1R4C3)] <- 0
edit$III1R4C4[is.na(edit$III1R4C4)] <- 0

edit <- edit %>% mutate(recursosBanca2019 = III1R4C1 + III1R4C2)
edit <- edit %>% mutate(recursosBanca2020 = III1R4C3 + III1R4C4)

edit$III1R2C1[is.na(edit$III1R2C1)] <- 0
edit$III1R2C2[is.na(edit$III1R2C2)] <- 0

edit <- edit %>% mutate(recursosConglomerado2019 = III1R2C1)
edit <- edit %>% mutate(recursosConglomerado2020 = III1R2C2)

edit$III1R3C1[is.na(edit$III1R3C1)] <- 0
edit$III1R3C2[is.na(edit$III1R3C2)] <- 0

edit <- edit %>% mutate(recursosPublicos2019 = III1R3C1)
edit <- edit %>% mutate(recursosPublicos2020 = III1R3C2)

edit$III1R5C1[is.na(edit$III1R5C1)] <- 0
edit$III1R5C2[is.na(edit$III1R5C2)] <- 0
edit$III1R5C3[is.na(edit$III1R5C3)] <- 0
edit$III1R5C4[is.na(edit$III1R5C4)] <- 0

edit <- edit %>% mutate(recursosEmpresas2019 = III1R5C1 + III1R5C2)
edit <- edit %>% mutate(recursosEmpresas2020 = III1R5C3 + III1R5C4)

edit$III1R6C1[is.na(edit$III1R6C1)] <- 0
edit$III1R6C2[is.na(edit$III1R6C2)] <- 0
edit$III1R6C3[is.na(edit$III1R6C3)] <- 0
edit$III1R6C4[is.na(edit$III1R6C4)] <- 0

edit$III1R7C1[is.na(edit$III1R7C1)] <- 0
edit$III1R7C2[is.na(edit$III1R7C2)] <- 0
edit$III1R7C3[is.na(edit$III1R7C3)] <- 0
edit$III1R7C4[is.na(edit$III1R7C4)] <- 0

edit <- edit %>% mutate(recursosOtros2019 = III1R6C1 + III1R6C2  + III1R7C1 + III1R7C2)
edit <- edit %>% mutate(recursosOtros2020 = III1R6C3 + III1R6C4  + III1R7C3 + III1R7C4)

## Contrato con el estado
# Dummy

edit$I8R1C1[is.na(edit$I8R1C1)] <- 2
edit <- edit %>% mutate(contratoEstado = ifelse(I8R1C1 == 1, 1, 0)) #1= Si contrato con el estado

## Sistemas nacionales de innovacion
# Dummys

edit$V2R2C1[is.na(edit$V2R2C1)] <- 2
edit <- edit %>% mutate(sniSENA = ifelse(V2R2C1 == 1, 1,0)) #1 = Coopero con SENA

edit$V2R15C1[is.na(edit$V2R15C1 == 1)] <- 2
edit <- edit %>% mutate(sniCamaraComercio = ifelse(V2R15C1 == 1, 1,0)) #1 = Coopero con Camara de Comercio

edit$V2R3C1[is.na(edit$V2R3C1)] <- 2
edit <- edit %>% mutate(sniICONTEC = ifelse(V2R3C1 == 1, 1,0)) #1 = Coopero con ICONTEC

edit$V2R7C1[is.na(edit$V2R7C1)] <- 2
edit <- edit %>% mutate(sniUnivSNCTI = ifelse(V2R7C1 == 1, 1,0)) #1 = Coopero con Universidad del SNCTI

edit$V2R4C1[is.na(edit$V2R4C1)] <- 2
edit <- edit %>% mutate(sniSIC = ifelse(V2R4C1 == 1, 1,0)) #1 = Coopero con SicSuper

edit$V2R1C1[is.na(edit$V2R1C1)] <- 2
edit <- edit %>% mutate(sniMinciencias = ifelse(V2R1C1 == 1, 1,0)) #1 = Coopero con Minciencias

edit$V3R5C1[is.na(edit$V3R5C1)] <- 2
edit <- edit %>% mutate(sniConsultores = ifelse(V3R5C1 == 1, 1,0)) #1 = Coopero con consultores

edit$V2R17C1[is.na(edit$V2R17C1)] <- 2
edit <- edit %>% mutate(sniProcolombia = ifelse(V2R17C1 == 1, 1,0)) #1 = Coopero con procolombia

edit$III2R1C1[is.na(edit$III2R1C1)] <- 0
edit$III2R1C2[is.na(edit$III2R1C2)] <- 0
edit <- edit %>% mutate(sniINNPulsa = ifelse(III2R1C1 > 0 | III2R1C2 > 0, 1,0)) #1 = Coopero con INNpulsa

## Incentivos a la productividad
## Dummys
# Solo hay 2018

edit$VIII14R5C1[is.na(edit$VIII14R5C1)] <- 2
edit <- edit %>% mutate(bonosGerenciales = ifelse(VIII14R5C1 == 1, 0, 1)) #1 = Usa Bonos Gerenciales como incentivo

edit$VIII12R5C1[is.na(edit$VIII12R5C1)] <- 2
edit <- edit %>% mutate(bonosNoGerenciales = ifelse(VIII12R5C1 == 1, 0, 1)) #1 = Usa Bonos no Gerenciales como incentivo

edit$VIII17R1C1[is.na(edit$VIII17R1C1)] <- 4
edit <- edit %>% mutate(ascensosGerenciales = ifelse(VIII17R1C1 == 4, 0, 1)) #1 = Hay ascensos gerenciales

edit$VIII16R1C1[is.na(edit$VIII16R1C1)] <- 4
edit <- edit %>% mutate(ascensosNoGerenciales = ifelse(VIII16R1C1 == 4, 0, 1)) #1 = Hay ascensos no gerenciales

edit$VIII9R1C1[is.na(edit$VIII9R1C1)] <- 4
edit <- edit %>% mutate(metasProduccion = ifelse(VIII9R1C1 == 4, 0, 1)) #1 = Hay metas de produccion

edit$VIII5R1C1[is.na(edit$VIII5R1C1)] <- 5
edit <- edit %>% mutate(indicadoresDesemp = ifelse(VIII5R1C1 == 5, 0, 1)) #1 = Hay metas de produccion

## Obstaculo recursos
# Dummys

edit$I10R1C1[is.na(edit$I10R1C1)] <- 3
edit <- edit %>% mutate(obsRecursosPropios = ifelse(I10R1C1 == 3, 0, 1)) #1 = Tuvo obstaculos por escases de recursos propios

edit$I10R10C1[is.na(edit$I10R10C1)] <- 3
edit <- edit %>% mutate(obsFinancExterno = ifelse(I10R10C1 == 3, 0, 1)) #1 = Tuvo obstaculos por financiamiento externo

## Obstaculos legales/personal
# Dummys

edit$I10R6C1[is.na(edit$I10R6C1)] <- 3
edit <- edit %>% mutate(obsApoyoPublico = ifelse(I10R6C1 == 3, 0, 1)) #1 = Tuvo obstaculo por falta de informacion apoyo/instrumentos publicos

edit$I10R4C1[is.na(edit$I10R4C1)] <- 3
edit$I10R5C1[is.na(edit$I10R5C1)] <- 3
edit <- edit %>% mutate(obsInformacion = ifelse(I10R4C1 == 3 | I10R5C1 == 3, 0, 1)) #1 = Tuvo obstaculo por falta de informacion de mercados o tecnologias

edit$I10R2C1[is.na(edit$I10R2C1)] <- 3
edit <- edit %>% mutate(obsPersonal = ifelse(I10R2C1 == 3, 0, 1)) #1 = Tuvo obstaculo por falta de personal calificado

edit$I10R3C1[is.na(edit$I10R3C1)] <- 3
edit <- edit %>% mutate(obsRegulaciones = ifelse(I10R3C1 == 3, 0, 1)) #1 = Tuvo obstaculo por incumplir regulaciones

edit$I10R11C1[is.na(edit$I10R11C1)] <- 3
edit <- edit %>% mutate(obsCooperacion = ifelse(I10R11C1 == 3, 0, 1)) #1 = Tuvo obstaculo por no poder cooperar con empresas

edit$I10R13C1[is.na(edit$I10R13C1)] <- 3
edit <- edit %>% mutate(obsDerechosProp = ifelse(I10R13C1 == 3, 0, 1)) #1 = Tuvo obstaculo por insuficiencia en el sistema de propiedad intelectual

edit$I10R14C1[is.na(edit$I10R14C1)] <- 3
edit <- edit %>% mutate(obsInspeccion = ifelse(I10R14C1 == 3, 0, 1)) #1 = Tuvo obstaculo por ausencia de servicios de inspeccion

edit$III4R4C1[is.na(edit$III4R4C1)] <- 3
edit <- edit %>% mutate(obsTramite = ifelse(III4R4C1 == 3, 0, 1)) #1 = Tuvo obstaculo por tramites excesivos

edit$III4R6C1[is.na(edit$III4R6C1)] <- 3
edit <- edit %>% mutate(obsIntermediacion = ifelse(III4R6C1 == 3, 0, 1)) #1 = Tuvo obstaculo por intermediacion financiera

edit$III4R3C1[is.na(edit$III4R3C1)] <- 3
edit <- edit %>% mutate(obsRequisitos = ifelse(III4R3C1 == 3, 0, 1)) #1 = Tuvo obstaculo por cumplimiento de requisitos

edit$III4R5C1[is.na(edit$III4R5C1)] <- 3
edit <- edit %>% mutate(obsFinAtractiva = ifelse(III4R5C1 == 3, 0, 1)) #1 = Tuvo obstaculo por financiacion poco atractiva

## Obstaculos incertidumbre
# Dummys

edit$I10R7C1[is.na(edit$I10R7C1)] <- 3
edit <- edit %>% mutate(obsDemanda = ifelse(I10R7C1 == 3, 0, 1)) #1 = Tuvo obstaculo por incertidumbre frente a la demanda del B/S innovador

edit$I10R8C1[is.na(edit$I10R8C1)] <- 3
edit <- edit %>% mutate(obsTecnica = ifelse(I10R8C1 == 3, 0, 1)) #1 = Tuvo obstaculo por incertidumbre frente al exito en la ejecucion tecnica

edit$I10R12C1[is.na(edit$I10R12C1)] <- 3
edit <- edit %>% mutate(obsImitacion = ifelse(I10R12C1 == 3, 0, 1)) #1 = Tuvo obstaculo por incertidumbre a potenciales imitaciones

edit$I10R9C1[is.na(edit$I10R9C1)] <- 3
edit <- edit %>% mutate(obsRentabilidad = ifelse(I10R9C1 == 3, 0, 1)) #1 = Tuvo obstaculo por incertidumbre a la rentabilidad del proyecto

## Regiones de Colombia
# Categorias + numerics

edit <- edit %>% mutate(deptoDivipola = DPTO) #Divipola antes de mutar

edit <- edit %>% mutate(region = ifelse(DPTO == 08 | DPTO == 13 | DPTO == 23 | DPTO == 47 | DPTO == 20 | DPTO == 44 | DPTO == 70, "Caribe",
    ifelse(DPTO == 05 | DPTO == 15 | DPTO == 17 | DPTO == 25 | DPTO == 41 | DPTO == 54 | DPTO == 63 | DPTO == 66 | DPTO == 68 | DPTO == 73 | DPTO == 11, "Central",
    ifelse(DPTO == 19 | DPTO == 27 | DPTO == 52 | DPTO == 76, "Pacifico",
    ifelse(DPTO == 50 | DPTO == 18 | DPTO == 99 | DPTO == 85 , "Orinoquia", NA))))
) # Regiones segun divipola


## Valor Agregado
# Numerics

edit <- edit %>% mutate(valorAgregado2019 = VALAGRI19/1000000) # Valor agregado segun la metodologia que tienes en documentation en miles de millones de pesos
edit <- edit %>% mutate(valorAgregado2020 = VALAGRI20/1000000) # Valor agregado segun la metodologia que tienes en documentation en miles de millones de pesos

## Productividad laboral
# Numerics

edit <- edit %>% mutate(productividadL2019 = (VALAGRI19/totOcupados2019)/1000000) # Productividad Laboral segun VA/TotalEmpleados en miles de millones de pesos
edit <- edit %>% mutate(productividadL2020 = (VALAGRI20/totOcupados2020)/1000000) # Productividad Laboral segun VA/TotalEmpleados en miles de millones de pesos
## Ratio comercio exterior (XM)

edit <- edit %>% mutate(ratioX2019 = PORCVT19/VALORVEN19) # Que parte de la venta fue al extranjero (ratio) 2017
edit <- edit %>% mutate(ratioX2020 = PORCVT20/VALORVEN20) # Que parte de la venta fue al extranjero (ratio) 2018

edit <- edit %>% mutate(ratioM2019 = VALORCX19/VALORVEN19) # Materias primas compradas al extranjero (ratio) 2017
edit <- edit %>% mutate(ratioM2020 = VALORCX20/VALORVEN20) # Materias primas compradas al extranjero (ratio) 2018

## Inversion

edit$II1R10C1[is.na(edit$II1R10C1)] <- 0
edit$II1R10C2[is.na(edit$II1R10C2)] <- 0

edit <- edit %>% mutate(gastoACTI2019 = II1R10C1) # Gasto en ACTI 2017, miles de pesos
edit <- edit %>% mutate(gastoACTI2020 = II1R10C2) # Gasto en ACTI 2018, miles de pesos

edit <- edit %>% mutate(inversion2019 = (gastoACTI2019/valorAgregado2019)*100) # Inversion 2017 por ACTI/VA*100
edit <- edit %>% mutate(inversion2020 = (gastoACTI2020/valorAgregado2020)*100) # Inversion 2018 por ACTI/VA*100

variables <- data.frame(colnames(edit))
