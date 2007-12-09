Return-Path: <fabchevalier@free.fr>
Message-ID: <475C659C.5000804@free.fr>
Date: Sun, 09 Dec 2007 23:01:00 +0100
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Issue with sniff mode with HBH-DS970 A2DP (TI based version)
Content-Type: multipart/mixed;
 boundary="------------050309090805050206000405"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050309090805050206000405
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Marcel,

Please find below hcidump traces for an issue i've seen with this headset.

In short:

We ask for sniff mode:
< HCI Command: Sniff Mode (0x02|0x0003) plen 10
     handle 42 max 800 min 80 attempt 4 timeout 1
 > HCI Event: Command Status (0x0f) plen 4
     Sniff Mode (0x02|0x0003) status 0x00 ncmd 1

We get Mode change error message:
 > HCI Event: Mode Change (0x14) plen 6
     status 0x24 handle 42 mode 0x00 interval 0
     Error: LMP PDU Not Allowed

After a couple seconds the device finally moves to sniff mode:
 > HCI Event: Mode Change (0x14) plen 6
     status 0x00 handle 42 mode 0x02 interval 2048
     Mode: Sniff

When after a while we want to reopen the AVDTP stream but we forget to
move to active mode.

Is it something you've already seen ?

I'm still investigating the issue...

Cheers,

Fabien


--------------050309090805050206000405
Content-Type: text/x-log;
 name="hbh-ds970-sniff-mode-2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hbh-ds970-sniff-mode-2.log"

====== HEADSET POWER ON PHASE ======

HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:18:13:E7:6D:4F class 0x240404 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:18:13:E7:6D:4F role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:18:13:E7:6D:4F type ACL encrypt 0x00
< ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 42
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:18:13:E7:6D:4F mode 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0051
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0051 result 0 status 0
      Connection successful
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0051 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0051 flags 0x00 clen 0
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 42 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:18:13:E7:6D:4F mode 2 clkoffset 0x0000
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 42 ptype 0xff1e
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 3-DH5 
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 42
    Features: 0xff 0xfd 0x29 0x78 0x18 0x18 0x00 0x80
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Req: tid 0x1 len 0x9
          pat uuid-16 0x111f (Handsfree AG)
          max 10
          cont 00
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0051 len 10 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x5
          count 0
          cont 00
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:18:13:E7:6D:4F name 'HBH-DS970'
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Req: tid 0x2 len 0x9
          pat uuid-16 0x1112 (Headset AG)
          max 10
          cont 00
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0051 len 14 [psm 1]
        SDP SS Rsp: tid 0x2 len 0x9
          count 1
          handle 0x10000
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 25
    L2CAP(d): cid 0x0040 len 21 [psm 1]
        SDP SA Req: tid 0x3 len 0x10
          handle 0x10000
          max 653
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 42 flags 0x02 dlen 42
    L2CAP(d): cid 0x0051 len 38 [psm 1]
        SDP SA Rsp: tid 0x3 len 0x21
          count 30
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1112 (Headset AG) uuid-16 0x1203 (Audio) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0xc > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0051
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0051
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0052
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0052 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 336 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0052 flags 0x00 result 0 clen 4
      MTU 336 
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0052 flags 0x00 clen 4
      MTU 1013 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 1013 
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0052 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 24 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 330 max_retrans 0 credits 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0052 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 24 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 24 pf 1 ilen 0 fcs 0xa2 
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 42
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:18:13:E7:6D:4F
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:18:13:E7:6D:4F key 2D351677C9F24DE6A0955024CAB8B4F8
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:18:13:E7:6D:4F
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 42
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 42 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 42 encrypt 0x01
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0052 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 24 pf 1 ilen 0 fcs 0x69 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0052 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 1 b3 0 len 2
< HCI Command: Change Connection Link Key (0x01|0x0015) plen 2
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 1 len 12
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0052 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 1 b3 0 len 2
> ACL data: handle 42 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 1 len 12
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0052 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 24 pf 1 ilen 0 fcs 0xc8 credits 33
> ACL data: handle 42 flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 24 pf 1 ilen 10 fcs 0x12 credits 20
      0000: 41 54 2b 43 4c 49 50 3d  31 0d                    AT+CLIP=1.
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Link Key (0x01|0x0015) status 0x00 ncmd 1
< ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0052 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 24 pf 0 ilen 9 fcs 0xd4 
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 25
    L2CAP(d): cid 0x0040 len 21 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 24 pf 0 ilen 16 fcs 0xe 
      0000: 41 54 2b 43 53 43 53 3d  22 55 54 46 2d 38 22 0d  AT+CSCS="UTF-8".
< ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0052 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 24 pf 0 ilen 9 fcs 0xd4 
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 33
    L2CAP(d): cid 0x0040 len 29 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 24 pf 1 ilen 23 fcs 0x12 credits 1
      0000: 41 54 2a 53 45 41 4d 3d  22 48 42 48 2d 44 53 39  AT*SEAM="HBH-DS9
      0010: 37 30 22 2c 31 33 0d                              70",13.
< ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0052 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 24 pf 0 ilen 9 fcs 0xd4 
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:18:13:E7:6D:4F key 64BD7D0F4C04CA75BDDB219FA658FB7B type 0
    Type: Combination Key
> HCI Event: Change Connection Link Key Complete (0x09) plen 3
    status 0x00 handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 24 pf 1 ilen 9 fcs 0x12 credits 1
      0000: 41 54 2b 43 4c 41 4e 3f  0d                       AT+CLAN?.
< ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0052 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 24 pf 0 ilen 9 fcs 0xd4 
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 24 pf 1 ilen 12 fcs 0x12 credits 1
      0000: 41 54 2a 45 49 50 53 3d  32 2c 31 0d              AT*EIPS=2,1.
< ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0052 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 24 pf 0 ilen 9 fcs 0xd4 
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 24 pf 1 ilen 10 fcs 0x12 credits 1
      0000: 41 54 2b 43 4f 4c 50 3d  31 0d                    AT+COLP=1.
< ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0052 len 13 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 24 pf 0 ilen 9 fcs 0xd4 
      0000: 0d 0a 45 52 52 4f 52 0d  0a                       ..ERROR..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0053
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0053 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0053 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0053 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 1]
        SDP SS Req: tid 0x4 len 0x9
          pat uuid-16 0x110c (AVRemTarget)
          max 10
          cont 00
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0053 len 10 [psm 1]
        SDP SS Rsp: tid 0x4 len 0x5
          count 0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 1]
        SDP SS Req: tid 0x5 len 0x9
          pat uuid-16 0x110e (AVRemote)
          max 10
          cont 00
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0053 len 10 [psm 1]
        SDP SS Rsp: tid 0x5 len 0x5
          count 0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 1]
        SDP SS Req: tid 0x6 len 0x9
          pat uuid-16 0x110a (AudioSource)
          max 10
          cont 00
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0053 len 14 [psm 1]
        SDP SS Rsp: tid 0x6 len 0x9
          count 1
          handle 0x10001
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 31
    L2CAP(d): cid 0x0041 len 27 [psm 1]
        SDP SA Req: tid 0x7 len 0x16
          handle 0x10001
          max 653
          aid(s) 0x0001 (SrvClassIDList) 0x0004 (ProtocolDescList) 0x0009 (BTProfileDescList) 0x0311 (SuppFeatures)
          cont 00
< ACL data: handle 42 flags 0x02 dlen 62
    L2CAP(d): cid 0x0053 len 58 [psm 1]
        SDP SA Rsp: tid 0x7 len 0x35
          count 50
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x110a (AudioSource) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) uint 0x19 > <
             uuid-16 0x0019 (AVDTP) uint 0x100 > >
          aid 0x0009 (BTProfileDescList)
             < < uuid-16 0x110d (AdvAudio) uint 0x100 > >
          aid 0x0311 (SuppFeatures)
             uint 0xf
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 34
    L2CAP(d): cid 0x0041 len 30 [psm 1]
        SDP SA Req: tid 0x8 len 0x19
          handle 0x0
          max 653
          aid(s) 0x0003 (SrvID) 0x0100 (SrvName) 0x0101 (SrvDesc) 0x0201 (SrvDBState) 0x0300 (SrvVersion)
          cont 00
< ACL data: handle 42 flags 0x02 dlen 22
    L2CAP(d): cid 0x0053 len 18 [psm 1]
        SDP SA Rsp: tid 0x8 len 0xd
          count 10
          aid 0x0201 (SrvDBState)
             uint 0x475c5eec
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0053
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0053
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0054
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0054 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0054 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0054 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0055
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0055 result 2 status 0
      Connection refused - PSM not supported
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 0
< ACL data: handle 42 flags 0x02 dlen 22
    L2CAP(d): cid 0x0054 len 18 [psm 25]
      AVDTP(s): Discover rsp: transaction 0
        ACP SEID 1 - Audio Source
        ACP SEID 2 - Audio Source
        ACP SEID 3 - Audio Source
        ACP SEID 4 - Audio Source
        ACP SEID 5 - Audio Source
        ACP SEID 6 - Audio Source
        ACP SEID 7 - Audio Source
        ACP SEID 8 - Audio Source
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 1
        ACP SEID 1
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(d): cid 0x0054 len 12 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 1
        Media Transport
        Media Codec - SBC
          16kHz 32kHz 44.1kHz 48kHz 
          Mono DualChannel Stereo JointStereo 
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness 
          Bitpool Range 2-64
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 2
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          44.1kHz 
          JointStereo 
          16 Blocks
          8 Subbands
          SNR 
          Bitpool Range 2-64
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0054 len 4 [psm 25]
      AVDTP(s): Set config rsp: transaction 2
      0000: 04 04                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 25]
      AVDTP(s): Open cmd: transaction 3
        ACP SEID 1
< ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0054 len 2 [psm 25]
      AVDTP(s): Open rsp: transaction 3
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0056
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0056 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0056 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0056 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
      MTU 672 
> ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 25]
      AVDTP(s): Start cmd: transaction 4
        ACP SEID 1
< ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0054 len 2 [psm 25]
      AVDTP(s): Start rsp: transaction 4
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0054 len 3 [psm 25]
      AVDTP(s): Suspend cmd: transaction 0
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Suspend rsp: transaction 0
< HCI Command: Sniff Mode (0x02|0x0003) plen 10
    handle 42 max 800 min 80 attempt 4 timeout 1
> HCI Event: Command Status (0x0f) plen 4
    Sniff Mode (0x02|0x0003) status 0x00 ncmd 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x24 handle 42 mode 0x00 interval 0
    Error: LMP PDU Not Allowed
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0054 len 3 [psm 25]
      AVDTP(s): Close cmd: transaction 1
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Close rsp: transaction 1
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0056 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0056 scid 0x0042
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0054 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x02 interval 2048
    Mode: Sniff
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0054 scid 0x0041

======= START PLAYBACK PHASE =============

< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0057 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0057 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0057 flags 0x00 result 0 clen 4
      MTU 672 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0057 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 25]
      AVDTP(s): Discover rsp: transaction 2
        ACP SEID 1 - Audio Sink
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0057 len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 3
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 20
    L2CAP(d): cid 0x0041 len 16 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 3
        Media Transport
        Media Codec - SBC
          16kHz 32kHz 44.1kHz 48kHz 
          Mono DualChannel Stereo JointStereo 
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness 
          Bitpool Range 2-250
        Content Protection
          02 00 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0057 len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 4
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          44.1kHz 
          Stereo 
          16 Blocks
          8 Subbands
          Loudness 
          Bitpool Range 2-53
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Set config rsp: transaction 4
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0057 len 3 [psm 25]
      AVDTP(s): Open cmd: transaction 5
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Open rsp: transaction 5
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0058 scid 0x0042 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0058 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0058 flags 0x00 result 0 clen 4
      MTU 672 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
      MTU 672 
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0057 len 3 [psm 25]
      AVDTP(s): Start cmd: transaction 6
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x00 interval 0
    Mode: Active
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Start rsp: transaction 6
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 0 time 640 ssrc 1
      0000: 05 9c b9 35 38 00 00 00  00 00 00 00 00 33 76 db  ...58........3v.
      0010: 26 ec 96 cb 99 96 c9 33  64 b2 5c dd 92 4b bb 25  &......3d.\..K.%
      0020: b2 e6 65 b6 4d d9 2d 97  37 64 92 ee c9 6c b9 bb  ..e.M.-.7d...l..
      0030: 2c b7 32 49 2c cd d9 6c  bb 96 59 26 e6 5b 2d dd  ,.2I,..l..Y&.[-.
      0040: b6 db 33 36 db 2e ed 92  4b 9b 92 59 77 65 96 cd  ..36....K..Ywe..
      0050: cd 96 5b 99 2d b2 e6 6c  b6 4d c9 2c b3 77 6d 96  ..[.-..l.M.,.wm.
      0060: e6 cb 2c b9 99 6c 97 72  cb 24 dc cb 25 9b 96 4b  ..,..l.r.$..%..K
      0070: 6e 66 c9 6d dc b2 cb 9c  b9 35 38 00 00 00 00 00  nf.m.....58.....
      0080: 00 00 00 33 32 49 26 e4  96 59 bb 92 db 33 25 96  ...32I&..Y...3%.
      0090: 4c cd b6 4b bb 6d b6 e6  e5 b2 4c db 65 97 73 6c  L..K.m....L.e.sl
      00a0: 96 e6 d9 25 99 b9 65 b7  72 5b 64 dd cb 2c 9b 92  ...%..e.r[d..,..
      00b0: c9 66 ee 49 2d cc 96 cb  73 32 db 26 ec 92 db 99  .f.I-...s2.&....
      00c0: 96 cb 33 64 b2 cd dc 96  c9 b9 6c b2 66 65 b6 4d  ..3d......l.fe.M
      00d0: d9 2d b3 77 25 92 66 59  6c b9 9b 6d 93 32 59 6c  .-.w%.fYl..m.2Yl
      00e0: dd db 65 9b b6 c9 2e e6  d9 25 cd 96 d9 9c b9 35  ..e......%.....5
      00f0: 38 00 00 00 00 00 00 00  00 37 36 cb 6e e5 96 d9  8........76.n...
      0100: 99 92 db 77 64 b2 cd cd  92 4b 99 6d b2 66 ec 96  ...wd....K.m.f..
      0110: cd db 6c 97 77 2c 96 e6  cb 25 99 99 2c b7 32 d9  ..l.w,...%..,.2.
      0120: 65 dd db 6d 9b 92 d9 66  66 5b 6c cc 92 d9 37 72  e..m...ff[l...7r
      0130: 5b 6e ec b6 cb 9b b6 5b  77 2d 92 dc dd 96 cb 99  [n.....[w-......
      0140: 2d b6 66 65 b6 dc c9 6c  93 73 2c b2 6e 4b 24 b9  -.fe...l.s,.nK$.
      0150: 9b 25 93 36 4b 2c dc c9  2c bb b6 d9 6e 6e c9 64  .%.6K,..,...nn.d
      0160: dd b2 4b 9c b9 35 38 00  00 00 00 00 00 00 00 37  ..K..58........7
      0170: 72 49 2e e5 96 49 9b b2  59 37 2d b2 5c dc b2 5b  rI...I..Y7-.\..[
      0180: b9 2d 92 ee 65 96 5d c9  24 b7 33 65 b6 66 4b 64  .-..e.].$.3e.fKd
      0190: 9b 99 25 93 72 5b 24 dc  cb 64 99 92 5b 66 e6 db  ..%.r[$..d..[f..
      01a0: 6d dc b6 cb 77 36 49 66  e4 92 49 9b b6 49 77 6d  m...w6If..I..Iwm
      01b0: b6 dd dd 96 59 9b 64 92  66 e5 92 dc cb 2d 97 33  ....Y.d.f....-.3
      01c0: 6c b2 6e cb 25 b9 b9 2d  93 76 49 2c cc cb 6d bb  l.n.%..-.vI,..m.
      01d0: 92 d9 2e e6 49 2c dd b6  cb 9c b9 35 38 00 00 00  ....I,.....58...
      01e0: 00 00 00 00 00 37 72 59  2e 65 b2 59 9b b6 59 37  .....7rY.e.Y..Y7
      01f0: 24 b6 5d cd 92 4b bb 24  96 6e 6c b2 cd c9 6d 97  $.]..K.$.nl...m.
      0200: 77 6c 96 ee cb 64 bb 9b  64 b3 76 cb 6c cc d9 2c  wl...d..d.v.l..,
      0210: 99 b2 cb 66 ee 5b 24 cd  96 5b 33 32 5b 26 e5 b2  ...f.[$..[32[&..
      0220: db bb 92 db 37 25 b2 cd  cd 92 5b 99 25 96 6e 6d  ....7%....[.%.nm
      0230: b2 dd d9 65 97 37 25 92  6e 59 6c 99 99 6d 93 32  ...e.7%.nYl..m.2
      0240: db 6c dc d9 2c b9 b2 d9  6e e6 d9 6c dd b6 5b     .l..,...n..l..[
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 1 time 1280 ssrc 1
      0000: 05 9c b9 35 38 00 00 00  00 00 00 00 00 77 76 59  ...58........wvY
      0010: 26 6d 96 db bb b2 db 73  2c 96 5d dc b6 59 9b 64  &m.....s,.]..Y.d
      0020: b2 e6 ed 92 cc c9 24 b7  77 2d b6 66 db 2c 99 bb  ......$.w-.f.,..
      0030: 2d b3 36 db 6d cd c9 2c  bb 92 d9 66 e6 59 65 dd  -.6.m..,...f.Ye.
      0040: b2 59 33 76 db 66 6d 92  5b b9 96 db 37 6d b2 cd  .Y3v.fm.[...7m..
      0050: cd b2 49 bb 2d b6 6e e4  b2 4d db 25 97 33 65 96  ..I.-.n..M.%.3e.
      0060: 66 c9 6c bb b9 64 b7 32  d9 2d dc d9 6c bb b2 4b  f.l..d.2.-..l..K
      0070: 2e ee c9 2c dc b2 4b 9c  b9 35 38 00 00 00 00 00  ...,..K..58.....
      0080: 00 00 00 73 32 cb 66 6c  96 cb 9b 92 db 37 2c b6  ...s2.fl.....7,.
      0090: 5d cd 96 4b bb 6c 92 6e  64 b2 4c d9 6d b3 73 65  ]..K.l.nd.L.m.se
      00a0: 92 e6 4b 2c 99 b9 64 b7  76 d9 25 cc d9 6d 9b 92  ..K,..d.v.%..m..
      00b0: d9 66 e6 db 25 cc 96 d9  73 72 49 6e e4 b6 49 b9  .f..%...srIn..I.
      00c0: b6 5b 37 6d b2 4c dc 96  5b 9b 2d b6 e6 ed b6 5d  .[7m.L..[.-....]
      00d0: cb 2d b3 37 24 96 6e 49  2d b9 99 6c 93 76 59 65  .-.7$.nI-..l.vYe
      00e0: cc db 6c 99 96 49 26 ee  c9 64 cd b6 49 9c b9 35  ..l..I&..d..I..5
      00f0: 38 00 00 00 00 00 00 00  00 37 72 49 6e 65 b6 5b  8........7rIne.[
      0100: bb b6 d9 33 6c b6 4d dc  96 d9 bb 24 96 ee e5 b2  ...3l.M....$....
      0110: dc d9 2c 97 33 2d 92 66  d9 2d b9 9b 25 97 36 c9  ..,.3-.f.-..%.6.
      0120: 6c cd db 24 99 b2 59 6e  e6 59 64 cd b2 59 77 72  l..$..Yn.Yd..Ywr
      0130: c9 2e 65 92 c9 bb 92 59  33 64 b2 5c dc b2 db 9b  ..e....Y3d.\....
      0140: 65 b6 66 6c 92 4d db 24  b3 37 6d b6 66 d9 25 bb  e.fl.M.$.7m.f.%.
      0150: 9b 65 b7 36 c9 24 dc c9  6c bb 96 5b 66 e6 db 2d  .e.6.$..l..[f..-
      0160: cd 92 cb 9c b9 35 38 00  00 00 00 00 00 00 00 77  .....58........w
      0170: 76 cb 66 64 96 db 99 b6  5b 77 65 b6 5d cc 92 cb  v.fd....[we.]...
      0180: 9b 64 b2 ee 6c b2 4d d9  25 97 33 2c 96 66 5b 25  .d..l.M.%.3,.f[%
      0190: 99 99 2d b7 36 c9 64 cd  cb 2d 9b b2 c9 66 6e 59  ..-.6.d..-...fnY
      01a0: 24 cc 92 cb 37 76 cb 6e  6c 92 59 9b b6 d9 37 65  $...7v.nl.Y...7e
      01b0: b2 cd cc 92 c9 bb 2d b2  6e 64 96 5d db 6d 97 33  ......-.nd.].m.3
      01c0: 6c 96 66 59 64 b9 bb 2c  b7 76 4b 6c cd c9 64 bb  l.fYd..,.vKl..d.
      01d0: 96 cb 66 6e cb 6c dd 96  c9 9c b9 35 38 00 00 00  ..fn.l.....58...
      01e0: 00 00 00 00 00 33 36 5b  6e ed b2 db bb b2 49 73  .....36[n.....Is
      01f0: 6c b2 dc dd 96 59 9b 6c  92 6e ed b2 4c db 2d b3  l....Y.l.n..L.-.
      0200: 77 25 b6 6e cb 25 bb 9b  65 b7 32 cb 64 cc c9 65  w%.n.%..e.2.d..e
      0210: 99 b2 cb 6e e6 49 65 cd  96 d9 77 36 59 6e ec b2  ...n.Ie...w6Yn..
      0220: 59 b9 96 49 37 24 96 5d  cd b2 cb b9 6c 92 e6 64  Y..I7$.]....l..d
      0230: 96 cc cb 24 b3 37 2c b6  66 d9 2d b9 bb 25 b7 36  ...$.7,.f.-..%.6
      0240: db 6d cc cb 6d b9 96 cb  2e ee d9 6c cd 92 db     .m..m......l...
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 2 time 1920 ssrc 1
      0000: 05 9c b9 35 38 00 00 00  00 00 00 00 00 73 76 4b  ...58........svK
      0010: 26 6c b2 db b9 96 d9 33  2c b6 cc cc b6 59 bb 64  &l.....3,....Y.d
      0020: 96 ee 6d 96 5c db 25 93  77 24 b2 e6 49 65 b9 bb  ..m.\.%.w$..Ie..
      0030: 6c b7 76 59 65 cd c9 64  bb 96 db 2e e6 59 2d dc  l.vYe..d.....Y-.
      0040: 96 4b 77 36 c9 26 e4 92  cb 99 b2 c9 73 25 b6 5c  .Kw6.&......s%.\
      0050: cc b6 db 99 65 b2 6e 64  b2 cd d9 64 97 37 25 92  ....e.nd...d.7%.
      0060: ee 49 6d 99 bb 2c 93 36  d9 2c dc d9 24 9b 96 cb  .Im..,.6.,..$...
      0070: 26 e6 c9 6d cd 96 5b 9c  b9 35 38 00 00 00 00 00  &..m..[..58.....
      0080: 00 00 00 33 36 5b 2e ec  92 c9 b9 96 49 37 64 b6  ...36[......I7d.
      0090: dd cd 92 c9 bb 6c 92 ee  ec 96 dc c9 65 b3 37 64  .....l......e.7d
      00a0: 96 ee c9 6d bb 99 64 b3  32 59 24 dc db 6c 9b b6  ...m..d.2Y$..l..
      00b0: 49 66 66 cb 25 cd b6 5b  33 32 5b 26 e4 b6 5b bb  Iff.%..[32[&..[.
      00c0: b2 49 37 2c 96 4d dd b6  db 9b 25 92 e6 e5 96 4d  .I7,.M....%....M
      00d0: cb 2c b7 77 65 b2 ee db  24 b9 9b 2c b3 32 cb 24  .,.we...$..,.2.$
      00e0: cc d9 64 9b b6 cb 26 e6  d9 6d dc b2 5b 9c b9 35  ..d...&..m..[..5
      00f0: 38 00 00 00 00 00 00 00  00 37 76 5b 6e 64 92 59  8........7v[nd.Y
      0100: 9b b6 cb 73 6d 96 5c dc  96 59 bb 65 92 6e 64 96  ...sm.\..Y.e.nd.
      0110: 5d d9 2c b7 37 24 b2 ee  4b 2c b9 bb 64 b3 32 cb  ].,.7$..K,..d.2.
      0120: 25 cd db 2c bb b2 db 6e  66 db 24 dc 92 49 73 72  %..,...nf.$..Isr
      0130: db 6e ec b6 59 b9 b2 49  37 6d b2 dc dc b6 4b 99  .n..Y..I7m....K.
      0140: 24 92 6e e5 b2 dd c9 25  b3 33 25 b6 ee 49 64 9b  $.n....%.3%..Id.
      0150: bb 64 93 32 59 64 dd cb  65 9b b2 49 66 e6 db 6c  .d.2Yd..e..If..l
      0160: dc b6 4b 9c b9 35 38 00  00 00 00 00 00 00 00 37  ..K..58........7
      0170: 36 4b 66 65 96 c9 9b 92  cb 33 24 b6 cd dd b2 cb  6Kfe.....3$.....
      0180: b9 64 b2 e6 65 96 dc cb  6c b3 77 24 96 e6 5b 24  .d..e...l.w$..[$
      0190: 99 b9 6c 97 72 4b 6c cc  cb 2c b9 92 d9 2e ee 4b  ..l.rKl..,.....K
      01a0: 2d cc 92 c9 77 36 49 6e  ec 96 db 9b b2 cb 77 24  -...w6In......w$
      01b0: b2 4d cd 92 db 9b 2c b6  ee e5 96 4c c9 6c 93 77  .M....,....L.l.w
      01c0: 2d 96 6e db 65 b9 9b 2d  b7 76 cb 6d dd db 2d 99  -.n.e..-.v.m..-.
      01d0: 96 c9 6e 66 49 25 cd 92  d9 9c b9 35 38 00 00 00  ..nfI%.....58...
      01e0: 00 00 00 00 00 37 32 db  26 e4 d6 cb 9b 96 d9 70  .....72.&......p
      01f0: 66 96 cc cd b6 cb b9 25  b2 6e e5 b2 4d db 24 b7  f......%.n..M.$.
      0200: 37 65 92 e6 d9 2d 9b 9b  2c b7 76 59 2d cd d9 65  7e...-..,.vY-..e
      0210: b9 b6 4b 26 e6 59 6c dc  b6 cb 73 32 cb 2e ec b2  ..K&.Yl...s2....
      0220: d9 bb 96 5b 37 2d 96 4d  cc b2 cb 9b 65 b6 6e e4  ...[7-.M....e.n.
      0230: b2 cd cb 2d 97 37 2d 96  e6 d9 25 9b 9b 65 b3 36  ...-.7-...%..e.6
      0240: cb 2d cd cb 65 b9 b2 4b  66 e6 db 25 cc 96 49     .-..e..Kf..%..I
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 3 time 2560 ssrc 1
      0000: 05 9c b9 35 38 00 00 00  00 00 00 00 00 73 36 59  ...58........s6Y
      0010: 26 6c b6 49 bb 92 d9 73  2d 92 cc dd 96 db bb 6d  &l.I...s-......m
      0020: b6 e6 ed b2 dc cb 25 93  77 25 96 e6 59 2c 99 bb  ......%.w%..Y,..
      0030: 2d 93 76 59 24 dd d9 6d  99 92 49 6e e6 4b 65 dd  -.vY$..m..In.Ke.
      0040: b6 d9 77 76 49 6e 65 b6  c9 9b b2 d9 73 65 b6 cc  ..wvIne.....se..
      0050: dd b2 db b9 25 92 66 e5  92 dc db 6c b7 77 64 b2  ....%.f....l.wd.
      0060: 66 cb 6c bb 99 04 97 76  5b 2d ed db 6d bd 96 db  f.l....v[-..m...
      0070: 26 e6 cb 6c dc 96 db 9c  b9 35 8c 00 00 00 00 00  &..l.....5......
      0080: 00 10 00 24 86 c9 65 8b  f2 5b 65 b2 cd 24 cf b6  ...$..e..[e..$..
      0090: 59 2c b6 db 6d 7d 96 58  24 92 49 2b e4 b6 cb 74  Y,..m}.X$.I+...t
      00a0: 92 49 7f 6c ba 5d ad 96  5c fb 6d 92 41 6d b6 2f  .I.l.]..\.m.Am./
      00b0: c9 2d 92 43 2d 92 fe 5b  2d b6 cb 21 bb f2 cb 2c  .-.C-..[-..!...,
      00c0: 9a cb 2d bf d2 69 2d b6  eb 2c fd d6 c1 0d 92 d9  ..-..i-..,......
      00d0: 73 e1 97 4d ac 37 4d 1f  66 96 d9 6d b2 49 f9 64  s..M.7M.f..m.I.d
      00e0: 92 41 64 32 d7 db 74 b7  41 66 8b be 69 9c b9 35  .Ad2..t.Af..i..5
      00f0: ba 10 10 11 00 20 01 11  10 3f 7d ef 7f bc f3 5b  ..... ...?}....[
      0100: fa e7 5b fd eb 3b d7 cf  5c d7 eb 7a d7 7e ba cf  ..[..;..\..z.~..
      0110: 1f 5a de f7 f3 ce 75 fb  d6 f5 9f af 73 c7 d7 35  .Z....u.....s..5
      0120: bd 7c f3 cd 7e f5 9d 73  eb bd 6d f7 be 63 5f 9d  .|..~..s..m..c_.
      0130: 6f 6f bd f3 7e fa f3 7b  7e 63 3a d7 c7 00 e3 eb  oo..~..{~c:.....
      0140: 7a ce 7e bb d7 1f 5c f6  b5 f5 c7 38 fc d6 73 8f  z.~...\....8..s.
      0150: de bd af ce b5 8d 7e f7  9c 00 09 ed e0 03 bd eb  ......~.........
      0160: f3 cf 6f 9c b9 35 8f 11  11 11 10 20 11 21 10 7d  ..o..5..... .!.}
      0170: d5 65 1c ef 2e 02 ee b2  fd cf 35 56 9f 59 5d 0e  .e........5V.Y].
      0180: 3b ab e5 fa ea 9b 29 d6  69 93 cd 56 5b 6f 2e aa  ;.....).i..V[o..
      0190: 4e 26 2a da f5 95 ac 09  71 d6 9b bc ba 00 3b 88  N&*.....q.....;.
      01a0: c7 3d 55 0c 9c 65 74 b4  f2 ec d6 e1 2a e2 4f 75  .=U..et.....*.Ou
      01b0: 69 0f 97 75 6d 78 ca 44  79 eb ca 6d d6 60 a1 cd  i..umx.Dy..m.`..
      01c0: 74 63 4e f2 c5 4e aa e0  9a 7b d0 64 09 57 d0 07  tcN..N...{.d.W..
      01d0: ca c8 63 bb b9 99 1d d6  a2 9c b9 35 0c 53 33 22  ..c........5.S3"
      01e0: 10 53 23 32 20 7c cd 05  af 9e 1c 4b f6 76 4c 7e  .S#2 |.....K.vL~
      01f0: b0 cb 20 bb 43 4c 06 a6  c2 f2 1d e3 5d 33 c2 d7  .. .CL......]3..
      0200: b0 ce 60 f5 da 18 3c 67  76 d7 ae ed a9 cc 3b b2  ..`...<gv.....;.
      0210: b7 88 65 a7 52 29 b0 4a  cc 68 4a 6e ee a6 05 e3  ..e.R).J.hJn....
      0220: b2 95 77 90 4c f8 9b 5e  1d 3d 4b 84 76 d8 b9 dd  ..w.L..^.=K.v...
      0230: 9a 15 b3 b5 15 4e e3 20  91 e4 34 a9 88 7c d3 b4  .....N. ..4..|..
      0240: 72 31 5a bb b8 a8 5b 71  ab 5b 19 b1 82 42 6a     r1Z...[q.[...Bj
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x02 dlen 384
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 4 time 3200 ssrc 1
      0000: 05 9c b9 35 84 42 23 31  10 52 23 22 20 52 30 cc  ...5.B#1.R#" R0.
      0010: 55 32 2f 41 b7 37 4c a9  91 e3 53 bb 2a 44 d4 ea  U2/A.7L...S.*D..
      0020: 94 3d 94 db 22 37 34 12  67 0d 15 22 cc 37 35 48  .=.."74.g..".75H
      0030: 74 ab 77 1c 34 b8 22 a1  4a 84 88 a4 62 d9 a9 d7  t.w.4.".J...b...
      0040: c4 4d 16 e6 ec 0c bb c2  09 97 a6 48 8e d9 d3 5a  .M.........H...Z
      0050: 8b 6a 46 01 56 d8 ac b5  d0 22 25 76 d0 b6 9e 55  .jF.V...."%v...U
      0060: 14 b4 16 09 87 b6 27 1d  29 08 3a 4c 91 3a 8f 09  ......'.).:L.:..
      0070: ab 56 31 2b 6a 48 ad 9c  b9 35 97 43 23 32 20 52  .V1+jH...5.C#2 R
      0080: 23 32 21 66 79 69 ab c7  24 70 09 79 25 40 d0 c9  #2!fyi..$p.y%@..
      0090: 0f bd 52 8a 27 36 d2 2d  b6 64 11 22 b9 14 2e ca  ..R.'6.-.d."....
      00a0: e2 aa d1 ba a9 58 7a 85  f4 ed a0 ba 8b 32 2c 64  .....Xz......2,d
      00b0: 09 a4 e6 06 d4 ce 12 cd  0e a4 31 a7 c0 cc 61 ba  ..........1...a.
      00c0: 33 6d 55 a6 e1 95 bb 04  4a d6 92 ea b5 e0 93 92  3mU.....J.......
      00d0: cc 98 93 6d 45 42 8d 5d  31 0b 58 3b 62 6f 4a 48  ...mEB.]1.X;boJH
      00e0: 5b 9a 50 9d 86 6d 27 e5  99 c9 49 93 6d 9c b9 35  [.P..m'...I.m..5
      00f0: d0 53 23 32 21 52 23 22  21 5e ea ee 28 5d 99 6a  .S#2!R#"!^..(].j
      0100: b9 83 4d 42 cc 83 52 c3  2b 09 c6 28 0a 79 d2 5c  ..MB..R.+..(.y.\
      0110: 4f ec 30 d6 cf 8e ca b6  5e 32 b7 65 b4 d6 28 54  O.0.....^2.e..(T
      0120: b5 64 65 27 20 9b a9 c8  df 68 84 c0 e5 65 42 69  .de' ....h...eBi
      0130: 44 a6 c9 62 33 06 5a 46  4d 0a da 5a 28 ca 8a 85  D..b3.ZFM..Z(...
      0140: 16 e2 c1 da dc 53 4a 3a  a5 58 4e ca 72 9d d2 a4  .....SJ:.XN.r...
      0150: 62 9a 53 4a 8f 25 13 ab  3a 29 63 4a 8d e5 ce 35  b.SJ.%..:)cJ...5
      0160: 7d 32 71 9c b9 35 dc 52  33 32 20 53 23 22 20 59  }2q..5.R32 S#" Y
      0170: 49 2d 08 e0 22 42 5f 65  69 3b 0a da 50 cb 44 49  I-.."B_ei;..P.DI
      0180: b9 67 12 7a 15 15 4e ca  17 96 51 04 9a ad dc a6  .g.z..N...Q.....
      0190: b1 57 56 a5 8e e9 99 43  ab a6 9f 83 69 a9 46 1e  .WV....C....i.F.
      01a0: 38 d2 3a 56 3a 48 ed 86  11 52 42 89 93 71 37 1c  8.:V:H...RB..q7.
      01b0: 5e 5d bb c3 4a d6 38 9a  a1 69 d2 51 ad 22 53 e4  ^]..J.8..i.Q."S.
      01c0: ee 5a 55 99 89 1b 27 82  23 27 70 05 08 cc 36 a1  .ZU...'.#'p...6.
      01d0: 3f 6d 2e 28 e5 d5 6c 44  6d 9c b9 35 38 52 13 33  ?m.(..lDm..58R.3
      01e0: 21 52 23 22 22 56 e1 b5  22 76 6d c9 e9 31 35 13  !R#""V.."vm..15.
      01f0: ac 74 11 3b a9 a8 8a 62  4c 89 f3 50 3f 21 14 06  .t.;...bL..P?!..
      0200: 4f 5b 42 bb 96 d1 3a a1  1b 57 9b 46 91 0d 07 18  O[B...:..W.F....
      0210: 77 11 c6 a8 d5 b6 d4 6b  0e 41 3f ae 3a 96 68 6e  w......k.A?.:.hn
      0220: aa c4 4a 31 23 c9 c8 5b  1c 4d ac 9d db 90 84 3b  ..J1#..[.M.....;
      0230: 85 3a 1a a9 64 01 0d 6a  00 33 84 21 58 6b 0d 44  .:..d..j.3.!Xk.D
      0240: 0c c5 45 92 d8 91 88 d6  2d 11 26 d5 ae ed e5     ..E.....-.&....
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x02 dlen 384
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 5 time 3840 ssrc 1
      0000: 05 9c b9 35 01 43 23 32  21 53 33 22 31 2e f2 db  ...5.C#2!S3"1...
      0010: 53 44 a8 98 1a 44 ca 81  cd 94 c7 95 27 13 ca c4  SD...D......'...
      0020: a6 15 e2 42 a0 86 4c 35  b4 e9 81 93 b3 8d 27 70  ...B..L5......'p
      0030: 69 4b 5d 59 74 0b 5b 4c  3c d1 08 45 dc e1 92 06  iK]Yt.[L<..E....
      0040: 68 1b 1a e8 db 4e bc 29  21 77 78 9a 9c ea 86 d4  h....N.)!wx.....
      0050: b4 c4 d6 6c ec a8 2d ee  35 26 78 98 41 ae 95 c4  ...l..-.5&x.A...
      0060: da 55 75 8d 88 4d a7 9d  d4 c8 4a 8d 6d 44 cd 15  .Uu..M....J.mD..
      0070: 6a df 13 4b 08 88 52 9c  b9 35 06 42 23 22 22 53  j..K..R..5.B#""S
      0080: 23 22 22 3b 92 36 ab 12  6c 40 74 4d e5 36 d4 55  #"";.6..l@tM.6.U
      0090: 83 a4 50 c9 d5 5b 70 25  63 6d 4f b0 da 65 b2 8c  ..P..[p%cmO..e..
      00a0: 4a b1 b2 9c 1b d8 53 95  8d 26 98 8c 27 5a 1f 71  J.....S..&..'Z.q
      00b0: 46 82 5d 9e d9 01 69 b6  00 ac d2 86 cc 2d 22 75  F.]...i......-"u
      00c0: 84 a5 53 21 64 53 cb 92  ab 37 23 aa 66 d3 2e 52  ..S!dS...7#.f..R
      00d0: 39 02 82 30 d0 22 91 46  41 05 72 8c 83 ad a0 a1  9..0.".FA.r.....
      00e0: 1d a8 d3 2d 66 38 cb ea  b6 d1 9b 29 c4 9c b9 35  ...-f8.....)...5
      00f0: c3 43 22 32 12 43 23 32  11 37 0d 1b 23 ae 9b 30  .C"2.C#2.7..#..0
      0100: f6 34 9a 07 80 dd 0a b0  38 c4 2c 87 18 56 6e 26  .4......8.,..Vn&
      0110: 24 de c0 96 2c 5d 35 32  e2 b7 2b c6 ad a9 58 51  $...,]52..+...XQ
      0120: b1 0b 4d 72 09 ba ad 46  d6 d3 64 2d 73 50 42 eb  ..Mr...F..d-sPB.
      0130: 13 81 29 63 ca b4 4e d1  1f 77 1b 59 ad 28 d1 29  ..)c..N..w.Y.(.)
      0140: b7 1a 75 70 b6 a2 5f 28  d3 ad e7 11 16 7c d0 9d  ..up.._(.....|..
      0150: 85 4e a8 76 6a d9 2b 30  6d 4d b4 30 ae d8 9b 72  .N.vj.+0mM.0...r
      0160: c5 12 91 9c b9 35 28 42  23 32 10 53 33 32 11 4e  .....5(B#2.S32.N
      0170: e8 8c 29 69 0b 91 d7 31  6e 48 e8 1b 05 ad 23 4a  ..)i...1nH....#J
      0180: 18 73 12 64 69 5d 4f b4  9a d6 72 cb 0a d5 9d c6  .s.di]O...r.....
      0190: 2d 2b 86 d5 86 ed 44 8a  a4 18 21 56 6c c2 d2 14  -+....D...!Vl...
      01a0: d5 1b c2 48 3a 49 69 a9  91 a9 4a 7b 57 48 57 0b  ...H:Ii...J{WHW.
      01b0: 0b 56 aa 42 52 a8 68 da  46 96 53 0e e3 45 53 6e  .V.BR.h.F.S..ESn
      01c0: 18 9a 95 96 a6 85 cb a2  84 2d b5 25 6a 1e 35 2d  .........-.%j.5-
      01d0: 76 a9 ac 59 a1 d5 a2 bb  46 9c b9 35 6b 42 23 22  v..Y....F..5kB#"
      01e0: 22 53 23 22 11 1e dc ca  44 ef 23 49 51 47 6b 24  "S#"....D.#IQGk$
      01f0: 52 fc 43 da a8 d1 0b a6  da 6d 15 56 c7 e6 a8 67  R.C......m.V...g
      0200: 72 c5 34 64 b1 44 1f 87  91 2a 47 6d 38 4a f1 6c  r.4d.D...*Gm8J.l
      0210: 4f 2d 31 84 d4 dc 8a 91  1a 99 36 3c 6d 14 2d 4e  O-1.......6<m.-N
      0220: 2a 1c 24 d2 2f 82 9d 4f  82 a4 89 83 16 da 6c e5  *.$./..O......l.
      0230: b8 89 de 36 91 2a 69 42  38 c4 a6 83 39 2c a1 f5  ...6.*iB8...9,..
      0240: 66 05 1f c2 2d 99 5b 45  ce 46 e8 6a d9 a4 08     f...-.[E.F.j...
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x02 dlen 384
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 6 time 4480 ssrc 1
      0000: 05 9c b9 35 1e 42 23 32  22 42 23 32 22 42 a6 24  ...5.B#2"B#2"B.$
      0010: a2 cb 89 a9 3c 29 35 26  ea 70 45 9c 65 20 77 20  ....<)5&.pE.e w 
      0020: 72 4c e5 30 84 b7 14 56  a6 eb 88 a5 3a da 1d 36  rL.0...V....:..6
      0030: d4 22 62 b4 99 0e 9a d2  17 8e 36 83 da b2 c8 3c  ."b.......6....<
      0040: 91 36 2a f2 a6 82 56 a9  24 18 55 b1 4e 55 69 56  .6*...V.$.U.NUiV
      0050: d1 91 29 d8 e4 6a 65 93  6d 47 b8 9c 53 f6 9b 82  ..)..je.mG..S...
      0060: 4f 36 f0 8f 73 59 80 0c  c6 61 0a b6 d9 1b 36 3a  O6..sY...a....6:
      0070: ce 65 28 21 2a 66 04 9c  b9 35 b6 42 23 22 21 52  .e(!*f...5.B#"!R
      0080: 23 32 21 42 90 c9 2a 1e  8b 29 57 a3 f5 50 6a a4  #2!B..*..)W..Pj.
      0090: 44 9d af 89 c5 a3 5a 54  6c ea 57 1e 98 e6 31 6c  D.....ZTl.W...1l
      00a0: d2 c9 75 36 ad 74 56 16  68 c9 94 ee 30 b6 a3 ab  ..u6.tV.h...0...
      00b0: 2a 23 64 21 35 0e 2b 4d  13 30 b1 a8 f1 93 6a d8  *#d!5.+M.0....j.
      00c0: 15 69 5e a0 99 57 9a 9b  72 f4 92 dc 46 45 db 52  .i^..W..r...FE.R
      00d0: ba 46 d0 f6 f2 9c b5 a2  36 87 66 74 e4 2e ad c8  .F......6.ft....
      00e0: e8 c3 d4 ab 47 6d 29 d1  d9 c9 a8 43 6d 9c b9 35  ....Gm)....Cm..5
      00f0: 7b 42 23 22 12 53 33 22  12 23 29 b6 89 14 6d c0  {B#".S3".#)...m.
      0100: b8 76 b1 4b 15 a8 87 cb  c2 02 26 f0 68 96 8d 2c  .v.K......&.h..,
      0110: 54 a5 8b 55 f2 1a 42 b2  a4 e0 9d 86 9b 15 ed b6  T..U..B.........
      0120: c4 c9 48 f0 a5 71 ba 22  65 bb 14 f3 32 b4 17 0e  ..H..q."e...2...
      0130: 46 a8 5a 72 32 33 6a 00  64 d3 64 0e b2 4c 73 08  F.Zr23j.d.d..Ls.
      0140: d2 54 56 5a 48 14 c4 92  00 12 8b 6c 76 a2 d5 0b  .TVZH......lv...
      0150: 52 ef 84 b1 3b 61 6b 24  a8 ae 89 28 2c 4d a2 95  R...;ak$...(,M..
      0160: 93 28 b5 9c b9 35 72 42  22 32 21 42 22 32 22 2e  .(...5rB"2!B"2".
      0170: 2a d3 48 ab 66 48 f4 b2  a2 0d a9 55 89 91 98 40  *.H.fH.....U...@
      0180: e6 0c 40 7d a5 a6 1f 6e  ca 26 28 ce 45 2a cb 1a  ..@}...n.&(.E*..
      0190: 1d 69 72 01 c4 a9 08 b9  5b 70 16 72 3a 02 d4 b1  .ir.....[p.r:...
      01a0: 68 5a 74 b5 22 aa ca 06  e1 85 0a f9 66 d4 cc 5b  hZt.".......f..[
      01b0: 66 52 c2 66 d3 2c 7b 6a  56 17 32 81 a3 19 43 ef  fR.f.,{jV.2...C.
      01c0: 2a 04 59 57 03 0f b5 ee  c1 6e d7 61 8b 39 88 4a  *.YW.....n.a.9.J
      01d0: c1 c6 4b f1 db 71 de 29  b8 9c b9 35 02 42 23 32  ..K..q.)...5.B#2
      01e0: 21 43 33 32 21 47 82 f1  05 ed 5c 41 1a 23 a5 0e  !C32!G....\A.#..
      01f0: e8 69 49 91 3d 68 38 57  62 86 a5 24 08 c4 19 05  .iI.=h8Wb..$....
      0200: 68 06 d4 7d 88 b7 29 59  26 d4 6c e1 a4 1b 29 bb  h..}..)Y&.l...).
      0210: 07 77 2b 41 6a 8a 24 5b  31 89 4e c6 95 22 d9 8c  .w+Aj.$[1.N.."..
      0220: 4b d5 92 6c 3e ee 5b 12  b4 3c 49 d6 c5 12 55 a1  K..l>.[..<I...U.
      0230: 49 4a ab b2 53 37 2c da  26 59 b8 99 57 73 90 ae  IJ..S7,.&Y..Ws..
      0240: cc e5 1c 1c a4 ab 46 89  2a d9 e9 b4 aa b5 89     ......F.*......
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x02 dlen 384
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 7 time 5120 ssrc 1
      0000: 05 9c b9 35 8f 42 23 33  21 52 23 33 22 37 94 9a  ...5.B#3!R#3"7..
      0010: 52 63 69 a9 74 7a 94 8a  64 4e 4a c4 42 94 f2 e9  Rci.tz..dNJ.B...
      0020: 4a 7c a9 a8 a6 14 db 43  e5 6d 35 69 b6 9b 19 7c  J|.....C.m5i...|
      0030: a9 89 9e c6 80 a9 44 a4  40 2e 54 c1 4d db 89 d7  ......D.@.T.M...
      0040: ad c4 3f 41 12 55 a8 a9  b2 75 f6 aa b6 2b 55 0e  ..?A.U...u...+U.
      0050: c6 28 e4 d1 1c 6a 55 15  26 a5 86 12 52 ee e7 05  .(...jU.&...R...
      0060: 1b 27 4a 95 a1 72 89 68  97 45 9d 32 90 6a e5 c8  .'J..r.h.E.2.j..
      0070: 0a dd 0a a2 d9 05 c2 9c  b9 35 5d 43 23 22 21 52  .........5]C#"!R
      0080: 23 22 21 37 46 61 8a 74  c8 60 f9 53 98 45 32 5e  #"!7Fa.t.`.S.E2^
      0090: 06 b8 33 4a 16 36 d8 ae  4d aa 53 d2 3a d7 2e cc  ..3J.6..M.S.:...
      00a0: da e1 c5 a8 95 b3 70 a5  54 2c b8 ab 2c 84 a3 a2  ......p.T,..,...
      00b0: 81 44 5e 9c b4 dc 23 09  52 c3 09 ab 10 99 2b 18  .D^...#.R.....+.
      00c0: 97 55 70 d3 0b 59 b9 3e  62 8c 07 50 2e 49 cb 53  .Up..Y.>b..P.I.S
      00d0: 43 42 d3 6c 92 ca 86 56  36 99 76 96 94 e6 35 35  CB.l...V6.v...55
      00e0: 9d 34 16 af a9 69 aa d4  e5 b5 71 c4 89 9c b9 35  .4...i....q....5
      00f0: 99 43 33 22 21 53 33 33  21 3e f2 d0 a9 e1 9a 49  .C3"!S33!>.....I
      0100: 76 98 8e 48 d5 23 81 a4  38 4a 41 76 9c b6 90 98  v..H.#..8JAv....
      0110: 54 69 96 57 2c ed 58 d9  d5 44 9b a9 53 43 d6 c9  Ti.W,.X..D..SC..
      0120: c0 6b aa fa 26 76 36 04  d5 cf 41 03 b9 b0 33 6e  .k..&v6...A...3n
      0130: 9a 2a 66 45 6b 94 76 88  6c 70 ab 0b b2 3a 6a 16  .*fEk.v.lp...:j.
      0140: 46 da 2e 89 15 12 cb 17  11 71 22 5a 89 e8 34 93  F........q"Z..4.
      0150: 78 76 d3 ae ad b5 eb 3b  28 b2 66 45 aa 65 a5 15  xv.....;(.fE.e..
      0160: 3e 43 69 9c b9 35 fd 43  23 33 21 53 32 33 21 3e  >Ci..5.C#3!S23!>
      0170: e6 e9 28 25 e3 48 b7 27  4e 36 a5 14 89 cb c9 69  ..(%.H.'N6.....i
      0180: e7 6a 5a fe 4e 52 98 da  74 95 6e 94 9a bd 9b 16  .jZ.NR..t.n.....
      0190: 89 82 a2 94 6c d9 24 ca  4c 94 a0 27 85 40 5e a8  ....l.$.L..'.@^.
      01a0: a8 d3 bd 4a 37 05 89 2b  a1 eb 6a 39 37 50 5c ea  ...J7..+..j97P\.
      01b0: 5c 53 c1 c5 6a b6 47 14  4d 92 9b 12 3b 58 82 26  \S..j.G.M...;X.&
      01c0: ef 5c 84 a1 d7 15 77 56  d3 8e e5 b6 0a d2 c0 ba  .\....wV........
      01d0: 46 10 ac 5a 21 b5 64 ba  71 9c b9 35 7e 43 22 32  F..Z!.d.q..5~C"2
      01e0: 21 52 22 33 20 3e bc 6d  28 e2 02 61 79 41 80 3b  !R"3 >.m(..ayA.;
      01f0: 4a 61 0d ba 2c 6a 52 83  1a dd d4 5a 59 02 b6 d7  Ja..,jR....ZY...
      0200: 2b 4e 9a cd 71 a4 91 84  46 64 ee 69 28 db 88 16  +N..q...Fd.i(...
      0210: a7 52 09 23 f1 6d 65 36  ad 56 66 aa ee ac a5 db  .R.#.me6.Vf.....
      0220: aa d7 07 81 5c ee a1 56  aa e4 42 a0 0c d8 4d 8e  ....\..V..B...M.
      0230: cb 92 32 42 d1 f3 2e 92  95 19 96 9d 78 66 94 1a  ..2B........xf..
      0240: 89 a5 bc 28 a3 35 82 2d  aa 5d e9 b1 3d bb 68     ...(.5.-.]..=.h
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x02 dlen 384
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 8 time 5760 ssrc 1
      0000: 05 9c b9 35 9a 42 23 23  20 52 23 32 21 33 67 96  ...5.B## R#2!3g.
      0010: a9 ad ac c9 76 a9 4d 44  77 12 4a a2 60 6a 55 3a  ....v.MDw.J.`jU:
      0020: 9c c6 49 cb 59 0b c5 45  ef 0d 52 b6 31 44 9f 84  ..I.Y..E..R.1D..
      0030: 7c 84 94 0e b0 6d 2c 57  21 a5 50 20 d9 da 30 f6  |....m,W!.P ..0.
      0040: 19 6d 56 af 25 ab 1e 23  73 b7 65 2d 73 68 93 50  .mV.%..#s.e-sh.P
      0050: cc a3 82 aa 52 da 4c 05  d5 10 12 37 51 72 8d da  ....R.L....7Qr..
      0060: 81 21 38 21 48 46 d4 e4  e9 b5 59 fa 24 ae 2e 4d  .!8!HF....Y.$..M
      0070: 2a 56 1e 29 4c 4b 68 9c  b9 35 09 42 13 23 11 52  *V.)LKh..5.B.#.R
      0080: 23 32 21 1b 01 44 11 ca  3a 69 54 8c dc 95 6d 4b  #2!..D..:iT...mK
      0090: 4d a9 92 54 ec 8e c8 ce  4c 26 ae 72 93 95 71 9d  M..T....L&.r..q.
      00a0: b5 74 53 28 87 92 ed a8  6a 5d b0 89 97 4c 48 68  .tS(....j]...LHh
      00b0: e9 42 56 51 51 e5 79 85  4e bb 02 15 b2 da 6b 11  .BVQQ.y.N.....k.
      00c0: d2 da c4 ae 10 88 b1 8a  b3 f9 32 d8 46 72 ba 24  ..........2.Fr.$
      00d0: 56 67 90 b5 62 a8 e2 cb  b6 9d 01 25 a9 4d e5 31  Vg..b......%.M.1
      00e0: cb 47 48 6a 8a d4 a8 52  39 4a 89 57 69 9c b9 35  .GHj...R9J.Wi..5
      00f0: 97 42 13 31 21 53 23 22  21 1e 6d 65 51 9c bc 71  .B.1!S#"!.meQ..q
      0100: 13 a9 48 8d 19 3c 10 88  68 a5 8b 10 e4 bd f3 be  ..H..<..h.......
      0110: 31 98 82 c5 ad 52 85 73  da 46 9f a0 ae a9 21 1d  1....R.s.F....!.
      0120: 34 68 f0 b1 46 d4 44 83  54 34 8a 35 57 31 53 2c  4h..F.D.T4.5W1S,
      0130: d5 14 ba 2a 4b 58 71 0a  cd 99 db 49 c9 87 44 94  ...*KXq....I..D.
      0140: 71 22 3c 9b 1a 24 74 66  a3 e5 5a 24 eb 9b 36 99  q"<..$tf..Z$..6.
      0150: 83 2c a9 d5 e4 b5 bb d8  71 6a cf 28 a6 5f 42 ca  .,......qj.(._B.
      0160: 77 c6 45 9c b9 35 c0 42  33 32 20 52 33 22 20 36  w.E..5.B32 R3" 6
      0170: 92 ed 29 e1 db 68 d1 79  4d 4a b0 d5 4b db d9 72  ..)..h.yMJ..K..r
      0180: 97 7a a0 ce d6 53 59 4b  33 05 70 f0 d8 c1 a1 b6  .z...SYK3.p.....
      0190: 0d 26 88 d3 ea cd a4 aa  3d 38 26 77 9a 04 e1 dd  .&......=8&w....
      01a0: 10 ed 33 88 5b 06 cd 4a  9c 93 2a d0 97 51 64 50  ..3.[..J..*..QdP
      01b0: d3 48 d3 b4 72 53 77 1c  57 dd e3 53 cc 2a e2 a8  .H..rSw.W..S.*..
      01c0: ce 90 8d 9d c8 25 77 34  a6 10 e6 85 8b b9 b0 af  .....%w4........
      01d0: c8 29 26 59 59 d9 24 bb  b5 9c b9 35 2c 42 22 32  .)&YY.$....5,B"2
      01e0: 20 52 22 42 20 1f 32 9c  92 3f 37 70 d3 57 12 90   R"B .2..?7p.W..
      01f0: d8 bb 85 c5 c6 d4 2c 7e  12 c6 4d b6 ad 25 2c d3  ......,~..M..%,.
      0200: e7 61 51 41 29 7c 0d 28  8d 87 81 db c0 4d bc 19  .aQA)|.(.....M..
      0210: 3c cb 0f 25 d7 da 41 d5  b4 c9 43 4b 9b 18 5c 57  <..%..A...CK..\W
      0220: 42 bb 56 da c6 99 bc 4a  9b 46 d4 6e 8e 1c 55 03  B.V....J.F.n..U.
      0230: 35 20 73 ae 91 2b 8d 25  04 d4 64 99 c2 ae a9 11  5 s..+.%..d.....
      0240: 23 c5 ad 91 6d 5e 70 5d  a4 66 94 4a 4a b5 09     #...m^p].f.JJ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x02 dlen 384
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 9 time 6400 ssrc 1
      0000: 05 9c b9 35 cb 42 23 23  22 53 33 32 21 32 2c ec  ...5.B##"S32!2,.
      0010: 54 4a 9b c8 d4 57 d2 1e  48 e8 48 b4 38 c9 11 b7  TJ...W..H.H.8...
      0020: 22 8d e8 c6 8b 5a 16 d3  2b a9 b2 4a ed 36 11 47  "....Z..+..J.6.G
      0030: 59 a2 37 4a b4 aa 40 ce  52 bc 11 23 4d 0d 72 7d  Y.7J..@.R..#M.r}
      0040: 12 96 5a 8a 72 56 08 cc  0a 7b 44 da b1 66 5a 44  ..Z.rV...{D..fZD
      0050: 9e 9a 61 22 c5 4c 45 75  b6 ca 22 a6 51 6c ad 28  ..a".LEu..".Ql.(
      0060: 3a cd a5 1d 7a 4d b2 a7  89 c5 5a 23 4e 18 b9 6c  :...zM....Z#N..l
      0070: c6 d1 dc 32 91 da 82 9c  b9 35 65 42 32 32 31 52  ...2.....5eB221R
      0080: 23 32 31 36 70 d1 89 a5  b4 60 06 8a 93 41 91 b2  #216p....`...A..
      0090: c0 b3 e4 aa 64 35 3a d5  17 37 19 33 6d 42 fa b1  ....d5:..7.3mB..
      00a0: a8 9a 85 6e 15 65 c9 b4  eb 1b 6c 4c b1 40 1e c6  ...n.e....lL.@..
      00b0: d0 06 ca 62 91 28 d6 6c  3f e7 1b 6a ac b8 9a 19  ...b.(.l?..j....
      00c0: 81 44 53 91 50 c0 d3 48  e1 f6 4e 38 4d 91 c2 d2  .DS.P..H..N8M...
      00d0: bb 70 41 f0 e1 b6 92 19  6d a5 23 0d b5 b4 0c 49  .pA.....m.#....I
      00e0: 1d 42 6a b7 5a da a4 59  db 11 25 d4 cc 9c b9 35  .Bj.Z..Y..%....5
      00f0: bf 42 23 32 21 52 23 32  20 07 2e 4d c8 60 93 50  .B#2!R#2 ..M.`.P
      0100: 06 67 6d 3c ec 9b 4c b3  ac 82 5a 75 18 b6 ac 94  .gm<..L...Zu....
      0110: 18 99 a6 c2 76 8f 0a a8  9d c4 83 3c 54 d3 a3 0d  ....v......<T...
      0120: 34 b9 cb 92 a1 a9 60 84  6d 9d a9 2b 1b 4a 4b 11  4.....`.m..+.JK.
      0130: 4d 8c 1e 1b 42 52 76 46  54 6e da 8d 99 ba 62 68  M...BRvFTn....bh
      0140: 36 90 25 75 8b 90 43 b2  a2 61 12 94 8a 15 a7 1f  6.%u..C..a......
      0150: 6a aa 95 73 56 15 7d ac  34 30 26 69 87 55 dd d5  j..sV.}.40&i.U..
      0160: 21 a3 75 9c b9 35 bc 42  23 22 22 52 23 22 21 16  !.u..5.B#""R#"!.
      0170: aa e3 53 c9 1e 48 32 96  d2 9e 46 db 49 ba c6 95  ..S..H2...F.I...
      0180: 20 38 8a ed 0d 54 ad 4d  ba 93 b0 8d c5 56 a5 b8   8...T.M.....V..
      0190: 8f d9 5d b1 fc 2b 24 5c  31 71 11 3c 36 a3 d1 d5  ..]..+$\1q.<6...
      01a0: 44 91 13 c8 6a ec db 86  71 1a 72 93 36 93 2b 26  D...j...q.r.6.+&
      01b0: c3 48 e5 13 61 06 22 6c  3d 00 b4 29 05 98 82 36  .H..a."l=..)...6
      01c0: 4a 25 35 4d 46 ad 4b 66  aa da 6c c5 39 bb 41 58  J%5MF.Kf..l.9.AX
      01d0: 29 48 a6 ed 99 aa 93 13  11 9c b9 35 9e 42 33 32  )H.........5.B32
      01e0: 21 53 33 32 21 1f 6c ed  c8 9d 9a 71 12 67 29 39  !S32!.l....q.g)9
      01f0: 0a ca 52 d3 ba 4a a8 76  d2 d5 da 52 99 33 c4 e2  ..R..J.v...R.3..
      0200: a9 32 e0 90 e6 38 1d 66  77 04 af 2d b0 7a 3d 96  .2...8.fw..-.z=.
      0210: a1 58 a6 26 59 ad 35 5b  9d 4d 8e 31 2d ae 96 5b  .X.&Y.5[.M.1-..[
      0220: 6a 75 57 8d 54 c7 23 49  ca db 6a 5b 59 1a 64 a9  juW.T.#I..j[Y.d.
      0230: 63 91 3d 38 e3 f1 0c 98  95 15 24 33 b9 47 15 b3  c.=8......$3.G..
      0240: 05 c5 69 1a a7 3c 34 4d  c7 e5 a6 15 1c c4 81     ..i..<4M.......
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 10 time 7040 ssrc 1
      0000: 05 9c b9 35 f0 42 23 32  20 42 23 32 20 2e d6 f2  ...5.B#2 B#2 ...
      0010: 21 c9 5c a8 94 75 aa 0e  90 aa 93 cd 03 89 78 80  !.\..u........x.
      0020: db 2d e0 e1 9a b3 16 a4  b2 88 ac 66 99 27 13 a3  .-.........f.'..
      0030: 44 50 aa 25 24 db ba c6  09 86 51 87 64 19 f0 6e  DP.%$.....Q.d..n
      0040: cb 74 9b 44 e9 2f cd da  6b 95 48 58 2a f0 d6 09  .t.D./..k.HX*...
      0050: 99 33 80 00 44 d8 7e 12  43 4a b0 40 d4 25 70 8a  .3..D.~.CJ.@.%p.
      0060: 15 e5 a2 a5 6a a7 03 32  95 b1 98 74 36 ad 29 6d  ....j..2...t6.)m
      0070: 85 d7 a1 b8 5a db 6a 9c  b9 35 e2 42 23 33 31 42  ....Z.j..5.B#31B
      0080: 23 32 31 4e 29 52 42 48  64 90 b9 4a 5b 0b 2e 16  #21N)RBHd..J[...
      0090: d2 b6 d4 e1 39 b5 38 ee  9a 92 d1 9b a4 34 31 71  ....9.8......41q
      00a0: b6 4d b4 89 a3 71 95 b2  2a 25 6d 18 a9 85 8b 38  .M...q..*%m....8
      00b0: a0 67 e0 5b 70 7b 24 cc  6f 38 5a 8a 52 26 e2 15  .g.[p{$.o8Z.R&..
      00c0: 54 9b 26 b1 24 8c 8d a7  18 91 69 d6 54 a5 46 87  T.&.$.....i.T.F.
      00d0: d3 71 a3 f1 c9 36 0e 21  49 37 3c 4d b4 23 13 6d  .q...6.!I7<M.#.m
      00e0: e8 63 6d 25 a8 da 46 fa  5a 84 1f b6 a9 9c b9 35  .cm%..F.Z......5
      00f0: 16 42 23 32 21 52 23 22  21 3e 4c c9 c9 8c 58 70  .B#2!R#"!>L...Xp
      0100: fc 09 65 50 e8 d1 53 ec  2b 6a eb 46 e2 ee 92 0c  ..eP..S.+j.F....
      0110: 5e c2 b0 d4 2a ec 88 a2  51 92 07 3a 94 d3 47 90  ^...*...Q..:..G.
      0120: c4 8d 24 25 1c 77 81 47  68 ac 95 1f 05 05 72 eb  ..$%.w.Gh.....r.
      0130: 6d 8c a4 e2 62 d9 28 6c  5c 83 22 0c 84 c3 72 22  m...b.(l\."...r"
      0140: 78 dc 5d 6a d3 53 13 c2  d3 29 d4 94 a1 26 a7 3b  x.]j.S...)...&.;
      0150: 92 96 a5 fc 8d a9 ce 43  3c 33 b4 6e 85 e4 da 45  .......C<3.n...E
      0160: 64 ab b5 9c b9 35 e9 43  23 33 20 42 23 32 20 3a  d....5.C#3 B#2 :
      0170: ca cd 81 61 14 41 38 67  6c 1b 28 db 19 c3 a3 a1  ...a.A8gl.(.....
      0180: ff 54 f9 1c c8 dc 59 81  96 d3 f2 a8 e0 5d d1 3a  .T....Y......].:
      0190: 1d 82 6a 81 2c ea b0 ba  d9 d6 83 3b 34 a5 e2 92  ..j.,......;4...
      01a0: 34 ba ca 91 8e ee 8a aa  e7 12 eb 77 94 49 4a 0c  4..........w.IJ.
      01b0: 52 4f b2 ba 49 19 58 90  56 65 5b 01 bb 26 c4 2e  RO..I.X.Ve[..&..
      01c0: 0e d8 07 85 b6 2b bb 46  c5 b9 89 b1 4c 24 28 a5  .....+.F....L$(.
      01d0: 67 6a c7 5e 62 24 8c c4  89 9c b9 35 15 42 23 22  gj.^b$.....5.B#"
      01e0: 10 52 33 22 11 1b a5 01  c8 69 60 51 38 3a 08 49  .R3".....i`Q8:.I
      01f0: 4c c1 13 a3 ca 6b 09 5a  a2 bd 1a d9 58 ba c8 53  L....k.Z....X..S
      0200: a7 ec e8 91 e5 be 13 58  96 94 94 ed 94 b9 3b 96  .......X......;.
      0210: 1e 34 69 08 c9 e4 b1 78  b4 34 72 15 0c ec 96 1b  .4i....x.4r.....
      0220: 39 b8 c5 6e 4e ce db ce  a9 cf 62 89 67 d0 27 49  9..nN.....b.g.'I
      0230: e2 d4 6a 48 73 3d 2c d4  93 5d b7 3b 60 29 06 64  ..jHs=,..].;`).d
      0240: e2 51 7b 53 26 af 75 69  27 df 9d e5 3b 61 71     .Q{S&.ui'...;aq
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 11 time 7680 ssrc 1
      0000: 05 9c b9 35 2c 42 33 33  21 42 33 33 21 33 70 0d  ...5,B33!B33!3p.
      0010: 23 dd 4b 49 1a 35 6d 16  aa 1b 56 a3 8b 6a 35 62  #.KI.5m...V..j5b
      0020: da c5 0e 9c 13 9a 46 c4  31 2a d0 4d 64 b4 1b 76  ......F.1*.Md..v
      0030: 73 51 36 ec d4 8b ab b4  80 48 8d aa d9 a8 b0 ab  sQ6......H......
      0040: 24 2c 7a 6c e9 8d 45 da  41 bd 87 2c 32 b2 cb 0f  $,zl..E.A..,2...
      0050: db e3 41 18 8a d8 76 1a  0c 43 e2 c3 13 f8 f0 da  ..A...v..C......
      0060: 2d 5e 36 bf d3 b5 17 2c  75 45 6c 24 14 1f 94 85  -^6....,uEl$....
      0070: 04 d8 ee 14 49 95 69 9c  b9 35 60 43 23 22 21 42  ....I.i..5`C#"!B
      0080: 33 22 21 4e f8 86 a7 e2  d0 c9 b7 c9 a9 2e 73 28  3"!N..........s(
      0090: 5e bf c3 6a b8 98 d2 ee  1a 52 54 da c4 d3 70 6e  ^..j.....RT...pn
      00a0: e0 27 0d ba 1f 5b 5c 12  a9 6b 04 ab 3a a7 0f 14  .'...[\..k..:...
      00b0: 49 a7 d1 da 34 e9 3a 69  76 a8 bd 4b 4e 17 72 5c  I...4.:iv..KN.r\
      00c0: 53 6d 33 2e 9c 54 d3 9d  69 1c 73 52 7d c9 64 09  Sm3..T..i.sR}.d.
      00d0: aa b6 c3 74 cb 94 37 1d  67 37 98 68 d5 b4 ce 45  ...t..7.g7.h...E
      00e0: 2b d3 86 9d 7a 61 a5 69  d8 44 bd 32 2d 9c b9 35  +...za.i.D.2-..5
      00f0: a4 42 32 33 22 42 33 32  22 33 26 37 02 5a 8c a1  .B23"B32"3&7.Z..
      0100: 5c 8d b2 06 d3 6c 9f c2  69 22 f6 da 68 d4 d9 6d  \....l..i"..h..m
      0110: 53 a6 9a 54 ec fa 60 65  28 a0 95 47 13 50 2d b5  S..T..`e(..G.P-.
      0120: 14 9a 4a aa 80 6a bc a9  ce 62 d4 eb ad 35 72 15  ..J..j...b...5r.
      0130: a4 2b 55 68 89 d4 95 a5  1e 9c 61 53 ba 8d a9 54  .+Uh......aS...T
      0140: db 4a 4c 9c 69 06 b5 1b  43 a9 19 6a 5e 46 72 b7  .JL.i...C..j^Fr.
      0150: 79 1b 45 26 b6 d1 2c 46  a8 95 ae 2a 2b 55 c8 50  y.E&..,F...*+U.P
      0160: 9b 6e 05 9c b9 35 b2 42  23 32 20 42 22 32 30 2f  .n...5.B#2 B"20/
      0170: 2c e4 48 c0 99 19 d3 15  52 3c e8 d2 da c4 26 94  ,.H.....R<....&.
      0180: 60 a1 a6 a6 94 ce 19 b1  12 b3 6e 8e 20 ad 11 89  `.........n. ...
      0190: 27 05 2e 22 cc cb ac 9a  32 75 1a 68 5d 47 4a 5c  '.."....2u.h]GJ\
      01a0: 61 54 a8 da 5a ee dd 0c  c4 a7 ca 38 64 d0 45 69  aT..Z......8d.Ei
      01b0: 34 94 9a c2 84 24 b4 b4  4e 9a b6 83 a2 ad 34 32  4....$..N.....42
      01c0: 6e 34 9d 1b 85 bd e6 89  8b e2 1a a9 3d 3c 4d 37  n4..........=<M7
      01d0: 69 93 49 58 19 c9 97 18  63 9c b9 35 5a 43 33 32  i.IX....c..5ZC32
      01e0: 20 42 23 33 20 2a ed 28  a4 dd a2 69 d7 5b 20 1a   B#3 *.(...i.[ .
      01f0: a7 4b 1e c3 ca 6a 78 5a  9a a5 dd d2 52 c3 b6 91  .K...jxZ....R...
      0200: f2 f3 02 0d e5 c4 95 79  75 43 2d 4d c5 29 ca b0  .......yuC-M.)..
      0210: 91 9a 4c a9 ed de 38 fd  0b 89 76 cf 2e 28 61 9b  ..L...8...v..(a.
      0220: 89 b7 63 51 22 24 54 53  c1 a5 08 d7 15 4a 45 e4  ..cQ"$TS.....JE.
      0230: 2d 41 9f 1b 16 ac 4f 44  6d d1 55 4f 9b 3a 98 a1  -A....ODm.UO.:..
      0240: a6 a5 3b c2 c2 13 9a 50  85 dd dd 44 7b db 4d     ..;....P...D{.M
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 12 time 8320 ssrc 1
      0000: 05 9c b9 35 c7 42 23 32  11 52 23 32 11 2f 40 ec  ...5.B#2.R#2./@.
      0010: 27 21 d3 29 17 94 51 41  2a 94 60 d1 32 43 b8 c4  '!.)..QA*.`.2C..
      0020: d0 8e 5a da 58 8d 56 a3  b1 0e 4a 99 d9 96 99 86  ..Z.X.V...J.....
      0030: 84 45 04 ed 04 8a 9c ab  1e 87 a8 ad 41 a9 a9 a1  .E..........A...
      0040: c5 6e 7a b9 48 ae 9b 62  42 7a 49 50 57 0f 12 12  .nz.H..bBzIPW...
      0050: d1 54 8a 58 0b 2a 65 5a  58 91 25 c6 a3 6c 4e e0  .T.X.*eZX.%..lN.
      0060: b1 cd b8 43 68 46 97 47  65 b5 1c cb a6 a9 6a 8a  ...ChF.Ge.....j.
      0070: 25 6d 1a d1 27 52 ad 9c  b9 35 06 42 32 32 11 42  %m..'R...5.B22.B
      0080: 23 32 11 2f 30 ac a4 55  93 29 96 61 6a 2a c0 9a  #2./0..U.).aj*..
      0090: 65 aa 9c b3 98 45 1c b7  5d d9 08 fb c6 43 f5 00  e....E..]....C..
      00a0: 5a 5e 28 97 11 43 38 d0  12 2a 38 8e 42 b8 8b 9b  Z^(..C8..*8.B...
      00b0: 73 2f 61 51 b5 7e c3 70  67 26 8c ab 48 13 02 59  s/aQ.~.pg&..H..Y
      00c0: 70 2d 26 b4 4c 8a e4 42  41 19 86 8a 1c 9c dc 42  p-&.L..BA......B
      00d0: a3 46 65 a4 ce ce 6c d9  23 c1 7b 87 65 b4 f1 bc  .Fe...l.#.{.e...
      00e0: a9 ba c4 8d 59 6d a3 59  89 10 03 ac 4c 9c b9 35  ....Ym.Y....L..5
      00f0: 69 42 23 32 31 42 23 32  21 36 d2 94 a2 cb 51 99  iB#21B#2!6....Q.
      0100: dc 1b 14 2e dd 5a 9d a4  b6 52 f4 76 9a be 8d 98  .....Z...R.v....
      0110: 90 a5 42 c2 75 31 b8 35  b2 31 17 34 6e 30 6e 8d  ..B.u1.5.1.4n0n.
      0120: c4 ee 54 71 87 8b 8a 2e  dd 23 29 4c 1d 48 77 48  ..Tq.....#)L.HwH
      0130: da 6a e7 53 68 d4 56 99  0e c8 d5 07 94 38 58 70  .j.Sh.V......8Xp
      0140: 45 12 36 11 b8 82 ac 28  c6 73 45 e4 b6 71 36 c1  E.6....(.sE..q6.
      0150: 64 6a b7 a6 e5 c5 3b 2a  6c 8d 75 4d 8b 61 d3 6c  dj....;*l.uM.a.l
      0160: aa 3a 6d 9c b9 35 d8 43  23 32 21 42 23 32 21 26  .:m..5.C#2!B#2!&
      0170: d2 ee 04 d4 94 82 37 94  6d 2b 2c 5d 5e a3 bb e2  ......7.m+,]^...
      0180: d6 64 e0 b6 0c da 4e d1  a6 d2 6a ce 5a 14 c9 92  .d....N...j.Z...
      0190: 85 69 71 20 6e a8 a8 ad  52 b2 05 a6 6c 2d ce 65  .iq n...R...l-.e
      01a0: 95 a8 34 65 83 34 90 aa  f3 d3 49 ba 08 4d 27 25  ..4e.4....I..M'%
      01b0: 14 4e a9 4b 28 f4 46 e2  46 02 ce 0d ba 55 16 6c  .N.K(.F.F....U.l
      01c0: ee ac 95 1e 29 43 68 67  07 61 2d b1 2c 63 ba 93  ....)Chg.a-.,c..
      01d0: 99 91 a7 58 72 38 5b 3d  8e 9c b9 35 86 42 33 22  ...Xr8[=...5.B3"
      01e0: 21 42 33 22 21 42 cf 01  42 e9 a9 2a d6 77 01 3b  !B3"!B..B..*.w.;
      01f0: 10 89 59 c3 9b 73 71 72  e4 cc 1d e2 54 93 3a d2  ..Y..sqr....T.:.
      0200: f3 0b 84 4c b1 70 95 87  6c 22 a5 27 08 fb ba a4  ...L.p..l".'....
      0210: 95 a7 4d 94 69 54 c5 9d  39 71 6f 06 d1 2b e1 15  ..M.iT..9qo..+..
      0220: 31 77 65 0d 23 30 4b 49  ca b2 a0 95 42 f2 77 18  1we.#0KI....B.w.
      0230: bb 4c d4 18 c5 b4 8c dc  c6 95 c4 bb 68 60 d4 aa  .L..........h`..
      0240: e8 45 4b ba e0 8f 96 74  a8 5d 9c 44 7e b3 14     .EK....t.].D~..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 13 time 8960 ssrc 1
      0000: 05 9c b9 35 e6 42 32 22  21 52 23 22 21 4a ea 60  ...5.B2"!R#"!J.`
      0010: 2b 18 d8 0a 3c 5f b4 5a  25 24 22 b4 4c 4b a3 a8  +...<_.Z%$".LK..
      0020: c2 7f 55 05 18 ad a1 92  76 be da 9e 03 36 93 76  ..U.....v....6.v
      0030: 80 d3 c1 4c a1 5c b3 02  2c 84 81 92 e9 62 25 f5  ...L.\..,....b%.
      0040: 4c 6d 62 cd 75 8b 99 e5  a1 79 78 95 4f 10 eb 4c  Lmb.u....yx.O..L
      0050: c4 a4 8a 25 47 22 8d 1f  13 16 85 34 c6 b0 c1 92  ...%G".....4....
      0060: df 05 d8 b5 b3 58 d6 e4  ea 14 fe 2a 46 27 b5 71  .....X.....*F'.q
      0070: 81 dd c5 a5 2b 32 71 9c  b9 35 18 42 33 32 21 42  ....+2q..5.B32!B
      0080: 33 31 32 22 86 9a 43 b3  2d 53 19 74 e4 66 9a 6c  312"..C.-S.t.f.l
      0090: 1f bc c8 c5 ea 9c 52 a4  99 32 9f 44 9a c0 fa c1  ......R..2.D....
      00a0: 38 2c a2 9a 9b 06 6d 81  e9 b6 a4 da c3 8d 46 cd  8,....m.......F.
      00b0: b1 b0 da 22 4b b5 6d 4d  6e 6c db 50 93 6e 40 9a  ..."K.mMnl.P.n@.
      00c0: b4 6a 0c 9a 3a 88 91 d4  d2 24 a9 58 66 35 a8 09  .j..:....$.Xf5..
      00d0: 4d 16 65 6d 15 35 29 ba  56 31 15 6d aa dd c6 b8  M.em.5).V1.m....
      00e0: e9 3b 75 2e 52 3d 86 65  e4 a0 b5 6e 2d 9c b9 35  .;u.R=.e...n-..5
      00f0: eb 43 33 32 21 42 24 32  21 1a ae 8e 03 e4 b9 a9  .C32!B$2!.......
      0100: f6 4b 1a 85 1e 1b 60 ad  a6 86 a6 ce 90 7d 5d 37  .K....`......}]7
      0110: 1b 62 66 e2 6f 92 14 4c  bc 46 a5 3b 4c e5 46 9d  .bf.o..L.F.;L.F.
      0120: a8 db 9b 60 32 94 ec 10  5a 93 0b b3 86 64 4e ee  ...`2...Z....dN.
      0130: d2 8f c5 b2 50 f6 43 5a  2e 25 6b 53 ab 8a d3 28  ....P.CZ.%kS...(
      0140: 87 1a 75 e9 48 93 7b 78  97 6d 09 c1 79 cb 36 bd  ..u.H.{x.m..y.6.
      0150: 85 69 88 72 1d 40 eb b3  6c 2e 56 ed a2 d6 53 88  .i.r.@..l.V...S.
      0160: 55 37 71 9c b9 35 f9 42  33 33 21 42 23 33 31 26  U7q..5.B33!B#31&
      0170: ea 93 46 ca a5 1b 74 76  98 9e 11 a6 a0 aa c4 96  ..F...tv........
      0180: 29 15 24 5d d6 38 8f 43  8e 21 eb 10 b0 a9 34 2c  ).$].8.C.!....4,
      0190: 9b 07 a9 c3 61 ea 6d 1e  3c 71 3b 93 1c 6d e5 63  ....a.m.<q;..m.c
      01a0: 6b 7a 08 e3 63 10 d3 13  ab b4 d1 74 89 0a 36 92  kz..c......t..6.
      01b0: 33 0c a3 c7 02 f1 11 c6  85 0e 24 99 22 89 36 2e  3.........$.".6.
      01c0: cd 39 4c 41 4e c5 87 31  cf 49 5c 70 ad 94 71 2b  .9LAN..1.I\p..q+
      01d0: 04 e5 65 66 15 28 3b 77  53 9c b9 35 ad 42 13 33  ..ef.(;wS..5.B.3
      01e0: 32 42 23 32 32 27 04 ca  46 ca 58 2a b7 a9 22 9d  2B#22'..F.X*..".
      01f0: c5 33 5a d5 d7 57 2d ba  e2 9d 25 36 9d 2c a6 93  .3Z..W-...%6.,..
      0200: 29 55 a4 5c a6 34 8b b8  8c 22 53 35 95 3b 0c 70  )U.\.4..."S5.;.p
      0210: 2a e1 8a 8f 62 5b 53 11  13 6e 56 c6 9b 0d b7 13  *...b[S..nV.....
      0220: 62 38 b4 94 65 c6 8a 8c  b5 16 81 a9 b2 90 65 b1  b8..e.........e.
      0230: 27 0f 99 a4 e7 2d ad c1  9c 55 b8 29 0b 51 2a da  '....-...U.).Q*.
      0240: 4a 14 db 61 49 1a cb 28  a8 db 0c 69 76 e8 ad     J..aI..(...iv..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 14 time 9600 ssrc 1
      0000: 05 9c b9 35 27 42 23 22  21 42 23 22 21 1e 73 85  ...5'B#"!B#"!.s.
      0010: c3 d9 aa 6a f1 c7 71 4e  37 14 5f 9c c2 42 f1 56  ...j..qN7._..B.V
      0020: 92 7d fd dd 45 b4 b7 42  b0 54 da 36 4e b5 23 50  .}..E..B.T.6N.#P
      0030: 66 42 ee 6d 85 3b 9a b9  15 8a 4a 52 5e 1f 21 e9  fB.m.;....JR^.!.
      0040: 33 e8 4b 35 09 a7 5e a1  89 f2 59 85 3a 65 29 4a  3.K5..^...Y.:e)J
      0050: 9c 25 69 18 93 1a 94 c9  a5 87 ab 3b 18 34 ae aa  .%i........;.4..
      0060: fc 25 3a ab 5f 66 03 ae  cd 90 ea aa 24 95 a6 29  .%:._f......$..)
      0070: 29 52 8e 25 2a 49 85 9c  b9 35 df 42 22 32 21 42  )R.%*I...5.B"2!B
      0080: 33 32 20 36 ac 51 84 dd  94 63 7a f1 6e 57 90 5b  32 6.Q...cz.nW.[
      0090: 9c ab 1b 63 76 44 da 8e  18 5b 46 cb 26 94 69 68  ...cvD...[F.&.ih
      00a0: da 85 d9 34 a3 02 47 13  aa c9 c5 9c 2c a6 ab 37  ...4..G.....,..7
      00b0: 69 32 65 bd c2 2c 45 50  6a 50 ec 29 4a db 2a 1a  i2e..,EPjP.)J.*.
      00c0: 8c 4d 0f aa d4 50 bb c2  61 55 78 98 be f7 cb 91  .M...P..aUx.....
      00d0: be d2 aa 62 94 c3 0d d2  b0 b7 95 86 c5 f8 f1 b1  ...b............
      00e0: 09 be b2 99 08 8c a9 62  a5 38 5e bc 6a 9c b9 35  .......b.8^.j..5
      00f0: c4 42 22 22 31 43 23 22  31 4e 08 db 68 d1 b4 db  .B""1C#"1N..h...
      0100: fa 74 c3 5f 69 40 e9 d2  37 24 37 0e 46 86 55 ba  .t._i@..7$7.F.U.
      0110: 89 c3 4e a4 e9 6d c2 5d  da 91 27 4a 39 b2 ee 1d  ..N..m.]..'J9...
      0120: 6d 7b 22 79 a5 7a 55 75  43 c6 2d cb 43 53 4e f2  m{"y.zUuC.-.CSN.
      0130: 1c 67 dd 16 d1 d1 41 1c  2a e9 36 d5 b2 86 90 fc  .g....A.*.6.....
      0140: 65 b6 a5 d5 21 52 b2 48  59 38 b4 45 25 9b 2d 39  e...!R.HY8.E%.-9
      0150: 12 44 b6 ac 1a 11 39 3c  71 19 a2 db 49 d3 5a 6c  .D....9<q...I.Zl
      0160: cb b6 a2 9c b9 35 30 42  33 33 22 43 23 33 22 57  .....50B33"C#3"W
      0170: 52 94 46 da a5 13 b5 95  34 56 dd 4d 1d bb 69 d2  R.F.....4V.M..i.
      0180: b7 1b 74 bd 13 a2 0d a5  21 84 24 db 44 6d e8 c9  ..t.....!.$.Dm..
      0190: 1d 95 94 84 6c e5 21 ec  d6 a2 a7 72 28 b1 5c c5  ....l.!....r(.\.
      01a0: 05 eb 14 c1 5e f1 c5 27  64 8d 4a 99 79 c1 2e ec  ....^..'d.J.y...
      01b0: 70 59 93 49 81 b6 54 40  b7 da 6c 91 d4 db 2a 21  pY.I..T@..l...*!
      01c0: 1b 91 14 e4 e4 31 b6 9b  24 f1 a6 89 5b 36 e4 17  .....1..$...[6..
      01d0: 61 ab 08 d6 2d 08 5c 4a  c2 9c b9 35 95 42 23 33  a...-.\J...5.B#3
      01e0: 21 42 33 33 21 5e c6 91  89 e5 4d 43 7e 24 8b 4f  !B33!^....MC~$.O
      01f0: 46 5a a2 c3 13 4c 37 92  da a7 45 db 92 d3 a6 e4  FZ...L7...E.....
      0200: e6 a8 da 3d 14 b6 9b 16  54 22 e0 ad 8a 0a e3 46  ...=....T".....F
      0210: 2b b9 4d 91 55 69 b1 eb  cc 6c 57 6e cd 46 e9 5c  +.M.Ui...lWn.F.\
      0220: 53 33 07 50 4e a4 dd 51  a2 52 71 f8 68 5c bd 69  S3.PN..Q.Rq.h\.i
      0230: db 4f b4 b4 87 ec 90 9a  ec 5a 26 bb 84 76 c5 70  .O.......Z&..v.p
      0240: cd b1 2b 5d 35 1b a4 89  2a c2 e4 b0 cb bc 0c     ..+]5...*......
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 15 time 10240 ssrc 1
      0000: 05 9c b9 35 9a 32 33 32  22 42 33 32 32 14 dc 14  ...5.232"B322...
      0010: 0f b7 47 43 34 e1 64 c5  b6 91 9d 86 9c 85 ad b7  ..GC4.d.........
      0020: 18 29 b4 d1 29 29 32 e1  75 ba 70 be 8a 88 96 26  .)..))2.u.p....&
      0030: 3b 26 d9 92 b5 3a a5 a1  67 61 69 33 ab 6f c3 76  ;&...:..gai3.o.v
      0040: 9c f0 06 da 81 8e e6 a1  69 6a 9c 88 75 94 e3 49  ........ij..u..I
      0050: 96 62 52 ad 28 5a 5c 34  54 17 6d a5 1a 5d c6 d5  .bR.(Z\4T.m..]..
      0060: fb 6c b6 8e ce 33 27 4b  a8 54 15 69 b1 36 da 6c  .l...3'K.T.i.6.l
      0070: a1 c2 4a 21 9a 93 6d 9c  b9 35 6b 32 23 32 31 42  ..J!..m..5k2#21B
      0080: 23 32 32 1f 5b 45 1b 84  9a 4e 2e e2 8d 4c b8 a3  #22.[E...N...L..
      0090: 1f 46 e2 6c d6 38 da 7d  38 5b 52 8a 26 d3 58 d4  .F.l.8.}8[R.&.X.
      00a0: 99 77 55 24 92 96 ba 8a  b4 aa 25 b8 6d aa ad 9c  .wU$......%.m...
      00b0: 4e 90 a2 6c 37 74 9a 2e  25 5b 8d 9d 6b 1b 61 ec  N..l7t..%[..k.a.
      00c0: dd 6c da 97 1b 85 c9 09  69 51 42 98 cc 8c 94 53  .l......iQB....S
      00d0: 4b 25 16 e1 b8 5b 32 4d  a6 9e 8d b8 d5 9e 6d a4  K%...[2M......m.
      00e0: 17 69 d6 5e 5a 91 a4 98  55 33 a6 44 51 9c b9 35  .i.^Z...U3.DQ..5
      00f0: e4 42 23 22 32 42 23 32  22 72 5a 69 27 d3 31 0c  .B#"2B#2"rZi'.1.
      0100: da d3 8d 6e 9b 8e 5b a2  c3 6a d8 d2 8a a5 d5 43  ...n..[..j.....C
      0110: 5c 96 a8 85 78 a4 e2 66  b2 d4 ab 0d 66 43 a5 b6  \...x..f....fC..
      0120: c2 2c 4d b5 2f 51 c6 b1  d8 4e 31 ba 69 c1 4e 9a  .,M./Q...N1.i.N.
      0130: 59 c8 5e 4e 2b 36 d1 6c  32 1a 69 54 bc 5b 89 3a  Y.^N+6.l2.iT.[.:
      0140: ca 73 15 cb 1c 5e a9 93  a9 29 d4 9a b4 d8 8a 2f  .s...^...)...../
      0150: 0d a2 e5 f2 34 98 ec 75  18 17 72 35 08 d3 81 a8  ....4..u..r5....
      0160: 99 74 a2 9c b9 35 18 43  33 32 32 43 23 22 21 56  .t...5.C322C#"!V
      0170: d2 94 c5 ab 29 4c 57 74  c7 37 85 5c 5b aa 8d c1  ....)LWt.7.\[...
      0180: 1c 49 1a 9e 1b 86 26 5a  36 53 f0 db 2d 16 c5 a2  .I....&Z6S..-...
      0190: ab 64 d6 49 b3 2d e1 cb  c7 02 5a b3 7c 0e d9 b6  .d.I.-....Z.|...
      01a0: 5b 15 db 40 5e e1 ba 93  f6 a0 89 f7 6e 38 11 86  [..@^.......n8..
      01b0: ec 55 bb 2d 39 1a 93 1a  c7 19 6e 89 71 90 e8 6c  .U.-9.....n.q..l
      01c0: 92 6e 76 85 04 a1 b4 d9  61 39 29 99 3c 34 cb 8f  .nv.....a9).<4..
      01d0: b4 75 26 e1 96 e0 4d a0  ce 9c b9 35 7e 33 32 22  .u&...M....5~32"
      01e0: 22 42 23 32 21 4d 58 50  a9 42 13 25 2f 2e 41 5f  "B#2!MXP.B.%/.A_
      01f0: 34 dd 1d 87 35 c2 da 85  5c 7b b1 68 91 ca a4 51  4...5...\{.h...Q
      0200: de 20 68 5d 59 98 96 b0  c5 23 2d cd 61 96 a7 1c  . h]Y....#-.a...
      0210: 2b 24 ad af cd c5 15 79  fa 51 0e 0e 32 28 65 a2  +$.....y.Q..2(e.
      0220: 49 66 f9 b1 4e 97 55 05  97 a1 89 d9 2a 58 ca bc  If..N.U.....*X..
      0230: 0e 53 93 b2 a6 d6 9b 6a  b4 71 b8 a6 b0 dc 45 e3  .S.....j.q....E.
      0240: 69 b4 58 76 da 9d 64 71  86 a3 b6 20 8b ba 85     i.Xv..dq... ...
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 16 time 10880 ssrc 1
      0000: 05 9c b9 35 5d 43 23 32  22 43 23 33 32 6a 8b 92  ...5]C#2"C#32j..
      0010: 93 b5 1c ad 94 d1 29 15  54 94 17 b4 94 24 29 a4  ......).T....$).
      0020: da d5 89 14 17 66 26 c3  6e ab 59 0a 8a c6 ab 49  .....f&.n.Y....I
      0030: c2 07 e2 71 26 8b ad 25  72 d9 62 ad 67 69 2b 57  ...q&..%r.b.gi+W
      0040: 1a 4d 42 93 62 4d b2 d2  82 72 99 72 6d 84 9b 91  .MB.bM...r.rm...
      0050: b6 a2 52 35 26 d1 15 c4  da ad 51 48 e9 a8 d2 d5  ..R5&.....QH....
      0060: fb 14 b6 2d b1 2e a5 f3  4e 35 59 70 a5 42 44 2d  ...-....N5Yp.BD-
      0070: a7 e2 88 09 1a a9 49 9c  b9 35 1f 43 23 33 22 42  ......I..5.C#3"B
      0080: 33 32 22 76 e9 b7 09 62  88 8c b7 91 a6 5e 14 4a  32"v...b.....^.J
      0090: 1c c3 ad c2 19 23 82 ae  5b 4a 89 d8 cd 83 6f 1b  .....#..[J....o.
      00a0: 30 4e c9 01 31 70 db 63  ec c5 52 6e 17 20 3d 69  0N..1p.c..Rn. =i
      00b0: b6 4f dd 26 c5 39 6a 14  4f 61 b6 87 5a 6e 33 77  .O.&.9j.Oa..Zn3w
      00c0: 31 45 53 53 ad 0f c1 89  c9 16 5a 25 25 a2 35 5a  1ESS......Z%%.5Z
      00d0: d6 93 86 ee db 4a 97 36  da 9f 81 1d 53 31 46 d5  .....J.6....S1F.
      00e0: 8b b4 ca a5 69 44 a5 e6  17 14 9d 62 b5 9c b9 35  ....iD.....b...5
      00f0: cb 32 33 33 20 43 33 22  21 6d d9 1c 58 cb 1c 74  .233 C3"!m..X..t
      0100: 72 c8 e2 e5 95 1d 51 25  78 d3 6e 8f 0a 6a 61 96  r.....Q%x.n..ja.
      0110: a9 7b 46 c0 19 dd 84 ab  ab 30 86 90 a9 26 de 1d  .{F......0...&..
      0120: 8e d0 8a 6d 6a f1 09 47  d2 c3 72 b6 58 71 4e 5d  ...mj..G..r.XqN]
      0130: cb 4e ca b9 88 f3 12 aa  6e 22 13 07 45 78 82 f2  .N......n"..Ex..
      0140: d0 cb 1c ab b4 b5 63 96  56 da 65 a9 5a bc 22 96  ......c.V.e.Z.".
      0150: d3 09 c7 de 66 48 d4 6a  2d 3b 0f 09 a0 54 c4 51  ....fH.j-;...T.Q
      0160: 1c 7a 6a 9c b9 35 aa 42  23 32 31 42 22 33 21 96  .zj..5.B#21B"3!.
      0170: 8d 1d 6d d5 74 93 f9 17  1b 66 48 9a 17 bb a8 19  ..m.t....fH.....
      0180: b5 76 9a a5 49 c7 09 a2  ca 83 f9 6a 88 5d e5 b8  .v..I......j.]..
      0190: 3b 7a 2b 25 e6 e5 26 98  83 a2 33 25 0c cc 68 db  ;z+%..&...3%..h.
      01a0: 54 ec 9b 2d 56 f2 d3 85  ea 8c 49 bc 64 db 23 44  T..-V.....I.d.#D
      01b0: 9b 51 aa c2 21 b2 86 95  0d b2 a4 d6 a7 e6 98 75  .Q..!..........u
      01c0: 91 48 b5 df 14 ab 41 84  32 32 8c a9 0b 71 4a 13  .H....A.22...qJ.
      01d0: 69 05 8a df 1c 30 8a ca  8d 9c b9 35 7f 42 32 32  i....0.....5.B22
      01e0: 31 43 32 23 21 7e ab 09  6c dd 98 8c f6 88 84 73  1C2#!~..l......s
      01f0: 4f 51 d9 b3 e7 12 97 58  94 b6 52 1a d0 c2 42 d4  OQ.....X..R...B.
      0200: f6 95 94 36 5a 14 af 94  ad b2 f6 94 b2 18 b4 51  ...6Z..........Q
      0210: b9 34 a5 4b 62 74 4c fb  bd 4a 6b 0f 6a 46 5e 2e  .4.KbtL..Jk.jF^.
      0220: 6b b0 7a eb 2e ed 9c 0d  e4 64 a1 57 7c 1b 15 09  k.z......d.W|...
      0230: 95 1c b1 33 27 70 e9 98  b5 d8 97 2f 76 6d b4 66  ...3'p...../vm.f
      0240: ed b1 0d 9b b1 a5 86 96  07 65 4c 24 5b a9 a8     .........eL$[..
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 17 time 11520 ssrc 1
      0000: 05 9c b9 35 89 33 33 32  21 42 23 32 21 4d dc 62  ...5.332!B#2!M.b
      0010: 0b 9d 93 85 b1 29 1c d6  a1 22 8d 72 19 12 ac 25  .....)...".r...%
      0020: 22 02 aa 36 19 31 56 d0  dd de 94 7b db c6 a3 68  "..6.1V....{...h
      0030: ed c9 76 1d 96 55 a7 69  72 b8 e9 ab bb b3 2a 33  ..v..U.ir.....*3
      0040: 77 6a 55 56 10 8d 92 49  30 ef 0a 52 55 e1 4a 4b  wjUV...I0..RU.JK
      0050: 85 86 d4 38 ae db 1a b3  32 31 36 76 47 5e d5 51  ...8....216vG^.Q
      0060: 5b db 1e 0a f3 12 85 5a  22 50 f9 7a 71 32 cf 4a  [......Z"P.zq2.J
      0070: 21 c3 bc 21 78 88 65 9c  b9 35 f6 42 23 22 31 42  !..!x.e..5.B#"1B
      0080: 33 22 22 9f 06 43 1a d2  ad 43 5a 30 58 b5 d4 32  3""..C...CZ0X..2
      0090: 51 a2 78 b3 32 e6 12 ad  62 35 23 38 8c 54 6a 5b  Q.x.2...b5#8.Tj[
      00a0: 6c cb b8 22 b5 56 b2 67  56 ac 86 6b d1 d4 92 70  l..".V.gV..k...p
      00b0: 66 aa d0 4b 99 d2 52 d5  62 d8 b8 d2 96 4f 2a 7a  f..K..R.b....O*z
      00c0: 2e 06 85 9b a1 4f e3 4e  23 32 cc 83 26 9a a6 c5  .....O.N#2..&...
      00d0: 12 a3 d7 ec cd 29 3a b3  50 a1 c2 e5 85 e8 b6 f1  .....):.P.......
      00e0: 5c b4 a9 4b 2c 98 47 50  46 d9 53 71 a8 9c b9 35  \..K,.GPF.Sq...5
      00f0: 81 43 22 32 22 43 23 32  22 6b 2e 26 4c 5b 6a 14  .C"2"C#2"k.&L[j.
      0100: d5 b5 34 7e ab 49 0d db  28 91 38 db 04 95 03 32  ..4~.I..(.8....2
      0110: 0e b6 cc 83 af 29 4c 3d  48 4a af 91 d9 94 29 d4  .....)L=HJ....).
      0120: a6 3c 98 d4 bf 6d b3 28  65 34 c4 5b 6d 41 56 93  .<...m.(e4.[mAV.
      0130: b0 a7 ce 8c 2a 59 50 c9  12 dc 2e 58 b1 cd aa 14  ....*YP....X....
      0140: eb 6a e5 d7 72 5a b3 1c  96 2f 43 2a a5 e4 c2 a1  .j..rZ.../C*....
      0150: 63 a2 12 2d 48 c5 0a 32  d2 91 29 b4 a5 e0 b4 e4  c..-H..2..).....
      0160: 3b 4d a9 9c b9 35 1d 42  33 23 21 52 33 33 21 63  ;M...5.B3#!R33!c
      0170: 4e 85 0c aa 0a 62 b8 46  8a 63 8c 9a 49 cb 46 49  N....b.F.c..I.FI
      0180: c2 77 0a 7d cd 2b 94 1a  18 a3 7a c5 92 96 9c d4  .w.}.+....z.....
      0190: ad a7 54 95 34 69 29 bb  ba b8 35 77 4d 88 ee 19  ..T.4i)...5wM...
      01a0: b5 45 3a 6e 5e ea e1 cc  49 99 89 7b 26 88 4c a6  .E:n^...I..{&.L.
      01b0: d9 56 9d 38 aa 65 b6 6a  d6 5e 5a 1c 1c 56 c6 ea  .V.8.e.j.^Z..V..
      01c0: ee da c9 1d b6 9b 27 84  a5 47 31 28 c8 4c 86 28  ......'..G1(.L.(
      01d0: 58 89 08 4a 58 95 2b b3  65 9c b9 35 08 42 23 32  X..JX.+.e..5.B#2
      01e0: 32 42 23 23 22 7a 7b 41  8d 4b 89 2b f6 e3 6e 46  2B##"z{A.K.+..nF
      01f0: cd 2d 4f b4 db a1 16 5d  7a 7d c4 cc 84 a4 82 94  .-O....]z}......
      0200: ec b4 18 3e a6 4a b1 c2  b8 94 b9 50 c5 fb 52 14  ...>.J.....P..R.
      0210: a9 26 66 29 68 70 25 0d  6e a5 3f 89 96 24 f1 39  .&f)hp%.n.?..$.9
      0220: 21 3b 15 71 0f 5b c9 53  b6 6a 31 98 cf 62 d5 12  !;.q.[.S.j1..b..
      0230: dc 18 94 63 16 71 26 cc  87 44 6a 9b 6d b4 c1 68  ...c.q&..Dj.m..h
      0240: 38 d1 49 65 e5 0f 48 b6  48 4a 2d c0 9a 85 b4     8.Ie..H.HJ-....
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 18 time 12160 ssrc 1
      0000: 05 9c b9 35 8c 32 33 33  31 42 33 32 32 5d 54 65  ...5.2331B322]Te
      0010: b5 76 e9 93 fb 15 4d 2d  34 e5 01 97 19 62 dd c4  .v....M-4....b..
      0020: d4 1b c2 91 2e cd 27 00  28 c4 d9 57 30 b2 9f 4d  ......'.(..W0..M
      0030: c6 d6 fa 70 36 1b 12 26  fe 4d 75 a1 cb 41 b2 37  ...p6..&.Mu..A.7
      0040: 0a ad 0e 9b 6d 95 85 1a  89 2d 23 8c 4a c8 db 47  ....m....-#.J..G
      0050: 76 d4 26 75 33 11 3a 26  9a 87 42 26 13 d9 b7 19  v.&u3.:&..B&....
      0060: 97 31 d6 00 86 c6 c9 b9  ce 24 7c 6d a6 4e 64 66  .1.......$|m.Ndf
      0070: 26 d2 85 c3 20 e3 b1 9c  b9 35 37 42 23 33 21 43  &... ....57B#3!C
      0080: 23 33 22 5f 80 da 10 b8  6d 0c 58 66 9c de 92 6f  #3"_....m.Xf...o
      0090: 0a c2 16 d1 76 4c 6c 95  11 c2 13 62 e1 85 34 cd  ....vLl....b..4.
      00a0: c4 7c 95 19 47 24 75 8d  59 37 11 fd cb 6d 63 31  .|..G$u.Y7...mc1
      00b0: 54 c9 58 93 60 fa 45 34  4f 02 9a 13 b0 2d 92 95  T.X.`.E4O....-..
      00c0: b5 1a 4d 99 ad 15 c0 b6  d4 ea db 6a fd 39 36 bb  ..M........j.96.
      00d0: 6a a2 46 e9 8d b5 7b 96  62 95 78 2d 45 65 12 54  j.F...{.b.x-Ee.T
      00e0: fa a4 2d 22 ae 38 29 d9  db 49 97 ad a5 9c b9 35  ..-".8)..I.....5
      00f0: 5d 43 23 32 21 43 33 32  21 86 6f 0d 2c d5 e1 73  ]C#2!C32!.o.,..s
      0100: 98 67 39 52 cc dd 54 c1  c3 49 57 89 18 8e 22 4c  .g9R..T..IW..."L
      0110: 4a bb c6 94 6e 92 88 65  d6 18 b7 87 96 45 ab 31  J...n..e.....E.1
      0120: 32 2b 3c b4 b5 77 8d cb  69 66 35 0c 34 9a 56 e3  2+<..w..if5.4.V.
      0130: 6d a5 e1 2b 61 da 99 85  17 3a da 55 aa 32 8a 56  m..+a....:.U.2.V
      0140: 74 e1 04 99 d2 1b 93 a6  94 f5 0e da 65 e1 c6 b7  t...........e...
      0150: 94 69 14 b0 ee b5 4b c3  c7 0b 59 71 26 da 8e 20  .i....K...Yq&.. 
      0160: 79 39 ad 9c b9 35 79 42  23 23 22 42 23 23 32 7a  y9...5yB##"B##2z
      0170: 41 ce 5f 84 ab 6b 38 cd  62 9e b2 db 4e a8 5b 02  A._..k8.b...N.[.
      0180: 6c 96 da 8c 72 d4 91 34  38 93 65 ba 50 7c 4f 36  l...r..48.e.P|O6
      0190: bb 4d 36 b0 64 50 b6 2b  52 49 5e cc 6a 0c 64 61  .M6.dP.+RI^.j.da
      01a0: 29 d6 da 6d 3e c3 2c 4d  a0 83 69 db 59 8a 25 c6  )..m>.,M..i.Y.%.
      01b0: 5c 5f b7 5a 14 ea 52 db  55 b8 5a 41 76 24 97 31  \_.Z..R.U.ZAv$.1
      01c0: a8 c9 9c 4a b6 ad 51 d4  87 61 75 31 6a 8e 32 56  ...J..Q..au1j.2V
      01d0: a3 6d 49 50 8d c1 96 ea  74 9c b9 35 40 32 23 23  .mIP....t..5@2##
      01e0: 21 43 33 23 21 96 ee 1a  1d ae 53 23 22 f3 54 ac  !C3#!.....S#".T.
      01f0: de 9b 85 6c 7a d3 e7 2f  1a 48 3b d7 13 67 7a a2  ...lz../.H;..gz.
      0200: 52 4d 24 dc 3a 34 bb 80  ed ce 69 99 b9 fa 37 d4  RM$.:4....i...7.
      0210: 5a d0 da 81 c9 8f 20 f9  80 e5 04 e8 64 52 8c 8d  Z..... .....dR..
      0220: 88 ae cd 90 3d e5 b2 1d  64 22 d5 68 e4 9d 4b 9c  ....=...d".h..K.
      0230: 34 c3 36 86 94 72 59 b4  fd 53 36 92 aa d1 a6 5d  4.6..rY..S6....]
      0240: dd b0 07 04 6e 4a ce 6a  2a ba 23 42 16 46 69     ....nJ.j*.#B.Fi
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 19 time 12800 ssrc 1
      0000: 05 9c b9 35 fc 42 23 22  21 41 33 32 31 b6 b3 0d  ...5.B#"!A321...
      0010: ae cc 36 db 32 57 4d 4a  4d a6 d4 b4 c9 49 b9 10  ..6.2WMJM....I..
      0020: 96 d5 de 81 8b d9 a9 34  b0 ac 18 4e 4b 50 cd 77  .......4...NKP.w
      0030: 76 58 a1 93 0d 89 c4 a8  a9 6d 54 6c d2 e9 34 e9  vX.......mTl..4.
      0040: c8 ec 47 03 0c 25 c9 46  99 95 8c 30 12 1e b4 df  ..G..%.F...0....
      0050: 87 52 6b 31 35 a6 fd 55  db 18 f9 65 a7 b3 6d 1c  .Rk15..U...e..m.
      0060: ce 3b 8e 25 60 88 d1 75  1c 6d 39 e4 d1 19 8f 20  .;.%`..u.m9.... 
      0070: 6a df 5c 59 3d 76 ac 9c  b9 35 54 43 33 32 22 42  j.\Y=v...5TC32"B
      0080: 33 22 22 9e 51 36 b1 c2  4d ab f4 ce 35 5a a4 8d  3"".Q6..M...5Z..
      0090: 52 b9 4a a9 72 c9 ca 8d  d9 85 48 a6 a1 54 ae cd  R.J.r.....H..T..
      00a0: 82 55 51 60 c1 94 5d 55  f5 19 95 eb a8 dc a5 6a  .UQ`..]U.......j
      00b0: 45 2d 5d a8 a5 58 6a a5  43 2d 2c 24 6c 4f 09 95  E-]..Xj.C-,$lO..
      00c0: 50 b5 0a 1c 0c 5b bd 6e  8a 92 e2 cb 56 cb 6e 20  P....[.n....V.n 
      00d0: b8 db 45 aa db 04 64 47  01 25 6a 91 82 2a 94 a1  ..E...dG.%j..*..
      00e0: 2c b6 49 13 a9 92 4b 55  c4 e0 db 4c c8 9c b9 35  ,.I...KU...L...5
      00f0: d0 43 23 23 32 42 33 23  32 a3 1b 6d b0 b7 12 6b  .C##2B3#2..m...k
      0100: 58 a4 4d 3b 37 13 51 a1  5a 69 60 e6 9a 85 d4 1c  X.M;7.Q.Zi`.....
      0110: 8d 91 87 16 28 56 78 61  75 1e 4b 69 56 a7 44 4d  ....(Vxau.KiV.DM
      0120: 29 9b 4b b8 2e da ce 09  4d 99 c4 b5 25 71 3a db  ).K.....M...%q:.
      0130: d0 a5 26 b4 29 b5 53 8d  2a 33 63 64 d2 ca 4a d5  ..&.).S.*3cd..J.
      0140: a6 93 3e 36 93 5e 4d b4  c4 6d b6 9c 5d a9 a7 1d  ..>6.^M..m..]...
      0150: 8c 47 43 54 2d d1 3a 6e  35 12 52 4d 4e 53 51 c1  .GCT-.:n5.RMNSQ.
      0160: 42 db 70 9c b9 35 90 32  22 32 32 42 33 32 32 ac  B.p..5.2"22B322.
      0170: b3 69 a0 96 ad 32 ae 95  20 9e b4 ac 01 69 88 e1  .i...2.. ....i..
      0180: 69 40 d4 1b 45 26 0b b0  a4 c1 f3 2f 34 eb 49 e6  i@..E&...../4.I.
      0190: bf 16 81 8d 62 94 35 7b  22 cd 3f dc 3d 28 a3 1c  ....b.5{".?.=(..
      01a0: 6a 38 1b 8d 03 9e 5a 4a  e3 83 49 f9 f6 52 66 48  j8....ZJ..I..RfH
      01b0: 4a 63 49 aa d5 31 45 5b  4a 51 36 b5 4d b6 d3 dc  JcI..1E[JQ6.M...
      01c0: e5 b4 e8 55 46 86 dc 68  a4 5b 91 95 12 eb 71 3e  ...UF..h.[....q>
      01d0: e4 6e 26 c6 9b 8b 38 db  6d 9c b9 35 4c 32 23 32  .n&...8.m..5L2#2
      01e0: 31 42 23 32 31 b6 82 32  a0 d3 b6 91 af 0a 38 76  1B#21..2......8v
      01f0: 21 c9 05 b6 56 23 b2 e6  54 89 a2 b1 99 22 52 a0  !...V#..T...."R.
      0200: 50 cb 14 b9 2a 86 de 54  63 4e 5f 0c 89 d2 b2 d9  P...*..TcN_.....
      0210: 46 54 5b 26 9c 26 60 f1  b6 cc 06 69 db 06 85 b9  FT[&.&`....i....
      0220: 62 6d 25 b4 a7 60 b6 a3  96 48 b6 e2 e9 a6 ee 94  bm%..`...H......
      0230: 6d 33 69 69 b2 49 12 91  0b aa 52 0b 09 1c 66 54  m3ii.I....R...fT
      0240: 1b 8c 95 a8 23 1b 0e cb  68 b4 c6 52 f7 76 c3     ....#...h..R.v.
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 20 time 13440 ssrc 1
      0000: 05 9c b9 35 88 33 23 23  20 43 23 32 20 8d 9e 0b  ...5.3## C#2 ...
      0010: 57 ab cb 69 72 b4 da 8e  1e da 85 55 a4 94 6e 96  W..ir......U..n.
      0020: 52 5b e4 b4 97 76 b4 23  61 69 b0 fd 35 c6 d2 b4  R[...v.#ai..5...
      0030: c9 4e 5c d9 09 5b 97 12  53 8c e5 c6 bc 51 a1 f7  .N\..[..S....Q..
      0040: 79 7c 00 ee 23 4b a3 bb  52 a8 fa da 65 eb 51 69  y|..#K..R...e.Qi
      0050: 79 52 c7 e9 c6 d8 ba 9a  b6 a3 53 74 95 dd 1e 39  yR........St...9
      0060: 3c 43 a7 16 e8 d9 06 d8  e1 90 37 96 c9 23 1e f0  <C........7..#..
      0070: aa bb 92 8a b6 53 75 9c  b9 35 3e 42 33 32 21 42  .....Su..5>B32!B
      0080: 23 32 21 8e ac 45 cd 49  4b 73 78 36 6d 37 66 a3  #2!..E.IKsx6m7f.
      0090: 55 bc b3 2a 35 64 ca 84  de 18 89 96 34 25 70 aa  U..*5d......4%p.
      00a0: 9a 6d cd 26 c1 65 74 c6  30 6d b1 9d 54 b6 a3 bc  .m.&.et.0m..T...
      00b0: 8a 2b 49 d9 81 09 1b 20  3f 06 a6 63 e1 91 92 f4  .+I.... ?..c....
      00c0: 79 49 22 61 53 5d ac 3a  82 d3 d6 e8 f4 9e 53 1b  yI"aS].:......S.
      00d0: ab d6 c5 b7 0e da 65 15  c6 23 47 87 94 2e ed 74  ......e..#G....t
      00e0: ec 43 b9 17 67 6a ac 55  d1 b9 89 b2 6e 9c b9 35  .C..gj.U....n..5
      00f0: d4 43 23 22 21 42 33 32  21 92 e9 28 0e ed db 23  .C#"!B32!..(...#
      0100: d5 d7 e9 5a 92 ea 54 c2  c7 61 5e 77 58 85 c9 cc  ...Z..T..a^wX...
      0110: 4d d1 35 15 a7 ae d0 85  1d b4 3d 5b 66 e6 61 0e  M.5.......=[f.a.
      0120: 39 ba ab a4 a1 55 71 2a  50 d3 21 18 32 8c 56 e8  9....Uq*P.!.2.V.
      0130: 8e a6 d2 4b aa 38 23 c8  2f 8c 62 20 ba 8c ac 34  ...K.8#./.b ...4
      0140: 70 ea e6 31 ab 59 bc a8  d4 32 aa da a5 d5 36 a5  p..1.Y...2....6.
      0150: 7b 45 53 b3 25 50 ec a2  66 8d d7 51 ae 65 1a 45  {ES.%P..f..Q.e.E
      0160: 3d ca 71 9c b9 35 d6 42  22 22 21 42 33 32 21 8e  =.q..5.B""!B32!.
      0170: 6c d5 ac d9 dd 6a d6 77  25 4b 28 d0 4f ac 39 61  l....j.w%K(.O.9a
      0180: 39 76 58 55 83 14 4a 91  47 16 ec 94 5a 96 dd b6  9vXU..J.G...Z...
      0190: c3 77 86 16 b5 0d 95 bc  0c b8 23 73 6d 89 6a 61  .w........#sm.ja
      01a0: 34 6a 34 6d 5a 2d c9 a4  51 db 69 9e 6e 4c 12 ef  4j4mZ-..Q.i.nL..
      01b0: 5a 1f cc 58 2a d8 78 52  df 0a c4 4b f3 44 d3 e8  Z..X*.xR...K.D..
      01c0: ab 4c 5d 19 b2 99 24 2b  51 e5 09 c5 6b 51 e6 95  .L]...$+Q...kQ..
      01d0: 77 95 ab da 12 b9 8a d2  89 9c b9 35 e2 42 23 32  w..........5.B#2
      01e0: 11 42 23 32 11 7a 30 91  49 d8 93 71 f5 74 6d 1f  .B#2.z0.I..q.tm.
      01f0: 0a 53 4d 9c ab 48 15 54  d2 7c 51 da 4a 83 24 c7  .SM..H.T.|Q.J.$.
      0200: 39 07 4a 86 6c d0 bf d6  64 e6 ad 29 c5 2e 8a 32  9.J.l...d..)...2
      0210: 19 96 4c 88 dc 99 40 2d  33 50 3a 6c ed a2 d5 53  ..L...@-3P:l...S
      0220: 8b 18 66 50 3b 82 d3 64  ca ba 23 1b 36 88 d5 d2  ..fP;..d..#.6...
      0230: 9b 91 ba 46 a4 6b 2c 54  35 99 a3 1f 36 84 c2 a5  ...F.k,T5...6...
      0240: 71 41 1a c5 2c 95 58 8a  ad 6a a6 28 ed 54 8e     qA..,.X..j.(.T.
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 21 time 14080 ssrc 1
      0000: 05 9c b9 35 9a 42 23 32  21 42 23 32 20 76 81 46  ...5.B#2!B#2 v.F
      0010: 0c 50 a1 62 16 97 65 2b  46 d8 94 bb bd 69 7a c7  .P.b..e+F....iz.
      0020: 5a 8e 16 da 49 c2 46 55  e0 ec 9a 9c 21 9a c1 59  Z...I.FU....!..Y
      0030: 66 d5 31 0d b5 3c 55 36  17 28 8d 87 5e 99 a4 8c  f.1..<U6.(..^...
      0040: 4b 6a 37 46 d1 a4 c9 5c  4b 34 74 4c 42 8a 4c 25  Kj7F...\K4tLB.L%
      0050: c0 93 8c 17 42 da a4 d1  aa 48 d4 ba d4 6d 08 da  ....B....H...m..
      0060: 84 ec b4 1f b5 66 52 b6  ce 15 18 c9 c9 17 0d 31  .....fR........1
      0070: ce f2 1d b1 2c a2 6d 9c  b9 35 d7 42 33 32 20 43  ....,.m..5.B32 C
      0080: 33 33 11 76 aa ca 2c 65  da 82 58 64 4e 3a ca 5b  33.v..,e..XdN:.[
      0090: d9 ab b1 41 f6 86 18 ae  09 92 49 ab b4 a6 f2 f0  ...A......I.....
      00a0: d2 ae 19 b7 4d 07 97 c7  2c d1 40 de c4 32 97 a7  ....M...,.@..2..
      00b0: 8d 2a 52 30 a4 cb 2d 4e  43 48 ee 24 e0 e3 61 dc  .*R0..-NCH.$..a.
      00c0: 78 6d 1f 6b 14 1e b3 c1  4b 76 76 8c 8e d9 15 4c  xm.k....Kvv....L
      00d0: cc 17 05 20 f2 e2 7c 5a  b6 97 8a c6 20 a9 71 94  ... ..|Z.... .q.
      00e0: fc 3b 96 91 87 69 8f cd  dd b1 8b c3 70 9c b9 35  .;...i......p..5
      00f0: 9a 43 23 32 21 42 22 32  31 6f 0a 9b 98 b3 16 da  .C#2!B"21o......
      0100: 3a 35 12 57 0d 48 90 b4  1b 11 e0 c2 b4 75 e1 56  :5.W.H.......u.V
      0110: 83 4a 34 c6 ae 09 a5 1b  89 88 bb 74 4d 8e 6d c1  .J4........tM.m.
      0120: ac cc b3 46 23 88 99 a4  dd 4b 68 b7 72 f1 5e 48  ...F#....Kh.r.^H
      0130: e4 49 8a 46 da 37 94 da  65 d8 45 21 bb 38 56 bf  .I.F.7..e.E!.8V.
      0140: 11 b6 9d dd 34 a7 6a 09  b4 32 8d 84 5c 1b 89 9d  ....4.j..2..\...
      0150: 47 6d c3 48 ea 71 0b bc  29 1f 69 10 70 5e 9a 32  Gm.H.q..).i.p^.2
      0160: f9 9a d4 9c b9 35 84 32  23 32 21 42 33 31 22 55  .....5.2#2!B31"U
      0170: 4a 26 54 a2 c8 30 2e d2  c2 64 9e b5 0d d5 72 53  J&T..0...d....rS
      0180: 71 2c aa 01 a5 24 17 47  a8 56 5e b1 41 2b c5 74  q,...$.G.V^.A+.t
      0190: ba cb 6d 4b 65 ab 04 7a  57 66 47 0e dc 03 e1 4a  ..mKe..zWfG....J
      01a0: 60 b8 67 0a 1d 31 e0 47  b4 b4 a3 24 90 b2 b4 19  `.g..1.G...$....
      01b0: a8 6f bd 67 07 e7 2a 2a  6b 33 b6 97 07 52 52 62  .o.g..**k3...RRb
      01c0: 12 18 4c b9 80 8a bb 10  a4 ca d5 60 74 96 60 3e  ..L........`t.`>
      01d0: ca 9a 53 98 c2 73 55 86  a0 9c b9 35 0b 42 22 33  ..S..sU....5.B"3
      01e0: 22 43 23 22 21 57 45 1b  54 6e a0 49 58 90 92 91  "C#"!WE.Tn.IX...
      01f0: 8a 8d 92 8a a4 c5 29 b6  22 a7 5c 38 06 62 26 09  ......).".\8.b&.
      0200: 72 31 aa 4a c6 23 2f 64  ed c1 f6 30 39 28 6a 14  r1.J.#/d...09(j.
      0210: 97 bd 61 86 4d a1 40 4d  dc 05 53 37 4c 12 6e e0  ..a.M.@M..S7L.n.
      0220: 0b 1a 88 e2 9f 67 0b 27  c2 56 d5 eb 8a dc 8f 9f  .....g.'.V......
      0230: 46 a8 69 ca a4 6c 5d 39  42 ea b6 1d 84 c9 28 7a  F.i..l]9B.....(z
      0240: 70 c1 1c 86 50 46 b1 62  31 5a 93 92 8d e2 8d     p...PF.b1Z.....
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 22 time 14720 ssrc 1
      0000: 05 9c b9 35 55 42 22 33  21 43 33 33 21 42 c8 b1  ...5UB"3!C33!B..
      0010: c7 dd 94 69 56 94 a5 2b  10 ea 4f cc 34 61 16 87  ...iV..+..O.4a..
      0020: 1a 5d 5e 63 84 bb 47 26  ee 60 8c 9d 94 b6 37 4a  .]^c..G&.`....7J
      0030: 02 94 30 e6 34 7a 28 58  17 76 2d 28 e4 c2 34 9e  ..0.4z(X.v-(..4.
      0040: 31 6e 32 8e 11 84 5c dc  29 b5 b0 75 36 f0 ab 5d  1n2...\.)..u6..]
      0050: b5 93 73 17 76 da a6 98  5b 0e bc b4 44 6a c8 d2  ..s.v...[...Dj..
      0060: 5d 59 18 97 20 22 d0 6a  c9 d9 3d 02 32 8b 86 4a  ]Y.. ".j..=.2..J
      0070: 30 53 a9 35 2b 53 6c 9c  b9 35 e9 43 23 33 32 42  0S.5+Sl..5.C#32B
      0080: 23 32 22 72 db 6e af 52  92 01 3a db 6d 2f c3 2d  #2"r.n.R..:.m/.-
      0090: 93 b6 db 69 36 da 50 9e  28 d3 47 c1 5f 27 69 c6  ...i6.P.(.G._'i.
      00a0: 98 cd a6 c6 37 72 42 e5  a9 d6 48 fc 31 b8 0f 6d  ....7rB...H.1..m
      00b0: d2 07 54 c5 a8 b9 74 b6  2b 2c 71 02 5d a6 83 36  ..T...t.+,q.]..6
      00c0: e2 75 52 9c 6e 58 a4 db  6a b6 5b 8a 95 c6 db 4a  .uR.nX..j.[....J
      00d0: a6 ea 15 2d aa d2 7d 87  22 97 a0 d4 d1 74 9a 25  ...-..}."....t.%
      00e0: 1b 0a 32 99 4c c8 31 5c  2e 45 bb 85 b9 9c b9 35  ..2.L.1\.E.....5
      00f0: e9 42 23 33 21 42 13 32  21 72 0e d1 a9 c5 23 0a  .B#3!B.2!r....#.
      0100: 3b d4 6d 13 9c da 49 ba  1d 61 b6 2b 5a 86 51 ec  ;.m...I..a.+Z.Q.
      0110: 4c c1 5a d7 2c ae da ae  94 b2 b7 24 76 83 af 59  L.Z.,......$v..Y
      0120: 88 ec 32 17 19 02 64 a6  68 15 40 8d 23 58 13 8f  ..2...d.h.@.#X..
      0130: 4e a0 f9 43 cb b2 b7 89  4e 15 e1 5d d2 d9 82 98  N..C....N..]....
      0140: 54 8a ac d2 1a 4e be 86  92 b1 6e 98 26 23 99 1f  T....N....n.&#..
      0150: 9b 93 22 2f 68 c5 2a a6  26 13 a1 4a 10 c2 59 b5  .."/h.*.&..J..Y.
      0160: bb b7 6e 9c b9 35 7f 42  23 32 22 43 32 33 21 66  ..n..5.B#2"C23!f
      0170: ad 2c 56 66 b5 6a 79 c6  d8 93 8a db 11 9a c8 84  .,Vf.jy.........
      0180: fb 48 98 5d ed 31 28 61  d6 67 af 2e 35 72 cd b6  .H.].1(a.g..5r..
      0190: 39 74 52 22 79 6a 35 0a  b2 71 88 b9 32 2c c2 cd  9tR"yj5..q..2,..
      01a0: 88 a5 19 ad 27 3c a3 62  29 44 6b 92 82 da 2f 78  ....'<.b)Dk.../x
      01b0: a3 63 94 26 ca 19 51 1a  7f 15 3b 04 e1 94 85 26  .c.&..Q...;....&
      01c0: 89 22 2e cd 22 97 b9 30  28 b4 65 b1 88 72 7d 4d  .".."..0(.e..r}M
      01d0: ab 2e 30 4d 1b 6a e5 92  6d 9c b9 35 3b 43 22 32  ..0M.j..m..5;C"2
      01e0: 22 42 23 32 21 6a 52 9a  85 22 da 51 d7 5c 73 17  "B#2!jR..".Q.\s.
      01f0: 83 03 8f c4 b2 90 ca b4  90 9e 1a 96 45 76 34 c9  ............Ev4.
      0200: 6b 2a 88 82 d9 b4 af 56  b1 d2 33 ad b9 0b 2c 62  k*.....V..3...,b
      0210: 07 a8 a8 a7 66 31 62 6c  53 30 4a af 5a 11 76 da  ....f1blS0J.Z.v.
      0220: 44 35 78 e4 bd 76 e4 a1  c5 18 d5 cc 55 1a c5 dd  D5x..v......U...
      0230: b1 06 45 c6 94 ec 8e b5  3a 8a 57 1d 80 95 a0 fd  ..E.....:.W.....
      0240: 15 b5 cb b1 64 91 c8 4e  0d ed 9c 28 c6 9b 81     ....d..N...(...
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 23 time 15360 ssrc 1
      0000: 05 9c b9 35 1a 42 23 32  21 43 23 32 21 57 4e 72  ...5.B#2!C#2!WNr
      0010: 28 6b 5b 89 f5 63 c6 2e  ee b1 90 ba 34 a1 78 77  (k[..c......4.xw
      0020: 5a c7 48 a3 13 d3 99 09  e8 64 a2 cd cc aa b3 78  Z.H......d.....x
      0030: 66 64 6a 4d a8 cb ab 38  8f 64 4d ab e8 da b1 8b  fdjM...8.dM.....
      0040: b2 8d 57 64 ed 81 5d 9a  43 d3 84 2c 46 ce 8a 24  ..Wd..].C..,F..$
      0050: e0 c9 33 58 36 8a bd 5d  cb 50 be b4 d4 6e b6 98  ..3X6..].P...n..
      0060: 7d ce ac a1 67 75 52 66  50 d5 ba a6 24 25 a6 a8  }...guRfP...$%..
      0070: 34 4e 29 b6 0a 24 69 9c  b9 35 42 32 23 32 22 42  4N)..$i..5B2#2"B
      0080: 23 22 22 66 23 71 51 ab  8e a9 f3 1c 0a 8d d3 85  #""f#qQ.........
      0090: 41 58 91 51 b2 9a 22 0a  46 d4 1f 08 92 4c 59 b8  AX.Q..".F....LY.
      00a0: c9 fb 18 d1 1e 49 d8 8a  41 bb 60 b4 4e b2 22 d1  .....I..A.`.N.".
      00b0: e6 cd 9d 6d 42 93 6a a8  0e da 6d 4a d2 55 95 32  ...mB.j...mJ.U.2
      00c0: ca 2a fe c2 69 29 52 da  d7 2e 1b 72 8c 35 18 a3  .*..i)R....r.5..
      00d0: 76 a3 43 4e 2a d4 fa a4  d8 83 a4 c6 a0 e0 aa d6  v.CN*...........
      00e0: 36 41 b5 5f 4c 26 b5 ad  51 0c 19 ce b1 9c b9 35  6A._L&..Q......5
      00f0: df 31 22 22 21 42 33 32  21 9d 48 dd 54 db b3 79  .1""!B32!.H.T..y
      0100: 24 a4 92 95 21 98 49 34  6d 13 62 ca a9 3c 34 54  $...!.I4m.b..<4T
      0110: 2f e7 56 dc 64 b8 35 fb  c3 a8 33 82 de 0b e8 ec  /.V.d.5...3.....
      0120: d5 1b 70 b0 2e 94 ec a4  c7 81 88 fa 7a 10 56 52  ..p.........z.VR
      0130: 4a 13 c4 3b 46 3a 29 14  fe 66 8b a5 31 8d 47 e6  J..;F:)..f..1.G.
      0140: f8 d8 4a 67 68 91 76 86  d0 d2 cc 95 0a c3 a4 8b  ..Jgh.v.........
      0150: 96 51 a5 ed a9 56 d8 f2  85 73 2a ed ba 83 a3 8c  .Q...V...s*.....
      0160: 97 68 48 9c b9 35 02 32  23 22 21 42 23 22 31 4e  .hH..5.2#"!B#"1N
      0170: 6e 9a 4c ed 54 98 e2 6e  ca 75 8d c2 c0 7a 7a c1  n.L.T..n.u...zz.
      0180: b7 ef b4 7c 43 86 9b 59  89 ca c2 93 19 d9 59 82  ...|C..Y......Y.
      0190: 37 14 ed 8b 46 5b 49 72  65 6e 2e 04 9b a3 bb 8a  7...F[Iren......
      01a0: 69 7a 72 5b 3c 95 db 50  94 36 dc 70 ec da e7 41  izr[<..P.6.p...A
      01b0: a5 29 02 86 56 68 ae 16  6d 39 20 9f 84 4d b4 f1  .)..Vh..m9 ..M..
      01c0: 8d 55 2e c1 11 92 fa 91  c2 e6 52 72 16 5a 34 4a  .U........Rr.Z4J
      01d0: e5 04 6d c1 bb 0b b2 98  4b 9c b9 35 2c 42 33 22  ..m.....K..5,B3"
      01e0: 11 43 23 22 21 43 68 ed  a6 e4 a4 6a 5a aa 90 26  .C#"!Ch....jZ..&
      01f0: fd 5b 52 bb b8 88 d7 38  1b 0d 9e 53 57 b9 31 9b  .[R....8...SW.1.
      0200: e2 f4 c9 0d ea 42 31 78  57 14 ee ac d5 3b 3b e6  .....B1xW....;;.
      0210: 19 c3 94 8a 46 1d 30 db  93 ad 6f 6b 02 25 61 19  ....F.0...ok.%a.
      0220: c6 1b 96 c8 92 ee f2 1f  c9 ca 93 58 56 2a c4 de  ...........XV*..
      0230: 1b 12 95 58 05 32 e7 e8  86 24 e6 29 18 3a e3 ec  ...X.2...$.).:..
      0240: e7 56 3b 42 d0 29 9d 34  91 d1 e1 b5 aa a2 71     .V;B.).4......q
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 24 time 16000 ssrc 1
      0000: 05 9c b9 35 f2 32 23 32  21 43 23 32 21 4d 69 9b  ...5.2#2!C#2!Mi.
      0010: 93 ca bb 10 a4 a8 98 a5  c9 53 00 05 28 d2 6e e5  .........S..(.n.
      0020: 1c fd 22 50 b3 72 3a 59  7f 11 e5 eb 42 ba c3 0c  .."P.r:Y....B...
      0030: d5 aa 5d 56 14 d3 27 2d  4a a0 85 a5 a6 b1 11 59  ..]V..'-J......Y
      0040: 95 4e 4e 1e 19 0e cc 3b  64 2e 0e 9c e5 55 d3 9d  .NN....;d....U..
      0050: 49 88 d6 70 97 12 28 f2  28 a1 76 55 52 54 a5 a4  I..p..(.(.vURT..
      0060: cb 85 30 af 73 69 aa 5f  29 46 3f 87 6d 6f 8f 48  ..0.si._)F?.mo.H
      0070: 33 a0 aa 83 b7 16 74 9c  b9 35 ac 32 23 32 10 43  3.....t..5.2#2.C
      0080: 23 33 10 46 2d 9b 8f c3  c3 92 32 d3 58 9e 0e 1b  #3.F-.....2.X...
      0090: 19 a5 96 95 30 97 13 0b  42 96 b5 79 54 d7 da 55  ....0...B..yT..U
      00a0: b5 eb 0a 36 9e 1e ed 8b  5e d9 b4 d3 96 75 4a f0  ...6....^....uJ.
      00b0: b2 23 ae 27 09 55 e5 c5  3e 45 2f 15 b9 23 85 e7  .#.'.U..>E/..#..
      00c0: 63 5b 0c f0 9a 97 0c 56  95 e6 e4 e2 0e 42 18 9b  c[.....V.....B..
      00d0: c0 68 d1 e1 9a b1 0b c1  a6 93 4a ac 45 dd 52 26  .h........J.E.R&
      00e0: 57 67 70 6a e2 d1 b3 c1  c4 4b 17 37 6d 9c b9 35  Wgpj.....K.7m..5
      00f0: 23 32 23 32 21 42 23 33  21 5d c8 dd 54 b8 9b 49  #2#2!B#3!]..T..I
      0100: 73 2e aa 7e 35 95 4b 74  b4 83 b0 36 92 ea 2b a1  s..~5.Kt...6..+.
      0110: 2b 8b 92 99 ed 65 45 dc  4c 26 27 24 cd 0a cc 22  +....eE.L&'$..."
      0120: 34 79 4a 4e 3f 2f 66 25  e4 b9 8a 5b 97 64 66 ce  4yJN?/f%...[.df.
      0130: 95 11 bc c9 85 26 b0 cc  ec 56 ab 9b 72 88 95 b2  .....&...V..r...
      0140: ce 98 4b 33 b6 a3 31 86  93 d6 5e 34 de 4b 47 22  ..K3..1...^4.KG"
      0150: f2 ed a7 da dd b2 79 37  69 52 d0 e8 d3 d4 33 62  ......y7iR....3b
      0160: d7 75 4d 9c b9 35 a4 32  32 21 11 42 22 33 20 3c  .uM..5.22!.B"3 <
      0170: 19 e2 93 8a dc 89 6c f1  a0 6d a5 ab 49 f7 16 52  ......l..m..I..R
      0180: 6f 21 53 0b 98 db 31 23  34 d9 55 d9 62 1d 31 a8  o!S...1#4.U.b.1.
      0190: 2a b0 8e 26 65 d5 48 73  a9 01 3a 6a 8d 06 aa 2a  *..&e.Hs..:j...*
      01a0: 11 f9 75 89 45 1d 29 10  b3 3c 6c b4 f5 32 bf 06  ..u.E.)..<l..2..
      01b0: 54 0d 68 0b 84 b0 e4 ca  4a 33 92 1b 86 52 d4 f1  T.h.....J3...R..
      01c0: 48 44 dd 93 36 93 8a c4  22 71 9c b6 3d 5c 50 7e  HD..6..."q..=\P~
      01d0: cd 8d ce b2 e5 e3 73 2e  8d 9c b9 35 8c 32 23 22  ......s....5.2#"
      01e0: 20 43 23 32 21 2e e2 30  8f be 3b 69 6e 4e d8 7d   C#2!..0..;inN.}
      01f0: 65 db 4b 78 74 e3 ee 8c  9a e9 2d 36 b5 52 a7 58  e.Kxt.....-6.R.X
      0200: d5 16 a5 dc 4a 54 9e 8e  c9 a7 d6 19 b0 09 79 d1  ....JT........y.
      0210: 26 63 2d 85 a9 b3 4a 19  75 a9 1d cd d9 15 c0 c5  &c-...J.u.......
      0220: 65 ab a9 8d 2d e8 9b 59  4e 46 d5 2d 46 da 8b 33  e...-..YNF.-F..3
      0230: c4 21 98 78 50 f1 9e 54  ec 42 bc 96 70 50 a8 59  .!.xP..T.B..pP.Y
      0240: cb 07 38 47 81 8a 8c 95  2d d4 24 72 18 76 6a     ..8G....-.$r.vj
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 25 time 16640 ssrc 1
      0000: 05 9c b9 35 26 32 22 22  21 42 23 32 21 45 5d 8a  ...5&2""!B#2!E].
      0010: 92 95 3a 29 6a c0 58 6e  6c 91 45 77 08 a2 2c 28  ..:)j.Xnl.Ew..,(
      0020: dd 19 45 44 af 37 98 d9  5e 58 b1 aa 5b b6 0f 27  ..ED.7..^X..[..'
      0030: 12 a8 e1 1d d4 08 77 64  3f bc a8 a5 93 b0 4a 13  ......wd?.....J.
      0040: 59 29 3e 8a 4c 55 db b9  8d 71 28 c8 fd 0e 1a 19  Y)>.LU...q(.....
      0050: 80 a0 a4 2e 70 dc 6e 44  46 23 8a 96 83 5d 31 38  ....p.nDF#...]18
      0060: fb 46 35 06 a3 c9 a7 e0  e5 36 94 66 6d 6e aa ea  .F5......6.fmn..
      0070: 28 c4 39 4a b2 56 69 9c  b9 35 da 33 23 32 20 43  (.9J.Vi..5.3#2 C
      0080: 23 32 20 35 8e eb 4c b9  dd 6a ab 29 1a 75 e9 9b  #2 5..L..j.).u..
      0090: 8d 7f 68 d4 b5 0b 23 19  d0 cd 2f 90 29 68 dc 96  ..h...#.../.)h..
      00a0: 01 3b a2 c0 0a e6 68 a7  5e 0d a4 58 16 72 3e c8  .;....h.^..X.r>.
      00b0: a9 45 bb 34 29 97 55 6d  9e 55 9c 59 bd 34 4e 76  .E.4).Um.U.Y.4Nv
      00c0: ce d8 fe 9d dc 13 64 74  55 24 ce 94 2c 1b 97 27  ......dtU$..,..'
      00d0: 5a 52 62 d4 dd 24 bc 2b  a8 9b 0e e9 47 5a 9d 2a  ZRb..$.+....GZ.*
      00e0: 98 88 69 7e ae ec 48 ba  3b 4b b6 97 66 9c b9 35  ..i~..H.;K..f..5
      00f0: c8 43 23 22 31 42 23 32  32 56 f1 a1 11 d9 10 6b  .C#"1B#22V.....k
      0100: 34 90 48 4e 28 74 4a a3  89 a3 6c 54 d3 26 33 6d  4.HN(tJ...lT.&3m
      0110: b7 75 b4 d8 f0 db 6a 1b  51 24 a5 66 e3 86 42 70  .u....j.Q$.f..Bp
      0120: c5 b8 d7 94 33 23 6e 27  5d b8 d2 36 a3 69 82 ea  ....3#n']..6.i..
      0130: 06 9b 94 d4 4c 77 a9 43  06 d6 a1 1c c0 c9 a5 e5  ....Lw.C........
      0140: d4 d4 b5 ea ce 21 59 c7  05 6c e5 64 8b 8d b5 3d  .....!Y..l.d...=
      0150: 7a 8d 68 cd 8b 32 fb b6  f3 96 db 79 cd 51 28 e3  z.h..2.....y.Q(.
      0160: 1a d4 70 9c b9 35 c1 42  23 33 31 43 33 33 22 57  ..p..5.B#31C33"W
      0170: 51 16 8d b3 85 8a bc 0d  b8 76 5a 4d 51 b4 31 a4  Q........vZMQ.1.
      0180: 2c d5 6b 1d db 6d b7 96  93 97 24 9b 4d ca b6 d0  ,.k..m....$.M...
      0190: b1 36 d3 89 61 b4 e5 8c  a6 5b 3b 45 96 a9 fa 34  .6..a....[;E...4
      01a0: a2 59 71 19 67 55 b0 d1  cb 8c cd 10 75 27 04 db  .Yq.gU......u'..
      01b0: 69 4d e5 8e 12 f2 e2 82  a4 d4 69 9f 66 d3 13 e6  iM........i.f...
      01c0: 62 8c db a6 e3 33 26 cb  89 61 54 e2 aa bc a3 92  b....3&..aT.....
      01d0: ce a8 cd 5e c6 e2 d4 6d  38 9c b9 35 4f 43 23 32  ...^...m8..5OC#2
      01e0: 22 43 23 22 21 43 14 da  63 b5 22 32 d7 17 02 1b  "C#"!C..c."2....
      01f0: 70 d9 5b b1 b4 58 cb 96  d3 1f 15 b6 8b ed 36 c7  p.[..X........6.
      0200: ec 4d d1 66 ed b8 97 a4  89 c8 f7 74 c9 5b 42 a1  .M.f.......t.[B.
      0210: 4e c5 30 ac e6 0c 62 5e  19 ac 8f 48 5b 56 73 4b  N.0...b^...H[VsK
      0220: ac b6 37 2a c1 54 ad 52  ba c3 21 2a b4 12 b4 d5  ..7*.T.R..!*....
      0230: 10 2a 51 b2 05 38 86 35  2a ac c6 b1 78 49 4a 97  .*Q..8.5*...xIJ.
      0240: ed aa ab 44 48 63 a3 84  4a 62 24 8a 75 db ac     ...DHc..Jb$.u..
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 26 time 17280 ssrc 1
      0000: 05 9c b9 35 ee 33 23 33  21 43 33 32 20 36 5e 5b  ...5.3#3!C32 6^[
      0010: 50 c3 52 a9 f2 b8 5e 8d  de 89 85 86 74 91 6e ce  P.R...^.....t.n.
      0020: 8b 79 c4 aa b7 65 99 96  f2 61 a1 de 2e 2a 97 2f  .y...e...a...*./
      0030: 89 a8 e9 21 30 18 3b 6d  32 e5 2e 23 c2 41 51 19  ...!0.;m2..#.AQ.
      0040: 57 6c 65 5a 13 59 c2 bc  95 f0 f8 8a f5 a5 93 51  WleZ.Y.........Q
      0050: 7d 62 84 ec ce a0 19 b5  4a 23 88 87 01 56 dd b9  }b......J#...V..
      0060: 0a a3 56 ba d1 2d 4d 6d  d6 42 74 b4 6e 76 ce b1  ..V..-Mm.Bt.nv..
      0070: c8 bc aa 81 d5 77 50 9c  b9 35 ed 42 23 32 20 42  .....wP..5.B#2 B
      0080: 23 32 21 4e d5 12 07 e9  d3 61 d4 64 c8 3a e8 62  #2!N.....a.d.:.b
      0090: 97 90 2c a9 f7 53 1b 36  74 e3 61 a6 1a 96 2c ee  ..,..S.6t.a...,.
      00a0: da af 82 46 9b b8 52 e3  3e a5 11 3e 02 28 ab 90  ...F..R.>..>.(..
      00b0: 46 ac 47 4d a5 09 e2 54  8e cd 29 8d 6c 1b 2b d6  F.GM...T..).l.+.
      00c0: 55 71 7a c8 6a 1d 9a bb  0a 38 68 e8 8e 1e 0a 51  Uqz.j....8h....Q
      00d0: c3 b3 64 ab 2f 02 67 19  94 2d aa 94 d6 31 31 46  ..d./.g..-...11F
      00e0: 8b 3c 2c b7 a4 8d 2b f5  de 34 ec ba 91 9c b9 35  .<,...+..4.....5
      00f0: 5a 43 22 32 22 42 33 22  31 3a ef b6 05 e0 c8 d1  ZC"2"B3"1:......
      0100: 93 6d 85 3e c9 d6 ce c4  ad a2 38 71 a3 04 e3 94  .m.>......8q....
      0110: 5f b4 69 b6 6d 02 92 94  63 8d b1 66 e9 13 68 dd  _.i.m...c..f..h.
      0120: 31 7b 3b 58 93 78 ea 4b  5e a7 11 28 47 5b 7a c0  1{;X.x.K^..(G[z.
      0130: b6 ad 51 96 e3 37 6d c9  4a 6d b6 8f b3 2d a9 99  ..Q..7m.Jm...-..
      0140: 89 94 ae 21 71 4f d3 6d  a2 32 ce 08 44 5a a5 b1  ...!qO.m.2..DZ..
      0150: 56 9b 25 30 9d d1 db b6  ca 29 85 23 4b 65 14 d8  V.%0.....).#Ke..
      0160: df b0 0c 9c b9 35 9e 43  23 33 21 42 23 32 21 2a  .....5.C#3!B#2!*
      0170: d8 69 43 e5 4b 09 d6 87  49 2a 82 c9 97 aa ba 6a  .iC.K...I*.....j
      0180: b3 76 9a fc a2 5b 5a ab  c9 15 75 8e a2 8f 0a 28  .v...[Z...u....(
      0190: 9b 78 66 c1 b9 4c e5 5b  23 a4 9b 75 65 25 54 65  .xf..L.[#..ue%Te
      01a0: c4 bb c3 48 7a d7 8a 2c  da 2b 8b 79 49 45 5a 4c  ...Hz..,.+.yIEZL
      01b0: d8 57 a6 4b 91 d4 97 0a  9d cb 1b 10 ba 67 02 ab  .W.K.........g..
      01c0: 70 62 45 69 a6 b5 79 76  d5 69 11 a5 bc 9c b6 af  pbEi..yv.i......
      01d0: 61 6d a8 66 a0 a4 cd a2  71 9c b9 35 57 43 23 32  am.f....q..5WC#2
      01e0: 21 42 22 32 21 36 6d 35  27 40 dc 6a 17 93 a6 1f  !B"2!6m5'@.j....
      01f0: 54 68 56 ba 93 61 99 55  1b 04 a9 d2 9d db 24 e5  ThV..a.U......$.
      0200: ee eb 4c a7 28 52 a5 73  76 92 ec 26 29 4a 22 38  ..L.(R.sv..&)J"8
      0210: 9b 0c 0f 28 60 cf 40 cd  99 81 7a ec b2 2f 64 cc  ...(`.@...z../d.
      0220: 6b 77 39 6a 6a 68 e2 96  d1 a4 09 9e 56 ca 86 22  kw9jjh......V.."
      0230: 15 8a c6 34 e4 ec d0 b2  4c 0e 1f 3f 6c 76 85 65  ...4....L..?lv.e
      0240: 2d 32 0b 8b 22 a9 61 4d  2a 61 12 20 eb b8 64     -2..".aM*a. ..d
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 27 time 17920 ssrc 1
      0000: 05 9c b9 35 70 43 32 33  21 43 32 32 21 4f 6d 4d  ...5pC23!C22!OmM
      0010: a6 e9 e3 4a 36 5b 30 27  29 cc 17 bc 34 6a 77 98  ...J6[0')...4jw.
      0020: cb 1d 99 5a 5f ba 26 95  6f 10 9a a5 99 36 a7 76  ...Z_.&.o....6.v
      0030: 7c 52 2a 92 94 dc c1 c5  0b a7 71 4e 5d e5 25 3d  |R*.......qN].%=
      0040: b4 51 8a aa ed 0d d9 8b  23 b7 c4 74 4e d6 d5 14  .Q......#..tN...
      0050: b3 db 6a 59 37 0a 7d 64  59 0e b3 a6 43 eb 31 5a  ..jY7.}dY...C.1Z
      0060: 75 a1 b6 a9 67 54 d5 2e  e5 86 9a 3a 37 3b 27 71  u...gT.....:7;'q
      0070: c9 61 55 a1 0a c1 60 9c  b9 35 db 32 23 32 21 42  .aU...`..5.2#2!B
      0080: 23 22 21 06 25 0b 8a ab  a1 90 64 ad 10 4c 61 72  #"!.%.....d..Lar
      0090: 11 94 77 04 b2 8e e8 e9  c2 28 3d 34 72 c2 e9 1d  ..w......(=4r...
      00a0: b4 fc 23 34 b6 08 cc a8  e2 10 a5 14 67 2d 52 ed  ..#4........g-R.
      00b0: 01 a6 ed cb 89 79 9b 6c  6e 42 1b 9a 9c 41 92 68  .....y.lnB...A.h
      00c0: ee 82 a4 09 c9 40 c7 f6  92 78 f4 d4 28 e4 26 a1  .....@...x..(.&.
      00d0: 5f a2 a2 ce 25 a1 3b 3e  36 57 13 26 ce de 1c 59  _...%.;>6W.&...Y
      00e0: d4 77 6d 56 92 a5 24 bb  cb 42 17 77 88 9c b9 35  .wmV..$..B.w...5
      00f0: 27 32 23 32 22 43 23 33  22 3c b2 ad 0a 9b 95 a0  '2#2"C#3"<......
      0100: a8 5b a2 5d dc 70 61 28  db 56 2b 93 6b 6a 45 22  .[.].pa(.V+.kjE"
      0110: 3d 38 a4 42 56 b8 88 eb  b7 19 1e f1 37 86 de 16  =8.BV.......7...
      0120: f0 54 45 86 32 c9 42 ca  b8 30 a2 b9 0a 24 e4 a9  .TE.2.B..0...$..
      0130: 72 6a ab 2d cc 6d 1c 48  be 1a 6d 09 b6 93 53 f0  rj.-.m.H..m...S.
      0140: 8a 6a ab b3 1c a1 86 a4  93 d1 b4 44 fc a6 d2 d6  .j.........D....
      0150: ae 32 b0 65 b4 97 52 89  c5 7a ed 36 a5 aa 6d a9  .2.e..R..z.6..m.
      0160: f8 51 b5 9c b9 35 4e 43  33 22 21 42 22 22 21 6e  .Q...5NC3"!B""!n
      0170: 50 a5 ca c6 90 91 d7 87  46 27 0e d2 5e bc 3b e2  P.......F'..^.;.
      0180: fb 46 b9 5c da 63 a3 90  b6 a5 ee ec 8c 5d 55 a7  .F.\.c.......]U.
      0190: 29 67 86 c4 30 5a 31 5b  25 94 27 80 c4 8d 5e 99  )g..0Z1[%.'...^.
      01a0: 55 0b e0 31 9e c7 46 0f  64 33 a3 b6 66 6d 57 2e  U..1..F.d3..fmW.
      01b0: 93 95 c3 cb 69 d6 08 d2  a5 9e 1a 4d d1 36 95 f4  ....i......M.6..
      01c0: cf a2 97 4d dc c7 a9 28  e6 be 81 b9 ea c3 c6 af  ...M...(........
      01d0: b6 39 8b d5 96 35 7d 38  6d 9c b9 35 11 42 23 32  .9...5}8m..5.B#2
      01e0: 31 43 13 32 31 5e c8 d4  68 5d 37 52 bd 75 0b 3e  1C.21^..h]7R.u.>
      01f0: c5 44 a3 cc 25 1b 77 2d  a7 25 91 b2 e0 bb 51 45  .D..%.w-.%....QE
      0200: 72 84 a4 ae 21 45 9d 91  30 33 6c d5 49 8c 8a 9d  r...!E..03l.I...
      0210: a5 42 9d 8e e0 d4 ad 4c  04 f3 a6 6c db 91 54 b4  .B.....L...l..T.
      0220: 1b 18 94 d1 4e e5 96 9b  c9 d6 e2 96 35 ba be 29  ....N.......5..)
      0230: 99 0d c6 85 46 77 75 34  a7 0d 4c c9 88 8c 38 b0  ....Fwu4..L...8.
      0240: e4 2e 19 bb 66 39 84 9d  6a 62 9b 2d 0b 95 43     ....f9..jb.-..C
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 28 time 18560 ssrc 1
      0000: 05 9c b9 35 e5 32 22 22  32 42 23 22 22 2d a2 2d  ...5.2""2B#""-.-
      0010: a7 da 71 a9 ea dc 50 3a  5a 85 1f 38 d1 73 93 59  ..q...P:Z..8.s.Y
      0020: 6d 3b b6 4c 21 95 09 82  4d 4c d4 5d 07 4b 0e cd  m;.L!...ML.].K..
      0030: 98 c3 ad 2a e1 b5 82 b2  ad 4d 6a a9 a3 15 b5 58  ...*.....Mj....X
      0040: c1 d4 bc 99 ae 31 4b 71  2a 31 1c 91 4f 5b 89 0b  .....1Kq*1..O[..
      0050: 18 13 69 f4 db 62 4b 61  2a 51 aa 5d 52 4c 96 da  ..i..bKa*Q.]RL..
      0060: 8c b3 22 ea cc ba 59 31  35 05 b4 8d 48 ab 56 28  .."...Y15...H.V(
      0070: a1 cb 6d c4 9c 89 b5 9c  b9 35 6e 32 32 32 20 42  ..m......5n222 B
      0080: 22 32 21 1d 1d 99 0d aa  9a 48 ec e4 88 75 cc 13  "2!......H...u..
      0090: 1b 96 93 08 2c ac c9 0c  2c a2 af 32 98 15 49 f5  ....,...,..2..I.
      00a0: 51 18 c9 d6 93 ac 8d 45  f1 dc d4 39 27 6c 1b 02  Q......E...9'l..
      00b0: 09 0b cb 53 6a 76 87 8e  c5 9e 13 a4 a1 e3 71 ee  ...Sjv........q.
      00c0: d8 c4 9d 29 22 4f 47 54  a4 e1 50 5a 2b d5 b5 0d  ...)"OGT..PZ+...
      00d0: 9d d6 64 d2 65 35 3b 34  26 56 6e 75 32 49 6e bd  ..d.e5;4&Vnu2In.
      00e0: b8 7a 6a 5a d8 c9 e6 cb  4a 42 96 6a 4d 9c b9 35  .zjZ....JB.jM..5
      00f0: 8d 42 22 22 20 43 23 22  21 5b 2c 4d 08 dd db 42  .B"" C#"![,M...B
      0100: 76 96 85 2e 9a b0 60 f1  2b 63 ba 29 1a ed 1c ee  v.....`.+c.)....
      0110: 97 b3 83 a4 b4 ca 10 75  cd d2 a7 7a 08 d3 6b ea  .......u...z..k.
      0120: 91 1b 00 da 97 60 0e 2d  5a 41 15 ab 39 a1 ab ce  .....`.-ZA..9...
      0130: 61 32 62 d1 8b 93 28 46  3a 72 e9 d5 da 39 49 57  a2b...(F:r...9IW
      0140: a8 52 d4 9e 5b 91 b9 b6  e3 6c ae 4c 95 99 86 d3  .R..[....l.L....
      0150: 78 50 e8 ad a8 39 af b6  47 2b 77 71 c9 55 49 00  xP...9..G+wq.UI.
      0160: ea 1b 61 9c b9 35 97 32  23 33 31 43 23 32 31 3d  ..a..5.2#31C#21=
      0170: ca a2 cd b1 46 58 27 71  24 5d e1 a2 a7 79 8d c9  ....FX'q$]...y..
      0180: f0 ce 39 3d c3 51 b3 76  69 b3 c5 eb 6c ba ac 66  ..9=.Q.vi...l..f
      0190: 16 7d 5b 06 5a a3 44 00  f6 d3 22 b1 51 6e ba b9  .}[.Z.D...".Qn..
      01a0: 5b 77 96 eb de 4c b2 dd  c9 26 11 33 29 c8 56 5d  [w...L...&.3).V]
      01b0: 3a cf 76 51 a3 ed 09 b4  6c 99 6d 17 7b 4d 26 c5  :.vQ....l.m.{M&.
      01c0: 0d 91 b9 c9 d1 d3 28 a3  2e ec 9c 65 1b 64 d3 46  ......(....e.d.F
      01d0: ca 99 67 bc 26 62 57 74  c3 9c b9 35 26 42 22 32  ..g.&bWt...5&B"2
      01e0: 31 43 22 32 21 53 b0 20  69 e2 cc 4a 55 00 ec 36  1C"2!S. i..JU..6
      01f0: e6 1c 64 e1 a6 9c 1b 32  c9 26 da 16 d8 c2 c4 d4  ..d....2.&......
      0200: ec ed a6 6d e1 b6 ab 58  26 a4 2f 68 c0 88 35 65  ...m...X&./h..5e
      0210: 8b 26 cc 2e c6 22 45 2b  a3 64 a2 f3 53 50 5d 22  .&..."E+.d..SP]"
      0220: 4b 57 a8 e2 5e ef 15 17  bb d7 1a 57 38 e2 7f 29  KW..^......W8..)
      0230: b2 cc cc c4 95 e2 f5 c6  a6 2b 43 47 55 8e b8 6f  .........+CGU..o
      0240: 0d e6 1a c1 49 b1 6c 69  28 62 25 30 aa ec 86     ....I.li(b%0...
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 29 time 19200 ssrc 1
      0000: 05 9c b9 35 ee 42 23 23  31 42 33 32 31 3a 36 b3  ...5.B##1B321:6.
      0010: 62 ce 28 da 15 84 8b 26  f1 b2 a5 ac 1d 1c 14 86  b.(....&........
      0020: 75 26 21 d6 db c3 95 a4  fe ab 26 66 12 6a 29 42  u&!.......&f.j)B
      0030: 5a 93 e8 5d e9 4a ea cc  97 1a a5 2d ea 89 a9 9c  Z..].J.....-....
      0040: 42 aa 86 e0 b3 31 e8 bb  92 16 75 5a 2b 8d b6 57  B....1....uZ+..W
      0050: c5 aa 9a 97 6d a4 86 24  c7 09 e3 4e 46 2d 0c b8  ....m..$...NF-..
      0060: 7d 5b 46 4f 21 8d a7 a2  db 49 bc 91 6c a9 64 9c  }[FO!....I..l.d.
      0070: 29 65 50 70 d9 b4 9b 9c  b9 35 47 43 23 23 21 43  )ePp.....5GC##!C
      0080: 22 23 22 53 05 0c 4c b5  c2 29 f7 a8 9a 45 a4 6d  "#"S..L..)...E.m
      0090: 68 ba c2 99 2c e8 6b 0d  e2 28 ad 6d 8d 15 32 ae  h...,.k..(.m..2.
      00a0: 29 1d b8 92 ad 72 69 a9  58 d3 04 cb 6b ae 16 b6  )....ri.X...k...
      00b0: 47 32 4e 61 63 76 98 29  9a a4 9c 24 b2 6d aa 77  G2Nacv.)...$.m.w
      00c0: 67 5a 6e 0b 8d 53 dc 2a  d4 72 dd 4a b5 1d d6 9f  gZn..S.*.r.J....
      00d0: 75 2b 85 71 85 45 0c 34  21 55 4b 39 4f d9 9e 61  u+.q.E.4!UK9O..a
      00e0: bc b3 72 53 2e 98 c8 59  8c 29 b4 62 14 9c b9 35  ..rS...Y.).b...5
      00f0: 4b 42 23 33 30 42 22 33  31 3a 72 9b 62 e1 16 da  KB#30B"31:r.b...
      0100: 36 93 1b 36 b4 48 e5 9c  27 23 94 85 38 c5 5d b6  6..6.H..'#..8.].
      0110: 92 c2 71 a3 b5 65 34 7d  60 4d 23 ab 65 a3 6b 19  ..q..e4}`M#.e.k.
      0120: 68 da ac 49 85 b5 5b 72  d5 dc 49 aa c5 0b 9a 94  h..I..[r..I.....
      0130: d3 8e d1 d6 e2 9b 38 a4  37 cd a8 db c1 a4 d2 33  ......8.7......3
      0140: 69 b6 9c 5e 26 4a b4 86  17 74 f5 34 c5 a6 85 cf  i..^&J...t.4....
      0150: 5e 8d 46 e3 a2 71 ba bb  6a 21 64 a2 69 66 5c 0c  ^.F..q..j!d.if\.
      0160: 5c c9 0c 9c b9 35 23 43  22 32 21 43 22 22 21 3a  \....5#C"2!C""!:
      0170: b3 8a 22 cb 63 29 f7 48  69 2a ec cb a6 b9 a2 c4  ..".c).Hi*......
      0180: 18 26 28 cd 69 5a 95 ad  34 55 ae 7c e2 5d cf ba  .&(.iZ..4U.|.]..
      0190: bd 67 16 a4 6e e2 b4 fb  42 46 9d 56 6c ae 5e 10  .g..n...BF.Vl.^.
      01a0: b5 9c d3 2c 9e ee ac af  da 59 42 57 5a 51 2e e8  ...,.....YBWZQ..
      01b0: cb 94 ac cc 2a 56 a7 0a  7e 9c 99 4b c9 a8 d6 f1  ....*V..~..K....
      01c0: 24 e4 b6 5c 12 cf 15 07  58 6a 49 a5 1d 02 a0 1f  $..\....XjI.....
      01d0: 70 49 ac 5b 01 95 0b b8  6c 9c b9 35 33 33 22 32  pI.[....l..533"2
      01e0: 21 43 22 33 21 0e 65 94  0f c5 e2 62 6e 10 e8 9d  !C"3!.e....bn...
      01f0: ce 5c 2f 43 66 c8 2c ce  d8 5d 25 2c 27 97 84 d0  .\/Cf.,..]%,'...
      0200: 62 a3 34 ac 54 e6 9e f3  09 87 5e 9d b0 f7 8c 29  b.4.T.....^....)
      0210: 46 ad 49 2f c2 e3 63 98  54 6c 85 8c 9b 19 c2 a2  F.I/..c.Tl......
      0220: 89 2d 94 9c 5d ee 9b 41  79 d8 d3 6d d9 12 1c 13  .-..]..Ay..m....
      0230: 25 1d 73 56 e5 ea 02 09  2c 58 c7 4a 0c 74 8e c1  %.sV....,X.J.t..
      0240: 52 b5 58 25 85 4b 20 ad  22 d3 bb 41 fb 80 84     R.X%.K ."..A...
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 30 time 19840 ssrc 1
      0000: 05 9c b9 35 a0 42 23 32  32 43 23 32 32 3b 1a 66  ...5.B#22C#22;.f
      0010: 08 32 a1 83 34 d3 4e 51  35 02 a5 aa 1a 83 a6 07  .2..4.NQ5.......
      0020: a0 e6 35 04 90 8d 42 e5  73 34 d8 6b cc b6 29 68  ..5...B.s4.k..)h
      0030: b8 93 99 28 25 2c 07 18  9d 0a a9 ae 44 4d b5 a7  ...(%,......DM..
      0040: 13 71 7e 95 69 ae 25 63  6a 97 8c 6d 3d f3 1b 51  .q~.i.%cj..m=..Q
      0050: 94 cb 49 e8 c3 92 9d 36  dd 4c 72 25 57 e1 55 1a  ..I....6.Lr%W.U.
      0060: ea 11 38 bd 66 2a 97 21  65 95 ec 4a b2 ae da a4  ..8.f*.!e..J....
      0070: a8 e6 4e a0 a7 5b e8 9c  b9 35 33 42 23 32 21 42  ..N..[...53B#2!B
      0080: 23 22 21 36 cb 28 85 c5  a2 83 9c 39 6d 5f a7 14  #"!6.(.....9m_..
      0090: 67 c8 b9 cc 96 36 12 cf  0e 5b 51 e0 51 93 f7 ad  g....6...[Q.Q...
      00a0: 72 5e f1 e6 ad 02 97 c4  30 31 c1 2b 2b a4 a5 c1  r^......01.++...
      00b0: 6c af d9 05 96 0a 99 59  73 b0 93 0c 66 cc e3 17  l......Ys...f...
      00c0: 4a 70 43 09 1b 12 95 ac  69 d2 c5 52 7d c1 62 8b  JpC.....i..R}.b.
      00d0: c1 a8 27 f5 66 94 d6 30  a7 3d 74 68 16 a2 6f a5  ..'.f..0.=th..o.
      00e0: 6d 1b 3a 9d 86 49 aa da  0d a5 4a c2 61 9c b9 35  m.:..I....J.a..5
      00f0: 3a 42 33 32 32 42 33 33  21 4e 11 35 43 67 14 92  :B322B33!N.5Cg..
      0100: b5 49 b3 2f 66 94 21 e3  85 21 fd b8 48 b5 d4 59  .I./f.!..!..H..Y
      0110: a8 54 b5 24 f2 6a 89 27  e1 a6 2d b7 0a 69 bb 74  .T.$.j.'..-..i.t
      0120: b5 4b ba 9b 4c c2 ae 2f  d5 c2 d3 1c db 2c 62 ce  .K..L../.....,b.
      0130: 38 97 66 e3 62 5e 76 56  a5 c9 23 53 c3 8d a4 7c  8.f.b^vV..#S...|
      0140: ba d8 75 d4 71 a5 dd b6  d7 a6 d5 51 66 b1 47 47  ..u.q......Qf.GG
      0150: 66 93 4c 10 69 34 ea b7  5a 4b a3 56 07 e5 bc d2  f.L.i4..ZK.V....
      0160: 7e 93 b0 9c b9 35 56 42  23 32 21 43 23 33 21 53  ~....5VB#2!C#3!S
      0170: 94 aa 25 f1 92 8c 15 93  88 6a ce 63 24 a2 0c 6b  ..%......j.c$..k
      0180: 36 15 1a b4 d1 5c 12 b3  a6 84 b0 8c da 56 4d c8  6....\.......VM.
      0190: 9f 64 5b 13 f0 ae b5 2b  2a 2a 15 73 4a 12 42 d1  .d[....+**.sJ.B.
      01a0: b6 3a e1 8d 4a c9 2d a9  60 9b 69 f1 77 61 36 b0  .:..J.-.`.i.wa6.
      01b0: 91 52 93 2b c9 37 74 e2  95 e5 5a 8a ad 26 f7 b2  .R.+.7t...Z..&..
      01c0: f4 50 ce 5a 94 bb 95 66  26 ee 6d b9 1b 0b 1c 17  .P.Z...f&.m.....
      01d0: 65 4d a3 70 61 a4 7c 8d  49 9c b9 35 9f 42 23 32  eM.pa.|.I..5.B#2
      01e0: 21 42 33 32 21 2e c3 0d  41 c5 9a 12 3f 36 66 33  !B32!...A...?6f3
      01f0: 0c d8 a7 a2 ca 4b d7 68  92 b5 7e 9b 4e 86 47 13  .....K.h..~.N.G.
      0200: 69 71 1a 66 1d d6 9d 73  a4 d2 ac cd c5 4b 53 c8  iq.f...s.....KS.
      0210: 93 68 ad 4f 51 15 d1 7c  b2 65 42 72 72 46 d5 93  .h.OQ..|.eBrrF..
      0220: 59 96 49 68 1f af 1a 51  a3 1d 49 18 53 5a 7f a0  Y.Ih...Q..I.SZ..
      0230: 9b 47 cb 16 c6 f4 e5 0a  9e e0 c0 b5 60 96 a4 ee  .G..........`...
      0240: 91 b5 49 53 c4 1b 47 51  87 de 11 c4 5b c2 91     ..IS..GQ....[..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 31 time 20480 ssrc 1
      0000: 05 9c b9 35 5d 42 22 23  32 42 32 23 32 26 a9 ad  ...5]B"#2B2#2&..
      0010: 20 0a 23 6a d7 0c 8c 59  b7 1b 5e 9a 1d 2b 12 07   .#j...Y..^..+..
      0020: 52 5c b2 5b 0b 31 36 c3  a2 25 0a 53 64 c2 95 88  R\.[.16..%.Sd...
      0030: e8 81 5a 39 35 8b 49 36  97 14 2d af 5b 6d b5 86  ..Z95.I6..-.[m..
      0040: e1 4d 46 5c 8d a6 27 93  68 f8 f2 4d 21 cb 1b 4a  .MF\..'.h..M!..J
      0050: b3 c3 60 49 f3 18 86 24  da 8a 6e 26 a6 e5 56 d8  ..`I...$..n&..V.
      0060: ca 79 b6 35 51 46 e5 92  75 b8 dc 1a 48 18 8d 2e  .y.5QF..u...H...
      0070: 03 db b2 28 46 ec 46 9c  b9 35 69 42 23 32 22 42  ...(F.F..5iB#2"B
      0080: 22 23 22 2e 31 bc 02 cc  76 c3 37 85 82 47 10 49  "#".1...v.7..G.I
      0090: 9e ac 2e 43 b5 49 70 76  1b 50 8a c7 5b 15 25 1b  ...C.Ipv.P..[.%.
      00a0: 08 84 b4 ca 17 48 a4 91  36 a9 24 fb 84 d0 8b 64  .....H..6.$....d
      00b0: 36 ad d5 a6 55 3d 61 a5  4f 51 46 aa e3 69 a9 b5  6...U=a.OQF..i..
      00c0: 8d c4 23 22 8d 0a 9b 4c  90 f4 cb 84 6d 52 8e 0c  ..#"...L....mR..
      00d0: b0 9b 88 ee cb 65 15 c0  d0 ad e4 e1 54 38 ca 91  .....e......T8..
      00e0: 1a 16 9a 99 4d 26 a5 ea  32 d4 7d 50 35 9c b9 35  ....M&..2.}P5..5
      00f0: ba 42 23 22 21 43 23 22  21 3e 2d 2d a1 ce dd 6b  .B#"!C#"!>--...k
      0100: 39 49 2d 4b 23 1b 5f b5  c1 53 b7 84 0a 8d 55 a3  9I-K#._..S....U.
      0110: 49 c9 b8 d4 75 4e e2 7d  ed b4 19 77 88 d0 ac 75  I...uN.}...w...u
      0120: 29 18 3c 18 17 54 8a 2f  5f 1e 91 cb 6b a9 66 6e  ).<..T./_...k.fn
      0130: 8e 09 5e 1c 8a b8 6c 85  3e ad 68 0d a9 d1 89 15  ..^...l.>.h.....
      0140: 46 92 75 16 5b 46 bc ba  c8 f3 4d 1a de 19 d6 39  F.u.[F....M....9
      0150: 66 44 d5 ee c5 c9 6b 3b  54 1f 65 71 a8 d0 e2 45  fD....k;T.eq...E
      0160: 0b a2 a4 9c b9 35 33 42  23 33 20 43 33 32 20 2a  .....53B#3 C32 *
      0170: 8c 8e 02 5e 1c 63 7d 83  8d 4f 30 65 1d c3 3a 73  ...^.c}..O0e..:s
      0180: 17 77 5c 94 65 db 4e 9c  a4 d5 e3 0e da 9c d9 43  .w\.e.N........C
      0190: 19 76 46 c2 f3 25 d0 ef  53 aa a3 a9 4d 51 d5 dd  .vF..%..S...MQ..
      01a0: a1 fa b3 4d 52 ab 09 a9  d9 db 2a 70 96 24 32 ae  ...MR.....*p.$2.
      01b0: da 12 e3 b2 71 9a 76 a2  9d 96 d3 50 ab d9 18 a1  ....q.v....P....
      01c0: ec 68 cd 69 28 af 07 88  c3 e4 cd a5 2c d3 a8 1b  .h.i(.......,...
      01d0: 97 71 8b 5c f5 c9 2a 94  56 9c b9 35 f4 42 32 32  .q.\..*.V..5.B22
      01e0: 21 41 33 23 31 4b 2e ed  87 4c 26 cb 18 69 65 6e  !A3#1K...L&..ien
      01f0: 9e 57 20 b3 3b 23 d2 6e  16 76 95 61 cc e4 6d 34  .W .;#.n.v.a..m4
      0200: 36 b4 da 55 2c ad 9d 68  f6 01 2e 23 31 ba c0 ca  6..U,..h...#1...
      0210: b7 0e 9c 76 dd 8e 36 49  73 9b 72 30 ed a9 73 23  ...v..6Is.r0..s#
      0220: 0a f5 55 8e 4a 15 38 97  bc 1b c9 f6 ef b6 95 d2  ..U.J.8.........
      0230: 29 4f c7 75 49 72 72 6a  de ba 4e 3d 56 34 c6 a0  )O.uIrrj..N=V4..
      0240: 9b 8d 5b b8 39 2d 90 62  48 5d 96 04 e8 75 8b     ..[.9-.bH]...u.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 32 time 21120 ssrc 1
      0000: 05 9c b9 35 33 32 33 32  20 42 22 32 21 0e 25 93  ...53232 B"2!.%.
      0010: 4a ab 93 4d 2c d6 95 2d  a2 d9 5d 27 86 d6 26 fc  J..M,..-..]'..&.
      0020: 70 2c 3b 95 1f 78 84 e5  5d e0 a9 2e 2b 18 9e ad  p,;..x..]...+...
      0030: 2d 88 59 25 95 b8 69 74  72 cf 72 34 ab 3a ab 7c  -.Y%..itr.r4.:.|
      0040: 84 75 4c 9d db 90 a0 c4  49 b4 98 c4 7e 8f 92 4f  .uL.....I...~..O
      0050: 59 64 13 2b 66 82 3c 25  36 a5 60 b5 68 59 dd b1  Yd.+f.<%6.`.hY..
      0060: fc 54 c4 3a c8 ea 2a 54  d9 a4 5d 27 8e 4b 61 0a  .T.:..*T..]'.Ka.
      0070: 23 bc b3 69 98 57 b0 9c  b9 35 08 42 23 32 21 42  #..i.W...5.B#2!B
      0080: 22 32 21 67 04 ec 0a 50  cb 2c 33 62 71 7b 82 16  "2!g...P.,3bq{..
      0090: 62 94 32 6a b8 90 9a 77  19 9b 09 c8 b4 84 a0 cb  b.2j...w........
      00a0: 12 a4 0c 35 25 58 68 e1  f1 0e 46 1b c2 d0 c3 63  ...5%Xh...F....c
      00b0: 31 33 ce e1 45 ee 4b 6d  52 f4 c6 89 da 89 a2 3b  13..E.KmR......;
      00c0: 05 4d 2f a2 92 54 ba 32  21 9d 42 c8 bf 5a a3 50  .M/..T.2!.B..Z.P
      00d0: d2 56 d9 6b 14 98 fd 67  28 29 e2 74 d3 b4 e8 b0  .V.k...g().t....
      00e0: fc 1d 2a 1b 38 a6 88 d6  1d 44 eb b5 6d 9c b9 35  ..*.8....D..m..5
      00f0: 18 32 23 32 20 42 23 32  20 45 0d d6 51 ae 2a ad  .2#2 B#2 E..Q.*.
      0100: 67 14 e9 14 9f 1e 11 87  69 04 b1 6c e2 4a 74 2a  g.......i..l.Jt*
      0110: 17 46 97 80 de 26 94 d9  d3 d0 86 cf 0d a5 48 29  .F...&........H)
      0120: 36 70 7a 66 6e 70 d0 ad  d9 b4 53 9b 16 66 25 a9  6pzfnp....S..f%.
      0130: a0 51 a4 b4 29 33 69 1a  76 29 63 49 23 3b 43 ee  .Q..)3i.v)cI#;C.
      0140: c6 e8 ba a2 4a 2f 93 7a  de 6d c6 c6 3e a0 46 9a  ....J/.z.m..>.F.
      0150: 70 72 c9 49 56 44 99 55  6d 36 ca 71 a2 cd 2c 81  pr.IVD.Um6.q..,.
      0160: fc 44 74 9c b9 35 48 43  33 32 31 43 32 32 31 3e  .Dt..5HC321C221>
      0170: cc a3 66 65 18 dd 55 84  cb 96 64 32 e3 b3 35 1b  ..fe..U...d2..5.
      0180: 75 71 36 66 20 b5 0f cb  09 45 ec 89 16 7d da 49  uq6f ....E...}.I
      0190: ab 89 6d a3 ac e3 4a 3d  95 75 b7 a7 96 72 5c da  ..m...J=.u...r\.
      01a0: a6 5c 28 e9 6a d2 cc 65  e6 b3 1a 97 8a 93 3a 6f  .\(.j..e......:o
      01b0: 12 ce d2 52 89 f8 59 02  ed de 16 dc bb e5 ba 6e  ...R..Y........n
      01c0: d5 28 e5 5e 6a 29 7a 49  b4 33 1a 6d 2d ad 61 9b  .(.^j)zI.3.m-.a.
      01d0: 93 d0 69 45 e3 6d 1a ab  1b 9c b9 35 f6 32 23 32  ..iE.m.....5.2#2
      01e0: 22 42 23 32 22 36 0b 64  8f e8 6c 15 a7 1b 70 ec  "B#2"6.d..l...p.
      01f0: 82 6e 13 86 e4 65 b6 d5  6c 5e b5 2c 17 86 9d 81  .n...e..l^.,....
      0200: 56 16 88 78 e4 d1 0f 09  53 05 e4 aa 62 9a 41 a5  V..x....S...b.A.
      0210: 72 ad 36 b0 92 69 ab 35  49 b5 26 09 4a 49 b2 6d  r.6..i.5I.&.JI.m
      0220: 48 6f 13 4a 45 e1 89 41  a8 eb 50 b4 d5 4a db b4  Ho.JE..A..P..J..
      0230: 9a ad 66 db 5a c0 b6 e5  db 24 9c ab 31 a8 29 dd  ..f.Z....$..1.).
      0240: b4 c4 1c 0c a1 2f 65 94  22 91 86 a8 d8 2c b9     ...../e."....,.
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 33 time 21760 ssrc 1
      0000: 05 9c b9 35 4a 32 23 22  21 43 33 22 21 4d 69 d3  ...5J2#"!C3"!Mi.
      0010: 12 c5 3a 64 23 74 0c f5  e6 42 97 a7 46 55 b0 e8  ..:d#t...B..FU..
      0020: ca 3d 9b c7 13 75 78 e1  72 e9 c0 ac 3c a6 06 f4  .=...ux.r...<...
      0030: e5 c8 d9 dc aa 55 38 a9  4f 69 18 ac da 5a 73 57  .....U8.Oi...ZsW
      0040: 3a 6e 24 f5 f3 91 9d be  70 f6 90 da 95 da 1b 0b  :n$.....p.......
      0050: 95 66 23 aa ee 84 9b 5d  34 23 8a a4 88 49 ca ba  .f#....]4#...I..
      0060: 1b b1 47 0b e6 ed c5 f1  19 39 90 a5 21 3a ce c4  ..G......9..!:..
      0070: a4 bb b3 29 b6 86 61 9c  b9 35 39 43 23 21 22 43  ...)..a..59C#!"C
      0080: 22 22 22 53 2d e1 0c ba  51 a5 72 86 0d 04 a0 69  """S-...Q.r....i
      0090: 90 bc 46 82 f1 51 70 a5  6a 61 15 86 92 24 2b 13  ..F..Qp.ja...$+.
      00a0: 51 2b e1 22 1d 78 9a a2  d9 a6 d6 3c 05 05 5e 84  Q+.".x.....<..^.
      00b0: 56 ae d5 36 ca 77 6d b5  5e ad b5 51 bc 49 aa d7  V..6.wm.^..Q.I..
      00c0: 6c aa 95 a4 0d 50 b3 86  53 2c e0 8a ee 13 6a 39  l....P..S,....j9
      00d0: 44 e3 59 ad 63 05 9b c6  d8 b7 76 d8 27 61 d8 95  D.Y.c.....v.'a..
      00e0: 2b a6 95 2e e9 c4 aa 4e  36 29 96 6d 85 9c b9 35  +......N6).m...5
      00f0: 31 32 22 23 20 42 22 22  21 3e 26 52 4e bf 61 6d  12"# B""!>&RN.am
      0100: e9 29 1a d6 5a 16 45 56  4e d4 2a ad 6a cc e3 f6  .)..Z.EVN.*.j...
      0110: 1f 99 7c 83 e0 e2 58 8c  1b cd 1f 80 e9 8b 54 dd  ..|...X.......T.
      0120: 31 f9 93 8c 77 1c 90 89  ca 2b 8a 72 65 79 2c 94  1...w....+.rey,.
      0130: 8d 0c b3 08 a0 33 2a da  64 e2 14 51 56 5a a3 ae  .....3*.d..QVZ..
      0140: e3 45 0b a1 c4 bb 64 6c  18 d9 28 25 e8 4a b6 8f  .E....dl..(%.J..
      0150: 44 c5 a8 d9 24 24 d7 94  4e 2b 5a a5 a3 8e 62 41  D...$$..N+Z...bA
      0160: f1 9b 28 9c b9 35 8d 42  23 33 22 42 33 32 32 5f  ..(..5.B#3"B322_
      0170: 0c 70 4d b5 13 4c 54 52  62 bc 34 ea 57 b7 14 13  .pM..LTRb.4.W...
      0180: b2 35 0a be bc a0 97 73  3a 93 6d b0 c4 bc 68 b2  .5.....s:.m...h.
      0190: 9d 42 88 a5 41 a3 36 99  8e 34 7e dc 71 8e e1 71  .B..A.6..4~.q..q
      01a0: 93 76 a2 86 66 da 8e 0a  c6 a3 83 76 5c 64 ae 29  .v..f......v\d.)
      01b0: 1a 8f c7 55 42 b5 d5 99  24 e6 c9 31 11 c0 68 64  ...UB...$..1..hd
      01c0: a8 91 d9 4e 06 29 8d ba  a7 5b 6e b9 da 8e 21 56  ...N.)...[n...!V
      01d0: 1b 88 88 6a 6e 28 da da  8d 9c b9 35 ec 32 23 22  ...jn(.....5.2#"
      01e0: 31 42 23 22 31 5d a5 c0  98 c7 ba 55 31 6c 37 0c  1B#"1].....U1l7.
      01f0: f5 a6 cf 43 69 b3 ea 45  c6 6a 31 51 9f 82 45 a4  ...Ci..E.j1Q..E.
      0200: dd cd 2c da 40 a9 a7 24  ab 68 d2 55 4e b6 c5 21  ..,.@..$.h.UN..!
      0210: 76 f4 94 31 82 b2 db 10  46 9b 35 e1 26 cc db a4  v..1....F.5.&...
      0220: 9a 2b 28 44 2e 58 98 8f  28 6d b3 2a 0a 36 fb 6b  .+(D.X..(m.*.6.k
      0230: 49 41 96 8c 28 ed 1c 11  9c 1c c6 0e 6a d4 67 c2  IA..(.......j.g.
      0240: 59 a8 f3 c6 ea 36 7c c4  42 ed 33 12 37 56 6a     Y....6|.B.3.7Vj
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 34 time 22400 ssrc 1
      0000: 05 9c b9 35 c7 33 34 22  21 42 24 22 32 85 5c 58  ...5.34"!B$"2.\X
      0010: a7 6e 1d 85 70 e1 41 bc  6f 22 9b 86 e9 29 eb 78  .n..p.A.o"...).x
      0020: 58 4b 28 90 2e 94 b4 e0  55 bc 68 78 5d d8 0f 29  XK(.....U.hx]..)
      0030: db 4e d0 ed ba 77 6c da  de 26 0d 8b bb 68 25 a8  .N...wl..&...h%.
      0040: 36 15 1e dc 1a 9f e5 eb  68 6e db 00 fc 6d 1b 45  6.......hn...m.E
      0050: 76 ed 27 5a 6a 53 2a b5  ad 46 ca a8 c6 59 ac a3  v.'ZjS*..F...Y..
      0060: b2 96 c4 9a ed d3 13 94  d5 30 b8 66 2a 96 52 11  .........0.f*.R.
      0070: 20 20 68 d1 28 33 6c 9c  b9 35 0b 32 32 32 21 43    h.(3l..5.222!C
      0080: 23 32 20 17 e5 64 4f c7  24 8d a2 d3 12 ed 19 da  #2 ..dO.$.......
      0090: 4b 65 34 c4 6d 0e e0 4d  2c 1c 1d bb 73 84 cc d9  Ke4.m..M,...s...
      00a0: 15 09 24 14 af 2f 46 45  e2 20 d6 16 8e 6c 82 af  ..$../FE. ...l..
      00b0: 4d a9 bb cc 8a 57 8a 4d  4c ed 1a 54 b7 a4 0a 60  M....W.ML..T...`
      00c0: f8 e0 a5 42 d4 47 47 87  22 2c 92 9b 89 b3 24 41  ...B.GG.",....$A
      00d0: 68 47 07 dd a9 c9 9d 24  a7 1b 0f 70 a8 5d de 24  hG.....$...p.].$
      00e0: 99 75 72 3f 0a d6 20 e3  bd 61 97 c8 8d 9c b9 35  .ur?.. ..a.....5
      00f0: 7f 32 33 32 21 42 23 22  20 86 9e 1a 5a dc bb 6d  .232!B#" ...Z..m
      0100: f2 e8 db 04 99 5a 49 66  5a 52 72 ab 42 4c 9c 36  .....ZIfZRr.BL.6
      0110: 99 37 7c 63 d1 92 b4 ec  a2 56 a6 b4 4d 8a e6 49  .7|c.....V..M..I
      0120: b7 f5 74 6c 9b 32 5a 8a  db 2b 6a 5d 15 30 25 25  ..tl.2Z..+j].0%%
      0130: 18 50 bc 92 4a a5 0d 2a  6c d9 e5 4d 77 6a d2 78  .P..J..*l..Mwj.x
      0140: 8d 89 4a 4b 42 3f 77 69  19 d0 dc c5 a9 83 93 26  ..JKB?wi.......&
      0150: b2 ea 29 6d dc 64 33 89  60 3e 89 04 41 c4 39 28  ..)m.d3.`>..A.9(
      0160: dd 67 25 9c b9 35 51 43  32 22 21 43 22 33 22 86  .g%..5QC2"!C"3".
      0170: ee da 55 ab ad 8c b3 7e  e5 04 de 6e 5a b3 5a 63  ..U....~...nZ.Zc
      0180: 6c 34 6a bd ed c3 1d 6c  93 43 ae b5 94 6c 2c d3  l4j....l.C...l,.
      0190: 31 79 65 8a 59 c4 92 4b  33 88 8a c4 b6 49 5d ec  1ye.Y..K3....I].
      01a0: 91 b9 b6 b8 62 ef 2a 4e  bb d5 ca d6 a5 4c 75 a8  ....b.*N.....Lu.
      01b0: 8d 58 ab 18 e3 2a 93 73  35 d8 36 c1 76 13 57 70  .X...*.s5.6.v.Wp
      01c0: c2 a9 ad 11 4a 2d b2 4d  49 e4 36 d5 4b 49 8d 3a  ....J-.MI.6.KI.:
      01d0: d4 39 27 65 d4 68 58 4a  31 9c b9 35 04 43 33 32  .9'e.hXJ1..5.C32
      01e0: 21 43 23 23 21 8e d0 31  2c 5a cc 6b d7 39 ac 62  !C##!..1,Z.k.9.b
      01f0: e6 eb 11 cb ba 11 d7 66  d4 cd 9d 4d 13 b9 94 c3  .......f...M....
      0200: 6f 0c e2 5d e5 28 2d 78  56 54 31 6a 22 6d 3c a8  o..].(-xVT1j"m<.
      0210: c1 a7 85 8c 5e 5d 51 5a  cb 30 4f 2a c9 a8 61 58  ....^]QZ.0O*..aX
      0220: 69 f5 4a 6a 16 d3 13 92  bb 61 2a 56 9c 13 2d de  i.Jj.....a*V..-.
      0230: 1a 24 c3 44 86 ee d0 e2  c5 4e 16 9b 77 a6 22 33  .$.D.....N..w."3
      0240: 12 15 b9 ad b6 a3 30 a9  26 ee 24 b4 6d 7c 30     ......0.&.$.m|0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 35 time 23040 ssrc 1
      0000: 05 9c b9 35 06 43 32 32  31 43 33 33 20 6e c7 ca  ...5.C221C33 n..
      0010: 4e 55 6b 4b d7 45 73 66  ec a4 17 c3 86 e2 58 57  NUkK.Esf......XW
      0020: 1c dd 9d c4 8e bc 38 94  30 e6 88 15 dd 46 bf 34  ......8.0....F.4
      0030: 15 b6 28 a6 b5 bc b9 85  3b b5 69 2d 45 d1 71 29  ..(.....;.i-E.q)
      0040: bb 31 42 92 ac 67 d6 55  4b 17 91 31 3a f4 6c 1a  .1B..g.UK..1:.l.
      0050: bb 83 5a 38 62 a9 25 58  34 dd b3 28 d5 32 ca 16  ..Z8b.%X4..(.2..
      0060: 9e 4d 44 a5 77 0e 43 6e  c6 38 fc 4b 49 9b 7a 69  .MD.w.Cn.8.KI.zi
      0070: a6 e9 a3 4c 2d bb 4d 9c  b9 35 cc 43 23 22 32 43  ...L-.M..5.C#"2C
      0080: 23 32 31 82 d5 28 a5 ae  24 d3 74 50 54 27 4a 18  #21..(..$.tPT'J.
      0090: d2 ba 6e a8 eb 69 e4 ad  dc 76 07 5b aa 42 2e f1  ..n..i...v.[.B..
      00a0: aa 1a e5 50 b5 47 05 62  15 2a ad 8a 38 11 57 a7  ...P.G.b.*..8.W.
      00b0: 13 25 f1 b7 12 7e c4 ea  4e cd c6 93 ee d8 52 55  .%...~..N.....RU
      00c0: 76 c4 8f 4a d6 93 ba 8a  34 cc 2d 56 e5 f2 6d 2d  v..J....4.-V..m-
      00d0: d4 6d a4 66 a4 a5 36 53  70 99 a4 33 29 99 0c 45  .m.f..6Sp..3)..E
      00e0: 7a a7 9c 0e bc ac 86 e2  1a 92 45 51 5a 9c b9 35  z.........EQZ..5
      00f0: db 42 23 22 31 43 22 22  21 73 14 8c 68 e2 91 8b  .B#"1C""!s..h...
      0100: b9 76 db 4a d2 1a 55 a2  94 92 37 51 10 66 5d ba  .v.J..U...7Q.f].
      0110: 49 bc b3 43 fe c9 a6 26  a9 c2 bd a5 6d d3 f0 8d  I..C...&....m...
      0120: be 29 3b a5 bd 47 68 a4  ec 9a 4c 7c bd 49 4a ea  .);..Gh...L|.IJ.
      0130: 43 47 d9 00 61 d5 36 d3  3e a6 5a 55 cb b4 e1 b8  CG..a.6.>.ZU....
      0140: aa e5 35 5a 86 e0 a6 d6  d5 ac d0 52 55 cf 88 21  ..5Z.......RU..!
      0150: 84 a5 c3 6d 15 18 df c3  11 89 ca a2 29 41 23 2d  ...m........)A#-
      0160: 19 3d 89 9c b9 35 8b 42  23 22 21 42 33 32 21 96  .=...5.B#"!B32!.
      0170: 75 11 4e cd db 33 70 67  89 4e 10 9a 4a a2 e3 68  u.N..3pg.N..J..h
      0180: d8 7b 1a 9e d5 d9 4f da  b4 43 f8 ae 5c 66 cd a9  .{....O..C..\f..
      0190: 35 23 67 16 ac aa 45 eb  31 cb 33 98 4e c6 71 63  5#g...E.1.3.N.qc
      01a0: 90 7e bc 80 1e 9e cd c3  c2 54 51 f2 77 ad 36 ac  .~.......TQ.w.6.
      01b0: da 58 d1 13 8a 19 62 ea  ed 19 28 5c c3 28 05 70  .X....b...(\.(.p
      01c0: 8a 9c 55 d9 27 1b ba 35  02 36 e5 30 9a b2 d8 0b  ..U.'..5.6.0....
      01d0: 96 52 86 e1 e3 84 ba bb  a5 9c b9 35 34 42 33 32  .R.........54B32
      01e0: 31 43 23 22 31 96 90 d4  6d d9 25 1a f8 66 da 3e  1C#"1...m.%..f.>
      01f0: c9 b6 8f 83 33 98 53 6c  56 6f 25 26 c4 dc 41 b3  ....3.SlVo%&..A.
      0200: 29 0d d4 4d 23 71 45 0b  69 37 29 9a 6d ca bb 69  )..M#qE.i7).m..i
      0210: ad 3a d2 68 5a 63 2c ab  e6 8b 53 2d 09 c8 df 42  .:.hZc,...S-...B
      0220: 6a 58 5a d4 36 ea b6 da  ba 52 9a 75 74 b4 f6 a1  jXZ.6....R.ut...
      0230: b8 d5 bd 6d b5 b6 d1 da  9d d4 b2 a3 17 8a 33 2c  ...m..........3,
      0240: db 6d 5b b3 69 9b 6a da  69 d9 5b 24 cb c4 d2     .m[.i.j.i.[$...
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 36 time 23680 ssrc 1
      0000: 05 9c b9 35 83 42 23 32  22 43 23 32 22 83 31 a4  ...5.B#2"C#2".1.
      0010: 90 da 69 a3 54 2d 85 5a  8b 61 4c f4 74 a0 dd 15  ..i.T-.Z.aL.t...
      0020: 20 a5 aa aa 4b b6 6b 92  b8 dc 2a 7d a6 d2 c7 2a   ...K.k...*}...*
      0030: 57 56 aa 97 86 3a 27 5a  b1 4d c4 aa 69 12 c4 dc  WV...:'Z.M..i...
      0040: 28 b0 46 65 a8 24 d2 49  91 9b 4a 34 2e 82 8e 20  (.Fe.$.I..J4... 
      0050: bd 4e 32 b9 94 a5 2e 6b  8d 1e b0 e4 44 af 11 6c  .N2....k....D..l
      0060: 56 54 5b 23 47 12 03 65  c6 51 6c b4 53 19 8d 24  VT[#G..e.Ql.S..$
      0070: ce 55 42 b1 3b 31 28 9c  b9 35 17 32 22 23 21 42  .UB.;1(..5.2"#!B
      0080: 22 23 21 96 67 0c 60 b2  49 6a f0 33 62 ad 06 2c  "#!.g.`.Ij.3b..,
      0090: 01 71 d2 93 6a 50 da 3c  9c 16 9d a1 96 d4 61 bd  .q..jP.<......a.
      00a0: 24 bc ce b6 bf 2f 05 2c  ee 1d 26 90 08 4a 8a 8a  $..../.,..&..J..
      00b0: 8c cc ec b4 8b 1a 96 b1  15 65 a1 0f 95 1b 22 a3  .........e....".
      00c0: 50 9a b4 a2 1a 51 d6 94  e5 b1 4e 9d 3c 49 c5 41  P....Q....N.<I.A
      00d0: 34 5e a3 cd 26 b1 3b 35  56 2e 92 8a 0a e6 1d 34  4^..&.;5V......4
      00e0: d4 41 b0 42 4a 19 90 cb  04 6b 15 62 ad 9c b9 35  .A.BJ....k.b...5
      00f0: 73 33 22 22 22 42 23 22  21 e5 d4 57 33 f0 cd 14  s3"""B#"!..W3...
      0100: 6d 29 30 5e 96 d9 51 9a  29 89 f3 e4 da 3b 30 6d  m)0^..Q.)....;0m
      0110: 4c 8d 9b 14 e0 13 a2 66  81 aa 62 ee dc 58 2c ea  L......f..b..X,.
      0120: 45 58 77 9c 2b 83 59 ca  bb 36 c9 5e bb 48 3f 06  EXw.+.Y..6.^.H?.
      0130: 03 08 74 d8 28 70 ac 46  3a 0d 15 63 85 ac a3 79  ..t.(p.F:..c...y
      0140: 98 83 ba ec 0d a6 85 50  d2 e5 dd 30 66 31 d3 a6  .......P...0f1..
      0150: c9 21 54 2c 35 95 d6 7d  08 a7 57 8c 8d c3 c2 a5  .!T,5..}..W.....
      0160: 9d a4 2d 9c b9 35 8e 32  33 22 21 42 23 33 21 bd  ..-..5.23"!B#3!.
      0170: 1d 8b 1b 85 2b 62 e9 2f  54 ad 69 e3 93 56 7a d4  ....+b./T.i..Vz.
      0180: ac 51 1a 4c 5b 76 1b 7e  5a c7 d5 1d a1 8c 8c 24  .Q.L[v.~Z......$
      0190: 5f ce 72 31 66 11 36 d4  75 6d 7e 2a ed 20 4b a9  _.r1f.6.um~*. K.
      01a0: 49 3a 56 4d 1c 64 75 4d  bc 95 aa f8 cb 20 a5 d9  I:VM.duM..... ..
      01b0: a2 2f 96 64 67 32 8c 93  4a e4 36 b7 5e 76 81 49  ./.dg2..J.6.^v.I
      01c0: 28 08 d9 1b 93 26 32 80  89 c6 cc b1 38 59 35 3b  (....&2.....8Y5;
      01d0: 2d 0a ae dd 3b 62 7e 77  70 9c b9 35 e9 42 22 22  -...;b~wp..5.B""
      01e0: 21 42 23 32 22 8a cd a1  65 a2 8c 83 73 86 da c6  !B#2"...e...s...
      01f0: 1c 30 96 9b d7 14 ea 6b  90 c5 07 82 21 53 82 56  .0.....k....!S.V
      0200: 78 a8 88 de b6 82 c9 75  89 30 e9 d4 a1 7b 41 8d  x......u.0...{A.
      0210: 46 89 40 ae e9 1b 6a 19  91 48 5f 4a ea 55 ba 90  F.@...j..H_J.U..
      0220: 89 d8 dc ec 4e a4 55 25  92 8c 97 a6 d4 43 24 5e  ....N.U%.....C$^
      0230: 09 43 45 0b 86 27 08 31  4b 44 9a ab c3 72 87 dc  .CE..'.1KD...r..
      0240: a9 41 7b ba a8 36 d1 44  cf 51 8b 6a b3 49 a8     .A{..6.D.Q.j.I.
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 37 time 24320 ssrc 1
      0000: 05 9c b9 35 8a 32 23 32  20 42 22 32 21 bd e1 db  ...5.2#2 B"2!...
      0010: 60 b4 93 89 ac ae d6 9d  92 59 d5 65 6b 15 78 83  `........Y.ek.x.
      0020: 2a dc 59 b0 9f 7b 38 05  cc 99 c1 09 2a 36 47 84  *.Y..{8.....*6G.
      0030: b1 8e e9 06 22 70 28 4c  82 46 89 82 c4 ab 4a 18  ...."p(L.F....J.
      0040: 80 85 35 a1 95 0d 9c 1a  a1 ef b2 60 75 6a 14 27  ..5........`uj.'
      0050: 5e a4 d7 f1 98 9b 0c 85  34 3f 91 a6 d3 e9 21 44  ^.......4?....!D
      0060: fc ad 9a 2a 8c e9 47 6d  61 b4 08 18 29 22 87 c9  ...*..Gma...)"..
      0070: 2c e4 3b 52 fb aa 8e 9c  b9 35 f2 32 23 32 21 43  ,.;R.....5.2#2!C
      0080: 23 32 21 c4 15 db a2 ba  c4 72 38 4f 4a 96 06 5b  #2!......r8OJ..[
      0090: 47 4c 75 53 65 93 22 7b  56 c3 1b 69 d6 64 66 15  GLuSe."{V..i.df.
      00a0: b0 cb f2 34 6a 4e c9 8f  d9 1d 81 3e 97 4c 63 4c  ...4jN.....>.LcL
      00b0: 6d 07 99 cb 62 17 48 74  4c 4d 6b 8e ac 35 91 6f  m...b.HtLMk..5.o
      00c0: 67 4a 3d 95 2b 65 5c 38  e5 ee aa e3 19 b3 d6 33  gJ=.+e\8.......3
      00d0: 89 86 81 5a 49 a9 1b 51  a5 96 6e a8 25 d9 d9 a4  ...ZI..Q..n.%...
      00e0: b8 23 71 2e e2 cd ac c2  23 8a 76 37 51 9c b9 35  .#q.....#.v7Q..5
      00f0: 4e 42 23 32 31 42 23 32  22 b2 ce a6 e4 cc a9 aa  NB#21B#2".......
      0100: 38 71 ba 7f 5d 4a 54 80  51 a4 28 1a 62 6e 39 4d  8q..]JT.Q.(.bn9M
      0110: 93 58 d3 45 6c db 69 3b  ca a0 c7 29 62 4f 52 58  .X.El.i;...)bORX
      0120: 82 29 b6 f4 4f 0d a9 26  d5 3a 69 35 6e 0c 67 0a  .)..O..&.:i5n.g.
      0130: 18 d1 ba 85 b2 39 6d 24  75 e4 0d 1d b9 b0 35 f2  .....9m$u.....5.
      0140: ab 6d 0e 0b 45 b9 61 54  04 b4 a3 a9 0b b8 e1 27  .m..E.aT.......'
      0150: b4 ab 47 62 38 d1 8d b8  b2 2e 6d a6 2d d2 46 da  ..Gb8.....m.-.F.
      0160: 35 71 35 9c b9 35 52 33  33 32 22 42 22 32 32 9d  5q5..5R332"B"22.
      0170: da 8d 1f d6 2b 42 a9 23  64 ac 53 23 91 98 93 43  ....+B.#d.S#...C
      0180: ae 15 20 5a 27 51 1d 04  54 61 5d 97 20 bb 65 16  .. Z'Q..Ta]. .e.
      0190: 3b 09 38 4a 63 4d b9 76  6e 40 62 59 6d 09 db 2c  ;.8JcM.vn@bYm..,
      01a0: a9 dc cb 09 35 da 6e 50  aa 5f a9 2e db 12 65 07  ....5.nP._....e.
      01b0: 14 6b a6 d3 17 ad b4 8a  db b4 da 29 6d b9 02 d2  .k.........)m...
      01c0: 95 c9 1a 89 35 06 ce 17  06 e8 65 40 93 4d 31 36  ....5.....e@.M16
      01d0: d4 29 52 c3 a9 ab b3 22  70 9c b9 35 6e 42 22 33  .)R...."p..5nB"3
      01e0: 31 43 23 33 31 ae 33 1b  70 51 56 db d8 88 99 5f  1C#31.3.pQV...._
      01f0: 15 b8 94 be 3a da 38 8e  38 75 8e 28 8b b9 aa 26  ....:.8.8u.(...&
      0200: 68 69 42 85 8b 2c cf b8  ae 26 30 ec 6a 0c a2 4e  hiB..,...&0.j..N
      0210: ad 86 93 6c 52 1b 45 0b  a7 19 4a f2 6c 66 59 ba  ...lR.E...J.lfY.
      0220: e2 d7 64 d9 53 31 b8 67  a2 85 13 97 69 b7 1d 25  ..d.S1.g....i..%
      0230: b6 de a3 6a 36 3a 31 36  9d c5 49 b5 55 2e 44 e5  ...j6:16..I.U.D.
      0240: 4b ac ab 29 a5 8b 56 f1  6f d6 cb 45 9c 64 d2     K..)..V.o..E.d.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 38 time 24960 ssrc 1
      0000: 05 9c b9 35 a7 32 33 22  21 43 23 23 21 bf 95 9a  ...5.23"!C##!...
      0010: 23 b9 aa 42 38 ce 22 76  45 c4 11 66 51 45 2e 88  #..B8."vE..fQE..
      0020: 18 3d b3 50 1f 97 66 e1  74 9d 11 0d 93 34 6a 4c  .=.P..f.t....4jL
      0030: ea b4 54 25 b0 b3 78 90  2a eb 32 23 a3 1c 71 95  ..T%..x.*.2#..q.
      0040: 55 2a 2e d9 d0 12 b3 d2  22 2a d4 1a 8d e2 85 69  U*......"*.....i
      0050: 77 83 47 31 12 99 4b 3b  07 3b 76 51 10 dc f1 15  w.G1..K;.;vQ....
      0060: 1b 96 34 86 d7 2d 28 5b  5d 84 38 6d 0e 3e b3 a6  ..4..-([].8m.>..
      0070: 31 8c 2b 8a f6 c5 a9 9c  b9 35 b3 33 23 22 22 43  1.+......5.3#""C
      0080: 23 22 21 a5 39 e3 0e 5a  95 68 6d 2e 06 52 ae a3  #"!.9..Z.hm..R..
      0090: 41 84 75 01 56 87 d2 5c  4c 50 8c ad 46 c6 46 5a  A.u.V..\LP..F.FZ
      00a0: 88 ac d5 06 cf 46 9c 15  f4 6e 19 59 57 12 a5 93  .....F...n.YW...
      00b0: 8e 81 c3 a4 d4 ec 51 4c  3d a8 c4 28 57 0a 6a 26  ......QL=..(W.j&
      00c0: 8a a4 42 ea b3 1b a2 2d  b3 99 04 c1 5b b3 4e 17  ..B....-....[.N.
      00d0: ba 36 e1 65 61 6c 46 1e  17 0a ae d3 44 69 30 a1  .6.ealF.....Di0.
      00e0: 54 b6 d0 a7 87 66 89 b5  56 a1 7b c4 4e 9c b9 35  T....f..V.{.N..5
      00f0: 86 32 33 32 32 42 23 32  21 7d e6 20 d6 e7 1b 28  .2322B#2!}. ...(
      0100: 71 29 08 95 b6 91 49 52  85 c0 fd 8a 94 5b 2b 41  q)....IR.....[+A
      0110: c6 65 b4 56 62 aa b0 6f  52 a9 62 ef 2a 53 de 8e  .e.Vb..oR.b.*S..
      0120: 30 58 84 cb 0f b4 70 a1  b3 c6 cc 87 54 6c 1e 9e  0X....p.....Tl..
      0130: 29 03 2d 53 68 a0 cd b6  99 15 1b 7b 47 71 b2 5b  ).-Sh......{Gq.[
      0140: 37 5c aa 42 89 a8 46 18  81 52 22 e5 36 b1 3a 0b  7\.B..F..R".6.:.
      0150: 54 a2 69 f8 8a 44 15 94  e3 4a 8e 6d 8e cb c6 9a  T.i..D...J.m....
      0160: a5 1b 6d 9c b9 35 ab 42  33 22 22 42 33 32 22 7a  ..m..5.B3""B32"z
      0170: e9 b2 b0 53 70 aa 99 4d  94 4f 1a 49 19 c3 25 0a  ...Sp..M.O.I..%.
      0180: 36 d3 0a 67 1a 6d 04 f6  9b 47 ae d3 6a bc a4 d2  6..g.m...G..j...
      0190: bd a4 db 85 6e 35 95 7a  b8 d8 a5 8d b6 29 69 20  ....n5.z.....)i 
      01a0: d5 3c 2d 35 3b 85 8a 03  e2 6e 02 b4 6e b6 5a 9a  .<-5;....n..n.Z.
      01b0: 8d a5 93 86 43 f6 e3 28  cd a3 4c 8f a6 d5 24 34  ....C..(..L...$4
      01c0: ea 08 85 3a 92 25 85 0b  63 6d 51 18 bc 36 d4 17  ...:.%..cmQ..6..
      01d0: 6e c3 11 dd d5 15 bb 71  49 9c b9 35 dc 42 23 33  n......qI..5.B#3
      01e0: 21 42 23 32 20 93 da e5  ac 56 5a 23 37 39 70 3e  !B#2 ....VZ#79p>
      01f0: ac de 0e e5 bb 71 db 79  1c a5 42 51 4c ab b6 d7  .....q.y..BQL...
      0200: 2c 4a a0 c4 d4 bc 47 63  67 17 66 4d b5 0e 9a b6  ,J....Gcg.fM....
      0210: 9f 96 49 ab f1 8e a5 5c  19 81 2b 4e 95 80 72 54  ..I....\..+N..rT
      0220: 6b 92 04 8d 42 ca 63 5c  d1 ad 2b 74 45 42 b5 71  k...B.c\..+tEB.q
      0230: 4c 4d c3 25 13 b9 26 58  85 d8 b6 2b 90 48 c3 6c  LM.%..&X...+.H.l
      0240: 62 20 fa 23 48 95 93 4f  35 cb 9d 26 4b d3 41     b .#H..O5..&K.A
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 39 time 25600 ssrc 1
      0000: 05 9c b9 35 9e 42 33 22  21 42 23 22 21 6b ac e9  ...5.B3"!B#"!k..
      0010: 8b ed 52 62 92 a6 57 23  28 cd 96 82 52 6a 91 6a  ..Rb..W#(...Rj.j
      0020: 94 85 99 d0 0c d2 d2 07  2a f7 12 c6 d6 34 4f 47  ........*....4OG
      0030: 52 18 e8 2c 24 cd bb a6  8f ac 62 8b 52 2b 10 fc  R..,$.....b.R+..
      0040: b4 e1 42 b1 21 86 46 22  23 70 a9 92 3a a9 6b 69  ..B.!.F"#p..:.ki
      0050: b9 b8 6c 1a 34 62 cd 61  e1 4f aa 34 56 a0 ed 92  ..l.4b.a.O.4V...
      0060: 84 aa 46 99 87 67 21 78  e9 48 ef 3a 64 a5 76 59  ..F..g!x.H.:d.vY
      0070: 30 51 8e 25 ba 9b a5 9c  b9 35 f6 42 13 32 20 42  0Q.%.....5.B.2 B
      0080: 23 32 31 72 cc da 56 d2  16 5a 37 8c d2 76 8d 48  #21r..V..Z7..v.H
      0090: d1 b8 3a d2 e3 22 b4 96  6a 46 91 5a 4d a7 f3 15  ..:.."..jF.ZM...
      00a0: b9 bc aa 4a 3d 86 88 ab  d9 53 29 1c 86 4e 2f 50  ...J=....S)..N/P
      00b0: d3 89 ee 22 69 f5 94 a3  52 89 db 4d 83 a9 22 d1  ..."i...R..M..".
      00c0: 6e e0 84 c5 b8 eb 9d 64  d8 2b 6d 16 87 74 c6 99  n......d.+m..t..
      00d0: b6 91 35 28 2d 38 ea a5  4e 9b b9 01 46 55 a9 6d  ..5(-8..N...FU.m
      00e0: ba 0b 69 42 c7 1a 6e f6  5b 6b 5a aa eb 9c b9 35  ..iB..n.[kZ....5
      00f0: e6 43 33 22 21 42 23 22  22 72 cf 0b 55 bb 89 aa  .C3"!B#""r..U...
      0100: 54 59 04 94 d4 42 0f a4  3d 22 eb 66 4a be 61 96  TY...B..=".fJ.a.
      0110: 99 b5 0c 88 6b 29 91 ab  c4 89 2f 79 6e aa e9 b9  ....k)..../yn...
      0120: 51 5b 33 2d 46 85 b2 a8  59 dc 69 d5 69 b5 46 d0  Q[3-F...Y.i.i.F.
      0130: a2 89 ab 54 aa fa 92 da  9d d9 8d 63 b2 a6 66 30  ...T.......c..f0
      0140: 8b 72 a5 c9 84 a3 60 8b  55 6e c9 b5 3c 42 9a 11  .r....`.Un..<B..
      0150: b9 35 a6 f3 2a d9 7b b1  4d 36 88 b6 91 5e 9d 6a  .5..*.{.M6...^.j
      0160: 97 8e a2 9c b9 35 fd 42  33 32 21 42 22 33 21 46  .....5.B32!B"3!F
      0170: 2c f1 27 41 64 6a 38 34  0d 2b ae 4c 0b d3 e3 20  ,.'Adj84.+.L... 
      0180: 91 3e 98 6d 21 d3 47 ad  b6 86 ae d2 80 9d 36 92  .>.m!.G.......6.
      0190: c3 77 65 55 27 4d 39 3c  c2 a8 97 5a 2a 26 de 9d  .weU'M9<...Z*&..
      01a0: 10 7a 3d 65 1e 51 4d 03  db 2a 8a d3 a9 4e 52 91  .z=e.QM..*...NR.
      01b0: 1b 9b 8c 43 32 91 98 ca  9d 66 99 89 e3 d6 92 e8  ...C2....f......
      01c0: ef 0c 45 91 c6 8d 58 88  91 35 6d b1 8b b3 b7 25  ..E...X..5m....%
      01d0: 52 51 b1 dd 92 95 ba b1  a9 9c b9 35 b1 43 23 33  RQ.........5.C#3
      01e0: 11 42 23 32 21 52 89 06  c4 d2 11 d1 d5 d6 68 3a  .B#2!R........h:
      01f0: 29 18 4f bd a5 40 d7 b3  5a 6d b9 a4 08 b3 a9 56  ).O..@..Zm.....V
      0200: f3 6a dc 96 a9 b3 3f 61  79 25 e4 8e 49 1c 92 b6  .j....?ay%..I...
      0210: 0f 95 4e a7 5d c9 30 bb  51 6d 3a ea 6d a3 d4 0b  ..N.].0.Qm:.m...
      0220: 4a fa 45 65 43 a4 9a 60  9a 3b 73 52 89 12 9e 0d  J.EeC..`.;sR....
      0230: a4 0b ca 29 43 30 e2 9a  4c b0 34 25 77 46 e2 31  ...)C0..L.4%wF.1
      0240: 69 b5 3b 44 37 9d 81 6d  32 c9 a5 b2 09 c3 75     i.;D7..m2.....u
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 40 time 26240 ssrc 1
      0000: 05 9c b9 35 5f 42 22 32  20 43 32 23 20 53 1f 49  ...5_B"2 C2# S.I
      0010: a5 66 a1 69 f3 4a 29 0e  e7 42 4b d0 51 88 7b 66  .f.i.J)..BK.Q.{f
      0020: 1c 9e de 99 8e ba d6 67  f1 98 c2 c6 17 34 ab a6  .......g.....4..
      0030: 56 e4 ae 6a 39 4c ac c1  19 93 8d a8 65 69 a0 8c  V..j9L......ei..
      0040: b6 a8 4f 38 ee a2 de 9a  63 b6 75 6e 5e cc eb 5e  ..O8....c.un^..^
      0050: 90 1c b3 f6 41 2a 6f 44  d9 8e ba 28 d5 30 b0 c8  ....A*oD...(.0..
      0060: 25 d9 24 23 48 67 01 6c  c9 b1 8b 30 34 27 66 51  %.$#Hg.l...04'fQ
      0070: 8f d8 da 2a 1b 38 aa 9c  b9 35 99 43 22 32 30 43  ...*.8...5.C"20C
      0080: 33 32 20 56 ea 99 69 5d  db 09 d8 52 9c 1b 0e 94  32 V..i]...R....
      0090: 8e ce 04 c9 36 72 e0 65  81 f0 88 b3 2c 09 aa c5  ....6r.e....,...
      00a0: 56 b5 95 a8 af 90 6c c4  2e a9 25 2b ab 6d 9d 78  V.....l...%+.m.x
      00b0: 6c 25 dd 81 4c a9 3b 2c  36 f3 13 82 de 9b ab d4  l%..L.;,6.......
      00c0: 58 d3 56 91 5b 5e b0 35  1a d5 66 9a 45 b9 44 47  X.V.[^.5..f.E.DG
      00d0: b6 38 43 ab 31 86 75 92  30 93 52 e9 b1 6c ad b5  .8C.1.u.0.R..l..
      00e0: 8b bc 82 25 77 ad 4f 6d  3a 8d 8e 9b 75 9c b9 35  ...%w.Om:...u..5
      00f0: 93 42 23 22 21 42 23 32  21 43 42 ea 27 6d 1b 8a  .B#"!B#2!CB.'m..
      0100: 17 58 a1 3e d5 21 48 c8  cc 70 96 47 1c 75 a1 9c  .X.>.!H..p.G.u..
      0110: 4a b4 37 17 f8 46 d2 de  00 b4 b9 89 4e 65 25 8a  J.7..F......Ne%.
      0120: 19 0d 03 94 0d e3 49 06  6d 5e b4 8a 3a ad 2e 64  ......I.m^..:..d
      0130: dd 03 65 9d 6b 79 54 72  4b 8c 53 9b b7 2c 2b 53  ..e.kyTrK.S..,+S
      0140: 65 0a 85 88 71 89 d1 1a  63 30 69 52 5d 4c b8 9d  e...q...c0iR]L..
      0150: 4d 56 51 e9 a9 95 8b 93  99 21 93 89 d1 46 dc a1  MVQ......!...F..
      0160: 99 bb 44 9c b9 35 7b 42  12 33 22 42 22 32 21 4e  ..D..5{B.3"B"2!N
      0170: c4 1a a5 68 11 ca 90 c1  a5 36 0c 5a 4b bd a9 a9  ...h.....6.ZK...
      0180: 17 86 d2 be 23 6d 49 e4  e7 18 70 32 2a dd 16 30  ....#mI...p2*..0
      0190: b5 a6 9b 54 f2 d1 25 bc  26 e0 23 76 6d 09 e5 c2  ...T..%.&.#vm...
      01a0: c8 eb 3b 30 57 86 b2 89  ee b4 2c d9 d1 c6 63 2e  ..;0W.....,...c.
      01b0: db 5a a0 2d 42 71 60 92  bd 83 88 8e ac ba c4 b0  .Z.-Bq`.........
      01c0: a5 88 8d 75 ca ab 9d 13  52 35 0d 06 7a f1 5c af  ...u....R5..z.\.
      01d0: 65 16 2e d1 06 61 2b 19  71 9c b9 35 15 43 32 32  e....a+.q..5.C22
      01e0: 22 42 32 32 21 52 b0 d9  23 e6 cb 6a b8 74 da 17  "B22!R..#..j.t..
      01f0: 96 d1 89 c3 a6 a4 bd 30  c4 d5 e0 30 ab dd 86 5a  .......0...0...Z
      0200: 2e 82 95 7a 90 40 b1 77  6d 89 d1 69 c5 4b b1 40  ...z.@.wm..i.K.@
      0210: 51 c3 28 0b d8 9a 8a 86  8a 2d 3e ee 93 92 ee 9a  Q.(......->.....
      0220: 13 f6 76 ca bd c5 11 63  e2 a6 d5 7e b2 e0 ad d9  ..v....c...~....
      0230: 44 a4 dd 68 93 ae f5 35  2f 72 16 ab 68 c5 b2 78  D..h...5/r..h..x
      0240: 58 a6 3b cc 89 19 ea ee  2f dd b1 84 dd 93 54     X.;...../.....T
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 41 time 26880 ssrc 1
      0000: 05 9c b9 35 bb 42 33 33  22 43 33 23 21 56 e6 9b  ...5.B33"C3#!V..
      0010: 13 2c 9b 82 79 86 d4 9b  86 d9 94 84 66 88 bb 2a  .,..y.......f..*
      0020: 5a e5 62 a8 8a e5 45 58  ad 0d 32 7e cd 36 33 15  Z.b...EX..2~.63.
      0030: 6e 01 b7 4d 35 3d bb 79  49 b3 72 0b ea 5b 42 85  n..M5=.yI.r..[B.
      0040: db 4c 66 a8 63 14 2e ce  64 f7 64 e0 c3 66 93 53  .Lf.c...d.d..f.S
      0050: d5 27 15 0b b7 1a b4 12  32 a6 dd 3a 94 ec c6 b5  .'......2..:....
      0060: 56 a9 36 9d 47 32 49 57  83 36 39 d9 89 58 c5 2d  V.6.G2IW.69..X.-
      0070: b2 52 63 6b 0c 94 ae 9c  b9 35 74 43 32 32 32 42  .Rck.....5tC222B
      0080: 33 32 21 37 55 26 81 7f  0a 4b 55 4c c7 23 44 ca  32!7U&...KUL.#D.
      0090: 4e c2 90 30 cd 18 d2 d6  92 71 ca 51 b7 09 32 da  N..0.....q.Q..2.
      00a0: 8d 76 d5 a6 35 56 d9 6a  d2 8d a5 8c aa 5a 4e da  .v..5V.j.....ZN.
      00b0: 8a 88 d9 c4 da 5d 9b 26  47 13 35 12 74 ea 34 f7  .....].&G.5.t.4.
      00c0: 55 86 c7 a7 21 62 ab 6d  35 6a a6 8c b5 a3 41 87  U...!b.m5j....A.
      00d0: de 36 94 6a e2 4a 23 6d  c4 95 c7 13 a1 b6 6d 46  .6.j.J#m......mF
      00e0: 2c 2a 8c 9f 82 85 af d5  98 60 ed 5a 90 9c b9 35  ,*.......`.Z...5
      00f0: 10 42 23 32 31 42 23 22  31 57 00 eb 86 5d 36 c9  .B#21B#"1W...]6.
      0100: f7 c4 da 27 91 3c ca a4  b6 90 78 6e a4 f5 a8 bc  ...'.<....xn....
      0110: 95 93 4e 38 ef 29 c4 ec  71 d4 a9 73 6d 33 a2 db  ..N8.)..q..sm3..
      0120: 71 1f ab 71 9b 4c db 87  d5 5b ac 69 b4 aa 4a 72  q..q.L...[.i..Jr
      0130: 8b 66 c1 b4 e4 f3 76 cb  6f 65 86 a2 cb 37 5a f7  .f....v.oe...7Z.
      0140: 6d 2a 9d 5d 3b 08 b9 69  25 73 4d c6 9d f2 4d ab  m*.];..i%sM...M.
      0150: 19 89 32 2f 61 2e 3a c4  74 3d 37 23 6d e6 a3 8d  ..2/a.:.t=7#m...
      0160: 5d 76 da 9c b9 35 97 32  33 22 20 42 33 32 22 35  ]v...5.23" B32"5
      0170: d5 26 19 63 74 08 12 50  b8 9c 14 6d 49 ab 65 27  .&.ct..P...mI.e'
      0180: e6 19 63 0d c6 41 6a d1  59 9c 65 d1 8c 9d 74 98  ..c..Aj.Y.e...t.
      0190: 86 c9 1c 0f a9 c4 d4 59  9b 42 1e 61 d4 2a 83 32  .......Y.B.a.*.2
      01a0: d3 68 ad b4 34 9d b8 a1  66 8c b4 72 ee a5 bc 33  .h..4...f..r...3
      01b0: 69 1f 57 b1 89 ce 23 6c  03 41 b0 27 52 a5 84 4d  i.W...#l.A.'R..M
      01c0: 93 29 72 76 d8 96 b4 9b  90 ad 24 87 bb a0 a3 25  .)rv......$....%
      01d0: dc b8 aa 93 2c 74 68 ee  71 9c b9 35 75 43 24 32  ....,th.q..5uC$2
      01e0: 22 43 23 32 21 4a e9 9a  12 6e 94 8b 16 6e da 9f  "C#2!J...n...n..
      01f0: 54 db 54 ba 56 94 bb 42  e2 d6 6b 23 2b 5e 34 c8  T.T.V..B..k#+^4.
      0200: ab a1 35 6e 7e 22 a9 6a  ad 49 36 8d 31 ba a8 49  ..5n~".j.I6.1..I
      0210: 50 a4 85 04 f1 ba 20 46  64 2e 6a aa cb 63 ec eb  P..... Fd.j..c..
      0220: 6c b7 ce 62 3f 5a 9b 5f  aa 86 69 79 96 da 7d e4  l..b?Z._..iy..}.
      0230: 26 87 5d b6 d4 6a dd b6  32 cd c6 27 62 d2 a1 77  &.]..j..2..'b..w
      0240: c9 46 6a 17 6c 5f b2 8d  8e ea 43 8a ae e3 69     .Fj.l_....C...i
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 42 time 27520 ssrc 1
      0000: 05 9c b9 35 38 42 22 22  21 42 22 22 31 4a ce 6b  ...58B""!B""1J.k
      0010: 48 80 34 da 1d 27 58 5d  d9 44 d4 cd b5 93 2f 73  H.4..'X].D..../s
      0020: 26 ec 99 d6 a3 3d 4d c8  b1 4d 91 eb 43 45 b3 52  &....=M..M..CE.R
      0030: 89 a6 f4 5a 25 0a 48 71  1b 66 61 88 c6 cb 89 b7  ...Z%.Hq.fa.....
      0040: a0 ea 62 b4 6b 4d bd 09  14 d8 70 9a fd c4 28 9c  ..b.kM....p...(.
      0050: 85 96 84 eb 06 a6 75 a5  b6 0f 59 2d 95 2a 69 b4  ......u...Y-.*i.
      0060: b9 c3 b5 1d a9 51 26 63  94 6e 8a 64 4c 8e 8b 0c  .....Q&c.n.dL...
      0070: 52 4c d9 94 17 18 a3 9c  b9 35 a3 52 23 31 20 42  RL.......5.R#1 B
      0080: 23 32 20 63 90 8c 09 fd  9b 8b 13 69 32 95 8a cd  #2 c.......i2...
      0090: 58 c4 ba 12 78 cc 91 11  e2 94 33 a4 84 d7 e7 13  X...x.....3.....
      00a0: 39 dc 5c c7 30 65 98 25  69 29 b5 c3 9d 24 2f 13  9.\.0e.%i)...$/.
      00b0: 09 0c 94 a1 01 b6 5b 28  75 22 ec 8f f3 33 73 e6  ......[(u"...3s.
      00c0: c3 64 ed a1 9b 5d 9f 43  56 21 8e ea c0 6e 62 19  .d...].CV!...nb.
      00d0: 37 98 d4 e0 0d 54 1b c3  54 9b c3 62 01 6d 98 91  7....T..T..b.m..
      00e0: d4 2b 44 3a cc cd 0d ad  5d aa 16 66 6d 9c b9 35  .+D:....]..fm..5
      00f0: c0 43 23 32 21 42 33 32  21 26 a4 a5 82 4d 52 49  .C#2!B32!&...MRI
      0100: 37 93 89 1e 10 61 4d c4  25 29 7b 63 52 b5 d9 63  7....aM.%){cR..c
      0110: 97 c4 a8 a7 a9 2e d8 cd  5d b6 1d 98 37 53 bc 89  ........]...7S..
      0120: c4 5b 5b bc 89 38 4e 22  d5 e5 40 8a 2c 58 2e ed  .[[..8N"..@.,X..
      0130: 0e 89 dd 23 83 b4 28 2e  62 6a d3 92 cd 3a 71 f7  ...#..(.bj...:q.
      0140: 96 e4 6d 9a 59 4a cc 44  83 68 ce 5a 4c 99 86 99  ..m.YJ.D.h.ZL...
      0150: 7b 64 c2 71 0d 31 db 9c  b7 3b 81 8d 49 c8 e6 54  {d.q.1...;..I..T
      0160: e9 3c 79 9c b9 35 95 42  23 33 21 42 33 33 21 2e  .<y..5.B#3!B33!.
      0170: a7 51 81 61 a5 60 ff 75  4c 1f 26 93 0a bb ca 69  .Q.a.`.uL.&....i
      0180: 37 7a 9a bf 56 5a 53 db  b6 67 ae 42 9e fd d8 a7  7z..VZS..g.B....
      0190: a1 78 7a d3 26 ee 34 cb  c4 56 0f 75 75 8b d9 15  .xz.&.4..V.uu...
      01a0: c5 1f aa 72 56 a7 0d 4a  49 9b 53 36 76 4e 4b 4c  ...rV..JI.S6vNKL
      01b0: 93 95 b1 a3 22 f3 54 c8  6d d4 9a 8c e3 96 a3 f7  ....".T.m.......
      01c0: 2f 58 87 1d d6 2b b4 97  13 ae b1 c6 18 69 b8 3f  /X...+.......i.?
      01d0: 07 4e 09 6d dd b8 ef 42  6e 9c b9 35 99 42 23 22  .N.m...Bn..5.B#"
      01e0: 31 43 23 22 31 47 0a 43  67 e1 b0 da 70 36 a3 52  1C#"1G.Cg...p6.R
      01f0: 6d a6 c7 cc 35 18 f6 89  37 1d 99 92 9e c3 a4 b7  m...5...7.......
      0200: ec 70 a6 b5 62 29 a3 64  30 34 26 1c 0d 0a 34 0a  .p..b).d04&...4.
      0210: 0f 86 c2 88 f2 2c 2c eb  bb 03 76 ae 90 ca 5e 36  .....,,...v...^6
      0220: 34 33 92 d3 76 50 b2 d5  a9 d4 da 17 50 b6 a6 8d  43..vP......P...
      0230: ea 8d b4 97 23 fa 52 b6  1e 4c e9 b7 56 89 b5 6c  ....#.R..L..V..l
      0240: e2 6e 5b aa 69 bb 76 9b  6d 56 54 69 0b b5 92     .n[.i.v.mVTi...
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 43 time 28160 ssrc 1
      0000: 05 9c b9 35 69 42 23 32  22 43 23 32 31 3e 8d b2  ...5iB#2"C#21>..
      0010: 2c 5d b8 da d4 71 89 42  ad a1 16 ac 55 89 57 ce  ,]...q.B....U.W.
      0020: 95 37 5a 91 1f ca 36 b9  e2 8b c4 cd 18 75 ab 6a  .7Z...6......u.j
      0030: 8c 44 ae d1 8d 2b 36 91  21 88 d4 46 6c ba d0 cc  .D...+6.!..Fl...
      0040: a7 4b 6f 49 46 a8 69 29  1c 9d 6d 35 76 f1 a8 d6  .KoIF.i)..m5v...
      0050: ae 6a c9 f8 c5 c8 8c e9  61 4f 9d 49 b5 26 d9 6a  .j......aO.I.&.j
      0060: 6d db 2d a5 73 5c 15 ac  a4 66 4a 48 c4 b9 67 5b  m.-.s\...fJH..g[
      0070: aa 66 44 a4 cc 58 8b 9c  b9 35 01 43 33 21 31 43  .fD..X...5.C3!1C
      0080: 23 32 31 32 71 12 d2 ac  46 a2 d9 6a c4 55 96 46  #212q...F..j.U.F
      0090: 99 ca b0 a3 ab 90 a6 f6  11 40 b1 65 2d 16 af 0d  .........@.e-...
      00a0: 2d 2a 42 6d 1f 95 b4 64  e1 74 0d 2d bb 91 3b 0d  -*Bm...d.t.-..;.
      00b0: 1d 27 61 62 19 3c 46 9b  5b 48 93 0f d0 36 dc b6  .'ab.<F.[H...6..
      00c0: 65 86 cd dd 44 d7 c4 35  35 2e 4d 36 b5 d8 b9 a3  e...D..55.M6....
      00d0: 76 6d b4 70 ea 88 bd 32  8d a7 76 4d 67 dd 52 6d  vm.p...2..vMg.Rm
      00e0: ec 2a 02 62 f1 0b 29 dc  98 1a 97 06 62 9c b9 35  .*.b..).....b..5
      00f0: 69 43 22 22 21 42 23 23  21 4e f3 09 29 6a 18 6a  iC""!B##!N..)j.j
      0100: 57 92 6d 1e c8 db 4d c2  29 c8 d3 44 6b 3d 99 ab  W.m...M.)..Dk=..
      0110: 1e 8b 28 c6 64 e1 2a 85  55 a8 1f 6d 64 83 72 cd  ..(.d.*.U..md.r.
      0120: 35 4c 3f 0e a5 90 a2 a6  5b 95 c0 ab 6b 10 6a eb  5L?.....[...k.j.
      0130: c5 87 6a 68 63 b7 3e 4d  5e af 4c 59 a5 13 0a 9a  ..jhc.>M^.LY....
      0140: 56 8a ae 72 ca 90 bc d0  95 68 f4 a2 45 da 36 a5  V..r.....h..E.6.
      0150: 65 d9 95 68 b2 da 8b 1d  c4 3b 9b 8d 2a 64 21 c9  e..h.....;..*d!.
      0160: 08 9a 6e 9c b9 35 91 43  23 33 32 43 13 32 32 4e  ..n..5.C#32C.22N
      0170: d3 d0 c3 58 f5 32 1b 0b  8c 46 e2 e3 12 c4 db 72  ...X.2...F.....r
      0180: 56 b6 9c fd c2 db 18 bc  36 c7 a5 a6 d4 8d ad 83  V.......6.......
      0190: 25 8d 48 c3 31 6e 31 4b  8a 16 9b 62 61 43 da 4d  %.H.1n1K...baC.M
      01a0: 44 8b 9b 70 86 52 8d 28  da a3 6c 38 1b 6d 76 86  D..p.R.(..l8.mv.
      01b0: da 59 b8 5a 69 d7 28 9a  7d c6 63 4b a9 36 d3 ae  .Y.Zi.(.}.cK.6..
      01c0: 42 98 5e 10 a6 21 9a 46  a4 76 ac 2a ab 55 38 3f  B.^..!.F.v.*.U8?
      01d0: 6c 2a 0d dc 6d b9 2c 63  8e 9c b9 35 b5 42 22 32  l*..m.,c...5.B"2
      01e0: 31 42 23 33 31 22 31 51  81 65 c4 62 74 7e 03 37  1B#31"1Q.e.bt~.7
      01f0: 0a 82 da e1 52 d9 97 51  37 1d 86 b8 de 80 ae 38  ....R..Q7......8
      0200: 28 cd d6 cd 23 75 a5 c7  71 c4 32 dc 6d 7a 9e 34  (...#u..q.2.mz.4
      0210: a5 27 0b 06 f2 23 2c 9f  46 9b 7e 68 da 6c c9 24  .'...#,.F.~h.l.$
      0220: d4 16 85 2a 7e 49 c6 96  ca c9 11 7e 71 d4 b4 a5  ...*~I.....~q...
      0230: 40 d7 ac 4c b5 30 ee 26  5e 03 6d b3 86 31 35 f2  @..L.0.&^.m..15.
      0240: 54 6e 3a 32 72 37 3a 53  68 5c 1b 6c 8e 85 14     Tn:2r7:Sh\.l...
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 44 time 28800 ssrc 1
      0000: 05 9c b9 35 f9 43 32 23  20 42 33 23 20 46 ca 49  ...5.C2# B3# F.I
      0010: 27 71 8c 61 59 65 8d 22  ea eb 13 cb 98 51 da 72  'q.aYe.".....Q.r
      0020: 95 1e 9d 5b 1f eb 39 07  6a a0 d8 9d 68 34 b7 68  ...[..9.j...h4.h
      0030: 4c d3 eb 2e 34 fc 46 18  99 05 a9 c6 cd 11 14 79  L...4.F........y
      0040: b3 40 72 ae ca 4d d9 68  94 36 56 6d 66 aa 83 4a  .@r..M.h.6Vmf..J
      0050: d1 5b 40 7a 38 10 75 e3  9a 46 d4 50 d4 6b 5e 5a  .[@z8.u..F.P.k^Z
      0060: 74 66 17 2b 87 e0 94 2f  51 a1 bb a5 c6 b7 96 a9  tf.+.../Q.......
      0070: 8b 65 d5 d5 3d 2a 75 9c  b9 35 79 42 23 22 20 43  .e..=*u..5yB#" C
      0080: 23 32 20 5e 92 cd a4 e0  d5 89 55 27 6d 0a e9 1e  #2 ^......U'm...
      0090: 58 dc b6 62 97 55 1b 3d  11 db 18 cd b8 85 66 ea  X..b.U.=......f.
      00a0: 28 b5 59 a8 a9 06 6c a2  ae 4d 99 2b 23 e6 17 38  (.Y...l..M.+#..8
      00b0: 45 89 fd 0e c8 ac 12 6e  8e ce 90 29 e9 12 4b ba  E......n...)..K.
      00c0: 87 0d 6b 6a da 54 9b 3b  2a 77 06 d2 8d bc 9c 0e  ..kj.T.;*w......
      00d0: c3 94 43 64 cd 90 36 19  54 3b 67 32 d5 ac a9 a6  ..Cd..6.T;g2....
      00e0: 89 a3 b4 bd 75 49 25 fc  dd 34 cb c4 4d 9c b9 35  ....uI%..4..M..5
      00f0: 17 43 23 22 20 42 33 22  20 5a e8 c8 a9 45 d1 29  .C#" B3" Z...E.)
      0100: d6 78 49 1a ee c3 19 b3  39 4a 38 88 c4 ee 62 53  .xI.....9J8...bS
      0110: 19 d3 b6 85 ee cc a8 85  dd b8 2b 79 63 14 6d 2d  ..........+yc.m-
      0120: e4 7c 95 b6 81 c6 a3 28  cd 1d 50 98 bc 44 8e ef  .|.....(..P..D..
      0130: 39 51 c1 e9 93 b8 96 90  5a f4 81 13 c3 b3 32 75  9Q......Z.....2u
      0140: 68 dc 5d d6 0b 48 bb b4  94 ef 31 5a 57 1e 36 b9  h.]..H....1ZW.6.
      0150: 72 86 95 f4 f4 55 dc c3  b2 ad 77 48 2b 54 1e 39  r....U....wH+T.9
      0160: 09 93 72 9c b9 35 f0 42  22 22 21 42 24 22 21 37  ..r..5.B""!B$"!7
      0170: 84 23 50 a3 32 29 d4 73  8c 4d e1 b2 94 ab 88 63  .#P.2).s.M.....c
      0180: 66 ed 14 fd d4 40 b9 2b  6c 14 2e a6 b4 dc 2b 3a  f....@.+l.....+:
      0190: a1 96 29 a6 6d 9d 14 ed  2c 2c 26 74 ea 0b dc 93  ..).m...,,&t....
      01a0: 91 b8 58 46 a2 d1 11 62  a4 ba 6a 77 34 02 5d 81  ..XF...b..jw4.].
      01b0: d3 51 aa 36 c2 fb 10 98  8e ed ba 99 66 81 94 28  .Q.6........f..(
      01c0: 89 b4 58 73 22 c1 63 8e  29 ca 2c 36 9c 4e 69 96  ..Xs".c.).,6.Ni.
      01d0: 7f 05 2a 75 23 21 d5 97  64 9c b9 35 8a 43 23 23  ..*u#!..d..5.C##
      01e0: 21 42 23 32 21 46 c8 ed  a4 dd 22 6a 18 69 6e 23  !B#2!F...."j.in#
      01f0: 29 12 5d b3 4a 8a 17 46  eb 1d 59 92 5c 90 26 95  ).].J..F..Y.\.&.
      0200: ac 4e da c4 d9 b6 9d 33  75 43 e8 8d d0 dc 4c b6  .N.....3uC....L.
      0210: 97 8a 71 ab e5 1e 34 fc  ac 89 7b 12 c9 0c 6d 0b  ..q...4...{...m.
      0220: 64 96 d5 8d 82 8e 9a 53  ca b4 91 f7 66 da 95 60  d......S....f..`
      0230: 73 49 a4 8b 93 ae 88 e2  45 ec 48 c5 97 56 86 b9  sI......E.H..V..
      0240: 0a 42 ab 83 e6 45 31 75  89 e2 d4 b9 3c 4a 46     .B...E1u....<JF
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 45 time 29440 ssrc 1
      0000: 05 9c b9 35 4d 43 23 22  22 42 33 32 22 5a ed b0  ...5MC#""B32"Z..
      0010: 47 6b 48 8b 15 28 54 4a  4b 51 1e ae 4d 12 d9 1b  GkH..(TJKQ..M...
      0020: 63 3d ec 26 1d d8 d2 85  f2 9c 0a 96 b6 9a ad 22  c=.&..........."
      0030: cd 95 a1 a3 15 5b 36 12  a5 6e 06 b0 61 d3 85 99  .....[6..n..a...
      0040: 75 21 d2 ce 26 94 61 a6  ab 14 50 51 56 dc 4d 55  u!..&.a...PQV.MU
      0050: b9 b4 a2 d4 62 8a de 4a  10 93 c6 d4 17 39 99 48  ....b..J.....9.H
      0060: a6 d8 62 57 73 53 27 65  26 ca 5a f7 5a 3b 31 b8  ..bWsS'e&.Z.Z;1.
      0070: 8e e0 b6 c9 9d 71 92 9c  b9 35 e6 32 33 23 22 32  .....q...5.23#"2
      0080: 23 32 22 5c 9d 64 89 a2  55 21 ac e9 46 2d db 91  #2"\.d..U!..F-..
      0090: a5 b3 4e 03 b6 13 a1 ba  4b 71 65 95 1b 56 dc db  ..N.....Kqe..V..
      00a0: 4a ab 96 c4 93 56 1b 90  35 94 e5 b2 75 54 96 8d  J....V..5...uT..
      00b0: 55 26 e3 36 10 7c 69 84  c4 21 46 33 b5 51 ad 70  U&.6.|i..!F3.Q.p
      00c0: c5 50 75 49 55 0d 65 35  88 e8 c3 2a 7d b3 96 47  .PuIU.e5...*}..G
      00d0: 62 9c 57 5d 94 6a 8c 38  d0 fa 4f 13 1b cd d4 c6  b.W].j.8..O.....
      00e0: 3a 76 da b7 11 b8 ab ac  32 94 77 91 39 9c b9 35  :v......2.w.9..5
      00f0: f3 42 22 33 22 43 23 33  21 67 0d 5b 96 2b 1b 52  .B"3"C#3!g.[.+.R
      0100: b3 cc 8a ab 4d 51 66 9b  66 91 da b8 8b 85 57 24  ....MQf.f.....W$
      0110: d3 d6 46 55 33 d1 48 3a  f9 99 31 33 d5 12 55 57  ..FU3.H:..13..UW
      0120: 35 ca 0c 4d 0f bc 69 ac  78 a4 22 86 1b 88 af a8  5..M..i.x.".....
      0130: 9c 19 b0 1b 84 33 c4 9a  bd 58 93 56 e3 b6 d5 2c  .....3...X.V...,
      0140: 19 12 d6 19 c4 ac 5e aa  d6 32 a9 21 43 89 b4 51  ......^..2.!C..Q
      0150: 34 4d c3 d7 45 c6 5a d9  89 59 b2 4d 2b ec da 70  4M..E.Z..Y.M+..p
      0160: 8e 0a 4e 9c b9 35 45 33  23 22 22 42 23 23 22 45  ..N..5E3#""B##"E
      0170: 19 95 51 98 31 a8 74 4f  4a 67 d9 cd 6b 4c ce 57  ..Q.1.tOJg..kL.W
      0180: a2 e0 a3 aa 46 d2 b3 28  a2 56 d9 96 84 e9 b4 5a  ....F..(.V.....Z
      0190: 9a e1 a3 28 49 b4 64 08  a9 a4 1f 99 26 88 b8 82  ...(I.d.....&...
      01a0: b2 12 30 b2 e5 9b 62 27  b0 8d 44 33 1a 64 86 aa  ..0...b'..D3.d..
      01b0: 2c 91 76 e2 03 a4 ee 60  5a c8 db 19 59 4c 51 60  ,.v....`Z...YLQ`
      01c0: 52 e0 bb 0a 12 de f1 a3  2e 62 32 d6 17 6e 25 66  R........b2..n%f
      01d0: 8e 46 a4 db 66 29 fe 70  b5 9c b9 35 b1 32 23 32  .F..f).p...5.2#2
      01e0: 20 42 23 22 21 5c 65 e2  4c aa 3c 49 e0 8d 24 5c   B#"!\e.L.<I..$\
      01f0: 85 de af 87 35 16 f4 ea  98 fa 3c 42 b5 5b 66 62  ....5.....<B.[fb
      0200: d7 11 95 2d 5a 34 b2 ca  f2 06 e4 63 50 b3 c6 69  ...-Z4.....cP..i
      0210: 3a 5c 74 56 bd 24 2b 15  86 a5 ce 81 cb 64 c5 22  :\tV.$+......d."
      0220: 8a a8 ce cc b5 c5 da 81  56 45 92 ac 22 ea aa 2b  ........VE.."..+
      0230: a2 a7 65 62 54 ee 59 91  1b a2 64 4f 68 ad ac 4e  ..ebT.Y...dOh..N
      0240: 0e 36 59 67 69 5f 8b 0c  21 ca b9 6a 5d 07 0d     .6Ygi_..!..j]..
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 46 time 30080 ssrc 1
      0000: 05 9c b9 35 c3 33 33 22  31 43 33 23 31 1d 69 98  ...5.33"1C3#1.i.
      0010: 8d 9c 33 10 74 6d 36 7e  a1 b6 eb a3 ca a7 f2 d8  ..3.tm6~........
      0020: c5 2c 2c 11 bf 97 8d b1  e9 a0 ad 3c b5 11 9a af  .,,........<....
      0030: 4e 67 d2 62 6c 17 86 d2  3a d1 53 55 8c 50 d3 93  Ng.bl...:.SU.P..
      0040: ba a2 d5 9d b8 e0 93 42  d9 f3 0e 26 b6 65 b4 d7  .......B...&.e..
      0050: 58 6c 36 2d 31 a6 2b bb  45 1b 56 69 a5 65 d5 4d  Xl6-1.+.E.Vi.e.M
      0060: 2c 9b 86 5b 4c 68 b1 68  cc 36 38 83 43 67 6c aa  ,..[Lh.h.68.Cgl.
      0070: 67 a3 b9 22 b2 74 9c 9c  b9 35 1a 33 33 22 12 43  g..".t...5.33".C
      0080: 33 22 22 15 e1 ec 8f ab  55 11 33 16 48 8d ea b1  3"".....U.3.H...
      0090: 29 76 db 98 ec dc 6b 3a  a6 dc a9 64 cb 53 68 a7  )v....k:...d.Sh.
      00a0: 20 fb b4 da 36 8c b6 c8  54 98 d4 3b 6c b0 3b 05   ...6...T..;l.;.
      00b0: 26 11 bb 6d 8b 3d 4c a1  cc db 19 25 b3 6b 22 6e  &..m.=L....%.k"n
      00c0: db 52 76 13 51 4f 78 c3  c4 ec da 50 5b 1c d9 1b  .Rv.QOx....P[...
      00d0: 65 db 63 e1 33 91 4b b7  32 5a c6 32 54 dc c4 49  e.c.3.K.2Z.2T..I
      00e0: 77 ac c8 53 4d 89 04 bb  a1 b1 79 90 35 9c b9 35  w..SM.....y.5..5
      00f0: c2 32 22 22 21 43 23 22  31 3c db 51 10 c1 c2 d0  .2""!C#"1<.Q....
      0100: 70 dc aa 9d d6 34 f3 43  78 27 6e cd 99 7e ba 3a  p....4.Cx'n..~.:
      0110: c5 84 59 b4 56 9f 20 cc  43 cd 07 43 0e 08 55 9b  ..Y.V. .C..C..U.
      0120: 65 7b 00 d1 33 68 ab 75  a4 04 6b b7 53 ab bf 56  e{..3h.u..k.S..V
      0130: a3 68 d1 b7 19 bc f0 30  b6 8d a8 4f 34 76 c3 2c  .h.....0...O4v.,
      0140: 4a 24 8a b8 28 21 60 6e  a3 db 82 55 2c b9 75 da  J$..(!`n...U,.u.
      0150: 88 c5 2f 5e 60 29 7d 06  8d 5f 2e e3 64 ba 03 81  ../^`)}.._..d...
      0160: f6 a4 62 9c b9 35 7f 33  33 32 32 42 23 33 32 35  ..b..5.3322B#325
      0170: b6 94 0d 81 13 81 b1 b6  dc ae 44 da a9 6c b8 d6  ..........D..l..
      0180: 2c 28 da fb 4e 44 bb 29  46 94 6a 66 95 1c 6c c2  ,(..ND.)F.jf..l.
      0190: 83 8c 2a 87 d9 65 d1 15  0a 86 3f 1a 70 d2 b9 9b  ..*..e....?.p...
      01a0: 83 d8 aa 70 95 b8 a9 9f  b5 5b 32 ac c6 d8 95 27  ...p.....[2....'
      01b0: 23 03 6d d0 93 a9 3a 52  5b 6d 56 99 b1 28 d4 5b  #.m...:R[mV..(.[
      01c0: 6d b5 6b 51 b6 ea 5a 65  2e da 4d a5 16 dd 15 62  m.kQ..Ze..M....b
      01d0: d3 aa 82 aa eb 49 d9 24  6d 9c b9 35 b2 43 33 22  .....I.$m..5.C3"
      01e0: 22 43 22 33 22 5a 4d 38  86 5b 11 a2 99 4d 21 42  "C"3"ZM8.[...M!B
      01f0: c4 4c 67 bd 68 83 77 a3  61 06 ca 6e 54 c0 1a 96  .Lg.h.w.a..nT...
      0200: ea da 68 85 06 9a 1b 98  99 12 f3 04 89 6a 26 94  ..h..........j&.
      0210: 11 81 a7 10 da 34 85 eb  89 a1 8a 85 27 2e 53 4d  .....4......'.SM
      0220: 49 da 47 15 2a d0 89 55  b3 69 aa 36 d3 92 cd d3  I.G.*..U.i.6....
      0230: 6e 4f a3 1b 96 31 12 e2  95 e2 a8 c9 85 53 47 a4  nO...1.......SG.
      0240: d4 91 ae 34 59 23 70 a6  4c 54 5e d0 ad 3f 34     ...4Y#p.LT^..?4
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 47 time 30720 ssrc 1
      0000: 05 9c b9 35 4f 32 33 32  22 42 23 32 22 2c a2 30  ...5O232"B#2",.0
      0010: 94 96 46 90 70 e9 90 5d  85 4e 2b 16 d5 25 b5 1a  ..F.p..].N+..%..
      0020: 64 f8 c8 c2 37 34 da 41  ce c7 14 c9 b6 ea 86 ca  d...74.A........
      0030: b8 24 c8 59 05 10 6d 25  3f 4d b0 29 eb 4c 0b 1b  .$.Y..m%?M.).L..
      0040: a9 85 a5 9c 55 5e 90 87  28 fa cc 62 57 c2 8c 53  ....U^..(..bW..S
      0050: e0 e4 94 3c 13 92 1e 25  10 97 a6 a0 18 5d b6 91  ...<...%.....]..
      0060: 5b c6 da 52 6d 26 ca d1  26 d9 14 48 b4 4b 41 26  [..Rm&..&..H.KA&
      0070: 80 32 50 89 d7 6a 12 9c  b9 35 e4 32 23 33 31 42  .2P..j...5.2#31B
      0080: 32 22 21 06 d1 a5 64 74  dd ab 72 2b 5b 5b 4e 2b  2"!...dt..r+[[N+
      0090: 63 66 88 d3 d8 47 18 ed  c3 b4 d5 c2 26 93 c5 92  cf...G......&...
      00a0: 34 46 60 64 96 c0 ea 23  7e 70 c0 bb 75 69 9b 86  4F`d...#~p..ui..
      00b0: 49 b1 a4 52 6d 6b 37 2d  8f 0a 0b 6e 6d 18 28 7a  I..Rmk7-...nm.(z
      00c0: 0e 92 32 ca c1 0f 93 a5  19 d8 5a aa b9 0d a4 91  ..2.......Z.....
      00d0: bc 72 85 72 64 c2 c6 2a  8a 6f 28 b1 b8 30 cb 24  .r.rd..*.o(..0.$
      00e0: bc 26 65 9f a5 6c 2a 82  5b 45 1a ce 84 9c b9 35  .&e..l*.[E.....5
      00f0: 53 31 32 22 32 43 33 23  21 1d 4b b5 84 dd dd 89  S12"2C3#!.K.....
      0100: 20 d1 ce 27 0a 94 b9 0a  20 83 d6 65 1b 0b c3 0c   ..'.... ..e....
      0110: 59 9e 2a 90 d3 bc da 36  1a 36 ab e1 e6 d4 ae ee  Y.*....6.6......
      0120: b5 7e 80 46 95 b3 4d 38  c5 16 25 fc 30 31 7e ac  .~.F..M8..%.01~.
      0130: 4c ab 58 db 40 05 99 6c  2e ee 9c 4d 70 13 89 57  L.X.@..l...Mp..W
      0140: 63 1a 49 60 d3 0b b3 2c  a5 db c4 da b6 9e 28 46  c.I`...,......(F
      0150: 1e 28 d7 6c cd b4 f1 4e  86 a1 49 50 aa 88 6a 45  .(.l...N..IP..jE
      0160: 3b 43 32 9c b9 35 43 42  33 32 20 43 32 32 20 52  ;C2..5CB32 C22 R
      0170: 85 0c a7 51 a3 42 76 75  65 32 ea 93 63 ad 4a 6c  ...Q.Bvue2..c.Jl
      0180: 95 78 e2 c4 de 0a 13 cc  b4 45 a6 d1 1a 65 a1 43  .x.......E...e.C
      0190: 11 99 74 83 2b 4d 31 4c  1e 36 9d 86 cd d4 da 1c  ..t.+M1L.6......
      01a0: c5 9d 34 4c 8b 0f 09 aa  55 51 6a 93 96 b0 4e af  ..4L....UQj...N.
      01b0: 18 55 94 4c 71 17 97 2a  75 e4 d8 46 9d 18 57 60  .U.Lq..*u..F..W`
      01c0: f0 b2 b5 a4 c8 c5 86 66  e8 2f 29 c5 4e ba 42 97  .......f./).N.B.
      01d0: 56 11 2b 55 95 f0 9a 9a  78 9c b9 35 be 42 22 32  V.+U....x..5.B"2
      01e0: 20 42 22 33 31 36 34 6b  09 a6 28 93 16 57 2a a4   B"3164k..(..W*.
      01f0: 18 b7 2d c5 27 48 f1 05  a4 97 86 34 a5 b9 52 24  ..-.'H.....4..R$
      0200: f8 a0 b1 1a 38 6e ad 49  25 82 ce 0d 55 aa ac 91  ....8n.I%...U...
      0210: 36 bb 04 72 e0 2b 43 f4  6d 0b 77 7a 0d 5a bd 97  6..r.+C.m.wz.Z..
      0220: 12 d3 71 1a ac d4 b4 d0  ba 44 d3 ab 35 c0 8d a2  ..q......D..5...
      0230: 32 95 66 89 c7 2e 8d a9  4a 04 44 cb 22 92 0f 41  2.f.....J.D."..A
      0240: e3 6d 0a eb 4d 43 55 13  8c e1 6c 6a d7 9e 5a     .m..MCU...lj..Z
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 48 time 31360 ssrc 1
      0000: 05 9c b9 35 3e 42 23 23  31 42 33 32 20 6e ab 12  ...5>B##1B32 n..
      0010: 68 d1 a3 2b b9 5a 13 3b  8b 1b a5 9b 96 5b d5 65  h..+.Z.;.....[.e
      0020: 0c 7f 51 17 13 ea 28 86  24 b2 c4 95 56 38 ab 8c  ..Q...(.$...V8..
      0030: 8e b1 69 50 b5 09 d3 4c  9d 89 69 90 c7 cc 69 b9  ..iP...L..i...i.
      0040: d9 50 7f 0c d3 6c d1 ce  6a 34 95 1b 2f 8a e8 93  .P...l..j4../...
      0050: 8b a6 d9 f3 70 92 9e e4  b6 84 eb 28 96 64 cb d4  ....p......(.d..
      0060: cc 64 ba c7 3e 29 c5 f1  4a 45 4a 93 6c a3 c0 4d  .d..>)..JEJ.l..M
      0070: a7 46 57 6c 39 39 68 9c  b9 35 58 42 32 33 21 42  .FWl99h..5XB23!B
      0080: 32 32 32 4f 6f a5 1f 97  11 6b 33 c9 a5 2d d0 dd  222Oo....k3..-..
      0090: 5c c3 a6 4e d5 c6 52 d6  4d 25 53 ca a8 d4 27 2a  \..N..R.M%S...'*
      00a0: 52 31 6e 26 a3 39 53 0c  a2 8b a5 bc b8 da a6 66  R1n&.9S........f
      00b0: 69 b2 c9 57 07 20 f1 6c  63 71 c6 29 88 e1 72 39  i..W. .lcq.)..r9
      00c0: 2d 44 6d 9c 9c 0d 9a b1  86 c5 e4 94 ad db 4d 43  -Dm...........MC
      00d0: 0f 28 c8 2d 0b 4b b0 ad  d3 35 64 f3 51 b3 70 31  .(.-.K...5d.Q.p1
      00e0: 6d c9 30 ae 6b 56 28 e5  b6 41 e8 d3 6d 9c b9 35  m.0.kV(..A..m..5
      00f0: db 43 13 33 21 42 23 22  22 37 2d b6 99 72 95 4a  .C.3!B#""7-..r.J
      0100: 78 ad 35 0d ca 66 60 b4  31 4a 5e 55 4a be 09 68  x.5..f`.1J^UJ..h
      0110: 4e c8 59 12 32 8b 71 39  02 72 1f 30 a3 4c 89 16  N.Y.2.q9.r.0.L..
      0120: d9 6c 32 da 9d d0 ba 94  df b6 49 2c ee b2 6f 11  .l2.......I,..o.
      0130: 36 a7 99 31 c2 b8 c9 34  ed d2 6c 90 b0 69 22 dc  6..1...4..l..i".
      0140: d8 08 d5 53 30 32 6e ca  68 34 9d 54 36 24 dc 43  ...S02n.h4.T6$.C
      0150: 75 13 9a d3 34 e4 8c 8a  9a 37 42 ba a7 d4 46 e1  u...4....7B...F.
      0160: ee 91 49 9c b9 35 d5 33  33 22 32 42 33 32 21 2e  ..I..5.33"2B32!.
      0170: 1d 86 52 f6 da 24 2e d1  36 b5 77 58 65 36 89 35  ..R..$..6.wXe6.5
      0180: ab 26 e0 5b 22 cd 27 da  2a d1 d9 eb 6d 2b 2f 34  .&.[".'.*...m+/4
      0190: 82 f4 d3 49 34 ad 50 b5  76 dc 46 bb 6c d5 9c 36  ...I4.P.v.F.l..6
      01a0: da fc 12 52 96 19 44 95  7c 54 69 36 6a 86 a1 94  ...R..D.|Ti6j...
      01b0: e2 4d 94 5a 34 8c 31 22  5e 23 a9 a4 e4 c8 5b 51  .M.Z4.1"^#....[Q
      01c0: 50 2c 86 8d 14 ab 26 72  52 b3 4d b0 19 55 24 03  P,....&rR.M..U$.
      01d0: eb 69 c4 ad 23 54 75 61  4c 9c b9 35 87 42 23 32  .i..#TuaL..5.B#2
      01e0: 21 42 23 32 21 43 ec ec  25 75 db 8b f7 76 70 62  !B#2!C..%u...vpb
      01f0: da a3 27 ba 3c 4a f0 32  ca a5 d9 53 4c 85 24 e5  ..'.<J.2...SL.$.
      0200: 34 4e ca 4d 6c b4 a9 a9  61 12 e8 4c d5 4b 6c 94  4N.Ml...a..L.Kl.
      0210: 91 bb 65 b2 4e 2d b6 1a  6d 55 43 55 22 83 70 e2  ..e.N-..mUCU".p.
      0220: 62 39 2c 65 2e a1 5b 4d  bc c8 69 b6 8a 0c 74 1a  b9,e..[M..i...t.
      0230: d8 4a d1 d6 67 b3 11 0c  d6 81 c5 3f 76 67 45 74  .J..g......?vgEt
      0240: 29 b1 29 bb 34 83 2e 55  a5 c4 9e 50 5b c9 ac     ).).4..U...P[..
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 49 time 32000 ssrc 1
      0000: 05 9c b9 35 b8 42 33 22  21 42 34 32 21 2e 92 94  ...5.B3"!B42!...
      0010: 06 ac 33 a4 37 67 68 f4  95 d5 61 d3 a7 25 7a ee  ..3.7gh...a..%z.
      0020: cc cc e9 b3 19 59 66 e3  76 46 24 6c 1b c2 99 42  .....Yf.vF$l...B
      0030: 15 a2 d9 8d b1 d8 c9 d5  4a 30 b5 b3 5a 9b 4b f3  ........J0..Z.K.
      0040: 87 79 36 f0 a4 4f cc 3b  6a 90 75 12 25 a1 99 4d  .y6..O.;j.u.%..M
      0050: f4 30 a0 6a ee 54 e4 55  a2 9b 75 68 58 6b 2c 41  .0.j.T.U..uhXk,A
      0060: 6b bc 1a 31 26 6d a9 4d  d6 25 5e c3 0c 2f 0a e6  k..1&m.M.%^../..
      0070: 09 75 6a 50 7b 69 4a 9c  b9 35 b6 42 23 33 20 42  .ujP{iJ..5.B#3 B
      0080: 23 32 20 46 f2 e6 85 ea  d9 e4 13 9b 4d 4f 0b 99  #2 F........MO..
      0090: 60 bc e2 6b 36 aa aa 6c  1d 1a 44 bc 26 43 25 34  `..k6..l..D.&C%4
      00a0: 9c 25 8e b6 9d 2d 94 c2  e0 d1 01 4b ab 96 97 b3  .%...-.....K....
      00b0: 6b 35 5f 1a 39 fb 2b 72  4e cb 0d 89 50 db 82 9a  k5_.9.+rN...P...
      00c0: 88 4c 37 4c e2 53 a1 bd  30 b8 76 da a6 15 a3 12  .L7L.S..0.v.....
      00d0: a1 38 c9 e6 ce da ed d4  b2 b3 4c 66 e3 e7 ad c4  .8........Lf....
      00e0: ed 0b b6 8d 99 71 a8 69  0d b4 da d9 4d 9c b9 35  .....q.i....M..5
      00f0: a7 32 32 22 20 42 33 32  11 17 18 59 46 cc ad 4d  .22" B32...YF..M
      0100: b1 0a 5a dc dd da 9d 37  26 d5 30 8a 9a 3e a3 38  ..Z....7&.0..>.8
      0110: a1 b6 78 44 4e 09 20 fa  50 a0 02 a8 a1 23 68 5d  ..xDN. .P....#h]
      0120: 40 b5 85 91 4f 16 cd d7  93 e0 14 1b 69 55 3f 4b  @...O.......iU?K
      0130: 11 91 c2 b5 52 aa f0 1a  a4 9d 53 8f 94 b0 93 28  ....R.....S....(
      0140: b4 d2 bd 41 46 9f 39 74  8c cd b5 26 2b c6 18 3a  ...AF.9t...&+..:
      0150: ef a1 ac 61 e9 95 5d 5f  70 47 43 0d ab c4 cb 6a  ...a..]_pGC....j
      0160: d5 68 6c 9c b9 35 a8 42  13 32 20 43 22 33 31 46  .hl..5.B.2 C"31F
      0170: 46 9a 90 bd 62 ad 54 2c  a1 05 f0 b2 e3 c3 56 a5  F...b.T,......V.
      0180: 2c ed 36 75 db 38 9d 48  51 b5 ea 9a 19 3b d3 4d  ,.6u.8.HQ....;.M
      0190: 33 54 b9 84 db da 8e 4e  73 75 63 06 dc 93 4c a3  3T.....Nsuc...L.
      01a0: 64 53 92 d9 76 e1 25 4f  cd 65 1a f7 4c 8c 4c dd  dS..v.%O.e..L.L.
      01b0: b8 d6 c4 28 d3 72 86 44  fe 03 56 35 60 49 aa 6c  ...(.r.D..V5`I.l
      01c0: 5d a6 3b 48 ad a9 25 0d  84 68 5a 6d 1d b7 39 56  ].;H..%..hZm..9V
      01d0: 70 1b 6f f6 c2 83 39 97  51 9c b9 35 2d 32 33 32  p.o...9.Q..5-232
      01e0: 31 32 32 22 31 1e 0a 15  60 d4 48 9c f4 90 db 65  122"1...`.H....e
      01f0: 15 48 a3 78 84 cb 2e c9  14 db c4 b5 0f 46 6c c3  .H.x.........Fl.
      0200: 5d 9c b6 19 b3 16 2e 72  ae c0 0e 03 72 7b 69 aa  ]......r....r{i.
      0210: 97 4f 4b 98 8a a1 0e 35  62 d3 45 d9 a8 61 bb 48  .OK....5b.E..a.H
      0220: 91 e4 eb 1a 05 5d 56 cd  b9 75 58 2e c3 4a ef b4  .....]V..uX..J..
      0230: c6 8d f8 c2 2a d9 c6 37  3a 4d 41 2a 6a ee c0 d6  ....*..7:MA*j...
      0240: 15 51 3b 74 a1 81 44 9a  4a bc a3 89 91 88 5b     .Q;t..D.J.....[
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 223
    L2CAP(d): cid 0x0058 len 603 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 50 time 32640 ssrc 1
      0000: 05 9c b9 35 2e 32 33 32  31 42 32 33 31 76 14 47  ...5.2321B231v.G
      0010: 54 e3 28 eb 67 0d 24 d5  1b 36 e1 c8 69 36 b6 ad  T.(.g.$..6..i6..
      0020: 24 d9 3b 81 a5 b6 68 b0  4d da 31 5b b3 49 8f 8e  $.;...h.M.1[.I..
      0030: 19 a4 e9 5c 77 55 76 ec  76 ae 94 ae 9c 44 8b b7  ...\wUv.v....D..
      0040: 86 9a 46 5d 46 92 f2 47  18 f6 a9 b4 94 9c 96 8d  ..F]F..G........
      0050: 46 69 42 f2 ee 06 cd 42  8e 35 46 76 3a e2 69 6d  FiB....B.5Fv:.im
      0060: d9 db 8d b2 8d 1a 69 fd  53 6d 57 88 cb 2f 0f 1b  ......i.SmW../..
      0070: 61 d1 c7 19 d6 56 63 9c  b9 35 05 32 23 32 20 42  a....Vc..5.2#2 B
      0080: 23 32 21 66 32 14 97 b6  49 6c a4 37 10 b4 ce d9  #2!f2...Il.7....
      0090: 63 6c 56 c5 37 0c 70 8b  44 36 1f a9 86 02 62 56  clV.7.p.D6....bV
      00a0: e4 ba 53 bc ae 8d 0e c6  e8 2d d5 f3 86 61 66 d0  ..S......-...af.
      00b0: c9 b4 8b ab 2b 15 93 84  15 1d aa 50 9a a6 88 b2  ....+......P....
      00c0: af 1c 4f 21 a5 51 94 76  c5 aa 2e da c9 da ba a7  ..O!.Q.v........
      00d0: 59 46 d5 d2 99 41 7a 63  38 2e f0 a9 26 59 95 84  YF...Azc8...&Y..
      00e0: 95 37 69 3a e4 cc c5 cc  a2 69 b8 d4 4e 9c b9 35  .7i:.....i..N..5
      00f0: d8 42 23 23 21 52 23 23  30 6a 85 49 57 54 36 ab  .B##!R##0j.IWT6.
      0100: fc 56 22 e1 a1 c8 96 86  46 55 48 ae 16 9d 36 09  .V".....FUH...6.
      0110: 2b 19 61 b5 78 10 25 6c  3c 6d a1 29 61 ab d6 98  +.a.x.%l<m.)a...
      0120: 92 29 b5 4d 6c f0 c4 70  52 a2 23 a5 66 59 5a c1  .).Ml..pR.#.fYZ.
      0130: 01 55 c9 32 93 1b 99 12  a5 e2 b4 d1 c8 57 55 10  .U.2.........WU.
      0140: 16 a5 1e fa 46 39 f9 69  ba 32 0d b5 fa 24 31 9b  ....F9.i.2...$1.
      0150: 83 8d c9 93 28 51 19 f5  46 42 5f 52 87 d2 14 31  ....(Q..FB_R...1
      0160: d6 49 5b 9c b9 35 ab 42  33 32 31 52 23 22 32 6b  .I[..5.B321R#"2k
      0170: 2a 36 93 e2 e2 4d 38 4e  0a c9 95 9c 16 bb 30 b4  *6...M8N......0.
      0180: 8a 0c 9a a6 11 ba 21 2d  45 04 6e cd cc db 68 57  ......!-E.n...hW
      0190: 19 66 d9 67 1d 78 b2 4c  32 93 60 9a ad af d0 b6  .f.g.x.L2.`.....
      01a0: 9a 82 d5 2d 53 30 46 cd  38 5a 62 f9 69 b8 7a 54  ...-S0F.8Zb.i.zT
      01b0: a3 9b a3 30 34 52 9a 58  fe 92 55 2c a9 08 26 fc  ...04R.X..U,..&.
      01c0: 52 11 74 48 36 11 68 d6  88 43 52 34 69 c8 4d 4a  R.tH6.h..CR4i.MJ
      01d0: 1c 05 24 c5 c4 52 c2 a0  4d 9c b9 35 9d 52 23 22  ..$..R..M..5.R#"
      01e0: 22 43 23 22 21 4d 33 93  41 34 e8 eb 73 94 19 27  "C#"!M3.A4..s..'
      01f0: 77 04 95 29 b9 20 cb b6  92 6d d6 3e 42 5d 56 25  w..). ...m.>B]V%
      0200: 73 93 10 2e b6 10 2f 55  8d 09 b2 71 49 a9 31 2c  s...../U...qI.1,
      0210: 54 b9 4e 4d dd db 4a ad  d3 41 4f 91 20 11 32 65  T.NM..J..AO. .2e
      0220: 6b 22 7b 0e 19 97 1d 54  a5 9c 14 ea 77 02 c6 59  k"{....T....w..Y
      0230: c8 ac d2 29 07 b2 ed 29  76 ce 37 33 21 6d 4b 54  ...)...)v.73!mKT
      0240: 6a 99 7b 52 47 4e c5 41  cb 4a 91 6a 6d 63 69     j.{RGN.A.J.jmci
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0057 len 3 [psm 25]
      AVDTP(s): Suspend cmd: transaction 7
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Suspend rsp: transaction 7

--------------050309090805050206000405--
