Return-Path: <cyrus@holtmann.org>
Message-ID: <49FCAC43.5020502@pook.es>
Date: Sat, 02 May 2009 22:25:39 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluetoothd git version -> aplay: pcm_write:1442: write error:
 Input/output error
References: <49F8638C.5070205@pook.es> <20090429160430.GA25611@jh-x301> <49F87CFF.4090804@pook.es> <20090429163255.GA27251@jh-x301> <49F88DC2.60703@pook.es> <20090429174229.GA29760@jh-x301> <49F89C94.2070604@pook.es> <2d5a2c100904291237k5afa93fdo15ba4913f641f4d0@mail.gmail.com> <49FC94FD.1080808@pook.es> <20090502195708.GA28973@jh-x301>
In-Reply-To: <20090502195708.GA28973@jh-x301>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Johan

On 02/05/09 21:57, Johan Hedberg wrote:

> Thanks a lot for this trace! It turned out to be a simple format string
> bug which is now fixed in git:

That's great. I have pulled the correction. What should I do to get 'arecord | aplay" to work?

:; oreillette 
+ aplay -vv -d 10 -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
######+                                            | 11%
+ sleep 6
+ arecord -vv -D JX10 -f S16_LE
+ aplay -v -D JX10 -f S16_LE
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
aplay: pcm_write:1442: write error: Input/output error
+ exit

: root; valgrind src/.libs/bluetoothd -dn
==19305== Memcheck, a memory error detector.
==19305== Copyright (C) 2002-2008, and GNU GPL'd, by Julian Seward et al.
==19305== Using LibVEX rev 1884, a library for dynamic binary translation.
==19305== Copyright (C) 2004-2008, and GNU GPL'd, by OpenWorks LLP.
==19305== Using valgrind-3.4.1-Debian, a dynamic binary instrumentation framework.
==19305== Copyright (C) 2000-2008, and GNU GPL'd, by Julian Seward et al.
==19305== For more details, rerun with: -v
==19305== 
bluetoothd[19305]: Bluetooth daemon 4.37
bluetoothd[19305]: Enabling debug information
bluetoothd[19305]: parsing main.conf
bluetoothd[19305]: discovto=0
bluetoothd[19305]: Key file does not have key 'PairableTimeout'
bluetoothd[19305]: pageto=8192
bluetoothd[19305]: name=%h-%d
bluetoothd[19305]: class=0x000100
bluetoothd[19305]: inqmode=0
bluetoothd[19305]: Key file does not have key 'InitiallyPowered'
bluetoothd[19305]: Key file does not have key 'RememberPowered'
bluetoothd[19305]: Key file does not have key 'DeviceID'
bluetoothd[19305]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[19305]: Starting SDP server
bluetoothd[19305]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[19305]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[19305]: Unix socket created: 7
bluetoothd[19305]: Telephony plugin initialized
bluetoothd[19305]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[19305]: register_interface: path /org/bluez/19305/any
bluetoothd[19305]: Registered interface org.bluez.Service on path /org/bluez/19305/any
bluetoothd[19305]: HCI dev 0 registered
bluetoothd[19305]: child 19308 forked
bluetoothd[19305]: Entering main loop
==19308== Syscall param ioctl(generic) points to unaddressable byte(s)
==19308==    at 0x40007F2: (within /lib/ld-2.9.so)
==19308==    by 0x4832513: device_devreg_setup (hciops.c:226)
==19308==    by 0x4832638: device_event (hciops.c:255)
==19308==    by 0x483279E: init_known_adapters (hciops.c:301)
==19308==    by 0x4832BC6: hciops_setup (hciops.c:412)
==19308==    by 0x11E5B8: manager_init_adapters (manager.c:552)
==19308==    by 0x11240A: main (main.c:414)
==19308==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
bluetoothd[19305]: HCI dev 0 up
bluetoothd[19305]: Starting security manager 0
==19308== 
==19308== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 77 from 3)
==19308== malloc/free: in use at exit: 30,146 bytes in 335 blocks.
==19308== malloc/free: 652 allocs, 317 frees, 242,876 bytes allocated.
==19308== For counts of detected errors, rerun with: -v
==19308== searching for pointers to 335 not-freed blocks.
==19308== checked 119,956 bytes.
==19308== 
==19308== LEAK SUMMARY:
==19308==    definitely lost: 0 bytes in 0 blocks.
==19308==      possibly lost: 744 bytes in 3 blocks.
==19308==    still reachable: 29,402 bytes in 332 blocks.
==19308==         suppressed: 0 bytes in 0 blocks.
==19308== Rerun with --leak-check=full to see details of leaked memory.
bluetoothd[19305]: headset_server_probe: path /org/bluez/19305/hci0
bluetoothd[19305]: Adding record with handle 0x10000
bluetoothd[19305]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[19305]: Adding record with handle 0x10001
bluetoothd[19305]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[19305]: a2dp_server_probe: path /org/bluez/19305/hci0
bluetoothd[19305]: SEP 0x4b50968 registered: type:0 codec:0 seid:1
bluetoothd[19305]: Adding record with handle 0x10002
bluetoothd[19305]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[19305]: avrcp_server_probe: path /org/bluez/19305/hci0
bluetoothd[19305]: Adding record with handle 0x10003
bluetoothd[19305]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[19305]: Adding record with handle 0x10004
bluetoothd[19305]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19305]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[19305]: register_interface: path /org/bluez/19305/hci0
bluetoothd[19305]: Registered interface org.bluez.Service on path /org/bluez/19305/hci0
bluetoothd[19305]: Creating device /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19305]: btd_device_ref(0x4b812d8): ref=1
bluetoothd[19305]: Probe drivers for /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19305]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19305]: btd_device_ref(0x4b812d8): ref=2
bluetoothd[19305]: Registered interface org.bluez.Audio on path /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19305]: Found Headset record
bluetoothd[19305]: Registered interface org.bluez.Headset on path /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19305]: Found Handsfree record
bluetoothd[19305]: Creating device /org/bluez/19305/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[19305]: btd_device_ref(0x4b9e5e8): ref=1
bluetoothd[19305]: Creating device /org/bluez/19305/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[19305]: btd_device_ref(0x4ba34e0): ref=1
bluetoothd[19305]: Creating device /org/bluez/19305/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[19305]: btd_device_ref(0x4ba83e8): ref=1
bluetoothd[19305]: Creating device /org/bluez/19305/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[19305]: btd_device_ref(0x4bad2a8): ref=1
bluetoothd[19305]: Creating device /org/bluez/19305/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[19305]: btd_device_ref(0x4bb21b8): ref=1
bluetoothd[19305]: Creating device /org/bluez/19305/hci0/dev_00_03_89_FE_E6_19
bluetoothd[19305]: btd_device_ref(0x4bb7078): ref=1
bluetoothd[19305]: Creating device /org/bluez/19305/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[19305]: btd_device_ref(0x4bbbf38): ref=1
bluetoothd[19305]: Creating device /org/bluez/19305/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[19305]: btd_device_ref(0x4bc0df8): ref=1
bluetoothd[19305]: Creating device /org/bluez/19305/hci0/dev_00_17_E5_16_88_6C
bluetoothd[19305]: btd_device_ref(0x4bc5d28): ref=1
bluetoothd[19305]: Creating device /org/bluez/19305/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[19305]: btd_device_ref(0x4bcabe8): ref=1
bluetoothd[19305]: Changing service classes to 0x480104
bluetoothd[19305]: Adapter /org/bluez/19305/hci0 has been enabled
bluetoothd[19305]: child 19308 exited
bluetoothd[19305]: Computer is classified as desktop
bluetoothd[19305]: Current device class is 0x480104
bluetoothd[19305]: Setting 0x000104 for major/minor device class
bluetoothd[19305]: Changing major/minor class to 0x480104
bluetoothd[19305]: Agent registered for hci0 at :1.22:/org/bluez/agent/hci0
bluetoothd[19305]: Accepted new client connection on unix socket (fd=13)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[19305]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19305]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[19305]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[19305]: kernel auth requirements = 0x00
bluetoothd[19305]: stored link key type = 0x00
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[19305]: Received AT+BRSF=27
bluetoothd[19305]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[19305]: Received AT+CIND=?
bluetoothd[19305]: Received AT+CIND?
bluetoothd[19305]: Received AT+CMER=3, 0, 0, 1
bluetoothd[19305]: Event reporting (CMER): mode=3, ind=1
bluetoothd[19305]: HFP Service Level Connection established
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 connected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[19305]: Received AT+VGS=06
bluetoothd[19305]: SCO socket opened for headset /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19305]: SCO fd=20
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[19305]: Unix client disconnected (fd=13)
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[19305]: client_free(0x4be9560)
bluetoothd[19305]: No matching connection found for handle 44
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 disconnected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
bluetoothd[19305]: Accepted new client connection on unix socket (fd=13)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=read
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[19305]: Accepted new client connection on unix socket (fd=19)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19305]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[19305]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[19305]: kernel auth requirements = 0x00
bluetoothd[19305]: stored link key type = 0x00
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[19305]: Received AT+BRSF=27
bluetoothd[19305]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[19305]: Received AT+CIND=?
bluetoothd[19305]: Received AT+CIND?
bluetoothd[19305]: Received AT+CMER=3, 0, 0, 1
bluetoothd[19305]: Event reporting (CMER): mode=3, ind=1
bluetoothd[19305]: HFP Service Level Connection established
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 connected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[19305]: Received AT+VGS=06
bluetoothd[19305]: SCO socket opened for headset /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19305]: SCO fd=21
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Unix client disconnected (fd=19)
bluetoothd[19305]: client_free(0x4c85828)
bluetoothd[19305]: Unix client disconnected (fd=13)
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[19305]: client_free(0x4c73c18)
bluetoothd[19305]: No matching connection found for handle 48
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 disconnected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED

I tried again and this time neither of the plays worked.

:; oreillette 
+ aplay -vv -d 10 -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
#+                                                 | 00%aplay: pcm_write:1442: write error: Input/output error
+ sleep 6
+ arecord -vv -D JX10 -f S16_LE
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
+ aplay -v -D JX10 -f S16_LE
Bluetooth Audio Device
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
aplay: pcm_write:1442: write error: Input/output error
+ exit

bluetoothd[19305]: Accepted new client connection on unix socket (fd=13)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[19305]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19305]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[19305]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[19305]: kernel auth requirements = 0x00
bluetoothd[19305]: stored link key type = 0x00
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[19305]: Received AT+BRSF=27
bluetoothd[19305]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[19305]: Received AT+CIND=?
bluetoothd[19305]: Received AT+CIND?
bluetoothd[19305]: Received AT+CMER=3, 0, 0, 1
bluetoothd[19305]: Event reporting (CMER): mode=3, ind=1
bluetoothd[19305]: HFP Service Level Connection established
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 connected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[19305]: Received AT+VGS=06
bluetoothd[19305]: SCO socket opened for headset /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19305]: SCO fd=18
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[19305]: Unix client disconnected (fd=13)
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[19305]: client_free(0x4d1a028)
bluetoothd[19305]: No matching connection found for handle 44
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 disconnected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
bluetoothd[19305]: Accepted new client connection on unix socket (fd=13)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=read
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[19305]: Accepted new client connection on unix socket (fd=19)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19305]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[19305]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[19305]: kernel auth requirements = 0x00
bluetoothd[19305]: stored link key type = 0x00
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[19305]: Received AT+BRSF=27
bluetoothd[19305]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[19305]: Received AT+CIND=?
bluetoothd[19305]: Received AT+CIND?
bluetoothd[19305]: Received AT+CMER=3, 0, 0, 1
bluetoothd[19305]: Event reporting (CMER): mode=3, ind=1
bluetoothd[19305]: HFP Service Level Connection established
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 connected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[19305]: Received AT+VGS=06
bluetoothd[19305]: SCO socket opened for headset /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19305]: SCO fd=18
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Unix client disconnected (fd=19)
bluetoothd[19305]: client_free(0x4db5cd8)
bluetoothd[19305]: Unix client disconnected (fd=13)
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[19305]: client_free(0x4da40c8)
bluetoothd[19305]: No matching connection found for handle 50
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 disconnected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED

Twinkle 1.4.2 works quite often though sometimes the recorded sound (from the microphone) is very distorted.

I just tried twinkle again and got a "ERR or HUP on RFCOMM socket" and the sound stopped.

bluetoothd[19305]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19305]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[19305]: kernel auth requirements = 0x00
bluetoothd[19305]: stored link key type = 0x00
bluetoothd[19305]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[19305]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19305]: hcid_dbus_bonding_process_complete: no pending auth request
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[19305]: Received AT+BRSF=27
bluetoothd[19305]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[19305]: Received AT+CIND=?
bluetoothd[19305]: Received AT+CIND?
bluetoothd[19305]: Received AT+CMER=3, 0, 0, 1
bluetoothd[19305]: Event reporting (CMER): mode=3, ind=1
bluetoothd[19305]: HFP Service Level Connection established
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 connected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[19305]: Received AT+VGS=00
bluetoothd[19305]: Accepted new client connection on unix socket (fd=18)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[19305]: SCO socket opened for headset /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19305]: SCO fd=19
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Accepted new client connection on unix socket (fd=20)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=read
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: ERR or HUP on RFCOMM socket
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 disconnected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_DISCONNECTED

I tried twinkle again. The sound in the headset was bad and the micro didn't seem to work at all.

bluetoothd[19305]: Accepted new client connection on unix socket (fd=13)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[19305]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[19305]: Received AT+BRSF=27
bluetoothd[19305]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[19305]: Received AT+CIND=?
bluetoothd[19305]: Received AT+CIND?
bluetoothd[19305]: Received AT+CMER=3, 0, 0, 1
bluetoothd[19305]: Event reporting (CMER): mode=3, ind=1
bluetoothd[19305]: HFP Service Level Connection established
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 connected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[19305]: Received AT+VGS=00
bluetoothd[19305]: SCO socket opened for headset /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19305]: SCO fd=18
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Accepted new client connection on unix socket (fd=20)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=read
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM

The next time (with twinkle calling the echo test of my asterisk server) the received audio was fine but the microphone picked up really weird sounds (though somewhat related to the music I'm listing to on my stereo).

bluetoothd[19305]: Accepted new client connection on unix socket (fd=13)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[19305]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[19305]: /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[19305]: Received AT+BRSF=27
bluetoothd[19305]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[19305]: Received AT+CIND=?
bluetoothd[19305]: Received AT+CIND?
bluetoothd[19305]: Received AT+CMER=3, 0, 0, 1
bluetoothd[19305]: Event reporting (CMER): mode=3, ind=1
bluetoothd[19305]: HFP Service Level Connection established
bluetoothd[19305]: telephony-dummy: device 0x4b925a8 connected
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[19305]: Received AT+VGS=00
bluetoothd[19305]: SCO socket opened for headset /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19305]: SCO fd=20
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: State changed /org/bluez/19305/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Accepted new client connection on unix socket (fd=18)
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19305]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=read
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19305]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19305]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19305]: Received AT+VGS=04
bluetoothd[19305]: Received AT+VGS=08
bluetoothd[19305]: Received AT+VGS=06
bluetoothd[19305]: Received AT+VGS=15

I'm using 2.6.30-rc2, a Jabra JX10 and a
Bus 002 Device 006: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)

-- 
If the From address bounces, please see http://www.pook.it/.
