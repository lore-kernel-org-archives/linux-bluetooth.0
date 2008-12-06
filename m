Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e343e5940812061301w368d0614s85e4f82938e76c3a@mail.gmail.com>
References: <COL102-W12443FB0254944C58D2F2FA8020@phx.gbl>
	<e343e5940812050154i52fb8eb3x46cf6e73e5a0c8f9@mail.gmail.com>
	<BAY127-W1206CF6F607105AA558C2DA8FE0@phx.gbl>
	<89b6ba3a0812050920q1dea080i148d9c4677b6ed04@mail.gmail.com>
	<COL102-W7079DBA98D2EA5B8835568A8FF0@phx.gbl>
	<e343e5940812061301w368d0614s85e4f82938e76c3a@mail.gmail.com>
Date: Sat, 06 Dec 2008 22:14:10 +0100
Message-Id: <1228598050.28839.47.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] MA-720 does not work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Yuriy,

> in this line there is only one module hci_usb. the other words are
> parameters for this module.
> but i  don't  know exactly if we can use those parameters. 
> I tried to help you in this way because early  I did like this for
> module 'usbserial'. so I supposed it would be helpful

are you still trying to debug this. Check modinfo hci_usb (or better
actually use the btusb driver). You can only use the module parameters
listed there. Period. There have never been any vendor or product module
parameters for any of these drivers. That is just pure usbserial crap
and shouldn't even been there. We can use sysfs to bind/unbind drivers.

I wanna see "cat /proc/bus/usb/devices" from your device. And if that is
not mounted then check Google on how to mount it.

Regards

Marcel



------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
