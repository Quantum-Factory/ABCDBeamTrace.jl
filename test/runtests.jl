using ABCDBeamTrace
@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

# general test setup
f = 100e-3
L = 1000e-3
w0 = 1.0e-3
expander_2x = [ThinLens(f=f), FreeSpace(3f), ThinLens(f=2f)]
system = [expander_2x; FreeSpace(L); reverse(expander_2x)]
beam = Beam(λ = 1000e-9, w0 = w0)

@testset "beamtrace" begin
    @test beamtrace(system, beam) isa Vector{Beam}
end

@testset "discretize" begin
    @test length(discretize(expander_2x,10)) == 12
end

@testset "waistradiusfunc" begin
    @test waistradiusfunc(expander_2x, beam) isa Function
    @test waistradiusfunc(expander_2x, beam)(0) == w0
    @test waistradiusfunc(expander_2x, beam)(3f) ≈ 2w0 rtol=0.01
end
