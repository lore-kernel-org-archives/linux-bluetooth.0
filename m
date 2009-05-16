Return-Path: <cyrus@holtmann.org>
Message-ID: <4A0EA712.5020703@makhutov.org>
Date: Sat, 16 May 2009 13:44:18 +0200
From: Artem Makhutov <artem@makhutov.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: uhci_hcd error messages when using bluetooth
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

when I transfering audio using bluetooth I am getting a log of this 
error messages.

I am using bluez-libs and bluez-utils 3.36.

What does this mean? Can this be fixed somehow?

Thanks, Artem

May 16 14:37:00 gw01 [ 2839.832609] uhci_hcd 0000:00:1d.2: reserve dev 3 
ep83-ISO, period 1, phase 0, 22 us
May 16 14:37:00 gw01 [ 2839.917914] uhci_hcd 0000:00:1d.2: reserve dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:02 gw01 [ 2842.006479] uhci_hcd 0000:00:1d.2: release dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:02 gw01 [ 2842.023317] uhci_hcd 0000:00:1d.2: reserve dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:09 gw01 [ 2849.215674] uhci_hcd 0000:00:1d.2: release dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:09 gw01 [ 2849.218486] uhci_hcd 0000:00:1d.2: reserve dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:09 gw01 [ 2849.236674] uhci_hcd 0000:00:1d.2: release dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:09 gw01 [ 2849.238408] uhci_hcd 0000:00:1d.2: reserve dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:10 gw01 [ 2849.856778] uhci_hcd 0000:00:1d.2: release dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:10 gw01 [ 2849.858313] uhci_hcd 0000:00:1d.2: reserve dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:10 gw01 [ 2849.897784] uhci_hcd 0000:00:1d.2: release dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:10 gw01 [ 2849.898705] uhci_hcd 0000:00:1d.2: reserve dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:12 gw01 [ 2852.188168] uhci_hcd 0000:00:1d.2: release dev 3 
ep03-ISO, period 1, phase 0, 21 us
May 16 14:37:12 gw01 [ 2852.214183] uhci_hcd 0000:00:1d.2: release dev 3 
ep83-ISO, period 1, phase 0, 22 us

Here are some more infos about my system:

gw01 ~ # hciconfig -a
hci0:   Type: USB
         BD Address: 00:1A:7D:0B:4A:66 ACL MTU: 384:10 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:2359 acl:22 sco:0 events:62 errors:0
         TX bytes:768 acl:18 sco:0 commands:34 errors:0
         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: HOLD SNIFF PARK
         Link mode: ACCEPT MASTER
         Name: 'BlueZ (0)'
         Class: 0x080100
         Service Classes: Capturing
         Device Class: Computer, Uncategorized
         HCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP 
Subver: 0xc5c
         Manufacturer: Cambridge Silicon Radio (10)

hci1:   Type: USB
         BD Address: 00:1A:7D:0B:49:C8 ACL MTU: 384:10 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:424219 acl:113 sco:8217 events:175 errors:0
         TX bytes:418787 acl:86 sco:8167 commands:44 errors:0
         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: HOLD SNIFF PARK
         Link mode: ACCEPT MASTER
         Name: 'BlueZ (1)'
         Class: 0x080100
         Service Classes: Capturing
         Device Class: Computer, Uncategorized
         HCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP 
Subver: 0xc5c
         Manufacturer: Cambridge Silicon Radio (10)

gw01 ~ # hciconfig hci0 revision
hci0:   Type: USB
         BD Address: 00:1A:7D:0B:4A:66 ACL MTU: 384:10 SCO MTU: 64:8
         Unified 21e
         Chip version: BlueCore4-ROM
         Max key size: 128 bit
         SCO mapping:  HCI
gw01 ~ # hciconfig hci1 revision
hci1:   Type: USB
         BD Address: 00:1A:7D:0B:49:C8 ACL MTU: 384:10 SCO MTU: 64:8
         Unified 21e
         Chip version: BlueCore4-ROM
         Max key size: 128 bit
         SCO mapping:  HCI

gw01 ~ # uname -a
Linux gw01 2.6.29-gentoo-r3 #3 SMP Wed May 13 18:33:14 EEST 2009 i686 
Intel(R) Celeron(R) CPU 1.70GHz GenuineIntel GNU/Linux

gw01 ~ # lsusb
Bus 003 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth 
Dongle (HCI mode)
Bus 003 Device 002: ID 04d9:1603 Holtek Semiconductor, Inc.
Bus 003 Device 001: ID 1d6b:0001
Bus 002 Device 001: ID 1d6b:0001
Bus 001 Device 003: ID 0af0:6701 Option
Bus 001 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth 
Dongle (HCI mode)
Bus 001 Device 001: ID 1d6b:0001

