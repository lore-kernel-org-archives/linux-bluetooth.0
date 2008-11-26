Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 25 Nov 2008 17:38:08 -0800
Message-ID: <35c90d960811251738pc7d0135hada76dfa4d3c67f7@mail.gmail.com>
Subject: l2ping only works for 10 seconds with 2.6.27
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have noticed with 2.6.27 that a bluez receiving side of l2ping will
detch the ACL connection (preventing further l2cap echos) after 10
seconds. HCI log below.

Is this by design, or was it unintentional?

I notice the OSX stack will detach after 60 seconds, so maybe it is by
design, after all the receiving side may not want to deal with these
unsolicited pings forever. In that case do you know the right place to
revert this behavior (l2ping is useful for testing).

Nick

2008-11-25 17:32:06.310607 > HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:17:E8:2E:6B:E3 class 0x00020c type ACL
2008-11-25 17:32:06.310821 < HCI Command: Accept Connection Request
(0x01|0x0009) plen 7
    bdaddr 00:17:E8:2E:6B:E3 role 0x00
    Role: Master
2008-11-25 17:32:06.315826 > HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
2008-11-25 17:32:06.484832 > HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:17:E8:2E:6B:E3 role 0x00
    Role: Master
2008-11-25 17:32:06.517578 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:17:E8:2E:6B:E3 type ACL encrypt 0x00
2008-11-25 17:32:06.517639 > HCI Event: Page Scan Repetition Mode
Change (0x20) plen 7
    bdaddr 00:17:E8:2E:6B:E3 mode 1
2008-11-25 17:32:06.517883 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
    handle 1
2008-11-25 17:32:06.523284 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2008-11-25 17:32:06.530517 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
2008-11-25 17:32:06.530548 > ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2008-11-25 17:32:06.530670 < ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
2008-11-25 17:32:06.540283 < HCI Command: Remote Name Request
(0x01|0x0019) plen 10
    bdaddr 00:17:E8:2E:6B:E3 mode 2 clkoffset 0x0000
2008-11-25 17:32:06.545532 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2008-11-25 17:32:06.577911 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0xff 0x2d 0xfe 0x9b 0xf9 0x00 0x80
2008-11-25 17:32:06.577941 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:17:E8:2E:6B:E3 name 'dream'
2008-11-25 17:32:06.577941 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 1
2008-11-25 17:32:06.610351 > ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo req: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
2008-11-25 17:32:06.610504 < ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo rsp: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
2008-11-25 17:32:06.622192 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 1

[ 10 seconds ]

2008-11-25 17:32:16.169464 > ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo req: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
2008-11-25 17:32:16.169616 < ACL data: handle 1 flags 0x02 dlen 52
    L2CAP(s): Echo rsp: dlen 44
    0000: 41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e 4f 50  ABCDEFGHIJKLMNOP
    0010: 51 52 53 54 55 56 57 58  59 5a 5b 5c 5d 5e 5f 60  QRSTUVWXYZ[\]^_`
    0020: 61 62 63 64 65 66 67 68  41 42 43 44              abcdefghABCD
2008-11-25 17:32:16.183380 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 1 packets 1
2008-11-25 17:32:16.576141 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
2008-11-25 17:32:16.589813 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2008-11-25 17:32:16.589843 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host
