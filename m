Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <F162D20C428AB34E9E4491C6CF5F8B9A02A1813B@posthoorn.intra.local>
From: "Johan van der Boom" <Johan.vanderBoom@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] not able to send SCO voice data
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 27 Oct 2004 09:25:32 +0200

Hi,

I'm trying to run the hstest and am unable to send any SCO voice data to
the headset. Receiving SCO voice data from the headset works OK. After
several successful writes to the SCO socket it returns an error. None of
the successful writes have actually been transmitted over the HCI UART
link.

hciconfig returns:
  ACL MTU: 120:20  SCO MTU: 64:0

The 'hci read buffer size' command returns:
  < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
  > HCI Event: Command Complete (0x0e) plen 11
    01 05 10 00 78 00 00 14 00 00 00

What I think is happening, is that the BlueZ stack thinks the bluetooth
device has not got any space to store any SCO packets since the 'hci
read buffer size' command returns 0 for HC_Total_Num_SCO_Data_Packets
and also 0 for HC_SCO_Data_Packet_Length, and therefore does not send
any SCO data and at some point runs out of internal buffers and returns
an error in the write to the SCO socket.

Is this assumption correct?, Or does the BlueZ stack interpret the 0
HC_Total_Num_SCO_Data_Packets as meaning the bluetooth device does not
support flow control as is intended by the bluetooth device, and
something else goes wrong?


Regards,
Johan.

--

I'm using a Silicon Wave Wireless Development System 6, which uses a
SiW3500 Bluetooth chip which is a Bluetooth 1.2 device. I use the 2.6.9
kernel with the patch-2.6.9-mh1.gz patch and bluez-libs-2.10.tar.gz,
bluez-utils-2.10.tar.gz and bluez-hcidump-1.12.tar.gz.

> hciconfig -a hci0

hci0:	Type: UART
	BD Address: AE:2D:00:18:21:28 ACL MTU: 120:20  SCO MTU: 64:0
	UP RUNNING PSCAN ISCAN=20
	RX bytes:394 acl:0 sco:0 events:16 errors:0
	TX bytes:325 acl:0 sco:0 commands:16 errors:0
	Features: 0xff 0xff 0x85 0xf8 0x1b 0x18 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
	Link policy: RSWITCH HOLD SNIFF PARK=20
	Link mode: SLAVE ACCEPT=20
	Name: 'BlueZ (0)'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver:
0x80c
	Manufacturer: Silicon Wave (11)


> hcidump -x (during hcid device init)

HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
> HCI Event: Command Complete (0x0e) plen 12
  01 03 10 00 FF FF 85 F8 1B 18 00 00=20
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> HCI Event: Command Complete (0x0e) plen 11
  01 05 10 00 78 00 00 14 00 00 00=20
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> HCI Event: Command Complete (0x0e) plen 10
  01 09 10 00 28 21 18 00 2D AE=20
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
  01 25 0C 00 60 00=20
< HCI Command: Set Event Filter (0x03|0x0005) plen 2
  00 D0=20
> HCI Event: Command Complete (0x0e) plen 4
  01 05 0C 00=20
< HCI Command: Write Page Timeout (0x03|0x0018) plen 2
  00 80=20
> HCI Event: Command Complete (0x0e) plen 4
  01 18 0C 00=20
< HCI Command: Write Connection Accept Timeout (0x03|0x0016) plen 2
  00 7D=20
> HCI Event: Command Complete (0x0e) plen 4
  01 16 0C 00=20
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
  03=20
> HCI Event: Command Complete (0x0e) plen 4
  01 1A 0C 00=20
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1
  00=20
> HCI Event: Command Complete (0x0e) plen 4
  01 20 0C 00=20
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1
  00=20
> HCI Event: Command Complete (0x0e) plen 4
  01 20 0C 00=20
< HCI Command: Write Encryption Mode (0x03|0x0022) plen 1
  00=20
> HCI Event: Command Complete (0x0e) plen 4
  01 22 0C 00=20
< HCI Command: Write Class of Device (0x03|0x0024) plen 3
  00 01 00=20
> HCI Event: Command Complete (0x0e) plen 4
  01 24 0C 00=20
< HCI Command: Write Local Name (0x03|0x0013) plen 248
  42 6C 75 65 5A 20 28 30 29 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
  00 00 00 00 00 00 00 00=20
> HCI Event: Command Complete (0x0e) plen 4
  01 13 0C 00=20
< HCI Command: Reset (0x03|0x0003) plen 0


> hcidump -x (during hstest up to first few received SCO packets)

HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  16 F1 0F 07 0E 00 18 CC 02 00 00 00 01=20
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04=20
> HCI Event: Link Key Request (0x17) plen 6
  16 F1 0F 07 0E 00=20
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  16 F1 0F 07 0E 00 AD 9B E3 DD 8C 36 05 5C D8 07 DA 2C E1 21=20
  8F A1=20
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 16 F1 0F 07 0E 00=20
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  16 F1 0F 07 0E 00 AD 9B E3 DD 8C 36 05 5C D8 07 DA 2C E1 21=20
  8F A1=20
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 0C 16 F1 0F 07 0E 00=20
> HCI Event: Connect Complete (0x03) plen 11
  00 08 00 16 F1 0F 07 0E 00 01 00=20
< ACL data: handle 0x0008 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  08 00 0F 00=20
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 08 00 18 CC=20
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 08 00=20
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00=20
> ACL data: handle 0x0008 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0061 scid 0x0040 result 0 status 0
< ACL data: handle 0x0008 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0061 flags 0x0000 clen 4
    MTU 1024=20
> ACL data: handle 0x0008 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 454=20
< ACL data: handle 0x0008 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0061 flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00=20
> ACL data: handle 0x0008 flags 0x02 dlen 17
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00=20
> ACL data: handle 0x0008 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 454=20
< ACL data: handle 0x0008 flags 0x02 dlen 8
    L2CAP(d): cid 0x0061 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c=20
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00=20
> ACL data: handle 0x0008 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7=20
< ACL data: handle 0x0008 flags 0x02 dlen 18
    L2CAP(d): cid 0x0061 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 449 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00=20
> ACL data: handle 0x0008 flags 0x02 dlen 17
> ACL data: handle 0x0008 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 449 max_retrans 0 credits 0
< ACL data: handle 0x0008 flags 0x02 dlen 8
    L2CAP(d): cid 0x0061 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59=20
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00=20
> ACL data: handle 0x0008 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92=20
< ACL data: handle 0x0008 flags 0x02 dlen 12
    L2CAP(d): cid 0x0061 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
  08 00 E0 00=20
> ACL data: handle 0x0008 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 7
< ACL data: handle 0x0008 flags 0x02 dlen 12
    L2CAP(d): cid 0x0061 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Command Status (0x0f) plen 4
  00 01 07 04=20
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00=20
> ACL data: handle 0x0008 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 7
< ACL data: handle 0x0008 flags 0x02 dlen 9
    L2CAP(d): cid 0x0061 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> ACL data: handle 0x0008 flags 0x02 dlen 17
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00=20
> HCI Event: Connect Complete (0x03) plen 11
  00 0A 00 16 F1 0F 07 0E 00 00 00=20
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00=20
> ACL data: handle 0x0008 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40=20
      41 54 2A 45 43 42 50 3D 3F 0D=20
> ACL data: handle 0x0008 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2
< ACL data: handle 0x0008 flags 0x02 dlen 12
    L2CAP(d): cid 0x0061 len 8 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 4 fcs 0x9a=20
      4F 4B 0D 0A=20
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00=20
> SCO data: handle 0x000a dlen 24
    0A 00 FD FF 01 00 F2 FF F3 FF F5 FF CA FF F2 FF 1B 00 FE FF=20
    1C 00 FA FF=20
> SCO data: handle 0x000a dlen 24
    EE FF 0B 00 FB FF 11 00 19 00 EF FF EB FF 0C 00 04 00 18 00=20
    07 00 D5 FF=20
> ACL data: handle 0x0008 flags 0x02 dlen 17
> SCO data: handle 0x000a dlen 24
    E9 FF 08 00 16 00 24 00 27 00 F8 FF F1 FF 1B 00 0A 00 0E 00=20
    0E 00 D2 FF=20
> SCO data: handle 0x000a dlen 24
    DA FF 10 00 10 00 13 00 2A 00 ED FF F0 FF 20 00 ED FF 0E 00=20
    30 00 EE FF=20
> SCO data: handle 0x000a dlen 24
    E4 FF FA FF FB FF 15 00 1F 00 ED FF D5 FF F3 FF 07 00 0C 00=20
    17 00 F3 FF=20
> SCO data: handle 0x000a dlen 24
    E8 FF 24 00 10 00 FD FF 10 00 E8 FF DB FF FC FF 00 00 F8 FF=20
    0A 00 FB FF=20
> SCO data: handle 0x000a dlen 24
    F4 FF 0E 00 0C 00 20 00 10 00 E9 FF FB FF 19 00 0F 00 1D 00=20
    0D 00 D8 FF=20
> SCO data: handle 0x000a dlen 24
    EF FF 01 00 FA FF 15 00 04 00 E5 FF F8 FF 03 00 EF FF 04 00=20
    09 00 DF FF=20
> SCO data: handle 0x000a dlen 24
    F0 FF 02 00 F1 FF 1B 00 2D 00 F1 FF ED FF 08 00 FB FF 16 00=20
    24 00 F6 FF=20
> SCO data: handle 0x000a dlen 24
    F6 FF 0B 00 06 00 19 00 25 00 F9 FF EA FF 08 00 06 00 0C 00=20
    1D 00 FF FF=20
> SCO data: handle 0x000a dlen 24
    F0 FF FA FF EE FF FA FF 0F 00 FA FF EF FF 00 00 FA FF 06 00=20
    00 00 00 00=20
> ACL data: handle 0x0008 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40=20
      41 54 2B 56 47 53 3D 34 0D=20
< ACL data: handle 0x0008 flags 0x02 dlen 12
    L2CAP(d): cid 0x0061 len 8 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 4 fcs 0x9a=20
      4F 4B 0D 0A=20
> SCO data: handle 0x000a dlen 24
    13 00 F8 FF FA FF EF FF F1 FF E6 FF FF FF 17 00 F9 FF F5 FF=20
    FC FF F0 FF=20
> SCO data: handle 0x000a dlen 24
    0A 00 22 00 04 00 06 00 0A 00 E6 FF 06 00 32 00 16 00 13 00=20
    15 00 F8 FF=20
> SCO data: handle 0x000a dlen 24
    0F 00 29 00 0A 00 FD FF 00 00 EE FF FE FF 1B 00 09 00 FC FF=20
    02 00 EF FF=20
> SCO data: handle 0x000a dlen 24
    F9 FF 1C 00 0D 00 F6 FF F7 FF F0 FF F8 FF 1F 00 1A 00 FD FF=20
    FA FF D5 FF=20
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 08 00 01 00


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
