Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: Re: [Bluez-devel] want duplicate inquiry results during a
	single device inquiry
From: Marcel Holtmann <marcel@holtmann.org>
To: Albert Huang <ashuang@gmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ef9938ec0408131032bc7d05f@mail.gmail.com>
References: <ef9938ec04081309406c2abae3@mail.gmail.com>
	 <1092416317.28711.258.camel@pegasus>
	 <ef9938ec0408131032bc7d05f@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1092419681.4501.4.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 13 Aug 2004 19:54:41 +0200

Hi Albert,

> on the HP iPAQ h5550:
> # hciconfig -a
> hci0:   Type: UART
>         BD Address: 08:00:17:1B:0A:21 ACL MTU: 339:4  SCO MTU: 60:9
>         UP RUNNING PSCAN ISCAN
>         RX bytes:84 acl:0 sco:0 events:10 errors:1
>         TX bytes:298 acl:0 sco:0 commands:10 errors:0
>         Features: 0x00 0x00 0x00 0x00
>         Packet type: DM1 DH1 HV1
>         Link policy: HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'familiar (0)'
>         Class: 0x120112
>         Service Classes: Networking, Object Transfer
>         Device Class: Computer, Handheld
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x180 LMP Ver: 1.1 (0x1) LMP Subver: 0x180
>         Manufacturer: RTX Telecom A/S (21)
> 
> on the desktop (d-link DBT-120):
> # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:80:C8:35:19:C8 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:8308 acl:0 sco:0 events:450 errors:0
>         TX bytes:2202 acl:0 sco:0 commands:338 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'OKN-32-G838'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
>         Manufacturer: Cambridge Silicon Radio (10)

simple answer. RTX send every inquiry response up to the HCI layer and
CSR does not.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
