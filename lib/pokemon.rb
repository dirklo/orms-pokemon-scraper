class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize(entry)
        @id = entry[:id]
        @name = entry[:name]
        @type = entry[:type]
        @db = entry[:db]
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?);
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id = ?;
        SQL

        pokemon = db.execute(sql, id)
        object = {
            :id=>pokemon[0][0],
            :name=>pokemon[0][1],
            :type=>pokemon[0][2],
            :db=>db
        }
        Pokemon.new(object)
    end
end
