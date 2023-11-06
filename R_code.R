


setwd("/Users/thanosalexandris/Downloads/katia2")

##############question1

# load csvs
df1 <- read.csv("2009.07.01_mentioned.csv")
df2 <- read.csv("2009.07.02_mentioned.csv")
df3 <- read.csv("2009.07.03_mentioned.csv")
df4 <- read.csv("2009.07.04_mentioned.csv")
df5 <- read.csv("2009.07.05_mentioned.csv")

topics1<-read.csv("2009.07.01_topic_of_interest.csv")
topics2<-read.csv("2009.07.02_topic_of_interest.csv")
topics3<-read.csv("2009.07.03_topic_of_interest.csv")
topics4<-read.csv("2009.07.04_topic_of_interest.csv")
topics5<-read.csv("2009.07.05_topic_of_interest.csv")


library(igraph)


#igrapgs
ig1 <- graph_from_data_frame(df1, directed=TRUE)
ig2 <- graph_from_data_frame(df2, directed=TRUE)
ig3 <- graph_from_data_frame(df3, directed=TRUE)
ig4 <- graph_from_data_frame(df4, directed=TRUE)
ig5 <- graph_from_data_frame(df5, directed=TRUE)

V(ig1)$topics <- topics1$topic_of_interest[match(V(ig1)$name, topics1$user)]
V(ig2)$topics <- topics2$topic_of_interest[match(V(ig2)$name, topics2$user)]
V(ig3)$topics <- topics3$topic_of_interest[match(V(ig3)$name, topics3$user)]
V(ig4)$topics <- topics4$topic_of_interest[match(V(ig4)$name, topics4$user)]
V(ig5)$topics <- topics5$topic_of_interest[match(V(ig5)$name, topics5$user)]


print(ig1, e=TRUE, v=TRUE)
print(ig2, e=TRUE, v=TRUE)
print(ig3, e=TRUE, v=TRUE)
print(ig4, e=TRUE, v=TRUE)
print(ig5, e=TRUE, v=TRUE)


########Question2

#metrics
five_days_number_of_vertices <- c(vcount(ig1), vcount(ig2), vcount(ig3), vcount(ig4), vcount(ig5)) 
five_days_number_of_edges<-c(ecount(ig1), ecount(ig2), ecount(ig3), ecount(ig4), ecount(ig5)) 
five_days_diameter<-c(diameter(ig1), diameter(ig2), diameter(ig3), diameter(ig4), diameter(ig5)) 
five_days_avg_indegree<-c(mean(degree(ig1, mode="in")), mean(degree(ig2, mode="in")), mean(degree(ig3, mode="in")),mean(degree(ig4, mode="in")),mean(degree(ig1, mode="in")))
five_days_avg_outdegree<-c(mean(degree(ig1, mode="out")), mean(degree(ig2, mode="out")), mean(degree(ig3, mode="out")),mean(degree(ig4, mode="out")),mean(degree(ig1, mode="out")))

legends<-c("1st of July", "2nd of July", "3rd of July", "4th of July", "5th of July")

df_plot<-data.frame(legends,five_days_number_of_vertices,five_days_number_of_edges,five_days_diameter,five_days_avg_indegree,five_days_avg_outdegree)



#number of vertices plot
barplot(df_plot$five_days_number_of_vertices, names.arg = legends, xlab = "Days", ylab = "Vertices", main = "Number of Vertices", ylim = c(0, 550000))
par(cex.axis = 0.7, las = 1)
text(x = 1:length(df_plot$five_days_number_of_vertices), y = df_plot$five_days_number_of_vertices, labels = df_plot$five_days_number_of_vertices, pos = 3)



#number of edges plot
barplot(df_plot$five_days_number_of_edges, names.arg = legends, xlab = "Days", ylab = "Edges", main = "Number of Edges", ylim = c(0, 600000))
par(cex.axis = 0.7, las = 1)
text(x = 1:length(df_plot$five_days_number_of_edges), y = df_plot$five_days_number_of_edges, labels = df_plot$five_days_number_of_edges, pos = 3)


#diameter plot
barplot(df_plot$five_days_diameter, names.arg = legends, xlab = "Days", ylab = "Diameter", main = "Diameter", ylim = c(0, 100))
par(cex.axis = 0.7, las = 1)  
text(x = 1:length(df_plot$five_days_diameter), y = df_plot$five_days_diameter, labels = df_plot$five_days_diameter, pos = 3)

#Average in-degree
barplot(df_plot$five_days_avg_indegree, names.arg = legends, xlab = "Days", ylab = "in-degree", main = "in-degree", ylim = c(0, 1.5))
par(cex.axis = 0.7, las = 1)  
text(x = 1:length(round(df_plot$five_days_avg_indegree,4)), y = round(df_plot$five_days_avg_indegree,4), labels = round(df_plot$five_days_avg_indegree,4), pos = 3)

#Average out-degree
barplot(df_plot$five_days_avg_outdegree, names.arg = legends, xlab = "Days", ylab = "out-degree", main = "out-degree", ylim = c(0, 1.5))
par(cex.axis = 0.7, las = 1)  
text(x = 1:length(round(df_plot$five_days_avg_outdegree,4)), y = round(df_plot$five_days_avg_outdegree,4), labels = round(df_plot$five_days_avg_outdegree,4), pos = 3)


#########question 3

#top-10-indegree
day1_top10_in_degree<-head(sort(degree(ig1, mode="in"), decreasing=TRUE), 10)
day2_top10_in_degree<-head(sort(degree(ig2, mode="in"), decreasing=TRUE), 10)
day3_top10_in_degree<-head(sort(degree(ig3, mode="in"), decreasing=TRUE), 10)
day4_top10_in_degree<-head(sort(degree(ig4, mode="in"), decreasing=TRUE), 10)
day5_top10_in_degree<-head(sort(degree(ig5, mode="in"), decreasing=TRUE), 10)

#5day-evolution in-degree

five_days_top10_indegree_nodes <- data.frame(
  Node_01.07 = names(day1_top10_in_degree),
  Node_02.07 = names(day2_top10_in_degree),
  Node_03.07 = names(day3_top10_in_degree),
  Node_04.07 = names(day4_top10_in_degree),
  Node_05.07 = names(day5_top10_in_degree)
)
rownames(five_days_top10_indegree_nodes) <- 1:10

View(five_days_top10_indegree_nodes)



#top-10-outdegree
day1_top10_out_degree<-head(sort(degree(ig1, mode="out"), decreasing=TRUE), 10)
day2_top10_out_degree<-head(sort(degree(ig2, mode="out"), decreasing=TRUE), 10)
day3_top10_out_degree<-head(sort(degree(ig3, mode="out"), decreasing=TRUE), 10)
day4_top10_out_degree<-head(sort(degree(ig4, mode="out"), decreasing=TRUE), 10)
day5_top10_out_degree<-head(sort(degree(ig5, mode="out"), decreasing=TRUE), 10)

#5day-evolution out-degree
five_days_top10_outdegree_nodes <- data.frame(
  Node_01.07 = names(day1_top10_out_degree),
  Node_02.07 = names(day2_top10_out_degree),
  Node_03.07 = names(day3_top10_out_degree),
  Node_04.07 = names(day4_top10_out_degree),
  Node_05.07 = names(day5_top10_out_degree)
)
rownames(five_days_top10_outdegree_nodes) <- 1:10

View(five_days_top10_outdegree_nodes)


#top-10-pagerank
day1_top10_pagerank<-head(sort(page.rank(ig1)$vector, decreasing=TRUE), 10)
day2_top10_pagerank<-head(sort(page.rank(ig2)$vector, decreasing=TRUE), 10)
day3_top10_pagerank<-head(sort(page.rank(ig3)$vector, decreasing=TRUE), 10)
day4_top10_pagerank<-head(sort(page.rank(ig4)$vector, decreasing=TRUE), 10)
day5_top10_pagerank<-head(sort(page.rank(ig5)$vector, decreasing=TRUE), 10)

#5day-evolution page rank

five_days_top10_pagerank_nodes <- data.frame(
  Node_01.07 = names(day1_top10_pagerank),
  Node_02.07 = names(day2_top10_pagerank),
  Node_03.07 = names(day3_top10_pagerank),
  Node_04.07 = names(day4_top10_pagerank),
  Node_05.07 = names(day5_top10_pagerank)
)
rownames(five_days_top10_pagerank_nodes) <- 1:10

View(five_days_top10_pagerank)



#question 4

#undirected graphs
ig1_und<-as.undirected(ig1)
ig2_und<-as.undirected(ig2)
ig3_und<-as.undirected(ig3)
ig4_und<-as.undirected(ig4)
ig5_und<-as.undirected(ig5)

#communities fast greedy###have not run after hours
fast_greed_comm1 <- cluster_fast_greedy(ig1_und)
fast_greed_comm2 <- cluster_fast_greedy(ig2_und)
fast_greed_comm3 <- cluster_fast_greedy(ig3_und)
fast_greed_comm4 <- cluster_fast_greedy(ig4_und)
fast_greed_comm5 <- cluster_fast_greedy(ig5_und)

#communities infomap###have not run after hours
infomap_comm1 <- cluster_infomap(ig1_und)
infomap_comm2 <- cluster_infomap(ig2_und)
infomap_comm3 <- cluster_infomap(ig3_und)
infomap_comm4 <- cluster_infomap(ig4_und)
infomap_comm5 <- cluster_infomap(ig5_und)

#communities louvain
louvain_comm1 <- cluster_louvain(ig1_und)
louvain_comm2 <- cluster_louvain(ig2_und)
louvain_comm3 <- cluster_louvain(ig3_und)
louvain_comm4 <- cluster_louvain(ig4_und)
louvain_comm5 <- cluster_louvain(ig5_und)

# random user that appears in all 5 graphs
common_users <- Reduce(intersect, list(louvain_comm1$names, louvain_comm2$names, 
                                       louvain_comm3$names, louvain_comm4$names,
                                       louvain_comm5$names))

random_user<- sample(common_users, 1)

graphs_list<-list(ig1_und,ig2_und,ig3_und,ig4_und,ig5_und)
communities_list<-list(louvain_comm1,louvain_comm2,louvain_comm3,louvain_comm4,louvain_comm5)


# Initialize a list to store the community membership for each graph
community_membership <- list()

# Iterate over the 5 graphs
for (i in 1:5) {
  # Find the community membership of the selected user in each graph
  graph <- graphs_list[[i]] 
  community <- membership(communities_list[[i]])  
  user_community <- community[which(V(graphs_list[[i]])$name == random_user)]
 
  # Store the community membership for the current graph
  community_membership[[i]] <- user_community
}


community1 <- membership(louvain_comm1)
# Analyze the evolution of the community membership
for (i in 1:5) {
  cat("Day", i, "Community_id:", community_membership[[i]], "\n")
  
}



community_membership[[1]]
sum(membership(louvain_comm1)==community_membership[[1]])
sum(membership(louvain_comm2)==community_membership[[2]])
sum(membership(louvain_comm3)==community_membership[[3]])
sum(membership(louvain_comm4)==community_membership[[4]])
sum(membership(louvain_comm5)==community_membership[[5]])


communities<-list(louvain_comm1[community_membership[[1]]]$'74',
                  louvain_comm2[community_membership[[2]]]$'25',
                  louvain_comm3[community_membership[[3]]]$'28',
                  louvain_comm4[community_membership[[4]]]$'63',
                  louvain_comm5[community_membership[[5]]]$'26')

communities[[1]]
# Initialize a matrix to store the number of common users between communities
num_common_users <- matrix(0, nrow = 5, ncol = 5)

# Loop through each pair of communities
for (i in 1:4) {
  for (j in (i+1):5) {
    # Get the membership vectors of the communities
    membership1 <- communities[[i]]
    membership2 <- communities[[j]]
    
    # Find the common users between the two communities
    common_users <- intersect(membership1, membership2)
    
    # Update the number of common users in the matrix
    num_common_users[i, j] <- length(common_users)
    num_common_users[j, i] <- length(common_users)
  }
}

# Print the number of common users between each pair of communities
print(num_common_users)


list_of_lists<-list()



###topics of the communities
# Loop over the node IDs and retrieve attribute values

for (i in 1:5){
  new_list<-list()
  for (node in 1:length(communities[[i]])) {
    new_list[[node]] <- V(graphs_list[[i]])[node]$topics
  }
  list_of_lists[[i]] <- new_list[new_list != ""]
}

for (i in 1:5){
  # Combine all sub-lists into a single vector
  combined_list <- unlist(list_of_lists[[i]])
  
  # Compute the frequencies of each value
  frequency_table <- table(combined_list)
  
  # Find the value(s) with the highest count(s)
  most_frequent_values <- names(frequency_table)[frequency_table == max(frequency_table)]
  
  # Print the most frequent value(s)
  print(most_frequent_values)
}

num_common_topics <- matrix(0, nrow = 5, ncol = 5)

# Loop through each pair of communities
for (i in 1:4) {
  for (j in (i+1):5) {
  
    # Find the common topics between the two communities
    common_topics <- intersect(list_of_lists[[i]], list_of_lists[[j]])
    
    # Update the number of common topics in the matrix
    num_common_topics[i, j] <- length(common_topics)
    num_common_topics[j, i] <- length(common_topics)
  }
}

# Print the number of common topics between each pair of communities
print(num_common_topics)



# plot communities 1st July

#  exclude very small or very large communities
included_communities1 <- unlist(louvain_comm1[sizes(louvain_comm1) > 50 & sizes(louvain_comm1) < 100])

# Subgraph
sub1 <- induced.subgraph(ig1_und, included_communities1)

# Plot 
plot(sub1, vertex.color=rainbow(30, alpha=0.8)[louvain_comm1$membership], vertex.label=NA, edge.arrow.size=0.55, vertex.size=6,
      edge.arrow.width = 0.1, edge.arrow.size = 0.9,  main="Communities 1st July")


# plot communities 2nd July

#  exclude very small or very large communities
included_communities2 <- unlist(louvain_comm2[sizes(louvain_comm2) > 50 & sizes(louvain_comm2) < 100])

# Subgraph
sub2 <- induced.subgraph(ig2_und, included_communities2)

# Plot 
plot(sub2, vertex.color=rainbow(30, alpha=0.8)[louvain_comm2$membership], vertex.label=NA, edge.arrow.size=0.55, vertex.size=6,
      edge.arrow.width = 0.1, edge.arrow.size = 0.9,  main="Communities 2nd July")


# plot communities 3rd July

#  exclude very small or very large communities
included_communities3 <- unlist(louvain_comm3[sizes(louvain_comm3) > 50 & sizes(louvain_comm3) < 100])

# Subgraph
sub3 <- induced.subgraph(ig3_und, included_communities3)

# Plot 
plot(sub3, vertex.color=rainbow(30, alpha=0.8)[louvain_comm3$membership], vertex.label=NA, edge.arrow.size=0.55, vertex.size=6,
      edge.arrow.width = 0.1, edge.arrow.size = 0.9,  main="Communities 3rd July")

# plot communities 4th July

#  exclude very small or very large communities
included_communities4 <- unlist(louvain_comm4[sizes(louvain_comm4) > 50 & sizes(louvain_comm4) < 100])

# Subgraph
sub4 <- induced.subgraph(ig4_und, included_communities4)

# Plot those mid-size communities
plot(sub4, vertex.color=rainbow(30, alpha=0.8)[louvain_comm4$membership], vertex.label=NA, edge.arrow.size=0.55, vertex.size=6,
      edge.arrow.width = 0.1, edge.arrow.size = 0.9,  main="Communities 4th July")


# plot communities 5th July

#  exclude very small or very large communities
included_communities5 <- unlist(louvain_comm5[sizes(louvain_comm5) > 50 & sizes(louvain_comm5) < 100])

# Subgraph
sub5 <- induced.subgraph(ig5_und, included_communities5)

# Plot those mid-size communities
plot(sub5, vertex.color=rainbow(30, alpha=0.8)[louvain_comm5$membership], vertex.label=NA, edge.arrow.size=0.55, vertex.size=6,
     edge.arrow.width = 0.1, edge.arrow.size = 0.9,  main="Communities 5th July")

