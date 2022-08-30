rm(list=ls())
library('PerformanceAnalytics')
library("maxLik")

data = read.csv(file="2020.csv", header = TRUE, sep=";")

x = data$ilosc
table.Stats(x)
sd(x)
x=as.numeric(x)
View(data)
N = length(x)
hist(x, main='PM10 measurement histogram in 2020')
mean(x)
#####  log-normal distribution

lnL = function(params) {
  mu = params[1]
  sigma = params[2]
  ll = -N/2*log(2*pi)-N*log(sigma)-sum((x-mu)^2)/(2*sigma^2)-log(sum(x))
  return(ll)
}

# gradient
gr = function(params) {
  mu = params[1]
  sigma = params[2]
  gr = c(0,0)
  gr[1] = sum(x-mu) / sigma^2
  gr[2] = -N/sigma + sum((x-mu)^2) / sigma^3
  return(gr)
}

# hessjan
he = function(params) {
  mu = params[1]
  sigma = params[2]
  h = matrix(0, 2, 2)
  h[1,1] = -N/sigma^2
  h[2,2] = N/sigma^2-3*sum((x-mu)^2)/sigma^4
  h[1,2] = -2*sum(x-mu)/sigma^3
  h[2,1] = -2*sum(x-mu)/sigma^3
  return(h)
}

res = maxNR(fn=lnL, grad=gr, hess=he, start=c(1,1))
res$estimate
summary(res)
#21.647541  9.800177; grad: 6.748950e-14, 3.397815e-11


# Z stat

vcov = -solve(res$hessian) / N
std.err.mu = sqrt(vcov[1,1])
z_test = (res$estimate[1]-(40))/std.err.mu
z_test
wart.krytyczna = qnorm(0.975, 0,1)
wart.krytyczna
p.value = 2*(1-pnorm(abs(z_test), mean=0, sd=1))
p.value# reject null hipotesis H0



# Will not exceed 40, sigma=10
lnL_U = res$maximum
# model with constraints
lnL_R = lnL(c(40, 10))
LR_test = (2*(lnL_U-lnL_R))
alpha = 0.05
g=2
qchisq(p=1-alpha, df=g)
p.value=1-pchisq(LR_test,df=g)
round(p.value, 5)#reject null hipotesis H0





###  weibull distribution
lnL = function(params) {
  k = params[1]
  lambda = params[2]
  ll = N*log(k)-k*N*log(lambda)+(k-1)*sum(log(x))-sum((x/lambda)^k)
  return(ll)
}


gradient=function(params){
  k= params[1]
  lambda = params[2]
  gr=c(0,0)
  gr[1] = -k*N/lambda + k/lambda*sum((x/lambda)^k)
  gr[2] = N/k + sum(log(x))- N*log(lambda)-sum((x/lambda)^k*log(x/lambda))
  return(gr)
}


hessjan = function(params) {
  k = params[1]
  lambda = params[2]
  h = matrix(0, 2, 2)
  h[1,1] = k*N/lambda^2- (k+1)^k/(lambda)^(k+2)*sum(x^k)
  h[1,2] = -N/lambda+1/lambda*sum((x/lambda)^k)+k/lambda*sum(((x/lambda)^k)*log(x/lambda))
  h[2,1] = -N/lambda+1/lambda*sum((x/lambda)^k)+k/lambda*sum(((x/lambda)^k)*log(x/lambda))
  h[2,2] = - N/(k^2)-sum(((x/lambda)^k)*(log(x/lambda))^2)

  
  return(h)
}

res = maxNR(lnL, grad=gradient, hess=hessjan, start=c(1,1))
res$estimate
summary(res)
#0.2127536  0.3945005 ; gr 257.6389 -182.0288

vcov = -solve(res$hessian) / N
std.err.mu = sqrt(vcov[1,1])
z_test = (res$estimate[1]-(40))/std.err.mu
z_test
wart.krytyczna = qnorm(0.975, 0,1)
wart.krytyczna
p.value = 2*(1-pnorm(abs(z_test), mean=0, sd=1))
p.value#reject null hipotesis H0



h = matrix(0, 2, 2)
lnL_U = res$maximum
lnL_R = lnL(c(40,10))
LRtest= 2*(lnL_U-lnL_R)
LRtest
g = 2
alpha=0.05
qchisq(1-alpha, g)
p.value = 1-pchisq(LRtest, g)
print(p.value)#reject null hipotesis H0
