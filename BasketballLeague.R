#Rounded Normal Random Numbers

rnorm_round <- function(n, mean, sd) {
  round(rnorm(n,mean,sd), digit=0)
}

#Single Game Simulation

game <- function(home_team_name, away_team_name) {
  t <- data.frame('Team' = c('Jersey Lions','Westchester Cats',
                             'Long Island Tigers','Staten Island Dogs',
                             'The Bronx Foxes','Queens Bears','Manhattan Ducks',
                             'Brooklyn Rats'), 
                  'A' = c(7,6,7,8,9,6,7,8),
                  'D' = c(7,8,6,6,6,9,6,7),
                  'H' = c(3,3,4,3,3,5,3,4),
                  'R' = c(0.5,0.25,0.3,0.25,0.2,0.35,0.2,0.25))
  
  hx <- data.frame('Team' = c(home_team_name))
  h <- data.frame(merge(hx, t, all.x = TRUE))
  ax <- data.frame('Team' = c(away_team_name))
  a <- data.frame(merge(ax, t, all.x = TRUE))
  
  mean <- (0.6*h$A + 0.4*h$D)-(0.4*a$A + 0.6*a$D)+h$H
  sd <- 1/h$R + 1/a$R
  ps <- rnorm_round(1,mean,sd)
  
  repeat {
    ps <- rnorm_round(1,mean,sd)
    if (ps != 0) {
      break
    }
  }
  
  if (ps > 0) {
    return(c(home_team_name,away_team_name,ps))
  } else {
    return(c(away_team_name,home_team_name,ps))
  }
}

#Season Schedule Simulation

library(gtools)
schedule = data.frame(permutations(n = 8, r = 2, v = c('Jersey Lions','Westchester Cats',
                                                   'Long Island Tigers','Staten Island Dogs',
                                                   'The Bronx Foxes','Queens Bears','Manhattan Ducks',
                                                   'Brooklyn Rats')))

#Playoff System
#Team 1,8,4,5

g181 <- transpose(as.data.frame(game('Queens Bears','Manhattan Ducks')))
g182 <- transpose(as.data.frame(game('Manhattan Ducks','Queens Bears')))
g18w <- if (g181[1,1] == g182[1,1]) {
  print(g181[1,1])
} else {
  g183 <- transpose(as.data.frame(game('Queens Bears','Manhattan Ducks')))
  print(g183[1,1])
}

g451 <- transpose(as.data.frame(game('Staten Island Dogs','Westchester Cats')))
g452 <- transpose(as.data.frame(game('Westchester Cats','Staten Island Dogs')))
g45w <- if (g451[1,1] == g452[1,1]) {
  print(g451[1,1])
} else {
  g453 <- transpose(as.data.frame(game('Staten Island Dogs','Westchester Cats')))
  print(g453[1,1])
}

#2nd Round Upper Half
gr21w <- if (g18w == 'Queens Bears') {
  gr211 <- transpose(as.data.frame(game(g18w,g45w)))
  gr212 <- transpose(as.data.frame(game(g45w,g18w)))
  if (gr211[1,1] == gr212[1,1]) {
    print(gr211[1,1])
  } else {
    g213 <- transpose(as.data.frame(game(g18w,g45w)))
    print(g213[1,1])
  }
} else {
  gr211 <- transpose(as.data.frame(game(g45w,g18w)))
  gr212 <- transpose(as.data.frame(game(g18w,g45w)))
  if (gr211[1,1] == gr212[1,1]) {
    print(gr211[1,1])
  } else {
    g213 <- transpose(as.data.frame(game(g45w,g18w)))
    print(g213[1,1])
  }
}

#Team 3,6,2,7
g361 <- transpose(as.data.frame(game('The Bronx Foxes','Long Island Tigers')))
g362 <- transpose(as.data.frame(game('Long Island Tigers','The Bronx Foxes')))
g36w <- if (g361[1,1] == g362[1,1]) {
  print(g361[1,1])
} else {
  g363 <- transpose(as.data.frame(game('The Bronx Foxes','Long Island Tigers')))
  print(g363[1,1])
}

g271 <- transpose(as.data.frame(game('Brooklyn Rats','Jersey Lions')))
g272 <- transpose(as.data.frame(game('Jersey Lions','Brooklyn Rats')))
g27w <- if (g271[1,1] == g272[1,1]) {
  print(g271[1,1])
} else {
  g273 <- transpose(as.data.frame(game('Brooklyn Rats','Jersey Lions')))
  print(g273[1,1])
}

#2nd Round Lower Half
gr22w <- if (g27w == 'Brooklyn Rats') {
  gr221 <- transpose(as.data.frame(game(g27w,g36w)))
  gr222 <- transpose(as.data.frame(game(g36w,g27w)))
  if (gr221[1,1] == gr222[1,1]) {
    print(gr221[1,1])
  } else {
    g223 <- transpose(as.data.frame(game(g27w,g36w)))
    print(g223[1,1])
  }
} else {
  gr221 <- transpose(as.data.frame(game(g36w,g27w)))
  gr222 <- transpose(as.data.frame(game(g27w,g36w)))
  if (gr221[1,1] == gr222[1,1]) {
    print(gr221[1,1])
  } else {
    g223 <- transpose(as.data.frame(game(g36w,g27w)))
    print(g223[1,1])
  }
} 

#3rd Round(Final Round)

gr3w <- if (gr21w == 'Queens Bears') {
  gr31 <- transpose(as.data.frame(game(gr21w,gr22w)))
  gr32 <- transpose(as.data.frame(game(gr22w,gr21w)))
  if (gr31[1,1] == gr32[1,1]) {
    print(gr31[1,1])
  } else {
    g33 <- transpose(as.data.frame(game(gr21w,gr22w)))
    print(g33[1,1])
  }
} else if (gr22w == 'Brooklyn Rats') {
  gr31 <- transpose(as.data.frame(game(gr22w,gr21w)))
  gr32 <- transpose(as.data.frame(game(gr21w,gr22w)))
  if (gr31[1,1] == gr32[1,1]) {
    print(gr31[1,1])
  } else {
    g33 <- transpose(as.data.frame(game(gr22w,gr21w)))
    print(g33[1,1])
  }
} else if (gr22w == 'The Bronx Foxes') {
  gr31 <- transpose(as.data.frame(game(gr22w,gr21w)))
  gr32 <- transpose(as.data.frame(game(gr21w,gr22w)))
  if (gr31[1,1] == gr32[1,1]) {
    print(gr31[1,1])
  } else {
    g33 <- transpose(as.data.frame(game(gr22w,gr21w)))
    print(g33[1,1])
  }
} else {
  gr31 <- transpose(as.data.frame(game(gr21w,gr22w)))
  gr32 <- transpose(as.data.frame(game(gr22w,gr21w)))
  if (gr31[1,1] == gr32[1,1]) {
    print(gr31[1,1])
  } else {
    g33 <- transpose(as.data.frame(game(gr21w,gr22w)))
    print(g33[1,1])
  }
}