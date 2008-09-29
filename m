Return-Path: <cyrus@holtmann.org>
Message-ID: <48E14B81.5020206@pook.es>
Date: Mon, 29 Sep 2008 23:41:21 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
CC: martin f krafft <madduck@madduck.net>
Subject: SCO headset, bluez-4.9 & linux 2.6.27-rc7 -> Unable to install hw
 params
References: <20080822073628.GA5989@piper.oerlikon.madduck.net> <1219394015.7591.441.camel@violet.holtmann.net> <20080826163544.GA5068@lapse.rw.madduck.net> <8C64B784-7758-40B0-AE1B-C15F475693D4@holtmann.org> <20080905162654.GA17843@lapse.rw.madduck.net> <1220634042.6714.89.camel@californication> <20080923130000.GA848@piper.oerlikon.madduck.net>
In-Reply-To: <20080923130000.GA848@piper.oerlikon.madduck.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I've installed bluez 4.9 and linux kernel 2.6.27-rc7 and I still cannot get any
sound out of my Jabra JX10 bluetooth headset connected via a Cambridge Silicon
Radio Bluetooth Dongle (0a12:0001). Bluetoothd says "connect: Operation
not permitted" and aplay "Unable to install hw params".

What should I try next? I think that I'm missing something stupid.

thanks for any help (or requests for more information)

Stuart

PS BTW, if use bluez 4.4 & linux 2.6.26, aplay works, if I use bluez 4.7 and
linux 2.6.26, aplay fails.

Bluetoothd says

bluetoothd[24162]: Accepted new client connection on unix socket (fd=23)
bluetoothd[24162]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[24162]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[24162]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[24162]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[24162]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[24162]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[24162]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[24162]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[24162]: kernel auth requirements = 0x04
bluetoothd[24162]: stored link key type = 0x00
bluetoothd[24162]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[24162]: Received AT+BRSF=27
bluetoothd[24162]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
bluetoothd[24162]: Received AT+CIND=?
bluetoothd[24162]: Received AT+CIND?
bluetoothd[24162]: Received AT+CMER=3, 0, 0, 1
bluetoothd[24162]: Event reporting (CMER): mode=3, ind=1
bluetoothd[24162]: HFP Service Level Connection established
bluetoothd[24162]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[24162]: connect: Operation not permitted (1)
bluetoothd[24162]: config failed
bluetoothd[24162]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[24162]: Unix client disconnected (fd=23)
bluetoothd[24162]: Received AT+VGS=00

aplay says:

Playing WAVE 'alarm.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:464:(bluetooth_hsp_hw_params) BT_SETCONFIGURATION failed : Input/output error(5)
aplay: set_params:979: Unable to install hw params:

The second time I run aplay the error messages arrives more quickly:

bluetoothd[24162]: Accepted new client connection on unix socket (fd=23)
bluetoothd[24162]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[24162]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[24162]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[24162]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[24162]: connect: Operation not permitted (1)
bluetoothd[24162]: config failed
bluetoothd[24162]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[24162]: Unix client disconnected (fd=23)

hcidump -XV doesn't show anything that looks like an error to me:

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
     L2CAP(s): Connect rsp: dcid 0x008c scid 0x0040 result 1 status 2
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
     L2CAP(s): Connect rsp: dcid 0x008c scid 0x0040 result 0 status 0
       Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x008c flags 0x00 clen 4
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
     L2CAP(s): Config rsp: scid 0x008c flags 0x00 result 0 clen 4
       MTU 1013
< ACL data: handle 41 flags 0x02 dlen 8
     L2CAP(d): cid 0x008c len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 41 flags 0x02 dlen 18
     L2CAP(d): cid 0x008c len 14 [psm 3]
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
     L2CAP(d): cid 0x008c len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(d): cid 0x008c len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
 > ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 3]
       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
       dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(d): cid 0x008c len 8 [psm 3]
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
     L2CAP(d): cid 0x008c len 5 [psm 3]
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
     L2CAP(d): cid 0x008c len 15 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 11 fcs 0x9a
       0000: 0d 0a 2b 42 52 53 46 3d  30 0d 0a                 ..+BRSF=0..
< ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(d): cid 0x008c len 10 [psm 3]
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
     L2CAP(d): cid 0x008c len 131 [psm 3]
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
     L2CAP(d): cid 0x008c len 8 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 4 fcs 0x9a
       0000: 29 29 0d 0a                                       ))..
< ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(d): cid 0x008c len 10 [psm 3]
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
     L2CAP(d): cid 0x008c len 27 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 23 fcs 0x9a
       0000: 0d 0a 2b 43 49 4e 44 3a  35 2c 35 2c 31 2c 30 2c  ..+CIND:5,5,1,0,
       0010: 30 2c 30 2c 30 0d 0a                              0,0,0..
< ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(d): cid 0x008c len 10 [psm 3]
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
     L2CAP(d): cid 0x008c len 10 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1
 > ACL data: handle 41 flags 0x02 dlen 19
     L2CAP(d): cid 0x0040 len 15 [psm 3]
       RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 1
       0000: 41 54 2b 56 47 53 3d 30  30 0d                    AT+VGS=00.
< ACL data: handle 41 flags 0x02 dlen 14
     L2CAP(d): cid 0x008c len 10 [psm 3]
       RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
       0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41 packets 1

