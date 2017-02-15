library(shiny)
library(dygraphs)
library(zoo)
library(TTR)
library(quantmod)
library(tsoutliers)



shinyServer(function(input, output, session) {
    
    

    
    
    output$symbolsSelector <- renderUI({
        load("data/symbols.RData")
        symbol_names <- symbols$Name
        symbols <- symbols$Symbol
        names(symbols) <- symbol_names
        
        selectizeInput("symbolsSelectorChoice", '',
        choices=symbols, multiple=TRUE, width = "100%")
    })
    
    getDataToPlot <- eventReactive(input$go, {
        
        selected_symbols <- input$symbolsSelectorChoice
        if (length(selected_symbols) > 0) {
            data <- getSymbols(selected_symbols[1], auto.assign=FALSE)[, 6]
            colnames(data) <- gsub(".Adjusted", "", colnames(data), fixed = TRUE)
            if (length(selected_symbols) > 1) {
                for (s in selected_symbols[2:length(selected_symbols)]) {
                    more_data <- getSymbols(s, auto.assign=FALSE)[, 6]
                    colnames(more_data) <- gsub(".Adjusted", "", colnames(more_data), fixed = TRUE)
                    data <- cbind(data, more_data)
                }
            }
            return(data)
        } else {
            return(NULL)
        }
        
    })
    
    output$graph <- renderDygraph({
        data_to_plot = getDataToPlot()
        if (!is.null(data_to_plot)) {
            dygraph(getDataToPlot())
        }
    })
    
})
    