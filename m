Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] I-Tec Bluetooth USB -- Same Problem...
From: Marcel Holtmann <marcel@holtmann.org>
To: Rudolf Matousek <matousek@utia.cas.cz>
Cc: cijoml@volny.cz, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <404D8166.1060601@utia.cas.cz>
References: <10865.30319-12503-1360465066-1076449270@seznam.cz>
	 <1076452227.2777.28.camel@pegasus> <404D69F5.50300@utia.cas.cz>
	 <200403090851.20295.cijoml@volny.cz>  <404D8166.1060601@utia.cas.cz>
Content-Type: text/plain
Message-Id: <1078833918.10671.48.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 09 Mar 2004 13:05:18 +0100

Hi Rudolf,

> thanks for your update. I'll test it as soon as I upgrade kernel (which 
> will be soon).
> 
> BTW. are we talking about the same dongle :-D. Please could you provide 
> the vendor and product IDs?

we are talking about the same dongle. I found the problem, why it
doesn't work and of course I fixed it. Here is the mailing list thread
about it

	http://thread.gmane.org/gmane.linux.bluez.devel/1756

However don't expect to get any information from Broadcom. They are not
very helpful and actually some of there stuff is very ugly. For example
it is impossible to get the Apple Bluetooth mouse (Broadcom based)
working with the i-Tec dongle (also Broadcom based) in HID mode. All my
other HID devices are working perfect with its HID mode. Mostly all
Information about HID devices and HID proxy dongles can be found here

	http://www.holtmann.org/linux/bluetooth/hid.html

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
