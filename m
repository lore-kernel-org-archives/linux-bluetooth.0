Return-Path: <cyrus@holtmann.org>
Message-ID: <48E2A0A3.1010607@pook.es>
Date: Tue, 30 Sep 2008 23:56:51 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
CC: linux-bluetooth@vger.kernel.org, bugme-daemon@bugzilla.kernel.org
Subject: Re: [Bugme-new] [Bug 11514] New: bluetooth headset works with 2.6.26,
 only hisses with 2.6.27-rc5
References: <bug-11514-10286@http.bugzilla.kernel.org/> <20080907040134.732f925c.akpm@linux-foundation.org>
In-Reply-To: <20080907040134.732f925c.akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/09/08 13:01, Andrew Morton wrote:
>> Latest working kernel version: 2.6.26-1-686 (Debian)
>> Earliest failing kernel version: 2.6.27-rc5 (vanilla)
> A post-2.6.26 regression.

I just installed bluez-4.9 and linux 2.6.27-rc8 hoping that my
Jabra JX10 bluetooth headset would start working. Still no luck.
Bluetoothd says "connect: Operation not permitted (1)" and
aplay "BT_SETCONFIGURATION failed".

I also downloaded the 2.6.26-mh6 patches from
http://www.bluez.org/more-usb-driver-fixes-and-quirks/ and recompiled
another kernel. The kernel crashed twice (I only booted it twice)
rather quickly. I did get time to run aplay once and it gave the same
errors as shown here. The hcidump is almost exactly the same.

The Jabra JX10 "features Bluetooth 2.0 and e-SCO for improved
audio quality and MultiPoint capability for connecting to 2 devices
at once" and I am using an old Bluetooth 1.2 Linksys USBBT100
USB dongle. Could that be what is causing the problem?

I ran strace on bluetoothd and it appears that it is
"bind(25, {sa_family=AF_BLUETOOTH, sa_data="0\377\341A\f\0\310\261\v\270H\225d\271"...}, 8)"
that is returning -1 with errno set to EADDRINUSE

Bluetoothd says:

bluetoothd: Accepted new client connection on unix socket (fd=23)
bluetoothd: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd: kernel auth requirements = 0x04
bluetoothd: stored link key type = 0x00
bluetoothd: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd: Received AT+BRSF=27
bluetoothd: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
bluetoothd: Received AT+CIND=?
bluetoothd: Received AT+CIND?
bluetoothd: Received AT+CMER=3, 0, 0, 1
bluetoothd: Event reporting (CMER): mode=3, ind=1
bluetoothd: HFP Service Level Connection established
bluetoothd: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd: connect: Operation not permitted (1)
bluetoothd: config failed
bluetoothd: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd: Unix client disconnected (fd=23)
bluetoothd: Received AT+VGS=00

% aplay -D JX10 lib/alarm.wav
Playing WAVE 'lib/alarm.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:464:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION failed : Input/output error(5)
aplay: set_params:979: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 2000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 8000
TICK_TIME: [0 0]

# hciconfig hci0 revision
hci0:    Type: USB
     BD Address: 00:0C:41:E1:FF:30 ACL MTU: 192:8 SCO MTU: 64:8
     HCI 16.4
     Chip version: BlueCore02-External
     Max key size: 56 bit
     SCO mapping:  HCI
# hciconfig hci0 version
hci0:    Type: USB
     BD Address: 00:0C:41:E1:FF:30 ACL MTU: 192:8 SCO MTU: 64:8
     HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
     Manufacturer: Cambridge Silicon Radio (10)

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:1A:45:2F:49:98 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 41 bdaddr 00:1A:45:2F:49:98 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 41
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
     bdaddr 00:1A:45:2F:49:98 mode 1
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 41 slots 5
 > HCI Event: Command Status (0x0f) plen 4
     Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:1A:45:2F:49:98 mode 2 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 41
     Features: 0xbf 0xfe 0x8b 0xf8 0x1b 0x18 0x00 0x80
< ACL data: handle 41 flags 0x02 dlen 10
     L2CAP(s): Info req: type 2
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Info rsp: type 2 result 0
       Extended feature mask 0x0000
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0058 scid 0x0040 result 1 status 2
       Connection pending - Authorization pending
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:1A:45:2F:49:98 name 'Jabra JX10 series 2'
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:1A:45:2F:49:98
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:1A:45:2F:49:98 key F63331CE2D0DBCA190DC73C930CD6117
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:1A:45:2F:49:98
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0058 scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0058 flags 0x00 clen 4
       MTU 1013
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
 > ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
       MTU 1013
< ACL data: handle 41 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0058 flags 0x00 result 0 clen 4
       MTU 1013
< ACL data: handle 41 flags 0x02 dlen 8
     L2CAP(d): cid 0x0058 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 41 flags 0x02 dlen 18
     L2CAP(d): cid 0x0058 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1008 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
       frame_size 127 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
     L2CAP(d): cid 0x0058 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(d): cid 0x0058 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
 > ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(d): cid 0x0058 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 9
     L2CAP(d): cid 0x0058 len 5 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
 > ACL data: handle 41 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 11 fcs 0x40
       0000: 41 54 2b 42 52 53 46 3d  32 37 0d                 AT+BRSF=27.
< ACL data: handle 41 flags 0x02 dlen 19
     L2CAP(d): cid 0x0058 len 15 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 11 fcs 0x9a
       0000: 0d 0a 2b 42 52 53 46 3d  30 0d 0a                 ..+BRSF=0..
< ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(d): cid 0x0058 len 10 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 2
       0000: 41 54 2b 43 49 4e 44 3d  3f 0d                    AT+CIND=?.
< ACL data: handle 41 flags 0x02 dlen 135
     L2CAP(d): cid 0x0058 len 131 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 127 fcs 0x9a
       0000: 0d 0a 2b 43 49 4e 44 3a  28 22 62 61 74 74 63 68  ..+CIND:("battch
       0010: 67 22 2c 28 30 2d 35 29  29 2c 28 22 73 69 67 6e  g",(0-5)),("sign
       0020: 61 6c 22 2c 28 30 2d 35  29 29 2c 28 22 73 65 72  al",(0-5)),("ser
       0030: 76 69 63 65 22 2c 28 30  2c 31 29 29 2c 28 22 63  vice",(0,1)),("c
       0040: 61 6c 6c 22 2c 28 30 2c  31 29 29 2c 28 22 63 61  all",(0,1)),("ca
       0050: 6c 6c 73 65 74 75 70 22  2c 28 30 2d 33 29 29 2c  llsetup",(0-3)),
       0060: 28 22 63 61 6c 6c 68 65  6c 64 22 2c 28 30 2d 32  ("callheld",(0-2
       0070: 29 29 2c 28 22 72 6f 61  6d 22 2c 28 30 2c 31     )),("roam",(0,1
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(d): cid 0x0058 len 8 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 4 fcs 0x9a
       0000: 29 29 0d 0a                                       ))..
< ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(d): cid 0x0058 len 10 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 9 fcs 0x5c credits 3
       0000: 41 54 2b 43 49 4e 44 3f  0d                       AT+CIND?.
< ACL data: handle 41 flags 0x02 dlen 31
     L2CAP(d): cid 0x0058 len 27 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 23 fcs 0x9a
       0000: 0d 0a 2b 43 49 4e 44 3a  35 2c 35 2c 31 2c 30 2c  ..+CIND:5,5,1,0,
       0010: 30 2c 30 2c 30 0d 0a                              0,0,0..
< ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(d): cid 0x0058 len 10 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 28
     L2CAP(d): cid 0x0040 len 24 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 19 fcs 0x5c credits 2
       0000: 41 54 2b 43 4d 45 52 3d  33 2c 20 30 2c 20 30 2c  AT+CMER=3, 0, 0,
       0010: 20 31 0d                                           1.
< ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(d): cid 0x0058 len 10 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 1
       0000: 41 54 2b 56 47 53 3d 30  30 0d                    AT+VGS=00.
< ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(d): cid 0x0058 len 10 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
