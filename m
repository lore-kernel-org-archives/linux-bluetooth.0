Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Key bouncing
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1099916465.3186.21.camel@saag>
References: <1099916465.3186.21.camel@saag>
Content-Type: text/plain
Message-Id: <1099918659.6896.126.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 08 Nov 2004 13:57:39 +0100

Hi Edd,

> I've noticed that if typing quickly on my Apple Bluetooth keyboard I
> often get additional keypresses. For instance, 'mode' comes out as
> 'moddeo' sometimes.  This only affects me when my DLink dongle is in HCI
> mode -- I get no issues when in HID mode.  I've seen this in kernels
> 2.6.9 and 2.6.10-rc1.
> 
> % hidd --show
> 00:50:F2:E2:A4:B1 HID Boot Device [045e:007c] connected [boot-protocol]
> 00:0A:95:39:0F:9E HID Boot Device [05ac:0209] connected [boot-protocol]

I have seen this only in boot protocol mode. If you apply the -mh patch
and use report protocol mode this should go away. However in the HID
mode the D-Link also uses the boot protocol and so there must be a way
to avoid it. At the moment I have no idea how to do this, but every
patch is welcome.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
