Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44992C04.2030600@ibmt.fraunhofer.de>
Date: Wed, 21 Jun 2006 13:22:44 +0200
From: =?ISO-8859-1?Q?Harald_Niederl=E4nder?= <harald.niederlaender@ibmt.fraunhofer.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4497CE54.5080305@ibmt.fraunhofer.de>	<4498EB58.3090200@ibmt.fraunhofer.de>	<1150883159.3950.34.camel@localhost>	<44991DF2.2000409@ibmt.fraunhofer.de>
	<1150886307.3950.36.camel@localhost>
In-Reply-To: <1150886307.3950.36.camel@localhost>
Subject: Re: [Bluez-devel] [Fwd: Re:  Problem connecting Bluetooth device]
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

Hi Marcel,

Marcel Holtmann wrote:
> Hi Harald,
> 
> 
> 
> it seems that the link key is stored totally wrong. Please replace it
> with the link key you see in the first connection attempt and then try
> again.
> 
> Regards
> 
> Marcel
> 
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 

these time it seems that the key in linkkeys is OK (without manual 
replacing, but why?)

and the alert message"..Authentication Error!" don't appear.

But the connection failed!

doro:/home/harald #
doro:/home/harald # rfcomm connect /dev/rfcomm0 00:11:B1:A2:01:C9
Can't create RFCOMM TTY: Address already in use
doro:/home/harald #
doro:/home/harald # rfcomm connect /dev/rfcomm0 00:11:B1:A2:01:C9
Can't connect RFCOMM socket: Permission denied

The corresponding output of hcidump:

doro:/var/lib/bluetooth # hcidump -X -V -i hci0
HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:11:B1:A2:01:C9 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: PIN Code Request (0x16) plen 6
     bdaddr 00:11:B1:A2:01:C9
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
     bdaddr 00:11:B1:A2:01:C9 len 6 pin '111111'
 > HCI Event: Command Complete (0x0e) plen 10
     PIN Code Request Reply (0x01|0x000d) ncmd 1
     status 0x00 bdaddr 00:11:B1:A2:01:C9
 > HCI Event: Link Key Notification (0x18) plen 23
     bdaddr 00:11:B1:A2:01:C9 key 2FD1DC3232CA52D349A6E23BF148F25B type 0
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 6 bdaddr 00:11:B1:A2:01:C9 type ACL encrypt 0x01
< ACL data: handle 6 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 6 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 6
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 6 slots 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 6 packets 1
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
     handle 6 packets 1
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
     handle 6 packets 2
 > ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 6 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1019 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 6 packets 1
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
     handle 6 packets 1
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
     handle 6 packets 3
 > ACL data: handle 6 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
 > ACL data: handle 6 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 6 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 6 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 6 packets 2
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
     handle 6 reason 0x13
     Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 6 reason 0x16
     Reason: Connection Terminated by Local Host
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:11:B1:A2:01:C9 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:11:B1:A2:01:C9
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:11:B1:A2:01:C9 key 2FD1DC3232CA52D349A6E23BF148F25B
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:11:B1:A2:01:C9
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 6 bdaddr 00:11:B1:A2:01:C9 type ACL encrypt 0x01
< ACL data: handle 6 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 6 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 6
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 6 slots 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 6 packets 1
 > ACL data: handle 6 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 1 status 2
       Connection pending - Authorization pending
 > ACL data: handle 6 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 4 status 0
       Connection refused - no resources available
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 6 reason 0x13
     Reason: Remote User Terminated Connection

Regards

Harald



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
