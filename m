Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 13 Jul 2006 21:57:22 +0200 (CEST)
From: Andreas Fehr <andreas@mrs.ch>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.64.0607132135350.4704@ybpnyubfg.ybpnyqbznva>
MIME-Version: 1.0
Subject: [Bluez-users] rfcomm pairing and timeout
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


Hi

I've still a problem with pairing my phone with my bluetooth dongle. My 
phone asks me if I want a serial port connection with computer. As soon 
as I accept this, the dialog to enter the pin shows but disappears 
within about 1 second. Far to few time to enter any pin.

Is there a way to set some other timeout for pairing? Just in case it 
helps, I dumped the bluetooth connection below (including timestamps and 
some hint where I want the enter the pin). (./hcidump -X -V -t)

Thanks for any hint,
Andreas

2006-07-13 21:40:03.795979 < HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:18:0F:D8:02:3D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
2006-07-13 21:40:03.799483 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2006-07-13 21:40:06.635027 > HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:18:0F:D8:02:3D role 0x01
    Role: Slave
2006-07-13 21:40:06.646023 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 2 bdaddr 00:18:0F:D8:02:3D type ACL encrypt 0x00
2006-07-13 21:40:06.646042 < ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2006-07-13 21:40:06.646047 < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 2 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
2006-07-13 21:40:06.649022 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 2
2006-07-13 21:40:06.649037 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:18:0F:D8:02:3D mode 2 clkoffset 0x0000
2006-07-13 21:40:06.652021 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2006-07-13 21:40:06.660022 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 2 slots 5
2006-07-13 21:40:06.668018 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1
2006-07-13 21:40:06.670023 > ACL data: handle 2 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2006-07-13 21:40:06.670041 < ACL data: handle 2 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013 
2006-07-13 21:40:06.671023 > ACL data: handle 2 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772 
2006-07-13 21:40:06.671040 < ACL data: handle 2 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
2006-07-13 21:40:06.679017 > ACL data: handle 2 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 1013 
2006-07-13 21:40:06.679036 < ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
2006-07-13 21:40:06.695014 > ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
2006-07-13 21:40:06.695031 < ACL data: handle 2 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 6 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
2006-07-13 21:40:06.702012 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:18:0F:D8:02:3D name 'foun'
2006-07-13 21:40:06.703015 > ACL data: handle 2 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 6 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 0
2006-07-13 21:40:06.703037 < ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs 0xd3 
2006-07-13 21:40:06.704014 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1
2006-07-13 21:40:06.706011 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1
2006-07-13 21:40:06.708012 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 2
2006-07-13 21:40:06.718010 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1

**************** press accept on the phone
**************** and try to enter pin here

2006-07-13 21:40:07.798989 < ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 6 pf 1 ilen 0 fcs 0x32 
2006-07-13 21:40:07.809837 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1
2006-07-13 21:40:07.811835 > ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18 
2006-07-13 21:40:07.811861 < ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
2006-07-13 21:40:07.811868 < ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
2006-07-13 21:40:07.826831 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1
2006-07-13 21:40:07.827835 > ACL data: handle 2 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
2006-07-13 21:40:07.828837 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 2 packets 1
2006-07-13 21:40:07.829834 > ACL data: handle 2 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
2006-07-13 21:40:09.827109 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 2 reason 0x13
    Reason: Remote User Terminated Connection
2006-07-13 21:40:09.830507 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2006-07-13 21:40:09.848505 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 2 reason 0x16
    Reason: Connection Terminated by Local Host



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
