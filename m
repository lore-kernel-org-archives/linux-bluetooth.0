Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43A74833.90804@david-geiger.de>
From: David Geiger <info@david-geiger.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/alternative;
 boundary="------------040700030206000906030006"
Subject: [Bluez-users] No sound with SonyEricsson HBH-PV700
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
Date: Tue, 20 Dec 2005 00:54:27 +0100

This is a multi-part message in MIME format.
--------------040700030206000906030006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody!

Just had my first look at btsco. I compiled the sources from CVS and 
everything seems to be fine as I get a connection with the headset and 
e.g. an event is submitted when I press the dial button.
Anyway, when I try sending a sound either directly to /dev/dsp1 or using 
aplay, a connection is obviously established but the only thing I hear 
is constant noise as long as the connection lasts.

As I've got no idea whether it simply doesn't work with the headset or 
there is another problem I try to post all possible information and 
maybe someone can help. Hope it's not an information overflow. ;)


    * Whether there is a hub between your computer and bluetooth adapter 
(you should avoid this especially if it's a usb 2.0 hub)
It doesn't work either with or withour a hub.


    * Manufacturer and model of headset and bluetooth adapter
SonyEricsson HBH-PV700 and Bluetooth USB Dongle BLUE Buffalo, Model: BB1005


    * Output from hciconfig -a
hci0:   Type: USB
        BD Address: 00:0B:0D:32:5B:1A ACL MTU: 120:20 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:2496 acl:57 sco:0 events:109 errors:0
        TX bytes:1211 acl:34 sco:0 commands:59 errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ blizzmo (0)'
        Class: 0x10010c
        Service Classes:
        Device Class: Computer, Laptop
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)


    * Output from hciconfig hci0 revision (Run hciconfig as root)
hci0:   Type: USB
        BD Address: 00:0B:0D:32:5B:1A ACL MTU: 120:20 SCO MTU: 64:0
        Unsupported manufacturer

          o If it prints "SCO mapping: HCI" then your adapter should work.
          o If it prints "SCO mapping: PCM" then you might permanently 
change the setting using a command like "pskey mapsco 0" using 
bluez-utils-cvs but this is at your own risk.
          o If it doesn't print either of those, you probably need a 
different bluetooth adapter (preferably "CSR" based)
Seems like it doesn't print either of those...? What exactly is the SCO 
mapping and do I really need another bluetooth adapter?


    * Output from hcitool info bdaddr where bdaddr is the headset's address
Requesting information ...
        BD Address:  00:12:EE:17:DA:35
        Device Name: HBH-PV700
        LMP Version: 1.1 (0x1) LMP Subversion: 0x9240
        Manufacturer: Philips Semiconductors (37)
        Features: 0xbc 0x28 0x01 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <sniff mode> <SCO link> <HV3 packets> <CVSD>


    * The output btsco -v or a2play prints to the screen
# btsco 00:12:EE:17:DA:35 -v -r
btsco v0.4c
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
recieved AT*ECBP=?
recieved AT+CLIP=1
recieved AT+CSCS="UTF-8"
recieved AT+CLAN?

--> aplay -B 1000000 -D plughw:Headset ~/Sounds/newmail.wav

speaker volume: 15 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
speaker volume: 15 mic volume: 1
driver is not in use
disconnected SCO channel
recieved AT+VGS=15
Sending up speaker change 15


# mpg123 --au - ~/Sounds/newmail.mp3 | ./a2play 00:12:EE:17:DA:35
subbands = 8 blocks = 16 bitpool = 32
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!

Directory: /home/david/Sounds/
Playing MPEG stream from newmail.mp3 ...
MPEG 1.0 layer III, 320 kbit/s, 44100 Hz stereo

len=2048
Header size=28
Sample Rate:44100
Channels:2
Using address: 00:12:EE:17:DA:35

Found A2DP Sink at the destination
Can't connect to 35:DA:17:EE:12:00. Connection refused(111)
cannot open psm_cmd = 25


    * Output from hcidump -X while running btsco or a2play if appropriate
during btsco -v:
# hcidump -X
hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.24
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 35 da 17 ee 12 00 18 cc  02 00 00 00 01           5............
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
 > HCI Event: Link Key Request (0x17) plen 6
  0000: 35 da 17 ee 12 00                                 5.....
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 35 da 17 ee 12 00 d1 af  4a 72 b8 ac a0 e8 61 4f  5.......Jr....aO
  0010: 8b 38 70 36 72 38                                 .8p6r8
 > HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 35 da 17 ee  12 00                    ....5.....
 > HCI Event: Connect Complete (0x03) plen 11
  0000: 00 03 00 35 da 17 ee 12  00 01 00                 ...5.......
< ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 03 00 0f 00                                       ....
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 03 00 18 cc                                    .....
 > HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 03 00                                 ......
 > ACL data: handle 3 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0053 scid 0x0040 result 0 status 0
      Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
< ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0053 flags 0x00 clen 0
 > ACL data: handle 3 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 454
< ACL data: handle 3 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0053 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 454
< ACL data: handle 3 flags 0x02 dlen 24
    L2CAP(d): cid 0x0053 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 4
    L2CAP(d): cid 0x0040 len 102 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x61
          count 94
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "SonyEricsson Headset Service"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0053 scid 0x0040
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
  0000: 01 25 0c 00 60 00                                 .%..`.
< ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
 > ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0053 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0054 scid 0x0041 result 0 status 0
      Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
< ACL data: handle 3 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0054 flags 0x00 clen 4
      MTU 1024
 > ACL data: handle 3 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 454
< ACL data: handle 3 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0054 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 454
< ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x0054 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
< ACL data: handle 3 flags 0x02 dlen 18
    L2CAP(d): cid 0x0054 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 449 max_retrans 0 credits 7
 > ACL data: handle 3 flags 0x02 dlen 17
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x01 dlen 2
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 449 max_retrans 0 credits 0
< ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x0054 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(d): cid 0x0054 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
 > ACL data: handle 3 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 7
< ACL data: handle 3 flags 0x02 dlen 12
    L2CAP(d): cid 0x0054 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 7
< ACL data: handle 3 flags 0x02 dlen 9
    L2CAP(d): cid 0x0054 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 2
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40
      0000: 41 54 2a 45 43 42 50 3d  3f 0d                    AT*ECBP=?.
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2
< ACL data: handle 3 flags 0x02 dlen 14
    L2CAP(d): cid 0x0054 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 2
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40
      0000: 41 54 2b 43 4c 49 50 3d  31 0d                    AT+CLIP=1.
< ACL data: handle 3 flags 0x02 dlen 14
    L2CAP(d): cid 0x0054 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2
 > ACL data: handle 3 flags 0x02 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 8
    L2CAP(d): cid 0x0041 len 21 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 16 fcs 0x40
      0000: 41 54 2b 43 53 43 53 3d  22 55 54 46 2d 38 22 0d  
AT+CSCS="UTF-8".
< ACL data: handle 3 flags 0x02 dlen 14
    L2CAP(d): cid 0x0054 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 17
 > ACL data: handle 3 flags 0x01 dlen 1
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40
      0000: 41 54 2b 43 4c 41 4e 3f  0d                       AT+CLAN?.
< ACL data: handle 3 flags 0x02 dlen 14
    L2CAP(d): cid 0x0054 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 03 00 01 00                                    .....
 > ACL data: handle 3 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2
 > HCI Event: Mode Change (0x14) plen 6
  0000: 00 03 00 02 00 08                                 ......
< HCI Command: Inquiry (0x01|0x0001) plen 5
  0000: 33 8b 9e 06 00                                    3....
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 01 04                                       ....
 > HCI Event: Inquiry Complete (0x01) plen 1
  0000: 00

--> aplay -B 1000000 -D plughw:Headset ~/Sounds/newmail.wav

 > HCI Event: Mode Change (0x14) plen 6
  0000: 00 01 00 02 00 08                                 ......
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0058 len 14 [psm 0]
      0000: 0b ef 15 41 54 2b 56 47  53 3d 31 35 0d 9a        ...AT+VGS=15..
< ACL data: handle 1 flags 0x02 dlen 17
    L2CAP(d): cid 0x0058 len 13 [psm 0]
      0000: 0b ef 13 41 54 2b 56 47  4d 3d 31 0d 9a           ...AT+VGM=1..
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
  0000: 01 00 e0 00                                       ....
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                       ....
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
 > ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 0]
      0000: 09 ff 00 00 02 5c                                 .....\
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
 > HCI Event: Connect Complete (0x03) plen 11
  0000: 00 00 01 35 da 17 ee 12  00 00 00                 ...5.......
 > SCO data: handle 256 dlen 48
    0000: ff ff fd ff fa ff fb ff  fd ff fc ff fc ff fc ff  ................
    0010: fd ff fc ff fd ff fe ff  fe ff fe ff fd ff fd ff  ................
    0020: fe ff fd ff fe ff fe ff  fd ff fe ff fd ff fe ff  ................
[...]
 > HCI Event: Mode Change (0x14) plen 6
  0000: 00 01 00 00 00 00                                 ......
 > ACL data: handle 1 flags 0x02 dlen 17
 > ACL data: handle 1 flags 0x01 dlen 2
    L2CAP(d): cid 0x0041 len 15 [psm 0]
      0000: 09 ef 14 00 41 54 2b 56  47 53 3d 31 35 0d 40     
....AT+VGS=15.@
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(d): cid 0x0058 len 10 [psm 0]
      0000: 0b ef 0d 0d 0a 4f 4b 0d  0a 9a                    .....OK...
 > SCO data: handle 256 dlen 48
    0000: fd ff fd ff fd ff fd ff  fd ff fd ff fd ff fd ff  ................
    0010: fd ff fd ff fd ff fd ff  fd ff fd ff fd ff fd ff  ................
    0020: fd ff fd ff fd ff fd ff  fd ff fd ff fd ff fd ff  ................
 > SCO data: handle 256 dlen 48
    0000: fd ff fd ff fd ff fd ff  fd ff fd ff fd ff fd ff  ................
    0010: fd ff fd ff fd ff fd ff  fd ff fd ff fd ff fd ff  ................
    0020: fd ff fd ff fd ff fd ff  fd ff fd ff fd ff fd ff  ................
 > SCO data: handle 256 dlen 48
    0000: fd ff fd ff fd ff fd ff  fd ff fd ff fe ff 03 00  ................
    0010: 10 00 0a 00 fa ff 0e 00  0e 00 00 00 14 00 0d 00  ................
    0020: 08 00 12 00 0d 00 06 00  fc ff 07 00 07 00 05 00  ................
 > HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 00 01 16                                       ....
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
 > HCI Event: Mode Change (0x14) plen 6
  0000: 00 01 00 02 00 08                                 ......


during a2play:
# hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.24
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 35 da 17 ee 12 00 18 cc  02 00 00 00 01           5............
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
 > HCI Event: Link Key Request (0x17) plen 6
  0000: 35 da 17 ee 12 00                                 5.....
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 35 da 17 ee 12 00 d1 af  4a 72 b8 ac a0 e8 61 4f  5.......Jr....aO
  0010: 8b 38 70 36 72 38                                 .8p6r8
 > HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 35 da 17 ee  12 00                    ....5.....
 > HCI Event: Connect Complete (0x03) plen 11
  0000: 00 01 00 35 da 17 ee 12  00 01 00                 ...5.......
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 01 00 0f 00                                       ....
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 01 00 18 cc                                    .....
 > HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 01 00                                 ......
 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0040 result 0 status 0
      Connection successful
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0050 flags 0x00 clen 0
 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 454
< ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0050 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
 > ACL data: handle 1 flags 0x02 dlen 17
 > ACL data: handle 1 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 454
< ACL data: handle 1 flags 0x02 dlen 24
    L2CAP(d): cid 0x0050 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x110d (AdvAudio)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
 > ACL data: handle 1 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x6
          count 3
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
< ACL data: handle 1 flags 0x02 dlen 24
    L2CAP(d): cid 0x0050 len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > ACL data: handle 1 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x6
          count 3
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0050 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0041
 > ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0050 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 2 status 0
      Connection refused - PSM not supported
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 01 00 01 00                                    .....
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 01 00 13                                          ...
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
 > HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 01 00 16                                       ....


    * Your kernel version and bluez userland versions or distro
2.6.13-15.7-default (SUSE 10.0)
bluez-libs version 2.19-2


    * If you have a headset that can do a2dp, try both btsco and a2play 
(the significance is that the latter does not use SCO)
a2dp doesn't seem to work at all - don't know if my headset isn't able 
to do it.


Best regards, David
-- 
David Geiger
info@david-geiger.de <mailto:info@david-geiger.de>

--------------040700030206000906030006
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1">Hi everybody!<br>
<br>
Just had my first look at btsco. I compiled the sources from CVS and
everything seems to be fine as I get a connection with the headset and
e.g. an event is submitted when I press the dial button.<br>
Anyway, when I try sending a sound either directly to /dev/dsp1 or
using aplay, a connection is obviously established but the only thing I
hear is constant noise as long as the connection lasts.<br>
<br>
As I've got no idea whether it simply doesn't work with the headset or
there is another problem I try to post all possible information and
maybe someone can help. Hope it's not an information overflow. ;)<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; * Whether there is a hub between your computer and bluetooth
adapter (you should avoid this especially if it's a usb 2.0 hub)<br>
It doesn't work either with or withour a hub.<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; * Manufacturer and model of headset and bluetooth adapter<br>
SonyEricsson HBH-PV700 and Bluetooth USB Dongle BLUE Buffalo, Model:
BB1005<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; * Output from hciconfig -a<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0B:0D:32:5B:1A ACL MTU: 120:20 SCO MTU: 64:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:2496 acl:57 sco:0 events:109 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:1211 acl:34 sco:0 commands:59 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ blizzmo (0)'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x10010c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Laptop<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver:
0x757<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Silicon Wave (11)<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; * Output from hciconfig hci0 revision (Run hciconfig as root)<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0B:0D:32:5B:1A ACL MTU: 120:20 SCO MTU: 64:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Unsupported manufacturer<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o If it prints "SCO mapping: HCI" then your adapter should
work.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o If it prints "SCO mapping: PCM" then you might permanently
change the setting using a command like "pskey mapsco 0" using
bluez-utils-cvs but this is at your own risk.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; o If it doesn't print either of those, you probably need a
different bluetooth adapter (preferably "CSR" based)<br>
Seems like it doesn't print either of those...? What exactly is the SCO
mapping and do I really need another bluetooth adapter?<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; * Output from hcitool info bdaddr where bdaddr is the headset's
address<br>
Requesting information ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:12:EE:17:DA:35<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: HBH-PV700<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.1 (0x1) LMP Subversion: 0x9240<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Philips Semiconductors (37)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xbc 0x28 0x01 0x00 0x00 0x00 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;encryption&gt; &lt;slot offset&gt; &lt;timing
accuracy&gt; &lt;role switch&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;sniff mode&gt; &lt;SCO link&gt; &lt;HV3 packets&gt;
&lt;CVSD&gt;<br>
<br>
</font><font size="-1"><br>
&nbsp;&nbsp;&nbsp; * The output btsco -v or a2play prints to the screen<br>
# btsco 00:12:EE:17:DA:35 -v -r<br>
btsco v0.4c<br>
Device is 1:0<br>
Voice setting: 0x0060<br>
RFCOMM channel 1 connected<br>
recieved AT*ECBP=?<br>
recieved AT+CLIP=1<br>
recieved AT+CSCS="UTF-8"<br>
recieved AT+CLAN?<br>
<br>
--&gt; aplay -B 1000000 -D plughw:Headset ~/Sounds/newmail.wav<br>
<br>
speaker volume: 15 mic volume: 1<br>
i/o needed: connecting sco...<br>
connected SCO channel<br>
Done setting sco fd<br>
speaker volume: 15 mic volume: 1<br>
driver is not in use<br>
disconnected SCO channel<br>
recieved AT+VGS=15<br>
Sending up speaker change 15<br>
<br>
<br>
</font><font size="-1"># mpg123 --au - ~/Sounds/newmail.mp3 | ./a2play
00:12:EE:17:DA:35<br>
subbands = 8 blocks = 16 bitpool = 32<br>
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.<br>
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.<br>
Uses code from various people. See 'README' for more!<br>
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!<br>
<br>
Directory: /home/david/Sounds/<br>
Playing MPEG stream from newmail.mp3 ...<br>
MPEG 1.0 layer III, 320 kbit/s, 44100 Hz stereo<br>
<br>
len=2048<br>
Header size=28<br>
Sample Rate:44100<br>
Channels:2<br>
Using address: 00:12:EE:17:DA:35<br>
<br>
Found A2DP Sink at the destination<br>
Can't connect to 35:DA:17:EE:12:00. Connection refused(111)<br>
cannot open psm_cmd = 25<br>
</font><font size="-1"><br>
<br>
&nbsp;&nbsp;&nbsp; * Output from hcidump -X while running btsco or a2play if
appropriate<br>
during btsco -v:<br>
# hcidump -X<br>
hcidump -X<br>
HCI sniffer - Bluetooth packet analyzer ver 1.24<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>
&nbsp; 0000: 35 da 17 ee 12 00 18 cc&nbsp; 02 00 00 00 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5............<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 05 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
&gt; HCI Event: Link Key Request (0x17) plen 6<br>
&nbsp; 0000: 35 da 17 ee 12 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.....<br>
&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22<br>
&nbsp; 0000: 35 da 17 ee 12 00 d1 af&nbsp; 4a 72 b8 ac a0 e8 61 4f&nbsp;
5.......Jr....aO<br>
&nbsp; 0010: 8b 38 70 36 72 38&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .8p6r8<br>
&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp; 0000: 01 0b 04 00 35 da 17 ee&nbsp; 12 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....5.....<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp; 0000: 00 03 00 35 da 17 ee 12&nbsp; 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...5.......<br>
&lt; ACL data: handle 3 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>
&nbsp; 0000: 03 00 0f 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>
&nbsp; 0000: 00 03 00 18 cc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&nbsp; 0000: 01 0d 08 00 03 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>
&gt; ACL data: handle 3 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0053 scid 0x0040 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&lt; ACL data: handle 3 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0053 flags 0x00 clen 0<br>
&gt; ACL data: handle 3 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 454<br>
&lt; ACL data: handle 3 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0053 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 1<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 454<br>
&lt; ACL data: handle 3 flags 0x02 dlen 24<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0053 len 20 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x0 len 0xf<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x1108 (Headset)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 4<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 102 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x0 len 0x61<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 94<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x10002<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio)
&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) &gt; &lt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0003 (RFCOMM) uint 0x1 &gt; &gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x1108 (Headset) uint 0x100 &gt; &gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str "SonyEricsson Headset Service"<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0302 (unknown)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool 0x1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>
&lt; ACL data: handle 3 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0053 scid 0x0040<br>
&lt; HCI Command: Read Voice Setting (0x03|0x0025) plen 0<br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&nbsp; 0000: 01 25 0c 00 60 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .%..`.<br>
&lt; ACL data: handle 3 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 0x0041<br>
&gt; ACL data: handle 3 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0053 scid 0x0040<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0054 scid 0x0041 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&lt; ACL data: handle 3 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0054 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 1024<br>
&gt; ACL data: handle 3 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 454<br>
&lt; ACL data: handle 3 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0054 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 1<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 454<br>
&lt; ACL data: handle 3 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0054 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&lt; ACL data: handle 3 flags 0x02 dlen 18<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0054 len 14 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 449 max_retrans 0 credits 7<br>
&gt; ACL data: handle 3 flags 0x02 dlen 17<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x01 dlen 2<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 15 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_size 449 max_retrans 0 credits 0<br>
&lt; ACL data: handle 3 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0054 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92<br>
&lt; ACL data: handle 3 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0054 len 8 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0<br>
&gt; ACL data: handle 3 flags 0x02 dlen 13<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 9 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 7<br>
&lt; ACL data: handle 3 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0054 len 8 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 13<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 9 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 7<br>
&lt; ACL data: handle 3 flags 0x02 dlen 9<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0054 len 5 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 2<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 15 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 41 54 2a 45 43 42 50 3d&nbsp; 3f 0d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AT*ECBP=?.<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 10<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2<br>
&lt; ACL data: handle 3 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0054 len 10 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 0d 0a 4f 4b 0d 0a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ..OK..<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 2<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 15 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 41 54 2b 43 4c 49 50 3d&nbsp; 31 0d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AT+CLIP=1.<br>
&lt; ACL data: handle 3 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0054 len 10 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 0d 0a 4f 4b 0d 0a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ..OK..<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 10<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2<br>
&gt; ACL data: handle 3 flags 0x02 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 21 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 16 fcs 0x40<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 41 54 2b 43 53 43 53 3d&nbsp; 22 55 54 46 2d 38 22 0d&nbsp;
AT+CSCS="UTF-8".<br>
&lt; ACL data: handle 3 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0054 len 10 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 0d 0a 4f 4b 0d 0a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ..OK..<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 17<br>
&gt; ACL data: handle 3 flags 0x01 dlen 1<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 14 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 9 fcs 0x40<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 41 54 2b 43 4c 41 4e 3f&nbsp; 0d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AT+CLAN?.<br>
&lt; ACL data: handle 3 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0054 len 10 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 0d 0a 4f 4b 0d 0a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ..OK..<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 03 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 3 flags 0x02 dlen 10<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 2<br>
&gt; HCI Event: Mode Change (0x14) plen 6<br>
&nbsp; 0000: 00 03 00 02 00 08&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>
&lt; HCI Command: Inquiry (0x01|0x0001) plen 5<br>
&nbsp; 0000: 33 8b 9e 06 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3....<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 01 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
&gt; HCI Event: Inquiry Complete (0x01) plen 1<br>
&nbsp; 0000: 00<br>
<br>
--&gt; aplay -B 1000000 -D plughw:Headset ~/Sounds/newmail.wav<br>
<br>
&gt; HCI Event: Mode Change (0x14) plen 6<br>
&nbsp; 0000: 00 01 00 02 00 08&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>
&lt; ACL data: handle 1 flags 0x02 dlen 18<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0058 len 14 [psm 0]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 0b ef 15 41 54 2b 56 47&nbsp; 53 3d 31 35 0d 9a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
...AT+VGS=15..<br>
&lt; ACL data: handle 1 flags 0x02 dlen 17<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0058 len 13 [psm 0]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 0b ef 13 41 54 2b 56 47&nbsp; 4d 3d 31 0d 9a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
...AT+VGM=1..<br>
&lt; HCI Command: Add SCO Connection (0x01|0x0007) plen 4<br>
&nbsp; 0000: 01 00 e0 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 07 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 1 flags 0x02 dlen 10<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 6 [psm 0]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 09 ff 00 00 02 5c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....\<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp; 0000: 00 00 01 35 da 17 ee 12&nbsp; 00 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...5.......<br>
&gt; SCO data: handle 256 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: ff ff fd ff fa ff fb ff&nbsp; fd ff fc ff fc ff fc ff&nbsp;
................<br>
&nbsp;&nbsp;&nbsp; 0010: fd ff fc ff fd ff fe ff&nbsp; fe ff fe ff fd ff fd ff&nbsp;
................<br>
&nbsp;&nbsp;&nbsp; 0020: fe ff fd ff fe ff fe ff&nbsp; fd ff fe ff fd ff fe ff&nbsp;
................<br>
[...]<br>
&gt; HCI Event: Mode Change (0x14) plen 6<br>
&nbsp; 0000: 00 01 00 00 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>
&gt; ACL data: handle 1 flags 0x02 dlen 17<br>
&gt; ACL data: handle 1 flags 0x01 dlen 2<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 15 [psm 0]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 09 ef 14 00 41 54 2b 56&nbsp; 47 53 3d 31 35 0d 40&nbsp;&nbsp;&nbsp;&nbsp;
....AT+VGS=15.@<br>
&lt; ACL data: handle 1 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0058 len 10 [psm 0]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 0b ef 0d 0d 0a 4f 4b 0d&nbsp; 0a 9a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....OK...<br>
&gt; SCO data: handle 256 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: fd ff fd ff fd ff fd ff&nbsp; fd ff fd ff fd ff fd ff&nbsp;
................<br>
&nbsp;&nbsp;&nbsp; 0010: fd ff fd ff fd ff fd ff&nbsp; fd ff fd ff fd ff fd ff&nbsp;
................<br>
&nbsp;&nbsp;&nbsp; 0020: fd ff fd ff fd ff fd ff&nbsp; fd ff fd ff fd ff fd ff&nbsp;
................<br>
&gt; SCO data: handle 256 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: fd ff fd ff fd ff fd ff&nbsp; fd ff fd ff fd ff fd ff&nbsp;
................<br>
&nbsp;&nbsp;&nbsp; 0010: fd ff fd ff fd ff fd ff&nbsp; fd ff fd ff fd ff fd ff&nbsp;
................<br>
&nbsp;&nbsp;&nbsp; 0020: fd ff fd ff fd ff fd ff&nbsp; fd ff fd ff fd ff fd ff&nbsp;
................<br>
&gt; SCO data: handle 256 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: fd ff fd ff fd ff fd ff&nbsp; fd ff fd ff fe ff 03 00&nbsp;
................<br>
&nbsp;&nbsp;&nbsp; 0010: 10 00 0a 00 fa ff 0e 00&nbsp; 0e 00 00 00 14 00 0d 00&nbsp;
................<br>
&nbsp;&nbsp;&nbsp; 0020: 08 00 12 00 0d 00 06 00&nbsp; fc ff 07 00 07 00 05 00&nbsp;
................<br>
&gt; HCI Event: Disconn Complete (0x05) plen 4<br>
&nbsp; 0000: 00 00 01 16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; HCI Event: Mode Change (0x14) plen 6<br>
&nbsp; 0000: 00 01 00 02 00 08&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>
<br>
<br>
during a2play:<br>
# hcidump -X<br>
HCI sniffer - Bluetooth packet analyzer ver 1.24<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>
&nbsp; 0000: 35 da 17 ee 12 00 18 cc&nbsp; 02 00 00 00 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5............<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 05 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
&gt; HCI Event: Link Key Request (0x17) plen 6<br>
&nbsp; 0000: 35 da 17 ee 12 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5.....<br>
&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22<br>
&nbsp; 0000: 35 da 17 ee 12 00 d1 af&nbsp; 4a 72 b8 ac a0 e8 61 4f&nbsp;
5.......Jr....aO<br>
&nbsp; 0010: 8b 38 70 36 72 38&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .8p6r8<br>
&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp; 0000: 01 0b 04 00 35 da 17 ee&nbsp; 12 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....5.....<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp; 0000: 00 01 00 35 da 17 ee 12&nbsp; 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...5.......<br>
&lt; ACL data: handle 1 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>
&nbsp; 0000: 01 00 0f 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>
&nbsp; 0000: 00 01 00 18 cc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&nbsp; 0000: 01 0d 08 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>
&gt; ACL data: handle 1 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0040 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&lt; ACL data: handle 1 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0050 flags 0x00 clen 0<br>
&gt; ACL data: handle 1 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 454<br>
&lt; ACL data: handle 1 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0050 flags 0x00 result 0 clen 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 1 flags 0x02 dlen 17<br>
&gt; ACL data: handle 1 flags 0x01 dlen 1<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 454<br>
&lt; ACL data: handle 1 flags 0x02 dlen 24<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0050 len 20 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x0 len 0xf<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x110d (AdvAudio)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 1 flags 0x02 dlen 15<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 11 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x0 len 0x6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&lt; ACL data: handle 1 flags 0x02 dlen 24<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0050 len 20 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 len 0xf<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x1200 (PNPInfo)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>
&gt; ACL data: handle 1 flags 0x02 dlen 15<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 11 [psm 1]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 len 0x6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&lt; ACL data: handle 1 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0050 scid 0x0040<br>
&lt; ACL data: handle 1 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 25 scid 0x0041<br>
&gt; ACL data: handle 1 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0050 scid 0x0040<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 1 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 2 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection refused - PSM not supported<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&nbsp; 0000: 01 01 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&lt; HCI Command: Disconnect (0x01|0x0006) plen 3<br>
&nbsp; 0000: 01 00 13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 06 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
&gt; HCI Event: Disconn Complete (0x05) plen 4<br>
&nbsp; 0000: 00 01 00 16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
<br>
<br>
</font><font size="-1">&nbsp;&nbsp;&nbsp; * Your kernel version and bluez userland
versions or distro<br>
2.6.13-15.7-default (SUSE 10.0)<br>
bluez-libs version 2.19-2<br>
<br>
<br>
&nbsp;&nbsp;&nbsp; * If you have a headset that can do a2dp, try both btsco and a2play
(the significance is that the latter does not use SCO)<br>
a2dp doesn't seem to work at all - don't know if my headset isn't able
to do it.<br>
<br>
<br>
Best regards, David<br>
</font>
<div class="moz-signature">-- <br>
<font size="-1">David Geiger<br>
<a href="mailto:info@david-geiger.de">info@david-geiger.de</a><br>
</font>
</div>
</body>
</html>

--------------040700030206000906030006--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
