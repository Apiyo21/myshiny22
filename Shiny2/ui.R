library(shinydashboard)

ui <- dashboardPage(
  skin = 'yellow',
  dashboardHeader(
    title = "My dashboard",
    dropdownMenu(
      type = "messages",
      messageItem(from = "Sales Dept",
                  message = "Sales are steady this month."),
      messageItem(
        from = "New User",
        message = "How do I register?",
        icon = icon("question"),
        time = "13:45"
      ),
      messageItem(
        from = "Support",
        message = "The new server is ready.",
        icon = icon("life-ring"),
        time = "2014-12-01"
      )
    ),
    dropdownMenu(
      type = "notifications",
      notificationItem(text = "5 new users today",
                       icon("users")),
      notificationItem(text = "12 items delivered",
                       icon("truck"),
                       status = "success"),
      notificationItem(
        text = "Server load at 86%",
        icon = icon("exclamation-triangle"),
        status = "warning"
      )
    ),
    dropdownMenu(
      type = "tasks",
      badgeStatus = "success",
      taskItem(value = 90, color = "green",
               "Documentation"),
      taskItem(value = 17, color = "aqua",
               "Project X"),
      taskItem(value = 75, color = "yellow",
               "Server deployment"),
      taskItem(value = 80, color = "red",
               "Overall project")
    )
  ),
  
  ## Sidebar content
  dashboardSidebar(sidebarMenu(
    menuItem(
      "Dashboard",
      tabName = "dashboard",
      icon = icon("dashboard"),
      badgeLabel = "new",
      badgeColor = "green"
    )
    # menuItem("Widgets", tabName = "widgets", icon = icon("th"))
  )),
  dashboardBody(# Boxes need to be put in a row (or column)
    fluidRow(
      box(plotOutput("plot1", height = 250)),
      
      box(
        title = "Controls",
        sliderInput("slider", "Number of observations:", 1, 100, 50),
        textInput("text", "Text input:")
      )
      
      
    ))
)



server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)