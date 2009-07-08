Return-Path: <cyrus@holtmann.org>
From: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 8 Jul 2009 20:02:58 +0530
Subject: A2DP issue with latest BlueZ in Ubuntu 9.04
Message-ID: <44EE5C37ADC36343B0625A05DD408C485068EDD151@CHEXMB-01.global.atheros.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,
I have tested A2DP profile using internal Bluetooth dongle present
in Compaq Presario CQ45 laptop in Linux.

IUT details
Linux Distribution - Ubuntu 9.04
Kernel - 2.6.28-11
BlueZ version - 4.32
Headset - Jabra BT620
Dongle - HP wireless (Bluetooth + WLAN) Interface [integrated module]

Asoundrc as follows, updated the headset mac properly.

pcm.bluetooth{
        type bluetooth
        device <mac>
        profile "auto"
}

pcm.bluetoothraw {
        type bluetooth
        }

pcm.bluetooth{
        type plug
        slave{
        pcm bluetoothraw
}
}

I am able to hear songs properly using mplayer.

I have upgraded the BlueZ version 4.44 in the same setup by manual compile.
A2DP not working...and found following line in bluetoothd daemon output

"bluetoothd[17495]: Invalid seid 0"

Pairing is ok. Mplayer throws an error message.

I am not able to track what is the issue.
Any once faces such issue? Let me know how to fix this issue.

I have tested A2DP in FC11 installed PC. I am not able to hear song.

Thanks,
Jothi

================================
Hcidump

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
2009-07-08 22:31:47.548233 < HCI Command: Periodic Inquiry Mode (0x01|0x0003) plen 9
    max 24 min 16 lap 0x9e8b33 len 8 num 0
2009-07-08 22:31:47.550020 > HCI Event: Command Complete (0x0e) plen 4
    Periodic Inquiry Mode (0x01|0x0003) ncmd 1
    status 0x00
2009-07-08 22:31:47.563017 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c3 class 0x240404 rssi -53
2009-07-08 22:31:47.983000 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c2 class 0x240404 rssi -51
2009-07-08 22:31:48.033998 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c3 class 0x240404 rssi -51
2009-07-08 22:31:48.167994 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5D mode 1 clkoffset 0x0e71 class 0x5a210c rssi -69
2009-07-08 22:31:48.235991 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c3 class 0x240404 rssi -51
2009-07-08 22:31:48.615978 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c2 class 0x240404 rssi -52
2009-07-08 22:31:48.996957 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c3 class 0x240404 rssi -45
2009-07-08 22:31:49.326944 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c2 class 0x240404 rssi -50
2009-07-08 22:31:49.927919 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c2 class 0x240404 rssi -50
2009-07-08 22:31:50.178900 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -50
2009-07-08 22:31:50.649888 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c2 class 0x240404 rssi -49
2009-07-08 22:31:50.880878 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c3 class 0x240404 rssi -46
2009-07-08 22:31:50.940872 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c2 class 0x240404 rssi -49
2009-07-08 22:31:51.581848 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c3 class 0x240404 rssi -45
2009-07-08 22:31:52.142791 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c3 class 0x240404 rssi -45
2009-07-08 22:31:52.619806 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5C mode 1 clkoffset 0x0095 class 0x7e0100 rssi -70
2009-07-08 22:31:52.810796 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5C mode 1 clkoffset 0x0096 class 0x7e0100 rssi -77
2009-07-08 22:31:52.920792 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5C mode 1 clkoffset 0x0095 class 0x7e0100 rssi -68
2009-07-08 22:31:53.040784 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -52
2009-07-08 22:31:53.261777 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5C mode 1 clkoffset 0x0095 class 0x7e0100 rssi -69
2009-07-08 22:31:53.271775 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -52
2009-07-08 22:31:53.472768 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -50
2009-07-08 22:31:53.573767 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -52
2009-07-08 22:31:53.624775 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -50
2009-07-08 22:31:53.654760 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -52
2009-07-08 22:31:53.721757 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5D mode 1 clkoffset 0x0e72 class 0x5a210c rssi -69
2009-07-08 22:31:53.835754 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -49
2009-07-08 22:31:53.925749 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -51
2009-07-08 22:31:54.012745 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5D mode 1 clkoffset 0x0e72 class 0x5a210c rssi -74
2009-07-08 22:31:54.136740 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -51
2009-07-08 22:31:54.163741 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5D mode 1 clkoffset 0x0e72 class 0x5a210c rssi -67
2009-07-08 22:31:54.247733 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -49
2009-07-08 22:31:54.308732 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -50
2009-07-08 22:31:54.339732 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -48
2009-07-08 22:31:54.359734 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -50
2009-07-08 22:31:54.530723 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -49
2009-07-08 22:31:55.304691 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c2 class 0x240404 rssi -48
2009-07-08 22:31:55.884666 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5C mode 1 clkoffset 0x0096 class 0x7e0100 rssi -69
2009-07-08 22:31:55.895667 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c2 class 0x240404 rssi -49
2009-07-08 22:31:56.074667 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5C mode 1 clkoffset 0x0095 class 0x7e0100 rssi -69
2009-07-08 22:31:56.335649 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5C mode 1 clkoffset 0x0095 class 0x7e0100 rssi -66
2009-07-08 22:31:56.476641 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c3 class 0x240404 rssi -46
2009-07-08 22:31:56.746621 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c2 class 0x240404 rssi -49
2009-07-08 22:31:56.776628 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5C mode 1 clkoffset 0x0095 class 0x7e0100 rssi -67
2009-07-08 22:31:56.917659 < HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:72:16:12 ptype 0xcc18 rswitch 0x01 clkoffset 0x55c2 (valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2009-07-08 22:31:56.919590 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2009-07-08 22:31:57.018625 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5C mode 1 clkoffset 0x0096 class 0x7e0100 rssi -69
2009-07-08 22:31:57.088615 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c2 class 0x240404 rssi -51
2009-07-08 22:31:57.279610 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c3 class 0x240404 rssi -47
2009-07-08 22:31:57.298605 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5C mode 1 clkoffset 0x0095 class 0x7e0100 rssi -66
2009-07-08 22:31:57.383605 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -48
2009-07-08 22:31:57.439602 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:5C mode 1 clkoffset 0x0095 class 0x7e0100 rssi -67
2009-07-08 22:31:57.493598 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -49
2009-07-08 22:31:57.714580 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:03:7F:42:02:B7 mode 1 clkoffset 0x0b47 class 0x12210c rssi -48
2009-07-08 22:31:57.779555 > HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:13:17:72:16:12 mode 1 clkoffset 0x55c2 class 0x240404 rssi -49
2009-07-08 22:31:57.781560 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
2009-07-08 22:31:57.786682 < HCI Command: Exit Periodic Inquiry Mode (0x01|0x0004) plen 0
2009-07-08 22:31:57.788554 > HCI Event: Command Complete (0x0e) plen 4
    Exit Periodic Inquiry Mode (0x01|0x0004) ncmd 1
    status 0x00
2009-07-08 22:32:00.337487 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 00:13:17:72:16:12 type ACL encrypt 0x00
2009-07-08 22:32:00.337566 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 11
2009-07-08 22:32:00.339444 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2009-07-08 22:32:00.340482 > HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 11
    Features: 0xbf 0xfe 0x8b 0x78 0x18 0x18 0x00 0x80
2009-07-08 22:32:00.344739 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:13:17:72:16:12 mode 2 clkoffset 0x0000
2009-07-08 22:32:00.346481 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2009-07-08 22:32:00.346555 < HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 11
2009-07-08 22:32:00.348481 > HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
2009-07-08 22:32:00.349476 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:13:17:72:16:12
2009-07-08 22:32:00.349764 < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:13:17:72:16:12
2009-07-08 22:32:00.351474 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:13:17:72:16:12
2009-07-08 22:32:00.352482 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:13:17:72:16:12
2009-07-08 22:32:00.357771 < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:13:17:72:16:12 len 4 pin '0000'
2009-07-08 22:32:00.366480 > HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:13:17:72:16:12
2009-07-08 22:32:00.388485 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:13:17:72:16:12 mode 1
2009-07-08 22:32:00.389476 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 11 slots 5
2009-07-08 22:32:00.459471 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:13:17:72:16:12 name 'Jabra BT620s'
2009-07-08 22:32:00.652465 > HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:13:17:72:16:12 key ACE21174E8468A110F4730CB5BE4E729 type 0
    Type: Combination Key
2009-07-08 22:32:00.653429 > HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 11
2009-07-08 22:32:00.655567 < ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2009-07-08 22:32:00.696473 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
2009-07-08 22:32:00.696545 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
2009-07-08 22:32:00.700465 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:00.710464 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006a scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
2009-07-08 22:32:00.747463 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006a scid 0x0040 result 0 status 0
      Connection successful
2009-07-08 22:32:00.747516 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x006a flags 0x00 clen 0
2009-07-08 22:32:00.788461 > ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
2009-07-08 22:32:00.790459 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
2009-07-08 22:32:00.790517 < ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x006a flags 0x00 result 0 clen 4
      MTU 48
2009-07-08 22:32:00.790610 < ACL data: handle 11 flags 0x02 dlen 24
    L2CAP(d): cid 0x006a len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
2009-07-08 22:32:00.794458 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:00.858472 > ACL data: handle 11 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          count 38
          cont 02 01 15
2009-07-08 22:32:00.858731 < ACL data: handle 11 flags 0x02 dlen 26
    L2CAP(d): cid 0x006a len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 01 15
2009-07-08 22:32:00.863455 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:00.903456 > ACL data: handle 11 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x2b
          count 38
          cont 02 00 EF
2009-07-08 22:32:00.903573 < ACL data: handle 11 flags 0x02 dlen 26
    L2CAP(d): cid 0x006a len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 EF
2009-07-08 22:32:00.949453 > ACL data: handle 11 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x2b
          count 38
          cont 02 00 C9
2009-07-08 22:32:00.949568 < ACL data: handle 11 flags 0x02 dlen 26
    L2CAP(d): cid 0x006a len 22 [psm 1]
        SDP SSA Req: tid 0x3 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 C9
2009-07-08 22:32:00.953453 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:00.995435 > ACL data: handle 11 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x3 len 0x2b
          count 38
          cont 02 00 A3
2009-07-08 22:32:00.995549 < ACL data: handle 11 flags 0x02 dlen 26
    L2CAP(d): cid 0x006a len 22 [psm 1]
        SDP SSA Req: tid 0x4 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 A3
2009-07-08 22:32:01.042453 > ACL data: handle 11 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x4 len 0x2b
          count 38
          cont 02 00 7D
2009-07-08 22:32:01.042615 < ACL data: handle 11 flags 0x02 dlen 26
    L2CAP(d): cid 0x006a len 22 [psm 1]
        SDP SSA Req: tid 0x5 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 7D
2009-07-08 22:32:01.046448 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:01.059449 > ACL data: handle 11 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x5 len 0x2b
          count 38
          cont 02 00 57
2009-07-08 22:32:01.059565 < ACL data: handle 11 flags 0x02 dlen 26
    L2CAP(d): cid 0x006a len 22 [psm 1]
        SDP SSA Req: tid 0x6 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 57
2009-07-08 22:32:01.088448 > ACL data: handle 11 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x6 len 0x2b
          count 38
          cont 02 00 31
2009-07-08 22:32:01.088563 < ACL data: handle 11 flags 0x02 dlen 26
    L2CAP(d): cid 0x006a len 22 [psm 1]
        SDP SSA Req: tid 0x7 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 31
2009-07-08 22:32:01.093448 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:01.106446 > ACL data: handle 11 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x7 len 0x2b
          count 38
          cont 02 00 0B
2009-07-08 22:32:01.106559 < ACL data: handle 11 flags 0x02 dlen 26
    L2CAP(d): cid 0x006a len 22 [psm 1]
        SDP SSA Req: tid 0x8 len 0x11
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 0B
2009-07-08 22:32:01.134446 > ACL data: handle 11 flags 0x02 dlen 23
    L2CAP(d): cid 0x0040 len 19 [psm 1]
        SDP SSA Rsp: tid 0x8 len 0xe
          count 11
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110e (AVRemote) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                 uuid-16 0x0017 (AVCTP) uint 0x100 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x100 > >
              aid 0x0311 (SuppFeatures)
                 uint 0x1
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x110b (AudioSink) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x19 > <
                 uuid-16 0x0019 (AVDTP) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Stereo-headset"
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110d (AdvAudio) uint 0x100 > >
              aid 0x0311 (SuppFeatures)
                 uint 0x1
          record #2
              aid 0x0000 (SrvRecHndl)
                 uint 0x10010
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
                 str "Headset"
              aid 0x0302 (unknown)
                 bool 0x1
          record #3
              aid 0x0000 (SrvRecHndl)
                 uint 0x10011
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x111e (Handsfree) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x2 > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x111e (Handsfree) uint 0x101 > >
              aid 0x0100 (SrvName)
                 str "Hands-Free unit"
              aid 0x0311 (SuppFeatures)
                 uint 0x1b
          cont 00
2009-07-08 22:32:01.135566 < ACL data: handle 11 flags 0x02 dlen 24
    L2CAP(d): cid 0x006a len 20 [psm 1]
        SDP SSA Req: tid 0x9 len 0xf
          pat uuid-16 0x1200 (PNPInfo)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
2009-07-08 22:32:01.140445 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:01.180444 > ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x9 len 0x5
          count 2
          cont 00
2009-07-08 22:32:03.002371 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x006a scid 0x0040
2009-07-08 22:32:03.014364 > ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x006a scid 0x0040
2009-07-08 22:32:03.142365 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
2009-07-08 22:32:05.012049 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 11 reason 0x13
    Reason: Remote User Terminated Connection
2009-07-08 22:32:05.014281 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2009-07-08 22:32:05.180273 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x16
    Reason: Connection Terminated by Local Host
2009-07-08 22:32:05.748867 < HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:13:17:72:16:12 ptype 0xcc18 rswitch 0x01 clkoffset 0x55c2 (valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2009-07-08 22:32:05.751251 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2009-07-08 22:32:08.011161 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 00:13:17:72:16:12 type ACL encrypt 0x00
2009-07-08 22:32:08.011240 < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 11
2009-07-08 22:32:08.013153 > HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2009-07-08 22:32:08.014121 > HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 11
    Features: 0xbf 0xfe 0x8b 0x78 0x18 0x18 0x00 0x80
2009-07-08 22:32:08.014191 < ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
2009-07-08 22:32:08.016977 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:13:17:72:16:12 mode 2 clkoffset 0x0000
2009-07-08 22:32:08.019164 > HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2009-07-08 22:32:08.037124 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:13:17:72:16:12 mode 1
2009-07-08 22:32:08.039120 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 11 slots 5
2009-07-08 22:32:08.114165 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
2009-07-08 22:32:08.114229 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040
2009-07-08 22:32:08.128132 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006b scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
2009-07-08 22:32:08.130147 > HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:13:17:72:16:12 name 'Jabra BT620s'
2009-07-08 22:32:08.131149 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:08.202147 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:13:17:72:16:12
2009-07-08 22:32:08.202426 < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:13:17:72:16:12 key ACE21174E8468A110F4730CB5BE4E729
2009-07-08 22:32:08.211146 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:13:17:72:16:12
2009-07-08 22:32:08.464137 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006b scid 0x0040 result 0 status 0
      Connection successful
2009-07-08 22:32:08.464195 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x006b flags 0x00 clen 0
2009-07-08 22:32:08.504135 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 895
2009-07-08 22:32:08.504187 < ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x006b flags 0x00 result 0 clen 4
      MTU 895
2009-07-08 22:32:08.508134 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:08.598129 > ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
2009-07-08 22:32:08.598357 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 23 scid 0x0041
2009-07-08 22:32:08.598383 < ACL data: handle 11 flags 0x02 dlen 6
    L2CAP(d): cid 0x006b len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 0
2009-07-08 22:32:08.603127 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:08.609148 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006c scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
2009-07-08 22:32:09.038113 > ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 25]
      AVDTP(s): Discover rsp: transaction 0
        ACP SEID 1 - Audio Sink
        ACP SEID 6 - Audio Sink
2009-07-08 22:32:09.038402 < ACL data: handle 11 flags 0x02 dlen 7
    L2CAP(d): cid 0x006b len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 1
        ACP SEID 1
2009-07-08 22:32:09.251104 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 1
        Media Transport
        Media Codec - SBC
          16kHz 32kHz 44.1kHz 48kHz
          Mono DualChannel Stereo JointStereo
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness
          Bitpool Range 2-50
2009-07-08 22:32:09.251317 < ACL data: handle 11 flags 0x02 dlen 7
    L2CAP(d): cid 0x006b len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 2
        ACP SEID 6
2009-07-08 22:32:09.255100 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:09.397098 > ACL data: handle 11 flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 2
        Media Transport
        Media Codec - SBC
          16kHz 32kHz 44.1kHz 48kHz
          Mono DualChannel Stereo JointStereo
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness
          Bitpool Range 2-50
        Content Protection
          02 00
2009-07-08 22:32:09.397439 < ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x006b len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 3
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          44.1kHz
          JointStereo
          16 Blocks
          8 Subbands
          Loudness
          Bitpool Range 2-50
2009-07-08 22:32:09.643087 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
2009-07-08 22:32:09.821078 > ACL data: handle 11 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Set config rsp: transaction 3
2009-07-08 22:32:09.821358 < ACL data: handle 11 flags 0x02 dlen 7
    L2CAP(d): cid 0x006b len 3 [psm 25]
      AVDTP(s): Open cmd: transaction 4
        ACP SEID 1
2009-07-08 22:32:09.930074 > ACL data: handle 11 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Open rsp: transaction 4
2009-07-08 22:32:09.930334 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0042
2009-07-08 22:32:09.934071 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:09.945074 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006d scid 0x0042 result 1 status 2
      Connection pending - Authorization pending
2009-07-08 22:32:10.329056 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006c scid 0x0041 result 0 status 0
      Connection successful
2009-07-08 22:32:10.329109 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x006c flags 0x00 clen 0
2009-07-08 22:32:10.345055 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 895
2009-07-08 22:32:10.345108 < ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x006c flags 0x00 result 0 clen 4
      MTU 895
2009-07-08 22:32:10.351055 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:10.450051 > ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
2009-07-08 22:32:11.083031 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x006d scid 0x0042 result 0 status 0
      Connection successful
2009-07-08 22:32:11.083100 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x006d flags 0x00 clen 0
2009-07-08 22:32:11.123022 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
      MTU 895
2009-07-08 22:32:11.123074 < ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x006d flags 0x00 result 0 clen 4
      MTU 895
2009-07-08 22:32:11.127021 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
2009-07-08 22:32:11.304015 > ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
      Success
2009-07-08 22:32:11.960998 > HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:13:17:72:16:12 role 0x01
    Role: Slave
2009-07-08 22:32:16.304812 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 11 slots 1
2009-07-08 22:32:16.308813 > HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 11 mode 0x02 interval 2048
    Mode: Sniff
