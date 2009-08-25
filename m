Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Aug 2009 14:31:57 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: Mateus Interciso <mateus@ouvi.com.br>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: Question on simple RFCOMM server
In-Reply-To: <4A93D887.8060007@ouvi.com.br>
Message-ID: <Pine.LNX.4.63.0908251427570.3317@redbean.intranet.gw-instruments.de>
References: <4A93D887.8060007@ouvi.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Mateus,

I don't think the problem is with your code but has something to do with 
the Bluetooth Master / Slave mode. By default for the RFCOMM connection 
opened by the remote device your server is a Bluetooth Slave. And as a 
slave you can not handle more than 2 connections at once. To allow more 
connections you need your server to do a role switch after connection 
setup. Than it will act as a master and can handle up to seven 
connections. 

Ciao, 

Peter

On Tue, 25 Aug 2009, Mateus Interciso wrote:

> Hello, I have a very simple RFCOMM server that I adapted from an extremely
> simple TCP echo server I've made for learning TCP, it's a simple fork()
> server, and while the TCP server works perfeclty, the RFCOMM works only with 2
> connected clients at the same time, and I'm failling to see the problem, can
> someone help me?
> 
> Here's the code:
> 
> (The commented part if the TCP part)
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <string.h>
> #include <errno.h>
> #include <sys/types.h>
> #include <sys/socket.h>
> #include <netinet/in.h>
> #include <arpa/inet.h>
> #include <sys/wait.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/rfcomm.h>
> 
> #define MYPORT 10
> #define BACKLOG 31
> #define MAX_SIZE 80
> 
> int main(int argc, char *argv[])
> {
>   int listenfd, connfd;
>   pid_t childpid;
>   socklen_t clilen;
>   struct sockaddr_rc cliaddr, servaddr;
>   char buf[MAX_SIZE];
>   int i =0;
> 
>   //listenfd = socket(AF_INET, SOCK_STREAM, 0);
>   listenfd = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>   if(listenfd < 0)
>   {
>     perror("socket");
>     exit(errno);
>   }
> 
>   bzero(&servaddr, sizeof(servaddr));
>   servaddr.rc_family = AF_BLUETOOTH;
>   servaddr.rc_bdaddr = *BDADDR_ANY;
>   servaddr.rc_channel = (uint8_t)MYPORT;
>   /*
>   servaddr.sin_family = AF_INET;
>   servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
>   servaddr.sin_port = htons(MYPORT);
>   */
>   if(bind(listenfd,(struct sockaddr*)&servaddr, sizeof(servaddr)) < 0)
>   {
>     perror("bind");
>     exit(errno);
>   }
> 
>   if(listen(listenfd,BACKLOG) < 0)
>   {
>     perror("listen");
>     exit(errno);
>   }
> 
>   while(1)
>   {
>     clilen = sizeof(cliaddr);
>     if((connfd = accept(listenfd, (struct sockaddr*)&cliaddr, &clilen)) 
> < 0)
>     {
>       perror("accept");
>       exit(errno);
>     }
>     if((childpid = fork()) == 0)
>     {
>       i = 0;
>       close(listenfd);
>       fprintf(stderr,"[DEBUG] Got connection\n");
>       memset(buf,'\0',sizeof(buf));
>       //echo server
>       if(read(connfd, buf, MAX_SIZE) < 0) perror("read");
>       else
>         if(send(connfd, buf, strlen(buf), 0) < 0) perror("send");
>       exit(0);
>     }
>     close(connfd);
>   }
>   return 0;
> }
> 
> 
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


|       Peter Wippich                   Voice: +49 30 46776411          |
|       G&W Instruments GmbH            fax:   +49 30 46776419          |
|       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
|       D-13355 Berlin  / Germany                                       |

