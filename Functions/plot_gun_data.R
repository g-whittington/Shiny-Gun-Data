# Programmer: George Whittington
# Data: 2025-04-24
# Purpose: Define the function for Q3 to use

plot_gun_data <- function(df, intentval, covar, policevar=2) {
  # no input validation because the radio buttons restrict the input
  
  # filter for desired death type
  df <- df |> filter(intent==str_to_title(intentval))
  
  # police var: if 2, no filter
  if (policevar == 0) {
    df <- df |> filter(police==0)
  } else if (policevar == 1) {
    df <- df |> filter(police==1)
  } 
  
  x_title <- ""
  main_title <- "Number of U.S."
  
  if (covar=="sex") {
    x_title <- "Sex of individual"
    main_title <- paste(main_title, intentval, 
                        "deaths by guns from 2012-2014 by sex")
  } else if (covar=="factor_age") {
    x_title <- "Decade of life"
    main_title <- paste(main_title, intentval, 
                        "deaths by guns from 2012-2014 by age")
  } else if (covar=="race") {
    x_title <- "Race of indivdual"
    main_title <- paste(main_title, intentval, 
                        "deaths by guns from 2012-2014 by race")
  } else if (covar=="place") {
    x_title <- "Location of death"
    main_title <- paste(main_title, intentval, 
                        "deaths by guns from 2012-2014 by location")
  } else {
    x_title <- "Education level of indivdual"
    main_title <- paste(main_title, intentval, 
                        "deaths by guns from 2012-2014 by education")
  }
  
  # produce plot
  df |> ggplot(aes(x = .data[[covar]])) +
    geom_bar(colour="#000", fill="#A3D") +
    coord_flip() +
    labs(
      x=x_title, 
      title=main_title,
      y="Number of Occurrences"
    ) +
    theme(axis.title = element_text(size=22),
          axis.text = element_text(size=18),
          title = element_text(size=20))
}