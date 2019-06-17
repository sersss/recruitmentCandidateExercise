library(shiny)
#library(dplyr)
library(ggplot2)
# optional
library(RCurl)
library(rgl)
library(scatterplot3d)
library(plotly)

shinyServer(
  function(input,output){
   #rfact = reactive({as.numeric(input$rf)})
   reactive ({data_url<-"https://raw.githubusercontent.com/schubertjan/recruitmentCandidateExercise/master/data.csv"
     datak1<-read.csv(data_url,sep=",")
     colnames(datak1)<- c("Date_Week","Media_Spend_USD","Media_Campaing","Search_Volume")
    # require(data.table)
     datak2<-datak1
     datak2$Index = 1:nrow(datak2)
     datak2$Adstock = 0
      for (i in 1:nrow(datak2)){
       if (i ==1)
         datak2[i,6] <- datak2[i,2]
       else
         #Adstock(week n) = Media Spend + RF*Adstock(week n-1)
         #rfact <- reactive({as.numeric(input$rf)})
         datak2[i,6] <- datak2[i,2] + (datak2[i-1,6] * input$rf)
     }
  })

  
  output$sumar <- renderPrint({
    ({for (i in 1:nrow(datak2)){
    if (i ==1)
      datak2[i,6] <- datak2[i,2]
    else
      #Adstock(week n) = Media Spend + RF*Adstock(week n-1)
      #rfact <- reactive({as.numeric(input$rf)})
      datak2[i,6] <- datak2[i,2] + (datak2[i-1,6] * input$rf)
                                datak3 <- datak2}})
                                summary(datak3)
                                
    })

  output$stru <- renderPrint({
    ({for (i in 1:nrow(datak2)){
    if (i ==1)
      datak2[i,6] <- datak2[i,2]
    else
      #Adstock(week n) = Media Spend + RF*Adstock(week n-1)
      #rfact <- reactive({as.numeric(input$rf)})
      datak2[i,6] <- datak2[i,2] + (datak2[i-1,6] * input$rf)
    datak3 <- datak2}})
    str(datak3)})

  output$datarec <- renderTable({
    ({for (i in 1:nrow(datak2)){
    if (i ==1)
      datak2[i,6] <- datak2[i,2]
    else
      #Adstock(week n) = Media Spend + RF*Adstock(week n-1)
      #rfact <- reactive({as.numeric(input$rf)})
      datak2[i,6] <- datak2[i,2] + (datak2[i-1,6] * input$rf)
    datak3 <- datak2}})
    datak3}) 

  output$plot1 <-renderPlot({
    ({for (i in 1:nrow(datak2)){
      if (i ==1)
        datak2[i,6] <- datak2[i,2]
      else
        #Adstock(week n) = Media Spend + RF*Adstock(week n-1)
        #rfact <- reactive({as.numeric(input$rf)})
        datak2[i,6] <- datak2[i,2] + (datak2[i-1,6] * input$rf)
      datak3 <- datak2}})
    ggplot(data=datak3,aes(x=Search_Volume,y=Adstock))+geom_point(shape=20,size=3.0)+geom_smooth(method="lm",se=FALSE,size=0.5)+ggtitle("Search_Volume vs Adstock")})
  
  output$info <- renderText({
    paste0("x=",input$plot_click$x,"\n",
           "y=",input$plot_click$y)
  })
  
  output$summarlm <- renderTable({({for (i in 1:nrow(datak2)){
    if (i ==1)
      datak2[i,6] <- datak2[i,2]
    else
      #Adstock(week n) = Media Spend + RF*Adstock(week n-1)
      #rfact <- reactive({as.numeric(input$rf)})
      datak2[i,6] <- datak2[i,2] + (datak2[i-1,6] * input$rf)
    datak3 <- datak2}})
    sm <- summary(lm(Adstock ~ SearchVolume, datak3))
    sm$coefficients
  })
  
  output$plot3 <- renderPlot({
    ({for (i in 1:nrow(datak2)){
      if (i ==1)
        datak2[i,6] <- datak2[i,2]
      else
        #Adstock(week n) = Media Spend + RF*Adstock(week n-1)
        #rfact <- reactive({as.numeric(input$rf)})
        datak2[i,6] <- datak2[i,2] + (datak2[i-1,6] * input$rf)
      datak3 <- datak2}})
    
   # ggplot(data=datak3, aes(x=Search_Volume, y =Index, z =Adstock, color=Media_Campaing))+theme_void()+ggtitle("Index-week vs Search_Volume vs Adstock")
    ModMatrix<-as.matrix(datak3)
    x1<-ModMatrix[,4]
    y1<-ModMatrix[,5]
    z1<-ModMatrix[,6]
    
    spl<-scatterplot3d(x1,y1,z1,pch=16, highlight.3d = TRUE,angle =120, type="h",xlab="Search_Volume",ylab="Index-Week",zlab="Adstock")
   # Mod.1<-lm(x1~y1+z1)
    #spl$plane3d(Mod.1,lty.box="solid")
  })
  
  output$info3 <- renderText({
    paste0("x=",input$plot_click$x,"\n",
           "y=",input$plot_click$y,"\n",
           "z=",input$plot_click$z)
  })
  


  }
  
)