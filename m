Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] L2Ping / Rfcomm connect : Function not
	implemented
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412131147.13321.wim.delvaux@adaptiveplanet.com>
References: <200412122356.09617.wim.delvaux@adaptiveplanet.com>
	 <1102924939.8750.84.camel@pegasus>
	 <200412131147.13321.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1102935713.8750.116.camel@pegasus>
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
Date: Mon, 13 Dec 2004 12:01:53 +0100

Hi Wim,

> > show us "hciconfig -a" from the iPAQ.
> 
> hci0:   Type: UART
>         BD Address: 00:02:C7:0D:85:96 ACL MTU: 128:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH
>         RX bytes:1181186 acl:3150 sco:0 events:1857 errors:0
>         TX bytes:220702 acl:2025 sco:0 commands:49 errors:0
>         Features: 0xff 0xff 0x05 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'familiar'
>         Class: 0x120112
>         Service Classes: Networking, Object Transfer
>         Device Class: Computer, Handheld
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x72 LMP Ver: 1.1 (0x1) LMP Subver: 0x72
>         Manufacturer: Cambridge Silicon Radio (10)

why is this device running in security mode 3 ??? As I always said, you
should use "auth" and "encrypt" only if you know what you are doing. And
btw the "good old" 0x72 firmware is old and can result in unexpected
behaviour with non-CSR chips.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
