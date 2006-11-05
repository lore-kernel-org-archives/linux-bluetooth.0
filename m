Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 4 Nov 2006 19:14:04 -0800 (PST)
From: Sankaran Ganesan <sankaran_g@yahoo.com>
To: Sankaran Ganesan <sankaran_g@yahoo.com>, bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <537674.45675.qm@web31812.mail.mud.yahoo.com>
Cc: sankaran_g@yahoo.com
Subject: Re: [Bluez-devel] rfcomm connection refused: to Motorola Razr with
	bluez 3.7
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

hcidump again but with 'Invalid CID in Request' this
time.

thanks
sg

[root@pavs-ap1 BT]# rfcomm connect hci0 
00:15:A8:E2:0B:78 7
Can't connect RFCOMM socket: Connection refused
[root@pavs-ap1 BT]# 

[root@pavs-ap1 bluetooth]# hcidump -V
HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:15:A8:E2:0B:78 ptype 0xcc18 rswitch 0x01
clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr 00:15:A8:E2:0B:78
type ACL encrypt 0x00
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Read Remote Supported Features
(0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b)
status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings
(0x02|0x000d) plen 4
    handle 12 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Read Remote Supported Features (0x0b)
plen 11
    status 0x00 handle 12
    Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00 0x00
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 12
< HCI Command: Remote Name Request (0x01|0x0019) plen
10
    bdaddr 00:15:A8:E2:0B:78 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd
1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:15:A8:E2:0B:78 name 'Razr
V3'
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040
result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
4
      MTU 1013 
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
4
      MTU 1506 
< ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 4
      Success
      MTU 1013 
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs
0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 4
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs
0x70 mcc_len 8
      dlci 14 frame_type 0 credit_flow 15 pri 7
ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs
0xaa mcc_len 8
      dlci 14 frame_type 0 credit_flow 14 pri 7
ack_timer 0
      frame_size 256 max_retrans 0 credits 0
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 14 pf 1 ilen 0 fcs
0x6 
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:15:A8:E2:0B:78
< HCI Command: Link Key Request Reply (0x01|0x000b)
plen 22
    bdaddr 00:15:A8:E2:0B:78 key
CAEBECF3230F883C4C2E986637831F90
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:15:A8:E2:0B:78
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 14 pf 1 ilen 0 fcs 0x2c

< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs
0xfd 
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Command rej: reason 2 dcid 0x0040 scid
0x0040
      Invalid CID in request
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 3
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 12 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x16
    Reason: Connection Terminated by Local Host



--- Sankaran Ganesan <sankaran_g@yahoo.com> wrote:

> It used to connect before; with the same config 
> couldn't connect after I upgrade the stack to 3.7. I
> have a belkin dongle running FC6. I'm attaching the
> hcidump and configs. pls let me know if there is any
> known issue. 
> 
> thanks
> sg  
> 
> 
> [root@pavs-ap1 bluetooth]# hciconfig hci0 version
> hci0:   Type: USB
>         BD Address: 00:0A:3A:6F:AD:0C ACL MTU:
> 1017:8
> SCO MTU: 64:8
>         HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver:
> 2.0 (0x3) LMP Subver: 0x415c
>         Manufacturer: Broadcom Corporation (15)
> [root@pavs-ap1 bluetooth]# hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:0A:3A:6F:AD:0C ACL MTU:
> 1017:8
> SCO MTU: 64:8
>         Firmware 0.65 / 92
> [root@pavs-ap1 BT]# rpm -qa |grep bluez
> bluez-libs-devel-3.7-1
> bluez-utils-cups-3.7-2
> bluez-gnome-0.6-1.fc6
> bluez-hcidump-1.32-1
> bluez-libs-3.7-1
> bluez-utils-3.7-2
> 
> [root@pavs-ap1 BT]# rfcomm connect  
> 00:15:A8:E2:0B:78
> Can't connect RFCOMM socket: Connection refused
> [root@pavs-ap1 BT]# 
> 
> 
> [root@pavs-ap1 bluetooth]# hcidump -V
> HCI sniffer - Bluetooth packet analyzer ver 1.32
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen
> 13
>     bdaddr 00:15:A8:E2:0B:78 ptype 0xcc18 rswitch
> 0x01
> clkoffset 0x0000
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> > HCI Event: Command Status (0x0f) plen 4
>     Create Connection (0x01|0x0005) status 0x00 ncmd
> 1
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 12 bdaddr 00:15:A8:E2:0B:78
> type ACL encrypt 0x00
> < ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0040
> < HCI Command: Read Remote Supported Features
> (0x01|0x001b) plen 2
>     handle 12
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 12 slots 5
> > HCI Event: Command Status (0x0f) plen 4
>     Read Remote Supported Features (0x01|0x001b)
> status 0x00 ncmd 1
> < HCI Command: Write Link Policy Settings
> (0x02|0x000d) plen 4
>     handle 12 policy 0x0f
>     Link policy: RSWITCH HOLD SNIFF PARK 
> > HCI Event: Read Remote Supported Features (0x0b)
> plen 11
>     status 0x00 handle 12
>     Features: 0xff 0xff 0x0d 0x00 0x00 0x00 0x00
> 0x00
> > HCI Event: Command Complete (0x0e) plen 6
>     Write Link Policy Settings (0x02|0x000d) ncmd 1
>     status 0x00 handle 12
> < HCI Command: Remote Name Request (0x01|0x0019)
> plen
> 10
>     bdaddr 00:15:A8:E2:0B:78 mode 2 clkoffset 0x0000
> > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00
> ncmd
> 1
> > HCI Event: Remote Name Req Complete (0x07) plen
> 255
>     status 0x00 bdaddr 00:15:A8:E2:0B:78 name 'Razr
> V3'
> > ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040
> result 0 status 0
>       Connection successful
> < ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00
> clen
> 4
>       MTU 1013 
> > ACL data: handle 12 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00
> clen
> 4
>       MTU 1506 
> < ACL data: handle 12 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00
> result 0 clen 0
>       Success
> > ACL data: handle 12 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00
> result 0 clen 4
>       Success
>       MTU 1013 
> < ACL data: handle 12 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs
> 0x1c 
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 12 packets 4
> > ACL data: handle 12 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs
> 0xd7 
> < ACL data: handle 12 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10
> fcs
> 0x70 mcc_len 8
>       dlci 14 frame_type 0 credit_flow 15 pri 7
> ack_timer 0
>       frame_size 1008 max_retrans 0 credits 7
> > ACL data: handle 12 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 3]
>       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10
> fcs
> 0xaa mcc_len 8
>       dlci 14 frame_type 0 credit_flow 14 pri 7
> ack_timer 0
>       frame_size 256 max_retrans 0 credits 0
> < ACL data: handle 12 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 14 pf 1 ilen 0 fcs
> 0x6 
> > HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:15:A8:E2:0B:78
> < HCI Command: Link Key Request Reply (0x01|0x000b)
> plen 22
>     bdaddr 00:15:A8:E2:0B:78 key
> CAEBECF3230F883C4C2E986637831F90
> > HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Reply (0x01|0x000b) ncmd 1
>     status 0x00 bdaddr 00:15:A8:E2:0B:78
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 12 packets 2
> > ACL data: handle 12 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 14 pf 1 ilen 0 fcs
> 0x2c
> 
> < ACL data: handle 12 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs
> 0xfd 
> < ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> > ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> < ACL data: handle 12 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 12 packets 3
> > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 12 reason 0x13
>     Reason: Remote User Terminated Connection
> 
> 
> [root@pavs-ap1 BT]# sdptool browse 
> Inquiring ...
> Browsing 00:15:A8:E2:0B:78 ...
> Service RecHandle: 0x0
> Service Class ID List:
>   "SDP Server" (0x1000)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "SDP" (0x0001)
> Profile Descriptor List:
>   "SDP Server" (0x1000)
>     Version: 0x0100
> 
> Service Name: Dial-up networking Gateway
> Service Description: Dial-up networking Gateway
> Service Provider: /a/mobile/system/cl.gif
> Service RecHandle: 0x10001
> Service Class ID List:
>   "Dialup Networking" (0x1103)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 1
> Language Base Attr List:
>   code_ISO639: 0x656e
> 
=== message truncated ===



 
____________________________________________________________________________________
Want to start your own business? Learn how on Yahoo! Small Business 
(http://smallbusiness.yahoo.com) 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
