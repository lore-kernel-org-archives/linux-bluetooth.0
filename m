Return-Path: <cyrus@holtmann.org>
From: Gene Heskett <gene.heskett@verizon.net>
To: linux-bluetooth@vger.kernel.org
Subject: Newbie, can't find device
Date: Wed, 25 Mar 2009 20:37:02 -0400
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Message-id: <200903252037.03024.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings;

gnubie to bluetooth that is.  I bought some dongles to replace a cable that is 
just long enough to present EMP surge problems between this box and a 
bluetooth kit installed to replace the connector in an RS-232 pack for a 
legacy computer, an old TRS-80 Color Computer 3 that has all the goodies in it 
that 20 some years of development can give.

I get this from demsg:
[    8.884948] Bluetooth: Core ver 2.14
[    8.885051] Bluetooth: HCI device and connection manager initialized
[    8.885054] Bluetooth: HCI socket layer initialized
[    9.112240] Bluetooth: Generic Bluetooth USB driver ver 0.4
[   21.015636] Bluetooth: L2CAP ver 2.11
[   21.015639] Bluetooth: L2CAP socket layer initialized
[   21.165128] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   21.165131] Bluetooth: BNEP filters: protocol multicast
[   21.245887] Bluetooth: SCO (Voice Link) ver 0.6
[   21.245890] Bluetooth: SCO socket layer initialized
[   22.084606] Bluetooth: RFCOMM socket layer initialized
[   22.084616] Bluetooth: RFCOMM TTY layer initialized
[   22.084618] Bluetooth: RFCOMM ver 1.10

But no new devices are being created by udev.

hciconfig -a:
hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
        UP RUNNING PSCAN ISCAN
        RX bytes:1104 acl:0 sco:0 events:45 errors:0
        TX bytes:445 acl:0 sco:0 commands:45 errors:0
        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'coyote.coyote.den-0'
        Class: 0x4a2100
        Service Classes: Networking, Capturing, Telephony
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver: 0x1f4
        Manufacturer: CONWISE Technology Corporation Ltd (66)

Where do I go from here.  What I need to do is run a session of minicom to it 
but minicom cannot find the device either.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
If a group of _N persons implements a COBOL compiler, there will be _N-1
passes.  Someone in the group has to be the manager.
		-- T. Cheatham

