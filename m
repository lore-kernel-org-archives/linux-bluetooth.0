Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FA06A5.3010904@tootai.net>
From: administrator tootai <admin@tootai.net>
MIME-Version: 1.0
To: Bluetooth <bluez-users@lists.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-users] Connection issue with headset
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
Date: Fri, 28 Jan 2005 10:32:21 +0100

Hi list,

I try to run an HAMA BT Headset connected through a Linksys BT USB 
adapter on my notebook.

I got to install alsa modules and the other BT softs. My outputs are:

dmesg [...]
Bluetooth: L2CAP ver 2.6
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
snd-bt-sco revision 1.4 $
snd-bt-sco: snd-bt-scod thread starting
nomade:/home/dh#

nomade:~# hciconfig -a
hci0:   Type: USB
         BD Address: 00:0C:41:E2:4C:B0 ACL MTU: 192:8  SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:2539 acl:39 sco:0 events:103 errors:0
         TX bytes:1246 acl:38 sco:0 commands:41 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'nomade-0'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP 
Subver: 0x20d
         Manufacturer: Cambridge Silicon Radio (10)

nomade:~# hcitool info 00:0b:2e:06:01:2e
Requesting information ...
         BD Address:  00:0b:2e:06:01:2e
         Device Name: BT1000
         LMP Version: 1.1 (0x1) LMP Subversion: 0x405
         Manufacturer: Transilica, Inc. (24)
         Features: 0xff 0xf9 0x31 0x00 0x00 0x00 0x00 0x00
                 <3-slot packets> <5-slot packets> <encryption> <slot 
offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <SCO link> <HV2 packets> <HV3 packets>
                 <u-law log> <A-law log> <CVSD>

I launch btsco

nomade:/home/dh# btsco 00:0b:2e:06:01:2e
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 6 connected

and that's all. Hcidump -X outputs are (notice the unexpected errors):

nomade:/home/dh# hcidump -X
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
   0000: 2e 01 06 2e 0b 00 18 cc  02 00 00 00 01           .............
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 01 05 04                                       ....
 > HCI Event: Link Key Request (0x17) plen 6
   0000: 2e 01 06 2e 0b 00                                 ......
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
   0000: 2e 01 06 2e 0b 00 e3 29  89 d3 51 2c 66 c5 d2 16  .......)..Q,f...
   0010: 20 fa 9e 46 f3 73                                  ..F.s
 > HCI Event: Command Complete (0x0e) plen 10
   0000: 01 0b 04 00 2e 01 06 2e  0b 00                    ..........
 > HCI Event: Connect Complete (0x03) plen 11
   0000: 00 29 00 2e 01 06 2e 0b  00 01 00                 .).........
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
   0000: 29 00 0f 00                                       )...
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
 > HCI Event: Command Complete (0x0e) plen 6
   0000: 01 0d 08 00 29 00                                 ....).
 > HCI Event: Max Slots Change (0x1b) plen 3
   0000: 29 00 05                                          )..
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
     MTU 48
< ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 24
     L2CAP(d): cid 0x0040 len 20 [psm 1]
         SDP SSA Req: tid 0x0 len 0xf
           pat uuid-16 0x1108 (Headset)
           max 0xffff
           aid(s) 0x0000 - 0xffff
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 27
 > ACL data: handle 0x0029 flags 0x01 dlen 24
     L2CAP(d): cid 0x0040 len 47 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x2a
           cnt 0x26
           srv rec #0
             aid 0x0000 (SrvRecHndl)
                uint 0x20000
             aid 0x0001 (SrvClassIDList)
                < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
             aid 0x0004 (ProtocolDescList)
                < < uuid-16 0x0100 (L2CAP) > <
                uuid-16 0x0003 (RFCOMM) null null > >

           cont
< ACL data: handle 0x0029 flags 0x02 dlen 25
     L2CAP(d): cid 0x0040 len 21 [psm 1]
         SDP SSA Req: tid 0x1 len 0x10
           pat uuid-16 0x1108 (Headset)
           max 0xffff
           aid(s) 0x0000 - 0xffff
           cont 01 01
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 27
 > ACL data: handle 0x0029 flags 0x01 dlen 22
     L2CAP(d): cid 0x0040 len 45 [psm 1]
         SDP SSA Rsp: tid 0x1 len 0x28
           cnt 0x24

ERROR: Unexpected syntax
           0000: 06 09 00 05 35 03 19 10  02 09 00 06 35 09 09 65 
....5.......5..e
           0010: 6e 09 00 6a 09 01 00 09  01 00 25 07 48 65 61 64 
n..j......%.Head
           0020: 73 65 74 01 02                                    set..
           cont 06 09 00 05 35 03 19 10 02 09 00 06 35 09 09 65 6E 09 00 
6A 09 01 00 09 01 00 25 0748 65 61 64 73 65 74 01 02
< ACL data: handle 0x0029 flags 0x02 dlen 25
     L2CAP(d): cid 0x0040 len 21 [psm 1]
         SDP SSA Req: tid 0x2 len 0x10
           pat uuid-16 0x1108 (Headset)
           max 0xffff
           aid(s) 0x0000 - 0xffff
           cont 01 02
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 17
     L2CAP(d): cid 0x0040 len 13 [psm 1]
         SDP SSA Rsp: tid 0x2 len 0x8
           cnt 0x5

ERROR: Unexpected syntax
           0000: 03 02 28 01 00                                    ..(..
           cont 03 02 28 01 00
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > HCI Event: Command Complete (0x0e) plen 6
   0000: 01 25 0c 00 60 00                                 .%..`.
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0041
 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
     MTU 1024
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 4
     MTU 1024
 > ACL data: handle 0x0029 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
     MTU 317
< ACL data: handle 0x0029 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 0x0029 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 12 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 312 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 18
     L2CAP(d): cid 0x0041 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 12 frame_type 0 credit_flow 14 pri 1 ack_timer 0
       frame_size 312 max_retrans 0 credits 7
< ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 12 pf 1 ilen 0 fcs 0x43
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 8
     L2CAP(d): cid 0x0041 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 12 pf 1 ilen 0 fcs 0x88
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(d): cid 0x0041 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(d): cid 0x0041 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 12 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 12 pf 1 ilen 0 fcs 0x53 credits 33
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
< ACL data: handle 0x0029 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
   0000: 01 29 00 01 00                                    .)...
< HCI Command: Disconnect (0x01|0x0006) plen 3
   0000: 29 00 13                                          )..
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 01 06 04                                       ....
 > HCI Event: Disconn Complete (0x05) plen 4
   0000: 00 29 00 16                                       .)..
< HCI Command: Read Local Name (0x03|0x0014) plen 0
 > HCI Event: Command Complete (0x0e) plen 252
   0000: 01 14 0c 00 6e 6f 6d 61  64 65 2d 30 00 00 00 00  ....nomade-0....
   0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00f0: 00 00 00 00 00 00 00 00  00 00 00 00              ............
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
 > HCI Event: Command Complete (0x0e) plen 7
   0000: 01 23 0c 00 00 01 00                              .#.....
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
   0000: 01 01 10 00 01 0d 02 01  0a 00 0d 02              ............
< HCI Command: Read Local Name (0x03|0x0014) plen 0
 > HCI Event: Command Complete (0x0e) plen 252
   0000: 01 14 0c 00 6e 6f 6d 61  64 65 2d 30 00 00 00 00  ....nomade-0....
   0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00f0: 00 00 00 00 00 00 00 00  00 00 00 00              ............
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
 > HCI Event: Command Complete (0x0e) plen 7
   0000: 01 23 0c 00 00 01 00                              .#.....
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
 > HCI Event: Command Complete (0x0e) plen 12
   0000: 01 01 10 00 01 0d 02 01  0a 00 0d 02              ............
< HCI Command: Create Connection (0x01|0x0005) plen 13
   0000: 2e 01 06 2e 0b 00 18 cc  02 00 00 00 01           .............
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 01 05 04                                       ....
 > HCI Event: Link Key Request (0x17) plen 6
   0000: 2e 01 06 2e 0b 00                                 ......
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
   0000: 2e 01 06 2e 0b 00 e3 29  89 d3 51 2c 66 c5 d2 16  .......)..Q,f...
   0010: 20 fa 9e 46 f3 73                                  ..F.s
 > HCI Event: Command Complete (0x0e) plen 10
   0000: 01 0b 04 00 2e 01 06 2e  0b 00                    ..........
 > HCI Event: Connect Complete (0x03) plen 11
   0000: 00 29 00 2e 01 06 2e 0b  00 01 00                 .).........
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
   0000: 29 00 0f 00                                       )...
 > HCI Event: Command Complete (0x0e) plen 6
   0000: 01 0d 08 00 29 00                                 ....).
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
   0000: 2e 01 06 2e 0b 00 02 00  00 00                    ..........
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 01 19 04                                       ....
 > HCI Event: Max Slots Change (0x1b) plen 3
   0000: 29 00 05                                          )..
 > HCI Event: Remote Name Req Complete (0x07) plen 255
   0000: 00 2e 01 06 2e 0b 00 42  54 31 30 30 30 00 00 00  .......BT1000...
   0010: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
   00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2
   0000: 29 00                                             ).
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 01 1d 04                                       ....
 > HCI Event: Read Remote Ver Info Complete (0x0c) plen 8
   0000: 00 29 00 01 18 00 05 04                           .)......
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
   0000: 29 00                                             ).
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 01 1b 04                                       ....
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
   0000: 00 29 00 ff f9 31 00 00  00 00 00                 .)...1.....
< HCI Command: Disconnect (0x01|0x0006) plen 3
   0000: 29 00 13                                          )..
 > HCI Event: Command Status (0x0f) plen 4
   0000: 00 01 06 04                                       ....
 > HCI Event: Disconn Complete (0x05) plen 4
   0000: 00 29 00 16                                       .)..

and nothing more. Pairing was done.

Thanks for your help.

-- 
Daniel


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
