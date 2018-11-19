#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(maps)
library(mapdata)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    map = map_data("italy")
    regionSelection = reactive({
        subset(map, map[,5] == input$region)    
    })
    
    output$distPlot <- renderPlot({
      ggplot(data = map) + geom_polygon(aes(x = long, y = lat, group = group), fill = "blue", color = "black") + coord_fixed(1.3) + geom_polygon(data=regionSelection(), aes(x = long, y = lat, group = group), fill = "red") + guides(fill=F)
  })
})
