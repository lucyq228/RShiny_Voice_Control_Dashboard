library(shiny)
library(ggplot2)

shinyApp(
  ui = fluidPage(
    titlePanel(strong('Talk to Me Dashboard')),
    
    h1(' '),
    
    singleton(tags$head(
      tags$script(src="//cdnjs.cloudflare.com/ajax/libs/annyang/1.4.0/annyang.min.js"),
      includeScript('init.js')
    )),
    
    div(
      
      sidebarLayout(position = 'left',
                    mainPanel(width =5,tableOutput('foo'),h4(strong('Spend Details')),tableOutput('detail')),
                    
                    mainPanel(width = 5, plotOutput('foo2'),
                              h6('For demo purpose, trigger words include title, color, horizontal, vertical, category.'))),
      
      helpText(HTML(
        ' '
      ))
    )
  ),
  
  server = function(input, output) {
    
    observe({
      df = read.csv('tran_data.csv')
      colnames(df) <- c('Category', 'Spent', 'Date', 'category2', 'Date2')
      df$Date2 = as.Date(df$Date2, format="%d-%b-%y")
      df = df[order(df$Date2),]
      
      output$detail = renderTable(df[df$category2 %in% c(input$category), c('Category', 'Spent', 'Date')])
      
      output$foo2 = renderPlot({
        col = input$color
        if (length(col)==0 || !(col %in% colors())) col = 'gray'
        
        ggplot(data = df[df$category2 %in% c(input$category), ],
               aes(Date2, Spent)) + theme_bw() + geom_line(colour=col, size=1) +
          ggtitle(input$title) + xlab(input$horizontal) + ylab(input$vertical) +
          theme(plot.title = element_text(hjust = 0.5, size =16),
                axis.text.x = element_text(size = 13),
                axis.text.y = element_text(size = 13),
                axis.title.x = element_text(size = 13),
                axis.title.y = element_text(size = 13))
      })
    })
    
  }
)
