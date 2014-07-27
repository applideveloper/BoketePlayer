
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(XML)
library(dplyr)
library(stringr)

start.date <- as.Date("2008-09-05") # The first date of bokete
days <- (Sys.Date() - start.date) %>% as.numeric()
GetImageUrls <- function() {
  date <- (start.date + sample(days, 1)) %>% str_replace_all("-", "")
  url <- paste0("http://bokete.jp/boke/daily/", date)
  html <- htmlParse(url)
  imageUrls <- getNodeSet(html, '//*[@class="boke-entry attention ui-widget"]/div[7]/input/@value') %>% unlist()
  urls <- getNodeSet(html, '//*[@class="boke-entry attention ui-widget"]/p[2]/a[2]/@href') %>% unlist()
  list(imageUrl=imageUrls, url=urls)
}
imageUrls <- GetImageUrls()

shinyServer(function(input, output) {

  output$image <- renderUI({

    index <- input$index

    if(index == 1) {
      imageUrls <<- GetImageUrls()
    }
    
    href <- paste0("http://bokete.jp", imageUrls$url[index])
    src <- imageUrls$imageUrl[index]
    a(href=href, img(src=src), target="_blank")
  })

})
