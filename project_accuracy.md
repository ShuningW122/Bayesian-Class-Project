# Project_accuracy
Shuning Wang, April Luo, Chang Lu
2024-12-03

- [Data Import](#data-import)
- [Analysis](#analysis)
- [Results](#results)

## Data Import

> Does accuracy on rewarded trials in the training section differ
> between the effort and performance conditions?

## Analysis

We used 4 chains, each with 8,000 iterations (first 4,000 as warm-ups).

# Results

     Family: binomial 
      Links: mu = logit 
    Formula: Training_Reward_accurate_trialsNum | trials(Training_Reward_trialsNum) ~ condition + difficulty + me(preTraining_accurate_ratio, preTrainingRatio_MeasureError) + (1 | subj) 
       Data: dot_accuracy[condition %in% e_vs_p] (Number of observations: 926) 
      Draws: 4 chains, each with iter = 8000; warmup = 4000; thin = 1;
             total post-warmup draws = 16000

    Multilevel Hyperparameters:
    ~subj (Number of levels: 509) 
                  Estimate Est.Error l-95% CI u-95% CI Rhat Bulk_ESS Tail_ESS
    sd(Intercept)     0.68      0.03     0.62     0.74 1.00     6396    10642

    Regression Coefficients:
                                                              Estimate Est.Error
    Intercept                                                    -5.08      0.41
    conditioneffort                                               0.12      0.07
    difficultyhard                                               -0.93      0.05
    mepreTraining_accurate_ratiopreTrainingRatio_MeasureError     8.45      0.43
                                                              l-95% CI u-95% CI
    Intercept                                                    -5.90    -4.28
    conditioneffort                                              -0.02     0.27
    difficultyhard                                               -1.03    -0.83
    mepreTraining_accurate_ratiopreTrainingRatio_MeasureError     7.63     9.31
                                                              Rhat Bulk_ESS
    Intercept                                                 1.00     6665
    conditioneffort                                           1.00     7869
    difficultyhard                                            1.00    15056
    mepreTraining_accurate_ratiopreTrainingRatio_MeasureError 1.00     6717
                                                              Tail_ESS
    Intercept                                                    10274
    conditioneffort                                               9971
    difficultyhard                                               13019
    mepreTraining_accurate_ratiopreTrainingRatio_MeasureError    10119

    Draws were sampled using sampling(NUTS). For each parameter, Bulk_ESS
    and Tail_ESS are effective sample size measures, and Rhat is the potential
    scale reduction factor on split chains (at convergence, Rhat = 1).

![](project_accuracy_files/figure-commonmark/unnamed-chunk-5-1.png)

    Using 10 posterior draws for ppc type 'dens_overlay' by default.

    Warning: Noise-free latent variables were not saved. You can control saving
    those variables via 'save_pars()'. Treating original data as if it was new data
    as a workaround.

![](project_accuracy_files/figure-commonmark/unnamed-chunk-6-1.png)

![](project_accuracy_files/figure-commonmark/unnamed-chunk-7-1.png)

<a href="#tbl-summ-fit1" class="quarto-xref">Table 1</a> shows the
posterior distributions of b_conditioneffort, b_Y_pretraining,
b_Intercept.

<div id="tbl-summ-fit1">

Table 1: Posterior summary of the model parameters.

<div class="cell-output-display">

| variable | mean | median | sd | mad | q5 | q95 | rhat | ess_bulk | ess_tail |
|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| b_Intercept | -5.079 | -5.067 | 0.414 | 0.409 | -5.768 | -4.408 | 1.000 | 6664.807 | 10273.522 |
| b_conditioneffort | 0.122 | 0.123 | 0.074 | 0.075 | 0.001 | 0.244 | 1.000 | 7868.581 | 9970.768 |
| b_difficultyhard | -0.934 | -0.934 | 0.050 | 0.050 | -1.018 | -0.851 | 1.001 | 15056.170 | 13018.674 |
| bsp_mepreTraining_accurate_ratiopreTrainingRatio_MeasureError | 8.453 | 8.441 | 0.428 | 0.427 | 7.763 | 9.172 | 1.000 | 6716.715 | 10119.013 |

</div>

</div>
