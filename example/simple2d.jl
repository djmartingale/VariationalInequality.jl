# using JuMP, JuVI
# using Base.Test

using JuMP, Ipopt
include("../src/model.jl")
include("../src/algorithms.jl")

# https://cdr.lib.unc.edu/indexablecontent/uuid:778ca632-74ca-4858-8c3c-6dcfc7e6e703
# Example 3.9. I created this simple two dimenional example for testing.
m = JuVIModel()

@defVar(m, x[1:2])

@addNLConstraint(m, x[1]^2 + x[2]^2 <= 1)

@defNLExpr(m, F1, 3x[1] + x[2] - 5)
@defNLExpr(m, F2, 2x[1] + 5x[2] - 3)
F = [F1, F2]
setVIP(m, F, x)

sol1, Fval1 = solveVIP(m, algorithm=:extra_gradient, max_iter=1000, step_size=0.1)
sol2, Fval2 = solveVIP(m, algorithm=:hyperplane, max_iter=1000, step_size=0.1)

println(sol1)
println(sol2)

# (0.9890, 0.1480)