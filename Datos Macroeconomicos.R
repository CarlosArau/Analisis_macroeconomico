#Instalación de paquetes a utilizar
library(readxl)
library(quantmod)
library(dplyr)
library(haven)
library(quantmod)
library(readxl)
require(ggplot2)
library(readxl)
install.packages("openxlsx")
library(openxlsx)
install.packages("tidyr")
library(tidyr)
install.packages("WDI", dependencies = TRUE)
require(WDI)


# Extraer data del banco mundial según indicadores seleccionados.
WbData <- WDI(
  indicator = c(
    "SP.POP.TOTL",        # Población total
    "SE.XPD.TOTL.GD.ZS",  # Gasto en educación (% del PIB)
    "SH.XPD.CHEX.GD.ZS",  # Gasto en salud (% del PIB)
    "SL.UEM.TOTL.ZS",     # Tasa de desempleo total (% de la fuerza laboral)
    "NY.GDP.PCAP.CD"      # PIB Pércapita en USD
  ),
  country = "all",
  start = 1980,
  end = 2025,
  extra = TRUE
)

#Depuración de datos y cambiamos los nombres de las columnas
WbData1 <- WbData %>% 
  rename("Poblacion"= SP.POP.TOTL,
         "PIB"=NY.GDP.PCAP.CD,
         "Gasto.educacion"=SE.XPD.TOTL.GD.ZS,
         "Gasto.salud"=SH.XPD.CHEX.GD.ZS,
         "Desempleo"=SL.UEM.TOTL.ZS) %>% arrange(country,year) %>% 
  filter(region !="Aggregates") %>% 
  select(country,year,Poblacion,PIB,Gasto.educacion,Gasto.salud,region,Desempleo) 
WbData2 <- WbData1 %>% 
  na.omit()

#Exportar archivo a excel

write.xlsx(WbData2, "C:/Users/Carla/Downloads/Proyecto Pib Pércapita/BaseMundo.xlsx", overwrite = TRUE)

