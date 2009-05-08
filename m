Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 May 2009 02:49:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Security mode 3 pairing acceptor broken with current
	bluetooth-testing
Message-ID: <20090508234902.GA6615@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I'm getting the following with latest bluetooth-testing kernel when
accepting a connection when either device is in security mode 3:

$ hcidump -V -r secmode3-acp.dump
HCI sniffer - Bluetooth packet analyzer ver 1.42
btsnoop version: 1 datalink type: 1002
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:24:7D:XX:XX:XX class 0x5a020c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:24:7D:XX:XX:XX role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:24:7D:XX:XX:XX role 0x00
    Role: Master
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:24:7D:XX:XX:XX
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:24:7D:XX:XX:XX
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:24:7D:XX:XX:XX
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:24:7D:XX:XX:XX
< HCI Command: Create Connection Cancel (0x01|0x0008) plen 6
    bdaddr 00:24:7D:XX:XX:XX
> HCI Event: Command Complete (0x0e) plen 10
    Create Connection Cancel (0x01|0x0008) ncmd 1
    status 0x00 bdaddr 00:24:7D:XX:XX:XX
> HCI Event: Connect Complete (0x03) plen 11
    status 0x02 handle 12 bdaddr 00:24:7D:XX:XX:XX type ACL encrypt 0x00
    Error: Unknown Connection Identifier

As you see, the kernel is sending "Create Connection Cancel" for this acceptor
use case even though it's a connection initiator command. It comes immediately
after the PIN code request when bluetoothd is waiting for the UI to respond.
I'll try to find some time to investigate this during the weekend but decided
to also post it here in case you know a simple fix for it.

Johan
