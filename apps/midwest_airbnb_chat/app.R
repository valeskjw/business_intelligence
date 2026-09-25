# ISA 401 Job Scout Chat: ask questions, get SQL, a table, or a chart back
library(querychat)
library(shiny)
library(bslib)

con = DBI::dbConnect(RSQLite::SQLite(), "data/midwest_airbnb.db")

client = ellmer::chat_openai(
  model  = "gpt-5.6-luna",
  params = ellmer::params(reasoning_effort = "none")
)

qc = querychat::querychat(
  con, "listings",
  client             = client,
  tools              = c("filter", "query", "visualize"),
  greeting           = "Ask me about 14,887 Airbnb listings in Chicago, Columbus, and the Twin Cities.",
  data_description   = "data/data_desc.md",
  extra_instructions = "data/extra_instructions.md"
)

ui = page_sidebar(
  title   = "Chicago-Columbus-Twin Cities Airbnb Chat",
  theme = bs_theme(
    version = 5,
    bootswatch = "minty"
  ),
  sidebar = qc$sidebar(width = 350),
  card(card_header(textOutput("title")),
       DT::DTOutput("table")),
  accordion(open = FALSE,
            accordion_panel("SQL", verbatimTextOutput("airbnb_sql")),
            accordion_panel("About", "Chicago-Columbus-Twin Cities Airbnb Search; built by Joseph Valeski"))
)

server = function(input, output, session) {
  vals = qc$server()
  
  output$title = renderText(vals$title() %||% "AirBnb Listings")
  
  output$table = DT::renderDT(
    vals$df(),
    options = list(pageLength = 10)
  )
  
  output$airbnb_sql = renderText(vals$sql())
}

shinyApp(ui, server)
