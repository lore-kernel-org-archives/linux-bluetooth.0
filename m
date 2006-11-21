Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45635BFD.7070404@free.fr>
Date: Tue, 21 Nov 2006 21:05:17 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <455392B6.5060209@free.fr> <45634AFC.909@vasmac.com>
In-Reply-To: <45634AFC.909@vasmac.com>
Subject: Re: [Bluez-devel] New bluetooth-headset release 20061109 : nickname
 'dogfood' ; -)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Jose,

It took me a while to figure out what was wrong...
Having a look to man 7 unix you will see that :

      sun_family  always contains AF_UNIX.  sun_path contains the 
zero-terminated pathname of the socket in the file system.

So no, thank you, i think my code is fine ;-)
If there are displays issues and something needs fixing i think you 
should fix your monitoring application instead.

Cheers,

Fabien

> Hi Fabien,
> 
> I have a minor suggestion regarding the binding of the unix
> socket in daemon.c. Currently, the socket name registered
> contains nul characters. It would be better to register the
> name without the extra fill for monitoring applications.
> 
> Jose
> 
> --- daemon.c    2006-05-18 10:30:06.000000000 -0400
> +++ ../../cvs/alsa-plugin-sco/headsetd/new/daemon.c    2006-09-01 
> 19:18:04.000000000 -0400
> @@ -73,7 +73,7 @@
>      struct sockaddr_un  pcm_srv_sock = {
>          AF_UNIX, PCM_SERVER_SOCKET
>      };
> -    if(bind(_appl_srv_sockfd, (struct sockaddr *)&pcm_srv_sock, 
> sizeof(pcm_srv_sock)) != 0) {
> +    if(bind(_appl_srv_sockfd, (struct sockaddr *)&pcm_srv_sock, 
> __SOCKADDR_COMMON_SIZE+sizeof(PCM_SERVER_SOCKET)-1) != 0) {
>              syslog(LOG_ERR, "bind(_appl_srv_sockfd): %s", strerror(errno));
>          goto error;   
>      }
> @@ -96,7 +96,7 @@
>      struct sockaddr_un  ctl_srv_sock = {
>          AF_UNIX, CTL_SERVER_SOCKET
>      };
> -    if(bind(_appl_ctlsrv_sockfd, (struct sockaddr *)&ctl_srv_sock, 
> sizeof(ctl_srv_sock)) != 0) {
> +    if(bind(_appl_ctlsrv_sockfd, (struct sockaddr *)&ctl_srv_sock, 
> __SOCKADDR_COMMON_SIZE+sizeof(CTL_SERVER_SOCKET)-1) != 0) {
>              syslog(LOG_ERR, "bind(_appl_ctlsrv_sockfd): %s", 
> strerror(errno));
>          goto error2;   
>      }
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
