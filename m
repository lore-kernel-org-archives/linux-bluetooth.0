Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <448D6723.4050107@ibmt.fraunhofer.de>
Date: Mon, 12 Jun 2006 15:07:47 +0200
From: =?ISO-8859-1?Q?Harald_Niederl=E4nder?= <harald.niederlaender@ibmt.fraunhofer.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Problem connecting Bluetooth device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello all,

I try to connect (unsuccessful) a Bluetooth Device (blood pressure unit)
to read the data .
(The connection with other devices was easy,
Inquirys by the manufacturer are ineffective)

I doe the following steps:

doro:/home/harald # hcitool scan
Scanning ...
         00:11:B1:A2:01:C9       TaiDoc-BTM

then "hcitool info" (after sending the PIN):
doro:/home/harald # hcitool info 00:11:B1:A2:01:C9
Requesting information ...
         BD Address:  00:11:B1:A2:01:C9
         Device Name: TaiDoc-BTM
         LMP Version: 1.1 (0x1) LMP Subversion: 0x2c2
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                 <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
scheme>
                 <power control> <transparent SCO>

then:
doro:/home/harald # rfcomm bind 0 00:11:B1:A2:01:C9 1

and change the rigths:
doro:/home/harald # chmod 777 rfcomm0

If i try to connect the device:
doro:/home/harald # rfcomm connect 0 00:11:B1:A2:01:C9 1
Can't connect RFCOMM socket: Permission denied

and in a message box I get :
....Authentication Error!

hcidump give the following infoarmations (during the steps above), but
I'm not able to interpret the output becouse I have
no documentations how to interpret the output:


HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Complete (0x01) plen 1
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Link Key Notification (0x18) plen 23
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Remote Name Req Complete (0x07) plen 255
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Ver Info Complete (0x0c) plen 8
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Read Remote Supported Features (0x0b) plen 11
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Link Key Notification (0x18) plen 23
> HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 6 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
> HCI Event: Max Slots Change (0x1b) plen 3
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 6 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
       Connection pending - Authorization pending
> ACL data: handle 6 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 6 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 6 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
> ACL data: handle 6 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1024
< ACL data: handle 6 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 6 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 6 flags 0x02 dlen 17
> ACL data: handle 6 flags 0x01 dlen 1
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
       frame_size 320 max_retrans 0 credits 0
< ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 6 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8
> ACL data: handle 6 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 6 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 6 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 5
> ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 6 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 6 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4
< HCI Command: Inquiry (0x01|0x0001) plen 5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Complete (0x01) plen 1
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11


Any help?

Thanks

Harald











_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
