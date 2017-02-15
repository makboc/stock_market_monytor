library(shiny)
library(dygraphs)
library(rmarkdown)

# Define the overall UI
shinyUI(fluidPage(
        
    includeCSS("www/styles.css"),
    dygraphOutput("graph", height=700),
    absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                  draggable = FALSE, top = 0, left = 85, right = "auto",
                  bottom = "auto", width = 600, height = 50,
                  fluidRow(
                      column(6,
                             h5("Simple stock adjusted price monitor."),
                             h5("Just select stock symbols and press show button."),
                             h5("Select area of interest on graph fro closer view."),
                             h5("Press double click for restoring graph to initial mode."),
                             uiOutput("symbolsSelector"),
                             actionButton("go", "SHOW")
                             )
                      )
                  )
    )
    
)