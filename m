Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BNEP session hangs, can't work out why.
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4299F069.3080703@eridani.co.uk>
References: <4299F069.3080703@eridani.co.uk>
Content-Type: text/plain
Message-Id: <1117454226.7072.135.camel@pegasus>
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
Date: Mon, 30 May 2005 13:57:05 +0200

Hi Michael,

> At machine A I have:
> hci0:   Type: USB
>          BD Address: 00:05:16:58:9D:C1 ACL MTU: 192:8 SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN
>          RX bytes:269283 acl:1781 sco:0 events:869 errors:0
>          TX bytes:58266 acl:815 sco:0 commands:42 errors:0
>          Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'BlueZ (0)'
>          Class: 0x3e0100
>          Service Classes: Networking, Rendering, Capturing
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
>          Manufacturer: Cambridge Silicon Radio (10)
> 
> Machine B has:
> hci0:   Type: USB
>          BD Address: 00:0A:94:13:26:7D ACL MTU: 120:20 SCO MTU: 64:0
>          UP RUNNING PSCAN ISCAN
>          RX bytes:72835 acl:1541 sco:0 events:1813 errors:0
>          TX bytes:266197 acl:2713 sco:0 commands:24 errors:0
>          Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'BlueZ (0)'
>          Class: 0x3e0100
>          Service Classes: Networking, Rendering, Capturing
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x757
>          Manufacturer: Silicon Wave (11)
> 
> Everything starts fine, I can get packets flowing.
> 
> Then, without warning, the connection stalls.
> 
> hcidump on A finishes off with:
>        44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 41
>        44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>      L2CAP(d): cid 0x0040 len 71 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 41
>        44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>      L2CAP(d): cid 0x0040 len 71 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 41
>        44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>      L2CAP(d): cid 0x0040 len 71 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 41
>        44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>      L2CAP(d): cid 0x0040 len 71 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 41
>        44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>      L2CAP(d): cid 0x0040 len 71 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        44.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 41
>        44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>      L2CAP(d): cid 0x0040 len 71 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        44.000000 < ACL data: handle 41 flags 0x02 dlen 75
>      L2CAP(d): cid 0x0040 len 71 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        44.000000 > HCI Event: Disconn Complete (0x05) plen 4
>      status 0x00 handle 41 reason 0x13
>      Reason: Remote User Terminated Connection
> 
> Machine B reports:
>        20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 2
>        20.000000 > ACL data: handle 2 flags 0x02 dlen 67
>      L2CAP(d): cid 0x0040 len 63 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        20.000000 < ACL data: handle 2 flags 0x02 dlen 59
>      L2CAP(d): cid 0x0040 len 55 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 2
>        20.000000 > ACL data: handle 2 flags 0x02 dlen 67
>      L2CAP(d): cid 0x0040 len 63 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        20.000000 < ACL data: handle 2 flags 0x02 dlen 59
>      L2CAP(d): cid 0x0040 len 55 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 2
>        20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 24
>      L2CAP(d): cid 0x0040 len 260 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 9
>      L2CAP(d): cid 0x0040 len 365 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        20.000000 > ACL data: handle 2 flags 0x02 dlen 67
>      L2CAP(d): cid 0x0040 len 63 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 38
>      L2CAP(d): cid 0x0040 len 274 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 2
>        20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 2
>        20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 2
>        20.000000 > HCI Event: Number of Completed Packets (0x13) plen 5
>      handle 2
>        20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 94
>      L2CAP(d): cid 0x0040 len 570 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 73
>      L2CAP(d): cid 0x0040 len 789 [psm 15]
>        BNEP: Compressed(0x02|0)
>          [proto 0x0800]
>        20.000000 < ACL data: handle 2 flags 0x02 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < ACL data: handle 2 flags 0x01 dlen 120
>        20.000000 < HCI Command: Disconnect (0x01|0x0006) plen 3
>      handle 2 reason 0x13
>      Reason: Remote User Terminated Connection
>        20.000000 > HCI Event: Command Status (0x0f) plen 4
>      Disconnect (0x01|0x0006) status 0x00 ncmd 1
>        20.000000 > HCI Event: Disconn Complete (0x05) plen 4
>      status 0x00 handle 2 reason 0x16
>      Reason: Connection Terminated by Local Host
> 
> (Aside: The timestamps in hcidump don't appear to be working right.)

they are working for me. Use "hcidump -X -V" and in case of your mailer
it is better you attach it.

> After this, trying 'hcitool info' on each querying the other just results in 
> "Connection timed out".

Show the hcidump for this, too.

> I can't work out which end is at fault.

Check dmesg for any error messages.

> Machine A is running an unpatched 2.4.30, machine B 2.4.28. (2.4.29 had USB 
> issues with my DVD burner.) Both are running bluez-libs and bluez-utils 2.17, 
> and bluz-hcidump 1.21.

What about using a 2.6.12-rc5 kernel?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
