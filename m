Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Small bugfix for hstest
From: Marcel Holtmann <marcel@holtmann.org>
To: Till Harbaum <harbaum@beecon.de>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <200408301753.25934.harbaum@beecon.de>
References: <200408301753.25934.harbaum@beecon.de>
Content-Type: text/plain
Message-Id: <1093882030.5620.86.camel@pegasus>
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
Date: Mon, 30 Aug 2004 18:07:10 +0200

Hi Till,

> i have played around with hstest and some uart based hardware and found a 
> problem, that only seems to happen with uart based devices:
> 
> A client may receive sco data packets that are bigger than the sco mtu. hstest 
> returns packets of exactly the same size of the packets it received. If the 
> packet received is bigger then the sco mtu, then packets bigger than sco mtu 
> are being sent and being dropped in the kernel. As a result, no data is being 
> sent at all. Instead multiple smaller sco packets should be sent.
> 
> The attached patch has to be applied to bluez-utils/test/hstest.c and fixes 
> the problem inside hstest. It would as well be possible to make the kernel 
> sco code detect this and fragment the payload accordingly. But imho this 
> should be done in the application.

I applied the patch, but there must be space between "while" and "(" to
keep me and the coding style happy ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
