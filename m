Return-Path: <cyrus@holtmann.org>
Message-ID: <48EA7B66.1050208@pook.es>
Date: Mon, 06 Oct 2008 22:56:06 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez/git + 2.6.27-rc8 + SCO headset -> SIGSEGV
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net> <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com> <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com> <0ED1CF2A-40D0-4A82-BAED-21F90B6466ED@gmail.com> <48EA6D84.7020101@pook.es> <632D4195-1EFF-4191-98D9-4A0953223590@gmail.com>
In-Reply-To: <632D4195-1EFF-4191-98D9-4A0953223590@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Johan

> however could you try to get a backtrace with gdb as well since it seems 
> that valgrind either distorts or hides some errors.

I guess that I have forgotten how to use gdb because the backtrace
doesn't tell me much. Or perhaps I have to recompile with "-g".

: root@kooka; gdb  src/.libs/bluetoothd
GNU gdb 6.8-debian
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i486-linux-gnu"...
(gdb) run -dn
Starting program: /ws/stuart/install/bluez/git/bluez/src/.libs/bluetoothd -dn
bluetoothd[4220]: Bluetooth daemon
bluetoothd[4220]: Enabling debug information
bluetoothd[4220]: parsing main.conf
bluetoothd[4220]: offmode=NoScan
bluetoothd[4220]: discovto=0
bluetoothd[4220]: pageto=8192
bluetoothd[4220]: name=%h-%d
bluetoothd[4220]: class=0x000100
bluetoothd[4220]: inqmode=0
bluetoothd[4220]: Starting SDP server
bluetoothd[4220]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[4220]: /home/stuart/ws/install/bluez/git/bluez/plugins/audio.so
bluetoothd[4220]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[4220]: Unix socket created: 13
bluetoothd[4220]: Telephony plugin initialized
bluetoothd[4220]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes"
bluetoothd[4220]: /home/stuart/ws/install/bluez/git/bluez/plugins/serial.so
bluetoothd[4220]: /home/stuart/ws/install/bluez/git/bluez/plugins/hal.so
bluetoothd[4220]: /home/stuart/ws/install/bluez/git/bluez/plugins/service.so
bluetoothd[4220]: /home/stuart/ws/install/bluez/git/bluez/plugins/network.so
bluetoothd[4220]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
bluetoothd[4220]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[4220]: Can't create GN bridge
bluetoothd[4220]: /home/stuart/ws/install/bluez/git/bluez/plugins/input.so
bluetoothd[4220]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[4220]: HCI dev 0 registered
bluetoothd[4220]: child 4223 forked
bluetoothd[4220]: HCI dev 0 already up
bluetoothd[4220]: headset_server_probe: path /org/bluez/hci0
bluetoothd[4220]: Adding record with handle 0x10000
bluetoothd[4220]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[4220]: Adding record with handle 0x10001
bluetoothd[4220]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[4220]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[4220]: SEP 0xb90df780 registered: type:0 codec:0 seid:1
bluetoothd[4220]: Adding record with handle 0x10002
bluetoothd[4220]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[4220]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[4220]: Adding record with handle 0x10003
bluetoothd[4220]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[4220]: Adding record with handle 0x10004
bluetoothd[4220]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[4220]: proxy_probe: path /org/bluez/hci0
bluetoothd[4220]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/hci0
bluetoothd[4220]: service_probe: path /org/bluez/hci0
bluetoothd[4220]: Registered interface org.bluez.Service on path /org/bluez/hci0
bluetoothd[4220]: network_server_probe: path /org/bluez/hci0
bluetoothd[4220]: Adding record with handle 0x10005
bluetoothd[4220]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[4220]: register_server_record: got record id 0x10005
bluetoothd[4220]: Registered interface org.bluez.NetworkPeer on path /org/bluez/hci0
bluetoothd[4220]: network_server_probe: path /org/bluez/hci0
bluetoothd[4220]: Adding record with handle 0x10006
bluetoothd[4220]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[4220]: register_server_record: got record id 0x10006
bluetoothd[4220]: Registered interface org.bluez.NetworkHub on path /org/bluez/hci0
bluetoothd[4220]: network_server_probe: path /org/bluez/hci0
bluetoothd[4220]: Adding record with handle 0x10007
bluetoothd[4220]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4220]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[4220]: register_server_record: got record id 0x10007
bluetoothd[4220]: Registered interface org.bluez.NetworkRouter on path /org/bluez/hci0
bluetoothd[4220]: Creating device /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[4220]: Probe drivers for /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[4220]: Found Headset record
bluetoothd[4220]: Discovered Headset service on RFCOMM channel 2
bluetoothd[4220]: Registered interface org.bluez.Headset on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[4220]: Found Hansfree record
bluetoothd[4220]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[4220]: headset_probe: path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[4220]: Registered interface org.bluez.Input on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[4220]: Creating device /org/bluez/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[4220]: Creating device /org/bluez/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[4220]: Creating device /org/bluez/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[4220]: Creating device /org/bluez/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[4220]: Creating device /org/bluez/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[4220]: Creating device /org/bluez/hci0/dev_00_03_89_FE_E6_19
bluetoothd[4220]: Creating device /org/bluez/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[4220]: Creating device /org/bluez/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[4220]: Creating device /org/bluez/hci0/dev_00_17_E5_16_88_6C
bluetoothd[4220]: Creating device /org/bluez/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[4220]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[4220]: Starting security manager 0
bluetoothd[4220]: child 4223 exited
bluetoothd[4220]: Computer is classified as desktop
bluetoothd[4220]: Current device class is 0x4a0104
bluetoothd[4220]: Setting 0x000104 for major/minor device class
bluetoothd[4220]: Accepted new client connection on unix socket (fd=25)
bluetoothd[4220]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4220]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4220]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[4220]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[4220]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[4220]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[4220]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[4220]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[4220]: kernel auth requirements = 0x04
bluetoothd[4220]: stored link key type = 0x00
bluetoothd[4220]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[4220]: Received AT+BRSF=27
bluetoothd[4220]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
bluetoothd[4220]: Received AT+CIND=?
bluetoothd[4220]: Received AT+CIND?
bluetoothd[4220]: Received AT+CMER=3, 0, 0, 1
bluetoothd[4220]: Event reporting (CMER): mode=3, ind=1
bluetoothd[4220]: HFP Service Level Connection established
bluetoothd[4220]: telephony-dummy: device 0xb90e45f0 connected
bluetoothd[4220]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[4220]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[4220]: Received AT+VGS=15
bluetoothd[4220]: connect(): Connection timed out (110)
bluetoothd[4220]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[4220]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[4220]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[4220]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[4220]: Audio API: sending BT_STREAMFD_IND
bluetoothd[4220]: unix_sendmsg_fd: Bad file descriptor(9)
bluetoothd[4220]: resume failed
bluetoothd[4220]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[4220]: Unix client disconnected (fd=25)
bluetoothd[4220]: No matching connection for handle 45
bluetoothd[4220]: Accepted new client connection on unix socket (fd=25)
bluetoothd[4220]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4220]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4220]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[4220]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[4220]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[4220]: Unix client disconnected (fd=25)
bluetoothd[4220]: telephony-dummy: device 0xb90e45f0 disconnected
bluetoothd[4220]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[4220]: Accepted new client connection on unix socket (fd=25)
bluetoothd[4220]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[4220]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[4220]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[4220]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[4220]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[4220]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[4220]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[4220]: Received AT+BRSF=27
bluetoothd[4220]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
bluetoothd[4220]: Received AT+CIND=?
bluetoothd[4220]: Received AT+CIND?
bluetoothd[4220]: Received AT+CMER=3, 0, 0, 1
bluetoothd[4220]: Event reporting (CMER): mode=3, ind=1
bluetoothd[4220]: HFP Service Level Connection established
bluetoothd[4220]: telephony-dummy: device 0xb90e45f0 connected
bluetoothd[4220]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[4220]: connect: Operation not permitted (1)
bluetoothd[4220]: config failed
bluetoothd[4220]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[4220]: Unix client disconnected (fd=25)
bluetoothd[4220]: Received AT+VGS=15
bluetoothd[4220]: connect(): Connection timed out (110)

Program received signal SIGSEGV, Segmentation fault.
0xb7deda16 in ?? ()
(gdb) where
#0  0xb7deda16 in ?? ()
#1  0xb7dff1e3 in ?? ()
#2  0xb7f6eda5 in ?? ()
#3  0x0000006e in ?? ()
#4  0xb80319e4 in ?? ()
#5  0xb7f9e86c in ?? ()
#6  0xbfff8d1b in ?? ()
#7  0xbfff8d16 in ?? ()
#8  0xb7f8aff4 in ?? ()
#9  0xb90e45f0 in ?? ()
#10 0xb90e4a40 in ?? ()
#11 0x00000000 in ?? ()
(gdb) bt
#0  0xb7deda16 in ?? ()
#1  0xb7dff1e3 in ?? ()
#2  0xb7f6eda5 in ?? ()
#3  0x0000006e in ?? ()
#4  0xb80319e4 in ?? ()
#5  0xb7f9e86c in ?? ()
#6  0xbfff8d1b in ?? ()
#7  0xbfff8d16 in ?? ()
#8  0xb7f8aff4 in ?? ()
#9  0xb90e45f0 in ?? ()
#10 0xb90e4a40 in ?? ()
#11 0x00000000 in ?? ()

