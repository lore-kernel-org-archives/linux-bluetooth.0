Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthias Thomae <bluez@thomae-privat.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40CEC020.6050107@thomae-privat.de>
References: <40CDE18C.70703@thomae-privat.de>
	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de>
	 <1087284859.13792.67.camel@pegasus>  <40CEC020.6050107@thomae-privat.de>
Content-Type: text/plain
Message-Id: <1087292887.13792.81.camel@pegasus>
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
Date: Tue, 15 Jun 2004 11:48:07 +0200

Hi Matthias,

> > it is a problem of the HID parser. If you enable debugging with "#define
> > DEBUG" in net/bluetooth/hidp/hid.h then you should see those lines with
> > dmesg:
> > 
> > net/bluetooth/hidp/hid.c: usage index exceeded
> > net/bluetooth/hidp/hid.c: hid_add_usage failed
> > net/bluetooth/hidp/hid.c: item 0 2 2 2 parsing failed
> > 
> > Do you see it, too?
> 
> Yes, I see exactly the same.

someone has to fix the HID parser to get it working with the keyboard
and the presenter from EPoX. I am a little bit busy in getting the boot
protocol support ready, so that we can at least include HID boot support
into the mainline kernel. The full report protocol support has to wait
until the kernel gets its device independent HID support.

> > Please send me the output of your mouse too and use
> 
> I`ll send it tonight, 'cause I haven't got it with me now.
> 
> > 	sdptest records 00:04:61:xx:xx:xx > file
> > 
> > from the utils2 CVS to get the full SDP record information.
> 
> It's attached. Do you need the same from the mouse, too?
> Anything else I can do?

Please do so. I want to compare it with my devices. The keyboard looks
the same as mine. It seems they only choosed a newer CSR firmware.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
