Return-Path: <survivor@uni-paderborn.de>
Message-ID: <41474870.3020204@uni-paderborn.de>
Date: Tue, 14 Sep 2004 21:37:20 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
References: <41470C59.2050909@uni-paderborn.de>	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de> <1095189878.5695.201.camel@pegasus>
In-Reply-To: <1095189878.5695.201.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>



Marcel Holtmann schrieb:

>before I start looking at the dump, include the output of hciconfig -a.
>  
>
I forgot to mention that the hcidump was taken at the connecting client, 
but that's obvious.

Ok, here are the hciconfig -a of all three devices:

00:02:72:B1:1D:6C is a listening server (master).
00:02:72:B1:1D:62 is also a listening server (master).
00:02:72:B1:59:46 is the connecting client (slave).


hci0:   Type: USB
        BD Address: 00:02:72:B1:59:46 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:403338 acl:11683 sco:0 events:15307 errors:0
        TX bytes:222599 acl:7967 sco:0 commands:4111 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

hci0:   Type: USB
        BD Address: 00:02:72:B1:1D:6C ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:604827 acl:18955 sco:0 events:25430 errors:0
        TX bytes:683933 acl:18133 sco:0 commands:2396 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

hci0:   Type: USB
        BD Address: 00:02:72:B1:1D:62 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:344077 acl:15137 sco:0 events:11370 errors:0
        TX bytes:395720 acl:10616 sco:0 commands:241 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

>Are you sure that both of your listining servers are set for switching
>the role to master after connection? Remember that the connecting device
>is master in the first place.
>
>  
>
Yes, I'm aware of that, but I don't know if this is a problem. It looks 
like this at the client:

Connections:
        < ACL 00:02:72:B1:1D:62 handle 0 state 5 lm MASTER
Connections:
        < ACL 00:02:72:B1:1D:62 handle 44 state 1 lm SLAVE
Connections:
        < ACL 00:02:72:B1:1D:62 handle 0 state 5 lm MASTER
Connections:
        < ACL 00:02:72:B1:1D:62 handle 48 state 1 lm SLAVE
Connections:
        < ACL 00:02:72:B1:1D:62 handle 0 state 5 lm MASTER
Connections:
        < ACL 00:02:72:B1:1D:62 handle 47 state 1 lm SLAVE
Connections:
        < ACL 00:02:72:B1:1D:6C handle 0 state 5 lm MASTER
Connections:
        < ACL 00:02:72:B1:1D:6C handle 41 state 1 lm SLAVE
Connections:
        < ACL 00:02:72:B1:1D:62 handle 0 state 5 lm MASTER
Connections:
        < ACL 00:02:72:B1:1D:62 handle 46 state 1 lm SLAVE
Connections:
        < ACL 00:02:72:B1:1D:6C handle 0 state 5 lm MASTER
Connections:
        < ACL 00:02:72:B1:1D:6C handle 42 state 1 lm SLAVE
Connections:
        < ACL 00:02:72:B1:1D:62 handle 0 state 5 lm MASTER
Connections:
        < ACL 00:02:72:B1:1D:62 handle 48 state 1 lm SLAVE
Connections:
        < ACL 00:02:72:B1:1D:62 handle 0 state 5 lm MASTER
Connections:
        < ACL 00:02:72:B1:1D:62 handle 47 state 1 lm SLAVE
...

Regards
Stefan
