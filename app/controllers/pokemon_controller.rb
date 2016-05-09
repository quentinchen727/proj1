class PokemonController < ApplicationController
  def capture()
    trainless_pokemon = Pokemon.all.find(params[:id])
    trainless_pokemon.trainer_id = current_trainer.id
    trainless_pokemon.save
    redirect_to root_path
  end

  def damage
    trained_pokemon = Pokemon.all.find(params[:id])
    trained_pokemon.health -= 10
    if trained_pokemon.health <= 0
      trained_pokemon.destroy
    else
      trained_pokemon.save
    end
   # redirect_to "/trainers/"+current_trainer.id.to_s+"/edit"
    redirect_to edit_trainer_registration_path
  end

  def new

  end

  def create
    new_pokeman = Pokemon.new(name:params[:pokemon][:name], health:100, level:1, trainer_id: current_trainer.id)
    if new_pokeman.valid?
      new_pokeman.save
      redirect_to edit_trainer_registration_path
    else
      #flash[:error] = "empty or duplicate pokemon name"
      flash[:error] = new_pokeman.errors.full_messages.to_sentence
      redirect_to new_path
    end
  end
end
