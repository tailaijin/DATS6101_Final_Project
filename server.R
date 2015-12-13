# server file
# tailaijin

library("shiny", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.0")
library(ggplot2)
library(dplyr)
#setwd("~/6101Data_product/shiny_app")
#playoff <- read.csv("playoffdata.csv", sep = ",", header = TRUE)
urlpath <- 'https://raw.githubusercontent.com/tailaijin/DATS6101_Final_Project/master/reg_season_data.csv'
reg_season <- read.csv(urlpath, sep = ",", header = TRUE)
urlpath <-'https://raw.githubusercontent.com/tailaijin/DATS6101_Final_Project/master/playoffdata.csv'
playoff <- read.csv(urlpath, sep = ",", header = TRUE)

server <- function(input, output) 
{
  #isolate(input$value)
  
  #Compare ppg among different team
  output$Compare_grade <- renderPlot(
    {
      ggplot(playoff, aes(as.factor(YEAR), PPG)) + geom_boxplot() + facet_wrap(~TEAM) + ggtitle("Ponit per Game v.s. Teams") + labs(x = 'YEAR') + theme(plot.title = element_text(lineheight=.8, face="bold"))
    }
  )
  
  #Choose a team to compare ppg and year
  YEAR <- eventReactive(input$go_year, {input$choosing_year})
  output$choosing_year <- renderPlot(
    {
      playoff_year<-playoff[playoff$YEAR == YEAR() ,]
      ggplot(playoff_year, aes(x=TEAM, y=PPG)) + geom_boxplot() + ggtitle("Ponit per Game v.s. Teams") + theme(plot.title = element_text(lineheight=.8, face="bold"))
    }
  )
  
  #Choose a team to compare ppg and team
  TEAM <- eventReactive(input$go_team, {input$choosing_team})
  output$choosing_team <- renderPlot(
    {
      playoff_team<-playoff[playoff$TEAM == TEAM() ,]
      ggplot(playoff_team, aes(as.factor(YEAR), PPG)) + geom_boxplot() + ggtitle("Ponit per Game v.s. year") + theme(plot.title = element_text(lineheight=.8, face="bold")) + labs(x = 'YEAR')
    }
  )
  
  #Compare age distribution
  output$age <- renderPlot(
    ggplot(playoff, aes(AGE)) + geom_bar() + facet_wrap(~TEAM)+ ggtitle("AGE among Teams") + theme(plot.title = element_text(lineheight=.8, face="bold"))
  )
  
  #Compare age distribution
  output$age_year <- renderPlot(
    ggplot(playoff, aes(AGE)) + geom_bar() + facet_wrap(~YEAR)+ ggtitle("AGE among Years") + theme(plot.title = element_text(lineheight=1, face="bold"))
  )
  
  #Choose a team to see the age distrubtion
  AGE <- eventReactive(input$go_team_age, {input$choosing_team_agedist})
  output$choosing_age <- renderPlot(
    {
      playoff_age<-playoff[playoff$TEAM == AGE() ,]
      #ggplot(playoff_age, aes(as.factor(AGE), PPG)) + geom_boxplot() + ggtitle("Count v.s. Age") + theme(plot.title = element_text(lineheight=.8, face="bold")) + labs(x = 'AGE')
      ggplot(playoff_age, aes(AGE)) + geom_bar() + ggtitle("Count v.s. Age") + theme(plot.title = element_text(lineheight=.8, face="bold"))+ labs(x = 'AGE')
    }
  )
  
  #
  output$regression_plot <- renderPlot(
    {
      library(reshape)
      pure_data<-playoff[, !(colnames(playoff) %in% c("PLAYER","POS","TEAM"))]
      data<-pure_data[pure_data$YEAR > 2010,]
      z<-cor(data)
      z.m <- melt(z)
      ggplot(z.m, aes(X1, X2, fill = value)) + geom_tile() + scale_fill_gradient(low = "green",  high = "red") + ggtitle("Cov Analysis") + theme(plot.title = element_text(lineheight=.8, face="bold"))
    }
  )
  #output$regression_code <- renderPrint(
   # lm<-lm(playoff$MIN.~playoff$PPG)
   # summary(lm)
  #)
}
#shinyApp(ui = ui, server = server)
