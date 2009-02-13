Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 13 Feb 2009 15:05:11 +0530
Message-ID: <6887eb5d0902130135i700fad80v3d460cedb3320f0@mail.gmail.com>
Subject: Problem in Bluez-4.30
From: Kartikey Parmar <kartikey2781@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have installed Bluez-4.30 on Fedora 9 and then configured my
bluetooth adapter like below:

1) ./hciconfig -a hci0 up
2) ./hciconfig -a hci0 auth
3) ./hciconfig -a hci0 encrypt
4) hcitool -i hci0 cc 00:1F:5D:B5:36:BC

I m getting hcidump -X -V output like below:
=================================================================
HCI sniffer - Bluetooth packet analyser ver 1.42
device hci0 snap_len: 1028 filter: 0xffffffff

<HCI Command: Create Connection (0x01 | 0x0005) plen 13
        bdaddr 00:1F:5D:B5:36:BC ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
        Create Connection (0x01 | 0x0005) status 0x00 ncmd1
> HCI event: Link Key Request (0x17) plen 6
        bdaddr 00:1F:5D:B5:36:BC
> HCI Event: Connect Complete (0x03) plen 11
         Status 0x22 handle 0 bdaddr 00:1F:5D:B5:36:BC type ACL encrypt 0x00
         Error: LMP Response Timeout

===============================================================

5) rfcomm connect hci0 00:1F:5D:B5:36:BC 13

I have got hcidump -X -V output like below:

===============================================================
HCI sniffer - Bluetooth packet analyser ver 1.42
device hci0 snap_len: 1028 filter: 0xffffffff

<HCI Command: Create Connection (0x01 | 0x0005) plen 13
        bdaddr 00:1F:5D:B5:36:BC ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
        Create Connection (0x01 | 0x0005) status 0x00 ncmd1
> HCI event: Link Key Request (0x17) plen 6
        bdaddr 00:1F:5D:B5:36:BC
< HCI Command: Create Connection Cancel (0x01 | 0x0008) plen 6
        bdaddr 00:1F:5D:B5:36:BC
> HCI Event: Command status (0x0f) plen 4
        Create Connection Cancel (0x01 | 0x0008) status 0x01 ncmd 1
        Error: Unknown HCI Command

> HCI Event: Connect Complete (0x03) plen 11
         Status 0x22 handle 0 bdaddr 00:1F:5D:B5:36:BC type ACL encrypt 0x00
         Error: LMP Response Timeout
===============================================================

Pls guide me exactly where is the problem?

-- 
Kartikey Parmar
President AAECC
09879095390 (M)
