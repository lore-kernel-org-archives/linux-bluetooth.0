Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USB-drivers
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Riikka =?ISO-8859-1?Q?Jylh=E4?= <jylhar@ac.tut.fi>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <000001c35a7d$41d7f630$ae2ae682@ac.tut.fi>
References: <000001c35a7d$41d7f630$ae2ae682@ac.tut.fi>
Content-Type: text/plain
Message-Id: <1059999322.1747.95.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 04 Aug 2003 14:15:15 +0200

Hi Riikka,

> I've read through bluez users and developers mailing-lists and it seems
> that there are problems with usb-sco driver. Are problems completely
> solved or if I'm planning on using sco with my Bluetooth usb dongle
> should I consider twice? My experiments have not succeeded at all but
> I'm still planning on trying with mh2 patch for 2.4.21. Are other
> drivers and devices more recommendable and working better with voice?

you can use hci_usb driver for SCO voice transmission, but you can't use
it out-of-the-box. You need to apply a patch for using two ISOC URB's
per TX and RX path. And the alternate configuration for the ISOC
interface must be set correctly according to the voice setting.

At the moment this is only tested with CSR dongles, but I can play and
record audio data with my headset in 8 and 16 bit quality. And it seems
that the BlueCore02 produces better audio than the BlueCore01b.

Using an UART based device is mostly no option, because the bandwith is
not enough for sending SCO packets over the HCI link. But it is working
with the 3Com and Xircom PCMCIA cards.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
