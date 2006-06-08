Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <027101c68b0f$2dc2cfb0$0203a8c0@NBVICTOR>
From: "Victor Shcherbatyuk" <victor@win.tue.nl>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Thu, 8 Jun 2006 17:21:13 +0200
MIME-Version: 1.0
Subject: [Bluez-devel] DUN: samsung-E770 & LG-S5200 & more...
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

Hi,

I'm testing DUN with some LGs and Samsungs (mostly new models) and some 
cases get very strange results. From the log below, PPP configuring the 
connection:

sent [LCP ConfReq id=0x2 <asyncmap 0xa0000> <magic 0xd8a026bf>]
< ACL data: handle 42 flags 0x02 dlen 45
    L2CAP(d): cid 0x005b len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 21  7d 22 7d 20 7d 30 7d 22 
 ~.}#.!}!}"} }0}" <-------------- PPP data is escaped with 0x7D
      0010: 7d 26 7d 20 7d 2a 7d 20  7d 20 7d 25 7d 26 d8 
a0  }&} }*} } }%}&..
      0020: 26 bf f2 83 7e                                    &...~
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10 
> <-------------------------------here phone responds
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 7e                                                ~
> ACL data: handle 42 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 23 fcs 0x40
      0000: ff 03 80 21 04 02 00 10  02 06 00 0a 00 00 05 06 
...!............  <--------------- PPP data not escaped?
      0010: d8 a0 26 bf 8f e7 7e                              ..&...~

PPP sends configure request and phone replies, but for some reasong the data 
in the replied frame is not escaped as should be according to standard.... 
So it looks like PPP ignores the reply (cause it is invalid?) and sends the 
next request... And so on till we termiate the link.

Does any one has any ideas what could be wrong? Thanks in advance.

Regards,
      Victor Shcherbatyuk.

P.S. Looks like Windows handles these phones correctly
P.P.S. Another strange thing with LGs, after trying a phone it with a 
Windows PC (where it works fine), it starts to work also with the ARM box 
running Bluez, if I reboot the phone it no longer works with ARM+Bluez till 
I use it with Windows PC again. This is weird, will try to dig something up.

------------------------------------------------------COMPLETE 
LOG----------------------------------------------------------
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:15:B9:E3:31:A7 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:15:B9:E3:31:A7 type ACL encrypt 0x00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: a7 31 e3 b9 15 00 01                              .1.....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 05                                          *..
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x005b scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x005b scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x005b flags 0x00 clen 4
      MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 336
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 336
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x005b flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x005b len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x005b len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 331 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x005b len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:15:B9:E3:31:A7
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:15:B9:E3:31:A7
    Link key: c42d9b97b4bb24f61ab200474fcfb9f0
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:15:B9:E3:31:A7
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 42 encrypt 0x01
> ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x005b len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 4
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 42 encrypt 0x00
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:15:B9:E3:31:A7 role 0x01
    Role: Slave
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 05                                          *..
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 42 encrypt 0x01
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 4
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x005b len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 4
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 0 ic 0 dv 0 b1 1 b2 1 b3 0 len 4
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x005b len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 0 ic 0 dv 0 b1 1 b2 1 b3 0 len 4
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 4
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x005b len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 4
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 4
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x005b len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 4
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 4
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x005b len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 4
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 4
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0d                                                .
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 19
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 41                                                A
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 54                                                T
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 0d                                                .
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 41                                                A
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 5a                                                Z
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0d                                                .
A> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 3
      0000: 54                                                T
T> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 5a                                                Z
Z> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 0d                                                .
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 4
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x005b len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 4
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 6 fcs 0x40
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..

OK< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 61                                                a
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 74                                                t
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 2b                                                +
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 63                                                c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 67                                                g
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 4
      0000: 61                                                a
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 74                                                t
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 2b                                                +
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 64                                                d
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 63                                                c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 63                                                c
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 6f                                                o
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 6e                                                n
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 74                                                t
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 3d                                                =
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 6
      0000: 67                                                g
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 64                                                d
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 63                                                c
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 6f                                                o
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 6e                                                n
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 74                                                t
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 31                                                1
> HCI Event: Number of Completed Packets (0x13) plen 5
CAPNWizard::TestInternetConnection: waiting on PPP connection, state=3
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 2c                                                ,
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 22                                                "
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 49                                                I
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 50                                                P
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 22                                                "
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 5
      0000: 3d                                                =
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 31                                                1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 2c                                                ,
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 22                                                "
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 49                                                I
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 2c                                                ,
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 22                                                "
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 6c                                                l
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 69                                                i
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 76                                                v
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 65                                                e
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 8
      0000: 50                                                P
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 2e                                                .
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 76                                                v
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 22                                                "
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 2c                                                ,
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 22                                                "
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 6f                                                o
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 64                                                d
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 61                                                a
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a

at+cgdcont=1,"IP","live.vodafone.com"
OK
      0000: 66                                                f
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 6f                                                o
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 6e                                                n
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 30
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 65                                                e
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 2e                                                .
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 63                                                c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 6f                                                o
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 5
      0000: 6f                                                o
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 6e                                                n
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 6d                                                m
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 65                                                e
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 2e                                                .
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 63                                                c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 6f                                                o
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 22                                                "
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0d                                                .
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 3
      0000: 6d                                                m
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 22                                                "
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 0d                                                .
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 6 fcs 0x40
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 41                                                A
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 54                                                T
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 44                                                D
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 2a                                                *
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 39                                                9
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 4
      0000: 41                                                A
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 54                                                T
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 39                                                9
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 44                                                D
> ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 1 fcs 0x40
      0000: 2a                                                *
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 2a                                                *
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 2a                                                *
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 2a                                                *
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 31                                                1

ATD*99***1#
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 23                                                #
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0d                                                .
> ACL data: handle 42 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 11 fcs 0x40
      0000: 0d 0a 43 4f 4e 4e 45 43  54 0d 0a                 ..CONNECT..

CONNECT> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 1 b3 1 len 0
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x005b len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 1 b3 1 len 0

< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a
      0000: 0d                                                .
Serial connection established.
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x005b len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 1 b3 1 len 0
using channel 6
Using interface ppp0
Connect: ppp0 <--> /dev/rfcomm0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 1 b3 1 len 0
sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xd8a026bf>]
< ACL data: handle 42 flags 0x02 dlen 45
    L2CAP(d): cid 0x005b len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 21  7d 21 7d 20 7d 30 7d 22 
 ~.}#.!}!}!} }0}"
      0010: 7d 26 7d 20 7d 20 7d 20  7d 20 7d 25 7d 26 d8 
a0  }&} } } } }%}&..
      0020: 26 bf bc bf 7e                                    &...~
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      0000: 7e                                                ~
> ACL data: handle 42 flags 0x02 dlen 71
    L2CAP(d): cid 0x0040 len 67 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 63 fcs 0x40
      0000: ff 7d 23 c0 21 7d 21 7d  21 7d 20 7d 2e 7d 22 7d 
 .}#.!}!}!} }.}"}
      0010: 26 7d 20 7d 2a 7d 20 7d  20 7d 23 7d 24 c0 23 f3 
 &} }*} } }#}$.#.
      0020: 4d 7e 7e ff 7d 23 c0 21  7d 23 7d 21 7d 20 7d 2a 
 M~~.}#.!}#}!} }*
      0030: 7d 22 7d 26 7d 20 7d 2a  7d 20 7d 20 6c 50 7e     }"}&} }*} } 
lP~
< ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x005b len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 30
rcvd [LCP ConfReq id=0x1 <asyncmap 0xa0000> <auth pap>]
sent [LCP ConfAck id=0x1 <asyncmap 0xa0000> <auth pap>]
rcvd [LCP ConfNak id=0x1 <asyncmap 0xa0000>]
sent [LCP ConfReq id=0x2 <asyncmap 0xa0000> <magic 0xd8a026bf>]
< ACL data: handle 42 flags 0x02 dlen 43
    L2CAP(d): cid 0x005b len 39 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 35 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 22  7d 21 7d 20 7d 2e 7d 22 
 ~.}#.!}"}!} }.}"
      0010: 7d 26 7d 20 7d 2a 7d 20  7d 20 7d 23 7d 24 c0 
23  }&} }*} } }#}$.#
      0020: cd ce 7e                                          ..~
< ACL data: handle 42 flags 0x02 dlen 45
    L2CAP(d): cid 0x005b len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 21  7d 22 7d 20 7d 30 7d 22 
 ~.}#.!}!}"} }0}"
      0010: 7d 26 7d 20 7d 2a 7d 20  7d 20 7d 25 7d 26 d8 
a0  }&} }*} } }%}&..
      0020: 26 bf f2 83 7e                                    &...~
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      0000: 7e                                                ~
> ACL data: handle 42 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 23 fcs 0x40
      0000: ff 03 c0 21 02 02 00 10  02 06 00 0a 00 00 05 06 
...!............
      0010: d8 a0 26 bf d3 19 7e                              ..&...~
sent [LCP ConfReq id=0x2 <asyncmap 0xa0000> <magic 0xd8a026bf>]
< ACL data: handle 42 flags 0x02 dlen 45
    L2CAP(d): cid 0x005b len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 21  7d 22 7d 20 7d 30 7d 22 
 ~.}#.!}!}"} }0}"
      0010: 7d 26 7d 20 7d 2a 7d 20  7d 20 7d 25 7d 26 d8 
a0  }&} }*} } }%}&..
      0020: 26 bf f2 83 7e                                    &...~
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 7e                                                ~
> ACL data: handle 42 flags 0x02 dlen 38
    L2CAP(d): cid 0x0040 len 34 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 30 fcs 0x40
      0000: ff 03 c0 23 02 02 00 05  00 46 1e 7e 7e ff 03 80 
...#.....F.~~...
      0010: 21 01 02 00 0a 03 06 55  66 77 88 4d 23 7e        !......Ufw.M#~
sent [LCP ConfReq id=0x2 <asyncmap 0xa0000> <magic 0xd8a026bf>]
< ACL data: handle 42 flags 0x02 dlen 45
    L2CAP(d): cid 0x005b len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 21  7d 22 7d 20 7d 30 7d 22 
 ~.}#.!}!}"} }0}"
      0010: 7d 26 7d 20 7d 2a 7d 20  7d 20 7d 25 7d 26 d8 
a0  }&} }*} } }%}&..
      0020: 26 bf f2 83 7e                                    &...~
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 7e                                                ~
> ACL data: handle 42 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 23 fcs 0x40
      0000: ff 03 80 21 04 02 00 10  02 06 00 0a 00 00 05 06 
...!............
      0010: d8 a0 26 bf 8f e7 7e                              ..&...~
sent [LCP ConfReq id=0x2 <asyncmap 0xa0000> <magic 0xd8a026bf>]
< ACL data: handle 42 flags 0x02 dlen 45
    L2CAP(d): cid 0x005b len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 21  7d 22 7d 20 7d 30 7d 22 
 ~.}#.!}!}"} }0}"
      0010: 7d 26 7d 20 7d 2a 7d 20  7d 20 7d 25 7d 26 d8 
a0  }&} }*} } }%}&..
      0020: 26 bf f2 83 7e                                    &...~
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 7e                                                ~
> ACL data: handle 42 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 23 fcs 0x40
      0000: ff 03 80 21 04 02 00 10  02 06 00 0a 00 00 05 06 
...!............
      0010: d8 a0 26 bf 8f e7 7e                              ..&...~
sent [LCP ConfReq id=0x2 <asyncmap 0xa0000> <magic 0xd8a026bf>]
< ACL data: handle 42 flags 0x02 dlen 45
    L2CAP(d): cid 0x005b len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 21  7d 22 7d 20 7d 30 7d 22 
 ~.}#.!}!}"} }0}"
      0010: 7d 26 7d 20 7d 2a 7d 20  7d 20 7d 25 7d 26 d8 
a0  }&} }*} } }%}&..
      0020: 26 bf f2 83 7e                                    &...~
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 7e                                                ~
> ACL data: handle 42 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 23 fcs 0x40
      0000: ff 03 80 21 04 02 00 10  02 06 00 0a 00 00 05 06 
...!............
      0010: d8 a0 26 bf 8f e7 7e                              ..&...~
sent [LCP ConfReq id=0x2 <asyncmap 0xa0000> <magic 0xd8a026bf>]
< ACL data: handle 42 flags 0x02 dlen 45
    L2CAP(d): cid 0x005b len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 21  7d 22 7d 20 7d 30 7d 22 
 ~.}#.!}!}"} }0}"
      0010: 7d 26 7d 20 7d 2a 7d 20  7d 20 7d 25 7d 26 d8 
a0  }&} }*} } }%}&..
      0020: 26 bf f2 83 7e                                    &...~
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 7e                                                ~
> ACL data: handle 42 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 23 fcs 0x40
      0000: ff 03 80 21 04 02 00 10  02 06 00 0a 00 00 05 06 
...!............
      0010: d8 a0 26 bf 8f e7 7e                              ..&...~
sent [LCP ConfReq id=0x2 <asyncmap 0xa0000> <magic 0xd8a026bf>]
< ACL data: handle 42 flags 0x02 dlen 45
    L2CAP(d): cid 0x005b len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 21  7d 22 7d 20 7d 30 7d 22 
 ~.}#.!}!}"} }0}"
      0010: 7d 26 7d 20 7d 2a 7d 20  7d 20 7d 25 7d 26 d8 
a0  }&} }*} } }%}&..
      0020: 26 bf f2 83 7e                                    &...~
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 7e                                                ~
> ACL data: handle 42 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 23 fcs 0x40
      0000: ff 03 80 21 04 02 00 10  02 06 00 0a 00 00 05 06 
...!............
      0010: d8 a0 26 bf 8f e7 7e                              ..&...~
sent [LCP ConfReq id=0x2 <asyncmap 0xa0000> <magic 0xd8a026bf>]
< ACL data: handle 42 flags 0x02 dlen 45
    L2CAP(d): cid 0x005b len 41 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 37 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 21  7d 22 7d 20 7d 30 7d 22 
 ~.}#.!}!}"} }0}"
      0010: 7d 26 7d 20 7d 2a 7d 20  7d 20 7d 25 7d 26 d8 
a0  }&} }*} } }%}&..
      0020: 26 bf f2 83 7e                                    &...~
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 7e                                                ~
> ACL data: handle 42 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 23 fcs 0x40
      0000: ff 03 80 21 04 02 00 10  02 06 00 0a 00 00 05 06 
...!............
      0010: d8 a0 26 bf 8f e7 7e                              ..&...~
Terminating on signal 15.
sent [LCP TermReq id=0x3 "User request"]
< ACL data: handle 42 flags 0x02 dlen 37
    L2CAP(d): cid 0x005b len 33 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 29 fcs 0x9a
      0000: 7e ff 7d 23 c0 21 7d 25  7d 23 7d 20 7d 30 55 73 
 ~.}#.!}%}#} }0Us
      0010: 65 72 20 72 65 71 75 65  73 74 79 7b 7e           er requesty{~
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      0000: 7e                                                ~
> ACL data: handle 42 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 23 fcs 0x40
      0000: ff 03 c0 21 06 03 00 10  55 73 65 72 20 72 65 71  ...!....User 
req
      0010: 75 65 73 74 58 e1 7e                              uestX.~
> ACL data: handle 42 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 14 fcs 0x40
      0000: 0d 0a 4e 4f 20 43 41 52  52 49 45 52 0d 0a        ..NO CARRIER..
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 1 len 4
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x005b len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 1 len 4
Modem hangup
Connection terminated.



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
