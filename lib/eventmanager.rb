puts "EventManager Initialized!"

lines = File.readlines "event_attendees.csv"
lines.each do |line|
    column = line.split(",")
    name = column[2]
    puts name
end
