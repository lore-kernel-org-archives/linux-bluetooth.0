Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Timeout message from kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: Jeff Sutherland <jeffs@fairwayacademy.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402131819.10939.jeffs@fairwayacademy.org>
References: <200402121636.02074.jeffs@fairwayacademy.org>
	 <200402131023.03974.jeffs@fairwayacademy.org>
	 <1076686120.2671.83.camel@pegasus>
	 <200402131819.10939.jeffs@fairwayacademy.org>
Content-Type: text/plain
Message-Id: <1076715629.18588.103.camel@pegasus>
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
Date: Sat, 14 Feb 2004 00:40:29 +0100

Hi Jeff,

> Making ColdFire the l2test listener seems to work ok:
> /> l2test -r
> l2test[25]: Waiting for connection on psm 10 ...
> l2test[25]: Connect from 00:0A:4F:00:09:5E [imtu 672, omtu 672, flush_to 
> 65535]
>                                                                                 
> l2test[25]: Receiving ...
> l2test[25]: 672 bytes in 0.04 sec, 17.70 kB/s
> l2test[25]: 672 bytes in 0.01 sec, 50.86 kB/s
> l2test[25]: 672 bytes in 0.03 sec, 20.72 kB/s
> 
> and so on and so forth.  Making ColdFire the sender however produces this 
> output on the pc side:
> 
> [root@Arwen test]# ./l2test -r
> l2test[30292]: Waiting for connection on psm 10 ...
> l2test[30293]: Connect from 00:0A:4F:00:13:5F [imtu 672, omtu 672, flush_to 
> 65535]
> l2test[30293]: Receiving ...
> l2test[30293]: 672 bytes in 0.06 sec, 11.28 kB/s
> l2test[30293]: seq missmatch: 1 -> 4
> l2test[30293]: 672 bytes in 0.09 sec, 7.70 kB/s
> l2test[30293]: seq missmatch: 5 -> 8
> l2test[30293]: 672 bytes in 0.08 sec, 8.21 kB/s
> l2test[30293]: seq missmatch: 9 -> 12
> etc., etc.

should not happen. I don't why it happens to you.

> > Maybe this is a role switch problem. Show us both outputs from
> > "hciconfig -a".
> 
> ColdFire:
> /> hciconfig -a
> hci0:   Type: UART
>         BD Address: 00:0A:4F:00:13:5F ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:306 acl:0 sco:0 events:14 errors:0
>         TX bytes:513 acl:0 sco:0 commands:12 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> PC:
> [root@Arwen test]# hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0A:4F:00:09:5E ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:1887092 acl:3025 sco:29743 events:1513 errors:0
>         TX bytes:309425 acl:1448 sco:1709 commands:109 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)

Both look fine, but you should enable role switch support in hcid.conf
or set it by hand with hciconfig.

> Other than that sequence problem it looks like the link mostly works, still 
> issues with most of the commands of hcitool though, on Coldfire.

Keep trying and look with hcidump at it, but we can also have a bug in
our tools if they are used on a ColdFire processor.

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
