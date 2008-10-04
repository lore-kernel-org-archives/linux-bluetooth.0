Return-Path: <cyrus@holtmann.org>
Message-ID: <48E7FB1E.8000504@pook.es>
Date: Sun, 05 Oct 2008 01:24:14 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez-4.11 + 2.6.27-rc8 + SCO headset -> bluetoothd: connect():
 Connection timed out (110)
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net>
In-Reply-To: <1223121068.11272.46.camel@violet.holtmann.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel

On 04/10/08 13:51, Marcel Holtmann wrote:
>>> There is a regression on bluetoothd daemon, we introduce a SCO socket
>>> listen recently which is causing the problem, although it seem that
>>> the driver is also cooperating with the problem.
>> ok. Thanks for the information. Would installing bluez-4.10 help? 
> I will release 4.11 over the weekend and that should fix it.

not for me :-( I am once again getting the "aplay: set_params:979:
Unable to install hw params:" message after a 40 second delay.

The headset hisses softly to me during these 40 seconds.

The error message from bluetoothd is "connect(): Connection timed out (110)"

Sometimes bluetoothd segfaults.

Would you like to see the output of hcidump?

Oct  5 01:08:44 kooka bluetoothd[21788]: Bluetooth daemon
Oct  5 01:08:44 kooka bluetoothd[21788]: Enabling debug information
Oct  5 01:08:44 kooka bluetoothd[21788]: parsing main.conf
Oct  5 01:08:44 kooka bluetoothd[21788]: offmode=NoScan
Oct  5 01:08:44 kooka bluetoothd[21788]: discovto=0
Oct  5 01:08:44 kooka bluetoothd[21788]: pageto=8192
Oct  5 01:08:44 kooka bluetoothd[21788]: name=%h-%d
Oct  5 01:08:44 kooka bluetoothd[21788]: class=0x000100
Oct  5 01:08:44 kooka bluetoothd[21788]: inqmode=0
Oct  5 01:08:44 kooka bluetoothd[21788]: Starting SDP server
Oct  5 01:08:44 kooka bluetoothd[21788]: Loading plugins /usr/local/lib/bluetooth/plugins
Oct  5 01:08:44 kooka bluetoothd[21788]: /usr/local/lib/bluetooth/plugins/audio.so
Oct  5 01:08:44 kooka bluetoothd[21788]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
Oct  5 01:08:44 kooka bluetoothd[21788]: Unix socket created: 11
Oct  5 01:08:44 kooka bluetoothd[21788]: Telephony plugin initialized
Oct  5 01:08:44 kooka bluetoothd[21788]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes"
Oct  5 01:08:44 kooka bluetoothd[21788]: /usr/local/lib/bluetooth/plugins/serial.so
Oct  5 01:08:44 kooka bluetoothd[21788]: /usr/local/lib/bluetooth/plugins/hal.so
Oct  5 01:08:44 kooka bluetoothd[21788]: /usr/local/lib/bluetooth/plugins/service.so
Oct  5 01:08:44 kooka bluetoothd[21788]: /usr/local/lib/bluetooth/plugins/network.so
Oct  5 01:08:44 kooka bluetoothd[21788]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
Oct  5 01:08:44 kooka bluetoothd[21788]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
Oct  5 01:08:44 kooka bluetoothd[21788]: bridge pan0 created
Oct  5 01:08:44 kooka bluetoothd[21788]: /usr/local/lib/bluetooth/plugins/input.so
Oct  5 01:08:44 kooka bluetoothd[21788]: input.conf: Key file does not have key 'IdleTimeout'
Oct  5 01:08:44 kooka bluetoothd[21788]: HCI dev 0 registered
Oct  5 01:08:44 kooka bluetoothd[21788]: child 21791 forked
Oct  5 01:08:44 kooka bluetoothd[21788]: HCI dev 0 already up
Oct  5 01:08:44 kooka bluetoothd[21788]: headset_server_probe: path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: Adding record with handle 0x10000
Oct  5 01:08:44 kooka bluetoothd[21788]: Adding record with handle 0x10001
Oct  5 01:08:44 kooka bluetoothd[21788]: a2dp_server_probe: path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: SEP 0xb9818800 registered: type:0 codec:0 seid:1
Oct  5 01:08:44 kooka bluetoothd[21788]: Adding record with handle 0x10002
Oct  5 01:08:44 kooka bluetoothd[21788]: avrcp_server_probe: path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: Adding record with handle 0x10003
Oct  5 01:08:44 kooka bluetoothd[21788]: Adding record with handle 0x10004
Oct  5 01:08:44 kooka bluetoothd[21788]: proxy_probe: path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: service_probe: path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: Registered interface org.bluez.Service on path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: network_server_probe: path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: Adding record with handle 0x10005
Oct  5 01:08:44 kooka bluetoothd[21788]: register_server_record: got record id 0x10005
Oct  5 01:08:44 kooka bluetoothd[21788]: Registered interface org.bluez.NetworkPeer on path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: network_server_probe: path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: Adding record with handle 0x10006
Oct  5 01:08:44 kooka bluetoothd[21788]: register_server_record: got record id 0x10006
Oct  5 01:08:44 kooka bluetoothd[21788]: Registered interface org.bluez.NetworkHub on path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: network_server_probe: path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: Adding record with handle 0x10007
Oct  5 01:08:44 kooka bluetoothd[21788]: register_server_record: got record id 0x10007
Oct  5 01:08:44 kooka bluetoothd[21788]: Registered interface org.bluez.NetworkRouter on path /org/bluez/hci0
Oct  5 01:08:44 kooka bluetoothd[21788]: Creating device /org/bluez/hci0/dev_00_1A_45_2F_49_98
Oct  5 01:08:44 kooka bluetoothd[21788]: Probe drivers for /org/bluez/hci0/dev_00_1A_45_2F_49_98
Oct  5 01:08:44 kooka bluetoothd[21788]: Found Headset record
Oct  5 01:08:44 kooka bluetoothd[21788]: Discovered Headset service on RFCOMM channel 2
Oct  5 01:08:44 kooka bluetoothd[21788]: Registered interface org.bluez.Headset on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
Oct  5 01:08:44 kooka bluetoothd[21788]: Found Hansfree record
Oct  5 01:08:44 kooka bluetoothd[21788]: Discovered Handsfree service on RFCOMM channel 1
Oct  5 01:08:44 kooka bluetoothd[21788]: headset_probe: path /org/bluez/hci0/dev_00_1A_45_2F_49_98
Oct  5 01:08:44 kooka bluetoothd[21788]: Registered interface org.bluez.Input on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
Oct  5 01:08:44 kooka bluetoothd[21788]: Creating device /org/bluez/hci0/dev_00_14_A7_74_D3_AF
Oct  5 01:08:44 kooka bluetoothd[21788]: Creating device /org/bluez/hci0/dev_00_03_89_B7_F8_D3
Oct  5 01:08:44 kooka bluetoothd[21788]: Creating device /org/bluez/hci0/dev_00_0A_94_94_4F_B3
Oct  5 01:08:44 kooka bluetoothd[21788]: Creating device /org/bluez/hci0/dev_00_03_89_DC_5C_9F
Oct  5 01:08:44 kooka bluetoothd[21788]: Creating device /org/bluez/hci0/dev_00_03_89_DC_FC_EC
Oct  5 01:08:44 kooka bluetoothd[21788]: Creating device /org/bluez/hci0/dev_00_03_89_FE_E6_19
Oct  5 01:08:44 kooka bluetoothd[21788]: Creating device /org/bluez/hci0/dev_00_0E_6D_8F_91_6A
Oct  5 01:08:44 kooka bluetoothd[21788]: Creating device /org/bluez/hci0/dev_00_17_E5_E6_25_AB
Oct  5 01:08:44 kooka bluetoothd[21788]: Creating device /org/bluez/hci0/dev_00_17_E5_16_88_6C
Oct  5 01:08:44 kooka bluetoothd[21788]: Creating device /org/bluez/hci0/dev_00_17_E5_0C_EA_70
Oct  5 01:08:44 kooka bluetoothd[21788]: Adapter /org/bluez/hci0 has been enabled
Oct  5 01:08:44 kooka bluetoothd[21788]: Starting security manager 0
Oct  5 01:08:44 kooka bluetoothd[21788]: child 21791 exited
Oct  5 01:08:44 kooka bluetoothd[21788]: Computer is classified as desktop
Oct  5 01:08:44 kooka bluetoothd[21788]: Current device class is 0x4a0104
Oct  5 01:08:44 kooka bluetoothd[21788]: Setting 0x000104 for major/minor device class
Oct  5 01:09:03 kooka bluetoothd[21788]: Accepted new client connection on unix socket (fd=23)
Oct  5 01:09:03 kooka bluetoothd[21788]: Audio API: received BT_GETCAPABILITIES_REQ
Oct  5 01:09:03 kooka bluetoothd[21788]: Audio API: sending BT_GETCAPABILITIES_RSP
Oct  5 01:09:03 kooka bluetoothd[21788]: Audio API: received BT_SETCONFIGURATION_REQ
Oct  5 01:09:03 kooka bluetoothd[21788]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
Oct  5 01:09:03 kooka bluetoothd[21788]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
Oct  5 01:09:03 kooka bluetoothd[21788]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
Oct  5 01:09:06 kooka bluetoothd[21788]: adapter_get_device(00:1A:45:2F:49:98)
Oct  5 01:09:07 kooka bluetoothd[21788]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
Oct  5 01:09:07 kooka bluetoothd[21788]: kernel auth requirements = 0x04
Oct  5 01:09:07 kooka bluetoothd[21788]: stored link key type = 0x00
Oct  5 01:09:07 kooka bluetoothd[21788]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
Oct  5 01:09:07 kooka bluetoothd[21788]: Received AT+BRSF=27
Oct  5 01:09:07 kooka bluetoothd[21788]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
Oct  5 01:09:08 kooka bluetoothd[21788]: Received AT+CIND=?
Oct  5 01:09:08 kooka bluetoothd[21788]: Received AT+CIND?
Oct  5 01:09:08 kooka bluetoothd[21788]: Received AT+CMER=3, 0, 0, 1
Oct  5 01:09:08 kooka bluetoothd[21788]: Event reporting (CMER): mode=3, ind=1
Oct  5 01:09:08 kooka bluetoothd[21788]: HFP Service Level Connection established
Oct  5 01:09:08 kooka bluetoothd[21788]: telephony-dummy: device 0xb981d4f8 connected
Oct  5 01:09:08 kooka bluetoothd[21788]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Oct  5 01:09:08 kooka bluetoothd[21788]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
Oct  5 01:09:08 kooka bluetoothd[21788]: Received AT+VGS=15
Oct  5 01:09:48 kooka bluetoothd[21788]: connect(): Connection timed out (110)
Oct  5 01:09:48 kooka bluetoothd[21788]: Audio API: sending BT_SETCONFIGURATION_RSP
Oct  5 01:09:48 kooka bluetoothd[21788]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Oct  5 01:09:48 kooka bluetoothd[21788]: Audio API: received BT_STREAMSTART_REQ
Oct  5 01:09:48 kooka bluetoothd[21788]: Audio API: sending BT_STREAMSTART_RSP
Oct  5 01:09:48 kooka bluetoothd[21788]: Audio API: sending BT_STREAMFD_IND
Oct  5 01:09:48 kooka bluetoothd[21788]: unix_sendmsg_fd: Bad file descriptor(9)
Oct  5 01:09:48 kooka bluetoothd[21788]: resume failed
Oct  5 01:09:48 kooka bluetoothd[21788]: Audio API: sending BT_STREAMSTART_RSP
Oct  5 01:09:48 kooka bluetoothd[21788]: Unix client disconnected (fd=23)
Oct  5 01:09:48 kooka bluetoothd[21788]: No matching connection for handle 49

bluetoothd[22825]: Bluetooth daemon
bluetoothd[22825]: Enabling debug information
bluetoothd[22825]: parsing main.conf
bluetoothd[22825]: offmode=NoScan
bluetoothd[22825]: discovto=0
bluetoothd[22825]: pageto=8192
bluetoothd[22825]: name=%h-%d
bluetoothd[22825]: class=0x000100
bluetoothd[22825]: inqmode=0
bluetoothd[22825]: Starting SDP server
bluetoothd[22825]: Loading plugins /usr/local/lib/bluetooth/plugins
bluetoothd[22825]: /usr/local/lib/bluetooth/plugins/audio.so
bluetoothd[22825]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[22825]: Unix socket created: 11
bluetoothd[22825]: Telephony plugin initialized
bluetoothd[22825]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes"
bluetoothd[22825]: /usr/local/lib/bluetooth/plugins/serial.so
bluetoothd[22825]: /usr/local/lib/bluetooth/plugins/hal.so
bluetoothd[22825]: /usr/local/lib/bluetooth/plugins/service.so
bluetoothd[22825]: /usr/local/lib/bluetooth/plugins/network.so
bluetoothd[22825]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
bluetoothd[22825]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[22825]: bridge pan0 created
bluetoothd[22825]: /usr/local/lib/bluetooth/plugins/input.so
bluetoothd[22825]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[22825]: HCI dev 0 registered
bluetoothd[22825]: child 22828 forked
bluetoothd[22825]: HCI dev 0 already up
bluetoothd[22825]: headset_server_probe: path /org/bluez/hci0
bluetoothd[22825]: Adding record with handle 0x10000
bluetoothd[22825]: Adding record with handle 0x10001
bluetoothd[22825]: a2dp_server_probe: path /org/bluez/hci0
bluetoothd[22825]: SEP 0xb8a9b818 registered: type:0 codec:0 seid:1
bluetoothd[22825]: Adding record with handle 0x10002
bluetoothd[22825]: avrcp_server_probe: path /org/bluez/hci0
bluetoothd[22825]: Adding record with handle 0x10003
bluetoothd[22825]: Adding record with handle 0x10004
bluetoothd[22825]: proxy_probe: path /org/bluez/hci0
bluetoothd[22825]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/hci0
bluetoothd[22825]: service_probe: path /org/bluez/hci0
bluetoothd[22825]: Registered interface org.bluez.Service on path /org/bluez/hci0
bluetoothd[22825]: network_server_probe: path /org/bluez/hci0
bluetoothd[22825]: Adding record with handle 0x10005
bluetoothd[22825]: register_server_record: got record id 0x10005
bluetoothd[22825]: Registered interface org.bluez.NetworkPeer on path /org/bluez/hci0
bluetoothd[22825]: network_server_probe: path /org/bluez/hci0
bluetoothd[22825]: Adding record with handle 0x10006
bluetoothd[22825]: register_server_record: got record id 0x10006
bluetoothd[22825]: Registered interface org.bluez.NetworkHub on path /org/bluez/hci0
bluetoothd[22825]: network_server_probe: path /org/bluez/hci0
bluetoothd[22825]: Adding record with handle 0x10007
bluetoothd[22825]: register_server_record: got record id 0x10007
bluetoothd[22825]: Registered interface org.bluez.NetworkRouter on path /org/bluez/hci0
bluetoothd[22825]: Creating device /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[22825]: Probe drivers for /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[22825]: Found Headset record
bluetoothd[22825]: Discovered Headset service on RFCOMM channel 2
bluetoothd[22825]: Registered interface org.bluez.Headset on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[22825]: Found Hansfree record
bluetoothd[22825]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[22825]: headset_probe: path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[22825]: Registered interface org.bluez.Input on path /org/bluez/hci0/dev_00_1A_45_2F_49_98
bluetoothd[22825]: Creating device /org/bluez/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[22825]: Creating device /org/bluez/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[22825]: Creating device /org/bluez/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[22825]: Creating device /org/bluez/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[22825]: Creating device /org/bluez/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[22825]: Creating device /org/bluez/hci0/dev_00_03_89_FE_E6_19
bluetoothd[22825]: Creating device /org/bluez/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[22825]: Creating device /org/bluez/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[22825]: Creating device /org/bluez/hci0/dev_00_17_E5_16_88_6C
bluetoothd[22825]: Creating device /org/bluez/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[22825]: Adapter /org/bluez/hci0 has been enabled
bluetoothd[22825]: Starting security manager 0
bluetoothd[22825]: child 22828 exited
bluetoothd[22825]: Computer is classified as desktop
bluetoothd[22825]: Current device class is 0x4a0104
bluetoothd[22825]: Setting 0x000104 for major/minor device class
bluetoothd[22825]: Accepted new client connection on unix socket (fd=23)
bluetoothd[22825]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[22825]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[22825]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[22825]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[22825]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[22825]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[22825]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[22825]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[22825]: kernel auth requirements = 0x04
bluetoothd[22825]: stored link key type = 0x00
bluetoothd[22825]: /org/bluez/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[22825]: Received AT+BRSF=27
bluetoothd[22825]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control"
bluetoothd[22825]: Received AT+CIND=?
bluetoothd[22825]: Received AT+CIND?
bluetoothd[22825]: Received AT+CMER=3, 0, 0, 1
bluetoothd[22825]: Event reporting (CMER): mode=3, ind=1
bluetoothd[22825]: HFP Service Level Connection established
bluetoothd[22825]: telephony-dummy: device 0xb8aa0518 connected
bluetoothd[22825]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[22825]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[22825]: Received AT+VGS=15
bluetoothd[22825]: connect(): Connection timed out (110)
bluetoothd[22825]: Audio API: sending BT_SETCONFIGURATION_RSP
bluetoothd[22825]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[22825]: Audio API: received BT_STREAMSTART_REQ
bluetoothd[22825]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[22825]: Audio API: sending BT_STREAMFD_IND
bluetoothd[22825]: unix_sendmsg_fd: Bad file descriptor(9)
bluetoothd[22825]: resume failed
bluetoothd[22825]: Audio API: sending BT_STREAMSTART_RSP
bluetoothd[22825]: Unix client disconnected (fd=23)
bluetoothd[22825]: No matching connection for handle 53
bluetoothd[22825]: Accepted new client connection on unix socket (fd=23)
bluetoothd[22825]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[22825]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[22825]: Unix client disconnected (fd=23)
bluetoothd[22825]: Accepted new client connection on unix socket (fd=23)
bluetoothd[22825]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[22825]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[22825]: Audio API: received BT_SETCONFIGURATION_REQ
bluetoothd[22825]: config sco - device = 00:1A:45:2F:49:98 access_mode = 2
bluetoothd[22825]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[22825]: Unix client disconnected (fd=23)
bluetoothd[22825]: telephony-dummy: device 0xb8aa0518 disconnected
bluetoothd[22825]: State changed /org/bluez/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[22825]: connect(): Connection timed out (110)
Segmentation fault
