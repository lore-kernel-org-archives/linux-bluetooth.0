Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <443E1FCD.3040901@gdatech.co.in>
From: Hariharan <v.hariharan@gdatech.co.in>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Rfcomm resource temperorily unavailable problem
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
Date: Thu, 13 Apr 2006 15:24:21 +0530

Dear all,
We are facing one problem while connecting with rfcomm.
hciattach, hciconfig, hcitool scan all are working fine.

presently we are having only
while we try to connect with rfcomm, it says that rfcomm resuorce 
unavailable.
we are think that it is because of PIN information conflict.

Hcidump message is given below,

< HCI Command: Create Connection (0x01|0x0005) plen 13
  70 E2 73 6D 0E 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
 > HCI Event: Connect Complete (0x03) plen 11
  00 28 00 70 E2 73 6D 0E 00 01 00
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  28 00 0F 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
 > HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 28 00
 > HCI Event: Max Slots Change (0x1b) plen 3
  28 00 05
 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0093 scid 0x0040 result 1 status 2
 > HCI Event: QoS Setup Complete (0x0d) plen 21
  00 28 00 00 01 00 00 00 00 00 00 00 00 FF FF FF FF FF FF FF
  FF
 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0093 scid 0x0040 result 0 status 0
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0093 flags 0x0000 clen 4
    MTU 1024
 > ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0093 flags 0x0000 result 0 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
 > ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 672
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0093 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
 > ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x0093 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 20 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
 > ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 20 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 3
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0093 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 20 pf 1 ilen 0 fcs 0xfd
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
 > HCI Event: PIN Code Request (0x16) plen 6
  70 E2 73 6D 0E 00

-- here some time it takes after PIN code request  -----------------

Can't connect RFCOMM socket: Resource temporarily unavailable
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0093 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 20 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0093 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0093 scid 0x0040
[root@localhost bin]# > HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
 > ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 20 pf 1 ilen 0 fcs 0x36
 > ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0093 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  28 00 13
 > HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
 > HCI Event: Disconn Complete (0x05) plen 4
  00 28 00 16
 
Thanks in advance for valuable support.

Hariharan.V.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
