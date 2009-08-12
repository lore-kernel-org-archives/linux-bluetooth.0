Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 12 Aug 2009 08:43:04 +0530
Message-ID: <43208fe40908112013h79f6c7fcp13e34e8e6a9075a3@mail.gmail.com>
Subject: scotest keeps waiting for connection
From: "Nikunj A. Dadhania" <nikunj.dadhania@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am trying to run scotest across two BT modules. Both are running
kernel 2.6.29-4.

On my laptop I give following command:

[test@localhost test]$ ./scotest -r
scotest[5167]: Waiting for connection ...

On the other PC i am giving following command

[root@dhruv test]$ ./scotest -s -b 64 00:16:41:99:2E:16
scotest[16681]: Connected [handle 46, class 0x000000]
scotest[16681]: Sending ...
scotest[16681]: Send failed: Connection reset by peer (104)
[root@dhruv test]#

When I see the hcidump output it seems that initial SCO connection goes
through successfully. But after sending some SCO data, the remote side
terminates the connection. Also, the remote side does not receive
anything.

Am i missing something here?

Regards,
Nikunj


Here is the output of hcidump:
[root@dhruv ~]# hcidump -V
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:16:41:99:2E:16 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:16:41:99:2E:16 role 0x01
    Role: Slave
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:16:41:99:2E:16 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 42
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:16:41:99:2E:16 mode 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 42 voice setting 0x0060
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 42
    Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:16:41:99:2E:16 mode 2 clkoffset 0x0000
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 3
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:16:41:99:2E:16 name 'localhost.localdomain-0'
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x00 handle 46 bdaddr 00:16:41:99:2E:16 type SCO
    Air mode: CVSD
< SCO data: handle 46 flags 0x00 dlen 64
< SCO data: handle 46 flags 0x00 dlen 64
< SCO data: handle 46 flags 0x00 dlen 64
< SCO data: handle 46 flags 0x00 dlen 64
< SCO data: handle 46 flags 0x00 dlen 64
< SCO data: handle 46 flags 0x00 dlen 64
< SCO data: handle 46 flags 0x00 dlen 64
< SCO data: handle 46 flags 0x00 dlen 64
< SCO data: handle 46 flags 0x00 dlen 64
< SCO data: handle 46 flags 0x00 dlen 64
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 46 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 42 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x16
    Reason: Connection Terminated by Local Host
