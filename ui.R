
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("California Per-Capita Leading Causes of Death"),

  sidebarLayout(
    sidebarPanel(
      radioButtons('wantrural',
                  "Urban vs Rural Zipcodes",
                  c('Urban','Rural','Combined')),
      h2('Description'),
      p('The plot shows per-capita causes of death for California residents for the year 2013.'),
      p(paste('The user selects whether to view',
              'information for Urban zipcodes, for Rural zipcodes or for all zipcodes (urban and rural counties combined).',
              'The server will identify the selected zipcodes and compute appropriate per-capita statistics for the',
              'leading causes of death across those zipcodes.',
              'An appropriate stacked bar chart is displayed in which the user can view the per-capita death rates',
              'for each cause of death, categorized according to each zipcode income level.')),
      p(paste('The median income for each California zipcode is categorized and that the statistics for',
              'that zipcode are accumulated into the appropriate income category. The user can identify how causes',
              'of death change across zipcodes with different median income levels.'))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      h2('Key'),
      HTML(paste('<table>',
           '<tr><td>ALZ</td><td>&nbsp;</td><td>Alzheimer\'s Disease</td></tr>',
           '<tr><td>CAN</td><td>&nbsp;</td><td>Malignant Neoplasms (Cancers)</td></tr>',
           '<tr><td>CLD</td><td>&nbsp;</td><td>Chronic Lower Respiratory Disease (CLRD)</td></tr>',
           '<tr><td>DIA</td><td>&nbsp;</td><td>Diabetes Mellitus</td></tr>',
           '<tr><td>HOM</td><td>&nbsp;</td><td>Alzheimer\'s Disease</td></tr>',
           '<tr><td>HTD</td><td>&nbsp;</td><td>Diseases of the Heart</td></tr>',
           '<tr><td>HYP</td><td>&nbsp;</td><td>Essential Hypertension and Hypertensive Renal Disease</td></tr>',
           '<tr><td>INJ</td><td>&nbsp;</td><td>Unintentional Injuries</td></tr>',
           '<tr><td>LIV</td><td>&nbsp;</td><td>Chronic Liver Disease and Cirrhosis</td></tr>',
           '<tr><td>NEP</td><td>&nbsp;</td><td>Nephritis, Nephrotic Syndrome and Nephrosis</td></tr>',
           '<tr><td>OTH</td><td>&nbsp;</td><td>All Other Causes</td></tr>',
           '<tr><td>PNF</td><td>&nbsp;</td><td>Pneumonia and Influenza</td></tr>',
           '<tr><td>STK</td><td>&nbsp;</td><td>Cerebrovascular Disease (Stroke)</td></tr>',
           '<tr><td>SUI</td><td>&nbsp;</td><td>Intentional Self Harm (Suicide)</td></tr>',
           '</table>')),
      h3('Data sources'),
      tags$a('https://catalog.data.gov/dataset/leading-causes-of-death-by-zip-code-1999-2013'),
      tags$a('http://www.aging.ca.gov/data_and_statistics/Docs/2011/2000_CA_Rural_Urban_by_Zip_Code.pdf'),
      tags$a('http://federalgovernmentzipcodes.us/'),
      tags$a('http://factfinder.census.gov/faces/tableservices/jsf/pages/productview.xhtml?src=bkmk')
    )
  )
))
