require('pry-byebug')
require_relative('models/bounties')

Bounty.delete_all

bounty1 = Bounty.new({
  "name" => "Satan",
  "favourite_weapon" => "Fork",
  "bounty_value" => "1000",
  "homeworld" => "Hell"
  })

bounty2 = Bounty.new({
  "name" => "Voldemort",
  "favourite_weapon" => "Elder Wand",
  "bounty_value" => "5000",
  "homeworld" => "The Chamber of Secrets"
  })

bounty3 = Bounty.new({
  "name" => "Sauron",
  "favourite_weapon" => "The Eye",
  "bounty_value" => "10000",
  "homeworld" => "Mordor"
  })

bounty1.save()
bounty2.save()
bounty3.save()

bounty1.bounty_value = "2000"
bounty1.favourite_weapon = "Sword of Judgement"
bounty1.update()

bounties = Bounty.all()

binding.pry
nil