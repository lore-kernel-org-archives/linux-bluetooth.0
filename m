Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Device class resetting itself after device is
	removed
From: Marcel Holtmann <marcel@holtmann.org>
To: trejkaz@xaoza.net
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200411012222.49520.trejkaz@trypticon.org>
References: <200411012222.49520.trejkaz@trypticon.org>
Content-Type: text/plain
Message-Id: <1099313117.16247.84.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 01 Nov 2004 13:45:17 +0100

Hi Trejkaz,

> I've been noticing some issues which seemed to start happening after I left my 
> machine alone for a while.  Eventually I thought I would try to nail the 
> problem down and exclude some parties like kdebluetooth from the picture.  
> What's left is quite reproducible.  It turns out that these periods of 
> leaving the machine alone coincided with the times I removed the dongle to 
> use it at work. :-)
> 
> System in healthy state:
> 
> raven root # hciconfig hci0 class
> hci0:   Type: USB
>         BD Address: 00:0B:0D:40:14:0D ACL MTU: 120:20  SCO MTU: 64:0
>         Class: 0xff0104
>         Service Classes: Positioning, Networking, Rendering, Capturing, Object 
> Transfer, Audio, Telephony, Information
>         Device Class: Computer, Desktop workstation
> 
> System after removing dongle:
> 
> raven root # hciconfig hci0 class
> Can't get device info: No such device
> 
> System after replacing dongle:
> 
> raven root # hciconfig hci0 class
> hci0:   Type: USB
>         BD Address: 00:0B:0D:40:14:0D ACL MTU: 120:20  SCO MTU: 64:0
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
> 
> Now, the class has reset to 0x000000, but that's not the value I have in 
> hcid.conf.
> 
> It also destroys my hostname value and probably everything else important at 
> the same time, which would certainly explain why I suddenly can't connect ot 
> the computer from any devices when it happens.

are you sure that your hcid is running?

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
https://lists.sourceforge.net/lists/listinfo/bluez-users
