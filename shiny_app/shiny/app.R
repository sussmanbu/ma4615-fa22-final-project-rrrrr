#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
# 
#
library(tidyverse)
library(shiny)
MA_select <- read_csv("MA_select.csv") %>% 
  select(`Report Year`, `County Name`, `Weather Condition`) %>% 
  group_by(`Report Year`, `County Name`, `Weather Condition`) %>%
  mutate(count = n()) %>%
  ungroup()
  
# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("MA Highway-Rail Accident"),

  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        "weather condition",
        "Select weather conditions",
        unique(MA_select$`Weather Condition`),
        selected = unique(MA_select$`Weather Condition`)[1]
        ),
        
      sliderInput(inputId = "Report Year", label = "Year", min = 1975, 
                  max = 2022, value = c(2017, 2021)),
      
      checkboxGroupInput(
        "County Name",
        "Select county names",
        unique(MA_select$`County Name`),
        selected = unique(MA_select$`County Name`)[1]
      )
    ),
    # Show a plot of the generated distribution
    mainPanel(
     plotOutput("barPlot")
    )
  )
)






# Define server logic required to draw a histogram
server <- function(input, output) {

    output$barPlot <- renderPlot({
        # show data for  input$group from ui.R
        MA_select %>% 
          filter(`Weather Condition` %in% input$`weather condition`, 
                 `Report Year` %in% input$`Report Year`,
                 `County Name` %in% input$`County Name`) %>%
          ggplot(aes(y = `County Name`, fill = `Weather Condition`)) +
        geom_bar()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
