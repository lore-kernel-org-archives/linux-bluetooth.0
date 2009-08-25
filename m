Return-Path: <cyrus@holtmann.org>
Message-ID: <4A93D887.8060007@ouvi.com.br>
Date: Tue, 25 Aug 2009 09:26:47 -0300
From: Mateus Interciso <mateus@ouvi.com.br>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Question on simple RFCOMM server
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, I have a very simple RFCOMM server that I adapted from an 
extremely simple TCP echo server I've made for learning TCP, it's a 
simple fork() server, and while the TCP server works perfeclty, the 
RFCOMM works only with 2 connected clients at the same time, and I'm 
failling to see the problem, can someone help me?

Here's the code:

(The commented part if the TCP part)

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>

#define MYPORT 10
#define BACKLOG 31
#define MAX_SIZE 80

int main(int argc, char *argv[])
{
   int listenfd, connfd;
   pid_t childpid;
   socklen_t clilen;
   struct sockaddr_rc cliaddr, servaddr;
   char buf[MAX_SIZE];
   int i =0;

   //listenfd = socket(AF_INET, SOCK_STREAM, 0);
   listenfd = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
   if(listenfd < 0)
   {
     perror("socket");
     exit(errno);
   }

   bzero(&servaddr, sizeof(servaddr));
   servaddr.rc_family = AF_BLUETOOTH;
   servaddr.rc_bdaddr = *BDADDR_ANY;
   servaddr.rc_channel = (uint8_t)MYPORT;
   /*
   servaddr.sin_family = AF_INET;
   servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
   servaddr.sin_port = htons(MYPORT);
   */
   if(bind(listenfd,(struct sockaddr*)&servaddr, sizeof(servaddr)) < 0)
   {
     perror("bind");
     exit(errno);
   }

   if(listen(listenfd,BACKLOG) < 0)
   {
     perror("listen");
     exit(errno);
   }

   while(1)
   {
     clilen = sizeof(cliaddr);
     if((connfd = accept(listenfd, (struct sockaddr*)&cliaddr, &clilen)) 
< 0)
     {
       perror("accept");
       exit(errno);
     }
     if((childpid = fork()) == 0)
     {
       i = 0;
       close(listenfd);
       fprintf(stderr,"[DEBUG] Got connection\n");
       memset(buf,'\0',sizeof(buf));
       //echo server
       if(read(connfd, buf, MAX_SIZE) < 0) perror("read");
       else
         if(send(connfd, buf, strlen(buf), 0) < 0) perror("send");
       exit(0);
     }
     close(connfd);
   }
   return 0;
}


Thanks.
