Return-Path: <nigel.magnay@gmail.com>
Message-ID: <320075ff0409260544471bf1f8@mail.gmail.com>
Date: Sun, 26 Sep 2004 13:44:50 +0100
From: Nigel Magnay <nigel.magnay@gmail.com>
Reply-To: Nigel Magnay <nigel.magnay@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] ipaq 1945
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1096187290.7719.20.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <320075ff040925153753850d92@mail.gmail.com>
	 <1096153758.7719.12.camel@pegasus>
	 <320075ff040926011212538dac@mail.gmail.com>
	 <1096187290.7719.20.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

I get this when the iPAQ connects - this is before I assign an IP to
the bnep0 interface though

HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  79 AF 80 3E 04 00 10 01 12 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  79 AF 80 3E 04 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Link Key Request (0x17) plen 6
  79 AF 80 3E 04 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  79 AF 80 3E 04 00 C2 A3 81 7E E7 06 52 8D 9D 8F 91 5C FF 3A
  90 8A
> HCI Event: Role Change (0x12) plen 8
  00 79 AF 80 3E 04 00 00
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 79 AF 80 3E 04 00
> HCI Event: Connect Complete (0x03) plen 11
  00 28 00 79 AF 80 3E 04 00 01 01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  28 00 0F 00
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  79 AF 80 3E 04 00 01
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 28 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  28 00 18 CC
> HCI Event: Max Slots Change (0x1b) plen 3
  28 00 05
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 28 00 18 CC
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 8
    MTU 512 FlushTO 65535
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1116 (NAP)
          max 0x14
          cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x9
          tot 0x1 cur 0x1 hndl 0x804db38
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SA Req: tid 0x1 len 0xe
          hndl 0x804db38
          max 0x1f0
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 106
    L2CAP(d): cid 0x0040 len 102 [psm 1]
        SDP SA Rsp: tid 0x1 len 0x61
          cnt 0x5e
          aid 0x0000 (SrvRecHndl)
             uint 0x804db38
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1116 (NAP) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) uint 0xf > <
             uuid-16 0x000f (BNEP) uint 0x100 < uint 0x800 uint 0x806 > > >
          aid 0x0005 (BrwGrpList)
             < uuid-16 0x1002 (PubBrwsGrp) >
          aid 0x0009 (BTProfileDescList)
             < < uuid-16 0x1116 (NAP) uint 0x100 > >
          aid 0x0100 (SrvName)
             str "Network Access Point"

          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0041
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 20
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 8
    MTU 1691 FlushTO 65535
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
    MTU 1691
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 15]
      BNEP: Control(0x01|0)
        Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 15]
      BNEP: Control(0x01|0)
        Setup Rsp(0x02) res 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 85
    L2CAP(d): cid 0x0040 len 81 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst 33:33:ff:80:af:79 [proto 0x86dd]
        60 00 00 00 00 20 00 01 00 00 00 00 00 00 00 00 00 00 00 00
        00 00 00 00 FF 02 00 00 00 00 00 00 00 00 00 01 FF 80 AF 79
        3A 00 05 02 00 00 01 00 83 00 20 B0 00 00 00 00 FF 02 00 00
        00 00 00 00 00 00 00 01 FF 80 AF 79
> ACL data: handle 0x0028 flags 0x02 dlen 61
    L2CAP(d): cid 0x0040 len 57 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst 33:33:00:00:00:02 [proto 0x86dd]
        60 00 00 00 00 08 3A FF 00 00 00 00 00 00 00 00 00 00 00 00
        00 00 00 00 FF 02 00 00 00 00 00 00 00 00 00 00 00 00 00 02
        85 00 7B B8 00 00 00 00
> ACL data: handle 0x0028 flags 0x02 dlen 77
    L2CAP(d): cid 0x0040 len 73 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst 33:33:ff:80:af:79 [proto 0x86dd]
        60 00 00 00 00 18 3A FF 00 00 00 00 00 00 00 00 00 00 00 00
        00 00 00 00 FF 02 00 00 00 00 00 00 00 00 00 01 FF 80 AF 79
        87 00 DD 2F 00 00 00 00 FE 80 00 00 00 00 00 00 02 04 3E FF
        FE 80 AF 79
> ACL data: handle 0x0028 flags 0x02 dlen 69
    L2CAP(d): cid 0x0040 len 65 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst 33:33:00:00:00:02 [proto 0x86dd]
        60 00 00 00 00 10 3A FF FE 80 00 00 00 00 00 00 02 04 3E FF
        FE 80 AF 79 FF 02 00 00 00 00 00 00 00 00 00 00 00 00 00 02
        85 00 9F 32 00 00 00 00 01 01 00 04 3E 80 AF 79
> ACL data: handle 0x0028 flags 0x02 dlen 85
    L2CAP(d): cid 0x0040 len 81 [psm 15]
      BNEP: Compressed DestOnly(0x04|0)
        dst 33:33:ff:80:af:79 [proto 0x86dd]
        60 00 00 00 00 20 00 01 FE 80 00 00 00 00 00 00 02 04 3E FF
        FE 80 AF 79 FF 02 00 00 00 00 00 00 00 00 00 01 FF 80 AF 79
        3A 00 05 02 00 00 01 00 83 00 33 31 00 00 00 00 FF 02 00 00
        00 00 00 00 00 00 00 01 FF 80 AF 79
