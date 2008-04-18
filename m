Return-Path: <cyrus@holtmann.org>
Message-ID: <48093316.3070906@powercraft.nl>
Date: Sat, 19 Apr 2008 01:47:34 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <48092EF6.3090603@powercraft.nl>
In-Reply-To: <48092EF6.3090603@powercraft.nl>
Content-Type: multipart/mixed; boundary="------------050109020107060904000300"
Subject: Re: [Bluez-users] Samsung WEP210 Bluetooth Headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050109020107060904000300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jelle de Jong wrote:
> This message contains the following attachment(s):
> Samsung WEP210 Bluetooth Headset.txt
> simple-agent
> 
> Hello everybody,
> 
> I bought a new headset and am trying to get it working under debian sid 
> 3.30-2 bluez-utils
> 
> However i cant connect to the device when it is in pairing mode.
> 
> I have attached my working files with a lot of background information.
> 
> Can somebody help me to get the device working.
> 

Some updated information with a full hcidump

Kind regards,

Jelle

--------------050109020107060904000300
Content-Type: text/plain;
 name="hciconfig-a.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hciconfig-a.txt"

 hciconfig -a
hci0:   Type: USB
    BD Address: 00:1B:DC:00:32:71 ACL MTU: 310:10 SCO MTU: 64:8
    UP RUNNING PSCAN ISCAN
    RX bytes:3311300 acl:6850 sco:62541 events:778 errors:0
    TX bytes:7160 acl:289 sco:0 commands:177 errors:0
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy: RSWITCH HOLD SNIFF PARK
    Link mode: SLAVE ACCEPT
    Name: 'debian-eeepc-0'
    Class: 0x080100
    Service Classes: Capturing
    Device Class: Computer, Uncategorized
    HCI Ver: 2.0 (0x3) HCI Rev: 0xc5c LMP Ver: 2.0 (0x3) LMP Subver: 0xc5c
    Manufacturer: Cambridge Silicon Radio (10)

--------------050109020107060904000300
Content-Type: text/plain;
 name="hcidump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump.txt"

HCI sniffer - Bluetooth packet analyzer ver 1.41
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  0000: 5a a9 15 09 07 20 04 04  20 01                    Z.... .. .
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 5a a9 15 09 07 20 00                              Z.... .
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Role Change (0x12) plen 8
  0000: 00 5a a9 15 09 07 20 00                           .Z.... .
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2b 00 5a a9 15 09 07  20 01 00                 .+.Z.... ..
< ACL data: handle 43 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  0000: 2b 00                                             +.
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 5a a9 15 09 07 20 01                              Z.... .
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 1b 04                                       ....
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 2b 00 0f 00                                       +...
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 2b 00                                 ....+.
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  0000: 2b 00 18 cc                                       +...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 0f 04                                       ....
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 5a a9 15 09 07 20 02 00  00 00                    Z.... ....
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 2b 00 1e 33                                    .+..3
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
> HCI Event: Read Remote Supported Features (0x0b) plen 11
  0000: 00 2b 00 fc fe 0f 00 08  08 00 00                 .+.........
> HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 5a a9 15 09 07 20 53  61 6d 73 75 6e 67 20 57  .Z.... Samsung W
  0010: 45 50 32 31 30 00 00 00  00 00 00 00 00 00 00 00  EP210...........
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............
> HCI Event: Link Key Request (0x17) plen 6
  0000: 5a a9 15 09 07 20                                 Z.... 
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 5a a9 15 09 07 20 10 ed  c2 db ba 8d bf 44 9a de  Z.... .......D..
  0010: 67 50 10 5a 46 d9                                 gP.ZF.
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 5a a9 15 09  07 20                    ....Z.... 
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x004a
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004a result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x004a flags 0x00 result 0 clen 4
      MTU 48 
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004a flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 43 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-32 0x111f (Handsfree AG)
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(d): cid 0x004a len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x004a
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x004a
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2b 00 01 00                                    .+...
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 2b 00 13                                       .+..
> HCI Event: Connect Request (0x04) plen 10
  0000: 5a a9 15 09 07 20 04 04  20 01                    Z.... .. .
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 5a a9 15 09 07 20 00                              Z.... .
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Role Change (0x12) plen 8
  0000: 00 5a a9 15 09 07 20 00                           .Z.... .
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2a 00 5a a9 15 09 07  20 01 00                 .*.Z.... ..
< ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  0000: 2a 00                                             *.
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 5a a9 15 09 07 20 01                              Z.... .
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 1b 04                                       ....
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 2a 00 0f 00                                       *...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 2a 00                                 ....*.
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  0000: 2a 00 18 cc                                       *...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 0f 04                                       ....
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 5a a9 15 09 07 20 02 00  00 00                    Z.... ....
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 2a 00 1e 33                                    .*..3
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
> HCI Event: Read Remote Supported Features (0x0b) plen 11
  0000: 00 2a 00 fc fe 0f 00 08  08 00 00                 .*.........
> HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 5a a9 15 09 07 20 53  61 6d 73 75 6e 67 20 57  .Z.... Samsung W
  0010: 45 50 32 31 30 00 00 00  00 00 00 00 00 00 00 00  EP210...........
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............
> HCI Event: Link Key Request (0x17) plen 6
  0000: 5a a9 15 09 07 20                                 Z.... 
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 5a a9 15 09 07 20 10 ed  c2 db ba 8d bf 44 9a de  Z.... .......D..
  0010: 67 50 10 5a 46 d9                                 gP.ZF.
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 5a a9 15 09  07 20                    ....Z.... 
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x004b
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004b result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x004b flags 0x00 result 0 clen 4
      MTU 48 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004b flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-32 0x1112 (Headset AG)
          max 38
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
< ACL data: handle 42 flags 0x02 dlen 33
    L2CAP(d): cid 0x004b len 29 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x18
          count 21
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xc > >
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x004b
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x004b
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x004c
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004c result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 132 
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x004c flags 0x00 result 0 clen 4
      MTU 132 
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x004c flags 0x00 clen 4
      MTU 1013 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 1013 
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x004c len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 24 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 126 max_retrans 0 credits 0
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x004c len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 24 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 126 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 24 pf 1 ilen 0 fcs 0xa2 
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
  0000: 2a 00                                             *.
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 11 04                                       ....
> HCI Event: Auth Complete (0x06) plen 3
  0000: 00 2a 00                                          .*.
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
  0000: 2a 00 01                                          *..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 13 04                                       ....
> HCI Event: Encrypt Change (0x08) plen 4
  0000: 00 2a 00 01                                       .*..
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x004c len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 24 pf 1 ilen 0 fcs 0x69 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x004c len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< HCI Command: Change Connection Link Key (0x01|0x0015) plen 2
  0000: 2a 00                                             *.
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x004c len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 24 pf 1 ilen 0 fcs 0x22 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 15 04                                       ....
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Link Key Notification (0x18) plen 23
  0000: 5a a9 15 09 07 20 4d 00  fa df 23 f9 5e 49 93 93  Z.... M...#.^I..
  0010: 30 3d e8 c4 0b 55 00                              0=...U.
> HCI Event: Change Connection Link Key Complete (0x09) plen 3
  0000: 00 2a 00                                          .*.
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 1 len 14
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x004c len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 1 len 14
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x004c len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 24 pf 1 ilen 0 fcs 0xc8 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 24 pf 1 ilen 0 fcs 0x12 credits 15
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 24 pf 1 ilen 0 fcs 0x8 
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x004c len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 0 dlci 24 pf 1 ilen 0 fcs 0xe9 
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 0 dlci 24 pf 1 ilen 0 fcs 0xe9 
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 0 pf 1 ilen 0 fcs 0xb6 
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004c scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2a 00 01 00                                    .*...
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004c scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 2a 00 13                                          *..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 2a 00 16                                       .*..
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 5a a9 15 09 07 20 18 cc  02 00 00 00 01           Z.... .......
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2c 00 5a a9 15 09 07  20 01 00                 .,.Z.... ..
< ACL data: handle 44 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  0000: 2c 00                                             ,.
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 1b 04                                       ....
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 2c 00 0f 00                                       ,...
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 5a a9 15 09 07 20 01                              Z.... .
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 2c 00                                 ....,.
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 5a a9 15 09 07 20 02 00  00 00                    Z.... ....
> HCI Event: Read Remote Supported Features (0x0b) plen 11
  0000: 00 2c 00 fc fe 0f 00 08  08 00 00                 .,.........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
> ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004d scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004d scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004d flags 0x00 clen 0
> HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 5a a9 15 09 07 20 53  61 6d 73 75 6e 67 20 57  .Z.... Samsung W
  0010: 45 50 32 31 30 00 00 00  00 00 00 00 00 00 00 00  EP210...........
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> ACL data: handle 44 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
< ACL data: handle 44 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x004d flags 0x00 result 0 clen 4
      MTU 48 
< ACL data: handle 44 flags 0x02 dlen 17
    L2CAP(d): cid 0x004d len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1108 (Headset)
          max 64
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> ACL data: handle 44 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x5
          count 0
          cont 00
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004d scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
> ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004d scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 2c 00 13                                          ,..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 2c 00 16                                       .,..

--------------050109020107060904000300
Content-Type: text/plain;
 name="Samsung WEP210 Bluetooth Headset.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Samsung WEP210 Bluetooth Headset.txt"

#!/bin/bash

http://gentoo-wiki.com/HOWTO_use_a_bluetooth_headset
http://www.wahlau.org/failed_getting_bluetooth_headset_to_work_with_ubuntu_edgy_eft
http://www.think-future.de/wiki/index.php?title=Bluetooth

sudo cp /etc/bluetooth/audio.conf /etc/bluetooth/audio.conf.backup
sudo mv /etc/bluetooth/audio.conf.backup /etc/bluetooth/audio.conf


cp $HOME/.asoundrc $HOME/.asoundrc.backup

# step 1: install bluetooth alsa software
sudo apt-get install bluetooth-alsa bluez-utils

# step 2: enable bluetooth alsa service


echo '[Bluetooth Service]
Identifier=audio
Name=Audio service
Description=Bluetooth Audio service
Autostart=true' | sudo tee /etc/bluetooth/audio.conf

echo '[Bluetooth Service]
Identifier=audio
Name=Audio service
Description=Bluetooth Audio service
Autostart=true' | sudo tee /etc/bluetooth/audio.service

cat /etc/bluetooth/audio.service

cat /etc/bluetooth/audio.conf

hcitool scan
20:07:09:15:A9:5A
sudo sdptool browse 20:07:09:15:A9:5A

sudo sdptool search HS
Inquiring ...
Searching for HS on 20:07:09:15:A9:5A ...
Service Name: Headset
Service RecHandle: 0x10001
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

echo 'pcm.bluetooth {
   type bluetooth
   device 20:07:09:15:A9:5A
   profile "auto"
}' | tee --append $HOME/.asoundrc

sudo hcitool cc 20:07:09:15:A9:5A

cat $HOME/.asoundrc

sudo /etc/init.d/bluetooth restart
sudo /etc/init.d/alsa-utils restart

sudo apt-get install mplayer

mplayer -ao alsa:device=bluetooth test.mp3
arecord -D bluetooth -f S16_LE | aplay -D bluetooth -f S16_LE

sudo modprobe snd-bt-sco
dbus-send --system --dest=org.bluez /org/bluez/hci0 org.bluez.Adapter.SetMode string:discoverable
btsco -v  20:07:09:15:A9:5A
sudo a2dpd

pcm.bluetooth {
    type plug
    slave {
       pcm "bluetooth_hw"
    }
}

pcm.bluetooth_hw {
    type bluetooth
    device 00:0B:2E:5B:30:E6
}

sudo hidd --connect 20:07:09:15:A9:5A
sudo l2ping 20:07:09:15:A9:5A

passkey-agent 0000 20:07:09:15:A9:5A

echo 0000 | sudo tee /etc/bluetooth/pin

sdptool search 20:07:09:15:A9:5A
hcitool cc 20:07:09:15:A9:5A
sudo /etc/init.d/syslog restart

sudo /etc/init.d/sysklogd start
sudo /etc/init.d/klogd start

sudo cat /var/log/syslog

sudo vim /etc/bluetooth/hcid.conf
pin_helper /etc/bluetooth/feed-pin.sh;


echo '#!/bin/sh
echo "PIN:0000"' | sudo tee /etc/bluetooth/feed-pin.sh


Apr 19 00:56:29 debian-eeepc hcid[5705]: Audio API: received BT_GETCAPABILITIES_REQ
Apr 19 00:56:29 debian-eeepc hcid[5705]: Audio API: sending BT_GETCAPABILITIES_RSP
Apr 19 00:56:29 debian-eeepc hcid[5705]: Audio API: received BT_SETCONFIGURATION_REQ
Apr 19 00:56:29 debian-eeepc hcid[5705]: config sco - device = 20:07:09:15:A9:5A access_mode = 2
Apr 19 00:56:32 debian-eeepc hcid[5705]: pin_code_request (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
Apr 19 00:56:32 debian-eeepc hcid[5705]: connect(): Connection refused (111)
Apr 19 00:56:32 debian-eeepc hcid[5705]: config failed
Apr 19 00:56:32 debian-eeepc hcid[5705]: Audio API: sending BT_SETCONFIGURATION_RSP

Package: bluez-utils
Version: 3.30-2



dbus-send --system --type=method_call --print-reply --dest=":1.20" \
/org/bluez/audio org.bluez.audio.Manager.CreateDevice string:20:07:09:15:A9:5A

dbus-send --system --type=method_call --print-reply --dest=":1.20" \
"/org/bluez/audio/device0" org.bluez.audio.Sink.Connect

sudo python simple-agent
Agent registered
RequestPasskey (/hci0/dev_20_07_09_15_A9_5A)


Apr 19 01:24:29 debian-eeepc hcid[2353]: Audio API: received BT_GETCAPABILITIES_REQ
Apr 19 01:24:29 debian-eeepc hcid[2353]: Audio API: sending BT_GETCAPABILITIES_RSP
Apr 19 01:24:29 debian-eeepc hcid[2353]: Audio API: received BT_SETCONFIGURATION_REQ
Apr 19 01:24:29 debian-eeepc hcid[2353]: config sco - device = 20:07:09:15:A9:5A access_mode = 2
Apr 19 01:24:33 debian-eeepc hcid[2353]: link_key_request (sba=00:1B:DC:00:32:71, dba=20:07:09:15:A9:5A)
Apr 19 01:24:36 debian-eeepc kernel: usb 1-2: USB disconnect, address 4
Apr 19 01:24:36 debian-eeepc hcid[2353]: HCI dev 0 down
Apr 19 01:24:36 debian-eeepc hcid[2353]: Stopping security manager 0
Apr 19 01:24:36 debian-eeepc hcid[2353]: Device hci0 has been disabled
Apr 19 01:24:36 debian-eeepc hcid[2353]: connect(): Software caused connection abort (103)
Apr 19 01:24:36 debian-eeepc hcid[2353]: config failed
Apr 19 01:24:36 debian-eeepc hcid[2353]: Audio API: sending BT_SETCONFIGURATION_RSP
Apr 19 01:24:37 debian-eeepc hcid[2353]: HCI dev 0 unregistered
Apr 19 01:24:37 debian-eeepc hcid[2353]: Unregister path: /org/bluez/hci0
Apr 19 01:24:37 debian-eeepc hcid[2353]: Device hci0 has been removed
Apr 19 01:24:37 debian-eeepc kernel: usb 1-2: new full speed USB device using uhci_hcd and address 5
Apr 19 01:24:37 debian-eeepc kernel: usb 1-2: configuration #1 chosen from 1 choice

--------------050109020107060904000300
Content-Type: text/plain;
 name="simple-agent"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simple-agent"

#!/usr/bin/python

import gobject

import dbus
import dbus.service
import dbus.mainloop.glib

class Agent(dbus.service.Object):
	@dbus.service.method("org.bluez.Agent",
					in_signature="", out_signature="")
	def Release(self):
		print "Release"
		mainloop.quit()

	@dbus.service.method("org.bluez.Agent",
					in_signature="os", out_signature="")
	def Authorize(self, device, uuid):
		print "Authorize (" + device + ", " + uuid + ")"
		return

	@dbus.service.method("org.bluez.Agent",
					in_signature="o", out_signature="s")
	def RequestPasskey(self, device):
		print "RequestPasskey (" + device + ")"
		return "0000"

	@dbus.service.method("org.bluez.Agent",
					in_signature="s", out_signature="")
	def ConfirmModeChange(self, mode):
		print "ConfirmModeChange (" + mode + ")"
		return

	@dbus.service.method("org.bluez.Agent",
					in_signature="", out_signature="")
	def Cancel(self):
		print "Cancel"
		return

if __name__ == '__main__':
	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)

	bus = dbus.SystemBus()
	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
							"org.bluez.Manager")

	path = manager.DefaultAdapter()
	adapter = dbus.Interface(bus.get_object("org.bluez", path),
							"org.bluez.Adapter")

	path = "/test/agent"
	object = Agent(bus, path)

	adapter.RegisterAgent(path)
	print "Agent registered"

	mainloop = gobject.MainLoop()
	mainloop.run()

	#adapter.UnregisterAgent(path)
	#print "Agent unregistered"

--------------050109020107060904000300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--------------050109020107060904000300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------050109020107060904000300--
