
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(dplyr)

cpalette <- c("#AD297D",
              "#71A916",
              "#FB8B24",
              "#2C8F72",
              "#4262BC",
              "#C31D31",
              "#454D02",
              "#8E5F68",
              "#DBA9F1",
              "#B2931D",
              "#75C97B",
              "#5B2B6E",
              "#F680AF",
              "#F64AA8")

df <- read.csv('demo_data.csv')
df$incomelevel <- factor(df$incomelevel, levels=list('0-25k','25k-50k','50k-100k','100k-150k','150k+'))
df$Causes.of.Death <- factor(df$Causes.of.Death, levels=rev(levels(df$Causes.of.Death)))
df$isrural <- df$isrural == 'True'

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
    if (input$wantrural == 'Combined') {
      dfper <- df %>% group_by(incomelevel) %>% mutate(deathspercap=Count/sum(population)) %>% ungroup
    }
    else {
      wantrural <- input$wantrural == 'Rural'
      dfper <- df[df$isrural == wantrural,] %>% group_by(incomelevel,isrural) %>% mutate(deathspercap=Count/sum(population)) %>% ungroup
    }
    g <- ggplot(dfper, aes(x=incomelevel, y=deathspercap, fill=Causes.of.Death, order=-as.numeric(Causes.of.Death))) + geom_bar(stat = 'identity')
    g <- g + scale_fill_manual(values=cpalette)
    g <- g + ylim(0, 0.015)
    g <- g + ggtitle(paste('Per-capita California death rates,', input$wantrural))
    g <- g + xlab('Median income level of zipcode') + ylab('Per-capita death rate')
    print(g)
  })

})
