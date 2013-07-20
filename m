Return-Path: <cyrus@holtmann.org>
Message-ID: <51EB0302.2020100@gmail.com>
Date: Sat, 20 Jul 2013 23:37:06 +0200
From: Olivier Cailloux <olivier.cailloux@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth stop working after hibernate, how to restart?
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello list,

I have a user question about how to restart bluetooth daemon (below). I 
suspect (from looking at the recent archives) this list might not be 
appropriate to ask this question, but it is a bit unclear on the website.

http://www.bluez.org/contact/ says “For people who want to use the Linux 
Bluetooth stack and have problems or basic question, they can post them 
to the user mailing list.” This points to 
http://www.bluez.org/development/lists/, which only says, about 
linux-bluetooth: “This is the development mailing list for the BlueZ 
project.”

So I hope my user-level question will be welcome on this list, 
otherwise, does anyone know where I could ask this?

I also understand the question might be considered somewhat Debian 
specific, but I tried to ask on debian-user list: no answer. I guess it 
requires a fair level of knowledge about bluez intricacies, hence my 
hope that someone here will be able to give me a useful hint.

Thanks for any help or pointer. Here is the question.

I have a Logitech USB Bluetooth hub connected to my computer running 
Debian Wheezy. It works well... until I hibernate. After wake up, the 
bluetooth icon in the gnome panel has disappeared, and I can’t make 
bluetooth work even using command line tools.

I tried restarting it using various methods, but couldn’t find how to 
properly restart it. However, rebooting succeeds in bringing bluetooth back.

Does anyone have an idea, either 1) how to prevent bluetooth from 
stopping after hibernate; or 2) how to restart bluetooth without having 
to restart the whole computer?

Any clue about where to look at would be appreciated.

Below, more technical details. Thanks a lot.

$ sudo /etc/init.d/bluetooth stop
[ ok ] Stopping bluetooth: rfcomm /usr/sbin/bluetoothd.
$ ps ax | grep [b]lue
$ sudo bluetoothd -n -d
bluetoothd[4490]: Bluetooth daemon 4.99
bluetoothd[4490]: src/main.c:parse_config() parsing main.conf
bluetoothd[4490]: src/main.c:parse_config() discovto=0
bluetoothd[4490]: src/main.c:parse_config() pairto=0
bluetoothd[4490]: src/main.c:parse_config() pageto=8192
bluetoothd[4490]: src/main.c:parse_config() auto_to=60
bluetoothd[4490]: src/main.c:parse_config() name=%h-%d
bluetoothd[4490]: src/main.c:parse_config() class=0x000100
bluetoothd[4490]: src/main.c:parse_config() discov_interval=30
bluetoothd[4490]: src/main.c:parse_config() Key file does not have key 
'DeviceID'
bluetoothd[4490]: Starting SDP server
bluetoothd[4490]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[4490]: src/plugin.c:add_plugin() Loading pnat plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading audio plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading sap plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading input plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading serial plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading network plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading proximity plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading service plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading gatt_example plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading time plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading alert plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading health plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading thermometer plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading hciops plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading mgmtops plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading formfactor plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading storage plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading adaptername plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading wiimote plugin
bluetoothd[4490]: src/plugin.c:add_plugin() Loading dbusoob plugin
bluetoothd[4490]: src/plugin.c:plugin_init() Loading plugins 
/usr/lib/x86_64-linux-gnu/bluetooth/plugins
bluetoothd[4490]: plugins/service.c:register_interface() path 
/org/bluez/4490/any
bluetoothd[4490]: plugins/service.c:register_interface() Registered 
interface org.bluez.Service on path /org/bluez/4490/any
bluetoothd[4490]: plugins/dbusoob.c:dbusoob_init() Setup dbusoob plugin
bluetoothd[4490]: health/hdp.c:hdp_manager_start() Starting Health manager
bluetoothd[4490]: alert/main.c:alert_init() Attribute server is disabled
bluetoothd[4490]: Failed to init alert plugin
bluetoothd[4490]: time/main.c:time_init() Attribute server is disabled
bluetoothd[4490]: Failed to init time plugin
bluetoothd[4490]: network/manager.c:read_config() 
/etc/bluetooth/network.conf: Key file does not have key 'DisableSecurity'
bluetoothd[4490]: network/manager.c:read_config() Config options: 
Security=true
bluetoothd[4490]: input/manager.c:input_manager_init() input.conf: Key 
file does not have key 'IdleTimeout'
bluetoothd[4490]: audio/manager.c:audio_manager_init() audio.conf: Key 
file does not have key 'AutoConnect'
bluetoothd[4490]: plugins/pnat.c:pnat_init() Setup Phonet AT (DUN) plugin
bluetoothd[4490]: plugins/hciops.c:hciops_init()
bluetoothd[4490]: plugins/gatt-example.c:gatt_example_init() Attribute 
server is disabled
bluetoothd[4490]: Failed to init gatt_example plugin
bluetoothd[4490]: plugins/hciops.c:hciops_setup()
bluetoothd[4490]: src/main.c:main() Entering main loop
bluetoothd[4490]: plugins/hciops.c:init_known_adapters()

(while daemon is running)
$ bluez-simple-agent
Traceback (most recent call last):
File "/usr/bin/bluez-simple-agent", line 104, in <module>
path = manager.DefaultAdapter()
File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in 
__call__
return self._proxy_method(*args, **keywords)
File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in 
__call__
**keywords)
File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651, in 
call_blocking
message, timeout)
dbus.exceptions.DBusException: org.bluez.Error.NoSuchAdapter: No such 
adapter

$ hcitool dev
Devices:

$ apt-show-versions | grep [b]lue
bluez/wheezy uptodate 4.99-2
gir1.2-gnomebluetooth-1.0/wheezy uptodate 3.4.2-1
gnome-bluetooth/wheezy uptodate 3.4.2-1
libbluetooth3/wheezy uptodate 4.99-2
libgnome-bluetooth10/wheezy uptodate 3.4.2-1
python-bluez/wheezy uptodate 0.18-2

$ dmesg | grep -i [b]lue
[ 9.539483] usb 6-2.2: Product: Logitech Bluetooth wireless hub
[ 9.633431] Bluetooth: Core ver 2.16
[ 9.633486] Bluetooth: HCI device and connection manager initialized
[ 9.633495] Bluetooth: HCI socket layer initialized
[ 9.633500] Bluetooth: L2CAP socket layer initialized
[ 9.633511] Bluetooth: SCO socket layer initialized
[ 9.669214] Bluetooth: Generic Bluetooth USB driver ver 0.6
[ 18.405261] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[ 18.405270] Bluetooth: BNEP filters: protocol multicast
[ 18.470249] Bluetooth: RFCOMM TTY layer initialized
[ 18.470261] Bluetooth: RFCOMM socket layer initialized
[ 18.470267] Bluetooth: RFCOMM ver 1.11

$ dmesg | grep -i logi
[ 1.436797] sd 5:0:0:0: [sda] 976773168 512-byte logical blocks: (500 
GB/465 GiB)
[ 2.317539] usb 6-1: Manufacturer: Logitech
[ 2.894558] sd 6:0:0:0: [sdb] 625142448 512-byte logical blocks: (320 
GB/298 GiB)
[ 3.842933] usb 6-2.1: Manufacturer: Logitech
[ 4.025359] usb 5-2.2: Manufacturer: Logitech
[ 4.565096] usb 5-2.1: Manufacturer: Logitech
[ 7.510931] input: Logitech USB-PS/2 Optical Mouse as 
/devices/pci0000:00/0000:00:12.1/usb6/6-1/6-1:1.0/input/input5
[ 7.511401] generic-usb 0003:046D:C050.0001: input,hidraw0: USB HID 
v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:12.1-1/input0
[ 7.530894] input: Logitech USB Receiver as 
/devices/pci0000:00/0000:00:12.1/usb6/6-2/6-2.1/6-2.1:1.0/input/input8
[ 7.531237] generic-usb 0003:046D:C703.0004: input,hidraw3: USB HID 
v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:12.1-2.1/input0
[ 7.545310] input: Logitech USB Receiver as 
/devices/pci0000:00/0000:00:12.1/usb6/6-2/6-2.1/6-2.1:1.1/input/input9
[ 7.546294] generic-usb 0003:046D:C703.0005: input,hiddev0,hidraw4: USB 
HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:12.1-2.1/input1
[ 7.555418] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input10
[ 7.555881] generic-usb 0003:046D:ABD0.0008: input,hiddev0,hidraw5: USB 
HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[ 9.031136] input: Logitech USB Receiver as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.2/5-2.2:1.0/input/input11
[ 9.031379] logitech 0003:046D:C50C.0006: input,hidraw6: USB HID v1.10 
Keyboard [Logitech USB Receiver] on usb-0000:00:12.0-2.2/input0
[ 9.038538] logitech 0003:046D:C50C.0007: fixing up Logitech keyboard 
report descriptor
[ 9.040178] input: Logitech USB Receiver as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.2/5-2.2:1.1/input/input12
[ 9.040556] logitech 0003:046D:C50C.0007: input,hiddev0,hidraw7: USB HID 
v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:12.0-2.2/input1
[ 9.539483] usb 6-2.2: Product: Logitech Bluetooth wireless hub
[ 9.539489] usb 6-2.2: Manufacturer: Logitech
[ 2558.729150] usb 5-2.1: Manufacturer: Logitech
[ 2558.740191] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input13
[ 2558.740332] generic-usb 0003:046D:ABD0.0009: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[74443.441163] usb 5-2.1: Manufacturer: Logitech
[74443.452224] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input14
[74443.452369] generic-usb 0003:046D:ABD0.000A: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[91248.825141] usb 5-2.1: Manufacturer: Logitech
[91248.836203] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input15
[91248.836347] generic-usb 0003:046D:ABD0.000B: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[108900.221143] usb 5-2.1: Manufacturer: Logitech
[108900.232208] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input16
[108900.232348] generic-usb 0003:046D:ABD0.000C: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[117516.029155] usb 5-2.1: Manufacturer: Logitech
[117516.040215] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input17
[117516.040357] generic-usb 0003:046D:ABD0.000D: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[129327.405165] usb 5-2.1: Manufacturer: Logitech
[129327.416229] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input18
[129327.416371] generic-usb 0003:046D:ABD0.000E: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[135531.077151] usb 5-2.1: Manufacturer: Logitech
[135531.088192] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input19
[135531.088331] generic-usb 0003:046D:ABD0.000F: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[152526.341168] usb 5-2.1: Manufacturer: Logitech
[152526.352207] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input20
[152526.352352] generic-usb 0003:046D:ABD0.0010: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[169773.013129] usb 5-2.1: Manufacturer: Logitech
[169773.024192] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input21
[169773.024333] generic-usb 0003:046D:ABD0.0011: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[171748.413164] usb 5-2.1: Manufacturer: Logitech
[171748.424203] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input22
[171748.424341] generic-usb 0003:046D:ABD0.0012: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[174826.569127] usb 5-2.1: Manufacturer: Logitech
[174826.580194] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input23
[174826.580340] generic-usb 0003:046D:ABD0.0013: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[177945.933133] usb 5-2.1: Manufacturer: Logitech
[177945.944280] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input24
[177945.944423] generic-usb 0003:046D:ABD0.0014: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[224310.341165] usb 5-2.1: Manufacturer: Logitech
[224310.352282] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input25
[224310.352429] generic-usb 0003:046D:ABD0.0015: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[276498.645168] usb 5-2.1: Manufacturer: Logitech
[276498.656234] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input26
[276498.656515] generic-usb 0003:046D:ABD0.0016: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0
[330029.381108] usb 5-2.1: Manufacturer: Logitech
[330029.392266] input: Logitech Desktop USB stand as 
/devices/pci0000:00/0000:00:12.0/usb5/5-2/5-2.1/5-2.1:1.0/input/input27
[330029.392422] generic-usb 0003:046D:ABD0.0017: input,hiddev0,hidraw5: 
USB HID v1.10 Keyboard [Logitech Desktop USB stand] on 
usb-0000:00:12.0-2.1/input0

after unplug, replug bluetooth USB (on a different USB port):
$ dmesg | grep -i logi
[354738.186710] usb 7-1.1: Manufacturer: Logitech
[354738.198264] input: Logitech USB Receiver as 
/devices/pci0000:00/0000:00:13.0/usb7/7-1/7-1.1/7-1.1:1.0/input/input28
[354738.198605] generic-usb 0003:046D:C703.0018: input,hidraw3: USB HID 
v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:13.0-1.1/input0
[354738.212755] input: Logitech USB Receiver as 
/devices/pci0000:00/0000:00:13.0/usb7/7-1/7-1.1/7-1.1:1.1/input/input29
[354738.213216] generic-usb 0003:046D:C703.0019: input,hiddev0,hidraw4: 
USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:13.0-1.1/input1

$ sudo /etc/init.d/bluetooth restart
$ sudo grep -i [b]lue /var/log/syslog
Jul 16 21:48:32 Saucisson bluetoothd[2798]: Terminating
Jul 16 21:48:32 Saucisson bluetoothd[2798]: Stopping SDP server
Jul 16 21:48:32 Saucisson bluetoothd[2798]: Exit
Jul 16 21:48:33 Saucisson bluetoothd[3971]: Bluetooth daemon 4.99
Jul 16 21:48:33 Saucisson bluetoothd[3971]: Starting SDP server
Jul 16 21:48:33 Saucisson bluetoothd[3971]: Failed to init alert plugin
Jul 16 21:48:33 Saucisson bluetoothd[3971]: Failed to init time plugin
Jul 16 21:48:33 Saucisson bluetoothd[3971]: Failed to init gatt_example 
plugin

$ sudo lsusb | grep -i logi
Bus 006 Device 002: ID 046d:c050 Logitech, Inc. RX 250 Optical Mouse
Bus 005 Device 003: ID 046d:c313 Logitech, Inc. Internet 350 Keyboard
Bus 007 Device 003: ID 046d:c703 Logitech, Inc. Elite Keyboard Y-RP20 + 
Mouse MX900 (Bluetooth)
Bus 005 Device 004: ID 046d:c50c Logitech, Inc. Cordless Desktop S510
Bus 005 Device 020: ID 046d:abd0 Logitech, Inc.

$ ls -l /etc/dbus-1/system.d/bluetooth.conf
-rw-r--r-- 1 root root 1379 mars 24 2012 /etc/dbus-1/system.d/bluetooth.conf

Possibly related: 
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=587158. But seems 
related to missing bluetooth.conf, does not apply to me.
Possibly related: 
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=645980. Does not tell much.
Olivier

