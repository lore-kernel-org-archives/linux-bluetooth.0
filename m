Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] About rfcomm socket
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41AFDAAB.8010101@avantwave.com>
References: <41AD2B86.6010002@avantwave.com>
	 <1101882506.18840.18.camel@pegasus>  <41AD867D.2060609@avantwave.com>
	 <1101894514.18840.50.camel@pegasus>  <41AE995F.7030107@avantwave.com>
	 <1101973471.15615.81.camel@pegasus>  <41AFDAAB.8010101@avantwave.com>
Content-Type: text/plain
Message-Id: <1102043750.7350.41.camel@pegasus>
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
Date: Fri, 03 Dec 2004 04:15:49 +0100

Hi Mike,

> hci0:   Type: UART
>         BD Address: 00:08:E0:01:49:6A ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:231 acl:0 sco:0 events:27 errors:0
>         TX bytes:630 acl:0 sco:0 commands:27 errors:0
>         Features: 0xff 0xff 0x8b 0x78 0x18 0x18 0x00 0x80
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'test'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x490 LMP Ver: 1.2 (0x2) LMP Subver: 
> 0x490
>         Manufacturer: Cambridge Silicon Radio (10)

this one is fine, because it is a HCI 18.x firmware.

> hci0:   Type: USB
>         BD Address: 00:08:E0:00:00:04 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:4031 acl:64 sco:0 events:143 errors:0
>         TX bytes:2429 acl:66 sco:0 commands:31 errors:0
>         Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy:
>         Link mode: SLAVE ACCEPT
>         Name: 'mike'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 
> 0x175
>         Manufacturer: Cambridge Silicon Radio (10)

This one is HCI 14.7 and previous HCI 16.x which is not good.

> Actually, the 3rd device is a bluetooth-embedded phone, i can not get 
> the configuration out. SLAVE is accept for my target device, is it what 
> you want to see?

You can, use "hcitool info ..." as root.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
