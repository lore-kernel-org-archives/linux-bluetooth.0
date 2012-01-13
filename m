Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Jan 2012 15:11:30 +0100
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix l2cap conn failures for ssp devices
Message-ID: <20120113141130.GA7481@candlejack.bmw-carit.intra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Peter Hurley <peter@hurleysoftware.com>

Commit 330605423c fixed l2cap conn establishment for non-ssp remote
devices by not setting HCI_CONN_ENCRYPT_PEND every time conn security
is tested (which was always returning failure on any subsequent
security checks).

However, this broke l2cap conn establishment for ssp remote devices
when an ACL link was already established at SDP-level security. This
fix ensures that encryption must be pending whenever authentication
is also pending.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
Tested-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---

[this time with the proper "From:" *fingers crossed*]

Hi,

Find below some test results.

Test 1:

./l2test -n -P 1 A0:4E:04:F6:F5:05
./l2test -n -P 3 A0:4E:04:F6:F5:05

Test 2:

./l2test -n -S -P 1 A0:4E:04:F6:F5:05
./l2test -n -P 3 A0:4E:04:F6:F5:05

for legacy pairing and simple paiing and with and without the patch.

cheers,
daniel


Without Path
============

- Legacy Pairing

-- Test 1:

./l2test -n -P 1 A0:4E:04:F6:F5:05
./l2test -n -P 3 A0:4E:04:F6:F5:05

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr A0:4E:04:F6:F5:05 ptype 0x0018 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DH1 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 43 bdaddr A0:4E:04:F6:F5:05 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 43
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr A0:4E:04:F6:F5:05 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 43 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 43
    Features: 0xbf 0xee 0x0f 0xce 0x98 0xbd 0x59 0x83
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr A0:4E:04:F6:F5:05 mode 2 clkoffset 0x0000
< ACL data: handle 43 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 65535 
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 65535 
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr A0:4E:04:F6:F5:05 name 'Nokia 6303i classic'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1

< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 32772 
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 32772 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success

> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x004

< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 43 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 43 reason 0x16
    Reason: Connection Terminated by Local Host

-- Test 2:

./l2test -n -S -P 1 A0:4E:04:F6:F5:05
./l2test -n -P 3 A0:4E:04:F6:F5:05

 HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr A0:4E:04:F6:F5:05 ptype 0x0018 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DH1 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 43 bdaddr A0:4E:04:F6:F5:05 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 43
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr A0:4E:04:F6:F5:05 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 43 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 43
    Features: 0xbf 0xee 0x0f 0xce 0x98 0xbd 0x59 0x83
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr A0:4E:04:F6:F5:05 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr A0:4E:04:F6:F5:05 name 'Nokia 6303i classic'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 43
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr A0:4E:04:F6:F5:05
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr A0:4E:04:F6:F5:05 key 5EB1D3000ABE8C2A12950DACD44ADA2C
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr A0:4E:04:F6:F5:05
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 43
< ACL data: handle 43 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 43 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 43 encrypt 0x01
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 65535 
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 65535 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success

< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 32772 
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 32772 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success

< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 43 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 43 reason 0x16
    Reason: Connection Terminated by Local Host

- Simple Pairing

-- Test 1:

./l2test -n -P 1 A0:4E:04:F6:F5:05
./l2test -n -P 3 A0:4E:04:F6:F5:05

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr A0:4E:04:F6:F5:05 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 43 bdaddr A0:4E:04:F6:F5:05 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 43
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr A0:4E:04:F6:F5:05 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 43 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 43
    Features: 0xbf 0xee 0x0f 0xce 0x98 0xbd 0x59 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 43 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 43 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr A0:4E:04:F6:F5:05 mode 2 clkoffset 0x0000
< ACL data: handle 43 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 43 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 65535 
< ACL data: handle 43 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 65535 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr A0:4E:04:F6:F5:05 name 'Nokia 6303i classic'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1

< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 43
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr A0:4E:04:F6:F5:05
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr A0:4E:04:F6:F5:05 key 6713574AEE7358B4B5EC2773E87F2421
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr A0:4E:04:F6:F5:05
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 43
< ACL data: handle 43 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0
      Connection refused - security block

< ACL data: handle 43 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 43 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 43 reason 0x16
    Reason: Connection Terminated by Local Host

-- Test 2:

./l2test -n -S -P 1 A0:4E:04:F6:F5:05
./l2test -n -P 3 A0:4E:04:F6:F5:05

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr A0:4E:04:F6:F5:05 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 43 bdaddr A0:4E:04:F6:F5:05 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 43
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr A0:4E:04:F6:F5:05 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 43 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 43
    Features: 0xbf 0xee 0x0f 0xce 0x98 0xbd 0x59 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 43 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 43 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr A0:4E:04:F6:F5:05 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr A0:4E:04:F6:F5:05 name 'Nokia 6303i classic'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 43
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr A0:4E:04:F6:F5:05
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr A0:4E:04:F6:F5:05 key 6713574AEE7358B4B5EC2773E87F2421
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr A0:4E:04:F6:F5:05
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 43
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 43 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 43 encrypt 0x01
< ACL data: handle 43 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 43 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 65535 
< ACL data: handle 43 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 65535 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1

< ACL data: handle 43 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 32772 
< ACL data: handle 43 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 32772 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success

< ACL data: handle 43 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< ACL data: handle 43 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 43 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 43 reason 0x16
    Reason: Connection Terminated by Local Host



With Path
=========

-- Test 1:

./l2test -n -P 1 A0:4E:04:F6:F5:05
./l2test -n -P 3 A0:4E:04:F6:F5:05

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr A0:4E:04:F6:F5:05 ptype 0x0018 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DH1 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 43 bdaddr A0:4E:04:F6:F5:05 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 43
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr A0:4E:04:F6:F5:05 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 43 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 43
    Features: 0xbf 0xee 0x0f 0xce 0x98 0xbd 0x59 0x83
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr A0:4E:04:F6:F5:05 mode 2 clkoffset 0x0000
< ACL data: handle 43 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 65535 
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 65535 
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr A0:4E:04:F6:F5:05 name 'Nokia 6303i classic'
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1

< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 32772 
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 32772 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success

< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 43 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 43 reason 0x16
    Reason: Connection Terminated by Local Host

-- Test 2:

./l2test -n -S -P 1 A0:4E:04:F6:F5:05
./l2test -n -P 3 A0:4E:04:F6:F5:05

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr A0:4E:04:F6:F5:05 ptype 0x0018 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DH1 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 43 bdaddr A0:4E:04:F6:F5:05 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 43
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr A0:4E:04:F6:F5:05 mode 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 43 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 43
    Features: 0xbf 0xee 0x0f 0xce 0x98 0xbd 0x59 0x83
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr A0:4E:04:F6:F5:05 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr A0:4E:04:F6:F5:05 name 'Nokia 6303i classic'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 43
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr A0:4E:04:F6:F5:05
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr A0:4E:04:F6:F5:05 key CC52E0B991B112753406D2BA5EC9C127
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr A0:4E:04:F6:F5:05
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 43
< ACL data: handle 43 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 43 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 43 encrypt 0x01
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 65535 
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 65535 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success

< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 32772 
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 32772 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success

< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 43 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 43 reason 0x16
    Reason: Connection Terminated by Local Host

- Simple Pairing

-- Test 1:

./l2test -n -P 1 A0:4E:04:F6:F5:05
./l2test -n -P 3 A0:4E:04:F6:F5:05

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr A0:4E:04:F6:F5:05 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr A0:4E:04:F6:F5:05 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 42
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr A0:4E:04:F6:F5:05 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 42
    Features: 0xbf 0xee 0x0f 0xce 0x98 0xbd 0x59 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 42 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 42 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr A0:4E:04:F6:F5:05 mode 2 clkoffset 0x0000
< ACL data: handle 42 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 65535 
< ACL data: handle 42 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 65535 
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr A0:4E:04:F6:F5:05 name 'Nokia 6303i classic'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1

< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 44
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr A0:4E:04:F6:F5:05
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr A0:4E:04:F6:F5:05 key F1E52B6F2E73A1563FE74E369A545916
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr A0:4E:04:F6:F5:05
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 44
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 44 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 44 encrypt 0x01
< ACL data: handle 44 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 44 packets 1
> ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 44 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 32772 
< ACL data: handle 44 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 32772 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 44 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 44 packets 1
> ACL data: handle 44 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success

< ACL data: handle 44 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 44 packets 1
> ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< ACL data: handle 44 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 44 packets 1
> ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041

-- Test 2:

./l2test -n -S -P 1 A0:4E:04:F6:F5:05
./l2test -n -P 3 A0:4E:04:F6:F5:05

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr A0:4E:04:F6:F5:05 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr A0:4E:04:F6:F5:05 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 42
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr A0:4E:04:F6:F5:05 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 42
    Features: 0xbf 0xee 0x0f 0xce 0x98 0xbd 0x59 0x83
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 42 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 42 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr A0:4E:04:F6:F5:05 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr A0:4E:04:F6:F5:05 name 'Nokia 6303i classic'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 42
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr A0:4E:04:F6:F5:05
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr A0:4E:04:F6:F5:05 key F1E52B6F2E73A1563FE74E369A545916
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr A0:4E:04:F6:F5:05
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 42
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 42 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 42 encrypt 0x01
< ACL data: handle 42 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 65535 
< ACL data: handle 42 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 65535 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success

< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 32772 
< ACL data: handle 42 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 32772 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success

< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< ACL data: handle 42 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 42 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x16
    Reason: Connection Terminated by Local Host


 net/bluetooth/hci_conn.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3db4324..07bc69e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -635,6 +635,10 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 
 	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
 		struct hci_cp_auth_requested cp;
+
+		/* encrypt must be pending if auth is also pending */
+		set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend);
+
 		cp.handle = cpu_to_le16(conn->handle);
 		hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
 							sizeof(cp), &cp);
-- 
1.7.8.2.325.g247f9

