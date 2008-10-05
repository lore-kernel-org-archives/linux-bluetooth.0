Return-Path: <cyrus@holtmann.org>
Message-ID: <48E91E6F.1030202@pook.es>
Date: Sun, 05 Oct 2008 22:07:11 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez-4.11 + 2.6.27-rc8 + SCO headset -> Invalid read of size
 4
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net> <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com>
In-Reply-To: <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>> Sometimes bluetoothd segfaults.
> That's something more serious. Could you please try to produce a 
> backtrace, either with gdb or valgrind. Thanks!

valgrind is easy

BTW, all the files in /usr/local/stow/bluez-4.11 are symlinked
into /usr/local using stow.

I can get this error by running "aplay -D JX10 lib/alarm.wav"
a few times with a 15 second delay before killing aplay with
control-C. It happened three times tonight.

Let me know if I can help in any other way.

This is the interesting output from valgrind:

bluetoothd[15123]: connect(): Connection timed out (110)
==15123== Invalid read of size 4
==15123==    at 0x490CBF3: (within /usr/lib/libdbus-1.so.3.4.0)
==15123==    by 0x4911DD1: dbus_message_get_sender (in /usr/lib/libdbus-1.so.3.4.0)
==15123==    by 0x49155C0: dbus_message_new_error (in /usr/lib/libdbus-1.so.3.4.0)
==15123==    by 0x1361D: error_common_reply (in /usr/local/stow/bluez-4.11/sbin/bluetoothd)
==15123==    by 0x4ED9D2C: error_connection_attempt_failed (in /usr/local/stow/bluez-4.11/lib/bluetooth/plugins/audio.so)
==15123==    by 0x4EDAEA2: rfcomm_connect_cb (in /usr/local/stow/bluez-4.11/lib/bluetooth/plugins/audio.so)
==15123==    by 0x2165E: connect_cb (in /usr/local/stow/bluez-4.11/sbin/bluetoothd)
==15123==    by 0x48B465C: (within /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0x487E1B7: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0x4881852: (within /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0x4881D71: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0xA410: main (in /usr/local/stow/bluez-4.11/sbin/bluetoothd)
==15123==  Address 0x464c45b3 is not stack'd, malloc'd or (recently) free'd

This what I ran (note where I typed control-C twice)

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
^CAborted by signal Interrupt...
bt_audio_service_open: connect() failed: Connection refused (111)
aplay: main:564: audio open error: Connection refused

Here is the complete log:

: root@kooka; valgrind /usr/local/sbin/bluetoothd -dn
==15123== Memcheck, a memory error detector.
==15123== Copyright (C) 2002-2007, and GNU GPL'd, by Julian Seward et al.
==15123== Using LibVEX rev 1854, a library for dynamic binary translation.
==15123== Copyright (C) 2004-2007, and GNU GPL'd, by OpenWorks LLP.
==15123== Using valgrind-3.3.1-Debian, a dynamic binary instrumentation framework.
==15123== Copyright (C) 2000-2007, and GNU GPL'd, by Julian Seward et al.
==15123== For more details, rerun with: -v
==15123==
bluetoothd[15123]: Bluetooth daemon
bluetoothd[15123]: Enabling debug information
bluetoothd[15123]: parsing main.conf
bluetoothd[15123]: offmode=NoScan
bluetoothd[15123]: discovto=0
bluetoothd[15123]: pageto=8192
bluetoothd[15123]: name=%h-%d
bluetoothd[15123]: class=0x000100
bluetoothd[15123]: inqmode=0
bluetoothd[15123]: Starting SDP server
bluetoothd[15123]: Loading plugins /usr/local/lib/bluetooth/plugins
bluetoothd[15123]: /usr/local/lib/bluetooth/plugins/audio.so
bluetoothd[15123]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[15123]: Unix socket created: 11
bluetoothd[15123]: Telephony plugin initialized
bluetoothd[15123]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes"
bluetoothd[15123]: /usr/local/lib/bluetooth/plugins/serial.so
bluetoothd[15123]: /usr/local/lib/bluetooth/plugins/hal.so
bluetoothd[15123]: /usr/local/lib/bluetooth/plugins/service.so
bluetoothd[15123]: /usr/local/lib/bluetooth/plugins/network.so
bluetoothd[15123]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
bluetoothd[15123]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
==15123== Warning: noted but unhandled ioctl 0x89a0 with no size/direction hints
==15123==    This could cause spurious value errors to appear.
==15123==    See README_MISSING_SYSCALL_OR_IOCTL for guidance on writing a proper wrapper.
bluetoothd[15123]: bridge pan0 created
bluetoothd[15123]: /usr/local/lib/bluetooth/plugins/input.so
bluetoothd[15123]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[15123]: HCI dev 0 registered
bluetoothd[15123]: child 15132 forked
bluetoothd[15123]: HCI dev 0 already up
bluetoothd[15123]: headset_server_probe: path /org/bluez/hci0
bluetoothd[15123]: Adding record with handle 0x10000
==15132==
==15132== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 84 from 2)
==15132== malloc/free: in use at exit: 30,100 bytes in 352 blocks.
==15132== malloc/free: 751 allocs, 399 frees, 290,809 bytes allocated.
==15132== For counts of detected errors, rerun with: -v
==15132== searching for pointers to 352 not-freed blocks.
==15132== checked 145,996 bytes.
==15132==
==15132== LEAK SUMMARY:
==15132==    definitely lost: 0 bytes in 0 blocks.
==15132==      possibly lost: 744 bytes in 3 blocks.
==15132==    still reachable: 29,356 bytes in 349 blocks.
==15132==         suppressed: 0 bytes in 0 blocks.
==15132== Rerun with --leak-check=full to see details of leaked memory.
bluetoothd[15123]: Adding record with handle 0x10001
bluetoothd[15123]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[15123]: SEP 0x4b311d0 registered: type:0 codec:0 seid:1
bluetoothd[15123]: Adding record with handle 0x10002
bluetoothd[15123]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[15123]: Adding record with handle 0x10003
bluetoothd[15123]: Adding record with handle 0x10004
bluetoothd[15123]: proxy_probe: path /org/bluez/hci0
bluetoothd[15123]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/hci0
bluetoothd[15123]: service_probe: path /org/bluez/hci0
bluetoothd[15123]: Registered interface org.bluez.Service on path /org/bluez/hci0
bluetoothd[15123]: network_server_probe: path /org/bluez/hci0
bluetoothd[15123]: Adding record with handle 0x10005
bluetoothd[15123]: register_server_record: got record id 0x10005
bluetoothd[15123]: Registered interface org.bluez.NetworkPeer on path /org/bluez/hci0
bluetoothd[15123]: network_server_probe: path /org/bluez/hci0
bluetoothd[15123]: Adding record with handle 0x10006
bluetoothd[15123]: register_server_record: got record id 0x10006
bluetoothd[15123]: Registered interface org.bluez.NetworkHub on path /org/bluez/hci0
bluetoothd[15123]: network_server_probe: path /org/bluez/hci0
bluetoothd[15123]: Adding record with handle 0x10007
bluetoothd[15123]: register_server_record: got record id 0x10007
bluetoothd[15123]: Registered interface org.bluez.NetworkRouter on path /org/bluez/hci0
bluetoothd[15123]: Creating device /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15123]: Probe drivers for /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15123]: Found Headset record
bluetoothd[15123]: Discovered Headset service on RFCOMM channel 2
bluetoothd[15123]: Registered interface org.bluez.Headset on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15123]: Found Hansfree record
bluetoothd[15123]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[15123]: headset_probe: path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15123]: Registered interface org.bluez.Input on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[15123]: Creating device /org/bluez/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[15123]: Creating device /org/bluez/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[15123]: Creating device /org/bluez/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[15123]: Creating device /org/bluez/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[15123]: Creating device /org/bluez/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[15123]: Creating device /org/bluez/hci0/dev_00_03_89_FE_E6_19
bluetoothd[15123]: Creating device /org/bluez/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[15123]: Creating device /org/bluez/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[15123]: Creating device /org/bluez/hci0/dev_00_17_E5_16_88_6C
bluetoothd[15123]: Creating device /org/bluez/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[15123]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[15123]: Starting security manager 0
bluetoothd[15123]: child 15132 exited
bluetoothd[15123]: Computer is classified as desktop
bluetoothd[15123]: Current device class is 0x4a0104
bluetoothd[15123]: Setting 0x000104 for major/minor device class
bluetoothd[15123]: Accepted new client connection on unix socket (fd=23)
bluetoothd[15123]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[15123]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[15123]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[15123]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[15123]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[15123]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[15123]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[15123]: kernel auth requirements = 0x04
bluetoothd[15123]: stored link key type = 0x00
bluetoothd[15123]: connect(): Connection timed out (110)
bluetoothd[15123]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[15123]: telephony-dummy: device 0x4b707b0 disconnected
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[15123]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[15123]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[15123]: Audio API: sending BT_STREAMFD_IND
bluetoothd[15123]: unix_sendmsg_fd: Bad file descriptor(9)
bluetoothd[15123]: resume failed
bluetoothd[15123]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[15123]: Unix client disconnected (fd=23)
bluetoothd[15123]: Accepted new client connection on unix socket (fd=23)
bluetoothd[15123]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[15123]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[15123]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[15123]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[15123]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[15123]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[15123]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[15123]: kernel auth requirements = 0x04
bluetoothd[15123]: stored link key type = 0x00
bluetoothd[15123]: connect(): Connection reset by peer (104)
bluetoothd[15123]: Unable to lock headset
bluetoothd[15123]: config failed
bluetoothd[15123]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[15123]: telephony-dummy: device 0x4b707b0 disconnected
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[15123]: Unix client disconnected (fd=23)
bluetoothd[15123]: Accepted new client connection on unix socket (fd=23)
bluetoothd[15123]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[15123]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[15123]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[15123]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[15123]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[15123]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[15123]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[15123]: kernel auth requirements = 0x04
bluetoothd[15123]: stored link key type = 0x00
bluetoothd[15123]: connect(): Connection timed out (110)
bluetoothd[15123]: Unable to lock headset
bluetoothd[15123]: config failed
bluetoothd[15123]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[15123]: telephony-dummy: device 0x4b707b0 disconnected
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[15123]: Unix client disconnected (fd=23)
bluetoothd[15123]: Accepted new client connection on unix socket (fd=23)
bluetoothd[15123]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[15123]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[15123]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[15123]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[15123]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[15123]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[15123]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[15123]: kernel auth requirements = 0x04
bluetoothd[15123]: stored link key type = 0x00
bluetoothd[15123]: Unix client disconnected (fd=23)
bluetoothd[15123]: telephony-dummy: device 0x4b707b0 disconnected
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[15123]: Accepted new client connection on unix socket (fd=23)
bluetoothd[15123]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[15123]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[15123]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[15123]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[15123]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[15123]: connect(): Connection timed out (110)
bluetoothd[15123]: Unable to lock headset
bluetoothd[15123]: config failed
bluetoothd[15123]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[15123]: telephony-dummy: device 0x4b707b0 disconnected
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[15123]: Unix client disconnected (fd=23)
bluetoothd[15123]: Accepted new client connection on unix socket (fd=23)
bluetoothd[15123]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[15123]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[15123]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[15123]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[15123]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[15123]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[15123]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[15123]: kernel auth requirements = 0x04
bluetoothd[15123]: stored link key type = 0x00
bluetoothd[15123]: connect(): Connection timed out (110)
bluetoothd[15123]: Unable to lock headset
bluetoothd[15123]: config failed
bluetoothd[15123]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[15123]: telephony-dummy: device 0x4b707b0 disconnected
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[15123]: Unix client disconnected (fd=23)
bluetoothd[15123]: Accepted new client connection on unix socket (fd=23)
bluetoothd[15123]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[15123]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[15123]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[15123]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[15123]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[15123]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[15123]: connect(): Connection timed out (110)
bluetoothd[15123]: Unable to lock headset
bluetoothd[15123]: config failed
bluetoothd[15123]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[15123]: telephony-dummy: device 0x4b707b0 disconnected
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[15123]: Unix client disconnected (fd=23)
bluetoothd[15123]: Accepted new client connection on unix socket (fd=23)
bluetoothd[15123]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[15123]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[15123]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[15123]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[15123]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[15123]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[15123]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[15123]: kernel auth requirements = 0x04
bluetoothd[15123]: stored link key type = 0x00
bluetoothd[15123]: Unix client disconnected (fd=23)
bluetoothd[15123]: telephony-dummy: device 0x4b707b0 disconnected
bluetoothd[15123]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[15123]: connect(): Connection timed out (110)
==15123== Invalid read of size 4
==15123==    at 0x490CBF3: (within /usr/lib/libdbus-1.so.3.4.0)
==15123==    by 0x4911DD1: dbus_message_get_sender (in /usr/lib/libdbus-1.so.3.4.0)
==15123==    by 0x49155C0: dbus_message_new_error (in /usr/lib/libdbus-1.so.3.4.0)
==15123==    by 0x1361D: error_common_reply (in /usr/local/stow/bluez-4.11/sbin/bluetoothd)
==15123==    by 0x4ED9D2C: error_connection_attempt_failed (in /usr/local/stow/bluez-4.11/lib/bluetooth/plugins/audio.so)
==15123==    by 0x4EDAEA2: rfcomm_connect_cb (in /usr/local/stow/bluez-4.11/lib/bluetooth/plugins/audio.so)
==15123==    by 0x2165E: connect_cb (in /usr/local/stow/bluez-4.11/sbin/bluetoothd)
==15123==    by 0x48B465C: (within /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0x487E1B7: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0x4881852: (within /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0x4881D71: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0xA410: main (in /usr/local/stow/bluez-4.11/sbin/bluetoothd)
==15123==  Address 0x464c45b3 is not stack'd, malloc'd or (recently) free'd
==15123==
==15123== Process terminating with default action of signal 11 (SIGSEGV)
==15123==  Access not within mapped region at address 0x464C45B3
==15123==    at 0x490CBF3: (within /usr/lib/libdbus-1.so.3.4.0)
==15123==    by 0x4911DD1: dbus_message_get_sender (in /usr/lib/libdbus-1.so.3.4.0)
==15123==    by 0x49155C0: dbus_message_new_error (in /usr/lib/libdbus-1.so.3.4.0)
==15123==    by 0x1361D: error_common_reply (in /usr/local/stow/bluez-4.11/sbin/bluetoothd)
==15123==    by 0x4ED9D2C: error_connection_attempt_failed (in /usr/local/stow/bluez-4.11/lib/bluetooth/plugins/audio.so)
==15123==    by 0x4EDAEA2: rfcomm_connect_cb (in /usr/local/stow/bluez-4.11/lib/bluetooth/plugins/audio.so)
==15123==    by 0x2165E: connect_cb (in /usr/local/stow/bluez-4.11/sbin/bluetoothd)
==15123==    by 0x48B465C: (within /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0x487E1B7: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0x4881852: (within /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0x4881D71: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.1600.6)
==15123==    by 0xA410: main (in /usr/local/stow/bluez-4.11/sbin/bluetoothd)
==15123==
==15123== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 84 from 2)
==15123== malloc/free: in use at exit: 46,759 bytes in 872 blocks.
==15123== malloc/free: 3,266 allocs, 2,394 frees, 1,953,427 bytes allocated.
==15123== For counts of detected errors, rerun with: -v
==15123== searching for pointers to 872 not-freed blocks.
==15123== checked 161,856 bytes.
==15123==
==15123== LEAK SUMMARY:
==15123==    definitely lost: 594 bytes in 10 blocks.
==15123==      possibly lost: 744 bytes in 3 blocks.
==15123==    still reachable: 45,421 bytes in 859 blocks.
==15123==         suppressed: 0 bytes in 0 blocks.
==15123== Rerun with --leak-check=full to see details of leaked memory.
Segmentation fault

