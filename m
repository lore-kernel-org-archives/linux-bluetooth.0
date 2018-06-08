Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Himanshu Gusain <himanshu.gusain1989@gmail.com>
Date: Thu, 7 Jun 2018 23:57:41 -0500
Message-ID: <CAE8=ow0NqfARmP_o3B_uWSXCMB24_K8mNg7xEvR6c9gRf5_TVQ@mail.gmail.com>
Subject: Bluez PAN Issue
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All

i am having trouble connecting a custom linux board (PANU) to my Nexus 6
device (NAP) which has bluetooth tethering enabled

Below is the hcidump of the issue i am facing

________________________________________________________

# bt-network --connect DC:D9:16:E3:3C:1D nap


< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr DC:D9:16:E3:3C:1D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr DC:D9:16:E3:3C:1D role 0x01
    Role: Slave
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr DC:D9:16:E3:3C:1D type ACL encrypt 0x00
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 12 page 1
> ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 12 page 1 max 2
    Features: 0x0f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> HCI Event: Link Supervision Timeout Change (0x38) plen 4
    handle 12 timeout 8000
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr DC:D9:16:E3:3C:1D mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr DC:D9:16:E3:3C:1D name 'Nexus 6P'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr DC:D9:16:E3:3C:1D
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr DC:D9:16:E3:3C:1D key 672F7591F8712BC8F124A6B1ADCC9B8F
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr DC:D9:16:E3:3C:1D
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 12
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 12 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 12 encrypt 0x01
< ACL data: handle 12 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x02b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
        Unicast Connectless Data Reception
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
> ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 3
< ACL data: handle 12 flags 0x00 dlen 10
    L2CAP(s): Info req: type 3
< ACL data: handle 12 flags 0x00 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x00000006
        L2CAP Signalling Channel
        L2CAP Connless
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x00000082
        L2CAP Signalling Channel
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0040 result 0 status 0
      Connection successful
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1691
< ACL data: handle 12 flags 0x00 dlen 27
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 15
      MTU 1691
      RFC 0x00 (Basic)
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 4
      MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success


< ACL data: handle 12 flags 0x00 dlen 11
    L2CAP(d): cid 0x0047 len 7 [psm 15]
      BNEP: Control(0x01|0)
        Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Setup Rsp(0x02) res 0x0000

Segmentation fault

# > ACL data: handle 12 flags 0x02 dlen 77
    L2CAP(d): cid 0x0040 len 73 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst 33:33:ff:e3:3c:1d [proto 0x86dd]
          IPV6: src :: dst ff02::1:ffe3:3c1d
            ICMPv6:

> ACL data: handle 12 flags 0x02 dlen 89
    L2CAP(d): cid 0x0040 len 85 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst 33:33:00:00:00:16 [proto 0x86dd]
          IPV6: src :: dst ff02::16
            Unknown Protocol: 0x00

< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0047 scid 0x0040

> ACL data: handle 12 flags 0x02 dlen 89
    L2CAP(d): cid 0x0040 len 85 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst 33:33:00:00:00:16 [proto 0x86dd]
          IPV6: src fe80::ded9:16ff:fee3:3c1d dst ff02::16
            Unknown Protocol: 0x80

> ACL data: handle 12 flags 0x02 dlen 149
    L2CAP(d): cid 0x0040 len 145 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst 33:33:00:00:00:16 [proto 0x86dd]
          IPV6: src fe80::ded9:16ff:fee3:3c1d dst ff02::16
            Unknown Protocol: 0x80

> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0047 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 12 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x16
    Reason: Connection Terminated by Local Host
________________________________________________________

-- 
Regards
Himanshu
