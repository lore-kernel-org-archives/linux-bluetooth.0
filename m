Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] combination keys support?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <26398.1100503129@www2.gmx.net>
References: <26398.1100503129@www2.gmx.net>
Content-Type: text/plain
Message-Id: <1100525209.7208.13.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Nov 2004 14:26:49 +0100

Hi Marco,

> > this is really weird. The error code 0x29 means "pairing with unit key
> > not supported",
> 
> Yes, that's what i found on google..
> check
> out:
> http://davesipaq.com/forum/showthread.php?s=b489a378fa8fe7e09f2cf7fdccea2a48&p=14360#post14360
> 
> or a german one (your name sounds german :-)):
> http://www.pocket.at/forum/nokia6230.htm

I am German, but the forename itself is French ;)

> the first link tells that it's a firmware topic...
> what do you think in this case:
> is it a firmware topic of my usb dongle (so below bluez) or does this fall
> into the bluez field?
> 
> btw, maybe interesting:
> trying to pair my nokia6230 on windows fails badly (with "pairing and
> connection refused for security reason"). pairing one of a friend (an older
> model) works withhout problems...
> 
> > but actually it sends out the link key notification.
> > It tell us that the link key is a local unit key. Whatever local means
> > in this case. And the PIN code request happens before the SABM on
> > the control DLCI 0. There is something fundamental wrong.
> 
> yes...
> but i'm not that familiar with the bluetooth basics...
> so i can't do that much with this information...
>  
> 
> > What device do you use (hciconfig -a)?
> It's a acer BT-500
> hci0:   Type: USB
>         BD Address: 00:04:3E:C0:C3:49 ACL MTU: 1356:5  SCO MTU: 48:1
>         UP RUNNING PSCAN ISCAN
>         RX bytes:87 acl:0 sco:0 events:11 errors:0
>         TX bytes:290 acl:0 sco:0 commands:11 errors:0
>         Features: 0xff 0x07 0x04 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BLUEZ'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x86 LMP Ver: 1.1 (0x1) LMP Subver: 0x86
>         Manufacturer: Zeevo, Inc. (18)

Here we go again. You actually got a Bluetooth dongle with the buggy and
crappy Zeevo TC2001 chip. They also sold it to HP for inclusion into
their iPAQs and this explain the information on the Internet. I've never
seen this problem before and it is good to be aware of it. Now all the
information seen with hcidump are making sense.

Get yourself a CSR based dongle and you won't see this problems anymore.

> PS: sorry for always breaking the thread, but i'm not on the mailinglist. if
> you hit "reply all", i could directly answer and the thread wouldn't be
> broken...

I actually always hit "reply all". This is a Mailman problem with using
the "Reply-To:" setting I switched to some time ago.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
