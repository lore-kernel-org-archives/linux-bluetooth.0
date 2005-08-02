Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <39673606050801205131f308d3@mail.gmail.com>
From: Robert Brewer <rwb123@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] btsco problems
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
Date: Mon, 1 Aug 2005 23:51:21 -0400

Hi all,

I'm a bluetooth newbie and trying to use my new headset
with Linux via bluez and btsco.  My end goal is to do speech control
and acknowledgement of my Linux desktop via the bluetooth headset.

So far I've gotten my bluetooth dongle recognized and paired enough
with my headset that I found its bluetooth address.  I compiled btsco
and its kernel module, and loaded them.  When I use aplay to play
a song to my headset, I hear a beep in the headset indicating a=20
connection is established.  But I don't hear any other sound.  I've
fiddled with the headset volume control and the alsamixer volume
controls with no luck. =20

My configuration:

Logitech mobile freedom bluetooth headset (class 2, bluetooth 1.2, csr chip=
set)
Zonet zub6101c usb dongle (class 1, bluetooth 1.2, broadcom chipset)
Debian unstable linux distro
kernel 2.6.11
bluez-utils 2.18
bluez-hcidump 1.23
btsco cvs 2005-08-01

Other details:

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:72:C4:25:E4 ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:8141 acl:182 sco:0 events:360 errors:0
        TX bytes:4713 acl:178 sco:0 commands:121 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'wiz-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0xc LMP Ver: 1.2 (0x2) LMP Subver: 0x30=
9
        Manufacturer: Broadcom Corporation (15)

# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:02:72:C4:25:E4 ACL MTU: 377:10 SCO MTU: 16:0
        Firmware 12.3 / 9

# hcitool info 00:0D:44:37:57:F2
Requesting information ...
        BD Address:  00:0D:44:37:57:F2
        Device Name: Logitech HS02-V07
        LMP Version: 1.2 (0x2) LMP Subversion: 0x611
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link=
>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
                <paging scheme> <power control> <transparent SCO>
                <AFH cap. slave> <AFH cap. master>

The next three outputs are for one attempt to play music to my headset.
After starting aplay and hearing a beep in the headset, I waited 30 seconds
and still heard nothing, so I pressed ctrl-c on aplay and then btsco to=20
shut everything down.

# hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: f2 57 37 44 0d 00 18 cc  02 00 00 00 01           .W7D.........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: f2 57 37 44 0d 00                                 .W7D..
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: f2 57 37 44 0d 00 21 75  1f 10 ed 96 c2 a1 42 d2  .W7D..!u......B.
  0010: 8c 14 2c 72 51 68                                 ..,rQh
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 f2 57 37 44  0d 00                    .....W7D..
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 06 00 f2 57 37 44 0d  00 01 01                 ....W7D....
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 06 00 0f 00                                       ....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 06 00                                 ......
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0049 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0049 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 24
    L2CAP(d): cid 0x0049 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 27
> ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          count 38
          cont 02 00 3A
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0049 len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 3A
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 27
> ACL data: handle 6 flags 0x01 dlen 25
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x2b
          count 38
          cont 02 00 14
< ACL data: handle 6 flags 0x02 dlen 26
    L2CAP(d): cid 0x0049 len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 14
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 27
> ACL data: handle 6 flags 0x01 dlen 5
    L2CAP(d): cid 0x0040 len 28 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x17
          count 20
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Logitech HS02-V07"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0049 scid 0x0040
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 25 0c 00 60 00                                 .%..`.
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0049 scid 0x0040
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004a scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004a scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x004a flags 0x00 clen 4
      MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1024
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004a flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x004a len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x004a len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x004a len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x004a len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x004a len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 9
    L2CAP(d): cid 0x004a len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> ACL data: handle 6 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x004a len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 10 fcs 0x9a
      0000: 41 54 2b 56 47 53 3d 31  33 0d                    AT+VGS=3D13.
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x004a len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 10 fcs 0x9a
      0000: 41 54 2b 56 47 4d 3d 31  34 0d                    AT+VGM=3D14.
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
  0000: 06 00 e0 00                                       ....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                       ....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 01 00 f2 57 37 44 0d  00 00 01                 ....W7D....
> ACL data: handle 6 flags 0x02 dlen 19
    L2CAP(d): cid 0x0041 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 2
      0000: 41 54 2b 56 47 53 3d 31  33 0d                    AT+VGS=3D13.
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(d): cid 0x004a len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 01 00 13                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 01 00 16                                       ....
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x004a len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 01 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x004a len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004a scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 06 00 02 00                                    .....
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004a scid 0x0041
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 06 00 13                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 06 00 16                                       ....

$ btsco -v 00:0D:44:37:57:F2
btsco v0.4c
Device is 2:0
Voice setting: 0x0060
RFCOMM channel 1 connected
speaker volume: 13 mic volume: 14
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=3D13
Sending up speaker change 13
speaker volume: 13 mic volume: 14
driver is not in use
disconnected SCO channel

$ aplay -D plughw:Headset -c1 music.MP3
Playing raw data 'music.MP3' : Unsigned 8 bit, Rate 8000 Hz, Mono
Aborted by signal Interrupt...

I'd appreciate any hints or other things to try to attempt to diagnose this=
.
Thanks very much!

-Rob
--=20
Robert W. Brewer


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
