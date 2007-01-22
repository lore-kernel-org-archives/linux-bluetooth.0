Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45B4B192.8070707@free.fr>
Date: Mon, 22 Jan 2007 13:44:02 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <yw1x4pqk44sl.fsf@thrashbarg.inprovide.com>
In-Reply-To: <yw1x4pqk44sl.fsf@thrashbarg.inprovide.com>
Subject: Re: [Bluez-devel] [PATCH] make 64-bit headsetd work with 32-bit
	clients
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


Thanks you for this, i applied it to CVS.

Cheers,

Fabien

> The attached patch makes headsetd and the ALSA PCM plugin use
> fixed-width types in the IPC data structures.  Without this, a 32-bit
> client will not work with a 64-bit headsetd and vice versa because of
> the different sizes of the 'long' type.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: alsa-plugins/pcm_sco.c
> ===================================================================
> RCS file: /cvsroot/bluetooth-alsa/plugz/alsa-plugins/pcm_sco.c,v
> retrieving revision 1.2
> diff -u -r1.2 pcm_sco.c
> --- alsa-plugins/pcm_sco.c	28 Dec 2006 12:52:37 -0000	1.2
> +++ alsa-plugins/pcm_sco.c	21 Jan 2007 16:05:30 -0000
> @@ -24,6 +24,7 @@
>  #include <sys/un.h>
>  #include <unistd.h>
>  #include <errno.h>
> +#include <stdint.h>
>  
>  #include <alsa/asoundlib.h>
>  #include <alsa/pcm_external.h>
> @@ -85,8 +86,8 @@
>  	unsigned char type;
>  	union {
>  		bdaddr_t     bdaddr;	               /* PKT_TYPE_CFG_BDADDR        */
> -		long         timeout;                  /* PKT_TYPE_CFG_PAGINGTIMEOUT */
> -		int	     errorcode;		       /* PKT_TYPE_ERROR_IND        */
> +		int32_t      timeout;                  /* PKT_TYPE_CFG_PAGINGTIMEOUT */
> +		int32_t	     errorcode;		       /* PKT_TYPE_ERROR_IND        */
>  	};
>  } ipc_packet_t;
>  
> Index: alsa-plugins/headsetd/states.c
> ===================================================================
> RCS file: /cvsroot/bluetooth-alsa/plugz/alsa-plugins/headsetd/states.c,v
> retrieving revision 1.2
> diff -u -r1.2 states.c
> --- alsa-plugins/headsetd/states.c	28 Dec 2006 12:52:38 -0000	1.2
> +++ alsa-plugins/headsetd/states.c	21 Jan 2007 16:05:30 -0000
> @@ -34,6 +34,7 @@
>  #include <stdlib.h>
>  #include <errno.h>
>  #include <syslog.h>
> +#include <stdint.h>
>  
>  #include <config.h>
>  #include "states.h"
> @@ -59,8 +60,8 @@
>  	unsigned char type;
>  	union {
>  		bdaddr_t     bdaddr;	               /* PKT_TYPE_CFG_BDADDR        */
> -		long         timeout;                  /* PKT_TYPE_CFG_PAGINGTIMEOUT */
> -		int	     errorcode;		       /* PKT_TYPE_ERROR_IND         */
> +		int32_t      timeout;                  /* PKT_TYPE_CFG_PAGINGTIMEOUT */
> +		int32_t	     errorcode;		       /* PKT_TYPE_ERROR_IND         */
>  	};
>  } ipc_packet_t;
>  
> 
> 
> ------------------------------------------------------------------------
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
