Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] [PATCH] tcsendbreak and flow control
	onhciattach(csrchip)
From: Marcel Holtmann <marcel@holtmann.org>
To: Rognlien Dag Kristian <Dag.K.Rognlien@sintef.no>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <39417DF3286A66428FA558987839F44F152D9C@SINTEFXCH01.sintef.no>
References: <39417DF3286A66428FA558987839F44F152D9C@SINTEFXCH01.sintef.no>
Content-Type: text/plain
Message-Id: <1097503251.9474.25.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Oct 2004 16:00:53 +0200

Hi Dag,

> > please use "diff -u".
> 
> Ok, makes sense.
> 
> Here is a more readable patch:
> 
> --- bluez-utils-2.9/tools/hciattach.c	2004-07-25 19:09:23.000000000
> +0200
> +++ bluez-utils-2.9-ij/tools/hciattach.c	2004-10-11
> 13:45:26.670694392 +0200
> @@ -899,8 +899,10 @@
>  
>  	tcflush(fd, TCIOFLUSH);
>  
> -	if (send_break)
> +	if (send_break){
>  		tcsendbreak(fd, 0);
> +		usleep(500000);
> +	}
>  
>  	if (u->init && u->init(fd, u, &ti) < 0)
>  		return -1;

applied. Thanks.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
