Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <32812.130.234.167.175.1169734246.squirrel@webmail3.cc.jyu.fi>
Date: Thu, 25 Jan 2007 16:10:46 +0200 (EET)
From: "Tuukka Puranen" <tupepura@cc.jyu.fi>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Failing to connect to some devices
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I have searched for this issue but so far found no working solution.

I have several mobile phones (Nokia 6630, Sony Ericsson P900, Nokia 7610,
Nokia 6600) to which I am trying to connect from a program on a Fedora
machine via Bluetooth dongle. The connection is established
programmatically and based on known bluetooth addresses of the phones. All
devices are also found if inquiried, and the client service is found from
all devices. The program is able to connect to client program on both 6630
and 7610, but when trying to connect to the service on 6600 the connection
responds with "Connection refused". With P900 this happens when I have
entered a pin-code (no other phone even asks for one).

The authentication (which shouldn't be happening, there is no need for
this) seems to fail for some reason. What I do not know, is why it happens
only on P900 (and propably 6600). I have tried to change hcid.conf and
every pin code file I came upon, but nothing seems to help.

I'd like to know is there a way to completely disable the authentication
or  set a default passkey for outgoing connections so that I can easily
connect to given bluetooth address programmatically.

Here's the hcidump from P900:

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:D9:EB:70:2E ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Command Complete (0x0e) plen 6
> HCI Event: Max Slots Change (0x1b) plen 3
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0040 result 1 status 2
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0040 result 0 status 0
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0050 flags 0x00 clen 0
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0050 flags 0x00 result 0 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
< ACL data: handle 41 flags 0x02 dlen 38
    L2CAP(d): cid 0x0050 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 38be1fb8-9980-11d9-8bde-f66bad1e3f3a
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 12
    L2CAP(d): cid 0x0040 len 93 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x58
          count 85
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x1000a
              aid 0x0001 (SrvClassIDList)
                 < uuid-128 38be1fb8-9980-11d9-8bde-f66bad1e3f3a uuid-16
0x1101 (SP) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x5 > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0100 (SrvName)
                 str "in-TISU Leaf"
          cont 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0050 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0050 scid 0x0040
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0041 result 1 status 2
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0051 scid 0x0041 result 0 status 0
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0051 flags 0x00 clen 4
      MTU 1013
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0051 flags 0x00 result 0 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      MTU 672
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0051 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0051 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 10 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 1
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 10 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 3
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0051 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 10 pf 1 ilen 0 fcs 0x8c
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 10 pf 1 ilen 0 fcs 0xa6
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0051 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0051 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0051 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Teminated Connection
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4


And here's (considerably shorter for some reason) from 7610:

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0E:ED:1E:88:E0 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Command Complete (0x0e) plen 6
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
> HCI Event: Max Slots Change (0x1b) plen 3
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 1 status 2
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 0 status 0
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
< ACL data: handle 41 flags 0x02 dlen 38
    L2CAP(d): cid 0x0041 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 38be1fb8-9980-11d9-8bde-f66bad1e3f3a
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 17
> ACL data: handle 41 flags 0x01 dlen 12
    L2CAP(d): cid 0x0040 len 93 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x58
          count 85
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10006
              aid 0x0001 (SrvClassIDList)
                 < uuid-128 38be1fb8-9980-11d9-8bde-f66bad1e3f3a uuid-16
0x1101 (SP) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x3 > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0100 (SrvName)
                 str "in-TISU Leaf"
          cont 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Teminated Connection
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Disconn Complete (0x05) plen 4

Tuukka


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
