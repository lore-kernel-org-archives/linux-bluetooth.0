Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcitool scan while hidd connection..
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <ce6230a49ab5d0dff8b85a8a35cfa1f1@pepper.com>
References: <805b11d45747c1dc166defb93f587cf1@pepper.com>
	 <1113607333.16433.46.camel@pegasus>
	 <a0b3fcf839d24cc684e86db701108bb6@pepper.com>
	 <1113836853.16233.97.camel@pegasus>
	 <701b25d25042b2dbf9643b5322f8e8cb@pepper.com>
	 <1113838532.16233.101.camel@pegasus>
	 <ce6230a49ab5d0dff8b85a8a35cfa1f1@pepper.com>
Content-Type: text/plain
Message-Id: <1113839759.16233.104.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 18 Apr 2005 17:55:59 +0200

Hi Michael,

> hci0:   Type: UART
>          BD Address: 00:80:37:21:49:71 ACL MTU: 672:8 SCO MTU: 64:0
>          UP RUNNING PSCAN ISCAN
>          RX bytes:43024 acl:1533 sco:0 events:835 errors:0
>          TX bytes:11573 acl:467 sco:0 commands:103 errors:0
>          Features: 0xff 0xfb 0x01 0x00 0x00 0x00 0x00 0x00
>          Packet type: DM1 DH1 HV1
>          Link policy: HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'Pad2 ((none))'
>          Class: 0x000100
>          Service Classes: Unspecified
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x8105 LMP Ver: 1.1 (0x1) LMP 
> Subver: 0x8d40
>          Manufacturer: Ericsson Technology Licensing (0)

please call "hciconfig hci0 revision" as root. Where is this module
connected to? Any reason to not enable all packet types and allow role
switch?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
