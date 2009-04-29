Return-Path: <cyrus@holtmann.org>
Message-ID: <49F8B704.40701@pook.es>
Date: Wed, 29 Apr 2009 22:22:28 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: bluetoothd git + aplay  -> pcm_write:1442: write error: Input/output
 error
References: <49F8638C.5070205@pook.es> <20090429160430.GA25611@jh-x301>	 <49F87CFF.4090804@pook.es> <20090429163255.GA27251@jh-x301>	 <49F88DC2.60703@pook.es> <20090429174229.GA29760@jh-x301>	 <49F89C94.2070604@pook.es> <2d5a2c100904291237k5afa93fdo15ba4913f641f4d0@mail.gmail.com>
In-Reply-To: <2d5a2c100904291237k5afa93fdo15ba4913f641f4d0@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Luiz

On 29/04/09 21:37, Luiz Augusto von Dentz wrote:
> These looks like a ctrl+c case, although still a bug which should be
> investigates this has nothing to do with the crash you have
> experienced before.

Yes and I must admit that I don't really care what bluetoothd does when I kill it.  I'd just like it to connect to my headset to I can talk to people!

I unplugged and replugged my bluetooth dongle. aplay gets a little further but dies after about 1 second. Tis been a long time sine aplay last worked.

Twinkle seems to work. Well it worked twice then for the following calls it just recorded noise. 

:; aplay -vv  -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
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


: root; valgrind src/.libs/bluetoothd -dn
==19997== Memcheck, a memory error detector.
==19997== Copyright (C) 2002-2008, and GNU GPL'd, by Julian Seward et al.
==19997== Using LibVEX rev 1884, a library for dynamic binary translation.
==19997== Copyright (C) 2004-2008, and GNU GPL'd, by OpenWorks LLP.
==19997== Using valgrind-3.4.1-Debian, a dynamic binary instrumentation framework.
==19997== Copyright (C) 2000-2008, and GNU GPL'd, by Julian Seward et al.
==19997== For more details, rerun with: -v
==19997== 
bluetoothd[19997]: Bluetooth daemon 4.37
bluetoothd[19997]: Enabling debug information
bluetoothd[19997]: parsing main.conf
bluetoothd[19997]: discovto=0
bluetoothd[19997]: Key file does not have key 'PairableTimeout'
bluetoothd[19997]: pageto=8192
bluetoothd[19997]: name=%h-%d
bluetoothd[19997]: class=0x000100
bluetoothd[19997]: inqmode=0
bluetoothd[19997]: Key file does not have key 'InitiallyPowered'
bluetoothd[19997]: Key file does not have key 'RememberPowered'
bluetoothd[19997]: Key file does not have key 'DeviceID'
bluetoothd[19997]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[19997]: Starting SDP server
bluetoothd[19997]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[19997]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[19997]: Unix socket created: 7
bluetoothd[19997]: Telephony plugin initialized
bluetoothd[19997]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[19997]: register_interface: path /org/bluez/19997/any
bluetoothd[19997]: Registered interface org.bluez.Service on path /org/bluez/19997/any
bluetoothd[19997]: HCI dev 0 registered
bluetoothd[19997]: child 20000 forked
bluetoothd[19997]: Entering main loop
==20000== Syscall param ioctl(generic) points to unaddressable byte(s)
==20000==    at 0x40007F2: (within /lib/ld-2.9.so)
==20000==    by 0x4832513: device_devreg_setup (hciops.c:226)
==20000==    by 0x4832638: device_event (hciops.c:255)
==20000==    by 0x483279E: init_known_adapters (hciops.c:301)
==20000==    by 0x4832BC6: hciops_setup (hciops.c:412)
==20000==    by 0x11E5B8: manager_init_adapters (manager.c:552)
==20000==    by 0x11240A: main (main.c:414)
==20000==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
bluetoothd[19997]: HCI dev 0 up
bluetoothd[19997]: Starting security manager 0
==20000== 
==20000== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 77 from 3)
==20000== malloc/free: in use at exit: 30,146 bytes in 335 blocks.
==20000== malloc/free: 652 allocs, 317 frees, 242,876 bytes allocated.
==20000== For counts of detected errors, rerun with: -v
==20000== searching for pointers to 335 not-freed blocks.
==20000== checked 119,956 bytes.
==20000== 
==20000== LEAK SUMMARY:
==20000==    definitely lost: 0 bytes in 0 blocks.
==20000==      possibly lost: 744 bytes in 3 blocks.
==20000==    still reachable: 29,402 bytes in 332 blocks.
==20000==         suppressed: 0 bytes in 0 blocks.
==20000== Rerun with --leak-check=full to see details of leaked memory.
bluetoothd[19997]: headset_server_probe: path /org/bluez/19997/hci0
bluetoothd[19997]: Adding record with handle 0x10000
bluetoothd[19997]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[19997]: Adding record with handle 0x10001
bluetoothd[19997]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[19997]: a2dp_server_probe: path /org/bluez/19997/hci0
bluetoothd[19997]: SEP 0x4b50968 registered: type:0 codec:0 seid:1
bluetoothd[19997]: Adding record with handle 0x10002
bluetoothd[19997]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[19997]: avrcp_server_probe: path /org/bluez/19997/hci0
bluetoothd[19997]: Adding record with handle 0x10003
bluetoothd[19997]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[19997]: Adding record with handle 0x10004
bluetoothd[19997]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[19997]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[19997]: register_interface: path /org/bluez/19997/hci0
bluetoothd[19997]: Registered interface org.bluez.Service on path /org/bluez/19997/hci0
bluetoothd[19997]: Creating device /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19997]: btd_device_ref(0x4b812d8): ref=1
bluetoothd[19997]: Probe drivers for /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19997]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19997]: btd_device_ref(0x4b812d8): ref=2
bluetoothd[19997]: Registered interface org.bluez.Audio on path /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19997]: Found Headset record
bluetoothd[19997]: Registered interface org.bluez.Headset on path /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19997]: Found Handsfree record
bluetoothd[19997]: Creating device /org/bluez/19997/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[19997]: btd_device_ref(0x4b9e5e8): ref=1
bluetoothd[19997]: Creating device /org/bluez/19997/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[19997]: btd_device_ref(0x4ba34e0): ref=1
bluetoothd[19997]: Creating device /org/bluez/19997/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[19997]: btd_device_ref(0x4ba83e8): ref=1
bluetoothd[19997]: Creating device /org/bluez/19997/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[19997]: btd_device_ref(0x4bad2a8): ref=1
bluetoothd[19997]: Creating device /org/bluez/19997/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[19997]: btd_device_ref(0x4bb21b8): ref=1
bluetoothd[19997]: Creating device /org/bluez/19997/hci0/dev_00_03_89_FE_E6_19
bluetoothd[19997]: btd_device_ref(0x4bb7078): ref=1
bluetoothd[19997]: Creating device /org/bluez/19997/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[19997]: btd_device_ref(0x4bbbf38): ref=1
bluetoothd[19997]: Creating device /org/bluez/19997/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[19997]: btd_device_ref(0x4bc0df8): ref=1
bluetoothd[19997]: Creating device /org/bluez/19997/hci0/dev_00_17_E5_16_88_6C
bluetoothd[19997]: btd_device_ref(0x4bc5d28): ref=1
bluetoothd[19997]: Creating device /org/bluez/19997/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[19997]: btd_device_ref(0x4bcabe8): ref=1
bluetoothd[19997]: Changing service classes to 0x480104
bluetoothd[19997]: Adapter /org/bluez/19997/hci0 has been enabled
bluetoothd[19997]: child 20000 exited
bluetoothd[19997]: Computer is classified as desktop
bluetoothd[19997]: Current device class is 0x480104
bluetoothd[19997]: Setting 0x000104 for major/minor device class
bluetoothd[19997]: Changing major/minor class to 0x480104
bluetoothd[19997]: Agent registered for hci0 at :1.22:/org/bluez/agent/hci0
bluetoothd[19997]: Accepted new client connection on unix socket (fd=13)
bluetoothd[19997]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[19997]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[19997]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[19997]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[19997]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[19997]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[19997]: State changed /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[19997]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[19997]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[19997]: /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[19997]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[19997]: kernel auth requirements = 0x00
bluetoothd[19997]: stored link key type = 0x00
bluetoothd[19997]: /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[19997]: Received AT+BRSF=27
bluetoothd[19997]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[19997]: Received AT+CIND=?
bluetoothd[19997]: Received AT+CIND?
bluetoothd[19997]: Received AT+CMER=3, 0, 0, 1
bluetoothd[19997]: Event reporting (CMER): mode=3, ind=1
bluetoothd[19997]: HFP Service Level Connection established
bluetoothd[19997]: telephony-dummy: device 0x4b925a8 connected
bluetoothd[19997]: State changed /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[19997]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[19997]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[19997]: State changed /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[19997]: Received AT+VGS=00
bluetoothd[19997]: SCO socket opened for headset /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98
bluetoothd[19997]: SCO fd=20
bluetoothd[19997]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[19997]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[19997]: State changed /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[19997]: Unix client disconnected (fd=13)
bluetoothd[19997]: State changed /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[19997]: client_free(0x4be9968)
bluetoothd[19997]: No matching connection found for handle 44
bluetoothd[19997]: telephony-dummy: device 0x4b925a8 disconnected
bluetoothd[19997]: State changed /org/bluez/19997/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED



-- 
If the From address bounces, please see http://www.pook.it/.
