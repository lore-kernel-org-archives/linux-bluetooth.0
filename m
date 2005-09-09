Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4321C81E.3020508@telia.com>
From: Mikael Hakali <mhakali@telia.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Samsung SGH-Z500 problem (connection refused)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 09 Sep 2005 19:36:30 +0200

Hello!

I am having problems using the device node created for the bluetooth 
device (rfcomm0) with the error "connection refused". Notable is that I 
have successfully set up same kind of connection with same type of 
configuration

System: Archlinux
Kernel: custom kernel 2.6.13-mm2, tried various others down to 2.6.10
Userspace: bluez-utils 2.20-1
Bluetooth devices on laptop: Built in acting as a bluetooth usb dongle 
and an actual Dlink USB dongle. Same result.

Starting of services:
Frixy ~ # /etc/init.d/bluetooth start
Starting Bluetooth subsystem: hcid sdpd hidd hid2hci rfcomm pand.

System logs:
Sep  9 19:11:29 [hcid] Bluetooth HCI daemon
Sep  9 19:11:29 [hcid] Starting security manager 0
Sep  9 19:11:29 [sdpd] Bluetooth SDP daemon_
Sep  9 19:11:29 [hidd] Bluetooth HID daemon
Sep  9 19:11:29 [pand] Bluetooth PAN daemon version 2.20

Command log:
Frixy ~ # hcitool inq
Inquiring ...
        00:12:47:4E:FE:CD       clock offset: 0x7ffc    class: 0x520204
Frixy ~ # rfcomm bind 1 00:12:47:4E:FE:CD
Frixy ~ # rfcomm
rfcomm1: 00:12:47:4E:FE:CD channel 1 clean
Frixy ~ # ls -l /dev/rfcomm1
0 crw-rw----  1 root tty 216, 1 2005-09-09 19:24 /dev/rfcomm1
Frixy ~ # cat /dev/rfcomm1
cat: /dev/rfcomm1: Connection refused

Any application trying to use the device node fails. Pin code is 
verified because I get "Access Denied" if wrong pin code is entered 
before the devices are paired. The devices are successfully paired.

hcidump data while trying to access device:

Frixy ~ # hcidump -x
HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  CD FE 4E 47 12 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
 > HCI Event: Link Key Request (0x17) plen 6
  CD FE 4E 47 12 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  CD FE 4E 47 12 00 C0 57 E2 46 87 60 1A E2 0E 65 6F 0B 95 E0
  4F 94
 > HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 CD FE 4E 47 12 00
 > HCI Event: Connect Complete (0x03) plen 11
  00 29 00 CD FE 4E 47 12 00 01 01
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
 > HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0040 result 0 status 0
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0047 flags 0x00 clen 4
      MTU 1024
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0047 flags 0x00 result 0 clen 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0047 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 3
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0047 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0047 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0047 scid 0x0040
 > HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 13

I have tried all possible configuration options in the phone as I can 
think of. Since I've used 2 other cell phones as GPRS/UMTS modems before 
(A nokia and a sony ericsson) I have played around with most common 
settings as can be done.

I have followed guides and tried to find one single case of any user 
having the same problem as I without success.

I am suspecting that some of the devices dosent follow the standards in 
communication protocol. The tricky question is to find out where and 
what goes wrong. :)

Any help is appreciated. Thanks!
   Mikael


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
