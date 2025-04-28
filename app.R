# Programmer: George Whittington
# Data: 2025-04-24
# Purpose: Turn the R function from the second problem in homework #5 (the 
#          function to plot the gun data) into an R Shiny app. My version is at
#          Gun Data App (shinyapps.io). Make your own version of this app and 
#          publish it on shinyapps.io as described in the notes. Submit the app 
#          folder as a zip file on eLC and give the link to the app as a comment 
#          in the submission. Your app should have the same or similar features, 
#          but will use your own function. It is fine for you to change your 
#          function if needed.

library(shiny)
library(bslib)
library(tidyverse)

# Read in data ----
df <- na.omit(read_csv("Data/full_data.csv"))

# add new age column to data
df$factor_age <- as.factor(if_else(df$age < 10, "0-9", 
                           if_else(df$age < 20, "10-19",
                           if_else(df$age < 30, "20-29",
                           if_else(df$age < 40, "30-39",
                           if_else(df$age < 50, "40-49",
                           if_else(df$age < 60, "50-59",
                           if_else(df$age < 70, "60-69",
                           if_else(df$age < 80, "70-79",
                           if_else(df$age < 90, "80-89", "90+"))))))))))

# Load in function(s) ----
source("Functions/plot_gun_data.R")

# Define UI ----
ui <- page_sidebar(
  title = "Q3: Gun Data",
  sidebar = sidebar(
    width = 400,
    ### Card 1
    card(
      radioButtons(
        inputId = "intentval",
        label = tags$p("Intent of person pulling the trigger", 
                       style = "font-size: 18px; font-weight: 500;"),
        choices = c("homicide", "suicide", "accidental", "undetermined"),
        selected = "homicide"
        )
      ),
    ### Card 2
    card(
      radioButtons(
        inputId = "covar",
        label = tags$p("Choose the variable to plot against",
                       style = "font-size: 18px; font-weight: 500;"),
        choices = list("age"="factor_age", "sex"="sex", "race"="race", 
                       "location of death"="place", "education"="education"),
        selected = "factor_age"
      )
    ),
    ### Card 3
    card(
      radioButtons(
        inputId = "policevar",
        label = tags$p("Police involvement",
                       style = "font-size: 18px; font-weight: 500;"),
        choices = list("all"=2, "police involved"=1, "police not involved"=0),
        selected = 2
      )
    )
  ),
  ### Main Content
  card(
    plotOutput(outputId = "plot_gun_data")
  ),
)

# Define server logic ----
server <- function(input, output) {
  output$plot_gun_data <- renderPlot(
    plot_gun_data(df, input$intentval, input$covar, input$policevar)
  )
}

# Run the app ----
shinyApp(ui = ui, server = server)