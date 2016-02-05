
--- Model that implements predatory-prey dynamics.
-- @arg data.wolves A number between 10 and 40 with the initial number of wolfes.
-- @arg data.rabbits A number between 100 and 1000 with the initial number of rabbits.
-- @arg data.preyGrowth A number between 0.01 and 1 with the probability of a prey
-- to reproduce. The default value is 0.08.
-- @arg data.preyDeathPred A number between 0.0001 and 0.01 with the probability of a prey
-- to be killed by a predator. The default value is 0.001.
-- @arg data.predDeath A number between 0.001 and 0.5 with the probability of a predator
-- to die. The default value is 0.02.
-- @arg data.predGrowthKills A number between 0 and 0.01 with the increase in the size of the
-- predator population per eack prey killed. The default value is 0.00002.
-- @arg data.finalTime The final time of the simulation. The minimum value is 50 and the
-- default value is 500.
-- @image predator-prey.bmp
PredatorPrey = Model{
	wolves          = Choice{min = 10,                 default = 40},
	rabbits         = Choice{min = 100,                default = 1000},
	preyGrowth      = Choice{min = 0.01,   max = 1,    default = 0.08},
	preyDeathPred   = Choice{min = 0.0001, max = 0.01, default = 0.001},
	predDeath       = Choice{min = 0.001,  max = 0.5,  default = 0.02},
	predGrowthKills = Choice{min = 0,      max = 0.01, default = 0.00002},
	finalTime       = Choice{min = 50,                 default = 500},
	init = function(model)
		model.step = function()
			model.rabbits = model.rabbits + model.preyGrowth * model.rabbits
			                - model.preyDeathPred * model.rabbits * model.wolves

			model.wolves = model.wolves - model.predDeath * model.wolves
			               + model.predGrowthKills * model.rabbits * model.wolves
		end

		model.timer = Timer{
			Event{action = model}
		}

		model.chart1 = Chart{
			target = model,
			select = {"rabbits", "wolves"}
		}
	
		model.chart2 = Chart{
			target = model,
			select = "rabbits",
			xAxis = "rabbits"
		}
	end
}

