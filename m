Return-Path: <diego.liziero@unimore.it>
Subject: Re: [Bluez-users] Presentation slides are online
From: Diego Liziero <diego.liziero@unimore.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Nicholas A. Preyss" <nalp@gmx.net>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1088431331.4614.6.camel@pegasus>
References: <1088413405.3774.164.camel@pegasus>
	 <20040628135038.GA28640@gmx.net>  <1088431331.4614.6.camel@pegasus>
Content-Type: text/plain
Message-Id: <1088441350.2987.26.camel@tarta>
Mime-Version: 1.0
Date: Mon, 28 Jun 2004 18:56:11 +0200
List-ID: <bluez-users.lists.sourceforge.net>

I've upgraded D-Link revision B3 and B2 with a iMac
and both of them seem to work fine.

Regards,
Diego.

# hciconfig -a
hci0:   Type: USB
        BD Address: x:x:x:x:x:x ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:32302431 acl:220940 sco:0 events:370334 errors:0
        TX bytes:91175966 acl:515971 sco:0 commands:108 errors:0
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'igno-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x4d9 LMP Ver: 1.2 (0x2) LMP Subver:
0x4d9
        Manufacturer: Cambridge Silicon Radio (10)

# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: x:x:x:x:x:x ACL MTU: 192:8  SCO MTU: 64:8
        Build 1241
        Chip version: BlueCore02
        Max key size: 128 bit
        SCO mapping:  HCI
# hciconfig hci0 version
hci0:   Type: USB
        BD Address: x:x:x:x:x:x ACL MTU: 192:8  SCO MTU: 64:8
        HCI Ver: 1.2 (0x2) HCI Rev: 0x4d9 LMP Ver: 1.2 (0x2) LMP Subver:
0x4d9
        Manufacturer: Cambridge Silicon Radio (10)

Il lun, 2004-06-28 alle 16:02, Marcel Holtmann ha scritto:
> Hi Nicholas,
> 
> > You now have some experience based data, which dongles accept the
signed
> > apple hciproxy firmware and which one render unusable?
> 
> the D-Link revision B3 and the Allnet ALL1575 seem to work fine.
