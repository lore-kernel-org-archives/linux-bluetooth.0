Return-Path: <cyrus@holtmann.org>
Subject: If adapter is replugged bluetoothd gives "Unable to find matching
 adapter"
From: Valmantas =?UTF-8?Q?Palik=C5=A1a?= <walmis@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Nk8XpEm2yIqhvlgfDf0k"
Date: Fri, 11 Dec 2009 10:08:52 +0200
Message-ID: <1260518932.3029.5.camel@walmis-desktop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-Nk8XpEm2yIqhvlgfDf0k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I started noticing this after I upgraded the desktop pc.
If adapter is plugged and you start bluetoothd, everything is fine.
When you unplug and replug the adapter while bluetoothd is running, it
will fail with "Unable to find matching adapter". If you kill and start
bluetoothd again, it will work fine.
Same with 2.6.31 and 2.6.32.

--=-Nk8XpEm2yIqhvlgfDf0k
Content-Disposition: attachment; filename="bluetoothd.log"
Content-Type: text/x-log; name="bluetoothd.log"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[walmis@walmis-desktop Desktop]$ sudo bluetoothd -nd
bluetoothd[3005]: Bluetooth daemon 4.57
bluetoothd[3005]: Enabling debug information
bluetoothd[3005]: parsing main.conf
bluetoothd[3005]: discovto=0
bluetoothd[3005]: pairto=0
bluetoothd[3005]: pageto=8192
bluetoothd[3005]: name=%h-%d
bluetoothd[3005]: class=0x000100
bluetoothd[3005]: discov_interval=0
bluetoothd[3005]: Key file does not have key 'DeviceID'
bluetoothd[3005]: Starting SDP server
bluetoothd[3005]: Loading builtin plugins
bluetoothd[3005]: Loading audio plugin
bluetoothd[3005]: Loading input plugin
bluetoothd[3005]: Loading serial plugin
bluetoothd[3005]: Loading network plugin
bluetoothd[3005]: Loading service plugin
bluetoothd[3005]: Loading hciops plugin
bluetoothd[3005]: Loading hal plugin
bluetoothd[3005]: Loading storage plugin
bluetoothd[3005]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[3005]: Can't load plugin /usr/lib/bluetooth/plugins/netlink.so: /usr/lib/bluetooth/plugins/netlink.so: undefined symbol: debug
bluetoothd[3005]: register_interface: path /org/bluez/3005/any
bluetoothd[3005]: Registered interface org.bluez.Service on path /org/bluez/3005/any
bluetoothd[3005]: /etc/bluetooth/network.conf: Key file does not have key 'Disable'
bluetoothd[3005]: /etc/bluetooth/network.conf: Key file does not have key 'DisableSecurity'
bluetoothd[3005]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[3005]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[3005]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[3005]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[3005]: bridge pan0 created
bluetoothd[3005]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[3005]: Unix socket created: 9
bluetoothd[3005]: audio.conf: Key file does not have key 'AutoConnect'
bluetoothd[3005]: audio.conf: Key file does not have key 'MaxConnected'
bluetoothd[3005]: Telephony plugin initialized
bluetoothd[3005]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[3005]: HCI dev 0 registered
bluetoothd[3005]: child 3006 forked
bluetoothd[3005]: btd_adapter_ref(0x7faa7fd09f20): ref=1
bluetoothd[3005]: Entering main loop
bluetoothd[3005]: RFKILL event idx 0 type 2 op 0 soft 0 hard 0
bluetoothd[3005]: HCI dev 0 up
bluetoothd[3005]: Starting security manager 0
bluetoothd[3005]: Changing Major/Minor class to 0x000104
bluetoothd[3005]: register_interface: path /org/bluez/3005/hci0
bluetoothd[3005]: Registered interface org.bluez.Service on path /org/bluez/3005/hci0
bluetoothd[3005]: network_server_probe: path /org/bluez/3005/hci0
bluetoothd[3005]: btd_adapter_ref(0x7faa7fd09f20): ref=2
bluetoothd[3005]: Adding record with handle 0x10000
bluetoothd[3005]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[3005]: register_server_record: got record id 0x10000
bluetoothd[3005]: Registered interface org.bluez.NetworkPeer on path /org/bluez/3005/hci0
bluetoothd[3005]: network_server_probe: path /org/bluez/3005/hci0
bluetoothd[3005]: Adding record with handle 0x10001
bluetoothd[3005]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[3005]: register_server_record: got record id 0x10001
bluetoothd[3005]: Registered interface org.bluez.NetworkHub on path /org/bluez/3005/hci0
bluetoothd[3005]: network_server_probe: path /org/bluez/3005/hci0
bluetoothd[3005]: Adding record with handle 0x10002
bluetoothd[3005]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[3005]: register_server_record: got record id 0x10002
bluetoothd[3005]: Registered interface org.bluez.NetworkRouter on path /org/bluez/3005/hci0
bluetoothd[3005]: proxy_probe: path /org/bluez/3005/hci0
bluetoothd[3005]: btd_adapter_ref(0x7faa7fd09f20): ref=3
bluetoothd[3005]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/3005/hci0
bluetoothd[3005]: Parsing /etc/bluetooth/serial.conf failed: No such file or directory
bluetoothd[3005]: btd_adapter_ref(0x7faa7fd09f20): ref=4
bluetoothd[3005]: headset_server_probe: path /org/bluez/3005/hci0
bluetoothd[3005]: btd_adapter_ref(0x7faa7fd09f20): ref=5
bluetoothd[3005]: audio_adapter_ref(0x7faa7fd0ce80): ref=1
bluetoothd[3005]: audio.conf: Key file does not have key 'Master'
bluetoothd[3005]: Adding record with handle 0x10003
bluetoothd[3005]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3005]: audio.conf: Key file does not have key 'SCORouting'
bluetoothd[3005]: Adding record with handle 0x10004
bluetoothd[3005]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3005]: gateway_server_probe: path /org/bluez/3005/hci0
bluetoothd[3005]: audio_adapter_ref(0x7faa7fd0ce80): ref=2
bluetoothd[3005]: audio.conf: Key file does not have key 'Master'
bluetoothd[3005]: Adding record with handle 0x10005
bluetoothd[3005]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3005]: a2dp_server_probe: path /org/bluez/3005/hci0
bluetoothd[3005]: audio_adapter_ref(0x7faa7fd0ce80): ref=3
bluetoothd[3005]: audio.conf: Key file does not have key 'Disable'
bluetoothd[3005]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3005]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3005]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3005]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3005]: audio.conf: Key file does not have key 'Master'
bluetoothd[3005]: SEP 0x7faa7fd0edb0 registered: type:0 codec:0 seid:1
bluetoothd[3005]: Adding record with handle 0x10006
bluetoothd[3005]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3005]: SEP 0x7faa7fd0f220 registered: type:1 codec:0 seid:2
bluetoothd[3005]: Adding record with handle 0x10007
bluetoothd[3005]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 0000110b-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3005]: avrcp_server_probe: path /org/bluez/3005/hci0
bluetoothd[3005]: audio_adapter_ref(0x7faa7fd0ce80): ref=4
bluetoothd[3005]: audio.conf: Key file does not have key 'Master'
bluetoothd[3005]: Adding record with handle 0x10008
bluetoothd[3005]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3005]: Adding record with handle 0x10009
bluetoothd[3005]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3005]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3005]: Adapter /org/bluez/3005/hci0 has been enabled
bluetoothd[3005]: Stopping security manager 0
bluetoothd[3005]: child 3006 exited
bluetoothd[3005]: HCI dev 0 down
bluetoothd[3005]: Adapter /org/bluez/3005/hci0 has been disabled
bluetoothd[3005]: Computer is classified as desktop
bluetoothd[3005]: Setting 0x000104 for major/minor device class
bluetoothd[3005]: HCI dev 0 unregistered
bluetoothd[3005]: Unregister path: /org/bluez/3005/hci0
bluetoothd[3005]: Removing adapter /org/bluez/3005/hci0
bluetoothd[3005]: unregister_interface: path /org/bluez/3005/hci0
bluetoothd[3005]: network_server_remove: path /org/bluez/3005/hci0
bluetoothd[3005]: Unregistered interface org.bluez.NetworkPeer on path /org/bluez/3005/hci0
bluetoothd[3005]: Removing record with handle 0x10000
bluetoothd[3005]: network_server_remove: path /org/bluez/3005/hci0
bluetoothd[3005]: Unregistered interface org.bluez.NetworkHub on path /org/bluez/3005/hci0
bluetoothd[3005]: Removing record with handle 0x10001
bluetoothd[3005]: network_server_remove: path /org/bluez/3005/hci0
bluetoothd[3005]: Unregistered interface org.bluez.NetworkRouter on path /org/bluez/3005/hci0
bluetoothd[3005]: Removing record with handle 0x10002
bluetoothd[3005]: btd_adapter_unref(0x7faa7fd09f20): ref=4
bluetoothd[3005]: proxy_remove: path /org/bluez/3005/hci0
bluetoothd[3005]: btd_adapter_unref(0x7faa7fd09f20): ref=3
bluetoothd[3005]: btd_adapter_unref(0x7faa7fd09f20): ref=2
bluetoothd[3005]: headset_server_remove: path /org/bluez/3005/hci0
bluetoothd[3005]: Removing record with handle 0x10003
bluetoothd[3005]: Removing record with handle 0x10004
bluetoothd[3005]: audio_adapter_unref(0x7faa7fd0ce80): ref=3
bluetoothd[3005]: gateway_server_remove: path /org/bluez/3005/hci0
bluetoothd[3005]: Removing record with handle 0x10005
bluetoothd[3005]: audio_adapter_ref(0x7faa7fd0ce80): ref=4
bluetoothd[3005]: a2dp_server_remove: path /org/bluez/3005/hci0
bluetoothd[3005]: Removing record with handle 0x10006
bluetoothd[3005]: Removing record with handle 0x10007
bluetoothd[3005]: audio_adapter_unref(0x7faa7fd0ce80): ref=3
bluetoothd[3005]: avrcp_server_remove: path /org/bluez/3005/hci0
bluetoothd[3005]: Removing record with handle 0x10009
bluetoothd[3005]: Removing record with handle 0x10008
bluetoothd[3005]: audio_adapter_unref(0x7faa7fd0ce80): ref=2
bluetoothd[3005]: btd_adapter_unref(0x7faa7fd09f20): ref=1
bluetoothd[3005]: RFKILL event idx 0 type 2 op 1 soft 0 hard 0
bluetoothd[3005]: HCI dev 0 registered
bluetoothd[3005]: child 3008 forked
bluetoothd[3005]: Adapter interface init failed on path /org/bluez/3005/hci0
bluetoothd[3005]: adapter_free(0x7faa7fd0c4d0)
bluetoothd[3005]: RFKILL event idx 1 type 2 op 0 soft 0 hard 0
bluetoothd[3005]: RFKILL event idx 1 type 2 op 2 soft 0 hard 0
bluetoothd[3005]: HCI dev 0 up
bluetoothd[3005]: Starting security manager 0
bluetoothd[3005]: Getting device data failed: hci0
bluetoothd[3005]: child 3008 exited
bluetoothd[3005]: Unable to find matching adapter
^Cbluetoothd[3005]: Cleanup plugins
bluetoothd[3005]: unregister_interface: path /org/bluez/3005/any
bluetoothd[3005]: bridge pan0 removed
bluetoothd[3005]: Stopping SDP server
bluetoothd[3005]: Exit

[walmis@walmis-desktop Desktop]$ sudo bluetoothd -nd

bluetoothd[3011]: Bluetooth daemon 4.57
bluetoothd[3011]: Enabling debug information
bluetoothd[3011]: parsing main.conf
bluetoothd[3011]: discovto=0
bluetoothd[3011]: pairto=0
bluetoothd[3011]: pageto=8192
bluetoothd[3011]: name=%h-%d
bluetoothd[3011]: class=0x000100
bluetoothd[3011]: discov_interval=0
bluetoothd[3011]: Key file does not have key 'DeviceID'
bluetoothd[3011]: Starting SDP server
bluetoothd[3011]: Loading builtin plugins
bluetoothd[3011]: Loading audio plugin
bluetoothd[3011]: Loading input plugin
bluetoothd[3011]: Loading serial plugin
bluetoothd[3011]: Loading network plugin
bluetoothd[3011]: Loading service plugin
bluetoothd[3011]: Loading hciops plugin
bluetoothd[3011]: Loading hal plugin
bluetoothd[3011]: Loading storage plugin
bluetoothd[3011]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[3011]: Can't load plugin /usr/lib/bluetooth/plugins/netlink.so: /usr/lib/bluetooth/plugins/netlink.so: undefined symbol: debug
bluetoothd[3011]: register_interface: path /org/bluez/3011/any
bluetoothd[3011]: Registered interface org.bluez.Service on path /org/bluez/3011/any
bluetoothd[3011]: /etc/bluetooth/network.conf: Key file does not have key 'Disable'
bluetoothd[3011]: /etc/bluetooth/network.conf: Key file does not have key 'DisableSecurity'
bluetoothd[3011]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[3011]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[3011]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[3011]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[3011]: bridge pan0 created
bluetoothd[3011]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[3011]: Unix socket created: 9
bluetoothd[3011]: audio.conf: Key file does not have key 'AutoConnect'
bluetoothd[3011]: audio.conf: Key file does not have key 'MaxConnected'
bluetoothd[3011]: Telephony plugin initialized
bluetoothd[3011]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[3011]: HCI dev 0 registered
bluetoothd[3011]: child 3012 forked
bluetoothd[3011]: btd_adapter_ref(0x7f940a568f20): ref=1
bluetoothd[3011]: HCI dev 0 up
bluetoothd[3011]: Starting security manager 0
bluetoothd[3011]: Changing Major/Minor class to 0x000104
bluetoothd[3011]: Stopping Inquiry at adapter startup
bluetoothd[3011]: register_interface: path /org/bluez/3011/hci0
bluetoothd[3011]: Registered interface org.bluez.Service on path /org/bluez/3011/hci0
bluetoothd[3011]: network_server_probe: path /org/bluez/3011/hci0
bluetoothd[3011]: btd_adapter_ref(0x7f940a568f20): ref=2
bluetoothd[3011]: Adding record with handle 0x10000
bluetoothd[3011]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[3011]: register_server_record: got record id 0x10000
bluetoothd[3011]: Registered interface org.bluez.NetworkPeer on path /org/bluez/3011/hci0
bluetoothd[3011]: network_server_probe: path /org/bluez/3011/hci0
bluetoothd[3011]: Adding record with handle 0x10001
bluetoothd[3011]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[3011]: register_server_record: got record id 0x10001
bluetoothd[3011]: Registered interface org.bluez.NetworkHub on path /org/bluez/3011/hci0
bluetoothd[3011]: network_server_probe: path /org/bluez/3011/hci0
bluetoothd[3011]: Adding record with handle 0x10002
bluetoothd[3011]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[3011]: register_server_record: got record id 0x10002
bluetoothd[3011]: Registered interface org.bluez.NetworkRouter on path /org/bluez/3011/hci0
bluetoothd[3011]: proxy_probe: path /org/bluez/3011/hci0
bluetoothd[3011]: btd_adapter_ref(0x7f940a568f20): ref=3
bluetoothd[3011]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/3011/hci0
bluetoothd[3011]: Parsing /etc/bluetooth/serial.conf failed: No such file or directory
bluetoothd[3011]: btd_adapter_ref(0x7f940a568f20): ref=4
bluetoothd[3011]: headset_server_probe: path /org/bluez/3011/hci0
bluetoothd[3011]: btd_adapter_ref(0x7f940a568f20): ref=5
bluetoothd[3011]: audio_adapter_ref(0x7f940a56b790): ref=1
bluetoothd[3011]: audio.conf: Key file does not have key 'Master'
bluetoothd[3011]: Adding record with handle 0x10003
bluetoothd[3011]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3011]: audio.conf: Key file does not have key 'SCORouting'
bluetoothd[3011]: Adding record with handle 0x10004
bluetoothd[3011]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3011]: gateway_server_probe: path /org/bluez/3011/hci0
bluetoothd[3011]: audio_adapter_ref(0x7f940a56b790): ref=2
bluetoothd[3011]: audio.conf: Key file does not have key 'Master'
bluetoothd[3011]: Adding record with handle 0x10005
bluetoothd[3011]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3011]: a2dp_server_probe: path /org/bluez/3011/hci0
bluetoothd[3011]: audio_adapter_ref(0x7f940a56b790): ref=3
bluetoothd[3011]: audio.conf: Key file does not have key 'Disable'
bluetoothd[3011]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3011]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3011]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3011]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[3011]: audio.conf: Key file does not have key 'Master'
bluetoothd[3011]: SEP 0x7f940a56d6a0 registered: type:0 codec:0 seid:1
bluetoothd[3011]: Adding record with handle 0x10006
bluetoothd[3011]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3011]: SEP 0x7f940a56db10 registered: type:1 codec:0 seid:2
bluetoothd[3011]: Adding record with handle 0x10007
bluetoothd[3011]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 0000110b-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3011]: avrcp_server_probe: path /org/bluez/3011/hci0
bluetoothd[3011]: audio_adapter_ref(0x7f940a56b790): ref=4
bluetoothd[3011]: audio.conf: Key file does not have key 'Master'
bluetoothd[3011]: Adding record with handle 0x10008
bluetoothd[3011]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3011]: Adding record with handle 0x10009
bluetoothd[3011]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3011]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3011]: Adapter /org/bluez/3011/hci0 has been enabled
bluetoothd[3011]: Stopping security manager 0
bluetoothd[3011]: Entering main loop
bluetoothd[3011]: Computer is classified as desktop
bluetoothd[3011]: Setting 0x000104 for major/minor device class
bluetoothd[3011]: child 3012 exited
bluetoothd[3011]: HCI dev 0 down
bluetoothd[3011]: Adapter /org/bluez/3011/hci0 has been disabled
bluetoothd[3011]: RFKILL event idx 1 type 2 op 0 soft 0 hard 0


--=-Nk8XpEm2yIqhvlgfDf0k--

