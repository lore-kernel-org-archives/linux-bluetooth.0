Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Error message
From: Marcel Holtmann <marcel@holtmann.org>
To: Alex <welpan@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405211909.59769.welpan@gmx.de>
References: <200405211611.38038.welpan@gmx.de>
	 <1085157410.22191.17.camel@pegasus>  <200405211909.59769.welpan@gmx.de>
Content-Type: text/plain
Message-Id: <1085160363.22191.24.camel@pegasus>
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
Date: Fri, 21 May 2004 19:26:03 +0200

Hi Alex,

> > this looks very weird. Give us more information about your hardware and
> > what kind of dongle you are using.
> 
> Dongle : with CSR Chip, Seller WIDCOMM
> 
> hciconfig -a
> hci0:   Type: USB
>         BD Address: 08:00:17:13:82:61 ACL MTU: 339:4  SCO MTU: 60:9
>         UP RUNNING PSCAN ISCAN
>         RX bytes:128797 acl:0 sco:37800 events:14 errors:0
>         TX bytes:300 acl:0 sco:0 commands:13 errors:0
>         Features: 0xff 0x3a 0x05 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'welpix-0'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x178 LMP Ver: 1.1 (0x1) LMP Subver: 0x178
>         Manufacturer: RTX Telecom A/S (21)

there is no CSR chip in this dongle.

> System:  AMD Duron 1600
> 	      ASROCK Motherboard with SIS USB-Controller

What is the content of /proc/bus/usb/devices with the dongle attached?

> Kernel with Bluez-modules and USB drivers

Use patch-2.6.6-mh1 to prevent some USB related bugs.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
