Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinMEH4utheRXZPjh0v-+ms8zPvEXDurvxwQBO6S@mail.gmail.com>
References: <AANLkTim_XfH9jTQLhCVtf4BJd8BJ9pV_2FQzqfOJO6kR@mail.gmail.com>
	<AANLkTik0vPSbwA5G2u7u_c+aZ_3BZaggVyjMftQ-5Cgp@mail.gmail.com>
	<AANLkTikmZfN_A=fyv0=CENCOvPEv5yb+DOXTObptqvUC@mail.gmail.com>
	<ij9edt$65n$2@dough.gmane.org>
	<AANLkTimLrD7HFA4Wz4sdwYJsJSLQ1FkYqm0JHTJucMWN@mail.gmail.com>
	<AANLkTimwLmR5L5H=jeKi7HT2f5b_TTtUt_67TqGGgopT@mail.gmail.com>
	<AANLkTikSZyxKst=3=JRBg1E7a4pW2rUXwjV4n53BL4wT@mail.gmail.com>
	<AANLkTinMEH4utheRXZPjh0v-+ms8zPvEXDurvxwQBO6S@mail.gmail.com>
Date: Mon, 28 Feb 2011 08:05:25 -0300
Message-ID: <AANLkTi=mgDqXjSBNahtXEWbJ+Cj6K3pbfmAT=TJUjPoo@mail.gmail.com>
Subject: [pulseaudio-discuss] Problems trying to connecf HFP device
From: Franz Glauber <franzec05@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I got a dump with hcitool, the last line was after the delay. I got
latest 4.89 bluez and kernel 2.6.36-r5. Any ideas?

< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Supported Features (0x0b) plen 11
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 2 result 1
      Not supported
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 64
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 64
> HCI Event: Number of Completed Packets (0x13) plen 5
< ACL data: handle 1 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x111e (Handsfree)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 17
> ACL data: handle 1 flags 0x01 dlen 17
> ACL data: handle 1 flags 0x01 dlen 17
> ACL data: handle 1 flags 0x01 dlen 17
> ACL data: handle 1 flags 0x01 dlen 17
> ACL data: handle 1 flags 0x01 dlen 17
> ACL data: handle 1 flags 0x01 dlen 4
    L2CAP(d): cid 0x0040 len 119 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x72
          count 111
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x111e (Handsfree) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x111e (Handsfree) uint 0x105 > >
              aid 0x0100 (SrvName)
                 str "Hands-Free"
              aid 0x0102 (ProviderName)
                 str "TERAX COMMUNICATION INC."
              aid 0x0311 (SuppFeatures)
                 uint 0x18
          cont 00
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 261
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 261
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Auth Complete (0x06) plen 3
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Encrypt Change (0x08) plen 4
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 256 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 1
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 256 max_retrans 0 credits 2
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 2
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 11 fcs 0x40
< ACL data: handle 1 flags 0x02 dlen 22
    L2CAP(d): cid 0x0041 len 18 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 14 fcs 0x9a
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 1
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40
< ACL data: handle 1 flags 0x02 dlen 141
    L2CAP(d): cid 0x0041 len 137 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 132 fcs 0x9a
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 1 flags 0x02 dlen 17
    L2CAP(d): cid 0x0041 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40
< ACL data: handle 1 flags 0x02 dlen 32
    L2CAP(d): cid 0x0041 len 28 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 24 fcs 0x9a
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 7
    L2CAP(d): cid 0x0041 len 20 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 16 fcs 0x40
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
> ACL data: handle 1 flags 0x02 dlen 17
> ACL data: handle 1 flags 0x01 dlen 1
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 1
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

> HCI Event: Mode Change (0x14) plen 6

--
Franz

http://ciudaddelpico.com




--
Franz

http://ciudaddelpico.com
