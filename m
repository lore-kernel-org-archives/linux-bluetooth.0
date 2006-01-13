Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-devel] Problem with AnD Medical devices using Bluetooth
Message-ID: <44BDAFB888F59F408FAE3CC35AB4704102C26609@orsmsx409>
From: "Zou, Yixiong" <yixiong.zou@intel.com>
To: <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 13 Jan 2006 10:43:19 -0800

Hi,=20

I am working on a project right now to integrate some medical devices =
with our platform.  And we are having trouble with a particular device, =
made by AnD.  It is a weight scale that can transmit the data to a =
computer over Bluetooth.  Since this is not a very common device, I will =
describe the behavior briefly.  The device itself can store up to 40 =
records.  And once a connection is made, it will transmit all of its =
records in memory one by one.  We have the device working properly under =
windows XP, using the Widcomm stack as the Bluetooth driver.  Once the =
device was paired up, we were able to receive all of its records every 5 =
seconds or so.   However, we could not get the device to work properly =
with Linux/Bluez.  Here's how the device works: it makes a connection to =
a Bluetooth device, and then finds out if a Serial port is available, if =
it is, then it makes a connection with the Rfcomm server and uploads the =
record.  If the ack 'PWA1' is received after the first upload, the =
upload process is repeated until all the records are uploaded.  We are =
able to successfully receive the first upload, but on the second upload, =
after the SDP query is finished, the device never makes a connection =
with the rfcomm server.  We've been looking at the hcidump for a couple =
days now and couldn't get any clue why this happened.  That's why I am =
asking for help here.  I am running a vanilla 2.6.15 kernel with Fedora =
core 4.  The Bluez lib/utils version is 2.15.  But I've tried Bluez =
lib/utils 2.24, the results are the same.  The hcidump is attached at =
the end.  Any suggestion would help. =20

Thank you so much for looking.  I apologize for the length of this post. =
=20

[root@Matrix bluetooth]# hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  0000: 1c 3b 0d 96 a0 00 00 00  00 01                    .;........
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:A0:96:0D:3B:1C role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 1c 3b 0d 96 a0 00                                 .;....
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:A0:96:0D:3B:1C
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0c 04 00 1c 3b 0d 96  a0 00                    .....;....
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:A0:96:0D:3B:1C
> HCI Event: PIN Code Request (0x16) plen 6
  0000: 1c 3b 0d 96 a0 00                                 .;....
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0c 04 00 1c 3b 0d 96  a0 00                    .....;....
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:A0:96:0D:3B:1C len 8 pin '39121440'
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0d 04 00 1c 3b 0d 96  a0 00                    .....;....
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:A0:96:0D:3B:1C len 8 pin '39121440'
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0d 04 00 1c 3b 0d 96  a0 00                    .....;....
> HCI Event: PIN Code Request (0x16) plen 6
  0000: 1c 3b 0d 96 a0 00                                 .;....
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:A0:96:0D:3B:1C len 8 pin '39121440'
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0d 04 00 1c 3b 0d 96  a0 00                    .....;....
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:A0:96:0D:3B:1C len 8 pin '39121440'
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0d 04 00 1c 3b 0d 96  a0 00                    .....;....
> HCI Event: Link Key Notification (0x18) plen 23
  0000: 1c 3b 0d 96 a0 00 5b d6  0e 90 e8 84 da f8 9c a9  =
.;....[.........
  0010: e6 d8 80 12 1d fa 00                              .......
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 06 00 1c 3b 0d 96 a0  00 01 01                 ....;......
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 06 00                                 ......
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 6 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
  0000: 06 00 18 cc                                       ....
> HCI Event: Command Status (0x0f) plen 4
  0000: 0c 01 0f 04                                       ....
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 06 00 05                                          ...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x9
          count 1
          handle 0x10001
          cont 00
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 4
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          handle 0x10001
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 6 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          count 19
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 325
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 325
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 319 max_retrans 0 credits 0
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 319 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 6
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 17
> ACL data: handle 6 flags 0x01 dlen 14
    L2CAP(d): cid 0x0041 len 78 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 74 fcs 0x9a
      0000: 02 00 0e 00 00 00 41 01  00 d5 07 0c 13 0c 37 2d  =
......A.......7-
      0010: d6 07 01 0b 09 31 17 1c  3b 0d 96 a0 00 58 03 b0  =
.....1..;....X..
      0020: 60 10 00 39 30 35 30 35  30 30 30 33 32 20 20 00  =
`..9050500032  .
      0030: 00 00 00 00 00 00 00 00  00 c1 00 11 53 54 2c 2b  =
............ST,+
      0040: 30 30 30 33 2e 30 6c 62  0d 0a                    0003.0lb..
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 6 fcs 0x40
      0000: 50 57 41 31 0d 0a                                 PWA1..
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 2 pf 1 ilen 0 fcs 0xd9
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 2 pf 1 ilen 0 fcs 0xf3
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0042
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0042 result 0 status 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x1101 (SP)
          max 40
          cont 00
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0042 len 14 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x9
          count 1
          handle 0x10001
          cont 00
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 4
    L2CAP(d): cid 0x0040 len 17 [psm 1]
        SDP SA Req: tid 0x2 len 0xc
          handle 0x10001
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
< ACL data: handle 6 flags 0x02 dlen 31
    L2CAP(d): cid 0x0042 len 27 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x16
          count 19
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0042
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0042
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 06 00 08                                       ....




-----------------------------------

Yixiong Zou (yixiong.zou@intel.com)
Open Source Technology Center
Intel Corp.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
