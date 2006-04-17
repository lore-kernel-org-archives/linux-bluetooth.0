Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BlueWiFly
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060417144157.12538.qmail@web50513.mail.yahoo.com>
References: <20060417144157.12538.qmail@web50513.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1145285388.26498.19.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 17 Apr 2006 16:49:48 +0200

Hi Mahtab,

> Does anybody use this solution from SunCore supporting both bluetooth
> and Wi-Fi in a single bluetooth USB dongle (Bluetooth v1.2 + 802.11g)?
> http://www.suncore.com.tw/bluewifly%20introduction.htm
> 
> It comes with support for Microsoft only. I think I certainly need a
> driver for Wi-Fi to make this work in Linux (Microsoft also uses the
> driver provided by the manufacturers). But for bluetooth, some reviews
> say, Microsoft built-in stack can also drive it (regardless of the
> driver porvided by BlueWiFLy). So I am presuming BlueZ can do the
> same.
> 
> Should there be any issues with module-loading as the USB comes with
> both Wi-Fi and Bluetooth support?

I don't think that you will have any problems with the Bluetooth part of
this dongle. However the output of /proc/bus/usb/devices always helps to
identify this dongle.

If the WiFi part is supported by Linux is the more important question,
because this is always a little bit unclear.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
