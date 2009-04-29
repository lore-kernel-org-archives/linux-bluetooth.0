Return-Path: <cyrus@holtmann.org>
Message-ID: <49F89C94.2070604@pook.es>
Date: Wed, 29 Apr 2009 20:29:40 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd 4.37 -> Segmentation fault
References: <49F8638C.5070205@pook.es> <20090429160430.GA25611@jh-x301> <49F87CFF.4090804@pook.es> <20090429163255.GA27251@jh-x301> <49F88DC2.60703@pook.es> <20090429174229.GA29760@jh-x301>
In-Reply-To: <20090429174229.GA29760@jh-x301>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Johan

On 29/04/09 19:42, Johan Hedberg wrote:
> The protocol doesn't change very often. Last time it changed was between
> 4.33 and 4.34. So it should be fine to use latest git with 4.37 plugins.

this is what I'm going. Mostly twinkle hangs until I type control-C at bluetoothd. Somethings twinkle crashes. Sometimes I get audio for 5 seconds and then the audio just stops.

:; twinkle 
ALSA lib pcm_bluetooth.c:1607:(audioservice_expect) BT_START_STREAM failed : Success(0)
ALSA lib pcm_bluetooth.c:1566:(audioservice_recv) Too short (1 bytes) IPC packet from bluetoothd
KCrash: Application 'twinkle' crashing...
KCrash cannot reach kdeinit, launching directly.
:; twinkle 
warning: The VAD has been replaced by a hack pending a complete rewrite
ALSA lib pcm_bluetooth.c:1566:(audioservice_recv) Too short (0 bytes) IPC packet from bluetoothd
KCrash: Application 'twinkle' crashing...
KCrash cannot reach kdeinit, launching directly.

I did a pull just a few minutes ago. I don't know any simple to let you know exactly what commits I have.

: root; valgrind src/.libs/bluetoothd -dn
==19530== Memcheck, a memory error detector.
==19530== Copyright (C) 2002-2008, and GNU GPL'd, by Julian Seward et al.
==19530== Using LibVEX rev 1884, a library for dynamic binary translation.
==19530== Copyright (C) 2004-2008, and GNU GPL'd, by OpenWorks LLP.
==19530== Using valgrind-3.4.1-Debian, a dynamic binary instrumentation framework.
==19530== Copyright (C) 2000-2008, and GNU GPL'd, by Julian Seward et al.
==19530== For more details, rerun with: -v
==19530== 
bluetoothd[19530]: Bluetooth daemon 4.37
bluetoothd[19530]: Enabling debug information
bluetoothd[19530]: parsing main.conf
bluetoothd[19530]: discovto=0
bluetoothd[19530]: Key file does not have key 'PairableTimeout'
bluetoothd[19530]: pageto=8192
bluetoothd[19530]: name=%h-%d
bluetoothd[19530]: class=0x000100
bluetoothd[19530]: inqmode=0
bluetoothd[19530]: Key file does not have key 'InitiallyPowered'
bluetoothd[19530]: Key file does not have key 'RememberPowered'
bluetoothd[19530]: Key file does not have key 'DeviceID'
bluetoothd[19530]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[19530]: Starting SDP server
bluetoothd[19530]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[19530]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[19530]: Unix socket created: 7
bluetoothd[19530]: Telephony plugin initialized
bluetoothd[19530]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[19530]: register_interface: path /org/bluez/19530/any
bluetoothd[19530]: Registered interface org.bluez.Service on path /org/bluez/19530/any
bluetoothd[19530]: HCI dev 0 registered
bluetoothd[19530]: child 19533 forked
bluetoothd[19530]: Entering main loop
==19533== Syscall param ioctl(generic) points to unaddressable byte(s)
==19533==    at 0x40007F2: (within /lib/ld-2.9.so)
==19533==    by 0x4832513: device_devreg_setup (hciops.c:226)
==19533==    by 0x4832638: device_event (hciops.c:255)
==19533==    by 0x483279E: init_known_adapters (hciops.c:301)
==19533==    by 0x4832BC6: hciops_setup (hciops.c:412)
==19533==    by 0x11E5B8: manager_init_adapters (manager.c:552)
==19533==    by 0x11240A: main (main.c:414)
==19533==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
bluetoothd[19530]: HCI dev 0 up
bluetoothd[19530]: Starting security manager 0
==19533== 
==19533== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 77 from 3)
==19533== malloc/free: in use at exit: 30,146 bytes in 335 blocks.
==19533== malloc/free: 652 allocs, 317 frees, 242,876 bytes allocated.
==19533== For counts of detected errors, rerun with: -v
==19533== searching for pointers to 335 not-freed blocks.
==19533== checked 119,956 bytes.
==19533== 
==19533== LEAK SUMMARY:
==19533==    definitely lost: 0 bytes in 0 blocks.
==19533==      possibly lost: 744 bytes in 3 blocks.
==19533==    still reachable: 29,402 bytes in 332 blocks.
==19533==         suppressed: 0 bytes in 0 blocks.
==19533== Rerun with --leak-check=full to see details of leaked memory.
bluetoothd[19530]: headset_server_probe: path /org/bluez/19530/hci0
bluetoothd[19530]: Adding record with handle 0x10000
bluetoothd[19530]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[19530]: Adding record with handle 0x10001
bluetoothd[19530]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[19530]: a2dp_server_probe: path /org/bluez/19530/hci0
bluetoothd[19530]: SEP 0x4b50968 registered: type:0 codec:0 seid:1
bluetoothd[19530]: Adding record with handle 0x10002
bluetoothd[19530]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[19530]: avrcp_server_probe: path /org/bluez/19530/hci0
bluetoothd[19530]: Adding record with handle 0x10003
bluetoothd[19530]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[19530]: Adding record with handle 0x10004
bluetoothd[19530]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19530]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[19530]: register_interface: path /org/bluez/19530/hci0
bluetoothd[19530]: Registered interface org.bluez.Service on path /org/bluez/19530/hci0
bluetoothd[19530]: Creating device /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19530]: btd_device_ref(0x4b812d8): ref=1
bluetoothd[19530]: Probe drivers for /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19530]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19530]: btd_device_ref(0x4b812d8): ref=2
bluetoothd[19530]: Registered interface org.bluez.Audio on path /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19530]: Found Headset record
bluetoothd[19530]: Registered interface org.bluez.Headset on path /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19530]: Found Handsfree record
bluetoothd[19530]: Creating device /org/bluez/19530/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[19530]: btd_device_ref(0x4b9e5e8): ref=1
bluetoothd[19530]: Creating device /org/bluez/19530/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[19530]: btd_device_ref(0x4ba34e0): ref=1
bluetoothd[19530]: Creating device /org/bluez/19530/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[19530]: btd_device_ref(0x4ba83e8): ref=1
bluetoothd[19530]: Creating device /org/bluez/19530/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[19530]: btd_device_ref(0x4bad2a8): ref=1
bluetoothd[19530]: Creating device /org/bluez/19530/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[19530]: btd_device_ref(0x4bb21b8): ref=1
bluetoothd[19530]: Creating device /org/bluez/19530/hci0/dev_00_03_89_FE_E6_19
bluetoothd[19530]: btd_device_ref(0x4bb7078): ref=1
bluetoothd[19530]: Creating device /org/bluez/19530/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[19530]: btd_device_ref(0x4bbbf38): ref=1
bluetoothd[19530]: Creating device /org/bluez/19530/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[19530]: btd_device_ref(0x4bc0df8): ref=1
bluetoothd[19530]: Creating device /org/bluez/19530/hci0/dev_00_17_E5_16_88_6C
bluetoothd[19530]: btd_device_ref(0x4bc5d28): ref=1
bluetoothd[19530]: Creating device /org/bluez/19530/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[19530]: btd_device_ref(0x4bcabe8): ref=1
bluetoothd[19530]: Changing service classes to 0x480104
bluetoothd[19530]: Adapter /org/bluez/19530/hci0 has been enabled
bluetoothd[19530]: child 19533 exited
bluetoothd[19530]: Computer is classified as desktop
bluetoothd[19530]: Current device class is 0x480104
bluetoothd[19530]: Setting 0x000104 for major/minor device class
bluetoothd[19530]: Changing major/minor class to 0x480104
bluetoothd[19530]: Agent registered for hci0 at :1.22:/org/bluez/agent/hci0
bluetoothd[19530]: Accepted new client connection on unix socket (fd=13)
bluetoothd[19530]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19530]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19530]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19530]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[19530]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19530]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19530]: State changed /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[19530]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19530]: Unable to get service record: Connection timed out (110)
bluetoothd[19530]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19530]: telephony-dummy: device 0x4b925a8 disconnected
bluetoothd[19530]: State changed /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[19530]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19530]: State changed /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
^Cbluetoothd[19530]: Removing adapter /org/bluez/19530/hci0
bluetoothd[19530]: Removing device /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19530]: Headset unregistered while device was connected!
bluetoothd[19530]: telephony-dummy: device 0x4b925a8 disconnected
bluetoothd[19530]: State changed /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[19530]: Unregistered interface org.bluez.Headset on path /org/bluez/19530/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19530]: unix_device_removed(0x4b925a8)
==19530== Invalid read of size 4
==19530==    at 0x4EEE6A0: headset_unlock (headset.c:2555)
==19530==    by 0x4EE4876: start_close (unix.c:1174)
==19530==    by 0x4EE5B5B: unix_device_removed (unix.c:1674)
==19530==    by 0x4EE9889: audio_device_unregister (device.c:630)
==19530==    by 0x4EE776D: audio_remove (manager.c:759)
==19530==    by 0x126799: device_remove (device.c:842)
==19530==    by 0x123AA5: adapter_remove (adapter.c:2461)
==19530==    by 0x11DEEA: manager_remove_adapter (manager.c:316)
==19530==    by 0x489EF06: g_slist_foreach (in /usr/lib/libglib-2.0.so.0.2000.1)
==19530==    by 0x11DF22: manager_cleanup (manager.c:321)
==19530==    by 0x129686: hcid_dbus_exit (dbus-common.c:158)
==19530==    by 0x11243F: main (main.c:426)
==19530==  Address 0x464 is not stack'd, malloc'd or (recently) free'd
==19530== 
==19530== Process terminating with default action of signal 11 (SIGSEGV)
==19530==  Access not within mapped region at address 0x464
==19530==    at 0x4EEE6A0: headset_unlock (headset.c:2555)
==19530==    by 0x4EE4876: start_close (unix.c:1174)
==19530==    by 0x4EE5B5B: unix_device_removed (unix.c:1674)
==19530==    by 0x4EE9889: audio_device_unregister (device.c:630)
==19530==    by 0x4EE776D: audio_remove (manager.c:759)
==19530==    by 0x126799: device_remove (device.c:842)
==19530==    by 0x123AA5: adapter_remove (adapter.c:2461)
==19530==    by 0x11DEEA: manager_remove_adapter (manager.c:316)
==19530==    by 0x489EF06: g_slist_foreach (in /usr/lib/libglib-2.0.so.0.2000.1)
==19530==    by 0x11DF22: manager_cleanup (manager.c:321)
==19530==    by 0x129686: hcid_dbus_exit (dbus-common.c:158)
==19530==    by 0x11243F: main (main.c:426)
==19530==  If you believe this happened as a result of a stack overflow in your
==19530==  program's main thread (unlikely but possible), you can try to increase
==19530==  the size of the main thread stack using the --main-stacksize= flag.
==19530==  The main thread stack size used in this run was 8388608.
==19530== 
==19530== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 77 from 3)
==19530== malloc/free: in use at exit: 45,425 bytes in 685 blocks.
==19530== malloc/free: 2,528 allocs, 1,843 frees, 1,159,834 bytes allocated.
==19530== For counts of detected errors, rerun with: -v
==19530== searching for pointers to 685 not-freed blocks.
==19530== checked 133,960 bytes.
==19530== 
==19530== LEAK SUMMARY:
==19530==    definitely lost: 24 bytes in 1 blocks.
==19530==      possibly lost: 744 bytes in 3 blocks.
==19530==    still reachable: 44,657 bytes in 681 blocks.
==19530==         suppressed: 0 bytes in 0 blocks.
==19530== Rerun with --leak-check=full to see details of leaked memory.
Segmentation fault


aplay doesn't work either.

:; aplay -vv  -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:1607:(audioservice_expect) BT_START_STREAM failed : Success(0)
ALSA lib pcm_bluetooth.c:1566:(audioservice_recv) Too short (1 bytes) IPC packet from bluetoothd
aplay: set_params:1022: Unable to install hw params:
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


bluetoothd[19575]: Accepted new client connection on unix socket (fd=13)
bluetoothd[19575]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19575]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19575]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19575]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[19575]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19575]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19575]: State changed /org/bluez/19575/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[19575]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19575]: Unable to get service record: Connection timed out (110)
bluetoothd[19575]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19575]: telephony-dummy: device 0x4b92490 disconnected
bluetoothd[19575]: State changed /org/bluez/19575/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[19575]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19575]: State changed /org/bluez/19575/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[19575]: Unable to get service record: Connection reset by peer (104)
bluetoothd[19575]: Unable to get a SCO fd
bluetoothd[19575]: headset_resume_complete: resume failed
bluetoothd[19575]: Audio API: BT_ERROR -> BT_START_STREAM
bluetoothd[19575]: telephony-dummy: device 0x4b92490 disconnected
bluetoothd[19575]: State changed /org/bluez/19575/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[19575]: Unix client disconnected (fd=13)
bluetoothd[19575]: client_free(0x4bed8e0)


-- 
If the From address bounces, please see http://www.pook.it/.
