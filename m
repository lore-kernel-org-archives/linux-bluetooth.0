Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Kernel panic when unplugging USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Arthur Dent <tobili@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY18-F24coCru4efxI0000356f@hotmail.com>
References: <BAY18-F24coCru4efxI0000356f@hotmail.com>
Content-Type: text/plain
Message-Id: <1084221682.9639.99.camel@pegasus>
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
Date: Mon, 10 May 2004 22:41:23 +0200

Hi Arthur,

> Here are some system parameters:
> 
> linux:~# hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0A:9A:00:37:68 ACL MTU: 339:4  SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:490986 acl:18311 sco:0 events:1891 errors:0
>         TX bytes:160980 acl:1868 sco:0 commands:20 errors:0
>         Features: 0xff 0xff 0x3d 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x8a LMP Ver: 1.1 (0x1) LMP Subver: 0x8a
>         Manufacturer: Transilica, Inc. (24)

I will try to find my Transilica based dongle and boot up a machine with
2.4.26-mh1, but this can take some time. In the meantime send us the
output of /proc/bus/usb/devices and if you enabled BLUEZ_HCIUSB_SCO
kernel options, then please try without it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
