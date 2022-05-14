## assignment
## read in .txt data file using read.table
## viewing the data table and the structure of the columns

library(dplyr)
DATA <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors=F, header = TRUE)
View(DATA)
str(DATA)

## using dplyr pipe command, mutate Dates using 'as.Date'

DATA <- DATA %>%
  mutate(Date = as.Date(Date, format = "%d/%m/%Y"))

## then filter out data rows between the 2 select rows

DATA %>% filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02"))) -> DATA2

## now using DATA2 table, proceed with assignment with rows of these selected dates
## first looking at the mode and class of each column using sapply() function

sapply(DATA2, mode)
sapply(DATA2, class)

#converting the data columns (columns 3 through 8, 9 already was numeric), to numeric
DATA2[, 3:8] <- sapply(DATA2[, 3:8], as.numeric)

# converting time from character to time

DATA2$Time <- strptime(DATA2$Time, format = "%H:%M:%OS")

png(file = "/Users/andrewdieterich/RStudio/datasciencecoursera/ExData_Plotting1/Plot2.png")

## making the plots - number 1 (plot2.png)

plot(DATA2$Global_active_power, type = "l", xaxt="n", xlab = "", ylab = "Global Active Power (killowatts)")
leng <- nrow(DATA2)
leng2 <- DATA2/2 - 1
leng
leng2
axis(1, at = seq(1, leng, by=leng2), labels= c("Thurs", "Fri", "Sat"))

# def off to create the file
dev.off()
