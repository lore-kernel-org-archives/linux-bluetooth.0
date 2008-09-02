Return-Path: <cyrus@holtmann.org>
Message-ID: <48BD97A8.1010201@pook.es>
Date: Tue, 02 Sep 2008 21:44:40 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluez 4.2 + linux 2.6.27-rc5 -> no audio interface
References: <48BC6CEC.8040602@pook.es>
In-Reply-To: <48BC6CEC.8040602@pook.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I reinstalled bluez-4.2 (without recompiling) and now I get a little 
further. I still cannot hear any music on my Jabra JX10 but I have a 
"Headset service on RFCOMM channel 2".  When I try aplay I get 
"unix_sendmsg_fd: Bad file descriptor(9)" and "resume failed" or 
"connect(): Connection timed out (110)" and "Unable to lock headset". 
After arecord I get "unix_sendmsg_fd: Bad file descriptor(9)" and 
"resume failed" after a 40 second timeout.

What do these messages mean?

When I run aplay and arecord, the headset beeps. When the connection is 
underway, I can press the headset's buttons and bluetoothd writes out a 
message "Received AT+CKPD=200".

thanks for your time!
Stuart

These are the messages written to /var/log/daemon.log. I used logger(1) 
to insert into the log the aplay & arecord commands I executed.


Sep  2 21:20:15 kooka bluetoothd[23192]: Bluetooth daemon
Sep  2 21:20:15 kooka bluetoothd[23192]: Enabling debug information
Sep  2 21:20:15 kooka bluetoothd[23192]: parsing main.conf
Sep  2 21:20:15 kooka bluetoothd[23192]: offmode=NoScan
Sep  2 21:20:15 kooka bluetoothd[23192]: discovto=0
Sep  2 21:20:15 kooka bluetoothd[23192]: pageto=8192
Sep  2 21:20:15 kooka bluetoothd[23192]: name=%h-%d
Sep  2 21:20:15 kooka bluetoothd[23192]: class=0x000100
Sep  2 21:20:15 kooka bluetoothd[23192]: Starting SDP server
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding rec : 0xb8ba9a98
Sep  2 21:20:15 kooka bluetoothd[23192]: with handle : 0x1
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding rec : 0xb8baba80
Sep  2 21:20:15 kooka bluetoothd[23192]: with handle : 0x0
Sep  2 21:20:15 kooka bluetoothd[23192]: Service classes 0x00
Sep  2 21:20:15 kooka bluetoothd[23192]: Loading plugins 
/usr/local/lib/bluetooth/plugins
Sep  2 21:20:15 kooka bluetoothd[23192]: 
/usr/local/lib/bluetooth/plugins/audio.so
Sep  2 21:20:15 kooka bluetoothd[23192]: Unix socket created: 11
Sep  2 21:20:15 kooka bluetoothd[23192]: 
/usr/local/lib/bluetooth/plugins/serial.so
Sep  2 21:20:15 kooka bluetoothd[23192]: 
/usr/local/lib/bluetooth/plugins/network.so
Sep  2 21:20:15 kooka bluetoothd[23192]: Parsing 
/etc/bluetooth/network.conf failed: No such file or directory
Sep  2 21:20:15 kooka bluetoothd[23192]: Config options: 
InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), 
NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
Sep  2 21:20:15 kooka bluetoothd[23192]: bridge pan0 created
Sep  2 21:20:15 kooka bluetoothd[23192]: 
/usr/local/lib/bluetooth/plugins/input.so
Sep  2 21:20:15 kooka bluetoothd[23192]: input.conf: Key file does not 
have key 'IdleTimeout'
Sep  2 21:20:15 kooka bluetoothd[23192]: HCI dev 0 registered
Sep  2 21:20:15 kooka bluetoothd[23192]: child 23194 exited
Sep  2 21:20:15 kooka bluetoothd[23192]: HCI dev 0 up
Sep  2 21:20:15 kooka bluetoothd[23192]: headset_server_probe: path 
/org/bluez/hci0
Sep  2 21:20:15 kooka bluetoothd[23192]: Couldn't find record for : 0x10000
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding record with handle 0x10000
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding rec : 0xb8bae760
Sep  2 21:20:15 kooka bluetoothd[23192]: with handle : 0x10000
Sep  2 21:20:15 kooka bluetoothd[23192]: Service classes 0x00
Sep  2 21:20:15 kooka bluetoothd[23192]: a2dp_server_probe: path 
/org/bluez/hci0
Sep  2 21:20:15 kooka bluetoothd[23192]: SEP 0xb8bac3d8 registered: 
type:0 codec:0 seid:1
Sep  2 21:20:15 kooka bluetoothd[23192]: Couldn't find record for : 0x10001
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding record with handle 0x10001
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding rec : 0xb8bac8a0
Sep  2 21:20:15 kooka bluetoothd[23192]: with handle : 0x10001
Sep  2 21:20:15 kooka bluetoothd[23192]: Service classes 0x08
Sep  2 21:20:15 kooka bluetoothd[23192]: avrcp_server_probe: path 
/org/bluez/hci0
Sep  2 21:20:15 kooka bluetoothd[23192]: Couldn't find record for : 0x10002
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding record with handle 0x10002
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding rec : 0xb8bac5e0
Sep  2 21:20:15 kooka bluetoothd[23192]: with handle : 0x10002
Sep  2 21:20:15 kooka bluetoothd[23192]: Service classes 0x08
Sep  2 21:20:15 kooka bluetoothd[23192]: Couldn't find record for : 0x10003
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding record with handle 0x10003
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding rec : 0xb8bacd58
Sep  2 21:20:15 kooka bluetoothd[23192]: with handle : 0x10003
Sep  2 21:20:15 kooka bluetoothd[23192]: Service classes 0x08
Sep  2 21:20:15 kooka bluetoothd[23192]: proxy_probe: path /org/bluez/hci0
Sep  2 21:20:15 kooka bluetoothd[23192]: Registered interface 
org.bluez.serial.ProxyManager on path /org/bluez/hci0
Sep  2 21:20:15 kooka bluetoothd[23192]: network_server_probe: path 
/org/bluez/hci0
Sep  2 21:20:15 kooka bluetoothd[23192]: Couldn't find record for : 0x10004
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding record with handle 0x10004
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding rec : 0xb8baf5c0
Sep  2 21:20:15 kooka bluetoothd[23192]: with handle : 0x10004
Sep  2 21:20:15 kooka bluetoothd[23192]: Service classes 0x0a
Sep  2 21:20:15 kooka bluetoothd[23192]: register_server_record: got 
record id 0x10004
Sep  2 21:20:15 kooka bluetoothd[23192]: Registered interface 
org.bluez.network.Peer on path /org/bluez/hci0
Sep  2 21:20:15 kooka bluetoothd[23192]: network_server_probe: path 
/org/bluez/hci0
Sep  2 21:20:15 kooka bluetoothd[23192]: Couldn't find record for : 0x10005
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding record with handle 0x10005
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding rec : 0xb8bafbe8
Sep  2 21:20:15 kooka bluetoothd[23192]: with handle : 0x10005
Sep  2 21:20:15 kooka bluetoothd[23192]: Service classes 0x0a
Sep  2 21:20:15 kooka bluetoothd[23192]: register_server_record: got 
record id 0x10005
Sep  2 21:20:15 kooka bluetoothd[23192]: Registered interface 
org.bluez.network.Hub on path /org/bluez/hci0
Sep  2 21:20:15 kooka bluetoothd[23192]: network_server_probe: path 
/org/bluez/hci0
Sep  2 21:20:15 kooka bluetoothd[23192]: Couldn't find record for : 0x10006
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding record with handle 0x10006
Sep  2 21:20:15 kooka bluetoothd[23192]: Adding rec : 0xb8bb0210
Sep  2 21:20:15 kooka bluetoothd[23192]: with handle : 0x10006
Sep  2 21:20:15 kooka bluetoothd[23192]: Service classes 0x0a
Sep  2 21:20:15 kooka bluetoothd[23192]: register_server_record: got 
record id 0x10006
Sep  2 21:20:15 kooka bluetoothd[23192]: Registered interface 
org.bluez.network.Router on path /org/bluez/hci0
Sep  2 21:20:15 kooka bluetoothd[23192]: Creating device 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx
Sep  2 21:20:15 kooka bluetoothd[23192]: Probe drivers for 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx
Sep  2 21:20:15 kooka bluetoothd[23192]: Found Headset record
Sep  2 21:20:15 kooka bluetoothd[23192]: Discovered Headset service on 
RFCOMM channel 2
Sep  2 21:20:15 kooka bluetoothd[23192]: Registered interface 
org.bluez.audio.Headset on path /org/bluez/hci0/dev_00_1A_45_2F_xx_xx
Sep  2 21:20:15 kooka bluetoothd[23192]: headset_probe: path 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx
Sep  2 21:20:15 kooka bluetoothd[23192]: Registered interface 
org.bluez.input.Device on path /org/bluez/hci0/dev_00_1A_45_2F_xx_xx
Sep  2 21:20:15 kooka bluetoothd[23192]: Creating device 
/org/bluez/hci0/dev_00_14_A7_74_D3_AF
Sep  2 21:20:15 kooka bluetoothd[23192]: Creating device 
/org/bluez/hci0/dev_00_03_89_B7_F8_D3
Sep  2 21:20:15 kooka bluetoothd[23192]: Creating device 
/org/bluez/hci0/dev_00_0A_94_94_4F_B3
Sep  2 21:20:15 kooka bluetoothd[23192]: Creating device 
/org/bluez/hci0/dev_00_03_89_DC_5C_9F
Sep  2 21:20:15 kooka bluetoothd[23192]: Creating device 
/org/bluez/hci0/dev_00_03_89_DC_FC_EC
Sep  2 21:20:15 kooka bluetoothd[23192]: Creating device 
/org/bluez/hci0/dev_00_03_89_FE_E6_19
Sep  2 21:20:15 kooka bluetoothd[23192]: Creating device 
/org/bluez/hci0/dev_00_0E_6D_8F_91_6A
Sep  2 21:20:15 kooka bluetoothd[23192]: Creating device 
/org/bluez/hci0/dev_00_17_E5_E6_25_AB
Sep  2 21:20:15 kooka bluetoothd[23192]: Creating device 
/org/bluez/hci0/dev_00_17_E5_16_88_6C
Sep  2 21:20:15 kooka bluetoothd[23192]: Creating device 
/org/bluez/hci0/dev_00_17_E5_0C_EA_70
Sep  2 21:20:15 kooka bluetoothd[23192]: Adapter /org/bluez/hci0 has 
been enabled
Sep  2 21:20:15 kooka bluetoothd[23192]: Starting security manager 0
Sep  2 21:20:15 kooka bluetoothd[23192]: child 23199 exited
Sep  2 21:20:36 kooka logger: aplay -D JX10 -f S16_LE /dev/zero
Sep  2 21:20:36 kooka bluetoothd[23192]: Accepted new client connection 
on unix socket (fd=20)
Sep  2 21:20:36 kooka bluetoothd[23192]: Audio API: received 
BT_GETCAPABILITIES_REQ
Sep  2 21:20:36 kooka bluetoothd[23192]: Audio API: sending 
BT_GETCAPABILITIES_RSP
Sep  2 21:20:36 kooka bluetoothd[23192]: Audio API: received 
BT_SETCONFIGURATION_REQ
Sep  2 21:20:36 kooka bluetoothd[23192]: config sco - device = 
00:1A:45:2F:xx:xx access_mode = 2
Sep  2 21:20:36 kooka bluetoothd[23192]: 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: Connecting to 00:1A:45:2F:xx:xx 
channel 2
Sep  2 21:20:36 kooka bluetoothd[23192]: State changed 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: HEADSET_STATE_DISCONNECTED -> 
HEADSET_STATE_CONNECT_IN_PROGRESS
Sep  2 21:20:39 kooka bluetoothd[23192]: link_key_request 
(sba=00:0C:41:E1:xx:xx, dba=00:1A:45:2F:xx:xx)
Sep  2 21:20:39 kooka bluetoothd[23192]: kernel auth requirements = 0x00
Sep  2 21:20:39 kooka bluetoothd[23192]: stored link key type = 0x00
Sep  2 21:20:40 kooka bluetoothd[23192]: 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: Connected to 00:1A:45:2F:xx:xx
Sep  2 21:20:40 kooka bluetoothd[23192]: State changed 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: HEADSET_STATE_CONNECT_IN_PROGRESS 
-> HEADSET_STATE_CONNECTED
Sep  2 21:20:40 kooka bluetoothd[23192]: State changed 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: HEADSET_STATE_CONNECTED -> 
HEADSET_STATE_PLAY_IN_PROGRESS
Sep  2 21:21:20 kooka bluetoothd[23192]: connect(): Connection timed out 
(110)
Sep  2 21:21:20 kooka bluetoothd[23192]: Audio API: sending 
BT_SETCONFIGURATION_RSP
Sep  2 21:21:20 kooka bluetoothd[23192]: State changed 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: HEADSET_STATE_PLAY_IN_PROGRESS -> 
HEADSET_STATE_CONNECTED
Sep  2 21:21:20 kooka bluetoothd[23192]: Audio API: received 
BT_STREAMSTART_REQ
Sep  2 21:21:20 kooka bluetoothd[23192]: Audio API: sending 
BT_STREAMSTART_RSP
Sep  2 21:21:20 kooka bluetoothd[23192]: Audio API: sending BT_STREAMFD_IND
Sep  2 21:21:20 kooka bluetoothd[23192]: unix_sendmsg_fd: Bad file 
descriptor(9)
Sep  2 21:21:20 kooka bluetoothd[23192]: resume failed
Sep  2 21:21:20 kooka bluetoothd[23192]: Audio API: sending 
BT_STREAMSTART_RSP
Sep  2 21:21:20 kooka bluetoothd[23192]: Unix client disconnected (fd=20)
Sep  2 21:21:38 kooka logger: aplay -D JX10 -f S16_LE /dev/zero
Sep  2 21:21:38 kooka bluetoothd[23192]: Accepted new client connection 
on unix socket (fd=20)
Sep  2 21:21:38 kooka bluetoothd[23192]: Audio API: received 
BT_GETCAPABILITIES_REQ
Sep  2 21:21:38 kooka bluetoothd[23192]: Audio API: sending 
BT_GETCAPABILITIES_RSP
Sep  2 21:21:38 kooka bluetoothd[23192]: Audio API: received 
BT_SETCONFIGURATION_REQ
Sep  2 21:21:38 kooka bluetoothd[23192]: config sco - device = 
00:1A:45:2F:xx:xx access_mode = 2
Sep  2 21:21:38 kooka bluetoothd[23192]: State changed 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: HEADSET_STATE_CONNECTED -> 
HEADSET_STATE_PLAY_IN_PROGRESS
Sep  2 21:21:42 kooka bluetoothd[23192]: Received AT+CKPD=200
Sep  2 21:21:45 kooka bluetoothd[23192]: Received AT+VGS=04
Sep  2 21:22:18 kooka bluetoothd[23192]: connect(): Connection timed out 
(110)
Sep  2 21:22:18 kooka bluetoothd[23192]: Unable to lock headset
Sep  2 21:22:18 kooka bluetoothd[23192]: config failed
Sep  2 21:22:18 kooka bluetoothd[23192]: Audio API: sending 
BT_SETCONFIGURATION_RSP
Sep  2 21:22:18 kooka bluetoothd[23192]: State changed 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: HEADSET_STATE_PLAY_IN_PROGRESS -> 
HEADSET_STATE_CONNECTED
Sep  2 21:22:18 kooka bluetoothd[23192]: Unix client disconnected (fd=20)
Sep  2 21:22:23 kooka logger: aplay -D JX10 -f S16_LE /dev/zero
Sep  2 21:22:23 kooka bluetoothd[23192]: Accepted new client connection 
on unix socket (fd=20)
Sep  2 21:22:23 kooka bluetoothd[23192]: Audio API: received 
BT_GETCAPABILITIES_REQ
Sep  2 21:22:23 kooka bluetoothd[23192]: Audio API: sending 
BT_GETCAPABILITIES_RSP
Sep  2 21:22:23 kooka bluetoothd[23192]: Audio API: received 
BT_SETCONFIGURATION_REQ
Sep  2 21:22:23 kooka bluetoothd[23192]: config sco - device = 
00:1A:45:2F:xx:xx access_mode = 2
Sep  2 21:22:23 kooka bluetoothd[23192]: State changed 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: HEADSET_STATE_CONNECTED -> 
HEADSET_STATE_PLAY_IN_PROGRESS
Sep  2 21:23:03 kooka bluetoothd[23192]: connect(): Connection timed out 
(110)
Sep  2 21:23:03 kooka bluetoothd[23192]: Unable to lock headset
Sep  2 21:23:03 kooka bluetoothd[23192]: config failed
Sep  2 21:23:03 kooka bluetoothd[23192]: Audio API: sending 
BT_SETCONFIGURATION_RSP
Sep  2 21:23:03 kooka bluetoothd[23192]: State changed 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: HEADSET_STATE_PLAY_IN_PROGRESS -> 
HEADSET_STATE_CONNECTED
Sep  2 21:23:03 kooka bluetoothd[23192]: Unix client disconnected (fd=20)
Sep  2 21:23:29 kooka logger: arecord -D JX10  -f S16_LE
Sep  2 21:23:29 kooka bluetoothd[23192]: Accepted new client connection 
on unix socket (fd=20)
Sep  2 21:23:29 kooka bluetoothd[23192]: Audio API: received 
BT_GETCAPABILITIES_REQ
Sep  2 21:23:29 kooka bluetoothd[23192]: Audio API: sending 
BT_GETCAPABILITIES_RSP
Sep  2 21:23:29 kooka bluetoothd[23192]: Audio API: received 
BT_SETCONFIGURATION_REQ
Sep  2 21:23:29 kooka bluetoothd[23192]: config sco - device = 
00:1A:45:2F:xx:xx access_mode = 1
Sep  2 21:23:29 kooka bluetoothd[23192]: State changed 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: HEADSET_STATE_CONNECTED -> 
HEADSET_STATE_PLAY_IN_PROGRESS
Sep  2 21:24:09 kooka bluetoothd[23192]: connect(): Connection timed out 
(110)
Sep  2 21:24:09 kooka bluetoothd[23192]: Audio API: sending 
BT_SETCONFIGURATION_RSP
Sep  2 21:24:09 kooka bluetoothd[23192]: State changed 
/org/bluez/hci0/dev_00_1A_45_2F_xx_xx: HEADSET_STATE_PLAY_IN_PROGRESS -> 
HEADSET_STATE_CONNECTED
Sep  2 21:24:09 kooka bluetoothd[23192]: Audio API: received 
BT_STREAMSTART_REQ
Sep  2 21:24:09 kooka bluetoothd[23192]: Audio API: sending 
BT_STREAMSTART_RSP
Sep  2 21:24:09 kooka bluetoothd[23192]: Audio API: sending BT_STREAMFD_IND
Sep  2 21:24:09 kooka bluetoothd[23192]: unix_sendmsg_fd: Bad file 
descriptor(9)
Sep  2 21:24:09 kooka bluetoothd[23192]: resume failed
Sep  2 21:24:09 kooka bluetoothd[23192]: Audio API: sending 
BT_STREAMSTART_RSP
Sep  2 21:24:09 kooka bluetoothd[23192]: Unix client disconnected (fd=20)

:; sdptool  records 00:1A:45:2F:xx:xx
Service Name: Hands-Free unit
Service RecHandle: 0x10000
Service Class ID List:
   "Handsfree" (0x111e)
   "Generic Audio" (0x1203)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 1
Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100
Profile Descriptor List:
   "Handsfree" (0x111e)
     Version: 0x0105

Service Name: Headset
Service RecHandle: 0x10001
Service Class ID List:
   "Headset" (0x1108)
   "Generic Audio" (0x1203)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 2
Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100
Profile Descriptor List:
   "Headset" (0x1108)
     Version: 0x0100

:; lsmod | grep usb
usb_storage            77960  1
usbhid                 37924  0
hid                    35660  1 usbhid
ff_memless              6216  1 usbhid
snd_usb_audio          72288  1
snd_usb_lib            15168  1 snd_usb_audio
snd_rawmidi            20512  2 snd_usb_lib,snd_seq_midi
snd_hwdep               8004  1 snd_usb_audio
btusb                  11864  22291
bluetooth              49184  9 sco,bnep,rfcomm,l2cap,btusb
snd_pcm                64708  3 snd_usb_audio,snd_hda_intel
snd                    47480  13 
snd_usb_audio,snd_seq_oss,snd_seq,snd_rawmidi,snd_seq_device,snd_hwdep,snd_mixer_oss,snd_hda_intel,snd_pcm,snd_timer

:; logger -p daemon.info  "arecord -D JX10  -f S16_LE"; arecord -D JX10 
  -f S16_LE
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:464:(bluetooth_hsp_hw_params) 
BT_SETCONFIGURATION failed : Input/output error(5)
arecord: set_params:979: Unable to install hw params:
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
:; logger -p daemon.info  "aplay -D JX10  -f S16_LE /dev/zero";  aplay 
-D JX10  -f S16_LE /dev/zero
Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 8000 
Hz, Mono
ALSA lib pcm_bluetooth.c:464:(bluetooth_hsp_hw_params) 
BT_SETCONFIGURATION failed : Input/output error(5)
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


