Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3837d8b10608010954l1cba6660g296de8379b2b8022@mail.gmail.com>
Date: Tue, 1 Aug 2006 11:54:06 -0500
From: "keith preston" <keithpre@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] Bluetooth Headset Error
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0957249188=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0957249188==
Content-Type: multipart/alternative;
	boundary="----=_Part_47051_12241430.1154451246255"

------=_Part_47051_12241430.1154451246255
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have been working to try and get a bluetooth headset to work on my linux
box and have run into a dead end with this error.  I am running Ubuntu
Dapper with the Linux Kernel 2.6.15.26.  I have a dlink usb bluetooth dongle
and logitech headset. Here are some outputs

preston@ubuntu:~/bluetooth/btsco$ hciconfig -a
hci0:   Type: USB
        BD Address: 00:15:E9:69:EA:E7 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1734856 acl:36143 sco:0 events:134252 errors:0
        TX bytes:34924881 acl:230286 sco:0 commands:695 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'ubuntu-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

preston@ubuntu:~/bluetooth/btsco$ sudo hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:15:E9:69:EA:E7 ACL MTU: 192:8 SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI

preston@ubuntu:~/bluetooth/btsco$ sudo hcitool info 00:0D:44:6F:C4:50
Requesting information ...
        BD Address:  00:0D:44:6F:C4:50
        LMP Version: 1.2 (0x2) LMP Subversion: 0x3d
        Manufacturer: Zeevo, Inc. (18)
        Features: 0xff 0x07 0x00 0x78 0x18 0x18 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                <AFH cap. slave> <AFH class. slave> <AFH cap. master>
                <AFH class. master>

preston@ubuntu:~/bluetooth/btsco$ sudo mpg123 --au - ~/music/throne.mp3
| ./a2play 00:0D:44:6F:C4:50
subbands = 8 blocks = 16 bitpool = 32
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2 and 3.
Version 0.59r (1999/Jun/15). Written and copyrights by Michael Hipp.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!

Directory: /home/preston/music/
Playing MPEG stream from throne.mp3 ...
Junk at the beginning 49443303
MPEG 1.0 layer III, 128 kbit/s, 44100 Hz mono
len=2048
Header size=32
Sample Rate:44100
Channels:1
Using address: 00:0D:44:6F:C4:50
Found A2DP Sink
Found A2DP Sink at the destination
Connected [imtu 672, omtu 672, flush_to 65535]
Sent the Stream End Point Discovery Command
Got a Stream End Point Discovery Response
received 1 capabilities
SEID = 1
Requested Capabilities for SEID = 1
Got capabilities response Sent set configurations command
Set configurations command accepted
Sent open stream command
Got open stream confirm
Connected [imtu 672, omtu 674, flush_to 65535]
Sent stream start
Got start stream confirm
Listen thread running
received signal 8 from set
unexpected headset directive 8
write failed: Connection reset by peer
error while receiving 2


/*  This is the output during the a2play command */
preston@ubuntu:~/bluetooth/btsco$ sudo hcidump -X HCI sniffer - Bluetooth
packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff < HCI Command: Create
Connection (0x01|0x0005) plen 13
  0000: 50 c4 6f 44 0d 00 18 cc  02 00 00 00 01           P.oD.........
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
 > HCI Event: Role Change (0x12) plen 8
  0000: 00 50 c4 6f 44 0d 00 01                           .P.oD...
 > HCI Event: Link Key Request (0x17) plen 6
  0000: 50 c4 6f 44 0d 00                                 P.oD..
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 50 c4 6f 44 0d 00 45 d7  29 76 ea 4e c8 c6 d7 c1  P.oD..E.)v.N....
  0010: 51 7a a7 ff 62 3d                                 Qz..b=
 > HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 50 c4 6f 44  0d 00                    ....P.oD..
 > HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2c 00 50 c4 6f 44 0d  00 01 00                 .,.P.oD....
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040 < HCI Command: Write Link
Policy Settings (0x02|0x000d) plen 4
  0000: 2c 00 0f 00                                       ,...
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 50 c4 6f 44 0d 00 01                              P.oD...
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 2c 00                                 ....,.
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 50 c4 6f 44 0d 00 01 00  00 00                    P.oD......
 > HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2c 00 05                                          ,..
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 50 c4 6f 44 0d 00 01 00  00 00                    P.oD......
 > ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004f scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004f flags 0x00 clen 0  > ACL data: handle
44 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0 < ACL data: handle
44 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004f flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
< ACL data: handle 44 flags 0x02 dlen 24
    L2CAP(d): cid 0x004f len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x110d (AdvAudio)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 00 19 04                                       ....
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 131
    L2CAP(d): cid 0x0040 len 127 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x7a
          count 119
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x1
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110b (AudioSink) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x19 > <
                 uuid-16 0x0019 (AVDTP) uint 0x100 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110d (AdvAudio) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "stereo headphone"
              aid 0x0102 (ProviderName)
                 str "impulse"
              aid 0x0311 (unknown)
                 uint 0x1
          cont 00
< ACL data: handle 44 flags 0x02 dlen 24
    L2CAP(d): cid 0x004f len 20 [psm 1]
        SDP SSA Req: tid 0x1 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x5
          count 2
          cont 00
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004f scid 0x0040  > HCI Event: Number of
Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004f scid 0x0040 < ACL data: handle 44
flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040  > HCI Event: Number of
Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0040 result 1 status 0
      Connection pending - No futher information available  > ACL data:
handle 44 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0050 flags 0x00 clen 0  > ACL data: handle
44 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0 < ACL data: handle
44 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0050 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0051 < ACL data: handle 44 flags
0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0051 result 2 status 0
      Connection refused - PSM not supported  > ACL data: handle 44 flags
0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 0  > HCI Event: Number of
Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
< ACL data: handle 44 flags 0x02 dlen 6
    L2CAP(d): cid 0x0050 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 0  > HCI Event: Number of
Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 25]
      AVDTP(s): Discover rsp: transaction 0
        ACP SEID 1 - Audio Sink
< ACL data: handle 44 flags 0x02 dlen 7
    L2CAP(d): cid 0x0050 len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 1
        ACP SEID 1
 > ACL data: handle 44 flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 1
        Media Transport
        Media Codec - SBC
          44.1kHz 48kHz
          Mono DualChannel Stereo JointStereo
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness
          Bitpool Range 20-58
        Content Protection
          02 00
 > HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 50 c4 6f 44 0d 00 42  54 2d 48 65 61 64 70 68  .P.oD..BT-Headph
  0010: 6f 6e 65 00 00 00 00 00  00 00 00 00 00 00 00 00  one.............
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
< ACL data: handle 44 flags 0x02 dlen 18
    L2CAP(d): cid 0x0050 len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 2
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          44.1kHz
          Mono
          16 Blocks
          8 Subbands
          SNR
          Bitpool Range 20-58
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 00 00                                       ....
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Set config rsp: transaction 2 < ACL data: handle 44 flags
0x02 dlen 7
    L2CAP(d): cid 0x0050 len 3 [psm 25]
      AVDTP(s): Open cmd: transaction 3
        ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Open rsp: transaction 3
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0041  > ACL data: handle 44 flags
0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 1 status 0
      Connection pending - No futher information available  > ACL data:
handle 44 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0052 flags 0x00 clen 0  > ACL data: handle
44 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 674
< ACL data: handle 44 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0052 flags 0x00 result 0 clen 0
      Success
 > ACL data: handle 44 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 44 flags 0x02 dlen 7
    L2CAP(d): cid 0x0050 len 3 [psm 25]
      AVDTP(s): Start cmd: transaction 4
        ACP SEID 1
 > HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 50 c4 6f 44 0d 00 42  54 2d 48 65 61 64 70 68  .P.oD..BT-Headph
  0010: 6f 6e 65 00 00 00 00 00  00 00 00 00 00 00 00 00  one.............
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
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0053 < ACL data: handle 44 flags
0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0053 result 2 status 0
      Connection refused - PSM not supported  > ACL data: handle 44 flags
0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Start rsp: transaction 4  > ACL data: handle 44 flags 0x02
dlen 7
    L2CAP(d): cid 0x0040 len 3 [psm 25]
      AVDTP(s): Close cmd: transaction 1
        ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
< ACL data: handle 44 flags 0x02 dlen 6
    L2CAP(d): cid 0x0050 len 2 [psm 25]
      AVDTP(s): Close rsp: transaction 1  > ACL data: handle 44 flags 0x02
dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0052  > HCI Event: Number of
Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
< ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0052  > ACL data: handle 44
flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 2  > HCI Event: Number of
Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > ACL data: handle 44 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0050 < ACL data: handle 44
flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0050  > HCI Event: Number of
Completed Packets (0x13) plen 5
  0000: 01 2c 00 01 00                                    .,...
 > HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 2c 00 13                                       .,..



Keith Preston

------=_Part_47051_12241430.1154451246255
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have been working to try and get a bluetooth headset to work on my linux box and have run into a dead end with this error.&nbsp; I am running Ubuntu Dapper with the Linux Kernel <a href="http://2.6.15.26">2.6.15.26</a>.&nbsp; I have a dlink usb bluetooth dongle and logitech headset. Here are some outputs
<br><br>preston@ubuntu:~/bluetooth/btsco$ hciconfig -a<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:15:E9:69:EA:E7 ACL MTU: 192:8 SCO MTU: 64:8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1734856 acl:36143 sco:0 events:134252 errors:0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:34924881 acl:230286 sco:0 commands:695 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'ubuntu-0'<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x3e0100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking, Rendering, Capturing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 
1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: <br>0x20d<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br><br>preston@ubuntu:~/bluetooth/btsco$ sudo hciconfig hci0 revision<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:15:E9:69:EA:E7 ACL MTU: 192:8 SCO MTU: 64:8
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI 16.4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip version: BlueCore02-External<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Max key size: 56 bit<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO mapping:&nbsp; HCI<br><br>preston@ubuntu:~/bluetooth/btsco$ sudo hcitool info 00:0D:44:6F:C4:50 Requesting information ...
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:0D:44:6F:C4:50<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.2 (0x2) LMP Subversion: 0x3d<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Zeevo, Inc. (18)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0x07 0x00 0x78 0x18 0x18 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; &lt;slot offset&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff mode&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;enhanced iscan&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;interlaced iscan&gt; &lt;interlaced pscan&gt; &lt;inquiry with RSSI&gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;AFH cap. slave&gt; &lt;AFH class. slave&gt; &lt;AFH cap. master&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;AFH class. master&gt;<br><br>preston@ubuntu:~/bluetooth/btsco$ sudo mpg123 --au - ~/music/throne.mp3 <br>| ./a2play 00:0D:44:6F:C4:50
<br>subbands = 8 blocks = 16 bitpool = 32<br>High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2 and 3.<br>Version 0.59r (1999/Jun/15). Written and copyrights by Michael Hipp.<br>Uses code from various people. See 'README' for more!
<br>THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!<br><br>Directory: /home/preston/music/<br>Playing MPEG stream from throne.mp3 ...<br>Junk at the beginning 49443303<br>MPEG 1.0 layer III, 128 kbit/s, 44100 Hz mono
<br>len=2048<br>Header size=32<br>Sample Rate:44100<br>Channels:1<br>Using address: 00:0D:44:6F:C4:50<br>Found A2DP Sink<br>Found A2DP Sink at the destination<br>Connected [imtu 672, omtu 672, flush_to 65535] <br>Sent the Stream End Point Discovery Command 
<br>Got a Stream End Point Discovery Response <br>received 1 capabilities <br>SEID = 1 <br>Requested Capabilities for SEID = 1 <br>Got capabilities response Sent set configurations command <br>Set configurations command accepted 
<br>Sent open stream command <br>Got open stream confirm <br>Connected [imtu 672, omtu 674, flush_to 65535] <br>Sent stream start<br>Got start stream confirm<br>Listen thread running<br>
received signal 8 from set<br>
unexpected headset directive 8<br>
write failed: Connection reset by peer<br>
error while receiving 2<br><br><br>/*&nbsp; This is the output during the a2play command */<br>preston@ubuntu:~/bluetooth/btsco$ sudo hcidump -X HCI sniffer - Bluetooth packet analyzer ver 1.28<br>device: hci0 snap_len: 1028 filter: 0xffffffff &lt; HCI Command: Create Connection (0x01|0x0005) plen 13
<br>&nbsp; 0000: 50 c4 6f 44 0d 00 18 cc&nbsp; 02 00 00 00 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P.oD.........<br>&nbsp;&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp; 0000: 00 01 05 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&nbsp;&gt; HCI Event: Role Change (0x12) plen 8
<br>&nbsp; 0000: 00 50 c4 6f 44 0d 00 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .P.oD...<br>&nbsp;&gt; HCI Event: Link Key Request (0x17) plen 6<br>&nbsp; 0000: 50 c4 6f 44 0d 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P.oD..<br>&lt; HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
<br>&nbsp; 0000: 50 c4 6f 44 0d 00 45 d7&nbsp; 29 76 ea 4e c8 c6 d7 c1&nbsp; P.oD..E.)v.N....<br>&nbsp; 0010: 51 7a a7 ff 62 3d&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Qz..b=<br>&nbsp;&gt; HCI Event: Command Complete (0x0e) plen 10<br>&nbsp; 0000: 01 0b 04 00 50 c4 6f 44&nbsp; 0d 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....P.oD..
<br>&nbsp;&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp; 0000: 00 2c 00 50 c4 6f 44 0d&nbsp; 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,.P.oD....<br>&lt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 1 scid 0x0040 &lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
<br>&nbsp; 0000: 2c 00 0f 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ,...<br>&nbsp;&gt; HCI Event: Page Scan Repetition Mode Change (0x20) plen 7<br>&nbsp; 0000: 50 c4 6f 44 0d 00 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P.oD...<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; HCI Event: Command Complete (0x0e) plen 6<br>&nbsp; 0000: 01 0d 08 00 2c 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....,.<br>&lt; HCI Command: Remote Name Request (0x01|0x0019) plen 10
<br>&nbsp; 0000: 50 c4 6f 44 0d 00 01 00&nbsp; 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P.oD......<br>&nbsp;&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>&nbsp; 0000: 2c 00 05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ,..<br>&nbsp;&gt; HCI Event: Command Status (0x0f) plen 4
<br>&nbsp; 0000: 00 01 19 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&lt; HCI Command: Remote Name Request (0x01|0x0019) plen 10<br>&nbsp; 0000: 50 c4 6f 44 0d 00 01 00&nbsp; 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P.oD......<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 16
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x004f scid 0x0040 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>&lt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x004f flags 0x00 clen 0&nbsp; &gt; ACL data: handle 44 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0 &lt; ACL data: handle 44 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x004f flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&lt; ACL data: handle 44 flags 0x02 dlen 24<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004f len 20 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x0 len 0xf<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x110d (AdvAudio)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&nbsp;&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp; 0000: 00 00 19 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 131<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 127 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x0 len 0x7a<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 119
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; record #0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0000 (SrvRecHndl)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0001 (SrvClassIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x110b (AudioSink) &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0004 (ProtocolDescList)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x0100 (L2CAP) uint 0x19 &gt; &lt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uuid-16 0x0019 (AVDTP) uint 0x100 &gt; &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0005 (BrwGrpList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uuid-16 0x1002 (PubBrwsGrp) &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0006 (LangBaseAttrIDList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; uint 0x656e uint 0x6a uint 0x100 &gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0009 (BTProfileDescList)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &lt; uuid-16 0x110d (AdvAudio) uint 0x100 &gt; &gt;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0100 (SrvName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;stereo headphone&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0102 (ProviderName)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str &quot;impulse&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid 0x0311 (unknown)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint 0x1
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 44 flags 0x02 dlen 24<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004f len 20 [psm 1]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Req: tid 0x1 len 0xf<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pat uuid-16 0x1200 (PNPInfo)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max 65535<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aid(s) 0x0000 - 0xffff
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 [psm 1]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP SSA Rsp: tid 0x1 len 0x5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cont 00<br>&lt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x004f scid 0x0040&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x004f scid 0x0040 &lt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 25 scid 0x0040&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0040 result 1 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection pending - No futher information available&nbsp; &gt; ACL data: handle 44 flags 0x02 dlen 16
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0050 scid 0x0040 result 0 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>&lt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0050 flags 0x00 clen 0&nbsp; &gt; ACL data: handle 44 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0 &lt; ACL data: handle 44 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0050 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 23 scid 0x0051 &lt; ACL data: handle 44 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0051 result 2 status 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection refused - PSM not supported&nbsp; &gt; ACL data: handle 44 flags 0x02 dlen 6<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover cmd: transaction 0&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&lt; ACL data: handle 44 flags 0x02 dlen 6<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0050 len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover cmd: transaction 0&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 8<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 4 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover rsp: transaction 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1 - Audio Sink
<br>&lt; ACL data: handle 44 flags 0x02 dlen 7<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0050 len 3 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Capabilities cmd: transaction 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 20<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 16 [psm 25]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Capabilities rsp: transaction 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Media Transport<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Media Codec - SBC<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 44.1kHz 48kHz<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mono DualChannel Stereo JointStereo<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 8 12 16 Blocks<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4 8 Subbands
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNR Loudness<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bitpool Range 20-58<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Content Protection<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 02 00<br>&nbsp;&gt; HCI Event: Remote Name Req Complete (0x07) plen 255<br>&nbsp; 0000: 00 50 c4 6f 44 0d 00 42&nbsp; 54 2d 48 65 61 64 70 68&nbsp; .P.oD..BT-Headph
<br>&nbsp; 0010: 6f 6e 65 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; one.............<br>&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0030: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................
<br>&nbsp; 0040: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0050: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0060: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................
<br>&nbsp; 0070: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0080: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0090: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................
<br>&nbsp; 00a0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 00b0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 00c0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................
<br>&nbsp; 00d0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 00e0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 00f0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp;&nbsp; ...............
<br>&lt; ACL data: handle 44 flags 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0050 len 14 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Set config cmd: transaction 2<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1 - INT SEID 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Media Transport<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Media Codec - SBC
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 44.1kHz<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mono<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 Blocks<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8 Subbands<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SNR<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bitpool Range 20-58<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...
<br>&nbsp;&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp; 0000: 00 01 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...
<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 6<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Set config rsp: transaction 2 &lt; ACL data: handle 44 flags 0x02 dlen 7<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0050 len 3 [psm 25]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Open cmd: transaction 3<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 6
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Open rsp: transaction 3<br>&lt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 25 scid 0x0041&nbsp; &gt; ACL data: handle 44 flags 0x02 dlen 16
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 1 status 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection pending - No futher information available&nbsp; &gt; ACL data: handle 44 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0052 scid 0x0041 result 0 status 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>&lt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0052 flags 0x00 clen 0&nbsp; &gt; ACL data: handle 44 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 674<br>&lt; ACL data: handle 44 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0052 flags 0x00 result 0 clen 0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&lt; ACL data: handle 44 flags 0x02 dlen 7<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0050 len 3 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Start cmd: transaction 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1<br>&nbsp;&gt; HCI Event: Remote Name Req Complete (0x07) plen 255
<br>&nbsp; 0000: 00 50 c4 6f 44 0d 00 42&nbsp; 54 2d 48 65 61 64 70 68&nbsp; .P.oD..BT-Headph<br>&nbsp; 0010: 6f 6e 65 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; one.............<br>&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................
<br>&nbsp; 0030: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0040: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0050: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................
<br>&nbsp; 0060: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0070: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 0080: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................
<br>&nbsp; 0090: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 00a0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 00b0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................
<br>&nbsp; 00c0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 00d0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................<br>&nbsp; 00e0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ................
<br>&nbsp; 00f0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp;&nbsp; ...............<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 23 scid 0x0053 &lt; ACL data: handle 44 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0053 result 2 status 0
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection refused - PSM not supported&nbsp; &gt; ACL data: handle 44 flags 0x02 dlen 6<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Start rsp: transaction 4&nbsp; &gt; ACL data: handle 44 flags 0x02 dlen 7
<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 3 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Close cmd: transaction 1<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1<br>&nbsp;&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...
<br>&lt; ACL data: handle 44 flags 0x02 dlen 6<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0050 len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Close rsp: transaction 1&nbsp; &gt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0041 scid 0x0052&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5
<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&lt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0052&nbsp; &gt; ACL data: handle 44 flags 0x02 dlen 6<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 2 [psm 25]
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover cmd: transaction 2&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...<br>&nbsp;&gt; ACL data: handle 44 flags 0x02 dlen 12
<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0040 scid 0x0050 &lt; ACL data: handle 44 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0050&nbsp; &gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 01 2c 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,...
<br>&nbsp;&gt; HCI Event: Disconn Complete (0x05) plen 4<br>&nbsp; 0000: 00 2c 00 13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .,..<br><br><br><br>Keith Preston<br><br><br><br><br>

------=_Part_47051_12241430.1154451246255--


--===============0957249188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0957249188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0957249188==--
