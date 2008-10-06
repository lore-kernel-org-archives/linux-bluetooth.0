Return-Path: <cyrus@holtmann.org>
Message-ID: <48EA93F7.4060000@pook.es>
Date: Tue, 07 Oct 2008 00:40:55 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez/git + 2.6.27-rc8 + bluetoothd -> SIGSEGV
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net>	 <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com>	 <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>	 <0ED1CF2A-40D0-4A82-BAED-21F90B6466ED@gmail.com> <48EA6D84.7020101@pook.es>	 <632D4195-1EFF-4191-98D9-4A0953223590@gmail.com> <48EA7B66.1050208@pook.es>	 <1223326990.11272.229.camel@violet.holtmann.net> <48EA7ED9.9080801@pook.es> <1223328106.11272.232.camel@violet.holtmann.net>
In-Reply-To: <1223328106.11272.232.camel@violet.holtmann.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

hello Marcel

>> :; grep ' -g' Makefile
>> CFLAGS = -Wall -O2 -D_FORTIFY_SOURCE=2 -fPIC -g -O0
> 
> that is indeed strange. You should be able to get a proper backtrace.

yes. I ran src/.libs/bluetoothd, it core dumped,
but I still cannot get a reasonable backtrace. Weird.

I'm not sure that that running src/.libs/bluetoothd is correct.
src/.libs/bluetoothd will use the libbluetooth.so.3 installed in
/usr/local/lib. If I want to use the library in the source area
(as I have not installed this version of bluez) I should run
src/bluetoothd. It does the library magic to use the libraries
in the src area.

I did this and it still core dumps and gdb still cannot read the
core. Time to go to bed.

: root@kooka; src//bluetoothd -dn
bluetoothd[9997]: Bluetooth daemon
bluetoothd[9997]: Enabling debug information
bluetoothd[9997]: parsing main.conf
bluetoothd[9997]: offmode=NoScan
bluetoothd[9997]: discovto=0
bluetoothd[9997]: pageto=8192
bluetoothd[9997]: name=%h-%d
bluetoothd[9997]: class=0x000100
bluetoothd[9997]: inqmode=0
bluetoothd[9997]: Starting SDP server
bluetoothd[9997]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[9997]: /home/stuart/ws/install/bluez/git/bluez/plugins/audio.so
bluetoothd[9997]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[9997]: Unix socket created: 11
bluetoothd[9997]: Telephony plugin initialized
bluetoothd[9997]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes"
bluetoothd[9997]: /home/stuart/ws/install/bluez/git/bluez/plugins/serial.so
bluetoothd[9997]: /home/stuart/ws/install/bluez/git/bluez/plugins/hal.so
bluetoothd[9997]: /home/stuart/ws/install/bluez/git/bluez/plugins/service.so
bluetoothd[9997]: /home/stuart/ws/install/bluez/git/bluez/plugins/network.so
bluetoothd[9997]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
bluetoothd[9997]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[9997]: bridge pan0 created
bluetoothd[9997]: /home/stuart/ws/install/bluez/git/bluez/plugins/input.so
bluetoothd[9997]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[9997]: HCI dev 0 registered
bluetoothd[9997]: child 10014 forked
bluetoothd[9997]: HCI dev 0 up
bluetoothd[9997]: Adapter /org/bluez/hci0 without an address
bluetoothd[9997]: headset_server_probe: path /org/bluez/hci0
bluetoothd[9997]: Adding record with handle 0x10000
bluetoothd[9997]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[9997]: Adding record with handle 0x10001
bluetoothd[9997]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[9997]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[9997]: SEP 0xb90487d0 registered: type:0 codec:0 seid:1
bluetoothd[9997]: Adding record with handle 0x10002
bluetoothd[9997]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[9997]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[9997]: Adding record with handle 0x10003
bluetoothd[9997]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[9997]: Adding record with handle 0x10004
bluetoothd[9997]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[9997]: proxy_probe: path /org/bluez/hci0
bluetoothd[9997]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/hci0
bluetoothd[9997]: service_probe: path /org/bluez/hci0
bluetoothd[9997]: Registered interface org.bluez.Service on path /org/bluez/hci0
bluetoothd[9997]: network_server_probe: path /org/bluez/hci0
bluetoothd[9997]: Adding record with handle 0x10005
bluetoothd[9997]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[9997]: register_server_record: got record id 0x10005
bluetoothd[9997]: Registered interface org.bluez.NetworkPeer on path /org/bluez/hci0
bluetoothd[9997]: network_server_probe: path /org/bluez/hci0
bluetoothd[9997]: Adding record with handle 0x10006
bluetoothd[9997]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[9997]: register_server_record: got record id 0x10006
bluetoothd[9997]: Registered interface org.bluez.NetworkHub on path /org/bluez/hci0
bluetoothd[9997]: network_server_probe: path /org/bluez/hci0
bluetoothd[9997]: Adding record with handle 0x10007
bluetoothd[9997]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9997]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[9997]: register_server_record: got record id 0x10007
bluetoothd[9997]: Registered interface org.bluez.NetworkRouter on path /org/bluez/hci0
bluetoothd[9997]: Creating device /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[9997]: Probe drivers for /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[9997]: Found Headset record
bluetoothd[9997]: Discovered Headset service on RFCOMM channel 2
bluetoothd[9997]: Registered interface org.bluez.Headset on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[9997]: Found Hansfree record
bluetoothd[9997]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[9997]: headset_probe: path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[9997]: Registered interface org.bluez.Input on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[9997]: Creating device /org/bluez/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[9997]: Creating device /org/bluez/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[9997]: Creating device /org/bluez/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[9997]: Creating device /org/bluez/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[9997]: Creating device /org/bluez/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[9997]: Creating device /org/bluez/hci0/dev_00_03_89_FE_E6_19
bluetoothd[9997]: Creating device /org/bluez/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[9997]: Creating device /org/bluez/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[9997]: Creating device /org/bluez/hci0/dev_00_17_E5_16_88_6C
bluetoothd[9997]: Creating device /org/bluez/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[9997]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[9997]: Starting security manager 0
bluetoothd[9997]: child 10014 exited
bluetoothd[9997]: Computer is classified as desktop
bluetoothd[9997]: Current device class is 0x4a0100
bluetoothd[9997]: Setting 0x000104 for major/minor device class
bluetoothd[9997]: Accepted new client connection on unix socket (fd=23)
bluetoothd[9997]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[9997]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[9997]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[9997]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[9997]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[9997]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[9997]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[9997]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[9997]: kernel auth requirements = 0x04
bluetoothd[9997]: stored link key type = 0x00
bluetoothd[9997]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[9997]: Received AT+BRSF=27
bluetoothd[9997]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
bluetoothd[9997]: Received AT+CIND=?
bluetoothd[9997]: Received AT+CIND?
bluetoothd[9997]: Received AT+CMER=3, 0, 0, 1
bluetoothd[9997]: Event reporting (CMER): mode=3, ind=1
bluetoothd[9997]: HFP Service Level Connection established
bluetoothd[9997]: telephony-dummy: device 0xb904d860 connected
bluetoothd[9997]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[9997]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[9997]: Received AT+VGS=14
bluetoothd[9997]: connect(): Connection timed out (110)
bluetoothd[9997]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[9997]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[9997]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[9997]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[9997]: Audio API: sending BT_STREAMFD_IND
bluetoothd[9997]: unix_sendmsg_fd: Bad file descriptor(9)
bluetoothd[9997]: resume failed
bluetoothd[9997]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[9997]: Unix client disconnected (fd=23)
bluetoothd[9997]: No matching connection for handle 44
bluetoothd[9997]: Accepted new client connection on unix socket (fd=23)
bluetoothd[9997]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[9997]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[9997]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[9997]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[9997]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[9997]: connect(): Connection timed out (110)
bluetoothd[9997]: Unable to lock headset
bluetoothd[9997]: config failed
bluetoothd[9997]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[9997]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[9997]: Unix client disconnected (fd=23)
bluetoothd[9997]: No matching connection for handle 44
bluetoothd[9997]: Accepted new client connection on unix socket (fd=23)
bluetoothd[9997]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[9997]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[9997]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[9997]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[9997]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[9997]: Received AT+VGS=15
bluetoothd[9997]: Unix client disconnected (fd=23)
bluetoothd[9997]: telephony-dummy: device 0xb904d860 disconnected
bluetoothd[9997]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[9997]: Accepted new client connection on unix socket (fd=23)
bluetoothd[9997]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[9997]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[9997]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[9997]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[9997]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[9997]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[9997]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[9997]: Received AT+BRSF=27
bluetoothd[9997]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
bluetoothd[9997]: Received AT+CIND=?
bluetoothd[9997]: Received AT+CIND?
bluetoothd[9997]: Received AT+CMER=3, 0, 0, 1
bluetoothd[9997]: Event reporting (CMER): mode=3, ind=1
bluetoothd[9997]: HFP Service Level Connection established
bluetoothd[9997]: telephony-dummy: device 0xb904d860 connected
bluetoothd[9997]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[9997]: connect: Operation not permitted (1)
bluetoothd[9997]: config failed
bluetoothd[9997]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[9997]: Unix client disconnected (fd=23)
bluetoothd[9997]: Received AT+VGS=15
bluetoothd[9997]: connect(): Connection timed out (110)
Segmentation fault (core dumped)

:; gdb src/.libs/bluetoothd   core
GNU gdb 6.8-debian
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i486-linux-gnu"...

warning: core file may not match specified executable file.
Core was generated by `/home/stuart/ws/install/bluez/git/bluez/src/.libs/lt-bluetoothd -dn'.
Program terminated with signal 11, Segmentation fault.
[New process 9997]
#0  0xb7c4da16 in ?? ()
(gdb) quit
:; ls /home/stuart/ws/install/bluez/git/bluez/src/.libs
bluetoothd  lt-bluetoothd
:; gdb /home/stuart/ws/install/bluez/git/bluez/src/.libs/lt-bluetoothd core
GNU gdb 6.8-debian
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i486-linux-gnu"...
Core was generated by `/home/stuart/ws/install/bluez/git/bluez/src/.libs/lt-bluetoothd -dn'.
Program terminated with signal 11, Segmentation fault.
[New process 9997]
#0  0xb7c4da16 in ?? ()
(gdb) where
#0  0xb7c4da16 in ?? ()
#1  0xb7c5f1e3 in ?? ()
#2  0xb7dceda5 in ?? ()
#3  0x0000006e in ?? ()
#4  0xb7df3afa in ?? ()
#5  0xbff5c4b0 in ?? ()
#6  0xbff5c472 in ?? ()
#7  0x00000010 in ?? ()
#8  0xb7deaff4 in ?? ()
#9  0xb904d860 in ?? ()
#10 0xb904dcb0 in ?? ()
#11 0x00000000 in ?? ()
