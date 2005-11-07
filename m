Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Logitech diNovo Media Desktop Laser patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1c464970511062228p1bafdf87mcef1cf3a77deb47c@mail.gmail.com>
References: <e1c464970511062228p1bafdf87mcef1cf3a77deb47c@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1131346143.5824.34.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 07 Nov 2005 07:49:03 +0100

Hi Trevor,

> Well, I just upgraded to 2.6.14 with 2.6.14-mh2, and it doesn't work,
> with and without the hci_usb.c patch I used. hciconfig just shows the
> mac address of 00's.

send the patch again.

> Anyways, I went back to 2.6.13, with the hci_usb.c patch. Works fine.
> I'll try it without it, I just have to recompile my kernel with a new
> version of gcc. ( reinstalled gentoo using gcc4 ). I'd do it now, but
> I want to get this email out before I head to work.
> 
> I also found out that the patch I sent you earlier for hid2hci.c did
> not work. Apparently, 0x046d:0x0b02 was not the correct device from
> the usb controller to do the switching to. Adding all three:
> { HCI, 0x046d, 0xc70c, switch_logitech },
> { HCI, 0x046d, 0xc70b, switch_logitech },
> { HCI, 0x046d, 0x0b02, switch_logitech },
> worked though. Perhaps it's 0xc70c?

Try to find out which product id is really working.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
