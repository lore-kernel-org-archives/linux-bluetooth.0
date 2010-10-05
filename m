Return-Path: <cyrus@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: New Broadcom chip in W510
From: Lu Ran <hephooey@gmail.com>
Date: Tue, 5 Oct 2010 08:59:30 -0400
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yEyqMsn/OHNbPj3"
Message-Id: <201010050859.30485.hephooey@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_yEyqMsn/OHNbPj3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On Tuesday 05 October 2010 08:13:59 you wrote:
> > I put the output ot "cat /proc/bus/usb/devices" in the attachment, I am
> > pretty sure the setup of my software is OK, because now I can use my
> > bluetooth headset with an dongle, but it does not work for the internal
> > chip.
> 
> maybe that hardware has some limitations that are unclear to me. Can you
> run hcidump -X -V and give us the output when trying to establish a SCO
> connection.

Here is the output of hcidump. This issue might be related to the usb code, 
when I test the dongle, it gives the same error when I connect it through a 
usb3 port, it only works with usb2 port, but for the internal broadcom chip, 
nothing changes even when I remove the xhci_hcd module.

-- 
Best Regards,
LR

--Boundary-00=_yEyqMsn/OHNbPj3
Content-Type: text/x-log;
  charset="utf-8";
  name="hcidump.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hcidump.log"

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:19:7F:D8:6A:C3 class 0x200404 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:19:7F:D8:6A:C3 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:19:7F:D8:6A:C3 role 0x00
    Role: Master
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:19:7F:D8:6A:C3
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:19:7F:D8:6A:C3 key 9741E3A1976D406A2667C8926C02BDBE
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:19:7F:D8:6A:C3
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 00:19:7F:D8:6A:C3 type ACL encrypt 0x01
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 11
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 11
    Features: 0xbc 0xe8 0x01 0x00 0x08 0x08 0x00 0x00
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:19:7F:D8:6A:C3 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 48 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:19:7F:D8:6A:C3 name 'ATT V521'
> ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x111f (Handsfree AG)
          max 40
          cont 00
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x9
          count 1
          handle 0x10001
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          handle 0x10001
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 11 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          count 19
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0xd > >
          cont 00
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 132 
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 132 
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 1013 
> ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 26 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 126 max_retrans 0 credits 0
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 26 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 126 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xe7 
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 11
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:19:7F:D8:6A:C3
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:19:7F:D8:6A:C3 key 9741E3A1976D406A2667C8926C02BDBE
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:19:7F:D8:6A:C3
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 11
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
    handle 11 encrypt 0x01
> HCI Event: Command Status (0x0f) plen 4
    Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 11 encrypt 0x01
< ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 26 pf 1 ilen 0 fcs 0x2c 
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 9
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 9
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 0 len 9
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 26 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 0 b3 0 len 9
< ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 1 ilen 0 fcs 0x22 credits 33
> ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 0 fcs 0xf8 credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 0 ilen 11 fcs 0xe4 
      0000: 41 54 2b 42 52 53 46 3d  32 34 0d                 AT+BRSF=24.
< ACL data: handle 11 flags 0x02 dlen 22
    L2CAP(d): cid 0x0041 len 18 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 14 fcs 0x3e 
      0000: 0d 0a 2b 42 52 53 46 3a  20 33 35 32 0d 0a        ..+BRSF: 352..
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 2
      0000: 41 54 2b 43 49 4e 44 3d  3f 0d                    AT+CIND=?.
< ACL data: handle 11 flags 0x02 dlen 134
    L2CAP(d): cid 0x0041 len 130 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 126 fcs 0x3e 
      0000: 0d 0a 2b 43 49 4e 44 3a  20 28 22 62 61 74 74 63  ..+CIND: ("battc
      0010: 68 67 22 2c 28 30 2d 35  29 29 2c 28 22 73 69 67  hg",(0-5)),("sig
      0020: 6e 61 6c 22 2c 28 30 2d  35 29 29 2c 28 22 73 65  nal",(0-5)),("se
      0030: 72 76 69 63 65 22 2c 28  30 2c 31 29 29 2c 28 22  rvice",(0,1)),("
      0040: 63 61 6c 6c 22 2c 28 30  2c 31 29 29 2c 28 22 63  call",(0,1)),("c
      0050: 61 6c 6c 73 65 74 75 70  22 2c 28 30 2d 33 29 29  allsetup",(0-3))
      0060: 2c 28 22 63 61 6c 6c 68  65 6c 64 22 2c 28 30 2d  ,("callheld",(0-
      0070: 32 29 29 2c 28 22 72 6f  61 6d 22 2c 28 30        2)),("roam",(0
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 
      0000: 2c 31 29 29 0d 0a                                 ,1))..
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 9 fcs 0xf8 credits 2
      0000: 41 54 2b 43 49 4e 44 3f  0d                       AT+CIND?.
< ACL data: handle 11 flags 0x02 dlen 32
    L2CAP(d): cid 0x0041 len 28 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 24 fcs 0x3e 
      0000: 0d 0a 2b 43 49 4e 44 3a  20 35 2c 35 2c 31 2c 30  ..+CIND: 5,5,1,0
      0010: 2c 30 2c 30 2c 30 0d 0a                           ,0,0,0..
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 27
> ACL data: handle 11 flags 0x01 dlen 1
    L2CAP(d): cid 0x0041 len 24 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 19 fcs 0xf8 credits 2
      0000: 41 54 2b 43 4d 45 52 3d  33 2c 20 30 2c 20 30 2c  AT+CMER=3, 0, 0,
      0010: 20 31 0d                                           1.
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 26 pf 1 ilen 10 fcs 0xf8 credits 2
      0000: 41 54 2b 56 47 53 3d 31  35 0d                    AT+VGS=15.
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 6 fcs 0x3e 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 11 encrypt 0x00
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:19:7F:D8:6A:C3 role 0x01
    Role: Slave
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 11 encrypt 0x01
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
    handle 11 voice setting 0x0060
> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x00 handle 1 bdaddr 00:19:7F:D8:6A:C3 type SCO
    Air mode: CVSD
< ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 11 fcs 0x3e 
      0000: 0d 0a 2b 56 47 53 3d 31  35 0d 0a                 ..+VGS=15..
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 26 pf 0 ilen 10 fcs 0x3e 
      0000: 0d 0a 2b 56 47 4d 3d 30  0d 0a                    ..+VGM=0..
< SCO data: handle 1 flags 0x00 dlen 48
    0000: 07 00 fb ff 04 00 fa ff  01 00 fb ff 04 00 fb ff  ................
    0010: 02 00 fb ff 05 00 fa ff  03 00 fd ff 02 00 fc ff  ................
    0020: 03 00 fb ff 05 00 fa ff  05 00 fa ff 06 00 fa ff  ................
< SCO data: handle 1 flags 0x00 dlen 48
    0000: 04 00 fc ff 05 00 f9 ff  07 00 fb ff 05 00 fc ff  ................
    0010: 05 00 fc ff 07 00 f7 ff  08 00 fd ff 06 00 fb ff  ................
    0020: 07 00 f8 ff 07 00 f9 ff  09 00 f8 ff 07 00 fa ff  ................
< SCO data: handle 1 flags 0x00 dlen 48
    0000: 09 00 f9 ff 06 00 f6 ff  0b 00 fa ff 07 00 f6 ff  ................
    0010: 09 00 f4 ff 07 00 f7 ff  0b 00 f4 ff 0b 00 f5 ff  ................
    0020: 0a 00 f1 ff 0e 00 f4 ff  0f 00 f6 ff 11 00 f2 ff  ................
< SCO data: handle 1 flags 0x00 dlen 48
    0000: 13 00 f1 ff 17 00 eb ff  1e 00 eb ff 25 00 d9 ff  ............%...
    0010: 52 00 b4 00 1e 01 43 00  a8 ff 1d fe 53 01 76 ff  R.....C.....S.v.
    0020: 37 fe e4 00 a7 fd bb 00  4e ff 4a 01 8b ff 93 01  7.......N.J.....
< SCO data: handle 1 flags 0x00 dlen 48
    0000: fa fc 73 ff 04 05 cd 00  27 fc 25 ff 03 01 d9 00  ..s.....'.%.....
    0010: cb 03 c0 00 1b fe 83 ff  5b ff d4 fc 12 03 53 fe  ........[.....S.
    0020: 30 fd c9 fd 40 04 d0 01  95 02 e0 fa 53 00 63 04  0...@.......S.c.
< SCO data: handle 1 flags 0x00 dlen 48
    0000: 81 d5 87 d9 a4 de 31 e5  5a eb 2e f2 2d fa b5 01  ......1.Z...-...
    0010: 68 08 b4 0f ae 16 01 1c  c0 20 f3 24 16 27 a9 27  h........ .$.'.'
    0020: 25 28 0f 27 0e 23 98 1e  c1 19 14 13 83 0b 05 04  %(.'.#..........
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host

--Boundary-00=_yEyqMsn/OHNbPj3--
