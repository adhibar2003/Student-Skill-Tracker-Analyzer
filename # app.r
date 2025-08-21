# app.py
from flask import Flask, render_template, request, redirect
import sqlite3

app = Flask(__name__)

# --- Initialize DB ---
def init_db():
    conn = sqlite3.connect("database.db")
        c = conn.cursor()
            c.execute("""CREATE TABLE IF NOT EXISTS students (
                                id INTEGER PRIMARY KEY AUTOINCREMENT,
                                                name TEXT,
                                                                problem_solving INTEGER,
                                                                                communication INTEGER,
                                                                                                coding INTEGER)""")
                                                                                                    conn.commit()
                                                                                                        conn.close()

                                                                                                        init_db()

                                                                                                        # --- Routes ---
                                                                                                        @app.route("/")
                                                                                                        def index():
                                                                                                            conn = sqlite3.connect("database.db")
                                                                                                                c = conn.cursor()
                                                                                                                    c.execute("SELECT * FROM students")
                                                                                                                        students = c.fetchall()
                                                                                                                            conn.close()
                                                                                                                                return render_template("index.html", students=students)

                                                                                                                                @app.route("/add", methods=["GET", "POST"])
                                                                                                                                def add_student():
                                                                                                                                    if request.method == "POST":
                                                                                                                                            name = request.form["name"]
                                                                                                                                                    ps = int(request.form["problem_solving"])
                                                                                                                                                            comm = int(request.form["communication"])
                                                                                                                                                                    coding = int(request.form["coding"])

                                                                                                                                                                            conn = sqlite3.connect("database.db")
                                                                                                                                                                                    c = conn.cursor()
                                                                                                                                                                                            c.execute("INSERT INTO students (name, problem_solving, communication, coding) VALUES (?,?,?,?)",
                                                                                                                                                                                                              (name, ps, comm, coding))
                                                                                                                                                                                                                      conn.commit()
                                                                                                                                                                                                                              conn.close()
                                                                                                                                                                                                                                      return redirect("/")
                                                                                                                                                                                                                                          return render_template("add_student.html")

                                                                                                                                                                                                                                          @app.route("/student/<int:id>")
                                                                                                                                                                                                                                          def student(id):
                                                                                                                                                                                                                                              conn = sqlite3.connect("database.db")
                                                                                                                                                                                                                                                  c = conn.cursor()
                                                                                                                                                                                                                                                      c.execute("SELECT * FROM students WHERE id=?", (id,))
                                                                                                                                                                                                                                                          student = c.fetchone()
                                                                                                                                                                                                                                                              conn.close()
                                                                                                                                                                                                                                                                  return render_template("student.html", student=student)

                                                                                                                                                                                                                                                                  if __name__ == "__main__":
                                                                                                                                                                                                                                                                      app.run(debug=True)
            ))