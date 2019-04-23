#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(maps)
library(mapproj)

source("helpers.R")
counties <- readRDS("data/counties.rds")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("censusVis"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        helpText("Create demographic maps with 
               information from the 2010 US Census."),
        
        selectInput("var", 
                    label = "Choose a variable to display",
                    choices = c("Percent White", 
                                "Percent Black",
                                "Percent Hispanic", 
                                "Percent Asian"),
                    selected = "Percent White"),
        
        sliderInput("range",
                    "Range of interest:",
                    min = 0,
                    max = 100,
                    value = c(0,100),
                    dragRange = TRUE)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        textOutput("selected_var"),
        textOutput("chosen_range")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  output$selected_var <- renderText({ 
    paste("You have selected ", input$var, ".", sep = "")
  })
  
  output$chosen_range <- renderText({ 
    paste("You have chosen a range that goes from ", input$range[1], " to ", input$range[2], ".", sep = "")
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

