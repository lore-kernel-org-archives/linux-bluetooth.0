Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: soraberri <421246@posta.unizar.es>
Message-ID: <csm972$gnu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Can't connect RFCOMM socket
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
Date: Wed, 19 Jan 2005 19:33:36 +0100

Hi

First of all thanks again for your time, maybe this is another proof of 
my lack of basic knowledge, but I've trying a lot and can't get ride of 
this error (I know this error is in many mails arround the list, but I 
have not find the particular remedy for mine)

When I try:

  rfcomm connect rfcomm0 00:10:60:A5:8F:8A 5

I get:

Can't connect RFCOMM socket: Connection refused
___________

modules l2cap, rfcomm are already loaded.
I have not paired both devices before, I only worry about this when the 
pop-up PIN helper window claims for the PIN... but this time it doesn't 
happen ¿how should I pair before?

Regards,


This is the dump for the device running rfcomm connect:
______________________________________________________________
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
   8A 8F A5 60 10 00 18 CC 02 00 00 00 01
 > HCI Event: Command Status (0x0f) plen 4
   00 01 05 04
 > HCI Event: Connect Complete (0x03) plen 11
   00 29 00 8A 8F A5 60 10 00 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
   29 00 0F 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
 > HCI Event: Command Complete (0x0e) plen 6
   01 0D 08 00 29 00
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
   8A 8F A5 60 10 00 01
 > HCI Event: Max Slots Change (0x1b) plen 3
   29 00 05
 > ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
     MTU 1024
 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
     MTU 1024
< ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 0x0029 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 10 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1019 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 10 pf 1 ilen 0 fcs 0xa6
< ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
   01 29 00 01 00
 > ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
   29 00 13
 > HCI Event: Command Status (0x0f) plen 4
   00 01 06 04
 > HCI Event: Disconn Complete (0x05) plen 4
   00 29 00 16

__________________________________________________________

and this is the dump for the remote device
________________________________________________________
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff

 > HCI Event: Connect Request (0x04) plen 10

  AA 96 A5 60 10 00 04 01 12 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  AA 96 A5 60 10 00 01

 > HCI Event: Command Status (0x0f) plen 4

  00 01 09 04

 > HCI Event: Connect Complete (0x03) plen 11

  00 29 00 AA 96 A5 60 10 00 01 00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00

 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7

  AA 96 A5 60 10 00 01

 > HCI Event: Command Complete (0x0e) plen 6

  01 0D 08 00 29 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  29 00 18 CC

 > HCI Event: Max Slots Change (0x1b) plen 3

  29 00 05

 > HCI Event: Command Status (0x0f) plen 4

  00 01 0F 04

 > HCI Event: Connection Packet Type Changed (0x1d) plen 5

  00 29 00 18 CC

 > ACL data: handle 0x0029 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 3 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0

 > HCI Event: Number of Completed Packets (0x13) plen 5

  01 29 00 01 00

 > ACL data: handle 0x0029 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024

 > HCI Event: Number of Completed Packets (0x13) plen 5

  01 29 00 01 00

 > HCI Event: Number of Completed Packets (0x13) plen 5

  01 29 00 01 00

 > ACL data: handle 0x0029 flags 0x02 dlen 14

    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0

 > ACL data: handle 0x0029 flags 0x02 dlen 8

    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7

 > HCI Event: Number of Completed Packets (0x13) plen 5

  01 29 00 01 00

 > ACL data: handle 0x0029 flags 0x02 dlen 18

    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 10 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 10 pf 1 ilen 0 fcs 0xa6

 > HCI Event: Number of Completed Packets (0x13) plen 5

  01 29 00 01 00

 > ACL data: handle 0x0029 flags 0x02 dlen 8

    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7

 > ACL data: handle 0x0029 flags 0x02 dlen 12

    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

 > HCI Event: Number of Completed Packets (0x13) plen 5

  01 29 00 01 00

 > HCI Event: Number of Completed Packets (0x13) plen 5

  01 29 00 01 00

 > HCI Event: Disconn Complete (0x05) plen 4

  00 29 00 13



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
