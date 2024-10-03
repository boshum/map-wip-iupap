options(timeout = 2400)
install.packages("ggplot2")
install.packages("sf")
install.packages("rnaturalearth")
install.packages("dplyr")
install.packages("maps")

library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(dplyr)
library(maps)

# Lista de países que queremos importar
countries_to_highlight <- readLines("countries.txt")

# Importar el mapa del paquete maps
world_map <- map_data("world")

# Colorear los países de la lista con azul, los demás en gris
world_map$highlight <- ifelse(world_map$region %in% countries_to_highlight, "cornflowerblue", "lightgrey")

# Data frame de los países para etiquetarlos
label_data <- world_map %>%
  group_by(region) %>%
  summarize(long = mean(long), lat = mean(lat)) %>%
  filter(region %in% countries_to_highlight)  # Sólo etiqueta a los países de la lista

# Plotear el mapa de los países de la lista
ggplot(world_map, aes(x = long, y = lat, group = group, fill = highlight)) +
  geom_polygon(color = "white") +  # Bordesde los países 
  scale_fill_identity() +  # Usar el color azul para rellenar
  theme_void() +
  labs(title = "Mapa de los países pertenecientes a WiP-IUPAP") +
  theme(legend.position = "none") 
  
  # Añadir las etiquetas de los países
 #  + geom_text(data = label_data, aes(x = long, y = lat, label = region),
  #          inherit.aes = FALSE, size = 2, color = "black")  #con esto ajustamos el color y tamaño de las etiquetas

