Return-Path: <cyrus@holtmann.org>
Message-ID: <4C206924.50303@gmail.com>
Date: Tue, 22 Jun 2010 09:41:24 +0200
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: johan.hedberg@gmail.com
Subject: Re: obexd: obex_handle_input: poll event HUP ERR
References: <4C206507.40402@gmail.com> <20100622073841.GA13989@jh-x301>
In-Reply-To: <20100622073841.GA13989@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/22/2010 09:38 AM, Johan Hedberg wrote:
> On Tue, Jun 22, 2010, Jiri Slaby wrote:
>> I have a problem with receiving files with obexd. After it receives
>> header (file name etc.) it hangs up the connection with
>> obex_handle_input: poll event HUP ERR
> 
> libopenobex seems to be indicating REQDONE, so it doesn't look like
> anything is necessarily wrong with obexd here. However, you'd need to
> look at the HCI level trafic (output of "hcidump -XV") to determine
> what's really going on (e.g. is it obexd or the client that's
> disconnecting).

Attached:
# hcidump -XV
HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:24:7D:65:55:C5 class 0x5a020c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:24:7D:65:55:C5 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:24:7D:65:55:C5 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:24:7D:65:55:C5 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 42
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:24:7D:65:55:C5 mode 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 42
    Features: 0xbf 0xee 0x0f 0xce 0x98 0x39 0x00 0x00
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0003
        Flow control mode
        Retransmission mode
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0080
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 5120
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 5120
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672
> ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x1 len 0x8
          pat uuid-16 0x1105 (OBEXObjPush)
          max 65535
          cont 00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:24:7D:65:55:C5 mode 2 clkoffset 0x0000
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x9
          count 1
          handle 0x10000
          cont 00
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          handle 0x10000
          max 1024
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 42 flags 0x02 dlen 36
    L2CAP(d): cid 0x0040 len 32 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x1b
          count 24
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x9 > <
             uuid-16 0x0008 (OBEX) > >
          cont 00
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:24:7D:65:55:C5 name 'Nokia 5800 gep'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 32772
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 32772
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 1013
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 1008 max_retrans 0 credits 3
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 18 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 33
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(d): cid 0x0041 len 12 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 7 fcs 0xd2 credits 4
        OBEX: Connect cmd(f): len 7 version 1.0 flags 0 mtu 65535
< ACL data: handle 42 flags 0x02 dlen 15
    L2CAP(d): cid 0x0041 len 11 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 0 ilen 7 fcs 0x14
        OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 mtu 32767
        Status 200 = Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 89
    L2CAP(d): cid 0x0041 len 85 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 80 fcs 0xd2 credits 1
        OBEX: Put cmd(c): len 80
        Name (0x01) = Unicode length 36
        0000: 00 33 00 32 00 33 00 6d  00 6d 00 3d 00 32 00 30
.3.2.3.m.m.=.2.0
        0010: 00 20 00 31 00 30 00 6b  00 67 00 2e 00 74 00 78  .
.1.0.k.g...t.x
        0020: 00 74 00 00                                       .t..
        Length (0xc3) = 28
        Type (0x42) = Sequence length 11
        0000: 74 65 78 74 2f 70 6c 61  69 6e 00                 text/plain.
        Time (0x44) = Sequence length 16
        0000: 32 30 31 30 30 36 32 32  54 30 35 33 38 33 30 5a
20100622T053830Z
< ACL data: handle 42 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 0 ilen 3 fcs 0x14
        OBEX: Put rsp(f): status 403 len 3
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
