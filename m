Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4634C553.6080400@xmission.com>
Date: Sun, 29 Apr 2007 10:18:27 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <20070415095728.GA6212@ifup.org>	<20070424184826.GD6853@torres.zugschlus.de>
	<loom.20070429T141323-596@post.gmane.org>
In-Reply-To: <loom.20070429T141323-596@post.gmane.org>
Subject: Re: [Bluez-devel] Unable to set number of SCO buffers : please
 upgrade your Kernel !
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

Klaus

> In plugz/../pcm_sco.c: sco_headset_hw_params(), 
>    setsockopt(...,SOL_SCO,...) is called, but it fails with ENOPROTOOPT
> "Protocol not available".
> 
>    setsockopt() for protocol level SOL_SCO is implemented in the kernel in
> net/bluetooth/sco.c: sco_sock_setsockopt(), but this function only does one
> thing - it returns ENOPROTOOPT:
> 
> ...
>         switch (optname) {
>         default:
>                 err = -ENOPROTOOPT;
>                 break;
>         }
> ...
> 
> I am a bit curious - how can this work for anybody?

you're looking at the upatched sco.c or maybe one hunk failed.
sco-flowcontrol-v4.2.diff has changes for setsockopt() around line 550.

we did actually change the constants for the setsockopt call, but if you
have a recently updated plugz it should actually try both the old and
new constants.

brad

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
