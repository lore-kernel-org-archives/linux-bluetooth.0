Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060728225605.90189.qmail@web51403.mail.yahoo.com>
Date: Fri, 28 Jul 2006 15:56:05 -0700 (PDT)
From: manojt ambe <mp_tambe@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] rfcomm connection disconnects immediately
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

Hello,

Thanks Marcel for you earlier reply. I am new to
Bluetooth programming.
I am trying to make RFcomm connection with Motorola
HS850 through a DBT120 dongle. I am using linux
2.4.21-40 kernel and bluez 3.1 .
I see that the rfcomm connection gets disconnected
immediately. Is this how it is supposed to work? I
have pasted hcidump below. Pls let me know. thanks,
Manoj

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:03:46:88 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:13:17:03:46:88
< HCI Command: Link Key Request Reply (0x01|0x000b)
plen 22
    bdaddr 00:13:17:03:46:88 key
9B5BBF681BF037F70F25654204DB5E99
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:13:17:03:46:88
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:13:17:03:46:88
type ACL encrypt 0x01
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings
(0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
< HCI Command: Remote Name Request (0x01|0x0019) plen
10
    bdaddr 00:13:17:03:46:88 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd
1
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004c scid 0x0040
result 1 status 2
      Connection pending - Authorization pending
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:13:17:03:46:88 name
'Motorola HS850'
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004c scid 0x0040
result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x004c flags 0x00 clen
4
      MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
4
      MTU 1024
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004c flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x004c len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs
0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x004c len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs
0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 0
ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs
0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 0
ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x004c len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs
0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x004c len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs
0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0
len 0
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x004c len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86
credits 33
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x004c len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs
0xb8
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs
0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0
len 0
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x004c len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs
0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0
len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs
0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0
len 0
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c
credits 15
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x004c len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs
0xfd
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004c scid 0x0040
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004c scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
