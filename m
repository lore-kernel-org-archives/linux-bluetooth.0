Return-Path: <cyrus@holtmann.org>
Message-Id: <8920A3CE-63EC-47AD-B9A1-70AAB04735D5@sparkintegration.com>
From: Andrew MacIsaac <andrew.macisaac@sparkintegration.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Subject: Permission Denied (EACCES) when attempting RFCOMM connection
Mime-Version: 1.0 (Apple Message framework v936)
Date: Tue, 25 Jan 2011 09:38:41 -0800
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am trying to get a simple RFCOMM client/server example to work  
between two Ubuntu 10.04.1 LTS installations.  The examples I am using  
are the rfcomm-server and rfcomm-client found here: http://people.csail.mit.edu/albert/bluez-intro/x502.html

I have four of these Ubuntu installations in total, and between two of  
them this example works without any problems, however between the  
other two I always get EACCES errors when attempting to perform  
connect().  All of the machines have the libbluetooth3 version  
4.60-0ubuntu8 installed.  If I run l2ping between the machines where I  
am experiencing this error, or from one of the working ones to one of  
the ones that is giving me problems, I get a permission denied error  
as well:

sudo l2ping 00:02:72:AC:BE:D7
Can't connect: Permission denied

The following are the hcidumps of one of the failed client-server  
sessions followed by the working one.  I can see that the failed one  
is trying to use authentication, but running

sudo hciconfig hci0 noauth

on both ends has had no effect.

FAILED:

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
1295913294.810214 < HCI Command: Create Connection (0x01|0x0005) plen 13
   C0 BE AC 72 02 00 18 CC 02 00 00 00 01
1295913294.812852 > HCI Event: Command Status (0x0f) plen 4
   00 01 05 04
1295913297.584461 > HCI Event: Role Change (0x12) plen 8
   00 C0 BE AC 72 02 00 01
1295913297.758436 > HCI Event: Connect Complete (0x03) plen 11
   00 0B 00 C0 BE AC 72 02 00 01 00
1295913297.758481 < HCI Command: Read Remote Supported Features (0x01| 
0x001b) plen 2
   0B 00
1295913297.760422 > HCI Event: Max Slots Change (0x1b) plen 3
   0B 00 05
1295913297.762426 > HCI Event: Command Status (0x0f) plen 4
   00 01 1B 04
1295913297.764415 > HCI Event: Read Remote Supported Features (0x0b)  
plen 11
   00 0B 00 FF FF 8F FE 9B FF 79 83
1295913297.764432 < HCI Command: Read Remote Extended Features (0x01| 
0x001c) plen 3
   0B 00 01
1295913297.767419 > HCI Event: Command Status (0x0f) plen 4
   00 01 1C 04
1295913297.771425 > HCI Event: Read Remote Extended Features (0x23)  
plen 13
   00 0B 00 01 01 01 00 00 00 00 00 00 00
1295913297.771459 < HCI Command: Authentication Requested (0x01| 
0x0011) plen 2
   0B 00
1295913297.773413 > HCI Event: Command Status (0x0f) plen 4
   00 01 11 04
1295913297.804036 < HCI Command: Remote Name Request (0x01|0x0019)  
plen 10
   C0 BE AC 72 02 00 02 00 00 00
1295913297.853420 > HCI Event: Link Key Request (0x17) plen 6
   C0 BE AC 72 02 00
1295913297.855404 > HCI Event: Command Status (0x0f) plen 4
   00 01 19 04
1295913297.855421 < HCI Command: Link Key Request Negative Reply (0x01| 
0x000c) plen 6
   C0 BE AC 72 02 00
1295913297.859401 > HCI Event: Command Complete (0x0e) plen 10
   01 0C 04 00 C0 BE AC 72 02 00
1295913297.861401 > HCI Event: IO Capability Request (0x31) plen 6
   C0 BE AC 72 02 00
1295913297.861540 < HCI Command: IO Capability Request Negative Reply  
(0x01|0x0034) plen 7
   C0 BE AC 72 02 00 18
1295913297.863413 > HCI Event: Command Complete (0x0e) plen 10
   01 34 04 00 C0 BE AC 72 02 00
1295913297.865404 > HCI Event: Simple Pairing Complete (0x36) plen 7
   05 C0 BE AC 72 02 00
1295913297.867400 > HCI Event: Auth Complete (0x06) plen 3
   05 0B 00
1295913297.911393 > HCI Event: Remote Name Req Complete (0x07) plen 255
   00 C0 BE AC 72 02 00 66 69 6C 65 73 65 72 76 65 72 2D 31 2D
   30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1295913299.864140 < HCI Command: Disconnect (0x01|0x0006) plen 3
   0B 00 13
1295913299.868112 > HCI Event: Command Status (0x0f) plen 4
   00 01 06 04
1295913299.945109 > HCI Event: Disconn Complete (0x05) plen 4
   00 0B 00 16

SUCCESSFUL:

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
1295913138.120190 < HCI Command: Create Connection (0x01|0x0005) plen 13
   DE D2 B0 6C 23 00 18 CC 02 00 00 00 01
1295913139.994246 > HCI Event: Command Status (0x0f) plen 4
   00 01 05 04
1295913143.297146 > HCI Event: Role Change (0x12) plen 8
   00 DE D2 B0 6C 23 00 01
1295913144.020230 > HCI Event: Connect Complete (0x03) plen 11
   00 2E 00 DE D2 B0 6C 23 00 01 00
1295913144.020284 < HCI Command: Read Remote Supported Features (0x01| 
0x001b) plen 2
   2E 00
1295913144.021047 > HCI Event: Page Scan Repetition Mode Change (0x20)  
plen 7
   DE D2 B0 6C 23 00 00
1295913144.022043 > HCI Event: Max Slots Change (0x1b) plen 3
   2E 00 05
1295913144.029093 > HCI Event: Command Status (0x0f) plen 4
   00 01 1B 04
1295913144.029110 < HCI Command: Remote Name Request (0x01|0x0019)  
plen 10
   DE D2 B0 6C 23 00 02 00 00 00
1295913144.042183 > HCI Event: Read Remote Supported Features (0x0b)  
plen 11
   00 2E 00 FF FF 8F FE 9B FF 79 83
1295913144.042219 < ACL data: handle 46 flags 0x02 dlen 10
     L2CAP(s): Info req: type 2
1295913144.050136 > HCI Event: Command Status (0x0f) plen 4
   00 01 19 04
1295913144.071127 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.073166 > ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Info rsp: type 2 result 0
       Extended feature mask 0x0080
1295913144.073187 < ACL data: handle 46 flags 0x02 dlen 10
     L2CAP(s): Info req: type 3
1295913144.081133 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.084145 > ACL data: handle 46 flags 0x02 dlen 20
     L2CAP(s): Info rsp: type 3 result 0
       Unknown (len 8)
1295913144.084165 < ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
1295913144.092113 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.105080 > ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
       Connection pending - No futher information available
1295913144.106153 > ACL data: handle 46 flags 0x02 dlen 10
     L2CAP(s): Info req: type 2
1295913144.106166 < ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Info rsp: type 2 result 0
       Extended feature mask 0x0080
1295913144.117181 > ACL data: handle 46 flags 0x02 dlen 10
     L2CAP(s): Info req: type 3
1295913144.117193 < ACL data: handle 46 flags 0x02 dlen 20
     L2CAP(s): Info rsp: type 3 result 0
       Unknown (len 8)
1295913144.129071 > ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
       Connection successful
1295913144.129095 < ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1013
1295913144.131162 > HCI Event: Remote Name Req Complete (0x07) plen 255
   00 DE D2 B0 6C 23 00 6C 69 6E 75 78 2D 64 65 76 2D 30 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1295913144.134154 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.137148 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.147181 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.147191 > ACL data: handle 46 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       MTU 1013
1295913144.149079 > ACL data: handle 46 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1013
1295913144.149097 < ACL data: handle 46 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       MTU 1013
1295913144.149133 < ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
1295913144.158153 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.160111 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.162150 > ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
1295913144.162184 < ACL data: handle 46 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1008 max_retrans 0 credits 7
1295913144.170142 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.172052 > ACL data: handle 46 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
       frame_size 1008 max_retrans 0 credits 7
1295913144.172082 < ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
1295913144.180152 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.181179 > ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
1295913144.181220 < ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
1295913144.183165 > ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
1295913144.183209 < ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
1295913144.192141 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.194056 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.195060 > ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
1295913144.195104 < ACL data: handle 46 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
1295913144.195119 < ACL data: handle 46 flags 0x02 dlen 14
     L2CAP(d): cid 0x0040 len 10 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
       68 65 6C 6C 6F 21
1295913144.195133 < ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8
1295913144.196121 > ACL data: handle 46 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 33
1295913144.202165 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.206151 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 02 00
1295913144.207169 > ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 0 dlci 2 pf 1 ilen 0 fcs 0xd9
1295913144.207206 < ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 0 dlci 2 pf 1 ilen 0 fcs 0xf3
1295913144.209223 > ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
1295913144.209299 < ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DM: cr 0 dlci 2 pf 1 ilen 0 fcs 0x12
1295913144.217193 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.219152 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913144.219157 > ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
1295913146.203916 < ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
1295913146.203965 < ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1295913146.206144 > ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
1295913146.213138 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913146.215152 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 2E 00 01 00
1295913146.215157 > ACL data: handle 46 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
1295913146.217135 > ACL data: handle 46 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
1295913148.215868 < HCI Command: Disconnect (0x01|0x0006) plen 3
   2E 00 13
1295913148.224078 > HCI Event: Command Status (0x0f) plen 4
   00 01 06 04
1295913148.235139 > HCI Event: Disconn Complete (0x05) plen 4
   00 2E 00 16


Any assistance in resolving this would be appreciated.

Thanks,

Andrew


--
Andrew MacIsaac | Computer Engineer
Spark Integration Technologies Inc.
1880 West First Ave, Suite 200, Vancouver, BC, V6J 1G5 | T 604 736 6675 x 109 | F 604 648 9544
http://www.sparkintegration.com

------------------------------------------------------------------------
Confidentiality Warning:
========================
This message contains confidential information and is intended
only for the use individual(s) as named. If you are not the named
addressee you are hereby notified that any review,
retransmission, conversion to hard copy, copying, circulation
dissemination, or other use of this message and any attachments
is strictly prohibited. If you are not the intended recipient, please
notify the sender immediately by e-mail and delete this e-mail
from your system.

Disclaimer:
===========
E-mail transmission cannot be guaranteed to be secure or
error-free as information could be intercepted, corrupted, lost,
destroyed, arrive late or incomplete, or contain viruses. The
sender therefore does not accept liability for any errors or
omissions in the contents of this message, which arise as a
result of e-mail transmission. If verification is required please
request a hard-copy version.
------------------------------------------------------------------------
