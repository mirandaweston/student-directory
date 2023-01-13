@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def input_students
  puts "Please enter the name and country of the students"
  puts "To finish, just hit return twice"

  loop do
  name = gets.chomp
  month = gets.chomp

  while !name.empty? do
    @students << {name: name, cohort: month}
    if @students.count > 1
      puts "Now we have #{@students.count} students"
    else
      puts "Now we have 1 student"
    end
  
    name = gets.chomp
    month = gets.chomp
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit
  when "3"
    save_students
  when "4"
    load_students
  else
    puts "I don't know what you meant, try again"
  end
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each.with_index(1) do |student, index|
    if student[:name].start_with?("M") && student[:name].length < 13
    puts "#{index} #{student[:name]} (#{student[:cohort]} cohort)".center(50)
    end
  end
end

def print_footer
  if @students.count > 1
    puts "Overall, we have #{@students.count} great students"
  else
    puts "Overall, we have 1 great student"
  end
end

def save_students

  file = File.open("students.csv", "w")
  
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu