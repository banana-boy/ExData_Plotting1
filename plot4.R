download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "dat.zip")

unzip("dat.zip")

library(tidyverse)
library(dplyr)

dat <- read_csv2("household_power_consumption.txt", col_types = cols(Date = col_date(format = "%d/%m/%Y")))

dat <- dat %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

dat$datetime = strptime(paste(dat$Date, dat$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 

dat$Global_active_power = as.double(dat$Global_active_power)
dat$Sub_metering_1 = as.numeric(dat$Sub_metering_1)
dat$Sub_metering_2 = as.numeric(dat$Sub_metering_2)
dat$Sub_metering_3 = as.numeric(dat$Sub_metering_3)

png(file = "plot4.png", height = 480, width = 480)

par(mfrow=c(2,2))

plot(x = dat$datetime, y = dat$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(x = dat$datetime, y = dat$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(x = dat$datetime, y = dat$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = dat$datetime, y = dat$Sub_metering_2, col = "Red")
lines(x = dat$datetime, y = dat$Sub_metering_3, col = "Blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("Black", "Red", "Blue"), lty = 1, lwd = 2)


plot(x = dat$datetime, y = dat$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
