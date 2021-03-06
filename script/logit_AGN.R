# Logit regression with AGNs 

require(arm)
require(plyr)
library(caret)
library(pROC)
AGN_data<-read.table("../data/outputdata.txt",header=TRUE,sep="")
AGN_data$WHAN_Class<-as.factor(AGN_data$WHAN_Class)
AGN_data$WHAN_Class<-revalue(AGN_data$WHAN_Class,c("2"="1","3"="1","1"="0","4"="0"))





fit<-bayesglm(WHAN_Class~log10.NII.Ha.+log10.EW.Ha..,family=binomial(link="logit"),scaled=TRUE,
              data = AGN_data)


ROCF<- data.frame(True=AGN_data$WHAN_Class,predicted=predict(fit,type = "response"))
F1 <-roc(ROCF$True,ROCF$predicted)
coords(F1,x="best")[1]

ROCF$class<-ROCF$predicted
ROCF$class[which(ROCF$class>=coords(F1,x="best")[1])]<-1
ROCF$class[which(ROCF$class<coords(F1,x="best")[1])]<-0

confusionMatrix(ROCF$True, ROCF$class)




x <-range(AGN_data$log10.NII.Ha.)
<<<<<<< HEAD
x <- seq(x[1], x[2], length.out=100)    
y <- range(AGN_data$log10.EW.Ha..)
y <- seq(y[1], y[2], length.out=100)

#z <- outer(x,y, 
 #          function(log10.NII.Ha.,log10.EW.Ha..)
 #            predict(fit, data.frame(log10.NII.Ha.,log10.EW.Ha..),type = 'response'))
z<-predict(fit, data.frame(log10.NII.Ha.=x,log10.EW.Ha..=y),type = 'response')


=======
x <- seq(x[1], x[2], length.out=50)    
y <- range(AGN_data$log10.EW.Ha..)
y <- seq(y[1], y[2], length.out=50)

z <- outer(x,y, 
           function(log10.NII.Ha.,log10.EW.Ha..)
             predict(fit, data.frame(log10.NII.Ha.,log10.EW.Ha..),type = 'response'))
>>>>>>> origin/master
library(rsm)
library(lattice)
YlOrBr <- c("#FFFFD4", "#FED98E", "#FE9929", "#D95F0E", "#993404")
#p<-persp(x,y,z, theta=150, phi=20, 
#         expand = 0.5,shade = 0.1,
#         xlab="Z", ylab=expression(NII.Ha), zlab=expression(log10.EW.Ha),ticktype='detailed',
#         col = YlOrBr,border=NA,xlog=T,ylog=T)
<<<<<<< HEAD
cor = topo.colors(200)
=======
#cor = topo.colors(200)
>>>>>>> origin/master

cairo_pdf("logit3D.pdf")
trellis.par.set("axis.line",list(axis.text=list(cex=20),col=NA,lty=1,lwd=2))
par(mar=c(1,1,1,1))
<<<<<<< HEAD
g<-expand.grid(x=x, y=y)
g$z<-z<-predict(fit, data.frame(log10.NII.Ha.=g$x,log10.EW.Ha..=g$y),type = 'response')
wireframe(z ~ x+y,data=g,
=======
wireframe(z~x+y,data=data.frame(x=x, y=rep(y, each=length(x)), z=z),
>>>>>>> origin/master
          par.settings = list(regions=list(alpha=0.4)),
          col.regions =cor,drape=T,light.source = c(5,5,5),colorkey = FALSE,
          xlab=list(label=expression(log10.NII.Ha.),cex=1.25), ylab=list(label=expression(log10.EW.Ha..),cex=1.25), 
          zlab=list(rot=90,label=expression(pi),cex=1.25,dist=-1,rot=0),
          scale=list(tck=0.75,arrows=FALSE,distance =c(0.75, 0.75, 0.75)))


dev.off() 

<<<<<<< HEAD
g <- expand.grid(x = 1:10, y = 5:15, gr = 1:2)
g$z <- log((g$x^g$gr + g$y^2) * g$gr)
wireframe(z ~ x * y, data = g, groups = gr,
          scales = list(arrows = FALSE),
          drape = TRUE, colorkey = TRUE,
          screen = list(z = 30, x = -60))
=======

>>>>>>> origin/master
