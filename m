Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] mroute and nokia 6600
From: Marcel Holtmann <marcel@holtmann.org>
To: "Jordi Molgo (Kryogen)" <kryogen@lleida.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1077886228.2002.14.camel@jordi.molgo.com>
References: <1077886228.2002.14.camel@jordi.molgo.com>
Content-Type: text/plain
Message-Id: <1077887281.2843.38.camel@pegasus>
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
Date: Fri, 27 Feb 2004 14:08:01 +0100

Hi Jordi,

> I have a Nokia 6600 and a bluetooth usb dongle. I have installed
> and configured bluez so I have now
> 
> [root@jordi root]# hciconfig  -a
> hci0:   Type: USB
>         BD Address: 00:09:DD:10:22:79 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:31260 acl:620 sco:0 events:1805 errors:0
>         TX bytes:284951 acl:1845 sco:0 commands:221 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'Kryogen (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x175
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> and also I have created two rfcomm
>   [root@jordi root]# rfcomm
>   rfcomm0: 00:60:57:B4:52:6D channel 1 closed
>   rfcomm1: 00:60:57:B4:52:6D channel 2 closed
> 
> After I have read in http://mobile.linux.pt/p800 I can connect with
> pppd to my handset, but when connecting it hangs. I have searched 
> the reason, but I can't manage to correct it.

this is all about the mRouter callback stuff. I don't have a Symbian
based mobile phone to write an easy to use application for this carp.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
