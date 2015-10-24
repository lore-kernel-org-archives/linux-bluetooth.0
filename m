Return-Path: <cyrus@holtmann.org>
From: Steven Davies <linux-bluetooth-list@steev.me.uk>
Subject: After bluetoothd disconnects a LE device only restart of kernel
 modules allows it to reconnect
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-ID: <562BBBFF.9000805@steev.me.uk>
Date: Sat, 24 Oct 2015 18:12:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm using bluez-5.35 with kernel 4.2 and am seeing that after a while 
(could be minutes, hours or days, I don't know what the trigger is) a 
BLE device will disconnect and the only way to reconnect to it is to 
rmmod the bluetooth  modules and re-modprobe them. Obviously this 
shouldn't happen. I'm seeing the following output from bluetoothd (sorry 
for the huge log, let me know if a full pastebin would be better). Can 
anyone offer any insight into why once this happens, I can't talk to the 
device through Bluetooth?

--- At this point the device is connected and able to send/receive ---
Oct 24 03:21:01 bang Thread-15:sensortag.py@77 Got temperature 18.09375 
from B0:B4:48:BA:47:03
--- The device disconnects ---
Oct 24 03:21:03 bang bluetoothd[1858]: src/adapter.c:dev_disconnected() 
Device B0:B4:48:BA:47:03 disconnected, reason 1
Oct 24 03:21:03 bang bluetoothd[1858]: 
src/adapter.c:adapter_remove_connection()
Oct 24 03:21:03 bang bluetoothd[1858]: plugins/policy.c:disconnect_cb() 
reason 1
Oct 24 03:21:03 bang bluetoothd[1858]: 
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:BA:47:03 
type 1 status 0xe
Oct 24 03:21:03 bang bluetoothd[1858]: 
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct 24 03:21:03 bang bluetoothd[1858]: 
src/device.c:device_bonding_failed() status 14
Oct 24 03:21:03 bang bluetoothd[1858]: src/adapter.c:resume_discovery()
Oct 24 03:21:03 bang bluetoothd[1858]: src/device.c:att_disconnected_cb()
Oct 24 03:21:03 bang bluetoothd[1858]: 
src/device.c:att_disconnected_cb() Connection timed out (110)
Oct 24 03:21:03 bang bluetoothd[1858]: src/device.c:attio_disconnected()
Oct 24 03:21:03 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa32960: g_attrib_unref=1
Oct 24 03:21:03 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. 
Cleaning up.
Oct 24 03:21:03 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa32960: g_attrib_unref=0
Oct 24 03:21:03 bang Thread-2:dbusbackend.py@290 Changed: 
org.bluez.Device1: dbus.Dictionary({dbus.String(u'Connected'): 
dbus.Boolean(False, variant_level=1)}, signature=dbus.Signature('sv'))
Oct 24 03:21:03 bang Thread-2:dbusbackend.py@300 Disconnected from 
B0:B4:48:BA:47:03
--- The device reconnects automatically and continues working normally ---
Oct 24 03:21:04 bang bluetoothd[1858]: 
src/adapter.c:connected_callback() hci0 device B0:B4:48:BA:47:03 
connected eir_len 14
Oct 24 03:21:04 bang Thread-2:dbusbackend.py@290 Changed: 
org.bluez.Device1: dbus.Dictionary({dbus.String(u'Connected'): 
dbus.Boolean(True, variant_level=1)}, signature=dbus.Signature('sv'))
Oct 24 03:21:04 bang Thread-2:dbusbackend.py@297 Connected to 
B0:B4:48:BA:47:03
Oct 24 03:21:04 bang bluetoothd[1858]: src/gatt-database.c:connect_cb() 
New incoming LE ATT connection
Oct 24 03:21:04 bang kernel: [1920930.256273] Bluetooth: SMP security 
requested but not available
Oct 24 03:21:04 bang kernel: [1920930.256298] Bluetooth: SMP security 
requested but not available
Oct 24 03:21:04 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa46468: g_attrib_ref=1
Oct 24 03:21:04 bang bluetoothd[1858]: src/device.c:attio_connected()
Oct 24 03:21:04 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa46468: g_attrib_ref=2
Oct 24 03:21:04 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa46468: g_attrib_ref=3
Oct 24 03:21:04 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_connected() Device connected.
Oct 24 03:21:04 bang bluetoothd[1858]: src/device.c:gatt_debug() MTU 
exchange complete, with MTU: 23
Oct 24 03:21:05 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa46468: g_attrib_ref=4
Oct 24 03:21:05 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa46468: g_attrib_unref=3
Oct 24 03:21:05 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa46468: g_attrib_unref=2
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() Primary 
services found: 13
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0001, end: 0x0007, uuid: 00001800-0000-1000-8000-00805f9b34fb
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0008, end: 0x000b, uuid: 00001801-0000-1000-8000-00805f9b34fb
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x000c, end: 0x001e, uuid: 0000180a-0000-1000-8000-00805f9b34fb
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x001f, end: 0x0026, uuid: f000aa00-0451-4000-b000-000000000000
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0027, end: 0x002e, uuid: f000aa20-0451-4000-b000-000000000000
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x002f, end: 0x0036, uuid: f000aa40-0451-4000-b000-000000000000
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0037, end: 0x003e, uuid: f000aa80-0451-4000-b000-000000000000
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x003f, end: 0x0046, uuid: f000aa70-0451-4000-b000-000000000000
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0047, end: 0x004b, uuid: 0000ffe0-0000-1000-8000-00805f9b34fb
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x004c, end: 0x0050, uuid: f000aa64-0451-4000-b000-000000000000
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0051, end: 0x0058, uuid: f000ac00-0451-4000-b000-000000000000
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0059, end: 0x0060, uuid: f000ccc0-0451-4000-b000-000000000000
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0061, end: 0xffff, uuid: f000ffc0-0451-4000-b000-000000000000
Oct 24 03:21:06 bang bluetoothd[1858]: 
src/device.c:gatt_client_ready_cb() status: success, error: 0
Oct 24 03:21:06 bang bluetoothd[1858]: 
src/device.c:device_svc_resolved() /org/bluez/hci0/dev_B0_B4_48_BA_47_03 
err 0
Oct 24 03:21:06 bang bluetoothd[1858]: 
profiles/gap/gas.c:gap_driver_accept() GAP profile accept 
(B0:B4:48:BA:47:03)
Oct 24 03:21:06 bang bluetoothd[1858]: 
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 
00002a04-0000-1000-8000-00805f9b34fb
Oct 24 03:21:06 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_ready() GATT client ready
Oct 24 03:21:06 bang bluetoothd[1858]: 
src/gatt-client.c:create_services() Exporting objects for GATT services: 
B0:B4:48:BA:47:03
Oct 24 03:21:06 bang bluetoothd[1858]: src/device.c:gatt_debug() 
Registered handler for "Service Changed": 1
Oct 24 03:21:06 bang bluetoothd[1858]: 
profiles/gap/gas.c:read_device_name_cb() GAP Device Name: SensorTag 2.0
Oct 24 03:21:07 bang bluetoothd[1858]: 
profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0000
Oct 24 03:22:00 bang Thread-12:dbusbackend.py@138 Writing to 
f000aa65-0451-4000-b000-000000000000 on B0:B4:48:BA:47:03
Oct 24 03:22:00 bang Thread-12:dbusbackend.py@138 Writing to 
f000aa66-0451-4000-b000-000000000000 on B0:B4:48:BA:47:03
Oct 24 03:22:00 bang Thread-12:dbusbackend.py@138 Writing to 
f000aa02-0451-4000-b000-000000000000 on B0:B4:48:BA:47:03
Oct 24 03:22:01 bang Thread-12:dbusbackend.py@138 Writing to 
f000aa65-0451-4000-b000-000000000000 on B0:B4:48:BA:47:03
Oct 24 03:22:01 bang Thread-12:dbusbackend.py@138 Writing to 
f000aa66-0451-4000-b000-000000000000 on B0:B4:48:BA:47:03
Oct 24 03:22:02 bang Thread-12:dbusbackend.py@124 Reading from 
f000aa01-0451-4000-b000-000000000000 on B0:B4:48:BA:47:03
Oct 24 03:22:02 bang Thread-12:dbusbackend.py@138 Writing to 
f000aa02-0451-4000-b000-000000000000 on B0:B4:48:BA:47:03
Oct 24 03:22:02 bang Thread-12:sensortag.py@77 Got temperature 17.96875 
from B0:B4:48:BA:47:03
--- The device disconnects again and reconnects automatically twice ---
Oct 24 03:22:14 bang bluetoothd[1858]: src/adapter.c:dev_disconnected() 
Device B0:B4:48:BA:47:03 disconnected, reason 1
Oct 24 03:22:14 bang bluetoothd[1858]: 
src/adapter.c:adapter_remove_connection()
Oct 24 03:22:14 bang bluetoothd[1858]: plugins/policy.c:disconnect_cb() 
reason 1
Oct 24 03:22:14 bang bluetoothd[1858]: 
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:BA:47:03 
type 1 status 0xe
Oct 24 03:22:14 bang bluetoothd[1858]: 
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct 24 03:22:14 bang bluetoothd[1858]: 
src/device.c:device_bonding_failed() status 14
Oct 24 03:22:14 bang bluetoothd[1858]: src/adapter.c:resume_discovery()
Oct 24 03:22:14 bang bluetoothd[1858]: src/device.c:att_disconnected_cb()
Oct 24 03:22:14 bang bluetoothd[1858]: 
src/device.c:att_disconnected_cb() Connection timed out (110)
Oct 24 03:22:14 bang bluetoothd[1858]: src/device.c:attio_disconnected()
Oct 24 03:22:14 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa46468: g_attrib_unref=1
Oct 24 03:22:14 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. 
Cleaning up.
Oct 24 03:22:14 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa46468: g_attrib_unref=0
Oct 24 03:22:14 bang Thread-2:dbusbackend.py@290 Changed: 
org.bluez.Device1: dbus.Dictionary({dbus.String(u'Connected'): 
dbus.Boolean(False, variant_level=1)}, signature=dbus.Signature('sv'))
Oct 24 03:22:14 bang Thread-2:dbusbackend.py@300 Disconnected from 
B0:B4:48:BA:47:03
Oct 24 03:22:16 bang bluetoothd[1858]: 
src/adapter.c:connected_callback() hci0 device B0:B4:48:BA:47:03 
connected eir_len 14
Oct 24 03:22:16 bang Thread-2:dbusbackend.py@290 Changed: 
org.bluez.Device1: dbus.Dictionary({dbus.String(u'Connected'): 
dbus.Boolean(True, variant_level=1)}, signature=dbus.Signature('sv'))
Oct 24 03:22:16 bang Thread-2:dbusbackend.py@297 Connected to 
B0:B4:48:BA:47:03
Oct 24 03:22:16 bang bluetoothd[1858]: src/gatt-database.c:connect_cb() 
New incoming LE ATT connection
Oct 24 03:22:16 bang kernel: [1921002.549280] Bluetooth: SMP security 
requested but not available
Oct 24 03:22:16 bang kernel: [1921002.549417] Bluetooth: SMP security 
requested but not available
Oct 24 03:22:16 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa45890: g_attrib_ref=1
Oct 24 03:22:16 bang bluetoothd[1858]: src/device.c:attio_connected()
Oct 24 03:22:16 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa45890: g_attrib_ref=2
Oct 24 03:22:16 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa45890: g_attrib_ref=3
Oct 24 03:22:16 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_connected() Device connected.
Oct 24 03:22:17 bang bluetoothd[1858]: src/device.c:gatt_debug() MTU 
exchange complete, with MTU: 23
Oct 24 03:22:18 bang bluetoothd[1858]: src/adapter.c:dev_disconnected() 
Device B0:B4:48:BA:47:03 disconnected, reason 1
Oct 24 03:22:18 bang bluetoothd[1858]: 
src/adapter.c:adapter_remove_connection()
Oct 24 03:22:18 bang bluetoothd[1858]: plugins/policy.c:disconnect_cb() 
reason 1
Oct 24 03:22:18 bang bluetoothd[1858]: 
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:BA:47:03 
type 1 status 0xe
Oct 24 03:22:18 bang bluetoothd[1858]: 
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct 24 03:22:18 bang bluetoothd[1858]: 
src/device.c:device_bonding_failed() status 14
Oct 24 03:22:18 bang bluetoothd[1858]: src/adapter.c:resume_discovery()
Oct 24 03:22:18 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa45890: g_attrib_unref=2
Oct 24 03:22:18 bang bluetoothd[1858]: src/device.c:att_disconnected_cb()
Oct 24 03:22:18 bang bluetoothd[1858]: 
src/device.c:att_disconnected_cb() Connection timed out (110)
Oct 24 03:22:18 bang bluetoothd[1858]: src/device.c:attio_disconnected()
Oct 24 03:22:18 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa45890: g_attrib_unref=1
Oct 24 03:22:18 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. 
Cleaning up.
Oct 24 03:22:18 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa45890: g_attrib_unref=0
Oct 24 03:22:18 bang Thread-2:dbusbackend.py@290 Changed: 
org.bluez.Device1: dbus.Dictionary({dbus.String(u'Connected'): 
dbus.Boolean(False, variant_level=1)}, signature=dbus.Signature('sv'))
Oct 24 03:22:18 bang Thread-2:dbusbackend.py@300 Disconnected from 
B0:B4:48:BA:47:03
Oct 24 03:22:18 bang bluetoothd[1858]: 
src/adapter.c:connected_callback() hci0 device B0:B4:48:BA:47:03 
connected eir_len 14
Oct 24 03:22:18 bang Thread-2:dbusbackend.py@290 Changed: 
org.bluez.Device1: dbus.Dictionary({dbus.String(u'Connected'): 
dbus.Boolean(True, variant_level=1)}, signature=dbus.Signature('sv'))
Oct 24 03:22:18 bang Thread-2:dbusbackend.py@297 Connected to 
B0:B4:48:BA:47:03
Oct 24 03:22:19 bang bluetoothd[1858]: src/gatt-database.c:connect_cb() 
New incoming LE ATT connection
Oct 24 03:22:19 bang kernel: [1921004.709257] Bluetooth: SMP security 
requested but not available
Oct 24 03:22:19 bang kernel: [1921004.709278] Bluetooth: SMP security 
requested but not available
Oct 24 03:22:19 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa351b0: g_attrib_ref=1
Oct 24 03:22:19 bang bluetoothd[1858]: src/device.c:attio_connected()
Oct 24 03:22:19 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa351b0: g_attrib_ref=2
Oct 24 03:22:19 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa351b0: g_attrib_ref=3
Oct 24 03:22:19 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_connected() Device connected.
Oct 24 03:22:19 bang bluetoothd[1858]: src/device.c:gatt_debug() MTU 
exchange complete, with MTU: 23
--- And again ---
Oct 24 03:22:20 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa351b0: g_attrib_ref=4
Oct 24 03:22:20 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa351b0: g_attrib_unref=3
Oct 24 03:22:20 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa351b0: g_attrib_unref=2
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() Primary 
services found: 13
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0001, end: 0x0007, uuid: 00001800-0000-1000-8000-00805f9b34fb
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0008, end: 0x000b, uuid: 00001801-0000-1000-8000-00805f9b34fb
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x000c, end: 0x001e, uuid: 0000180a-0000-1000-8000-00805f9b34fb
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x001f, end: 0x0026, uuid: f000aa00-0451-4000-b000-000000000000
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0027, end: 0x002e, uuid: f000aa20-0451-4000-b000-000000000000
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x002f, end: 0x0036, uuid: f000aa40-0451-4000-b000-000000000000
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0037, end: 0x003e, uuid: f000aa80-0451-4000-b000-000000000000
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x003f, end: 0x0046, uuid: f000aa70-0451-4000-b000-000000000000
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0047, end: 0x004b, uuid: 0000ffe0-0000-1000-8000-00805f9b34fb
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x004c, end: 0x0050, uuid: f000aa64-0451-4000-b000-000000000000
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0051, end: 0x0058, uuid: f000ac00-0451-4000-b000-000000000000
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0059, end: 0x0060, uuid: f000ccc0-0451-4000-b000-000000000000
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0061, end: 0xffff, uuid: f000ffc0-0451-4000-b000-000000000000
Oct 24 03:22:22 bang bluetoothd[1858]: 
src/device.c:gatt_client_ready_cb() status: success, error: 0
Oct 24 03:22:22 bang bluetoothd[1858]: 
src/device.c:device_svc_resolved() /org/bluez/hci0/dev_B0_B4_48_BA_47_03 
err 0
Oct 24 03:22:22 bang bluetoothd[1858]: 
profiles/gap/gas.c:gap_driver_accept() GAP profile accept 
(B0:B4:48:BA:47:03)
Oct 24 03:22:22 bang bluetoothd[1858]: 
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 
00002a04-0000-1000-8000-00805f9b34fb
Oct 24 03:22:22 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_ready() GATT client ready
Oct 24 03:22:22 bang bluetoothd[1858]: 
src/gatt-client.c:create_services() Exporting objects for GATT services: 
B0:B4:48:BA:47:03
Oct 24 03:22:22 bang bluetoothd[1858]: src/device.c:gatt_debug() 
Registered handler for "Service Changed": 1
Oct 24 03:22:22 bang bluetoothd[1858]: 
profiles/gap/gas.c:read_device_name_cb() GAP Device Name: SensorTag 2.0
Oct 24 03:22:23 bang bluetoothd[1858]: 
profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0000
Oct 24 03:22:54 bang bluetoothd[1858]: src/adapter.c:dev_disconnected() 
Device B0:B4:48:BA:47:03 disconnected, reason 1
Oct 24 03:22:54 bang bluetoothd[1858]: 
src/adapter.c:adapter_remove_connection()
Oct 24 03:22:54 bang bluetoothd[1858]: plugins/policy.c:disconnect_cb() 
reason 1
Oct 24 03:22:54 bang bluetoothd[1858]: 
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:BA:47:03 
type 1 status 0xe
Oct 24 03:22:54 bang bluetoothd[1858]: 
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct 24 03:22:54 bang bluetoothd[1858]: 
src/device.c:device_bonding_failed() status 14
Oct 24 03:22:54 bang bluetoothd[1858]: src/adapter.c:resume_discovery()
Oct 24 03:22:54 bang bluetoothd[1858]: src/device.c:att_disconnected_cb()
Oct 24 03:22:54 bang bluetoothd[1858]: 
src/device.c:att_disconnected_cb() Connection timed out (110)
Oct 24 03:22:54 bang bluetoothd[1858]: src/device.c:attio_disconnected()
Oct 24 03:22:54 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa351b0: g_attrib_unref=1
Oct 24 03:22:54 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. 
Cleaning up.
Oct 24 03:22:54 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa351b0: g_attrib_unref=0
Oct 24 03:22:54 bang Thread-2:dbusbackend.py@290 Changed: 
org.bluez.Device1: dbus.Dictionary({dbus.String(u'Connected'): 
dbus.Boolean(False, variant_level=1)}, signature=dbus.Signature('sv'))
Oct 24 03:22:54 bang Thread-2:dbusbackend.py@300 Disconnected from 
B0:B4:48:BA:47:03
Oct 24 03:22:55 bang miniupnpd[3983]: SSDP packet sender 
81.2.120.68:57435 not from a LAN, ignoring
Oct 24 03:22:55 bang bluetoothd[1858]: 
src/adapter.c:connected_callback() hci0 device B0:B4:48:BA:47:03 
connected eir_len 14
Oct 24 03:22:55 bang Thread-2:dbusbackend.py@290 Changed: 
org.bluez.Device1: dbus.Dictionary({dbus.String(u'Connected'): 
dbus.Boolean(True, variant_level=1)}, signature=dbus.Signature('sv'))
Oct 24 03:22:55 bang Thread-2:dbusbackend.py@297 Connected to 
B0:B4:48:BA:47:03
Oct 24 03:22:55 bang miniupnpd[3983]: SSDP packet sender 
81.2.120.68:57435 not from a LAN, ignoring
Oct 24 03:22:56 bang miniupnpd[3983]: SSDP packet sender 
81.2.120.68:57435 not from a LAN, ignoring
Oct 24 03:22:56 bang bluetoothd[1858]: src/adapter.c:dev_disconnected() 
Device B0:B4:48:BA:47:03 disconnected, reason 0
Oct 24 03:22:56 bang bluetoothd[1858]: 
src/adapter.c:adapter_remove_connection()
Oct 24 03:22:56 bang bluetoothd[1858]: plugins/policy.c:disconnect_cb() 
reason 0
Oct 24 03:22:56 bang bluetoothd[1858]: 
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:BA:47:03 
type 1 status 0xe
Oct 24 03:22:56 bang bluetoothd[1858]: 
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct 24 03:22:56 bang bluetoothd[1858]: 
src/device.c:device_bonding_failed() status 14
Oct 24 03:22:56 bang bluetoothd[1858]: src/adapter.c:resume_discovery()
Oct 24 03:22:56 bang Thread-2:dbusbackend.py@290 Changed: 
org.bluez.Device1: dbus.Dictionary({dbus.String(u'Connected'): 
dbus.Boolean(False, variant_level=1)}, signature=dbus.Signature('sv'))
Oct 24 03:22:56 bang Thread-2:dbusbackend.py@300 Disconnected from 
B0:B4:48:BA:47:03
Oct 24 03:22:56 bang bluetoothd[1858]: 
src/adapter.c:connected_callback() hci0 device B0:B4:48:BA:47:03 
connected eir_len 14
Oct 24 03:22:56 bang Thread-2:dbusbackend.py@290 Changed: 
org.bluez.Device1: dbus.Dictionary({dbus.String(u'Connected'): 
dbus.Boolean(True, variant_level=1)}, signature=dbus.Signature('sv'))
Oct 24 03:22:56 bang Thread-2:dbusbackend.py@297 Connected to 
B0:B4:48:BA:47:03
Oct 24 03:22:56 bang bluetoothd[1858]: src/gatt-database.c:connect_cb() 
New incoming LE ATT connection
Oct 24 03:22:56 bang kernel: [1921042.510246] Bluetooth: SMP security 
requested but not available
Oct 24 03:22:56 bang kernel: [1921042.510266] Bluetooth: SMP security 
requested but not available
Oct 24 03:22:56 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa46468: g_attrib_ref=1
Oct 24 03:22:56 bang bluetoothd[1858]: src/device.c:attio_connected()
Oct 24 03:22:56 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa46468: g_attrib_ref=2
Oct 24 03:22:56 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa46468: g_attrib_ref=3
Oct 24 03:22:56 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_connected() Device connected.
--- This is where things seem to start going wrong ---
Oct 24 03:22:57 bang bluetoothd[1858]: src/adapter.c:dev_disconnected() 
Device B0:B4:48:BA:47:03 disconnected, reason 1
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/adapter.c:adapter_remove_connection()
Oct 24 03:22:57 bang bluetoothd[1858]: plugins/policy.c:disconnect_cb() 
reason 1
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:BA:47:03 
type 1 status 0xe
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/device.c:device_bonding_failed() status 14
Oct 24 03:22:57 bang bluetoothd[1858]: src/adapter.c:resume_discovery()
Oct 24 03:22:57 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa46468: g_attrib_unref=2
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/device.c:gatt_service_removed() start: 0x0001, end: 0x0007
Oct 24 03:22:57 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa3f808: device B0:B4:48:BA:47:03 profile gap-profile state changed: 
connecting -> disconnected (-103)
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/device.c:device_profile_connected() gap-profile Software caused 
connection abort (103)
Oct 24 03:22:57 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa3f808: device B0:B4:48:BA:47:03 profile gap-profile state changed: 
disconnected -> unavailable (0)
Oct 24 03:22:57 bang bluetoothd[1858]: 
profiles/gap/gas.c:gap_driver_remove() GAP profile remove 
(B0:B4:48:BA:47:03)
Oct 24 03:22:57 bang bluetoothd[1858]: src/service.c:btd_service_unref() 
0x7fa3f808: ref=0
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_service_removed() GATT Services 
Removed - start: 0x0001, end: 0x0007
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/device.c:gatt_service_removed() start: 0x0008, end: 0x000b
Oct 24 03:22:57 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa3f888: device B0:B4:48:BA:47:03 profile Proximity Reporter GATT 
Driver state changed: connecting -> disconnected (-103)
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/device.c:device_profile_connected() Proximity Reporter GATT Driver 
Software caused connection abort (103)
Oct 24 03:22:57 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa3f888: device B0:B4:48:BA:47:03 profile Proximity Reporter GATT 
Driver state changed: disconnected -> unavailable (0)
Oct 24 03:22:57 bang bluetoothd[1858]: 
profiles/proximity/reporter.c:unregister_reporter_device() unregister on 
device /org/bluez/hci0/dev_B0_B4_48_BA_47_03
Oct 24 03:22:57 bang bluetoothd[1858]: src/service.c:btd_service_unref() 
0x7fa3f888: ref=0
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_service_removed() GATT Services 
Removed - start: 0x0008, end: 0x000b
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/device.c:gatt_service_removed() start: 0x000c, end: 0x001e
Oct 24 03:22:57 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa36528: device B0:B4:48:BA:47:03 profile deviceinfo state changed: 
connecting -> disconnected (-103)
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/device.c:device_profile_connected() deviceinfo Software caused 
connection abort (103)
Oct 24 03:22:57 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa36528: device B0:B4:48:BA:47:03 profile deviceinfo state changed: 
disconnected -> unavailable (0)
Oct 24 03:22:57 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa46468: g_attrib_unref=1
Oct 24 03:22:57 bang bluetoothd[1858]: src/service.c:btd_service_unref() 
0x7fa36528: ref=0
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_service_removed() GATT Services 
Removed - start: 0x000c, end: 0x001e
--- These lines are repeated for each GATT service on the device: start ---
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/device.c:gatt_service_removed() start: 0x001f, end: 0x0026
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_service_removed() GATT Services 
Removed - start: 0x001f, end: 0x0026
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/gatt-client.c:unregister_service() Removing GATT service: 
/org/bluez/hci0/dev_B0_B4_48_BA_47_03/service001f
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/gatt-client.c:unregister_characteristic() Removing GATT 
characteristic: /org/bluez/hci0/dev_B0_B4_48_BA_47_03/service001f/char0020
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/gatt-client.c:unregister_descriptor() Removing GATT descriptor: 
/org/bluez/hci0/dev_B0_B4_48_BA_47_03/service001f/char0020/desc0022
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/gatt-client.c:unregister_characteristic() Removing GATT 
characteristic: /org/bluez/hci0/dev_B0_B4_48_BA_47_03/service001f/char0023
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/gatt-client.c:unregister_characteristic() Removing GATT 
characteristic: /org/bluez/hci0/dev_B0_B4_48_BA_47_03/service001f/char0025
--- These lines are repeated for each GATT service on the device: end ---
Oct 24 03:22:57 bang bluetoothd[1858]: src/device.c:att_disconnected_cb()
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/device.c:att_disconnected_cb() Connection timed out (110)
Oct 24 03:22:57 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. 
Cleaning up.
Oct 24 03:22:57 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa46468: g_attrib_unref=0
Oct 24 03:22:58 bang bluetoothd[1858]: 
src/adapter.c:connected_callback() hci0 device B0:B4:48:BA:47:03 
connected eir_len 14
Oct 24 03:22:59 bang bluetoothd[1858]: src/gatt-database.c:connect_cb() 
New incoming LE ATT connection
Oct 24 03:22:59 bang kernel: [1921044.737131] Bluetooth: SMP security 
requested but not available
Oct 24 03:22:59 bang kernel: [1921044.737156] Bluetooth: SMP security 
requested but not available
Oct 24 03:22:59 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa2c610: g_attrib_ref=1
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_gatt_db() 
Restoring B0:B4:48:BA:47:03 gatt database from file
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x0001, end: 0x0007, uuid: 
00001800-0000-1000-8000-00805f9b34fb
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x0008, end: 0x000b, uuid: 
00001801-0000-1000-8000-00805f9b34fb
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x000c, end: 0x001e, uuid: 
0000180a-0000-1000-8000-00805f9b34fb
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x001f, end: 0x0026, uuid: 
f000aa00-0451-4000-b000-000000000000
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x0027, end: 0x002e, uuid: 
f000aa20-0451-4000-b000-000000000000
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x002f, end: 0x0036, uuid: 
f000aa40-0451-4000-b000-000000000000
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x0037, end: 0x003e, uuid: 
f000aa80-0451-4000-b000-000000000000
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x003f, end: 0x0046, uuid: 
f000aa70-0451-4000-b000-000000000000
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x0047, end: 0x004b, uuid: 
0000ffe0-0000-1000-8000-00805f9b34fb
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x004c, end: 0x0050, uuid: 
f000aa64-0451-4000-b000-000000000000
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x0051, end: 0x0058, uuid: 
f000ac00-0451-4000-b000-000000000000
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x0059, end: 0x0060, uuid: 
f000ccc0-0451-4000-b000-000000000000
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_service() 
loading service: 0x0061, end: 0xffff, uuid: 
f000ffc0-0451-4000-b000-000000000000
--- These lines are repeated for each GATT service on the device: start ---
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_chrc() loading 
characteristic handle: 0x0002, value handle: 0x0003, properties 0x0002 
uuid: 00002a00-0000-1000-8000-00805f9b34fb
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_chrc() loading 
characteristic handle: 0x0004, value handle: 0x0005, properties 0x0002 
uuid: 00002a01-0000-1000-8000-00805f9b34fb
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_chrc() loading 
characteristic handle: 0x0006, value handle: 0x0007, properties 0x0002 
uuid: 00002a04-0000-1000-8000-00805f9b34fb
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_chrc() loading 
characteristic handle: 0x0009, value handle: 0x000a, properties 0x0020 
uuid: 00002a05-0000-1000-8000-00805f9b34fb
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:load_desc() loading 
descriptor handle: 0x000b, uuid: 00002902-0000-1000-8000-00805f9b34fb
--- These lines are repeated for each GATT service on the device: end ---
Oct 24 03:22:59 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_connected() Device connected.
Oct 24 03:22:59 bang bluetoothd[1858]: src/device.c:gatt_debug() MTU 
exchange complete, with MTU: 23
Oct 24 03:23:00 bang Thread-16:dbusbackend.py@138 Writing to 
f000aa65-0451-4000-b000-000000000000 on B0:B4:48:BA:47:03
Oct 24 03:23:00 bang Thread-16:sensortag.py@59 nce1: 
org.freedesktop.DBus.Error.UnknownObject: Method "WriteValue" with 
signature "ay" on interface "org.bluez.GattCharacteristic1" doesn't exist
--- dbus has thrown a NotConnectedError, my code then tries to 
disconnect and reconnect explicitly ---
Oct 24 03:23:00 bang Thread-16:dbusbackend.py@383 Disconnect from 
B0:B4:48:BA:47:03
Oct 24 03:23:00 bang bluetoothd[1858]: 
src/device.c:device_set_auto_connect() B0:B4:48:BA:47:03 auto connect: 0
Oct 24 03:23:00 bang bluetoothd[1858]: 
src/adapter.c:remove_device_complete() B0:B4:48:BA:47:03 (1) removed 
from kernel connect list
Oct 24 03:23:00 bang bluetoothd[1858]: src/adapter.c:dev_disconnected() 
Device B0:B4:48:BA:47:03 disconnected, reason 1
Oct 24 03:23:00 bang bluetoothd[1858]: 
src/adapter.c:adapter_remove_connection()
Oct 24 03:23:00 bang bluetoothd[1858]: plugins/policy.c:disconnect_cb() 
reason 1
Oct 24 03:23:00 bang bluetoothd[1858]: 
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:BA:47:03 
type 1 status 0xe
Oct 24 03:23:00 bang bluetoothd[1858]: 
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct 24 03:23:00 bang bluetoothd[1858]: 
src/device.c:device_bonding_failed() status 14
Oct 24 03:23:00 bang bluetoothd[1858]: src/adapter.c:resume_discovery()
Oct 24 03:23:00 bang bluetoothd[1858]: src/device.c:att_disconnected_cb()
Oct 24 03:23:00 bang bluetoothd[1858]: 
src/device.c:att_disconnected_cb() Connection timed out (110)
Oct 24 03:23:00 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. 
Cleaning up.
Oct 24 03:23:00 bang bluetoothd[1858]: 
src/device.c:att_disconnected_cb() Automatic connection disabled
Oct 24 03:23:00 bang Thread-16:dbusbackend.py@111 Disconnected from 
/org/bluez/hci0/dev_B0_B4_48_BA_47_03
Oct 24 03:23:00 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa2c610: g_attrib_unref=0
--- Reconnect here ---
Oct 24 03:23:00 bang Thread-16:dbusbackend.py@371 Connect to 
B0:B4:48:BA:47:03
Oct 24 03:23:00 bang bluetoothd[1858]: 
src/device.c:device_set_auto_connect() B0:B4:48:BA:47:03 auto connect: 1
Oct 24 03:23:00 bang bluetoothd[1858]: src/device.c:device_connect_le() 
Connection attempt to: B0:B4:48:BA:47:03
Oct 24 03:23:00 bang bluetoothd[1858]: 
src/adapter.c:add_device_complete() B0:B4:48:BA:47:03 (1) added to 
kernel connect list
Oct 24 03:23:01 bang bluetoothd[1858]: 
src/adapter.c:connected_callback() hci0 device B0:B4:48:BA:47:03 
connected eir_len 0
Oct 24 03:23:01 bang kernel: [1921047.167257] Bluetooth: SMP security 
requested but not available
Oct 24 03:23:01 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa32f40: g_attrib_ref=1
Oct 24 03:23:01 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_connected() Device connected.
Oct 24 03:23:01 bang bluetoothd[1858]: src/device.c:gatt_debug() MTU 
exchange complete, with MTU: 23
Oct 24 03:23:02 bang Thread-16:dbusbackend.py@133 Attempting to write to 
B0:B4:48:BA:47:03 but not connected!
Oct 24 03:23:02 bang Thread-16:sensortag.py@59 nce1:
Oct 24 03:23:02 bang Thread-16:dbusbackend.py@383 Disconnect from 
B0:B4:48:BA:47:03
Oct 24 03:23:02 bang bluetoothd[1858]: 
src/device.c:device_set_auto_connect() B0:B4:48:BA:47:03 auto connect: 0
Oct 24 03:23:02 bang bluetoothd[1858]: 
src/adapter.c:remove_device_complete() B0:B4:48:BA:47:03 (1) removed 
from kernel connect list
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() Primary 
services found: 13
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0001, end: 0x0007, uuid: 00001800-0000-1000-8000-00805f9b34fb
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0008, end: 0x000b, uuid: 00001801-0000-1000-8000-00805f9b34fb
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x000c, end: 0x001e, uuid: 0000180a-0000-1000-8000-00805f9b34fb
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x001f, end: 0x0026, uuid: f000aa00-0451-4000-b000-000000000000
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0027, end: 0x002e, uuid: f000aa20-0451-4000-b000-000000000000
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x002f, end: 0x0036, uuid: f000aa40-0451-4000-b000-000000000000
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0037, end: 0x003e, uuid: f000aa80-0451-4000-b000-000000000000
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x003f, end: 0x0046, uuid: f000aa70-0451-4000-b000-000000000000
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0047, end: 0x004b, uuid: 0000ffe0-0000-1000-8000-00805f9b34fb
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x004c, end: 0x0050, uuid: f000aa64-0451-4000-b000-000000000000
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0051, end: 0x0058, uuid: f000ac00-0451-4000-b000-000000000000
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0059, end: 0x0060, uuid: f000ccc0-0451-4000-b000-000000000000
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() start: 
0x0061, end: 0xffff, uuid: f000ffc0-0451-4000-b000-000000000000
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:gatt_client_ready_cb() status: success, error: 0
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
profiles/gap/gas.c:gap_driver_probe() GAP profile probe (B0:B4:48:BA:47:03)
Oct 24 03:23:03 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa34030: device B0:B4:48:BA:47:03 profile gap-profile state changed: 
unavailable -> disconnected (0)
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
profiles/proximity/reporter.c:register_reporter_device() register on 
device /org/bluez/hci0/dev_B0_B4_48_BA_47_03
Oct 24 03:23:03 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa328d0: device B0:B4:48:BA:47:03 profile Proximity Reporter GATT 
Driver state changed: unavailable -> disconnected (0)
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:btd_device_add_attio_callback() 0x7fa33c88 registered ATT 
connection callback
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_set_auto_connect() B0:B4:48:BA:47:03 auto connect: 1
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_set_auto_connect() Already connected
Oct 24 03:23:03 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa43228: device B0:B4:48:BA:47:03 profile deviceinfo state changed: 
unavailable -> disconnected (0)
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_probe_profiles() Probing profiles for device 
B0:B4:48:BA:47:03
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/device.c:device_svc_resolved() /org/bluez/hci0/dev_B0_B4_48_BA_47_03 
err 0
Oct 24 03:23:03 bang bluetoothd[1858]: 
profiles/gap/gas.c:gap_driver_accept() GAP profile accept 
(B0:B4:48:BA:47:03)
Oct 24 03:23:03 bang bluetoothd[1858]: 
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 2a04
Oct 24 03:23:03 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa34030: device B0:B4:48:BA:47:03 profile gap-profile state changed: 
disconnected -> connecting (0)
Oct 24 03:23:03 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa328d0: device B0:B4:48:BA:47:03 profile Proximity Reporter GATT 
Driver state changed: disconnected -> connecting (0)
Oct 24 03:23:03 bang bluetoothd[1858]: src/service.c:change_state() 
0x7fa43228: device B0:B4:48:BA:47:03 profile deviceinfo state changed: 
disconnected -> connecting (0)
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_ready() GATT client ready
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/gatt-client.c:create_services() Exporting objects for GATT services: 
B0:B4:48:BA:47:03
--- These lines are repeated for each GATT service on the device: start ---
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/gatt-client.c:service_create() Exported GATT service: 
/org/bluez/hci0/dev_B0_B4_48_BA_47_03/service001f
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/gatt-client.c:characteristic_create() Exported GATT characteristic: 
/org/bluez/hci0/dev_B0_B4_48_BA_47_03/service001f/char0020
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/gatt-client.c:descriptor_create() Exported GATT characteristic 
descriptor: 
/org/bluez/hci0/dev_B0_B4_48_BA_47_03/service001f/char0020/desc0022
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/gatt-client.c:characteristic_create() Exported GATT characteristic: 
/org/bluez/hci0/dev_B0_B4_48_BA_47_03/service001f/char0023
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/gatt-client.c:characteristic_create() Exported GATT characteristic: 
/org/bluez/hci0/dev_B0_B4_48_BA_47_03/service001f/char0025
--- These lines are repeated for each GATT service on the device: end ---
Oct 24 03:23:03 bang bluetoothd[1858]: 
src/adapter.c:add_device_complete() B0:B4:48:BA:47:03 (1) added to 
kernel connect list
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:notify_attios()
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:attio_connected()
Oct 24 03:23:03 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa32f40: g_attrib_ref=2
Oct 24 03:23:03 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa32f40: g_attrib_ref=3
Oct 24 03:23:03 bang bluetoothd[1858]: src/device.c:gatt_debug() 
Registered handler for "Service Changed": 1
Oct 24 03:23:03 bang bluetoothd[1858]: 
profiles/gap/gas.c:read_device_name_cb() GAP Device Name: SensorTag 2.0
Oct 24 03:23:03 bang bluetoothd[1858]: 
profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0000
Oct 24 03:23:03 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa32f40: g_attrib_ref=4
Oct 24 03:23:03 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa32f40: g_attrib_unref=3
Oct 24 03:23:04 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa32f40: g_attrib_unref=2
Oct 24 03:23:04 bang bluetoothd[1858]: src/adapter.c:dev_disconnected() 
Device B0:B4:48:BA:47:03 disconnected, reason 2
Oct 24 03:23:04 bang bluetoothd[1858]: 
src/adapter.c:adapter_remove_connection()
Oct 24 03:23:04 bang bluetoothd[1858]: plugins/policy.c:disconnect_cb() 
reason 2
Oct 24 03:23:04 bang bluetoothd[1858]: 
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:BA:47:03 
type 1 status 0xe
Oct 24 03:23:04 bang bluetoothd[1858]: 
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct 24 03:23:04 bang bluetoothd[1858]: 
src/device.c:device_bonding_failed() status 14
Oct 24 03:23:04 bang bluetoothd[1858]: src/adapter.c:resume_discovery()
Oct 24 03:23:04 bang bluetoothd[1858]: src/device.c:att_disconnected_cb()
Oct 24 03:23:04 bang bluetoothd[1858]: 
src/device.c:att_disconnected_cb() Software caused connection abort (103)
Oct 24 03:23:04 bang bluetoothd[1858]: src/device.c:attio_disconnected()
Oct 24 03:23:04 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa32f40: g_attrib_unref=1
Oct 24 03:23:04 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. 
Cleaning up.
Oct 24 03:23:04 bang bluetoothd[1858]: 
src/device.c:att_disconnected_cb() Automatic connection disabled
Oct 24 03:23:04 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa32f40: g_attrib_unref=0
Oct 24 03:23:04 bang Thread-16:dbusbackend.py@111 Disconnected from 
/org/bluez/hci0/dev_B0_B4_48_BA_47_03
Oct 24 03:23:04 bang Thread-16:dbusbackend.py@371 Connect to 
B0:B4:48:BA:47:03
Oct 24 03:23:04 bang bluetoothd[1858]: 
src/device.c:device_set_auto_connect() B0:B4:48:BA:47:03 auto connect: 1
Oct 24 03:23:04 bang bluetoothd[1858]: src/device.c:device_connect_le() 
Connection attempt to: B0:B4:48:BA:47:03
Oct 24 03:23:04 bang bluetoothd[1858]: 
src/adapter.c:connected_callback() hci0 device B0:B4:48:BA:47:03 
connected eir_len 0
Oct 24 03:23:04 bang kernel: [1921050.340244] Bluetooth: SMP security 
requested but not available
Oct 24 03:23:04 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa34008: g_attrib_ref=1
Oct 24 03:23:04 bang bluetoothd[1858]: src/device.c:attio_connected()
Oct 24 03:23:04 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa34008: g_attrib_ref=2
Oct 24 03:23:04 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa34008: g_attrib_ref=3
Oct 24 03:23:04 bang bluetoothd[1858]: 
src/gatt-client.c:btd_gatt_client_connected() Device connected.
Oct 24 03:23:04 bang bluetoothd[1858]: src/device.c:gatt_debug() MTU 
exchange complete, with MTU: 23
Oct 24 03:23:05 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_ref() 
0x7fa34008: g_attrib_ref=4
Oct 24 03:23:05 bang bluetoothd[1858]: attrib/gattrib.c:g_attrib_unref() 
0x7fa34008: g_attrib_unref=3
--- End

This cycle then seems to repeat forever, with either of these two lines 
appearing (although error 103 is by far most common)
Oct 24 03:23:04 bang bluetoothd[1858]: 
src/device.c:att_disconnected_cb() Software caused connection abort (103)
Oct 24 03:28:02 bang bluetoothd[1858]: 
src/device.c:att_disconnected_cb() Connection timed out (110)

-- 
Regards
Steven Davies
