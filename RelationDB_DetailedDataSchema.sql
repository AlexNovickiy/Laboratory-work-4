-- Оновлено для перевірки workflow

-- Створення таблиці "User"
CREATE TABLE User (
    user_id SERIAL PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL CHECK (last_name ~ '^[A-Za-zА-Яа-я]+$'),  -- Регулярний вираз для текстових значень
    first_name VARCHAR(50) NOT NULL CHECK (first_name ~ '^[A-Za-zА-Яа-я]+$'), 
    email VARCHAR(100) UNIQUE NOT NULL CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')  -- Формат для електронної пошти
);

-- Створення таблиці "FinancialData"
CREATE TABLE FinancialData (
    data_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES User(user_id),
    date DATE NOT NULL CHECK (date >= '1900-01-01' AND date <= CURRENT_DATE),  -- Формат дати
    amount DOUBLE PRECISION NOT NULL CHECK (amount >= 0),
    type VARCHAR(10) NOT NULL CHECK (type IN ('доход', 'витрати'))
);

-- Створення таблиці "Report"
CREATE TABLE Report (
    report_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES User(user_id),
    period VARCHAR(50) NOT NULL,
    categories VARCHAR(100) NOT NULL
);

-- Створення таблиці "Analysis"
CREATE TABLE Analysis (
    analysis_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES User(user_id)
);

-- Створення таблиці "Trip"
CREATE TABLE Trip (
    trip_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES User(user_id),
    date DATE NOT NULL CHECK (date >= '1900-01-01' AND date <= CURRENT_DATE), 
    place VARCHAR(100) NOT NULL,
    activities VARCHAR(255)
);

-- Створення таблиці "CulturalObject"
CREATE TABLE CulturalObject (
    cultural_object_id SERIAL PRIMARY KEY,
    trip_id INT REFERENCES Trip(trip_id),
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50),
    description TEXT
);

-- Створення таблиці "Recommendation"
CREATE TABLE Recommendation (
    recommendation_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES User(user_id),
    text TEXT NOT NULL
);
