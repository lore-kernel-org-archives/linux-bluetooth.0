Return-Path: <bluez-users-admin@lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
From: Martin Trost <phobozz@sgies.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <E1D6TKF-0005T0-Vl@sc8-sf-mx2.sourceforge.net>
Subject: [Bluez-users] Getting bluetooth working using Belkin F8T003 v2
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
Date: Wed, 02 Mar 2005 07:55:37 -0500

Hey folks, i'm stuck with the following and have no clue what to do..=0D
=0D
Trying to follow that guide=0D
http://gentoo-wiki.com/HOWTO_mobile_phone%2C_Bluetooth_and_GNOME=0D
=0D
i came upon the following error:=0D
Code:=0D
=0D
drivers/usb/class/bluetty.c: Bluetooth converter now attached to ttyUB0 (or=
=0D
usb/ttub/0 for devfs)=0D
drivers/usb/class/bluetty.c: usb_bluetooth_probe - improper number of endpo=
ints.=0D
Bluetooth driver not bound.=0D
bluetty: probe of 3-3:1.1 failed with error -5=0D
drivers/usb/class/bluetty.c: usb_bluetooth_probe - improper number of endpo=
ints.=0D
Bluetooth driver not bound.=0D
bluetty: probe of 3-3:1.2 failed with error -5=0D
=0D
when typing "dmesg"... so it seems as if it doesn't recognize my Belkin Blu=
etooth=0D
stick, does it?=0D
Tried also not using the Linux-Bluetooth but the HCI-USB bluetooth, but whe=
n=0D
trying that, it complaing that it can't register rfcomm tty driver.. which =
shall=0D
be normal since it ain't installed if not using the Linux Blueooth.. so wha=
t=0D
shall i do to get bluetooth (mostly OBEX) to work with my mobile?=0D
Using kernel: 2.6.11-rc3-nitro0, Belkin Bluetooth Stick, gnome-bluetooth...=
 thx=0D
in advance for any help, i'd be really happy if you could help me :)=0D
=0D


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
