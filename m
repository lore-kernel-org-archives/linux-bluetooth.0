Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Dongles not working
From: Marcel Holtmann <marcel@holtmann.org>
To: Raul Jimeno Mouzo <pichas23@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <LAW11-F7reyCJ5COYbg00014369@hotmail.com>
References: <LAW11-F7reyCJ5COYbg00014369@hotmail.com>
Content-Type: text/plain
Message-Id: <1073583971.2563.35.camel@pegasus>
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
Date: Thu, 08 Jan 2004 18:46:11 +0100

Hi Raul,

> PVI-Raul:/# hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:06:A2:05:A2:40 ACL MTU: 339:4  SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:63 acl:0 sco:0 events:7 errors:0
>         TX bytes:27 acl:0 sco:0 commands:7 errors:0
>         Features: 0xff 0xff 0x3d 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy:
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x90 LMP Ver: 1.1 (0x1) LMP Subver: 0x90
>         Manufacturer: Transilica, Inc. (24)

I don't have experiences with Transilica chips. Once I got a dongle with
such a chip, but it seems that I lost it. If the SCO option of the HCI
USB driver is enabled, disable it and try to switch the usb-uhci with
the uhci USB host driver and vice versa. If none of that helped in your
case, you should better try to get a CSR based USB dongle. They are more
unproblematic than the others at the moment. 

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
