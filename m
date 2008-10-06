Return-Path: <cyrus@holtmann.org>
Message-ID: <48EA6D84.7020101@pook.es>
Date: Mon, 06 Oct 2008 21:56:52 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez-4.11 + 2.6.27-rc8 + SCO headset -> Invalid read of size
 4
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net> <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com> <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com> <0ED1CF2A-40D0-4A82-BAED-21F90B6466ED@gmail.com>
In-Reply-To: <0ED1CF2A-40D0-4A82-BAED-21F90B6466ED@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Johan

> I think I managed to fix the segfault issue. The valgrind backtrace was 
> actually misleading/incorrect but I managed to get a proper one with 
> gdb. Could you try the latest git and see if the segfault is gone? 

I still have the segfault. But it took a little longer this time.

I'm a git beginner. Is there a git command that gives me the "version"
of what "git clone" retrieved so that you exactly what code I have?

bluetoothd[2451]: connect(): Connection timed out (110)
==2451== Invalid read of size 4
==2451==    at 0x490CBF3: (within /usr/lib/libdbus-1.so.3.4.0)
==2451==    by 0x4911DD1: dbus_message_get_sender (in /usr/lib/libdbus-1.so.3.4.0)
==2451==    by 0x49155C0: dbus_message_new_error (in /usr/lib/libdbus-1.so.3.4.0)
==2451==    by 0x15677: error_common_reply (error.c:42)
==2451==    by 0x4ED900D: error_connection_attempt_failed (headset.c:175)
==2451==    by 0x4ED9A3B: sco_connect_cb (headset.c:468)
==2451==    by 0x26074: connect_cb (glib-helper.c:707)
==2451==    by 0x48B465C: (within /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0x487E1B7: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0x4881852: (within /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0x4881D71: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0xAA93: main (main.c:750)
==2451==  Address 0x464c45b3 is not stack'd, malloc'd or (recently) free'd

:; while sleep 15; do aplay -D JX10 lib/alarm.wav ; done
Playing WAVE 'lib/alarm.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
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
Playing WAVE 'lib/alarm.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
^CAborted by signal Interrupt...
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
Playing WAVE 'lib/alarm.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
^CAborted by signal Interrupt...
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
Playing WAVE 'lib/alarm.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
^CAborted by signal Interrupt...
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
bt_audio_service_open: connect() failed: Connection refused (111)
aplay: main:564: audio open error: Connection refused
: root@kooka; valgrind src/.libs/bluetoothd -dn
==2451== Memcheck, a memory error detector.
==2451== Copyright (C) 2002-2007, and GNU GPL'd, by Julian Seward et al.
==2451== Using LibVEX rev 1854, a library for dynamic binary translation.
==2451== Copyright (C) 2004-2007, and GNU GPL'd, by OpenWorks LLP.
==2451== Using valgrind-3.3.1-Debian, a dynamic binary instrumentation framework.
==2451== Copyright (C) 2000-2007, and GNU GPL'd, by Julian Seward et al.
==2451== For more details, rerun with: -v
==2451==
bluetoothd[2451]: Bluetooth daemon
bluetoothd[2451]: Enabling debug information
bluetoothd[2451]: parsing main.conf
bluetoothd[2451]: offmode=NoScan
bluetoothd[2451]: discovto=0
bluetoothd[2451]: pageto=8192
bluetoothd[2451]: name=%h-%d
bluetoothd[2451]: class=0x000100
bluetoothd[2451]: inqmode=0
bluetoothd[2451]: Starting SDP server
bluetoothd[2451]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[2451]: /home/stuart/ws/install/bluez/git/bluez/plugins/audio.so
bluetoothd[2451]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[2451]: Unix socket created: 11
bluetoothd[2451]: Telephony plugin initialized
bluetoothd[2451]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes"
bluetoothd[2451]: /home/stuart/ws/install/bluez/git/bluez/plugins/serial.so
bluetoothd[2451]: /home/stuart/ws/install/bluez/git/bluez/plugins/hal.so
bluetoothd[2451]: /home/stuart/ws/install/bluez/git/bluez/plugins/service.so
bluetoothd[2451]: /home/stuart/ws/install/bluez/git/bluez/plugins/network.so
bluetoothd[2451]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
bluetoothd[2451]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
==2451== Warning: noted but unhandled ioctl 0x89a0 with no size/direction hints
==2451==    This could cause spurious value errors to appear.
==2451==    See README_MISSING_SYSCALL_OR_IOCTL for guidance on writing a proper wrapper.
bluetoothd[2451]: Can't create GN bridge
bluetoothd[2451]: /home/stuart/ws/install/bluez/git/bluez/plugins/input.so
bluetoothd[2451]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[2451]: HCI dev 0 registered
bluetoothd[2451]: child 2452 forked
bluetoothd[2451]: HCI dev 0 already up
bluetoothd[2451]: headset_server_probe: path /org/bluez/hci0
bluetoothd[2451]: Adding record with handle 0x10000
bluetoothd[2451]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 00001112-0000-1000-8000-00805f9
==2452==
==2452== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 104 from 2)
bluetoothd[2451]: Record pattern UUID 00001203-0000-1000-8000-00805f9
==2452== malloc/free: in use at exit: 30,412 bytes in 352 blocks.
==2452== malloc/free: 751 allocs, 399 frees, 292,193 bytes allocated.
==2452== For counts of detected errors, rerun with: -v
==2452== searching for pointers to 352 not-freed blocks.
==2452== checked 146,352 bytes.
==2452==
==2452== LEAK SUMMARY:
==2452==    definitely lost: 0 bytes in 0 blocks.
==2452==      possibly lost: 744 bytes in 3 blocks.
==2452==    still reachable: 29,668 bytes in 349 blocks.
==2452==         suppressed: 0 bytes in 0 blocks.
==2452== Rerun with --leak-check=full to see details of leaked memory.
bluetoothd[2451]: Adding record with handle 0x10001
bluetoothd[2451]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[2451]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[2451]: SEP 0x4b42690 registered: type:0 codec:0 seid:1
bluetoothd[2451]: Adding record with handle 0x10002
bluetoothd[2451]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[2451]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[2451]: Adding record with handle 0x10003
bluetoothd[2451]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[2451]: Adding record with handle 0x10004
bluetoothd[2451]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[2451]: proxy_probe: path /org/bluez/hci0
bluetoothd[2451]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/hci0
bluetoothd[2451]: service_probe: path /org/bluez/hci0
bluetoothd[2451]: Registered interface org.bluez.Service on path /org/bluez/hci0
bluetoothd[2451]: network_server_probe: path /org/bluez/hci0
bluetoothd[2451]: Adding record with handle 0x10005
bluetoothd[2451]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[2451]: register_server_record: got record id 0x10005
bluetoothd[2451]: Registered interface org.bluez.NetworkPeer on path /org/bluez/hci0
bluetoothd[2451]: network_server_probe: path /org/bluez/hci0
bluetoothd[2451]: Adding record with handle 0x10006
bluetoothd[2451]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[2451]: register_server_record: got record id 0x10006
bluetoothd[2451]: Registered interface org.bluez.NetworkHub on path /org/bluez/hci0
bluetoothd[2451]: network_server_probe: path /org/bluez/hci0
bluetoothd[2451]: Adding record with handle 0x10007
bluetoothd[2451]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2451]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[2451]: register_server_record: got record id 0x10007
bluetoothd[2451]: Registered interface org.bluez.NetworkRouter on path /org/bluez/hci0
bluetoothd[2451]: Creating device /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[2451]: Probe drivers for /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[2451]: Found Headset record
bluetoothd[2451]: Discovered Headset service on RFCOMM channel 2
bluetoothd[2451]: Registered interface org.bluez.Headset on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[2451]: Found Hansfree record
bluetoothd[2451]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[2451]: headset_probe: path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[2451]: Registered interface org.bluez.Input on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[2451]: Creating device /org/bluez/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[2451]: Creating device /org/bluez/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[2451]: Creating device /org/bluez/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[2451]: Creating device /org/bluez/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[2451]: Creating device /org/bluez/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[2451]: Creating device /org/bluez/hci0/dev_00_03_89_FE_E6_19
bluetoothd[2451]: Creating device /org/bluez/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[2451]: Creating device /org/bluez/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[2451]: Creating device /org/bluez/hci0/dev_00_17_E5_16_88_6C
bluetoothd[2451]: Creating device /org/bluez/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[2451]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[2451]: Starting security manager 0
bluetoothd[2451]: child 2452 exited
bluetoothd[2451]: Computer is classified as desktop
bluetoothd[2451]: Current device class is 0x4a0104
bluetoothd[2451]: Setting 0x000104 for major/minor device class
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[2451]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[2451]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[2451]: kernel auth requirements = 0x04
bluetoothd[2451]: stored link key type = 0x00
bluetoothd[2451]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[2451]: Received AT+BRSF=27
bluetoothd[2451]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
bluetoothd[2451]: Received AT+CIND=?
bluetoothd[2451]: Received AT+CIND?
bluetoothd[2451]: Received AT+CMER=3, 0, 0, 1
bluetoothd[2451]: Event reporting (CMER): mode=3, ind=1
bluetoothd[2451]: HFP Service Level Connection established
bluetoothd[2451]: telephony-dummy: device 0x4b9f950 connected
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: Received AT+VGS=15
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[2451]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[2451]: Audio API: sending BT_STREAMFD_IND
bluetoothd[2451]: unix_sendmsg_fd: Bad file descriptor(9)
bluetoothd[2451]: resume failed
bluetoothd[2451]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 45
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 45
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: telephony-dummy: device 0x4b9f950 disconnected
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[2451]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: telephony-dummy: device 0x4b9f950 connected
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 45
bluetoothd[2451]: Received AT+BRSF=27
bluetoothd[2451]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
bluetoothd[2451]: Received AT+CIND=?
bluetoothd[2451]: Received AT+CIND?
bluetoothd[2451]: Received AT+CMER=3, 0, 0, 1
bluetoothd[2451]: Event reporting (CMER): mode=3, ind=1
bluetoothd[2451]: Received AT+VGS=15
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 45
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: No matching connection for handle 45
bluetoothd[2451]: telephony-dummy: device 0x4b9f950 disconnected
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[2451]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[2451]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[2451]: kernel auth requirements = 0x04
bluetoothd[2451]: stored link key type = 0x00
bluetoothd[2451]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[2451]: Received AT+BRSF=27
bluetoothd[2451]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
bluetoothd[2451]: Received AT+CIND=?
bluetoothd[2451]: Received AT+CIND?
bluetoothd[2451]: Received AT+CMER=3, 0, 0, 1
bluetoothd[2451]: Event reporting (CMER): mode=3, ind=1
bluetoothd[2451]: HFP Service Level Connection established
bluetoothd[2451]: telephony-dummy: device 0x4b9f950 connected
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: Received AT+VGS=15
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 41
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 41
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 41
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 41
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 41
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 41
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 41
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 41
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 41
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: connect(): Connection timed out (110)
bluetoothd[2451]: Unable to lock headset
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: No matching connection for handle 41
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: telephony-dummy: device 0x4b9f950 disconnected
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[2451]: Accepted new client connection on unix socket (fd=23)
bluetoothd[2451]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[2451]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[2451]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[2451]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[2451]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[2451]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[2451]: Received AT+BRSF=27
bluetoothd[2451]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
bluetoothd[2451]: Received AT+CIND=?
bluetoothd[2451]: Received AT+CIND?
bluetoothd[2451]: Received AT+CMER=3, 0, 0, 1
bluetoothd[2451]: Event reporting (CMER): mode=3, ind=1
bluetoothd[2451]: HFP Service Level Connection established
bluetoothd[2451]: telephony-dummy: device 0x4b9f950 connected
bluetoothd[2451]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[2451]: connect: Operation not permitted (1)
bluetoothd[2451]: config failed
bluetoothd[2451]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[2451]: Unix client disconnected (fd=23)
bluetoothd[2451]: Received AT+VGS=15
bluetoothd[2451]: connect(): Connection timed out (110)
==2451== Invalid read of size 4
==2451==    at 0x490CBF3: (within /usr/lib/libdbus-1.so.3.4.0)
==2451==    by 0x4911DD1: dbus_message_get_sender (in /usr/lib/libdbus-1.so.3.4.0)
==2451==    by 0x49155C0: dbus_message_new_error (in /usr/lib/libdbus-1.so.3.4.0)
==2451==    by 0x15677: error_common_reply (error.c:42)
==2451==    by 0x4ED900D: error_connection_attempt_failed (headset.c:175)
==2451==    by 0x4ED9A3B: sco_connect_cb (headset.c:468)
==2451==    by 0x26074: connect_cb (glib-helper.c:707)
==2451==    by 0x48B465C: (within /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0x487E1B7: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0x4881852: (within /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0x4881D71: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0xAA93: main (main.c:750)
==2451==  Address 0x464c45b3 is not stack'd, malloc'd or (recently) free'd
==2451==
==2451== Process terminating with default action of signal 11 (SIGSEGV)
==2451==  Access not within mapped region at address 0x464C45B3
==2451==    at 0x490CBF3: (within /usr/lib/libdbus-1.so.3.4.0)
==2451==    by 0x4911DD1: dbus_message_get_sender (in /usr/lib/libdbus-1.so.3.4.0)
==2451==    by 0x49155C0: dbus_message_new_error (in /usr/lib/libdbus-1.so.3.4.0)
==2451==    by 0x15677: error_common_reply (error.c:42)
==2451==    by 0x4ED900D: error_connection_attempt_failed (headset.c:175)
==2451==    by 0x4ED9A3B: sco_connect_cb (headset.c:468)
==2451==    by 0x26074: connect_cb (glib-helper.c:707)
==2451==    by 0x48B465C: (within /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0x487E1B7: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0x4881852: (within /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0x4881D71: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.1600.6)
==2451==    by 0xAA93: main (main.c:750)
==2451==
==2451== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 104 from 2)
==2451== malloc/free: in use at exit: 47,875 bytes in 882 blocks.
==2451== malloc/free: 4,077 allocs, 3,195 frees, 3,448,435 bytes allocated.
==2451== For counts of detected errors, rerun with: -v
==2451== searching for pointers to 882 not-freed blocks.
==2451== checked 162,236 bytes.
==2451==
==2451== LEAK SUMMARY:
==2451==    definitely lost: 1,292 bytes in 19 blocks.
==2451==      possibly lost: 864 bytes in 4 blocks.
==2451==    still reachable: 45,719 bytes in 859 blocks.
==2451==         suppressed: 0 bytes in 0 blocks.
==2451== Rerun with --leak-check=full to see details of leaked memory.
Segmentation fault


