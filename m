Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez-utils compile error
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan <tam99@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200408121348.18203.tam99@t-online.de>
References: <200408121348.18203.tam99@t-online.de>
Content-Type: text/plain
Message-Id: <1092313255.28711.120.camel@pegasus>
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
Date: Thu, 12 Aug 2004 14:20:56 +0200

Hi Stefan,

> when I try to compile bluez-utils I get the following error:
> 
> ...
> c `test -f 'hid2hci.c' || echo './'`hid2hci.c
> gcc -I/usr/include  -I/usr/include -Wall -g -O2   -o hid2hci  hid2hci.o 
> -L/usr/lib -lusb
> /usr/lib/libusb.a(usb.o)(.text+0x7e9): In function `usb_get_busses':
> : multiple definition of `usb_get_busses'
> hid2hci.o(.text+0x0):/home/stefan/bluez-utils-2.9/tools/hid2hci.c:45: first 
> defined here
> collect2: ld returned 1 exit status
> make[2]: *** [hid2hci] Error 1
> make[2]: Leaving directory `/home/stefan/bluez-utils-2.9/tools'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/stefan/bluez-utils-2.9'
> make: *** [all] Error 2
> bash-2.05b$
> 
> bluez-libs and libusb are installed

remove this:

	#ifndef usb_get_busses
	struct usb_bus *usb_get_busses(void)
	{
	        return usb_busses;
	}
	#endif

from the hid2hci.c file and try again.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
