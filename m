Return-Path: <Edward.Wei@Dartmouth.edu>
Message-ID: <415D6B27.5080805@Dartmouth.edu>
Date: Fri, 01 Oct 2004 10:35:19 -0400
From: Edward Wei <Edward.Wei@Dartmouth.edu>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Infineon ROK104001 Bluetooth Problem
References: <415C6D46.1020309@Dartmouth.edu> <1096618056.5403.14.camel@notepaq>
In-Reply-To: <1096618056.5403.14.camel@notepaq>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Oh sorry.  I put the commands right next to the hcidump of my first 
message.  I'll make it more specific this time.

There are no problems with sending to the Infineon + PXA.

Laptop with Kensington USB Dongle (sender)
# ./rctest.exec -s -P 10 xx:xx:xx:xx:xx:xx

Infineon ROK + PXA (receiver)
# ./rctest.exec


There are problems sending with the Infineon + PXA.

Laptop with Kensington USB Dongle (receiver)
# ./rctest.exec

Infineon ROK + PXA (sender)
# hcidump -x &
# ./rctest.exec -s -P 10 xx:xx:xx:xx:xx:xx

This is the hcidump that follows... a few packets get through, then it 
stalls and says "hci_cmd_task: hci0 command tx timeout".


< HCI Command: Create Connection (0x01|0x0005) plen 13
 93 D6 46 76 0C 00 18 CC 01 00 B7 ED 01

> HCI Event: Command Status (0x0f) plen 4

 00 07 05 04

> HCI Event: Connect Complete (0x03) plen 11

 00 02 00 93 D6 46 76 0C 00 01 00 < ACL data: handle 0x0002 flags 0x02 
dlen 12
   L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
 02 00 0F 00

> HCI Event: Command Status (0x0f) plen 4

 00 08 00 00

> HCI Event: Command Complete (0x0e) plen 6

 08 0D 08 00 02 00

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00

> HCI Event: Max Slots Change (0x1b) plen 3

 02 00 05

> ACL data: handle 0x0002 flags 0x02 dlen 16

   L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0002 flags 0x02 dlen 16
   L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
   MTU 1024

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00

> ACL data: handle 0x0002 flags 0x02 dlen 14

   L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0

> ACL data: handle 0x0002 flags 0x02 dlen 16

   L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
   MTU 1024 < ACL data: handle 0x0002 flags 0x02 dlen 14
   L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0002 flags 0x02 dlen 8
   L2CAP(d): cid 0x0040 len 4 [psm 3]
     RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00

> ACL data: handle 0x0002 flags 0x02 dlen 8

   L2CAP(d): cid 0x0040 len 4 [psm 3]
     RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 < ACL data: handle 
0x0002 flags 0x02 dlen 18
   L2CAP(d): cid 0x0040 len 14 [psm 3]
     RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
     dlci 20 frame_type 0 credit_flow 15 pri 7 ack_timer 0
     frame_size 1019 max_retrans 0 credits 7

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00

> ACL data: handle 0x0002 flags 0x02 dlen 18

   L2CAP(d): cid 0x0040 len 14 [psm 3]
     RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
     dlci 20 frame_type 0 credit_flow 14 pri 7 ack_timer 0
     frame_size 1019 max_retrans 0 credits 7
< ACL data: handle 0x0002 flags 0x02 dlen 8
   L2CAP(d): cid 0x0040 len 4 [psm 3]
     RFCOMM(s): SABM: cr 1 dlci 20 pf 1 ilen 0 fcs 0xfd

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00

> ACL data: handle 0x0002 flags 0x02 dlen 8

   L2CAP(d): cid 0x0040 len 4 [psm 3]
     RFCOMM(s): UA: cr 1 dlci 20 pf 1 ilen 0 fcs 0x36 < ACL data: handle 
0x0002 flags 0x02 dlen 12
   L2CAP(d): cid 0x0040 len 8 [psm 3]
     RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
     dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
rctest[172]: Connected
rctest[172]: Sending ...

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00

> ACL data: handle 0x0002 flags 0x02 dlen 12

   L2CAP(d): cid 0x0040 len 8 [psm 3]
     RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
     dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0002 flags 0x02 dlen 12
   L2CAP(d): cid 0x0040 len 8 [psm 3]
     RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
     dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00

> ACL data: handle 0x0002 flags 0x02 dlen 12

   L2CAP(d): cid 0x0040 len 8 [psm 3]
     RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
     dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0002 flags 0x02 dlen 9
   L2CAP(d): cid 0x0040 len 5 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 20 pf 1 ilen 0 fcs 0x2d credits 33
< ACL data: handle 0x0002 flags 0x02 dlen 135
   L2CAP(d): cid 0x0040 len 131 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31      00 00 00 
00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00

> ACL data: handle 0x0002 flags 0x02 dlen 9

   L2CAP(d): cid 0x0040 len 5 [psm 3]
     RFCOMM(d): UIH: cr 0 dlci 20 pf 1 ilen 0 fcs 0xf7 credits 33

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00 < ACL data: handle 0x0002 flags 0x02 dlen 135
   L2CAP(d): cid 0x0040 len 131 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31      01 00 00 
00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00 < ACL data: handle 0x0002 flags 0x02 dlen 135
   L2CAP(d): cid 0x0040 len 131 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31      02 00 00 
00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00 < ACL data: handle 0x0002 flags 0x02 dlen 135
   L2CAP(d): cid 0x0040 len 131 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31      03 00 00 
00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F

> HCI Event: Hardware Error (0x10) plen 2

 23 08 < ACL data: handle 0x0002 flags 0x02 dlen 135
   L2CAP(d): cid 0x0040 len 131 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31      04 00 00 
00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F

> HCI Event: Hardware Error (0x10) plen 1

 20

> HCI Event: Number of Completed Packets (0x13) plen 5

 01 02 00 01 00 < ACL data: handle 0x0002 flags 0x02 dlen 135
   L2CAP(d): cid 0x0040 len 131 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31      05 00 00 
00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F < ACL data: handle 0x0002 
flags 0x02 dlen 135
   L2CAP(d): cid 0x0040 len 131 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31      06 00 00 
00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F < ACL data: handle 0x0002 
flags 0x02 dlen 135
   L2CAP(d): cid 0x0040 len 131 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31      07 00 00 
00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F < ACL data: handle 0x0002 
flags 0x02 dlen 135
   L2CAP(d): cid 0x0040 len 131 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31      08 00 00 
00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
7F 7F 7F 7F 7F 7F 7F      7F 7F 7F 7F 7F 7F 7F





Marcel Holtmann wrote:

>Hi Edward,
>
>  
>
>>I'm using the Infineon ROK104001 module connected to an Intel PXA255 
>>serial BTUART.  I tried running rctest and l2test from the bluez-libs 
>>sources and I seem to have problems sending with this setup and no 
>>problems receiving.
>>    
>>
>
>be more specific. What is your problem. Describe what you are doing
>(command lines etc.) and then what fails and what works.
>
>Regards
>
>Marcel
>
>
>  
>
