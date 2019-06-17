library(shiny)
library(ggplot2)
library(rgl)
library(plotly)

shinyUI(fluidPage(
  
  titlePanel(title = h4("Recruitment Exercise!",align="center")),
  sidebarLayout(
    sidebarPanel( title = ("Select model and Slider"),
    sliderInput("rf","A.Select the RF lenght", min=0, max=2, value=0.1, step=0.1),
    selectInput("model","B.Select the model", choices=c("2D Linear Regression"=1,"3D Multiple Regression"=2))
  
                 
    ),
    mainPanel(title=("This is the main panel text, output is displayed here"),
              tabsetPanel(type="tab",
              tabPanel("Summary",verbatimTextOutput("sumar")),
              tabPanel("Structure",verbatimTextOutput("stru")),
              tabPanel("Data+Index+Adstock",tableOutput("datarec")),
              tabPanel("Plot + Model1",plotOutput("plot1",click="plot_click",width=800),verbatimTextOutput("info")),
              tabPanel("Plot + Model2",plotOutput("plot3",click="plot_click",width=800),verbatimTextOutput("info3"))
              ))
  )
)
)


