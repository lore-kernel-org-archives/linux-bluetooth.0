Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 18 Sep 2012 16:26:48 +0300
Message-ID: <CAB7uhOR9JjcU_iKrb=9KmYcko5LQFWffYa9Ae4pe3vbBs43zJA@mail.gmail.com>
Subject: hstest fails in Android
From: Ahmed Abdelfattah <ahmed.abdelfattah.elshemisy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I am testing a Bluetooth chip on Android . Now, I am in the phase of
testing audio connection functionality but it's failing.I ran hstest
with piantronics Bluetooth headset and the problem seems to happen
after a Parameter Negotiation command to the HS, the HS doesn't reply
with PN RSP but instead with DM and then disconnects what could be .
The same test works fine on ubuntu 11.10 so I am sure the headset is
ok. What could be a possible reason for this behavior ?
Here is hcidump log:

< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 5
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:23:7F:EB:4F:10 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 5
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 128 bdaddr 00:23:7F:EB:4F:10 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 128
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 128
    Features: 0xbc 0xec 0x01 0x00 0x18 0x18 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:23:7F:EB:4F:10 mode 2 clkoffset 0x0000
< ACL data: handle 128 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 5
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 128 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 128 packets 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:23:7F:EB:4F:10 name 'PLT_MLXX'
> ACL data: handle 128 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004c scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:23:7F:EB:4F:10
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:23:7F:EB:4F:10 key 81305E3AB5D0447783B7079E1E107374
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 5
    status 0x00 bdaddr 00:23:7F:EB:4F:10
> ACL data: handle 128 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004c scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 128 flags 0x00 dlen 16
    L2CAP(s): Config req: dcid 0x004c flags 0x00 clen 4
      MTU 1013
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 128 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013
< ACL data: handle 128 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x004c flags 0x00 result 0 clen 4
      MTU 1013
< ACL data: handle 128 flags 0x00 dlen 8
    L2CAP(d): cid 0x004c len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 128 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 128 flags 0x00 dlen 18
    L2CAP(d): cid 0x004c len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 12 pf 1 ilen 0 fcs 0x69
< ACL data: handle 128 flags 0x00 dlen 8
    L2CAP(d): cid 0x004c len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 128 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x004c scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 128 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 128 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004c scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 128 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 5
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 128 reason 0x16
    Reason: Connection Terminated by Local Host

-- 
regards ,
Ahmed Abdelfattah
