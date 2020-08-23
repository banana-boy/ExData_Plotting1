download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "dat.zip")

unzip("dat.zip")

library(tidyverse)
library(dplyr)

dat <- read_csv2("household_power_consumption.txt", col_types = cols(Date = col_date(format = "%d/%m/%Y")))

dat <- dat %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

dat$Global_active_power = as.double(dat$Global_active_power)

png(file = "plot1.png", height = 480, width = 480)

hist(dat$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "Red", main = "Global Active Power")

dev.off()


