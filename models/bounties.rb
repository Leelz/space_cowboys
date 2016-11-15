require('pg')

class Bounty
  attr_accessor :bounty_value, :favourite_weapon
  attr_reader :name, :homeworld

  def initialize( options )
    @name = options['name']
    @favourite_weapon = options['favourite_weapon']
    @bounty_value = options['bounty_value'].to_i
    @homeworld = options['homeworld']
    @id = options['id'].to_i if options['id']
  end

  def save
    db = PG.connect(  { dbname: 'space_cowboys', host: 'localhost' }  )
    sql =
    "INSERT INTO bounties
    (name, favourite_weapon, bounty_value, homeworld)
    VALUES
    ('#{@name}',  '#{@favourite_weapon}', #{@bounty_value}, '#{@homeworld}') returning *;"
    result = db.exec(sql)
    @id = result[0]['id'].to_i
    db.close
  end

  def delete
    return unless @id
    db = PG.connect(  { dbname: 'space_cowboys', host: 'localhost' }  )
    sql = "DELETE FROM bounties WHERE id = #{@id};"
    db.exec(sql)
    db.close
  end

  def update
    return unless @id
    db = PG.connect(  { dbname: 'space_cowboys', host: 'localhost' }  )
    sql = "UPDATE bounties SET
    (name, favourite_weapon, bounty_value, homeworld) =
    ('#{@name}',  '#{@favourite_weapon}', #{@bounty_value}, '#{@homeworld}') WHERE id = #{@id};"
    db.exec(sql)
    db.close
  end

  def self.all
    db = PG.connect(  { dbname: 'space_cowboys', host: 'localhost' }  )
    sql = "SELECT * FROM bounties;"
    bounties = db.exec(sql)
    db.close
    return bounties.map { |hash| Bounty.new(hash)}
  end

  def self.delete_all
    db = PG.connect(  { dbname: 'space_cowboys', host: 'localhost' }  )
    sql = "DELETE FROM bounties;"
    db.exec(sql)
    db.close
  end

end