Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hstest with anycom 240 Dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <41C7C3D5.60403@webstuhl.net>
References: <41C7C3D5.60403@webstuhl.net>
Content-Type: text/plain
Message-Id: <1103623667.29892.125.camel@pegasus>
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
Date: Tue, 21 Dec 2004 11:07:47 +0100

Hi Ben,

> output of some commands:
> hciconfig -a
> hci0:   Type: USB
>          BD Address: 00:0B:0D:30:31:FA ACL MTU: 120:20  SCO MTU: 64:0
>          UP RUNNING PSCAN ISCAN
>          RX bytes:986683 acl:22 sco:19305 events:68 errors:0
>          TX bytes:1213 acl:14 sco:0 commands:44 errors:0
>          Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'BlueZ (0)'
>          Class: 0x3e0100
>          Service Classes: Networking, Rendering, Capturing
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 
> 0x757
>          Manufacturer: Silicon Wave (11)
> 
> hciconfig hci0 revision
> -> Unsupported manufacturer
>     ^^^^ bad?

I never really tried this with a Silicon Wave dongle, but in general it
should work. All my tests were done with CSR based dongles.

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
