Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Frank Pieczynski <pieczy@web.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TpaoCpSU/O3UCaR"
Message-Id: <200506041519.15949.pieczy@web.de>
Subject: [Bluez-users] Protocol error in btsco
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 4 Jun 2005 15:19:15 +0200

--Boundary-00=_TpaoCpSU/O3UCaR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
I try to play a short wav file, it works. But after on of the next tries the 
connection dies somehow with "Protocol error"
hcidump attached.
Thanks,
Frank

btsco v0.4a
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 6 connected
recieved AT+VGS=9
Sending up speaker change 9
driver is in use
connected SCO channel
Done setting sco fd
speaker volume: 9 mic volume: 14
driver is not in use
disconnected SCO channel
speaker volume: 9 mic volume: 14
driver is in use
Can't connect SCO audio channel
: Protocol error
driver is in use
Can't connect SCO audio channel
: Connection timed out


config data:
Dell TrueMobile 350 in Latitude X1
Head set BT201 (noname)

Gentoo Kernel 2.6.11-gentoo-r9
btsco 0.4a (gentoo ebuild)
bluetooth-alsa 1.6-r2
bluez-libs 2.16-r1
bluez-utils 2.16-r1

lati btsco-0.4a # hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:C6:XX:XX:XX ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:146748 acl:19 sco:2845 events:89 errors:0
        TX bytes:145295 acl:19 sco:2829 commands:46 errors:0
        Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x679 LMP Ver: 1.2 (0x2) LMP Subver: 0x679
        Manufacturer: Cambridge Silicon Radio (10)


lati btsco-0.4a # hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:10:C6:XX:XX:XX ACL MTU: 384:8 SCO MTU: 64:8
        Build 1657
        Chip version: BlueCore4-External
        Max key size: 128 bit
        SCO mapping:  HCI
        Panic code:   0x22


lati btsco-0.4a # hcitool info 00:0E:DA:XX:XX:XX
Requesting information ...
        BD Address:  00:0E:DA:XX:XX:XX
        Device Name: BT201
        LMP Version: 1.1 (0x1) LMP Subversion: 0xc70
        Manufacturer: Transilica, Inc. (24)
        Features: 0xbf 0xf8 0x31 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <sniff mode> <SCO link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>

lati btsco-0.4a # sdptool search --bdaddr 00:0E:DA:XX:XX:XX 0x1108
Class 0x1108
Searching for 0x1108 on 00:0E:DA:XX:XX:XX ...
Service Name: Headset
Service RecHandle: 0x20000
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100


--Boundary-00=_TpaoCpSU/O3UCaR
Content-Type: text/plain;
  charset="iso-8859-1";
  name="bt-trc.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bt-trc.txt"

HCI sniffer - Bluetooth packet analyzer ver 1.20
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0E:DA:XX:XX:XX ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: XX XX XX da 0e 00                                 ......
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0E:DA:XX:XX:XX
    Link key: c6c15909a3bc2153dXXXXXXXXXXXbXX3
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 XX XX XX da  0e 00                    ..........
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2e 00 XX XX XX da 0e  00 01 00                 ...........
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 46 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2e 00 05                                          ...
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 2e 00                                 ......
> ACL data: handle 46 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 46 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 128 
< ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 46 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> ACL data: handle 46 flags 0x02 dlen 27
> ACL data: handle 46 flags 0x01 dlen 24
    L2CAP(d): cid 0x0040 len 47 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2a
          count 38
          cont 01 01
< ACL data: handle 46 flags 0x02 dlen 25
    L2CAP(d): cid 0x0040 len 21 [psm 1]
        SDP SSA Req: tid 0x1 len 0x10
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 01 01
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> ACL data: handle 46 flags 0x02 dlen 27
> ACL data: handle 46 flags 0x01 dlen 23
    L2CAP(d): cid 0x0040 len 46 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x29
          count 37
          cont 01 02
< ACL data: handle 46 flags 0x02 dlen 25
    L2CAP(d): cid 0x0040 len 21 [psm 1]
        SDP SSA Req: tid 0x2 len 0x10
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 01 02
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> ACL data: handle 46 flags 0x02 dlen 27
> ACL data: handle 46 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 25 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x14
          count 17
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x20000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x6 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Headset"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 25 0c 00 60 00                                 .%..`.
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> ACL data: handle 46 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 46 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> ACL data: handle 46 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 1024 
> ACL data: handle 46 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 330 
< ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 46 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 12 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 325 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> ACL data: handle 46 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 12 frame_type 0 credit_flow 14 pri 1 ack_timer 0
      frame_size 325 max_retrans 0 credits 7
< ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 12 pf 1 ilen 0 fcs 0x43 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> ACL data: handle 46 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 12 pf 1 ilen 0 fcs 0x88 
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> ACL data: handle 46 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 0 ilen 9 fcs 0x95 
      0000: 41 54 2b 56 47 53 3d 39  0d                       AT+VGS=9.
> ACL data: handle 46 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 1 b3 1 len 0
< ACL data: handle 46 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 1 ilen 0 fcs 0x53 credits 34
< ACL data: handle 46 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 6 fcs 0x4f 
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    handle 46 ptype 0x00e0
    Packet type: HV1 HV2 HV3 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                       ....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2e 00 01                                          ...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 31 00 bb c0 00 da 0e  00 00 00                 .1.........
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2e 00 03                                          ...
> SCO data: handle 49 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
> SCO data: handle 49 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................

some SCO data deleted

> SCO data: handle 49 dlen 48
    0000: 7a 01 64 01 3f 00 70 ff  31 fe 49 fd dc fd 5f fe  z.d.?.p.1.I..._.
    0010: bb fe 19 ff 83 ff dd ff  eb ff 46 00 5f 00 7d 00  ..........F._.}.
    0020: a3 00 92 00 82 00 95 00  a6 00 61 00 54 00 44 00  ..........a.T.D.
< SCO data: handle 49 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
< SCO data: handle 49 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
< SCO data: handle 49 dlen 48
    0000: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
    0010: 3a 00 2e 00 27 00 35 00  3c 00 32 00 2b 00 2d 00  :...'.5.<.2.+.-.
    0020: 2d 00 32 00 34 00 32 00  39 00 32 00 28 00 29 00  -.2.4.2.9.2.(.).
< ACL data: handle 46 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 9 fcs 0x4f 
      0000: 41 54 2b 56 47 53 3d 39  0d                       AT+VGS=9.
< ACL data: handle 46 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 10 fcs 0x4f 
      0000: 41 54 2b 56 47 4d 3d 31  34 0d                    AT+VGM=14.
> SCO data: handle 49 dlen 48
    0000: 2a 00 2f 00 17 00 1a 00  10 00 39 00 d3 00 ed 00  *./.......9.....
    0010: 2a 00 a0 ff c9 fe 00 fe  b3 fe 11 ff 2c ff c2 ff  *...........,...
    0020: b3 ff e3 ff 35 00 3c 00  72 00 4f 00 3b 00 70 00  ....5.<.r.O.;.p.
> SCO data: handle 49 dlen 48
    0000: 70 00 50 00 3d 00 61 00  79 00 4e 00 3c 00 33 00  p.P.=.a.y.N.<.3.
    0010: 21 00 12 00 0b 00 44 00  ba 00 d5 00 26 00 95 ff  !.....D.....&...
    0020: cf fe 27 fe c6 fe 3f ff  4e ff 88 ff 93 ff b5 ff  ..'...?.N.......
> SCO data: handle 49 dlen 48
    0000: e3 ff 23 00 4e 00 4f 00  5b 00 76 00 83 00 89 00  ..#.N.O.[.v.....
    0010: 95 00 92 00 6d 00 4d 00  43 00 2e 00 26 00 1d 00  ....m.M.C...&...
    0020: 1c 00 6c 00 48 01 6c 01  51 00 92 ff 82 fe ac fd  ..l.H.l.Q.......
> SCO data: handle 49 dlen 48
    0000: 61 fe a7 fe dd fe 6f ff  6e ff e2 ff 2e 00 45 00  a.....o.n.....E.
    0010: 80 00 85 00 a4 00 83 00  83 00 af 00 9a 00 a8 00  ................
    0020: 70 00 51 00 4f 00 29 00  21 00 d9 ff d7 ff 3d 00  p.Q.O.).!.....=.
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 49 reason 0x13
    Reason: Remote User Terminated Connection
> SCO data: handle 49 dlen 48
    0000: c8 00 d5 00 09 00 88 ff  db fe 3b fe b8 fe 03 ff  ..........;.....
    0010: 35 ff 75 ff aa ff 06 00  16 00 3a 00 36 00 54 00  5.u.......:.6.T.
    0020: 7b 00 6f 00 74 00 3d 00  3c 00 2f 00 1b 00 22 00  {.o.t.=.<./...".
> SCO data: handle 49 dlen 48
    0000: 0c 00 13 00 0a 00 06 00  15 00 7f 00 81 01 7b 01  ..............{.
    0010: 49 00 9a ff 52 fe 33 fd  11 fe 8d fe c6 fe 48 ff  I...R.3.......H.
    0020: 96 ff f5 ff 02 00 59 00  66 00 af 00 e5 00 89 00  ......Y.f.......
> SCO data: handle 49 dlen 48
    0000: b0 00 c2 00 88 00 6d 00  4e 00 41 00 31 00 25 00  ......m.N.A.1.%.
    0010: 1f 00 14 00 1d 00 89 00  64 01 6b 01 5f 00 9e ff  ........d.k._...
    0020: 6d fe 80 fd 3f fe ad fe  e8 fe 40 ff 58 ff d6 ff  m...?.....@.X...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> SCO data: handle 49 dlen 48
    0000: 03 00 18 00 65 00 63 00  8e 00 8b 00 8e 00 b1 00  ....e.c.........
    0010: 5b 00 7b 00 a3 00 77 00  5e 00 42 00 38 00 1f 00  [.{...w.^.B.8...
    0020: f2 ff 52 00 6a 01 65 01  42 00 90 ff 3e fe 68 fd  ..R.j.e.B...>.h.
> SCO data: handle 49 dlen 48
    0000: 30 fe 95 fe cf fe 40 ff  a0 ff d8 ff d3 ff 31 00  0.....@.......1.
    0010: 67 00 7e 00 af 00 ae 00  ce 00 a8 00 70 00 6e 00  g.~.........p.n.
    0020: 81 00 98 00 5e 00 4a 00  41 00 26 00 2b 00 4f 00  ....^.J.A.&.+.O.
> SCO data: handle 49 dlen 48
    0000: ea 00 e3 00 11 00 84 ff  95 fe 01 fe 8f fe e5 fe  ................
    0010: 11 ff 54 ff 81 ff e5 ff  16 00 44 00 8f 00 9f 00  ..T.......D.....
    0020: 87 00 8d 00 76 00 13 00  41 00 68 00 31 00 37 00  ....v...A.h.1.7.
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> SCO data: handle 49 dlen 48
    0000: 20 00 1b 00 1a 00 0a 00  2d 00 a7 00 91 01 89 01   .......-.......
    0010: 5b 00 96 ff 95 fe c8 fd  7c fe e1 fe f8 fe 56 ff  [.......|.....V.
    0020: 84 ff ee ff f2 ff 16 00  57 00 45 00 82 00 72 00  ........W.E...r.
> SCO data: handle 49 dlen 48
    0000: 88 00 73 00 39 00 50 00  50 00 7a 00 4e 00 32 00  ..s.9.P.P.z.N.2.
    0010: 3a 00 17 00 34 00 8c 00  4f 01 41 01 39 00 93 ff  :...4...O.A.9...
    0020: 7d fe a3 fd 4f fe b7 fe  cf fe 40 ff 8b ff e6 ff  }...O.....@.....
> SCO data: handle 49 dlen 48
    0000: 06 00 38 00 3b 00 58 00  76 00 44 00 90 00 75 00  ..8.;.X.v.D...u.
    0010: 41 00 4d 00 23 00 2d 00  1a 00 30 00 69 00 4a 00  A.M.#.-...0.i.J.
    0020: 34 00 55 00 f1 00 13 01  21 00 8e ff a8 fe f0 fd  4.U.....!.......
> SCO data: handle 49 dlen 48
    0000: 7f fe d8 fe 16 ff 5a ff  9a ff f8 ff 05 00 6a 00  ......Z.......j.
    0010: 80 00 5a 00 97 00 7a 00  92 00 8b 00 63 00 9f 00  ..Z...z.....c...
    0020: 6d 00 51 00 72 00 49 00  10 00 0d 00 2e 00 a6 00  m.Q.r.I.........
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2e 00 01 00                                    .....
> SCO data: handle 49 dlen 48
    0000: 97 01 8f 01 61 00 86 ff  44 fe 4a fd 1a fe a0 fe  ....a...D.J.....
    0010: fd fe da fe 3b fe e3 ff  88 00 01 00 1e 01 a3 00  ....;...........
    0020: f6 ff 52 00 4a 00 d0 00  0f 01 cd 00 49 00 73 00  ..R.J.......I.s.
> SCO data: handle 49 dlen 48
    0000: 3e 00 e8 ff 96 00 5d 00  3c 00 67 00 a1 00 ea 00  >.....].<.g.....
    0010: 37 00 b3 ff d8 fe 1f fe  90 fe a7 fe c5 fe 47 ff  7.............G.
    0020: ae ff ff ff 18 00 0a 00  05 00 2c 00 5d 00 45 00  ..........,.].E.
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 31 00 16                                       .1..
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2e 00 05                                          ...
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 2e 00 02 20 03                                 .... .
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    handle 46 ptype 0x00e0
    Packet type: HV1 HV2 HV3 
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                       ....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2e 00 01                                          ...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 24 2e 00 bb c0 00 da 0e  00 00 00                 $..........
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2e 00 05                                          ...
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    handle 46 ptype 0x00e0
    Packet type: HV1 HV2 HV3 
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 08 00 00 bb c0 00 da 0e  00 00 00                 ...........
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 2e 00 08                                       ....

--Boundary-00=_TpaoCpSU/O3UCaR--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
