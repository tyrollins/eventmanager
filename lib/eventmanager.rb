require 'csv'
require 'erb'
#require 'sunlight-congress'

#Sunlight::Congress.api_key = "3a985a64ced04533bd60eadb3f88afef"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

=begin (sunlight gem is failing...uncomment when passing)
def legislators_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)

  legislator_names = legislators.collect do |legislator|
    "#{legislator.first_name} #{legislator.last_name}"
  end

  legislator_names.join(", ")
end
=end

def save_letter(id, form_letter)
    Dir.mkdir("output") unless Dir.exist?("output")

    filename = "output/thanks #{id}.html"

    File.open(filename, 'w') do |file|
        file.puts form_letter
    end
end



puts "EventManager initialized."

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

 # legislators = legislators_by_zipcode(zipcode)
 form_letter = erb_template.result(binding)
 save_letter(id, form_letter)

end
