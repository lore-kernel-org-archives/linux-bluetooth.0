Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] LIBS vs LD_FLAGS in bluez-utils makefiles
From: Marcel Holtmann <marcel@holtmann.org>
To: Franck Arnaud <franck@nenie.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45540213.2004.5.20.21.35.29.45662@mem.nenie.org>
References: <45540213.2004.5.20.21.35.29.45662@mem.nenie.org>
Content-Type: text/plain
Message-Id: <1085154828.22191.3.camel@pegasus>
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
Date: Fri, 21 May 2004 17:53:49 +0200

Hi Franck,

> (let me know if you want it in another format.)

the format is quite right, but your mailer broke the patch. Maybe it is
better you attach it instead of inlining.

> diff --exclude=Makefile --exclude=Makefile.in -u -r 
> orig/bluez-utils-2.7/tools/Makefile.am bluez-utils-2.7/tools/Makefile.am
> --- orig/bluez-utils-2.7/tools/Makefile.am	Sun May  9 11:39:43 2004
> +++ bluez-utils-2.7/tools/Makefile.am	Thu May 20 14:38:06 2004
> @@ -10,17 +10,7 @@
>  
>  hciconfig_SOURCES = hciconfig.c csr.h csr.c
>  
> -hciconfig_LDFLAGS = @BLUEZ_LIBS@
> -
> -hcitool_LDFLAGS = @BLUEZ_LIBS@
> -
> -l2ping_LDFLAGS = @BLUEZ_LIBS@
> -
> -sdptool_LDFLAGS = @BLUEZ_LIBS@
> -
> -ciptool_LDFLAGS = @BLUEZ_LIBS@
> -
> -ppporc_LDFLAGS = @BLUEZ_LIBS@
> +LIBS = @BLUEZ_LIBS@
>  
>  INCLUDES = @BLUEZ_INCLUDES@

I am happy to apply your patch, but this is not what I want. Tools like
hciattach, hid2hci or hcisecfilter don't need to link -lbluetooth. What
is the correct way of solving this?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
