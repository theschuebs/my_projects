# require gems
require 'sqlite3'
require 'faker'

#create SQLite3 database
db = SQLite3::Database.new("birthday_celebrator.db")
#IT IS POSSIBLE TO RETURN OUR DATA TYPE AS A HASH!!
db.results_as_hash = true

#string delimiter
create_table_cmd = <<-SQL
	CREATE TABLE IF NOT EXISTS students (
		id INTEGER PRIMARY KEY,
		name VARCHAR(255),
		birthdate DATE,
		happy_meal_id INT,
		FOREIGN KEY (happy_meal_id) REFERENCES happy_meal(id)
	)

SQL

create_table_2_cmd = <<-SQL
	CREATE TABLE IF NOT EXISTS happy_meal (
			id INTEGER PRIMARY KEY,
			happy_meal VARCHAR(255)
	)

SQL

db.execute(create_table_cmd)
db.execute(create_table_2_cmd)

students = db.execute("SELECT students.name, happy_meal.happy_meal FROM students, happy_meal 
	WHERE students.happy_meal_id = happy_meal.id AND birthdate BETWEEN date('2005-01-01') AND date('2005-12-31');")


def add_student(db, name, birthdate, happy_meal_id)
	puts "Enter your name (first, last):"
	name = gets.chomp
	puts "Enter your birthdate (YYYY-MM-DD):"
	birthdate = gets.chomp
	puts "Enter your happy meal choice (1 for Hamburger, 2 for Cheeseburger, or 3 for Chicken McNuggets):"
	happy_meal_id = gets.chomp

	db.execute("INSERT INTO students (name, birthdate, happy_meal_id) 
    VALUES (?, ?, ?)", [name, birthdate, happy_meal_id])
end

add_student(db, 'erika', '1984-06-18', 1)

students = db.execute("SELECT students.name, happy_meal.happy_meal FROM students, happy_meal 
	WHERE students.happy_meal_id = happy_meal.id AND birthdate BETWEEN date('1980-01-01') AND date('1988-12-31');")

# USER FRIENDLY FORMAT
students.each do |student|
	puts "HAPPY BIRTHDAY #{student['name']}!! Your birthday lunch special: A #{student['happy_meal']} Happy Meal!"
end



#Add students to the table
	#RESEARCH DATE format
	#Practice using FAKER
# db.execute("INSERT INTO students (name, birthdate, happy_meal_id) VALUES ('Ed', '2006-06-07', 1)")
# db.execute("INSERT INTO students (name, birthdate, happy_meal_id) VALUES (?, ?, ?)", [Faker::Name.name, '2006-03-21', 2])
# db.execute("INSERT INTO students (name, birthdate, happy_meal_id) VALUES (?, ?, ?)", [Faker::Name.name, '2006-08-25', 3])
# db.execute("INSERT INTO students (name, birthdate, happy_meal_id) VALUES (?, ?, ?)", [Faker::Name.name, '2006-06-18', 3])
# db.execute("INSERT INTO students (name, birthdate, happy_meal_id) VALUES (?, ?, ?)", [Faker::Name.name, '2005-01-22', 2])

#Values inputted into the happy_meal table
	# db.execute("INSERT INTO happy_meal (happy_meal) VALUES ('Hamburger')")
	# db.execute("INSERT INTO happy_meal (happy_meal) VALUES ('Cheeseburger')")
	# db.execute("INSERT INTO happy_meal (happy_meal) VALUES ('Chicken McNugget')")

#EXPERIMENTAL DRIVER CODE
	# students = db.execute("SELECT students.name, students.birthdate, happy_meal.happy_meal FROM students, happy_meal WHERE students.happy_meal_id = happy_meal.id;")
	# puts students.class
	# p students
	# #practice pulling out specific data
	# p students[0][1]
	# puts students[2][2].class

#EXPLORE ORM BY RETREIVING DATA **ALWAYS CHECK THE CLASS TO KNOW WHAT YOUR DATATYPE IS!!
	# students = db.execute("SELECT birthdate FROM students WHERE birthdate BETWEEN date('2005-01-01') AND date('2005-12-31');")
	# p students

	# def create_student(db, name, birthdate)
# 	db.execute("INSERT INTO students (name, birthdate) VALUES (?, ?, ?)", [name, birthdate])
# 	end
