library(tidyverse)
library(palmerpenguins)
library(gghighlight)
library(shiny)
library(bslib)
data(penguins, package = "palmerpenguins")

color_by <- varSelectInput(
  "color_by", "Color by",
  penguins[c("species", "island", "sex", "year")],
  selected = "island"
)

cards <- list(
  card(
    full_screen = TRUE,
    card_header("Bill Length"),
    plotOutput("bill_length")
  ),
  card(
    full_screen = TRUE,
    card_header("Bill depth"),
    plotOutput("bill_depth")
  ),
  card(
    full_screen = TRUE,
    card_header("Body Mass"),
    plotOutput("body_mass")
  )
)

ui <- page_sidebar(
  title = "Penguins dashboard",
  sidebar = color_by,
  layout_columns(cards[[1]], cards[[2]],
  cards[[3]])
)

gp1<-ggplot(penguins) +
  theme_minimal(base_size = 16) + scale_fill_discrete(h = c(0,190)) + 
  theme(axis.title = element_blank(), legend.position = "bottom")

server <- function(input, output) {
  gg_plot <- reactive({gp1+
      geom_density(aes(fill = !!input$color_by), alpha = 0.5)  })
  gg_plot_h <- reactive({
    gp1 +
      geom_point(aes(x = flipper_length_mm, y=body_mass_g, color = !!input$color_by))+
      gghighlight() +
      facet_wrap(vars(!!input$color_by)) })
  output$bill_length <- renderPlot(gg_plot() + aes(bill_length_mm))
  output$bill_depth <- renderPlot(gg_plot() + aes(bill_depth_mm))
  output$body_mass <- renderPlot(gg_plot_h())}

shinyApp(ui, server)