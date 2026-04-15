# Blinking Effect on Synchronization Control

[cite_start]This repository contains the MATLAB implementations developed for the study "Blinking effect on synchronization control". The project explores the synchronization of a specific subset of nodes within a dynamical network using time-varying (blinking) controllers.

## Project Overview
[cite_start]The research focuses on a network of **20 identical Chua's Oscillators** connected by 23 edges[cite: 97]. [cite_start]The main goal is to achieve synchronization between **Node 4** and **Node 12**[cite: 123]. [cite_start]While the original network does not reach global synchronization, the application of an additional layer of "blinking" links—based on a specific mathematical theorem—allows these target nodes to synchronize their trajectories[cite: 70, 852].

## Mathematical Model
[cite_start]Each node in the network is a chaotic Chua's oscillator defined by the following dimensionless equations[cite: 98, 99, 100, 101]:

- $\dot{x}_{1} = \alpha(x_{2} - x_{1} + g(x_{1}))$
- $\dot{x}_{2} = x_{1} - x_{2} + x_{3}$
- $\dot{x}_{3} = -\beta x_{2} - \gamma x_{3}$

**Simulation Parameters:**
- [cite_start]**Oscillator constants**: $\alpha = 10$, $\beta = 15$, $\gamma = 0.0385$[cite: 103].
- [cite_start]**Non-linear function $g(x_1)$**: $a = -1.27$, $b = -0.68$[cite: 102].
- [cite_start]**Coupling strength ($\sigma$)**: 2[cite: 103].

## Repository Content
The repository includes two main simulation scripts that implement the **Blinking Effect** in different ways:

### 1. `chua_oscillators_fixed_laplacian`
[cite_start]In this implementation, an augmented Laplacian matrix ($L''$) containing the control links is created *a priori*[cite: 90]. [cite_start]During the simulation, the controller switches the entire coupling configuration between the original state ($L$) and the augmented state ($L''$) based on a probability $p$[cite: 89, 396].

### 2. `chua_oscillators_unfixed_laplacian`
[cite_start]In this version, the control links are generated dynamically[cite: 90]. [cite_start]Each potential link in the control layer ($L'$) is independently activated or set to zero at each time step with a probability $p$[cite: 91, 397].

## How to Run
1. Open MATLAB.
2. Run either script to start the simulation.
3. [cite_start]The simulation will iterate through a probability vector (typically `logspace(-2, 0, 21)`) to evaluate the effect of $p$ on synchronization[cite: 307, 383].

## Results and Metrics
[cite_start]The scripts generate plots for[cite: 390, 435]:
- [cite_start]**Global Error**: The overall synchronization error of the 20-node network[cite: 66].
- [cite_start]**Synchronization Error (Nodes 4 & 12)**: The specific error between the two nodes targeted for control[cite: 257].
- [cite_start]**Average Error vs. Probability**: A semilogarithmic chart showing how the synchronization error decreases as the blinking probability $p$ increases[cite: 604, 853].

## References
- [1] M. Frasca, L. V. Gambuzza, et al. [cite_start]*Synchronization in Networks of Nonlinear Circuits*, Springer 2018[cite: 868].
- [2] L. V. Gambuzza, M. Frasca, V. Latora. [cite_start]"Distributed control of synchronization of a group of network nodes", *IEEE Transactions on Automatic Control*, 2019[cite: 869, 870].

---
*Implementation based on the Bachelor's Thesis by Carmelo Pirosa (2019), Università degli Studi di Catania.*
