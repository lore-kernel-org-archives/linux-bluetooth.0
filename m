Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth-adapter not detected
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42820C7A.6030704@gmx.de>
References: <4281F089.1090404@web.de> <1115812535.11503.77.camel@pegasus>
	 <4281F811.1080306@gmx.de> <1115814650.11503.90.camel@pegasus>
	 <42820C7A.6030704@gmx.de>
Content-Type: text/plain
Message-Id: <1115830592.23458.59.camel@pegasus>
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
Date: Wed, 11 May 2005 18:56:32 +0200

Hi Johannes,

> >first check /proc/bus/usb/devices.
> >
> I did and found nothing about the bluetooth adapter. A copy of the
> output is enclosed.

I doubt that it is connected otherwise then USB, but check lspci and
dmesg for weird entries.

Does is have a hardware switch for WiFi/Bluetooth somewhere. Otherwise I
think you need a special tool or ACPI module for it. Ask Asus or your
manufacturer about it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
