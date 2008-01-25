Return-Path: <cyrus@holtmann.org>
Message-ID: <4799A562.1030906@naustech.com>
Date: Fri, 25 Jan 2008 10:01:22 +0100
From: "Ing. Gabriele Oberhammer" <gabriele@naustech.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4795D6EB.2080209@naustech.com>	<1201018471.24085.4.camel@littletux>
	<47986354.2080205@naustech.com>	<d89ddf300801240717g61e06642v28d6f0cf1b3cf2da@mail.gmail.com>	<479911A2.6040704@naustech.com>
	<d89ddf300801241520x440c0714lbe996ac3ac6aced9@mail.gmail.com>
In-Reply-To: <d89ddf300801241520x440c0714lbe996ac3ac6aced9@mail.gmail.com>
Subject: Re: [Bluez-users] Headset half working using Bluez's ALSA plugin
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hcidump of '$ arecord -D bluetooth -f S16_LE /tmp/test.wav'  :


HCI sniffer - Bluetooth packet analyzer ver 1.39
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
 > HCI Event: Command Status (0x0f) plen 4
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
 > ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x004b scid 0x0040 result 1 status 2
       Connection pending - Authorization pending
 > ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x004b scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x004b flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
 > HCI Event: Command Status (0x0f) plen 4
 > ACL data: handle 46 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
 > ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 48
< ACL data: handle 46 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x004b flags 0x00 result 0 clen 4
       Success
       MTU 48
< ACL data: handle 46 flags 0x02 dlen 17
     L2CAP(d): cid 0x004b len 13 [psm 1]
         SDP SS Req: tid 0x0 len 0x8
           pat uuid-16 0x1108 (Headset)
           max 64
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 46 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 1]
         SDP SS Rsp: tid 0x0 len 0x9
           count 1
           handle 0x10005
           cont 00
< ACL data: handle 46 flags 0x02 dlen 23
     L2CAP(d): cid 0x004b len 19 [psm 1]
         SDP SA Req: tid 0x1 len 0xe
           handle 0x10005
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Remote Name Req Complete (0x07) plen 255
 > ACL data: handle 46 flags 0x02 dlen 27
 > ACL data: handle 46 flags 0x01 dlen 25
     L2CAP(d): cid 0x0040 len 48 [psm 1]
         SDP SA Rsp: tid 0x1 len 0x2b
           count 38
           cont 02 00 2D
< ACL data: handle 46 flags 0x02 dlen 25
     L2CAP(d): cid 0x004b len 21 [psm 1]
         SDP SA Req: tid 0x2 len 0x10
           handle 0x10005
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 02 00 2D
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 46 flags 0x02 dlen 27
 > ACL data: handle 46 flags 0x01 dlen 25
     L2CAP(d): cid 0x0040 len 48 [psm 1]
         SDP SA Rsp: tid 0x2 len 0x2b
           count 38
           cont 02 00 07
< ACL data: handle 46 flags 0x02 dlen 25
     L2CAP(d): cid 0x004b len 21 [psm 1]
         SDP SA Req: tid 0x3 len 0x10
           handle 0x10005
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 02 00 07
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 46 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 1]
         SDP SA Rsp: tid 0x3 len 0xa
           count 7
           aid 0x0000 (SrvRecHndl)
              uint 0x10005
           aid 0x0001 (SrvClassIDList)
              < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
           aid 0x0004 (ProtocolDescList)
              < < uuid-16 0x0100 (L2CAP) > <
              uuid-16 0x0003 (RFCOMM) uint 0x2 > >
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
     L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x004b scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x004c scid 0x0041 result 1 status 2
       Connection pending - Authorization pending
 > ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x004b scid 0x0040
 > HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
 > HCI Event: Command Complete (0x0e) plen 10
 > ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x004c scid 0x0041 result 0 status 0
       Connection successful
< ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x004c flags 0x00 clen 4
       MTU 1013
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 46 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
       MTU 1013
< ACL data: handle 46 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x004c flags 0x00 result 0 clen 4
       Success
       MTU 1013
< ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x004c len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 46 flags 0x02 dlen 18
     L2CAP(d): cid 0x004c len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 4 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1008 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 46 flags 0x02 dlen 18
     L2CAP(d): cid 0x0041 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 4 frame_type 0 credit_flow 14 pri 7 ack_timer 0
       frame_size 127 max_retrans 0 credits 0
< ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x004c len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 4 pf 1 ilen 0 fcs 0x96
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 4 pf 1 ilen 0 fcs 0x5d
< ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(d): cid 0x004c len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
 > ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(d): cid 0x0041 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(d): cid 0x004c len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Command Status (0x0f) plen 4
 > ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(d): cid 0x0041 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 4 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 46 flags 0x02 dlen 9
     L2CAP(d): cid 0x004c len 5 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 4 pf 1 ilen 0 fcs 0x79 credits 33
 > ACL data: handle 46 flags 0x02 dlen 9
     L2CAP(d): cid 0x0041 len 5 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 4 pf 1 ilen 0 fcs 0xa3 credits 15
 > HCI Event: Encrypt Change (0x08) plen 4
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Connect Complete (0x03) plen 11
 > HCI Event: Mode Change (0x14) plen 6

Here I hear a beep and some noise in the headset, so I guess it has 
entered capture mode correctly.
But from now no more packets are dumped till I interrupt arecord with 
ctrl-c. After stopping arecord I get the diconnect sequence:

< ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x004c len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 4 pf 1 ilen 0 fcs 0x77
< HCI Command: Disconnect (0x01|0x0006) plen 3
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 4 pf 1 ilen 0 fcs 0x5d
< ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x004c len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x004c scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Disconn Complete (0x05) plen 4
 > ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x004c scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Disconn Complete (0x05) plen 4


Is this useful?
I'm not much into bluez source code, but I'm a C programmer so if you 
give me some hints about what to look for in the sources I could try to 
solve the problem myself.


Best regards, Gabriele

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
