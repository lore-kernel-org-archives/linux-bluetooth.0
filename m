Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41C7C3D5.60403@webstuhl.net>
From: Ben Pezzei <ben@webstuhl.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] hstest with anycom 240 Dongle
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 21 Dec 2004 07:33:57 +0100

Hello,

Currently I am trying to play some sound with the
Anycom 240 USB Dongle to my Plantronics 2500 Headset.

Setup is a Slackware 10 Box with 2.6.8 Kernel with
latest ALSA- and bluez-Drivers, Libs and Tools.

Everything compiled fine, but when I try to run
./hstest record sound.out <addr> 1
- if there is no Connection Timeout - an SCO Connection
can be established and sound.out is filled with data.

When playing this File with aplay it sounds more or
less like (loud) static. (Unsigned 8 bit, Rate 8000 Hz, Mono)

When sending this file back to headset with
./hstest play sound.out <addr> 1
nothing can be heard. I tried this with different au
or wav Formats, but still nothing.

After every second try, the BT (or USB) Dongle Connection
is messed up, and i have to replug the dongle.

Is there any chance to get a working setup?
Any help or hint would be greatly appreciated

output of some commands:
hciconfig -a
hci0:   Type: USB
         BD Address: 00:0B:0D:30:31:FA ACL MTU: 120:20  SCO MTU: 64:0
         UP RUNNING PSCAN ISCAN
         RX bytes:986683 acl:22 sco:19305 events:68 errors:0
         TX bytes:1213 acl:14 sco:0 commands:44 errors:0
         Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ (0)'
         Class: 0x3e0100
         Service Classes: Networking, Rendering, Capturing
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 
0x757
         Manufacturer: Silicon Wave (11)

hciconfig hci0 revision
-> Unsupported manufacturer
    ^^^^ bad?

And the beginnig of hcidump. (sorry if its quite long, but i dont know
which part contains the "important" data):

device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
   0000: 01 25 0c 00 60 00                                 .%..`.
< HCI Command: Create Connection (0x01|0x0005) plen 13
   0000: fc 01 51 89 03 00 18 cc  02 00 00 00 01           ..Q..........
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 01 05 04                                       ....
 > HCI Event: Link Key Request (0x17) plen 6
   0000: fc 01 51 89 03 00                                 ..Q...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
   0000: fc 01 51 89 03 00 0c b8  03 d9 4b 83 9f 8e 2b 0b  ..Q.......K...+.
   0010: 87 c8 b1 24 92 8c                                 ...$..
 > HCI Event: Command Complete (0x0e) plen 10
   0000: 01 0b 04 00 fc 01 51 89  03 00                    ......Q...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
   0000: fc 01 51 89 03 00 0c b8  03 d9 4b 83 9f 8e 2b 0b  ..Q.......K...+.
   0010: 87 c8 b1 24 92 8c                                 ...$..
 > HCI Event: Command Complete (0x0e) plen 10
   0000: 01 0b 04 0c fc 01 51 89  03 00                    ......Q...
 > HCI Event: Connect Complete (0x03) plen 11
   0000: 00 01 00 fc 01 51 89 03  00 01 01                 .....Q.....
< ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
   0000: 01 00 0f 00                                       ....
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
   0000: 00 01 00 18 cc                                    .....
 > HCI Event: Command Complete (0x0e) plen 6
   0000: 01 0d 08 00 01 00                                 ......
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 01 00 01 00                                    .....
 > ACL data: handle 0x0001 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 1 status 2
 > ACL data: handle 0x0001 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 0 status 0
< ACL data: handle 0x0001 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
     MTU 1024
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 01 00 01 00                                    .....
 > ACL data: handle 0x0001 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0001 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
     MTU 1024
< ACL data: handle 0x0001 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 01 00 01 00                                    .....
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 01 00 01 00                                    .....
 > ACL data: handle 0x0001 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 0x0001 flags 0x02 dlen 18
     L2CAP(d): cid 0x0041 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1019 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 01 00 01 00                                    .....
 > ACL data: handle 0x0001 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
       frame_size 127 max_retrans 0 credits 0
< ACL data: handle 0x0001 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 01 00 01 00                                    .....
 > ACL data: handle 0x0001 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(d): cid 0x0041 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
   0000: 01 00 e0 00                                       ....
 > ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(d): cid 0x0041 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 01 07 04                                       ....
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 01 00 01 00                                    .....
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 01 00 01 00                                    .....
 > HCI Event: Connect Complete (0x03) plen 11
   0000: 00 00 01 fc 01 51 89 03  00 00 01                 .....Q.....
 > SCO data: handle 0x0100 dlen 48
     0000: ff ff fd ff fa ff fb ff  fd ff fc ff fc ff fc ff 
................
     0010: fd ff fc ff fd ff fe ff  fe ff fe ff fd ff fd ff 
................
     0020: fe ff fd ff fe ff fe ff  fd ff fe ff fd ff fe ff 
................
 > SCO data: handle 0x0100 dlen 48
     0000: fe ff fe ff fe ff fe ff  fe ff fd ff 00 00 fe ff 
................
     0010: fd ff fe ff fe ff fe ff  fe ff fd ff fe ff fd ff 
................
     0020: fe ff fe ff fe ff fe ff  fe ff fe ff fd ff fe ff 
................
 > ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 1 len 15
< ACL data: handle 0x0001 flags 0x02 dlen 9
     L2CAP(d): cid 0x0041 len 5 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
 > ACL data: handle 0x0001 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 01 00 01 00                                    .....
 > SCO data: handle 0x0100 dlen 48
     0000: fd ff fe ff fe ff fe ff  fe ff fe ff fe ff fd ff 
................
     0010: fe ff fd ff fe ff fe ff  fe ff 00 00 00 00 00 00 
................
     0020: fe ff fe ff fe ff fd ff  fe ff fd ff fe ff fe ff 
................

 From here there are only SCO Parts quite similiar to the last
above

except (volume i guess):

 > ACL data: handle 0x0001 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40
       0000: 41 54 2b 56 47 53 3d 31  31 0d                    AT+VGS=11.
< ACL data: handle 0x0001 flags 0x02 dlen 12
     L2CAP(d): cid 0x0041 len 8 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 4 fcs 0x9a
       0000: 4f 4b 0d 0a                                       OK..
 > SCO data: handle 0x0100 dlen 48


I also tried snd-bt-sco SCO but after successfull compiling
and cfg, no sound arrives at the Headset

again, any help or hint would be great.

greetings
ben





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
