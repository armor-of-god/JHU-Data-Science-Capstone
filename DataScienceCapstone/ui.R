### Data Science Capstone : Course Project
### ui.R file for the Shiny app
### Github repo : https://github.com/sriharshams/coursera-data-science-capstone
suppressWarnings(library(shiny))
suppressWarnings(library(markdown))
shinyUI(navbarPage("Capstone: Data Science Capstone Project",
                   tabPanel("Predict the Next Word",
                            HTML("<strong>Author: Dr. Daniel J. Veit</strong>"),
                            br(),
                            HTML("<strong>Date: 6/29/2022</strong>"),
                            br(),
                            # Sidebar
                            sidebarLayout(
                                sidebarPanel(
                                    helpText("Enter a partial sentence to begin the next word prediction."),
                                    textInput("inputString", "Enter a partial sentence here",value = ""),
                                    br(),
                                    br(),
                                    br(),
                                    br()
                                ),
                                mainPanel(
                                    h2("Prediction for Next Word"),
                                    verbatimTextOutput("prediction"),
                                    strong("Text inputted by user:"),
                                    tags$style(type='text/css', '#string1 {background-color: rgba(255,0,0,0.10); color: black;}'), 
                                    textOutput('string1'),
                                    br(),
                                    strong("Which n-gram was used:"),
                                    tags$style(type='text/css', '#string2 {background-color: rgba(255,0,0,0.10); color: black;}'),
                                    textOutput('string2')
                                )
                            )
                            
                   ),
                   tabPanel("Additional Info",
                            mainPanel(
                                includeMarkdown("about.md")
                            )
                   )
)
)