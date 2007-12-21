Return-Path: <cyrus@holtmann.org>
Message-ID: <003101c843ba$5d611280$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <009b01c8432a$f2b9a800$0200a8c0@jester><Pine.LNX.4.63.0712201911380.5733@redbean.intranet.gw-instruments.de>
	<000801c84343$f6efce40$0200a8c0@jester>
Date: Fri, 21 Dec 2007 11:15:08 +0100
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Creating a connection : Error: Command Disallowed
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
	BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

I have tried parallel connection requests with 2 types of dongles :
- Cambridge Silicon Radio (CSR) one is successful for the first connection, 
and, as Peter said, returns "Command Disallowed" for next ones (and there 
are automatic retries)
- Integrated System Solution Corp. one allows all connection requests (no 
more "Command Disallowed")

However, I can notice that the "HCI Event : Connect Complete" event is long 
to come back, even if all connection requests have been performed at the 
same time. For example, trying to connect concurrently to 5 devices from the 
same dongle (with a simple "connect", sleep 10 seconds, "close") gives 
something like :

00:19:2D:15:FF:0E : 3 seconds between Create Connection (0x01|0x0005) and 
HCI Event : Connect Complete
00:12:D1:6E:4C:96 : 6.7 seconds between Create Connection (0x01|0x0005) and 
HCI Event : Connect Complete
00:16:4E:83:2D:19 : 6.2 seconds between Create Connection (0x01|0x0005) and 
HCI Event : Connect Complete
00:12:D1:65:27:7F : 9.1 seconds between Create Connection (0x01|0x0005) and 
HCI Event : Connect Complete
00:17:B0:1E:54:FD : 11.5 seconds between Create Connection (0x01|0x0005) and 
HCI Event : Connect Complete

Of course, concurrency seems to be the concern, trying to connect to each 
device at a time is always performed instantly.
Trying to span these connections on several bluetooth dongles (i.e. 
00:19:2D:15:FF:0E on hci0, 00:12:D1:6E:4C:96 on hci1 etc...) is not 
improving the connection time.

Any help is welcome ! I really wonder what is blocking here !

I'm running Kernel 2.6.23.12 and BlueZ 3.23

Here is a full hcidump ...

-------------------------------------------------------------------------------------------------------------------------------------

HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
2007-12-21 10:19:39.510533 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:19:2D:15:FF:0E ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 10:19:39.514408 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 10:19:39.514434 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:16:4E:83:2D:19 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 10:19:39.517404 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 10:19:39.517442 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:12:D1:6E:4C:96 ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 10:19:39.520405 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 10:19:39.520431 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:12:D1:65:27:7F ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 10:19:39.524397 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 10:19:39.524414 < HCI Command: Create Connection (0x01|0x0005) 
plen 13
    bdaddr 00:17:B0:1E:54:FD ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 10:19:39.527396 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-12-21 10:19:42.496413 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:19:2D:15:FF:0E type ACL encrypt 0x00
2007-12-21 10:19:42.496429 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-21 10:19:42.496435 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 1
2007-12-21 10:19:42.499411 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2007-12-21 10:19:42.499424 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-21 10:19:42.502410 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
2007-12-21 10:19:42.502421 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:19:2D:15:FF:0E mode 2 clkoffset 0x0000
2007-12-21 10:19:42.505414 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-21 10:19:42.521414 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:42.548411 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
2007-12-21 10:19:42.602413 > HCI Event: Connection Packet Type Changed 
(0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 10:19:42.627411 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 1
    Features: 0xbf 0xee 0x0f 0x46 0x98 0x19 0x00 0x00
2007-12-21 10:19:42.646412 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:19:2D:15:FF:0E name 'Nokia N70'
2007-12-21 10:19:42.646770 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 1
2007-12-21 10:19:42.650412 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-21 10:19:42.652418 > ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2007-12-21 10:19:42.652431 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 2 result 1
      Not supported
2007-12-21 10:19:42.677415 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2007-12-21 10:19:42.677425 < ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013
2007-12-21 10:19:42.679412 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:42.704418 > ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-12-21 10:19:42.704429 < ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672
2007-12-21 10:19:42.705416 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:42.731414 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:42.755422 > ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672
2007-12-21 10:19:42.755445 < ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-21 10:19:42.783415 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:42.809413 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 1
    LMP Version: 2.0 (0x3) LMP Subversion: 0x6cc
    Manufacturer: Cambridge Silicon Radio (10)
2007-12-21 10:19:42.835423 > ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-21 10:19:42.835445 < ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
2007-12-21 10:19:42.862415 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:42.913419 > ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 3
2007-12-21 10:19:42.913437 < ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
2007-12-21 10:19:42.940414 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:44.993430 > ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
2007-12-21 10:19:44.993450 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
2007-12-21 10:19:45.018428 > ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
2007-12-21 10:19:45.018455 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
2007-12-21 10:19:45.019425 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:45.045430 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:45.069428 > ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
2007-12-21 10:19:45.069446 < ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd2 credits 33
2007-12-21 10:19:45.097423 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:45.762428 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 2 bdaddr 00:16:4E:83:2D:19 type ACL encrypt 0x00
2007-12-21 10:19:45.762444 < ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-21 10:19:45.762450 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 2
2007-12-21 10:19:45.765432 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2007-12-21 10:19:45.765443 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 2 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-21 10:19:45.768426 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 2
2007-12-21 10:19:45.768436 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:16:4E:83:2D:19 mode 2 clkoffset 0x0000
2007-12-21 10:19:45.771426 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-21 10:19:45.812430 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 2 slots 5
2007-12-21 10:19:45.888427 > HCI Event: Connection Packet Type Changed 
(0x1d) plen 5
    status 0x00 handle 2 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 10:19:45.912429 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 2
    Features: 0xbf 0xee 0x0f 0x40 0x18 0x18 0x00 0x00
2007-12-21 10:19:45.955429 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:16:4E:83:2D:19 name 'Nokia 6021'
2007-12-21 10:19:45.955773 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 2
2007-12-21 10:19:45.959428 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-21 10:19:46.012429 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 2
    LMP Version: 1.2 (0x2) LMP Subversion: 0x4db
    Manufacturer: Cambridge Silicon Radio (10)
2007-12-21 10:19:46.036430 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:46.084436 > ACL data: handle 2 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2007-12-21 10:19:46.084448 < ACL data: handle 2 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013
2007-12-21 10:19:46.109432 > ACL data: handle 2 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772
2007-12-21 10:19:46.109443 < ACL data: handle 2 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 32772
2007-12-21 10:19:46.111428 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:46.136431 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:46.142437 > ACL data: handle 2 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 1013
2007-12-21 10:19:46.142458 < ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-21 10:19:46.171431 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:46.220434 > ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-21 10:19:46.220451 < ACL data: handle 2 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
2007-12-21 10:19:46.247428 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:46.262430 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 3 bdaddr 00:12:D1:6E:4C:96 type ACL encrypt 0x00
2007-12-21 10:19:46.262441 < ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-21 10:19:46.262446 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 3
2007-12-21 10:19:46.265435 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2007-12-21 10:19:46.265446 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 3 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-21 10:19:46.268429 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 3
2007-12-21 10:19:46.268438 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:12:D1:6E:4C:96 mode 2 clkoffset 0x0000
2007-12-21 10:19:46.271429 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-21 10:19:46.284437 > ACL data: handle 2 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 0
2007-12-21 10:19:46.284457 < ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
2007-12-21 10:19:46.326431 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 3
    Features: 0xff 0xff 0x2d 0xf8 0x1b 0x18 0x00 0x80
2007-12-21 10:19:46.355431 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:12:D1:6E:4C:96 name 'my501X'
2007-12-21 10:19:46.355769 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 3
2007-12-21 10:19:46.358430 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-21 10:19:46.376431 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 3 slots 5
2007-12-21 10:19:46.377430 > HCI Event: Connection Packet Type Changed 
(0x1d) plen 5
    status 0x00 handle 3 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 10:19:46.401432 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 3
    LMP Version: 1.2 (0x2) LMP Subversion: 0xe1b
    Manufacturer: Texas Instruments Inc. (13)
2007-12-21 10:19:46.411432 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:46.423432 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:46.434438 > ACL data: handle 3 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x1600 scid 0x0040 result 0 status 0
      Connection successful
2007-12-21 10:19:46.434449 < ACL data: handle 3 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x1600 flags 0x00 clen 4
      MTU 1013
2007-12-21 10:19:46.450431 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:46.476435 > ACL data: handle 3 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
2007-12-21 10:19:46.484439 > ACL data: handle 3 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1700
2007-12-21 10:19:46.484452 < ACL data: handle 3 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x1600 flags 0x00 result 0 clen 4
      Success
      MTU 1700
2007-12-21 10:19:46.484467 < ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x1600 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-21 10:19:46.502433 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:46.503431 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:47.459440 > ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-21 10:19:47.459457 < ACL data: handle 3 flags 0x02 dlen 18
    L2CAP(d): cid 0x1600 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 8 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
2007-12-21 10:19:47.509437 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:47.509855 > ACL data: handle 3 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 8 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1003 max_retrans 0 credits 0
2007-12-21 10:19:47.509876 < ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x1600 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 8 pf 1 ilen 0 fcs 0xc9
2007-12-21 10:19:47.560438 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:47.584442 > ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 8 pf 1 ilen 0 fcs 0x2
2007-12-21 10:19:47.584462 < ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(d): cid 0x1600 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:47.609437 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:47.609443 > ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:47.609470 < ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(d): cid 0x1600 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:47.634439 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:47.634445 > ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:47.634465 < ACL data: handle 3 flags 0x02 dlen 9
    L2CAP(d): cid 0x1600 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 0 fcs 0x46 credits 33
2007-12-21 10:19:47.659437 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:47.659443 > ACL data: handle 3 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c credits 255
2007-12-21 10:19:47.732442 > ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
2007-12-21 10:19:47.732463 < ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:47.736439 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:47.757440 > ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:47.757461 < ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:47.761437 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:47.782443 > ACL data: handle 2 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 3
2007-12-21 10:19:47.807439 > ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:47.807456 < ACL data: handle 2 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd2 credits 33
2007-12-21 10:19:47.811437 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:48.660443 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 4 bdaddr 00:12:D1:65:27:7F type ACL encrypt 0x00
2007-12-21 10:19:48.660457 < ACL data: handle 4 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-21 10:19:48.660462 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 4
2007-12-21 10:19:48.663441 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2007-12-21 10:19:48.663455 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 4 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-21 10:19:48.666443 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 4
2007-12-21 10:19:48.666453 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:12:D1:65:27:7F mode 2 clkoffset 0x0000
2007-12-21 10:19:48.669441 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-21 10:19:48.759850 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 4
    Features: 0xff 0xff 0x2d 0xf8 0x1b 0x18 0x00 0x80
2007-12-21 10:19:48.802441 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:12:D1:65:27:7F name 'SAGEM my401X'
2007-12-21 10:19:48.802777 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 4
2007-12-21 10:19:48.806445 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-21 10:19:48.859442 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 4 slots 5
2007-12-21 10:19:48.860443 > HCI Event: Connection Packet Type Changed 
(0x1d) plen 5
    status 0x00 handle 4 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 10:19:48.883445 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 4
    LMP Version: 1.2 (0x2) LMP Subversion: 0xe1b
    Manufacturer: Texas Instruments Inc. (13)
2007-12-21 10:19:48.932445 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:48.958447 > ACL data: handle 4 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x1800 scid 0x0040 result 0 status 0
      Connection successful
2007-12-21 10:19:48.958459 < ACL data: handle 4 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x1800 flags 0x00 clen 4
      MTU 1013
2007-12-21 10:19:48.982445 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:49.007445 > ACL data: handle 4 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
2007-12-21 10:19:49.032448 > ACL data: handle 4 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1700
2007-12-21 10:19:49.032461 < ACL data: handle 4 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x1800 flags 0x00 result 0 clen 4
      Success
      MTU 1700
2007-12-21 10:19:49.032476 < ACL data: handle 4 flags 0x02 dlen 8
    L2CAP(d): cid 0x1800 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-21 10:19:49.057442 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:49.082446 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:49.107446 > ACL data: handle 4 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-21 10:19:49.107463 < ACL data: handle 4 flags 0x02 dlen 18
    L2CAP(d): cid 0x1800 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 8 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
2007-12-21 10:19:49.132446 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:49.157446 > ACL data: handle 4 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 8 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1003 max_retrans 0 credits 0
2007-12-21 10:19:49.157464 < ACL data: handle 4 flags 0x02 dlen 8
    L2CAP(d): cid 0x1800 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 8 pf 1 ilen 0 fcs 0xc9
2007-12-21 10:19:49.182446 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:49.207446 > ACL data: handle 4 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 8 pf 1 ilen 0 fcs 0x2
2007-12-21 10:19:49.207466 < ACL data: handle 4 flags 0x02 dlen 12
    L2CAP(d): cid 0x1800 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:49.232451 > ACL data: handle 4 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:49.232474 < ACL data: handle 4 flags 0x02 dlen 12
    L2CAP(d): cid 0x1800 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:49.233447 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:49.257448 > ACL data: handle 4 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 8 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:49.257465 < ACL data: handle 4 flags 0x02 dlen 9
    L2CAP(d): cid 0x1800 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 8 pf 1 ilen 0 fcs 0x46 credits 33
2007-12-21 10:19:49.258445 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:49.282450 > ACL data: handle 4 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 8 pf 1 ilen 0 fcs 0x9c credits 255
2007-12-21 10:19:49.283445 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:51.025460 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 5 bdaddr 00:17:B0:1E:54:FD type ACL encrypt 0x00
2007-12-21 10:19:51.025477 < ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2007-12-21 10:19:51.025483 < HCI Command: Read Remote Supported Features 
(0x01|0x001b) plen 2
    handle 5
2007-12-21 10:19:51.028453 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2007-12-21 10:19:51.028464 < HCI Command: Write Link Policy Settings 
(0x02|0x000d) plen 4
    handle 5 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
2007-12-21 10:19:51.031452 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:19:51.033454 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 5
2007-12-21 10:19:51.033462 < HCI Command: Remote Name Request (0x01|0x0019) 
plen 10
    bdaddr 00:17:B0:1E:54:FD mode 2 clkoffset 0x0000
2007-12-21 10:19:51.037453 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 5 slots 5
2007-12-21 10:19:51.039454 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-12-21 10:19:51.040454 > HCI Event: Connection Packet Type Changed 
(0x1d) plen 5
    status 0x00 handle 5 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2007-12-21 10:19:51.042457 > ACL data: handle 5 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2007-12-21 10:19:51.042470 < ACL data: handle 5 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013
2007-12-21 10:19:51.043455 > HCI Event: Read Remote Supported Features 
(0x0b) plen 11
    status 0x00 handle 5
    Features: 0xbf 0xee 0x0f 0xc6 0x9a 0x39 0x00 0x00
2007-12-21 10:19:51.043463 > ACL data: handle 5 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772
2007-12-21 10:19:51.043483 < ACL data: handle 5 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 32772
2007-12-21 10:19:51.049453 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:19:51.051454 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:19:51.052457 > ACL data: handle 5 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 1013
2007-12-21 10:19:51.052477 < ACL data: handle 5 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
2007-12-21 10:19:51.057452 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:19:51.076454 > HCI Event: Remote Name Req Complete (0x07) plen 
255
    status 0x00 bdaddr 00:17:B0:1E:54:FD name 'Nokia 6234'
2007-12-21 10:19:51.076805 < HCI Command: Read Remote Version Information 
(0x01|0x001d) plen 2
    handle 5
2007-12-21 10:19:51.079454 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
2007-12-21 10:19:51.081460 > ACL data: handle 5 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-21 10:19:51.081479 < ACL data: handle 5 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 18 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
2007-12-21 10:19:51.085457 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:19:51.091455 > HCI Event: Read Remote Ver Info Complete (0x0c) 
plen 8
    status 0x00 handle 5
    LMP Version: 2.0 (0x3) LMP Subversion: 0x6cc
    Manufacturer: Cambridge Silicon Radio (10)
2007-12-21 10:19:51.117457 > ACL data: handle 5 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 18 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 0
2007-12-21 10:19:51.117475 < ACL data: handle 5 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 18 pf 1 ilen 0 fcs 0x32
2007-12-21 10:19:51.126455 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:19:52.440465 > ACL data: handle 5 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
2007-12-21 10:19:52.440485 < ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:52.441470 > ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:52.441498 < ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:52.444463 > ACL data: handle 5 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 18 pf 1 ilen 0 fcs 0x8 credits 9
2007-12-21 10:19:52.445464 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:19:52.450461 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:19:52.455469 > ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 18 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
2007-12-21 10:19:52.455484 < ACL data: handle 5 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd2 credits 33
2007-12-21 10:19:52.460461 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:19:54.995512 < ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 18 pf 1 ilen 0 fcs 0xd3
2007-12-21 10:19:55.000472 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:55.011476 > ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 18 pf 1 ilen 0 fcs 0xf9
2007-12-21 10:19:55.011497 < ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
2007-12-21 10:19:55.011505 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
2007-12-21 10:19:55.016475 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:55.017474 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 1 packets 1
2007-12-21 10:19:55.022479 > ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
2007-12-21 10:19:55.031478 > ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
2007-12-21 10:19:57.029848 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-21 10:19:57.033483 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2007-12-21 10:19:57.112485 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host
2007-12-21 10:19:57.585140 < ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x1600 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 8 pf 1 ilen 0 fcs 0x28
2007-12-21 10:19:57.590487 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:57.618490 > ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 23 73 01 02                                       #s..
2007-12-21 10:19:57.618515 < ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x1600 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
2007-12-21 10:19:57.618523 < ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x1600 scid 0x0040
2007-12-21 10:19:57.625491 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:57.626490 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 3 packets 1
2007-12-21 10:19:57.640491 > ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
2007-12-21 10:19:57.642491 > ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x1600 scid 0x0040
2007-12-21 10:19:57.732930 < ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 4b 53 01 d3                                       KS..
2007-12-21 10:19:57.737485 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:57.746491 > ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 4b 73 01 f9                                       Ks..
2007-12-21 10:19:57.746510 < ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 53 01 fd                                       .S..
2007-12-21 10:19:57.746518 < ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
2007-12-21 10:19:57.750486 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:57.752489 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 2 packets 1
2007-12-21 10:19:57.755495 > ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
2007-12-21 10:19:57.767489 > ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
2007-12-21 10:19:58.777491 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 3 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-21 10:19:59.208713 < ACL data: handle 4 flags 0x02 dlen 8
    L2CAP(d): cid 0x1800 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 8 pf 1 ilen 0 fcs 0x28
2007-12-21 10:19:59.213494 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:59.237497 > ACL data: handle 4 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 23 73 01 02                                       #s..
2007-12-21 10:19:59.237521 < ACL data: handle 4 flags 0x02 dlen 8
    L2CAP(d): cid 0x1800 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
2007-12-21 10:19:59.237528 < ACL data: handle 4 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x1800 scid 0x0040
2007-12-21 10:19:59.241494 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:59.242494 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 4 packets 1
2007-12-21 10:19:59.255503 > ACL data: handle 4 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
2007-12-21 10:19:59.261497 > ACL data: handle 4 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x1800 scid 0x0040
2007-12-21 10:19:59.759856 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 2 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-21 10:19:59.763496 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2007-12-21 10:19:59.842499 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 2 reason 0x16
    Reason: Connection Terminated by Local Host
2007-12-21 10:20:00.565509 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 4 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-21 10:20:02.441012 < ACL data: handle 5 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 4b 53 01 d3                                       KS..
2007-12-21 10:20:02.445515 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:20:02.474517 > ACL data: handle 5 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 4b 73 01 f9                                       Ks..
2007-12-21 10:20:02.474541 < ACL data: handle 5 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 53 01 fd                                       .S..
2007-12-21 10:20:02.474550 < ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
2007-12-21 10:20:02.479510 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:20:02.480511 > HCI Event: Number of Completed Packets (0x13) 
plen 5
    handle 5 packets 1
2007-12-21 10:20:02.483515 > ACL data: handle 5 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 0]
      0000: 03 73 01 d7                                       .s..
2007-12-21 10:20:02.507512 > ACL data: handle 5 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
2007-12-21 10:20:04.499850 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 5 reason 0x13
    Reason: Remote User Terminated Connection
2007-12-21 10:20:04.503519 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2007-12-21 10:20:04.582523 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 5 reason 0x16
    Reason: Connection Terminated by Local Host




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
