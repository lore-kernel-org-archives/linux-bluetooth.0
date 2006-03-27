Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <5307d89f0603271206w5142bd73n28f5e20da2e67019@mail.gmail.com>
From: "Patrick Libert" <patrick.libert@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Info a2dp userspace plugin
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
Date: Mon, 27 Mar 2006 22:06:14 +0200

Hello, I have a problem with the a2dp plugin!

When I use it with a2play it works OK
(beep-media-player -p music.mp3 | sox -c 2 -t raw -r 44100 -w -s - -t
au - | a2play -p 08:95:FF:00:00:6D)

But when I use the userspace plugin it doesn't work!
I get the following error with hcidump:
           L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0042 result 2 status 0
           Connection refused - PSM not supported

Here is the hcidump from a2play that works OK (all good)

             HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  6D 00 00 FF 95 08 18 CC 02 00 00 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: Connect Complete (0x03) plen 11
  00 2A 00 6D 00 00 FF 95 08 01 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  2A 00 0F 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x007e scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 2A 00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  6D 00 00 FF 95 08 01 00 00 00
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  6D 00 00 FF 95 08 01
> HCI Event: Max Slots Change (0x1b) plen 3
  2A 00 05
> HCI Event: Command Status (0x0f) plen 4
  00 01 19 04
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  6D 00 00 FF 95 08 01 00 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 00 19 04
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x007e scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x007e flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x007e flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x007e len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x110d (AdvAudio)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Remote Name Req Complete (0x07) plen 255
  00 6D 00 00 FF 95 08 4D 41 4E 20 26 20 54 45 4C 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 00 00
> ACL data: handle 42 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          count 38
          cont 02 00 18
< ACL data: handle 42 flags 0x02 dlen 26
    L2CAP(d): cid 0x007e len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x110d (AdvAudio)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 18
> HCI Event: Remote Name Req Complete (0x07) plen 255
  00 6D 00 00 FF 95 08 4D 41 4E 20 26 20 54 45 4C 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 36
    L2CAP(d): cid 0x0040 len 32 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x1b
          count 24
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110b (AudioSink) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x19 > <
                 uuid-16 0x0019 (AVDTP) uint 0x100 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110d (AdvAudio) uint 0x100 > >
              aid 0x0311 (unknown)
                 uint 0x1
          cont 00
< ACL data: handle 42 flags 0x02 dlen 24
    L2CAP(d): cid 0x007e len 20 [psm 1]
        SDP SSA Req: tid 0x2 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x5
          count 2
          cont 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x007e scid 0x0040
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x007f scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x007e scid 0x0040
> HCI Event: Link Key Request (0x17) plen 6
  6D 00 00 FF 95 08
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  6D 00 00 FF 95 08 02 6F 8C 42 F1 A7 EC 23 E2 70 11 B2 A4 E5
  D1 FC
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 6D 00 00 FF 95 08
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x007f scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x007f flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 895
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x007f flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x007f len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 25]
      AVDTP(s): Discover rsp: transaction 0
        ACP SEID 1 - Audio Sink
        ACP SEID 2 - Audio Sink
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x007f len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 1
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(d): cid 0x0041 len 12 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 1
        Media Transport
        Media Codec - SBC
          16kHz 32kHz 44.1kHz 48kHz
          Mono DualChannel Stereo JointStereo
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness
          Bitpool Range 2-32
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x007f len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 2
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          44.1kHz
          Stereo
          16 Blocks
          8 Subbands
          SNR
          Bitpool Range 2-32
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Set config rsp: transaction 2
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x007f len 3 [psm 25]
      AVDTP(s): Open cmd: transaction 3
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Open rsp: transaction 3
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0080 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0080 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0080 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 895
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0080 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x007f len 3 [psm 25]
      AVDTP(s): Start cmd: transaction 4
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0041 len 2 [psm 25]
      AVDTP(s): Start rsp: transaction 4
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 384
< ACL data: handle 42 flags 0x01 dlen 85
    L2CAP(d): cid 0x0080 len 849 [psm 25]
      AVDTP(m): ver 2 cc 0 pt 1 seqn 1 time 0 ssrc 1
      0B 9C BB 20 2D 00 00 00 00 00 00 00 00 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 9C BB 20
      2D 00 00 00 00 00 00 00 00 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 9C BB 20 2D 00 00 00
      00 00 00 00 00 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 9C BB 20 2D 00 00 00 00 00 00 00
      00 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 9C BB 20 2D 00 00 00 00 00 00 00 00 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 9C BB 20 2D 00 00 00 00 00 00 00 00 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55
      55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 55 9C BB 20
      1E 44 21 10 00 34 21 10 00 7D ED 5D ED 7D ED 5D ED 7D ED 5D
      ED 7D ED 5D ED 81 ED 5D ED 7D CD 5D ED 79 ED 5D ED 89 AD 5D
      AD 75 F0 5E 11 86 8A 5E 6A A2 AC 62 AC 76 59 62 79 A1 C1 65
      A1 8C 5A 74 99 62 29 1E 0A E5 2D 29 2D 9C BB 20 40 55 54 32
      00 65 54 32 00 62 52 7A D2 8C 3B 93 BB 6D 34 6D B4 43 33 7A
      B4 92 23 7A A3 8C 3A 64 32 83 B3 73 33 BC C5 7D 3D 9D 34 94
      BB 51 A3 62 24 46 22 6D A2 C4 1C 9C 9C 5D 1C 3D 1B 7E A2 66
      A3 84 3B A4 BA 2C CB A4 4B 9C BB 20 FC 65 54 33 00 65 54 33
      00 79 BD 92 BC 7C 52 9B D3 6D 6D 75 ED 64 F2 34 72 A8 3C 80
      3C 8A BA 52 C2 94 2B 9B AB 9B 4A A3 CA 44 4B 4B C4 91 93 92
      9A 75 B5 3C B5 5D 5B 5D DA 62 24 99 9D 83 B4 9B B4 C3 BD D4
      3E 63 34 8A 3B 9C BB 20 EA 66 64 43 00 76 54 44 00 48 85 84
      C9 58 75 63 31 75 59 5B 19 86 95 92 D1 39 85 64 C5 B6 55 AB
      91 98 74 8B B4 87 94 54 44 BD 99 75 D9 4D 90 3F 40 68 39 83
      89 87 42 A3 82 7A 6A 95 29 29 71 B4 31 87 51 A4 A1 64 81 49
      41 9C BB 20 85 77 75 54 00 77 75 54 00 54 85 35 85 85 85 A4
      85 33 91 53 A1 67 86 67 86 A8 9A A8 96 A3 69 73 69 85 72 64
      71 74 71 45 71 66 74 76 84 19 99 59 99 48 79 38 79 93 81 C3
      81 7B 36 5B 36 DA 11 8A 22 62 89 83 89 AA 60 B9 60
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 02 00
< ACL data: handle 42 flags 0x02 dlen 384
< ACL data: handle 42 flags 0x01 dlen 384
< ACL data: handle 42 flags 0x01








Here is the hcidump of the plugin that doesn't work



       HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Disconnect (0x01|0x0006) plen 3
  2B 00 13
> HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete (0x05) plen 4
  00 2B 00 16
< HCI Command: Create Connection (0x01|0x0005) plen 13
  6D 00 00 FF 95 08 18 CC 02 00 00 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: Connect Complete (0x03) plen 11
  00 2A 00 6D 00 00 FF 95 08 01 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  2A 00 0F 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 2A 00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  6D 00 00 FF 95 08 01 00 00 00
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  6D 00 00 FF 95 08 01
> HCI Event: Max Slots Change (0x1b) plen 3
  2A 00 05
> HCI Event: Command Status (0x0f) plen 4
  00 01 19 04
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  6D 00 00 FF 95 08 01 00 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 00 19 04
> HCI Event: Remote Name Req Complete (0x07) plen 255
  00 6D 00 00 FF 95 08 4D 41 4E 20 26 20 54 45 4C 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 00 00
> HCI Event: Remote Name Req Complete (0x07) plen 255
  00 6D 00 00 FF 95 08 4D 41 4E 20 26 20 54 45 4C 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> HCI Event: Link Key Request (0x17) plen 6
  6D 00 00 FF 95 08
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  6D 00 00 FF 95 08 02 6F 8C 42 F1 A7 EC 23 E2 70 11 B2 A4 E5
  D1 FC
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 6D 00 00 FF 95 08
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 895
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0040 len 3 [psm 25]
      AVDTP(s): Discover cmd: transaction 0
      00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 25]
      AVDTP(s): Discover rsp: transaction 0
        ACP SEID 1 - Audio Sink
        ACP SEID 2 - Audio Sink
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0040 len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 1
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 1
        Media Transport
        Media Codec - SBC
          16kHz 32kHz 44.1kHz 48kHz
          Mono DualChannel Stereo JointStereo
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness
          Bitpool Range 2-32
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 2
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          44.1kHz
          Stereo
          16 Blocks
          8 Subbands
          SNR
          Bitpool Range 2-32
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Set config rsp: transaction 2
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0040 len 3 [psm 25]
      AVDTP(s): Open cmd: transaction 3
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Open rsp: transaction 3
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
> ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 895
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 7
    L2CAP(d): cid 0x0040 len 3 [psm 25]
      AVDTP(s): Start cmd: transaction 4
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> ACL data: handle 42 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Start rsp: transaction 4
> HCI Event: Role Change (0x12) plen 8
  00 6D 00 00 FF 95 08 01
> HCI Event: Max Slots Change (0x1b) plen 3
  2A 00 05
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0042
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0042 result 2 status 0
      Connection refused - PSM not supported
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Mode Change (0x14) plen 6
  00 2A 00 02 C8 00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 2A 00 01 00
> HCI Event: Max Slots Change (0x1b) plen 3
  2A 00 01
> HCI Event: Mode Change (0x14) plen 6
  00 2A 00 00 00 00
> HCI Event: Max Slots Change (0x1b) plen 3
  2A 00 05
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  2A 00 13
> HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
> HCI Event: Disconn Complete (0x05) plen 4
  00 2A 00 16


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
