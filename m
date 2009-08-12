Return-Path: <cyrus@holtmann.org>
Message-ID: <4A82B32E.3020903@gmail.com>
Date: Wed, 12 Aug 2009 15:18:54 +0300
From: "y.dmitry@gmail.com" <y.dmitry@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: NAP/GN with bluez-4
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

Can't setup NAP-server with bluez-4 (versions 4.39, 4.47). Remote device
can't discover any services. But when i trying to run  'simple-service'
script from sources, i can see a "Serial Port" service on remote device.
Service disappears when script canceled. As I understand at this point,
all ok with connectivity and access rights.

I mean linux box must became an Access Point for phone, netbook, etc.

Logs:
...
bluetoothd[9949]: Loading builtin plugins
bluetoothd[9949]: Loading service plugin
bluetoothd[9949]: Loading hciops plugin
bluetoothd[9949]: Loading hal plugin
bluetoothd[9949]: Loading storage plugin
bluetoothd[9949]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[9949]: Loading network plugin
bluetoothd[9949]: Loading serial plugin
...
bluetoothd[9949]: network_server_probe: path /org/bluez/9949/hci0
bluetoothd[9949]: Adding record with handle 0x10002
bluetoothd[9949]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[9949]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9949]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9949]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[9949]: Changing service classes to 0x020104
bluetoothd[9949]: register_server_record: got record id 0x10002
bluetoothd[9949]: Registered interface org.bluez.NetworkRouter on path
/org/bluez/9949/hci0
h /org/bluez/9949/any
bluetoothd[9949]: Registered interface org.bluez.Service on path
/org/bluez/9949/any
bluetoothd[9949]: /etc/bluetooth/network.conf: Key file does not have
key 'Disable'
bluetoothd[9949]: Config options: InterfacePrefix=bnep0,
PANU_Script=(null), GN_Script=(null), NAP_Script=(null),
GN_Interface=pan1, NAP_Interface=pan2, Security=false
bluetoothd[9949]: bridge pan1 created
...
bluetoothd[9949]: network_server_probe: path /org/bluez/9949/hci0
bluetoothd[9949]: Adding record with handle 0x10002
bluetoothd[9949]: Record pattern UUID 0000000f-0000-1000-8000-00805f9
bluetoothd[9949]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9949]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9949]: Record pattern UUID 00001116-0000-1000-8000-00805f9
bluetoothd[9949]: Changing service classes to 0x020104
bluetoothd[9949]: register_server_record: got record id 0x10002
bluetoothd[9949]: Registered interface org.bluez.NetworkRouter on path
/org/bluez/9949/hci0

from dmesg:
[169632.490256] Bluetooth: Core ver 2.15
[169632.490308] Bluetooth: HCI device and connection manager initialized
[169632.490310] Bluetooth: HCI socket layer initialized
[169632.535120] Bluetooth: Generic Bluetooth USB driver ver 0.5
[170196.227526] Bluetooth: L2CAP ver 2.13
[170196.227529] Bluetooth: L2CAP socket layer initialized
[170196.262160] Bluetooth: SCO (Voice Link) ver 0.6
[170196.262163] Bluetooth: SCO socket layer initialized
[170196.290501] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[170196.290505] Bluetooth: BNEP filters: protocol multicast
[170196.440134] Bluetooth: RFCOMM socket layer initialized
[170196.440142] Bluetooth: RFCOMM TTY layer initialized
[170196.440145] Bluetooth: RFCOMM ver 1.11


# ifconfig -a|grep 'pan|bnep'
pan0      Link encap:Ethernet  HWaddr 3a:cb:41:e4:19:97

(pan0 iface not disappears when bluetoothd stops. But it's ok when i set
pan1 in config)


I can see both NAP/GN records with 'sdptool browse local'. After
'simple-service' script new record appears.
I dumped some bt traffic with 'hcidump' and saw a "serial port" record
transmission. It seems, that somewhy bluez completely ignores any
builtin records about network services.

I tried several userland tools (blueman, bluez-gnome) with no success.
bluez-gnome has no support for local services. blueman has such broken
support.

I tried to play a little with python and dbus (few 'simple-service'
script modifications). No success here too.

Am I missed something?


