Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] zeevo acer dongle
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Maximilian Michel <michel@docomolab-euro.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>, max@3max.de
In-Reply-To: <3F27DED9.3090706@docomolab-euro.com>
References: <3F27DED9.3090706@docomolab-euro.com>
Content-Type: text/plain
Message-Id: <1059603475.1831.21.camel@pegasus>
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
Date: 31 Jul 2003 00:17:49 +0200

Hi Maximilian,

> I got an acer dongle (BT-510) containing a zeevo bluetooth chip.
> This zeevo-dongle obviously works not so well with bluez as it keeps 
> crashing with segfault.
> The system I use should be well-configured, as everything works fine 
> with csr-based devices (acer BU2 dongle).
> So, is the zeevo-chip not supported, can it be fixed anyway?

if I remember correctly, the Zeevo chip is one of these buggy Bluetooth
devices which have no SCO endpoints. Please send us the output of
/proc/bus/usb/devices and try one of my latest -mh patches or the latest
2.4.22-pre.

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
