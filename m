Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Getting bluetooth working using Belkin F8T003 v2
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1D6TKF-0005T0-Vl@sc8-sf-mx2.sourceforge.net>
References: <E1D6TKF-0005T0-Vl@sc8-sf-mx2.sourceforge.net>
Content-Type: text/plain
Message-Id: <1109779773.8284.25.camel@pegasus>
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
Date: Wed, 02 Mar 2005 17:09:33 +0100

Hi Martin,

> Hey folks, i'm stuck with the following and have no clue what to do..
> 
> Trying to follow that guide
> http://gentoo-wiki.com/HOWTO_mobile_phone%2C_Bluetooth_and_GNOME
> 
> i came upon the following error:
> Code:
> 
> drivers/usb/class/bluetty.c: Bluetooth converter now attached to ttyUB0 (or
> usb/ttub/0 for devfs)
> drivers/usb/class/bluetty.c: usb_bluetooth_probe - improper number of endpoints.
> Bluetooth driver not bound.
> bluetty: probe of 3-3:1.1 failed with error -5
> drivers/usb/class/bluetty.c: usb_bluetooth_probe - improper number of endpoints.
> Bluetooth driver not bound.
> bluetty: probe of 3-3:1.2 failed with error -5
> 
> when typing "dmesg"... so it seems as if it doesn't recognize my Belkin Bluetooth
> stick, does it?
> Tried also not using the Linux-Bluetooth but the HCI-USB bluetooth, but when
> trying that, it complaing that it can't register rfcomm tty driver.. which shall
> be normal since it ain't installed if not using the Linux Blueooth.. so what
> shall i do to get bluetooth (mostly OBEX) to work with my mobile?
> Using kernel: 2.6.11-rc3-nitro0, Belkin Bluetooth Stick, gnome-bluetooth... thx
> in advance for any help, i'd be really happy if you could help me :)

the correct driver is hci_usb and not bluetty.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
