
# Read the UCI power consumption dataset
# Estimated slightly over 2075259 * 9 * 8 bytes ~= 142 MB in memory
# Will read only the relevant subset, 2007/02/01 ~ 2007/02/02
# 2880 rows starting from row 66637

# First read column names
hpc_colnames <- colnames(read.table("household_power_consumption.txt", sep=";", header = TRUE, nrow = 1))

# Read the subset of data in days 2007/02/01 ~ 2007/02/02
hpc <- read.table("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?", colClasses = c(rep("character", 2), rep("numeric", 7)), col.names = hpc_colnames, skip = 66636, nrows = 2880)

# Construct POSIX time from the date and time string
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time), '%d/%m/%Y %H:%M:%S')




# Plot 2: Plotting datetime vs. global active power
png(filename = "plot2.png", bg = "transparent")

with(hpc, plot(datetime, Global_active_power, 'l', xlab = "", ylab = "Global Active Power (kilowatts)", main = ""))

dev.off()

