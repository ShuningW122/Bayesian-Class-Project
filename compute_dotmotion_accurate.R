# set path
input_folder <- "/Users/wangshuning/Desktop/USC/24Fall/573Bayesian/project/intermediate"
output_file <- "/Users/wangshuning/Desktop/USC/24Fall/573Bayesian/project/project/project8_accuracy_dotmotion_summary.csv"

# get all files path
files <- list.files(input_folder, pattern = "_dotmotion.csv", full.names = TRUE)


results <- data.frame()

# loop each file
for (file in files) {
  # read data files
  data <- read.csv(file)
  
  # get subject_id
  subject_id <- gsub("_dotmotion.csv", "", basename(file))
  
  # -------- pre_training  -------- #
  pre_training_data <- subset(data, block == "pre_training" & event == "dot_motion")
  preTraining_trialsNum_hard <- sum(pre_training_data$choice == "hard")
  preTraining_trialsNum_easy <- sum(pre_training_data$choice == "easy")
  preTraining_trialsNum_hard_accurate <- sum(pre_training_data$choice == "hard" & pre_training_data$acc == 1)
  preTraining_trialsNum_easy_accurate <- sum(pre_training_data$choice == "easy" & pre_training_data$acc == 1)
  preTraining_accurate_ratio_hard <- preTraining_trialsNum_hard_accurate / preTraining_trialsNum_hard
  preTraining_accurate_ratio_easy <- preTraining_trialsNum_easy_accurate / preTraining_trialsNum_easy
  
  # -------- post_training  -------- #
  post_training_data <- subset(data, block == "post_training" & event == "dot_motion")
  postTraining_trialsNum_hard <- sum(post_training_data$choice == "hard")
  postTraining_trialsNum_easy <- sum(post_training_data$choice == "easy")
  postTraining_trialsNum_hard_accurate <- sum(post_training_data$choice == "hard" & post_training_data$acc == 1)
  postTraining_trialsNum_easy_accurate <- sum(post_training_data$choice == "easy" & post_training_data$acc == 1)
  postTraining_accurate_ratio_hard <- postTraining_trialsNum_hard_accurate / postTraining_trialsNum_hard
  postTraining_accurate_ratio_easy <- postTraining_trialsNum_easy_accurate / postTraining_trialsNum_easy
  
  # -------- training reward trials  -------- #
  training_reward_data <- subset(data, block == "training" & cue_type == "reward" & event == "rockets")
  N_hard <- sum(training_reward_data$choice == "hard")
  N_easy <- sum(training_reward_data$choice == "easy")
  Training_Reward_trialsNum_hard <- N_hard * 3
  Training_Reward_trialsNum_easy <- N_easy * 3
  Training_reward_accurate_ratio_hard <- mean(training_reward_data$acc[training_reward_data$choice == "hard"], na.rm = TRUE)
  Training_reward_accurate_ratio_easy <- mean(training_reward_data$acc[training_reward_data$choice == "easy"], na.rm = TRUE)
  Training_Reward_trialsNum_hard_accurate <- round(Training_reward_accurate_ratio_hard * Training_Reward_trialsNum_hard)
  Training_Reward_trialsNum_easy_accurate <- round(Training_reward_accurate_ratio_easy * Training_Reward_trialsNum_easy)
  
  # -------- training probe (unrewarded) trials  -------- #
  training_probe_data <- subset(data, block == "training" & cue_type == "probe" & event == "rockets")
  N_hard <- sum(training_probe_data$choice == "hard")
  N_easy <- sum(training_probe_data$choice == "easy")
  Training_probe_trialsNum_hard <- N_hard * 3
  Training_probe_trialsNum_easy <- N_easy * 3
  Training_probe_accurate_ratio_hard <- mean(training_probe_data$acc[training_probe_data$choice == "hard"], na.rm = TRUE)
  Training_probe_accurate_ratio_easy <- mean(training_probe_data$acc[training_probe_data$choice == "easy"], na.rm = TRUE)
  Training_probe_trialsNum_hard_accurate <- round(Training_probe_accurate_ratio_hard * Training_probe_trialsNum_hard)
  Training_probe_trialsNum_easy_accurate <- round(Training_probe_accurate_ratio_easy * Training_probe_trialsNum_easy)
  
  # -------- preTrainingRatio_MeasureError -------- #
  preTrainingRatio_MeasureError_easy <- sqrt(preTraining_accurate_ratio_easy * (1 - preTraining_accurate_ratio_easy) / preTraining_trialsNum_easy_accurate)
  preTrainingRatio_MeasureError_hard <- sqrt(preTraining_accurate_ratio_hard * (1 - preTraining_accurate_ratio_hard) / preTraining_trialsNum_hard_accurate)
  
  # -------- get condition value -------- #
  condition <- data$condition[2]
  
  # -------- summarize results -------- #
  output <- data.frame(
    title = c(subject_id, subject_id),
    condition = c(condition, condition),
    difficulty = c("easy", "hard"),
    preTraining_trialsNum = c(preTraining_trialsNum_easy, preTraining_trialsNum_hard),
    preTraining_accurate_trialsNum = c(preTraining_trialsNum_easy_accurate, preTraining_trialsNum_hard_accurate),
    preTraining_accurate_ratio = c(preTraining_accurate_ratio_easy, preTraining_accurate_ratio_hard),
    postTraining_trialsNum = c(postTraining_trialsNum_easy, postTraining_trialsNum_hard),
    postTraining_accurate_trialsNum = c(postTraining_trialsNum_easy_accurate, postTraining_trialsNum_hard_accurate),
    postTraining_accurate_ratio = c(postTraining_accurate_ratio_easy, postTraining_accurate_ratio_hard),
    Training_Reward_trialsNum = c(Training_Reward_trialsNum_easy, Training_Reward_trialsNum_hard),
    Training_Reward_accurate_trialsNum = c(Training_Reward_trialsNum_easy_accurate, Training_Reward_trialsNum_hard_accurate),
    Training_Reward_accurate_trialsNum_ratio = c(Training_reward_accurate_ratio_easy, Training_reward_accurate_ratio_hard),
    Training_probe_trialsNum = c(Training_probe_trialsNum_easy, Training_probe_trialsNum_hard),
    Training_probe_accurate_trialsNum = c(Training_probe_trialsNum_easy_accurate, Training_probe_trialsNum_hard_accurate),
    Training_probe_accurate_trialsNum_ratio = c(Training_probe_accurate_ratio_easy, Training_probe_accurate_ratio_hard),
    preTrainingRatio_MeasureError = c(preTrainingRatio_MeasureError_easy, preTrainingRatio_MeasureError_hard)
  )
  
  # combine results
  results <- rbind(results, output)
}

# write results intp csv file
write.csv(results, output_file, row.names = FALSE)


