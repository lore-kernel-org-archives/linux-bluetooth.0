Return-Path: <cyrus@holtmann.org>
Message-ID: <47764013.6020600@acm.org>
Date: Sat, 29 Dec 2007 13:39:47 +0100
From: Jesper Holck <holckj@acm.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Headset disconnects immediately
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

I have installed kde bluetooth and try to connect to Jabra 250v headset, 
and at first things seem to succeed - I can pair with the headset and 
also connect with it - but then the headset seems to disconnect 
immediately. An answer to a previous post 
(http://article.gmane.org/gmane.linux.bluez.user/13073) suggest that 
this might have to do with lack of support for the headset profile, but 
if this is so - is it a dongle or a headset problem? and what can I do 
about it?

Installed versions:
kdebluetooth-libs-1.0-0.37.beta8.fc8
kdebluetooth-1.0-0.37.beta8.fc8
bluez-utils-alsa-3.20-4.fc8
bluez-libs-devel-3.20-1.fc8
bluez-libs-3.20-1.fc8
bluez-utils-3.20-4.fc8
bluez-hcidump-1.40-1.fc8

The dongle is a Cambridge Silicon type. I run 64-bit Linux.

HCI dump:

< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
 > HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:07:A4:27:3A:17 mode 1 clkoffset 0x5615 class 0x200404
< HCI Command: Inquiry Cancel (0x01|0x0002) plen 0
 > HCI Event: Command Complete (0x0e) plen 4
    Inquiry Cancel (0x01|0x0002) ncmd 1
    status 0x00
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:07:A4:27:3A:17 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:07:A4:27:3A:17
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:07:A4:27:3A:17 len 4 pin '0000'
 > HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:07:A4:27:3A:17
 > HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:07:A4:27:3A:17 key 9C4633B5A7A3874941EB30C4C26A3497 type 0
    Type: Combination Key
 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:07:A4:27:3A:17 type ACL encrypt 0x00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 41
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:07:A4:27:3A:17 mode 1
 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:07:A4:27:3A:17 mode 2 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 41
    Features: 0xfc 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:07:A4:27:3A:17 name 'Jabra BT 250v'
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00 result 0 clen 4
      Success
      MTU 48
< ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0048 len 13 [psm 1]
        SDP SS Req: tid 0x0 len 0x8
          pat uuid-16 0x1108 (Headset)
          max 64
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 1]
        SDP SS Rsp: tid 0x0 len 0x9
          count 1
          handle 0x10000
          cont 00
< ACL data: handle 41 flags 0x02 dlen 23
    L2CAP(d): cid 0x0048 len 19 [psm 1]
        SDP SA Req: tid 0x1 len 0xe
          handle 0x10000
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 27
 > ACL data: handle 41 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SA Rsp: tid 0x1 len 0x2b
          count 38
          cont 02 00 1F
< ACL data: handle 41 flags 0x02 dlen 25
    L2CAP(d): cid 0x0048 len 21 [psm 1]
        SDP SA Req: tid 0x2 len 0x10
          handle 0x10000
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 1F
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 27
 > ACL data: handle 41 flags 0x01 dlen 16
    L2CAP(d): cid 0x0040 len 39 [psm 1]
        SDP SA Rsp: tid 0x2 len 0x22
          count 31
          aid 0x0000 (SrvRecHndl)
             uint 0x10000
          aid 0x0001 (SrvClassIDList)
             < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
          aid 0x0004 (ProtocolDescList)
             < < uuid-16 0x0100 (L2CAP) > <
             uuid-16 0x0003 (RFCOMM) uint 0x1 > >
          aid 0x0009 (BTProfileDescList)
             < < uuid-16 0x1108 (Headset) uint 0x100 > >
          aid 0x0100 (SrvName)
             str "Headset"
          aid 0x0302 (unknown)
             bool 0x1
          cont 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0048 scid 0x0040
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0049 flags 0x00 clen 4
      MTU 1013
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0048 scid 0x0040
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0049 flags 0x00 result 0 clen 4
      Success
      MTU 1013
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0049 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0049 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0049 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0049 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0049 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 11
 > ACL data: handle 41 flags 0x01 dlen 1
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0049 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0049 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
 > ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0049 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0049 scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0049 scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host

It would be so nice to make it work :-)

Happy new year to everybody,
Jesper, Denmark

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
