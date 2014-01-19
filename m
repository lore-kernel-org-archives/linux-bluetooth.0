Return-Path: <cyrus@holtmann.org>
Message-ID: <d1fe03c920dacec62bc0f59c62a8932c.squirrel@mungewell.org>
In-Reply-To: <1390153036-10030-1-git-send-email-szymon.janc@gmail.com>
References: <1390153036-10030-1-git-send-email-szymon.janc@gmail.com>
Date: Sun, 19 Jan 2014 14:45:43 -0500
Subject: Re: [PATCH] lib: Use bigger IMTU when connecting SDP
From: simon@mungewell.org
To: "Szymon Janc" <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"David Herrmann" <dh.herrmann@gmail.com>,
	"Frank Praznik" <frank.praznik@oh.rr.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20140119144543_44891"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------=_20140119144543_44891
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> Sony Dualshock 4 controller is ignoring L2CAP MTU while sending SDP
> response. This results in data being dropped and no SDP response is
> received (so no input device was created and HID connection was
> refused). Workaround this by using large IMTU for SDP.

I tried with this and your earlier DS4 patch, on top of a Fedora 20 Live
CD, and unfortunately it does not work for me. I still get the situation
where the DS initiates a connection and then turns off immediately.

I get the log messages
--
Jan 19 14:01:14 localhost systemd: Reached target Bluetooth.
Jan 19 14:01:14 localhost bluetoothd[1803]: Refusing input device connect:
No such file or directory (2)
Jan 19 14:01:14 localhost bluetoothd[1803]: Refusing connection from
1C:66:6D:07:C3:E0: unknown device
--

See log files:
pair_ds4_fedora.txt
connect_ds4_fedora.txt

There is also a problem when the pairing is initiated from the PC side,
seems that the resultant link key is not accepted on connection.

See:
pair_fedora_ds4_2.txt
connect_ds4_fedora_2.txt

I note that the cache file for the DS4's mac picks up some details on a
SDP browse, but not a complete record. This is on an older machine, so BT
chipset might be a factor.

Anything I can try?
Simon

------=_20140119144543_44891
Content-Type: text/plain; name="pair_ds4_fedora.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pair_ds4_fedora.txt"

HCI sniffer - Bluetooth packet analyzer ver 5.13
device: hci0 snap_len: 1500 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 1C:66:6D:07:C3:E0 class 0x002508 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 1C:66:6D:07:C3:E0 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 1C:66:6D:07:C3:E0 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 1C:66:6D:07:C3:E0 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 41
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 1C:66:6D:07:C3:E0 mode 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 41
    Features: 0xff 0xfe 0x0d 0xfe 0x98 0x7f 0x79 0x87
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 1C:66:6D:07:C3:E0 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x0100 (L2CAP)
          max 2048
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 41 flags 0x02 dlen 192
< ACL data: handle 41 flags 0x01 dlen 192
< ACL data: handle 41 flags 0x01 dlen 93
    L2CAP(d): cid 0x0040 len 473 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x1d4
          count 465
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1800 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1f > <
                 uuid-16 0x0007 uint 0x1 uint 0x8 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x000a (DocURL)
                 url "http://www.bluez.org/"
              aid 0x000b (ClientExeURL)
                 url "http://www.bluez.org/"
              aid 0x000c (IconURL)
                 url "http://www.bluez.org/"
              aid 0x0100 (SrvName)
                 str "Generic Access Profile"
              aid 0x0102 (ProviderName)
                 str "BlueZ"
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1801 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1f > <
                 uuid-16 0x0007 uint 0x10 uint 0x10 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0100 (SrvName)
                 str "Generic Attribute Profile"
              aid 0x0102 (ProviderName)
                 str "BlueZ"
          record #2
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110e (AVRemote) uuid-16 0x110f (AVRemCt) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x105 > >
              aid 0x000d (AdditionalProtocolDescLists)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x1b > < uuid-16 0x0017 (AVCTP) uint 0x103 > > >
              aid 0x0100 (SrvName)
                 str "AVRCP CT"
              aid 0x0311 (SuppFeatures)
                 uint 0x4f
          record #3
              aid 0x0000 (SrvRecHndl)
                 uint 0x10004
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110c (AVRemTarget) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x104 > >
              aid 0x000d (AdditionalProtocolDescLists)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x1b > < uuid-16 0x0017 (AVCTP) uint 0x103 > > >
              aid 0x0100 (SrvName)
                 str "AVRCP TG"
              aid 0x0311 (SuppFeatures)
                 uint 0x5f
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 2
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 1C:66:6D:07:C3:E0 name 'Wireless Controller'
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 1C:66:6D:07:C3:E0
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 1C:66:6D:07:C3:E0
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 1C:66:6D:07:C3:E0
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 1C:66:6D:07:C3:E0
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 1C:66:6D:07:C3:E0 len 4 pin '0000'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 1C:66:6D:07:C3:E0
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 1C:66:6D:07:C3:E0 key BC41AFE608E8AD39806F772FCD37F5AD type 0
    Type: Combination Key
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 41 encrypt 0x01
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 41 flags 0x02 dlen 5
    L2CAP(d): cid 0x0041 len 1 [psm 17]
      HIDP: Control: Virtual cable unplug
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0042
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 3 status 0
      Connection refused - security block
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 5
    L2CAP(d): cid 0x0040 len 1 [psm 17]
      HIDP: Handshake: Unsupported request
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x13
    Reason: Remote User Terminated Connection
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 1C:66:6D:07:C3:E0 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x04 handle 0 bdaddr 1C:66:6D:07:C3:E0 type ACL encrypt 0x00
    Error: Page Timeout
------=_20140119144543_44891
Content-Type: text/plain; name="connect_ds4_fedora.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="connect_ds4_fedora.txt"

HCI sniffer - Bluetooth packet analyzer ver 5.13
device: hci0 snap_len: 1500 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 1C:66:6D:07:C3:E0 class 0x002508 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 1C:66:6D:07:C3:E0 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 1C:66:6D:07:C3:E0 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 1C:66:6D:07:C3:E0 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 41
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 1C:66:6D:07:C3:E0 mode 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 41
    Features: 0xff 0xfe 0x0d 0xfe 0x98 0x7f 0x79 0x87
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 1C:66:6D:07:C3:E0 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x0100 (L2CAP)
          max 2048
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 41 flags 0x02 dlen 192
< ACL data: handle 41 flags 0x01 dlen 192
< ACL data: handle 41 flags 0x01 dlen 93
    L2CAP(d): cid 0x0040 len 473 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x1d4
          count 465
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1800 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1f > <
                 uuid-16 0x0007 uint 0x1 uint 0x8 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x000a (DocURL)
                 url "http://www.bluez.org/"
              aid 0x000b (ClientExeURL)
                 url "http://www.bluez.org/"
              aid 0x000c (IconURL)
                 url "http://www.bluez.org/"
              aid 0x0100 (SrvName)
                 str "Generic Access Profile"
              aid 0x0102 (ProviderName)
                 str "BlueZ"
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1801 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1f > <
                 uuid-16 0x0007 uint 0x10 uint 0x10 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0100 (SrvName)
                 str "Generic Attribute Profile"
              aid 0x0102 (ProviderName)
                 str "BlueZ"
          record #2
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110e (AVRemote) uuid-16 0x110f (AVRemCt) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x105 > >
              aid 0x000d (AdditionalProtocolDescLists)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x1b > < uuid-16 0x0017 (AVCTP) uint 0x103 > > >
              aid 0x0100 (SrvName)
                 str "AVRCP CT"
              aid 0x0311 (SuppFeatures)
                 uint 0x4f
          record #3
              aid 0x0000 (SrvRecHndl)
                 uint 0x10004
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110c (AVRemTarget) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x104 > >
              aid 0x000d (AdditionalProtocolDescLists)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x1b > < uuid-16 0x0017 (AVCTP) uint 0x103 > > >
              aid 0x0100 (SrvName)
                 str "AVRCP TG"
              aid 0x0311 (SuppFeatures)
                 uint 0x5f
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 2
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 1C:66:6D:07:C3:E0 name 'Wireless Controller'
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 1C:66:6D:07:C3:E0
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 1C:66:6D:07:C3:E0 key BC41AFE608E8AD39806F772FCD37F5AD
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 1C:66:6D:07:C3:E0
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 41 encrypt 0x01
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 41 flags 0x02 dlen 5
    L2CAP(d): cid 0x0041 len 1 [psm 17]
      HIDP: Control: Virtual cable unplug
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0042
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0042 result 3 status 0
      Connection refused - security block
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 5
    L2CAP(d): cid 0x0040 len 1 [psm 17]
      HIDP: Handshake: Unsupported request
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x13
    Reason: Remote User Terminated Connection
------=_20140119144543_44891
Content-Type: text/plain; name="connect_ds4_fedora_2.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="connect_ds4_fedora_2.txt"

HCI sniffer - Bluetooth packet analyzer ver 5.13
device: hci0 snap_len: 1500 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 1C:66:6D:07:C3:E0 class 0x002508 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 1C:66:6D:07:C3:E0 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 1C:66:6D:07:C3:E0 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 1C:66:6D:07:C3:E0 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 41
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 1C:66:6D:07:C3:E0 mode 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 41
    Features: 0xff 0xfe 0x0d 0xfe 0x98 0x7f 0x79 0x87
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 1C:66:6D:07:C3:E0 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x0100 (L2CAP)
          max 2048
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 41 flags 0x02 dlen 192
< ACL data: handle 41 flags 0x01 dlen 192
< ACL data: handle 41 flags 0x01 dlen 93
    L2CAP(d): cid 0x0040 len 473 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x1d4
          count 465
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1800 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1f > <
                 uuid-16 0x0007 uint 0x1 uint 0x8 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x000a (DocURL)
                 url "http://www.bluez.org/"
              aid 0x000b (ClientExeURL)
                 url "http://www.bluez.org/"
              aid 0x000c (IconURL)
                 url "http://www.bluez.org/"
              aid 0x0100 (SrvName)
                 str "Generic Access Profile"
              aid 0x0102 (ProviderName)
                 str "BlueZ"
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1801 >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1f > <
                 uuid-16 0x0007 uint 0x10 uint 0x10 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0100 (SrvName)
                 str "Generic Attribute Profile"
              aid 0x0102 (ProviderName)
                 str "BlueZ"
          record #2
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110e (AVRemote) uuid-16 0x110f (AVRemCt) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x105 > >
              aid 0x000d (AdditionalProtocolDescLists)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x1b > < uuid-16 0x0017 (AVCTP) uint 0x103 > > >
              aid 0x0100 (SrvName)
                 str "AVRCP CT"
              aid 0x0311 (SuppFeatures)
                 uint 0x4f
          record #3
              aid 0x0000 (SrvRecHndl)
                 uint 0x10004
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110c (AVRemTarget) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x103 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x104 > >
              aid 0x000d (AdditionalProtocolDescLists)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x1b > < uuid-16 0x0017 (AVCTP) uint 0x103 > > >
              aid 0x0100 (SrvName)
                 str "AVRCP TG"
              aid 0x0311 (SuppFeatures)
                 uint 0x5f
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 2
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 1C:66:6D:07:C3:E0 name 'Wireless Controller'
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 1C:66:6D:07:C3:E0
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 1C:66:6D:07:C3:E0 key E7A1FCE56F3CDF257687D829E953C33C
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 1C:66:6D:07:C3:E0
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x05
    Reason: Authentication Failure
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
------=_20140119144543_44891
Content-Type: text/plain; name="pair_fedora_ds4_2.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pair_fedora_ds4_2.txt"

HCI sniffer - Bluetooth packet analyzer ver 5.13
device: hci0 snap_len: 1500 filter: 0xffffffff
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 1C:66:6D:07:C3:E0 ptype 0xcc18 rswitch 0x01 clkoffset 0x514b (valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 1C:66:6D:07:C3:E0 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 41
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 41
    Features: 0xff 0xfe 0x0d 0xfe 0x98 0x7f 0x79 0x87
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 1C:66:6D:07:C3:E0 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 1C:66:6D:07:C3:E0 name 'Wireless Controller'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 41
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 1C:66:6D:07:C3:E0
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 1C:66:6D:07:C3:E0
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 1C:66:6D:07:C3:E0
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 1C:66:6D:07:C3:E0
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 1C:66:6D:07:C3:E0 len 4 pin '0000'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 1C:66:6D:07:C3:E0
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 1C:66:6D:07:C3:E0 key E7A1FCE56F3CDF257687D829E953C33C type 0
    Type: Combination Key
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 41
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 1C:66:6D:07:C3:E0 mode 1 clkoffset 0x514c class 0x002508
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 1C:66:6D:07:C3:E0 mode 1 clkoffset 0x514c class 0x002508
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 1C:66:6D:07:C3:E0 mode 1 clkoffset 0x514c class 0x002508
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
------=_20140119144543_44891
Content-Type: text/plain; name="info_ds4_fedora.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="info_ds4_fedora.txt"

[LinkKey]
Key=0x67C8E811F0C7CF297C6900ABA9A73BA7
Type=0
PINLength=4

[General]
Name=
Class=0x002508
SupportedTechnologies=BR/EDR
Trusted=false
Blocked=false
------=_20140119144543_44891
Content-Type: text/plain; name="cache_after_sdp_browse.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="cache_after_sdp_browse.txt"

[General]
Name=Wireless Controller
------=_20140119144543_44891--


