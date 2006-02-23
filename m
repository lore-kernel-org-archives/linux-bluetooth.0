Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43FDE154.7050803@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-users] A2DP alsa no sound
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
Date: Thu, 23 Feb 2006 18:22:44 +0200

I am SO glad you made a alsa plugin for the headphones.
I  tried it , I hear that the headphones do pick it up , but no sound 
goes throu
hcidump -X -V:

HCI sniffer - Bluetooth packet analyzer ver 1.29
device: hci0 snap_len: 1028 filter: 0xffffffff
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 1
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0086 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 41 mode 0x00 interval 0
    Mode: Active
 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0086 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0086 flags 0x00 clen 0
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 895
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0086 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0086 len 3 [psm 25]
      AVDTP(s): Discover cmd: transaction 0
      0000: 00                                                .
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 25]
      AVDTP(s): Discover rsp: transaction 0
        ACP SEID 1 - Audio Sink
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0086 len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 1
        ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 16
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
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0086 len 14 [psm 25]
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
    handle 41 packets 1
          16 Blocks
          8 Subbands
          SNR
          Bitpool Range 2-32
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Set config rsp: transaction 2
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0086 len 3 [psm 25]
      AVDTP(s): Open cmd: transaction 3
        ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Open rsp: transaction 3
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0042
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0087 scid 0x0042 result 1 status 2
      Connection pending - Authorization pending
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0087 scid 0x0042 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0087 flags 0x00 clen 0
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
      MTU 895
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0087 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0086 len 3 [psm 25]
      AVDTP(s): Start cmd: transaction 4
        ACP SEID 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Start rsp: transaction 4
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0088
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0088 result 2 status 0
      Connection refused - PSM not supported
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 41 mode 0x02 interval 200
    Mode: Sniff
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0087 scid 0x0042
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 1
 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 41 mode 0x00 interval 0
    Mode: Active
 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
 > ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0087 scid 0x0042



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
