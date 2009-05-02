Return-Path: <cyrus@holtmann.org>
Message-ID: <49FC94FD.1080808@pook.es>
Date: Sat, 02 May 2009 20:46:21 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
CC: linux-bluetooth@vger.kernel.org
Subject: bluetoothd git version -> Segmentation fault
References: <49F8638C.5070205@pook.es> <20090429160430.GA25611@jh-x301>	 <49F87CFF.4090804@pook.es> <20090429163255.GA27251@jh-x301>	 <49F88DC2.60703@pook.es> <20090429174229.GA29760@jh-x301>	 <49F89C94.2070604@pook.es> <2d5a2c100904291237k5afa93fdo15ba4913f641f4d0@mail.gmail.com>
In-Reply-To: <2d5a2c100904291237k5afa93fdo15ba4913f641f4d0@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi

bluetoothd seg faulted again. This time I didn't have to type control-C. I just ran it and it crashed. I last did a git pull a bit before 2009-04-29 20:17

: root; valgrind src/.libs/bluetoothd -dn
==3300== Memcheck, a memory error detector.
==3300== Copyright (C) 2002-2008, and GNU GPL'd, by Julian Seward et al.
==3300== Using LibVEX rev 1884, a library for dynamic binary translation.
==3300== Copyright (C) 2004-2008, and GNU GPL'd, by OpenWorks LLP.
==3300== Using valgrind-3.4.1-Debian, a dynamic binary instrumentation framework.
==3300== Copyright (C) 2000-2008, and GNU GPL'd, by Julian Seward et al.
==3300== For more details, rerun with: -v
==3300== 
bluetoothd[3300]: Bluetooth daemon 4.37
bluetoothd[3300]: Enabling debug information
bluetoothd[3300]: parsing main.conf
bluetoothd[3300]: discovto=0
bluetoothd[3300]: Key file does not have key 'PairableTimeout'
bluetoothd[3300]: pageto=8192
bluetoothd[3300]: name=%h-%d
bluetoothd[3300]: class=0x000100
bluetoothd[3300]: inqmode=0
bluetoothd[3300]: Key file does not have key 'InitiallyPowered'
bluetoothd[3300]: Key file does not have key 'RememberPowered'
bluetoothd[3300]: Key file does not have key 'DeviceID'
bluetoothd[3300]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[3300]: Starting SDP server
bluetoothd[3300]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[3300]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[3300]: Unix socket created: 7
bluetoothd[3300]: Telephony plugin initialized
bluetoothd[3300]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[3300]: register_interface: path /org/bluez/3300/any
bluetoothd[3300]: Registered interface org.bluez.Service on path /org/bluez/3300/any
bluetoothd[3300]: HCI dev 0 registered
bluetoothd[3300]: child 3303 forked
bluetoothd[3300]: HCI dev 0 up
bluetoothd[3300]: Starting security manager 0
bluetoothd[3300]: periodic_inquiry_exit at adapter startup
==3303== Syscall param ioctl(generic) points to unaddressable byte(s)
==3303==    at 0x40007F2: (within /lib/ld-2.9.so)
==3303==    by 0x4832513: device_devreg_setup (hciops.c:226)
==3303==    by 0x4832638: device_event (hciops.c:255)
==3303==    by 0x483279E: init_known_adapters (hciops.c:301)
==3303==    by 0x4832BC6: hciops_setup (hciops.c:412)
==3303==    by 0x11E5B8: manager_init_adapters (manager.c:552)
==3303==    by 0x11240A: main (main.c:414)
==3303==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
bluetoothd[3300]: headset_server_probe: path /org/bluez/3300/hci0
==3303== 
==3303== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 77 from 3)
==3303== malloc/free: in use at exit: 30,144 bytes in 335 blocks.
==3303== malloc/free: 652 allocs, 317 frees, 242,846 bytes allocated.
==3303== For counts of detected errors, rerun with: -v
==3303== searching for pointers to 335 not-freed blocks.
bluetoothd[3300]: Adding record with handle 0x10000
==3303== checked 119,956 bytes.
==3303== 
==3303== LEAK SUMMARY:
==3303==    definitely lost: 0 bytes in 0 blocks.
==3303==      possibly lost: 744 bytes in 3 blocks.
==3303==    still reachable: 29,400 bytes in 332 blocks.
==3303==         suppressed: 0 bytes in 0 blocks.
==3303== Rerun with --leak-check=full to see details of leaked memory.
bluetoothd[3300]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3300]: Adding record with handle 0x10001
bluetoothd[3300]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3300]: a2dp_server_probe: path /org/bluez/3300/hci0
bluetoothd[3300]: SEP 0x4b50818 registered: type:0 codec:0 seid:1
bluetoothd[3300]: Adding record with handle 0x10002
bluetoothd[3300]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3300]: avrcp_server_probe: path /org/bluez/3300/hci0
bluetoothd[3300]: Adding record with handle 0x10003
bluetoothd[3300]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3300]: Adding record with handle 0x10004
bluetoothd[3300]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3300]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3300]: register_interface: path /org/bluez/3300/hci0
bluetoothd[3300]: Registered interface org.bluez.Service on path /org/bluez/3300/hci0
bluetoothd[3300]: Creating device /org/bluez/3300/hci0/dev_00_1A_45_2F_49_98
bluetoothd[3300]: btd_device_ref(0x4b81170): ref=1
bluetoothd[3300]: Probe drivers for /org/bluez/3300/hci0/dev_00_1A_45_2F_49_98
bluetoothd[3300]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[3300]: btd_device_ref(0x4b81170): ref=2
bluetoothd[3300]: Registered interface org.bluez.Audio on path /org/bluez/3300/hci0/dev_00_1A_45_2F_49_98
bluetoothd[3300]: Found Headset record
bluetoothd[3300]: Registered interface org.bluez.Headset on path /org/bluez/3300/hci0/dev_00_1A_45_2F_49_98
bluetoothd[3300]: Found Handsfree record
bluetoothd[3300]: Creating device /org/bluez/3300/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[3300]: btd_device_ref(0x4b9e480): ref=1
bluetoothd[3300]: Creating device /org/bluez/3300/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[3300]: btd_device_ref(0x4ba3378): ref=1
bluetoothd[3300]: Creating device /org/bluez/3300/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[3300]: btd_device_ref(0x4ba8280): ref=1
bluetoothd[3300]: Creating device /org/bluez/3300/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[3300]: btd_device_ref(0x4bad140): ref=1
bluetoothd[3300]: Creating device /org/bluez/3300/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[3300]: btd_device_ref(0x4bb2050): ref=1
bluetoothd[3300]: Creating device /org/bluez/3300/hci0/dev_00_03_89_FE_E6_19
bluetoothd[3300]: btd_device_ref(0x4bb6f10): ref=1
bluetoothd[3300]: Creating device /org/bluez/3300/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[3300]: btd_device_ref(0x4bbbdd0): ref=1
bluetoothd[3300]: Creating device /org/bluez/3300/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[3300]: btd_device_ref(0x4bc0c90): ref=1
bluetoothd[3300]: Creating device /org/bluez/3300/hci0/dev_00_17_E5_16_88_6C
bluetoothd[3300]: btd_device_ref(0x4bc5bc0): ref=1
bluetoothd[3300]: Creating device /org/bluez/3300/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[3300]: btd_device_ref(0x4bcaa80): ref=1
bluetoothd[3300]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[3300]: Changing service classes to 0x480104
bluetoothd[3300]: Adapter /org/bluez/3300/hci0 has been enabled
bluetoothd[3300]: Changing service classes to 0x480104
bluetoothd[3300]: Entering main loop
bluetoothd[3300]: child 3303 exited
bluetoothd[3300]: Computer is classified as desktop
bluetoothd[3300]: Current device class is 0x480104
bluetoothd[3300]: Setting 0x000104 for major/minor device class
bluetoothd[3300]: Changing major/minor class to 0x480104
bluetoothd[3300]: Agent registered for hci0 at :1.22:/org/bluez/agent/hci0
bluetoothd[3300]: Accepted new client connection on unix socket (fd=13)
bluetoothd[3300]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[3300]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[3300]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[3300]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[3300]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[3300]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[3300]: State changed /org/bluez/3300/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[3300]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[3300]: /org/bluez/3300/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[3300]: connect: Operation not permitted (1)
==3300== Invalid read of size 1
==3300==    at 0x4826728: strlen (mc_replace_strmem.c:242)
==3300==    by 0x498E677: vfprintf (in /lib/i686/cmov/libc-2.9.so)
==3300==    by 0x4A2A635: __vsyslog_chk (in /lib/i686/cmov/libc-2.9.so)
==3300==    by 0x4A2A706: vsyslog (in /lib/i686/cmov/libc-2.9.so)
==3300==    by 0x12D457: error (logging.c:58)
==3300==    by 0x4EEC176: get_record_cb (headset.c:1432)
==3300==    by 0x12D9DA: search_completed_cb (glib-helper.c:209)
==3300==    by 0x493F0B1: sdp_process (in /usr/local/stow/bluez-4.37/lib/libbluetooth.so.3.2.3)
==3300==    by 0x12DA46: search_process_cb (glib-helper.c:228)
==3300==    by 0x48B64AC: (within /usr/lib/libglib-2.0.so.0.2000.1)
==3300==    by 0x487F847: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.2000.1)
==3300==    by 0x4882DAA: (within /usr/lib/libglib-2.0.so.0.2000.1)
==3300==  Address 0x5 is not stack'd, malloc'd or (recently) free'd
==3300== 
==3300== Process terminating with default action of signal 11 (SIGSEGV)
==3300==  Access not within mapped region at address 0x5
==3300==    at 0x4826728: strlen (mc_replace_strmem.c:242)
==3300==    by 0x498E677: vfprintf (in /lib/i686/cmov/libc-2.9.so)
==3300==    by 0x4A2A635: __vsyslog_chk (in /lib/i686/cmov/libc-2.9.so)
==3300==    by 0x4A2A706: vsyslog (in /lib/i686/cmov/libc-2.9.so)
==3300==    by 0x12D457: error (logging.c:58)
==3300==    by 0x4EEC176: get_record_cb (headset.c:1432)
==3300==    by 0x12D9DA: search_completed_cb (glib-helper.c:209)
==3300==    by 0x493F0B1: sdp_process (in /usr/local/stow/bluez-4.37/lib/libbluetooth.so.3.2.3)
==3300==    by 0x12DA46: search_process_cb (glib-helper.c:228)
==3300==    by 0x48B64AC: (within /usr/lib/libglib-2.0.so.0.2000.1)
==3300==    by 0x487F847: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.2000.1)
==3300==    by 0x4882DAA: (within /usr/lib/libglib-2.0.so.0.2000.1)
==3300==  If you believe this happened as a result of a stack overflow in your
==3300==  program's main thread (unlikely but possible), you can try to increase
==3300==  the size of the main thread stack using the --main-stacksize= flag.
==3300==  The main thread stack size used in this run was 8388608.
==3300== 
==3300== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 77 from 3)
==3300== malloc/free: in use at exit: 123,843 bytes in 737 blocks.
==3300== malloc/free: 2,487 allocs, 1,750 frees, 1,298,497 bytes allocated.
==3300== For counts of detected errors, rerun with: -v
==3300== searching for pointers to 737 not-freed blocks.
==3300== checked 212,588 bytes.
==3300== 
==3300== LEAK SUMMARY:
==3300==    definitely lost: 0 bytes in 0 blocks.
==3300==      possibly lost: 744 bytes in 3 blocks.
==3300==    still reachable: 123,099 bytes in 734 blocks.
==3300==         suppressed: 0 bytes in 0 blocks.
==3300== Rerun with --leak-check=full to see details of leaked memory.
Segmentation fault



-- 
If the From address bounces, please see http://www.pook.it/.
