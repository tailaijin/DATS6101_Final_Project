# UI File
# tailaijin
ui <- fluidPage(
  #title
  tags$h1("Final Project of DATS 6101"),
  tags$hr(),
  
  #introduction to the author and background of this project
  tags$img(height = 100, width = 100, src = "https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAALpAAAAJDhkZTlhNDhkLWYyMTItNDAwMS1hOWZkLTk5Yjc2YmY1OWMyMA.jpg"),
  tags$em("   Author: Tailai Jin"),
  tags$h5("This data product describe the past five year's NBA playoff data by player dimension. Retrived from: ", tags$a(href = "http://www.nbastuffer.com/player_stats", "Link" ),". Of course some data cleaning works are done berfore analysis."),
  tags$h5("Here is the summery data by teams and shown on an map: ", tags$a(href = " https://www.google.com/maps/d/edit?mid=z5YuZVKkwQTA.kyYTbZy0y2Ns&usp=sharing", "GIS_display")),
  tags$h5("Note the R needs a few seconds to process the request."),
  tags$hr(),
  
  #Compare ppg among different team
  tags$h5("First, let's compare each team's point get in every match."),
  #Compare grade in different amoung different teams
  plotOutput("Compare_grade", height = "800px"),
  tags$h5("Some data are missing, but we still can see the difference among teams."),
  tags$hr(),
  
  #Choose a team to compare ppg and year
  tags$h5("Please choose the team you are insterested in and click the update button."),
  selectInput(inputId = "choosing_team", label = "Choose a team", choices = levels(factor(playoff$TEAM)), selected = NULL, multiple = FALSE,selectize = TRUE, width = NULL, size = NULL),
  actionButton(inputId = "go_team", label = "Update"),
  plotOutput("choosing_team"),
  tags$hr(),
  
  #Choose a year to compare ppg and team
  tags$h5("Please choose the year you are insterested in and click the update button. Note the data of 2009 is missing."),
  selectInput(inputId = "choosing_year", label = "Choose a year", choices = levels(factor(playoff$YEAR)), selected = NULL, multiple = FALSE,selectize = TRUE, width = NULL, size = NULL),
  actionButton(inputId = "go_year", label = "Update"),
  plotOutput("choosing_year"),
  tags$hr(),
  
  #Compare age distribution among team
  tags$h5("Second, let's compare each team's age distribution."),
  # Dist's of age
  plotOutput("age", height = "800px"),
  tags$h5("Just like the Population growth curve, some teams are growing. "),
  tags$hr(),
  
  #Compare age distribution among year
  tags$h5("Compare each year's age distribution."),
  # Dist's of age
  plotOutput("age_year", height = "800px"),
  tags$h5("We can see the age distrubution is changing in these years."),
  tags$hr(),
  
  #Choose a team to see the age distrubtion
  tags$h5("Please choose the year you are insterested in and click the update button."),
  selectInput(inputId = "choosing_team_agedist", label = "Choose a team", choices = levels(factor(playoff$TEAM)), selected = NULL, multiple = FALSE,selectize = TRUE, width = NULL, size = NULL),
  actionButton(inputId = "go_team_age", label = "Update"),
  plotOutput("choosing_age"),
  tags$hr(),
  
  #Try to explore some relationship between age and strategies
  tags$h5("Is there any realtionship between the MIN. and PPG?"),
  plotOutput("regression_plot", height = "800px"),
  tags$h5("The answer is yes."),
  tags$hr(),
  #textOutput("regression")
  #plot(playoff$MIN., playoff$PPG)
  #lm<-lm(playoff$MIN.~playoff$PPG)
  #summary(lm)
  #plot(playoff[playoff$PLAYER == 'Marvin Williams']$YEAR,playoff[playoff$PLAYER == 'Marvin Williams']$PPG)
  
  #Do a regression
  tags$h5("Regression results:"),
  tags$img(width = 600, src = "https://scontent-iad3-1.xx.fbcdn.net/hphotos-xfl1/t31.0-8/12371044_863833553714668_454991806156700548_o.jpg"),
  tags$h5("All coefficients are significant, thus my hypothesis should be true in statistic.")
)
