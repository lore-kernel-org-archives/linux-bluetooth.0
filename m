Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't establish a connection
From: Marcel Holtmann <marcel@holtmann.org>
To: ben4fun <ben_4_fun@freenet.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1092776029.3475.27.camel@localhost>
References: <1091742606.6143.17.camel@localhost>
	 <1092727197.12606.1.camel@localhost> <1092728177.31651.6.camel@pegasus>
	 <200408170949.50588.cijoml@volny.cz>  <1092776029.3475.27.camel@localhost>
Content-Type: text/plain
Message-Id: <1092778940.31651.39.camel@pegasus>
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
Date: Tue, 17 Aug 2004 23:42:20 +0200

Hi Ben,

> But the cheapest way was to follow the advice of Marcel. It's almost
> done.

so adding the broken ISOC quirk would be enough to make this dongle work
again. Maybe the last time I tested it, I had the SCO support disabled.

> this is the results of my new hciconfig -a 
> 
> hci0:   Type: USB
>         BD Address: 00:02:72:B3:43:18 ACL MTU: 377:10  SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:102019 acl:4770 sco:0 events:292 errors:0
>         TX bytes:5159 acl:258 sco:0 commands:48 errors:0
>         Features: 0xff 0xff 0x0d 0x38 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x3 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x800
>         Manufacturer: Broadcom Corporation (15)

What does "hciconfig hci0 revision" say? These versions look a little
bit wrong.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
