Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: David Wuertele <dave-gnus@bfnet.com>
Message-ID: <m3hdj7w3za.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] troubleshooting jabra headset btsco connection
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
Date: 19 Mar 2005 16:33:29 -0800

I have a Jabra 250 headset and I would like to use this with my
Thinkpad X31 notebook, but btsco does not report a connection, and
sound does not play.  The notebook has built-in bluetooth.  Here are
my software versions:

  # rpm -qa | grep -i bluez
  bluez-libs-devel-2.10-2
  bluez-hcidump-1.11-1
  bluez-utils-2.10-2
  bluez-libs-2.10-2
  bluez-bluefw-1.0-6
  bluez-pin-0.23-3

Today (3/19/2005) I cleanly checked out the btsco package, configured,
built, and installed in the main directory.  Then I cd into the kernel
directory and typed 'make install' to get the snd_bt_sco.ko module.

  # lsmod | grep sco
  # modprobe snd_bt_sco
  # lsmod | grep sco
  snd_bt_sco             16416  0 
  snd_hwdep               8901  1 snd_bt_sco
  snd_pcm                93001  5 snd_bt_sco,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
  snd                    52645  11 snd_bt_sco,snd_hwdep,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
  snd_page_alloc          9541  4 snd_bt_sco,snd_intel8x0m,snd_intel8x0,snd_pcm

  # hciconfig -a
  hci0:	Type: USB
          BD Address: 00:20:E0:75:D6:F6 ACL MTU: 192:8  SCO MTU: 64:8
          UP RUNNING PSCAN ISCAN 
          RX bytes:5610037 acl:288 sco:109741 events:572 errors:0
          TX bytes:5518964 acl:224 sco:108083 commands:189 errors:0
          Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
          Link policy: RSWITCH HOLD SNIFF PARK 
          Link mode: SLAVE ACCEPT 
          Name: 'localhost.localdomain-0'
          Class: 0x120104
          Service Classes: Networking, Object Transfer
          Device Class: Computer, Desktop workstation
          HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver: 0x222
          Manufacturer: Cambridge Silicon Radio (10)

I have paired my device and I can ping it with l2ping:

  # l2ping 00:07:A4:06:40:99
  Ping: 00:07:A4:06:40:99 from 00:20:E0:75:D6:F6 (data size 20) ...
  44 bytes from 00:07:A4:06:40:99 id 200 time 70.83ms
  44 bytes from 00:07:A4:06:40:99 id 201 time 35.24ms
  44 bytes from 00:07:A4:06:40:99 id 202 time 36.22ms
  44 bytes from 00:07:A4:06:40:99 id 203 time 46.33ms
  4 sent, 4 received, 0% loss

Searching confirms that that address is my headset:

  # sdptool search --bdaddr 00:07:A4:06:40:99 0x1108
  Class 0x1108
  Searching for 0x1108 on 00:07:A4:06:40:99 ...
  Service Name: Headset
  Service RecHandle: 0x10000
  Service Class ID List:
    "Headset" (0x1108)
    "Generic Audio" (0x1203)
  Protocol Descriptor List:
    "L2CAP" (0x0100)
    "RFCOMM" (0x0003)
      Channel: 1
  Profile Descriptor List:
    "Headset" (0x1108)
      Version: 0x0100


My headset is now on (the blue light flashes once every three
seconds).  The first time I run btsco:

  # btsco 00:07:A4:06:40:99 1
  Can't connect RFCOMM channel: Device or resource busy

Here's the hcidump -X output during the above command:

  < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
  > HCI Event: Command Complete (0x0e) plen 6
    0000: 01 25 0c 00 60 00                                 .%..`.
  < HCI Command: Create Connection (0x01|0x0005) plen 13
    0000: 99 40 06 a4 07 00 18 cc 02 00 00 00 01            .@...........
  > HCI Event: Command Status (0x0f) plen 4
    0000: 0c 01 05 04                                       ....
  > HCI Event: Connect Complete (0x03) plen 11
    0000: 04 00 00 00 00 00 00 00 00 01 00                  ...........

The *second* time I run btsco, it doesn't print an error --- in fact
it doesn't print anything:

  # btsco 00:07:A4:06:40:99 1

Here is the hcidump -X output during the above command:

  < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
  > HCI Event: Command Complete (0x0e) plen 6
    0000: 01 25 0c 00 60 00                                 .%..`.
  < HCI Command: Create Connection (0x01|0x0005) plen 13
    0000: 99 40 06 a4 07 00 18 cc 02 00 00 00 01            .@...........
  > HCI Event: Command Status (0x0f) plen 4
    0000: 00 01 05 04                                       ....
  > HCI Event: Link Key Request (0x17) plen 6
    0000: 99 40 06 a4 07 00                                 .@....
  < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    0000: 99 40 06 a4 07 00 e0 b5 ad 2a 5e 49 b2 0d 44 b3   .@.......*^I..D.
    0010: 98 be 56 78 1c 3c                                 ..Vx.<
  > HCI Event: Command Complete (0x0e) plen 10
    0000: 01 0b 04 00 99 40 06 a4 07 00                     .....@....
  > HCI Event: Connect Complete (0x03) plen 11
    0000: 00 29 00 99 40 06 a4 07 00 01 01                  .)..@......
  < ACL data: handle 0x0029 flags 0x02 dlen 12
      L2CAP(s): Connect req: psm 3 scid 0x0040
  < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    0000: 29 00 0f 00                                       )...
  > HCI Event: Number of Completed Packets (0x13) plen 5
    0000: 01 29 00 01 00                                    .)...
  > HCI Event: Command Complete (0x0e) plen 6
    0000: 01 0d 08 00 29 00                                 ....).
  > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    0000: 99 40 06 a4 07 00 01                              .@.....
  > ACL data: handle 0x0029 flags 0x02 dlen 16
      L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 1 status 2
  > ACL data: handle 0x0029 flags 0x02 dlen 16
      L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 0 status 0
  < ACL data: handle 0x0029 flags 0x02 dlen 16
      L2CAP(s): Config req: dcid 0x0048 flags 0x0000 clen 4
      MTU 1024 
  > HCI Event: Number of Completed Packets (0x13) plen 5
    0000: 01 29 00 01 00                                    .)...
  > ACL data: handle 0x0029 flags 0x02 dlen 14
      L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
  > ACL data: handle 0x0029 flags 0x02 dlen 16
      L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
      MTU 1024 
  < ACL data: handle 0x0029 flags 0x02 dlen 14
      L2CAP(s): Config rsp: scid 0x0048 flags 0x0000 result 0 clen 0
  < ACL data: handle 0x0029 flags 0x02 dlen 8
      L2CAP(d): cid 0x0048 len 4 [psm 3]
        RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
  > HCI Event: Number of Completed Packets (0x13) plen 5
    0000: 01 29 00 01 00                                    .)...
  > HCI Event: Number of Completed Packets (0x13) plen 5
    0000: 01 29 00 01 00                                    .)...
  > ACL data: handle 0x0029 flags 0x02 dlen 8
      L2CAP(d): cid 0x0040 len 4 [psm 3]
        RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
  < ACL data: handle 0x0029 flags 0x02 dlen 18
      L2CAP(d): cid 0x0048 len 14 [psm 3]
        RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
        dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
        frame_size 1019 max_retrans 0 credits 7
  > HCI Event: Number of Completed Packets (0x13) plen 5
    0000: 01 29 00 01 00                                    .)...
  > ACL data: handle 0x0029 flags 0x02 dlen 18
      L2CAP(d): cid 0x0040 len 14 [psm 3]
        RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
        dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
        frame_size 127 max_retrans 0 credits 0
  < ACL data: handle 0x0029 flags 0x02 dlen 8
      L2CAP(d): cid 0x0048 len 4 [psm 3]
        RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
  > HCI Event: Number of Completed Packets (0x13) plen 5
    0000: 01 29 00 01 00                                    .)...
  > ACL data: handle 0x0029 flags 0x02 dlen 8
      L2CAP(d): cid 0x0040 len 4 [psm 3]
        RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
  < ACL data: handle 0x0029 flags 0x02 dlen 12
      L2CAP(d): cid 0x0048 len 8 [psm 3]
        RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
        dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
  > ACL data: handle 0x0029 flags 0x02 dlen 12
      L2CAP(d): cid 0x0040 len 8 [psm 3]
        RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
        dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
  < ACL data: handle 0x0029 flags 0x02 dlen 12
      L2CAP(d): cid 0x0048 len 8 [psm 3]
        RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
        dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
  > HCI Event: Number of Completed Packets (0x13) plen 5
    0000: 01 29 00 01 00                                    .)...
  > HCI Event: Number of Completed Packets (0x13) plen 5
    0000: 01 29 00 01 00                                    .)...
  > ACL data: handle 0x0029 flags 0x02 dlen 12
      L2CAP(d): cid 0x0040 len 8 [psm 3]
        RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
        dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
  < ACL data: handle 0x0029 flags 0x02 dlen 9
      L2CAP(d): cid 0x0048 len 5 [psm 3]
        RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
  > ACL data: handle 0x0029 flags 0x02 dlen 9
      L2CAP(d): cid 0x0040 len 5 [psm 3]
        RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15
  > HCI Event: Number of Completed Packets (0x13) plen 5
    0000: 01 29 00 01 00                                    .)...
  > HCI Event: Mode Change (0x14) plen 6
    0000: 00 29 00 02 00 08                                 .)....

When I try to play music over the headset, it appears to work:

  # aplay -D plughw:Headset "/home/music/music/Where It's At.wav"
  Playing WAVE '/home/music/music/Where It's At.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

Here is the hcidump -X output of the above command, somewhat
truncated:

  < HCI Command: Add SCO Connection (0x01|0x0007) plen 4
    0000: 29 00 e0 00                                       )...
  > HCI Event: Command Status (0x0f) plen 4
    0000: 00 01 07 04                                       ....
  > HCI Event: Connect Complete (0x03) plen 11
    0000: 00 2c 00 99 40 06 a4 07 00 00 01                  .,..@......
  > SCO data: handle 0x002c dlen 48
      0000: 10 00 13 00 13 00 29 00 0f 00 ac 20 00 00 15 00   ......).... ....
      0010: 11 00 25 00 24 00 16 00 14 00 0d 00 11 00 23 00   ..%.$.........#.
      0020: 1f 00 10 00 16 00 11 00 0f 00 1a 00 13 00 0c 00   ................
  > SCO data: handle 0x002c dlen 48
      0000: 0c 00 0b 00 14 00 12 00 0a 00 09 00 ff ff 05 00   ................
      0010: 22 00 22 00 17 00 05 00 15 00 11 00 0a 00 18 00   ".".............
      0020: 22 00 1b 00 12 00 1c 00 16 00 04 00 17 00 1a 00   "...............
  > SCO data: handle 0x002c dlen 48
      0000: 10 00 15 00 0a 00 13 00 1f 00 0f 00 14 00 16 00   ................
      0010: 0f 00 17 00 14 00 08 00 06 00 fb ff 08 00 23 00   ..............#.
      0020: 23 00 12 00 08 00 14 00 0e 00 0f 00 20 00 28 00   #........... .(.
  > SCO data: handle 0x002c dlen 48
      0000: 1d 00 0b 00 13 00 21 00 10 00 16 00 1f 00 12 00   ......!.........
      0010: 17 00 14 00 10 00 16 00 10 00 13 00 16 00 19 00   ................
      0020: 1a 00 11 00 17 00 14 00 f9 ff 03 00 24 00 18 00   ............$...
  > SCO data: handle 0x002c dlen 48
      0000: 0f 00 19 00 04 00 0a 00 23 00 27 00 1e 00 09 00   ........#.'.....
      0010: 11 00 1f 00 10 00 17 00 12 00 0d 00 25 00 14 00   ............%...
      0020: 0d 00 17 00 08 00 0f 00 11 00 0b 00 1d 00 1c 00   ................
  > SCO data: handle 0x002c dlen 48
      0000: 08 00 0d 00 0a 00 02 00 15 00 15 00 08 00 02 00   ................
      0010: 10 00 10 00 10 00 1a 00 1d 00 1e 00 12 00 0f 00   ................
      0020: 1d 00 0f 00 13 00 21 00 12 00 19 00 1a 00 0d 00   ......!.........
  > SCO data: handle 0x002c dlen 48
      0000: 13 00 1b 00 16 00 05 00 12 00 1a 00 09 00 0f 00   ................
      0010: 06 00 ff ff 11 00 1c 00 1c 00 18 00 09 00 11 00   ................
      0020: 0d 00 f6 ff 12 00 23 00 16 00 13 00 10 00 1a 00   ......#.........
  > SCO data: handle 0x002c dlen 48
      0000: 0f 00 11 00 1d 00 10 00 1a 00 16 00 08 00 19 00   ................
      0010: 15 00 0c 00 0b 00 06 00 14 00 19 00 04 00 01 00   ................

This continues until I kill the aplay process.

One interesting thing I noticed:  after invoking aplay, there is a new
module loaded into the kernel:

  # lsmod | grep sco
  sco                    15685  0 
  snd_bt_sco             16416  1 
  snd_hwdep               8901  2 snd_bt_sco
  bluetooth              48453  10 sco,hci_usb,rfcomm,l2cap
  snd_pcm                93001  5 snd_bt_sco,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
  snd                    52645  12 snd_bt_sco,snd_hwdep,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
  snd_page_alloc          9541  4 snd_bt_sco,snd_intel8x0m,snd_intel8x0,snd_pcm

Note the "sco" module.  That is a module that had been installed along
with my kernel in /lib/modules/2.6.10-1.770_FC3/kernel/net/bluetooth/sco.ko. 

Can anyone tell me why btsco does not report a connection, and why I'm
unable to hear the audio that appears to be streaming over hci0 as a
result of the aplay command?

Thanks,
Dave



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
