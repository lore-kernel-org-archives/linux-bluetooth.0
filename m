Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Has anyone seen these problems with the
	CSRBlueCore and BlueZ before ?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1DBvrG-0002tO-0b@sc8-sf-mx1.sourceforge.net>
References: <E1DBvrG-0002tO-0b@sc8-sf-mx1.sourceforge.net>
Content-Type: text/plain
Message-Id: <1111071510.11792.88.camel@pegasus>
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
Date: Thu, 17 Mar 2005 15:58:30 +0100

Hi Han,

> The info I get from hciconfig -a is :
> 
> hci0:   Type: UART
>         BD Address: 00:A0:96:0A:BF:D4 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:303 acl:0 sco:0 events:13 errors:0
>         TX bytes:434 acl:0 sco:0 commands:12 errors:0
>         Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'BlueZ (0)'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x5df LMP Ver: 1.2 (0x2) LMP Subver:
> 0x5df
>         Manufacturer: Cambridge Silicon Radio (10)
> 
> This info is what I get just after booting the board.

this is a HCI 18.2 firmware on a BlueCore02 or BlueCore3 chip. What kind
of chip is it? Is it a ROM or External/Flash version?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
