Return-Path: <survivor@uni-paderborn.de>
Message-ID: <4148A827.6030103@uni-paderborn.de>
Date: Wed, 15 Sep 2004 22:37:59 +0200
From: Stefan Mischke <survivor@uni-paderborn.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP: One failing connection hurts others?
References: <41470C59.2050909@uni-paderborn.de>	 <1095186861.5695.193.camel@pegasus>  <41474247.8090602@uni-paderborn.de>	 <1095189878.5695.201.camel@pegasus>  <41474870.3020204@uni-paderborn.de>	 <1095191352.5695.205.camel@pegasus>  <41475033.3030209@uni-paderborn.de>	 <1095196325.5263.3.camel@pegasus>  <414780B0.2070908@uni-paderborn.de> <1095234376.5263.10.camel@pegasus>
In-Reply-To: <1095234376.5263.10.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hello Marcel!

I just tested this rather old dongle:

hci0:   Type: USB
        BD Address: 00:06:AB:80:6F:5C ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:64709 acl:1565 sco:0 events:1055 errors:0
        TX bytes:38780 acl:1236 sco:0 commands:297 errors:0
        Features: 0xff 0xfd 0x05 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x2 LMP Ver: 1.1 (0x1) LMP Subver: 
0x1007
        Manufacturer: Broadcom Corporation (15)

Same problem. I tried the same dongle one year ago and it was not 
supported by BlueZ. Now it is. Thumbs up for that!

Marcel Holtmann schrieb:

>There are more than one timeouts in the BlueZ stack. Even the ACL
>disconnect timeout is different for the initiator and the acceptor of
>and ACL connection. Keep an eye on the HCI disconnect events on each of
>your devices and compare the timestamps.
>  
>
I set my timeouts by setting SO_RCVTIMEO and SO_SNDTIMEO on the L2CAP 
socket. But I think this is just the socket timeout. Is there a way to 
influence the internal timeouts of BlueZ (L2CAP, ACL)?

Regards
Stefan
