Return-Path: <cyrus@holtmann.org>
Message-ID: <498EB082.7040708@xyzw.org>
Date: Sun, 08 Feb 2009 02:14:26 -0800
From: Brian Rogers <brian@xyzw.org>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: btusb compatibility issues
Content-Type: multipart/mixed;
 boundary="------------090903090201080309020908"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090903090201080309020908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It appears that the btusb driver has never worked for at least the 
following dongles:

1131:1001 Integrated System Solution Corp. KY-BT100 Bluetooth Adapter
1131:1004 Integrated System Solution Corp. Bluetooth Device
2001:f111 D-Link Corp. [hex] DBT-122 Bluetooth adapter
0a5c:200a Broadcom Corp. Bluetooth dongle

And so when this became the default driver in 2.6.27, some users could 
no longer use Bluetooth. They can generally scan for devices, but no 
connections can be established in either direction.

See the bug report here: 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/268502

I have the KY-BT100 listed above, and was hoping this would be an 
ordinary regression where I could just bisect and find the bad commit. 
But I soon realized what made Bluetooth work or not work was whether 
hci_usb or btusb was being used. One thing I noticed is that either way, 
I got this in dmesg:

hci_cmd_task: hci0 command tx timeout

This seems to be common to everyone experiencing this issue. Since the 
message is still produced with the hci_usb driver, even though that 
driver works, a (perhaps naive) guess of mine is that the problem has 
something to do with the two drivers handling this error differently.

I'm attaching the output of 'hciconfig -a' and logs of 'bluetoothd -nd'. 
I got different results depending on whether I plugged in the dongle 
before or after starting bluetoothd, so I'm supplying both log files. In 
the hotplugging case, I got these two messages:

bluetoothd[6745]: Adapter /org/bluez/6745/hci0 without an address
bluetoothd[6745]: Can't read version info for /org/bluez/6745/hci0: 
Unknown error 18446744073709551506 (-110)

after plugging in the device, and the applet didn't show a list of 
paired devices to try to connect to, so I just unplugged the device.

In the other log file, I tried a couple times to browse my phone from my 
computer, send a file, and I tried to browse my computer from my phone. 
Then I hit ctrl-C. This is with BlueZ 4.28 and post-2.6.29-rc3.

What other information can I provide to track down this problem?

Brian


--------------090903090201080309020908
Content-Type: text/x-log;
 name="bluetoothd_hotplug.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluetoothd_hotplug.log"

bluetoothd[6745]: Bluetooth daemon
bluetoothd[6745]: Enabling debug information
bluetoothd[6745]: parsing main.conf
bluetoothd[6745]: discovto=0
bluetoothd[6745]: pairto=0
bluetoothd[6745]: pageto=8192
bluetoothd[6745]: name=%h-%d
bluetoothd[6745]: class=0x000100
bluetoothd[6745]: inqmode=0
bluetoothd[6745]: Key file does not have key 'DeviceID'
bluetoothd[6745]: Starting SDP server
bluetoothd[6745]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[6745]: register_interface: path /org/bluez/6745/any
bluetoothd[6745]: Registered interface org.bluez.Service on path /org/bluez/6745/any
bluetoothd[6745]: /etc/bluetooth/network.conf: Key file does not have key 'Disable'
bluetoothd[6745]: /etc/bluetooth/network.conf: Key file does not have key 'DisableSecurity'
bluetoothd[6745]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[6745]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[6745]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[6745]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[6745]: bridge pan0 created
bluetoothd[6745]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[6745]: Unix socket created: 12
bluetoothd[6745]: audio.conf: Key file does not have key 'MaxConnected'
bluetoothd[6745]: Telephony plugin initialized
bluetoothd[6745]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[6745]: Starting experimental netlink support
bluetoothd[6745]: Failed to find Bluetooth netlink family
bluetoothd[6745]: HCI dev 0 registered
bluetoothd[6745]: child 6748 forked
bluetoothd[6745]: Agent registered for hci0 at :1.24:/org/bluez/agent/hci0
bluetoothd[6745]: child 6748 exited
bluetoothd[6745]: HCI dev 0 up
bluetoothd[6745]: Starting security manager 0
bluetoothd[6745]: Adapter /org/bluez/6745/hci0 without an address
bluetoothd[6745]: Can't read version info for /org/bluez/6745/hci0: Unknown error 18446744073709551506 (-110)
bluetoothd[6745]: HCI dev 0 down
bluetoothd[6745]: Adapter /org/bluez/6745/hci0 has been disabled
bluetoothd[6745]: Stopping security manager 0
bluetoothd[6745]: HCI dev 0 unregistered
bluetoothd[6745]: Unregister path: /org/bluez/6745/hci0
bluetoothd[6745]: Removing adapter /org/bluez/6745/hci0
bluetoothd[6745]: unregister_interface: path /org/bluez/6745/hci0
bluetoothd[6745]: network_server_remove: path /org/bluez/6745/hci0
bluetoothd[6745]: network_server_remove: path /org/bluez/6745/hci0
bluetoothd[6745]: network_server_remove: path /org/bluez/6745/hci0
bluetoothd[6745]: proxy_remove: path /org/bluez/6745/hci0
bluetoothd[6745]: headset_server_remove: path /org/bluez/6745/hci0
bluetoothd[6745]: a2dp_server_remove: path /org/bluez/6745/hci0
bluetoothd[6745]: avrcp_server_remove: path /org/bluez/6745/hci0
process 6745: arguments to dbus_connection_unref() were incorrect, assertion "connection != NULL" failed in file dbus-connection.c line 2657.
This is normally a bug in some application using the D-Bus library.
bluetoothd[6745]: Releasing agent :1.24, /org/bluez/agent/hci0
^Cbluetoothd[6745]: Cleanup plugins
bluetoothd[6745]: unregister_interface: path /org/bluez/6745/any
bluetoothd[6745]: bridge pan0 removed
bluetoothd[6745]: Stopping SDP server
bluetoothd[6745]: Exit

--------------090903090201080309020908
Content-Type: text/x-log;
 name="bluetoothd_normal.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluetoothd_normal.log"

bluetoothd[6822]: Bluetooth daemon
bluetoothd[6822]: Enabling debug information
bluetoothd[6822]: parsing main.conf
bluetoothd[6822]: discovto=0
bluetoothd[6822]: pairto=0
bluetoothd[6822]: pageto=8192
bluetoothd[6822]: name=%h-%d
bluetoothd[6822]: class=0x000100
bluetoothd[6822]: inqmode=0
bluetoothd[6822]: Key file does not have key 'DeviceID'
bluetoothd[6822]: Starting SDP server
bluetoothd[6822]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[6822]: register_interface: path /org/bluez/6822/any
bluetoothd[6822]: Registered interface org.bluez.Service on path /org/bluez/6822/any
bluetoothd[6822]: /etc/bluetooth/network.conf: Key file does not have key 'Disable'
bluetoothd[6822]: /etc/bluetooth/network.conf: Key file does not have key 'DisableSecurity'
bluetoothd[6822]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[6822]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[6822]: /etc/bluetooth/network.conf: Key file does not have key 'Interface'
bluetoothd[6822]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
bluetoothd[6822]: bridge pan0 created
bluetoothd[6822]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[6822]: Unix socket created: 12
bluetoothd[6822]: audio.conf: Key file does not have key 'MaxConnected'
bluetoothd[6822]: Telephony plugin initialized
bluetoothd[6822]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[6822]: Starting experimental netlink support
bluetoothd[6822]: Failed to find Bluetooth netlink family
bluetoothd[6822]: HCI dev 0 registered
bluetoothd[6822]: child 6824 forked
bluetoothd[6822]: Agent registered for hci0 at :1.24:/org/bluez/agent/hci0
bluetoothd[6822]: child 6824 exited
bluetoothd[6822]: HCI dev 0 up
bluetoothd[6822]: Starting security manager 0
bluetoothd[6822]: Adapter /org/bluez/6822/hci0 without an address
bluetoothd[6822]: register_interface: path /org/bluez/6822/hci0
bluetoothd[6822]: Registered interface org.bluez.Service on path /org/bluez/6822/hci0
bluetoothd[6822]: network_server_probe: path /org/bluez/6822/hci0
bluetoothd[6822]: Adding record with handle 0x10000
bluetoothd[6822]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001115-0000-1000-8000-00805f9
bluetoothd[6822]: register_server_record: got record id 0x10000
bluetoothd[6822]: Registered interface org.bluez.NetworkPeer on path /org/bluez/6822/hci0
bluetoothd[6822]: network_server_probe: path /org/bluez/6822/hci0
bluetoothd[6822]: Adding record with handle 0x10001
bluetoothd[6822]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001117-0000-1000-8000-00805f9
bluetoothd[6822]: register_server_record: got record id 0x10001
bluetoothd[6822]: Registered interface org.bluez.NetworkHub on path /org/bluez/6822/hci0
bluetoothd[6822]: network_server_probe: path /org/bluez/6822/hci0
bluetoothd[6822]: Adding record with handle 0x10002
bluetoothd[6822]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[6822]: register_server_record: got record id 0x10002
bluetoothd[6822]: Registered interface org.bluez.NetworkRouter on path /org/bluez/6822/hci0
bluetoothd[6822]: proxy_probe: path /org/bluez/6822/hci0
bluetoothd[6822]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/6822/hci0
bluetoothd[6822]: headset_server_probe: path /org/bluez/6822/hci0
bluetoothd[6822]: Adding record with handle 0x10003
bluetoothd[6822]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[6822]: audio.conf: Key file does not have key 'SCORouting'
bluetoothd[6822]: Adding record with handle 0x10004
bluetoothd[6822]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[6822]: a2dp_server_probe: path /org/bluez/6822/hci0
bluetoothd[6822]: audio.conf: Key file does not have key 'Disable'
bluetoothd[6822]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[6822]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[6822]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[6822]: audio.conf: Key file does not have group 'A2DP'
bluetoothd[6822]: SEP 0x7fe388500660 registered: type:0 codec:0 seid:1
bluetoothd[6822]: Adding record with handle 0x10005
bluetoothd[6822]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[6822]: avrcp_server_probe: path /org/bluez/6822/hci0
bluetoothd[6822]: Adding record with handle 0x10006
bluetoothd[6822]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[6822]: Adding record with handle 0x10007
bluetoothd[6822]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[6822]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[6822]: Creating device /org/bluez/6822/hci0/dev_00_12_A1_63_EF_3A
bluetoothd[6822]: Probe drivers for /org/bluez/6822/hci0/dev_00_12_A1_63_EF_3A
bluetoothd[6822]: hid_device_probe: path /org/bluez/6822/hci0/dev_00_12_A1_63_EF_3A
bluetoothd[6822]: Registered interface org.bluez.Input on path /org/bluez/6822/hci0/dev_00_12_A1_63_EF_3A
bluetoothd[6822]: Creating device /org/bluez/6822/hci0/dev_6C_29_49_71_66_01
bluetoothd[6822]: Probe drivers for /org/bluez/6822/hci0/dev_6C_29_49_71_66_01
bluetoothd[6822]: serial_probe: path /org/bluez/6822/hci0/dev_6C_29_49_71_66_01: 00001101-0000-1000-8000-00805f9b34fb
bluetoothd[6822]: Registered interface org.bluez.Serial on path /org/bluez/6822/hci0/dev_6C_29_49_71_66_01
bluetoothd[6822]: serial_probe: path /org/bluez/6822/hci0/dev_6C_29_49_71_66_01: 00001103-0000-1000-8000-00805f9b34fb
bluetoothd[6822]: serial_probe: path /org/bluez/6822/hci0/dev_6C_29_49_71_66_01: 00001105-0000-1000-8000-00805f9b34fb
bluetoothd[6822]: serial_probe: path /org/bluez/6822/hci0/dev_6C_29_49_71_66_01: 00001106-0000-1000-8000-00805f9b34fb
bluetoothd[6822]: adapter_get_device(6C:29:49:71:66:01)
bluetoothd[6822]: audio handle_uuid: server not enabled for 0000110a-0000-1000-8000-00805f9b34fb (0x110a)
bluetoothd[6822]: Found AV Target
bluetoothd[6822]: Registered interface org.bluez.Control on path /org/bluez/6822/hci0/dev_6C_29_49_71_66_01
bluetoothd[6822]: Found AV Target
bluetoothd[6822]: Creating device /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: Probe drivers for /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: headset_probe: path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: Registered interface org.bluez.Input on path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: serial_probe: path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED: 00001108-0000-1000-8000-00805f9b34fb
bluetoothd[6822]: Registered interface org.bluez.Serial on path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: serial_probe: path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED: 0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[6822]: adapter_get_device(00:1A:45:1C:D7:ED)
bluetoothd[6822]: Found Headset record
bluetoothd[6822]: Discovered Headset service on RFCOMM channel 2
bluetoothd[6822]: Registered interface org.bluez.Headset on path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: Found Handsfree record
bluetoothd[6822]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[6822]: Found Audio Sink
bluetoothd[6822]: Registered interface org.bluez.AudioSink on path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: Found AV Remote
bluetoothd[6822]: Registered interface org.bluez.Control on path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: Adapter /org/bluez/6822/hci0 has been enabled
bluetoothd[6822]: Computer is classified as laptop
bluetoothd[6822]: Current device class is 0x4a2100
bluetoothd[6822]: Setting 0x00010c for major/minor device class
bluetoothd[6822]: Discovery session 0x7fe3885056d0 with :1.63 activated
bluetoothd[6822]: session_ref(0x7fe3885056d0): ref=1
bluetoothd[6822]: session_unref(0x7fe3885056d0): ref=0
bluetoothd[6822]: Discovery session 0x7fe3885056d0 with :1.63 deactivated
bluetoothd[6822]: Stopping discovery
bluetoothd[6822]: Discovery session 0x7fe3885010f0 with :1.66 activated
bluetoothd[6822]: session_ref(0x7fe3885010f0): ref=1
bluetoothd[6822]: Discovery session 0x7fe3885010f0 with :1.66 deactivated
bluetoothd[6822]: Stopping discovery
bluetoothd[6822]: link_key_request (sba=00:11:67:73:9B:94, dba=6C:29:49:71:66:01)
bluetoothd[6822]: kernel auth requirements = 0x00
bluetoothd[6822]: stored link key type = 0x00
bluetoothd[6822]: adapter_get_device(6C:29:49:71:66:01)
bluetoothd[6822]: adapter_get_device(6C:29:49:71:66:01)
^Cbluetoothd[6822]: Removing adapter /org/bluez/6822/hci0
bluetoothd[6822]: unregister_interface: path /org/bluez/6822/hci0
bluetoothd[6822]: network_server_remove: path /org/bluez/6822/hci0
bluetoothd[6822]: Unregistered interface org.bluez.NetworkPeer on path /org/bluez/6822/hci0
bluetoothd[6822]: Removing record with handle 0x10000
bluetoothd[6822]: network_server_remove: path /org/bluez/6822/hci0
bluetoothd[6822]: Unregistered interface org.bluez.NetworkHub on path /org/bluez/6822/hci0
bluetoothd[6822]: Removing record with handle 0x10001
bluetoothd[6822]: network_server_remove: path /org/bluez/6822/hci0
bluetoothd[6822]: Unregistered interface org.bluez.NetworkRouter on path /org/bluez/6822/hci0
bluetoothd[6822]: Removing record with handle 0x10002
bluetoothd[6822]: proxy_remove: path /org/bluez/6822/hci0
bluetoothd[6822]: headset_server_remove: path /org/bluez/6822/hci0
bluetoothd[6822]: Removing record with handle 0x10003
bluetoothd[6822]: Removing record with handle 0x10004
bluetoothd[6822]: a2dp_server_remove: path /org/bluez/6822/hci0
bluetoothd[6822]: Removing record with handle 0x10005
bluetoothd[6822]: avrcp_server_remove: path /org/bluez/6822/hci0
bluetoothd[6822]: Removing record with handle 0x10007
bluetoothd[6822]: Removing record with handle 0x10006
bluetoothd[6822]: Removing device /org/bluez/6822/hci0/dev_00_12_A1_63_EF_3A
bluetoothd[6822]: input_remove: path /org/bluez/6822/hci0/dev_00_12_A1_63_EF_3A
bluetoothd[6822]: Unregistered interface org.bluez.Input on path /org/bluez/6822/hci0/dev_00_12_A1_63_EF_3A
bluetoothd[6822]: Removing device /org/bluez/6822/hci0/dev_6C_29_49_71_66_01
bluetoothd[6822]: serial_remove: path /org/bluez/6822/hci0/dev_6C_29_49_71_66_01
bluetoothd[6822]: Unregistered interface org.bluez.Serial on path /org/bluez/6822/hci0/dev_6C_29_49_71_66_01
bluetoothd[6822]: Unregistered interface org.bluez.Control on path /org/bluez/6822/hci0/dev_6C_29_49_71_66_01
bluetoothd[6822]: Removing device /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: input_remove: path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: Unregistered interface org.bluez.Input on path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: serial_remove: path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: Unregistered interface org.bluez.Serial on path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: Unregistered interface org.bluez.Headset on path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: Unregistered interface org.bluez.AudioSink on path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: Unregistered interface org.bluez.Control on path /org/bluez/6822/hci0/dev_00_1A_45_1C_D7_ED
bluetoothd[6822]: Releasing agent :1.24, /org/bluez/agent/hci0
bluetoothd[6822]: Cleanup plugins
bluetoothd[6822]: unregister_interface: path /org/bluez/6822/any
bluetoothd[6822]: bridge pan0 removed
bluetoothd[6822]: Stopping SDP server
bluetoothd[6822]: Exit

--------------090903090201080309020908
Content-Type: text/x-log;
 name="hciconfig.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hciconfig.log"

hci0:	Type: USB
	BD Address: 00:11:67:73:9B:94 ACL MTU: 1021:8 SCO MTU: 48:10
	UP RUNNING 
	RX bytes:1219 acl:0 sco:0 events:25 errors:0
	TX bytes:345 acl:0 sco:0 commands:26 errors:0
	Features: 0xff 0xfe 0x8d 0x3e 0x88 0x19 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'rumblered-0'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 2.0 (0x3) HCI Rev: 0x2c6 LMP Ver: 2.0 (0x3) LMP Subver: 0x2c6
	Manufacturer: Integrated System Solution Corp. (57)


--------------090903090201080309020908--
