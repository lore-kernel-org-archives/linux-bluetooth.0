Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060823224610.63128.qmail@web51415.mail.yahoo.com>
Date: Wed, 23 Aug 2006 15:46:10 -0700 (PDT)
From: manojt ambe <mp_tambe@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Receive audio from Motorola HS850 headset
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

I want to receive audio from HS850 headset. I have
connected RFCOMM channel 3 and able to receive AT
command when key is pressed. But when i try to connect
SCO channel using SCO socket program on channel 1, i
get "No Route found (113)". I am using bluez 3.1.
Has anyone seen similar issue? Are there any special
tests needed to do this?

Pls let me know. I have pasted sdptool and hcidump
outputs below.

regards,
Manoj


The sdptool records <BT ADDR> gives follwing output.

Service Name: Headset
Service RecHandle: 0x10000
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: Hands-Free unit
Service RecHandle: 0x10001
Service Class ID List:
  "Handsfree" (0x111e)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0101

Service Name: Serial Command
Service RecHandle: 0x10002
Service Class ID List:
  "Serial Port" (0x1101)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Profile Descriptor List:
  "Serial Port" (0x1101)
    Version: 0x0100

[root@dhcp-10-2-201-204 root]# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
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
    L2CAP(s): Connect rsp: dcid 0x026a scid 0x0040
result 1 status 2
      Connection pending - Authorization pending
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:13:17:03:46:88 name
'Motorola HS850'
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x026a scid 0x0040
result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x026a flags 0x00 clen
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
    L2CAP(s): Config rsp: scid 0x026a flags 0x00
result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x026a len 4 [psm 3]
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
    L2CAP(d): cid 0x026a len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs
0x70 mcc_len 8
      dlci 6 frame_type 0 credit_flow 15 pri 0
ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs
0xaa mcc_len 8
      dlci 6 frame_type 0 credit_flow 14 pri 0
ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x026a len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs
0xd3
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 6 pf 1 ilen 0 fcs 0x18
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x026a len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs
0x70 mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0
len 0
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x026a len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 6 pf 1 ilen 0 fcs 0x93
credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs
0xaa mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0
len 0
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x026a len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs
0x70 mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0
len 0
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs
0xaa mcc_len 2
      dlci 6 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0
len 0
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 1 ilen 0 fcs 0x49
credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 17
> ACL data: handle 41 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 6 pf 0 ilen 10 fcs
0x55
      0000: 41 54 2a 4b 45 59 3d 31  30 0d            
       AT*KEY=10.
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
