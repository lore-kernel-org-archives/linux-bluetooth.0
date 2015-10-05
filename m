Return-Path: <cyrus@holtmann.org>
Message-ID: <56126614.5050303@steev.me.uk>
Date: Mon, 05 Oct 2015 12:59:16 +0100
From: Steven Davies <linux-bluetooth-list@steev.me.uk>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Gone away BLE device still available in dbus
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have two BLE devices which are visible to the bluetooth stack on my
host machine. One of them is at the edge of the reception range and
sometimes the host can't connect to it. I would expect bluez to remove
the record of this device after a timeout (3 minutes?) but it doesn't
seem to. Instead, when trying to connect to the device I see this debug
output:

Oct  5 12:35:57 bang bluetoothd[3801]: src/device.c:device_connect_le()
Connection attempt to: B0:B4:48:B9:77:03
Oct  5 12:36:17 bang bluetoothd[3801]:
src/adapter.c:connect_failed_callback() hci0 B0:B4:48:B9:77:03 status 2
Oct  5 12:36:17 bang bluetoothd[3801]: plugins/policy.c:conn_fail_cb()
status 2
Oct  5 12:36:17 bang bluetoothd[3801]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:B9:77:03
type 1 status 0x2
Oct  5 12:36:17 bang bluetoothd[3801]:
src/device.c:device_bonding_complete() bonding (nil) status 0x02
Oct  5 12:36:17 bang bluetoothd[3801]:
src/device.c:device_bonding_failed() status 2
Oct  5 12:36:17 bang bluetoothd[3801]: src/adapter.c:resume_discovery()
Oct  5 12:36:17 bang bluetoothd[3801]: src/device.c:att_connect_cb()
connect error: Transport endpoint is not connected (107)
Oct  5 12:36:17 bang bluetoothd[3801]: src/device.c:att_error_cb()
Enabling automatic connections

This returns the message "GDBus.Error:org.bluez.Error.Failed: Software
caused connection abort (36)" through dbus.

Should the device not be removed from the device list after a timeout?
At this point the device had been unavailable for two and a half hours:

Oct  5 10:02:02 bang bluetoothd[3801]: src/adapter.c:dev_disconnected()
Device B0:B4:48:B9:77:03 disconnected, reason 1
Oct  5 10:02:02 bang bluetoothd[3801]:
src/adapter.c:adapter_remove_connection()
Oct  5 10:02:02 bang bluetoothd[3801]: plugins/policy.c:disconnect_cb()
reason 1
Oct  5 10:02:02 bang bluetoothd[3801]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:B9:77:03
type 1 status 0xe
Oct  5 10:02:02 bang bluetoothd[3801]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct  5 10:02:02 bang bluetoothd[3801]:
src/device.c:device_bonding_failed() status 14
Oct  5 10:02:02 bang bluetoothd[3801]: src/adapter.c:resume_discovery()
Oct  5 10:02:02 bang bluetoothd[3801]: src/device.c:att_disconnected_cb()
Oct  5 10:02:02 bang bluetoothd[3801]:
src/device.c:att_disconnected_cb() Connection timed out (110)
Oct  5 10:02:02 bang bluetoothd[3801]: src/device.c:attio_disconnected()
Oct  5 10:02:02 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x80498480: g_attrib_unref=1
Oct  5 10:02:02 bang bluetoothd[3801]:
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
Cleaning up.
Oct  5 10:02:02 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x80498480: g_attrib_unref=0
Oct  5 10:02:03 bang bluetoothd[3801]:
src/adapter.c:connected_callback() hci0 device B0:B4:48:B9:77:03
connected eir_len 14
Oct  5 10:02:03 bang bluetoothd[3801]: src/gatt-database.c:connect_cb()
New incoming LE ATT connection
Oct  5 10:02:03 bang kernel: [303380.113098] Bluetooth: SMP security
requested but not available
Oct  5 10:02:03 bang kernel: [303380.113199] Bluetooth: SMP security
requested but not available
Oct  5 10:02:03 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_ref()
0x8048e760: g_attrib_ref=1
Oct  5 10:02:03 bang bluetoothd[3801]: src/device.c:attio_connected()
Oct  5 10:02:03 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_ref()
0x8048e760: g_attrib_ref=2
Oct  5 10:02:03 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_ref()
0x8048e760: g_attrib_ref=3
Oct  5 10:02:03 bang bluetoothd[3801]:
src/gatt-client.c:btd_gatt_client_connected() Device connected.
Oct  5 10:02:03 bang bluetoothd[3801]: src/device.c:gatt_debug() MTU
exchange complete, with MTU: 23
Oct  5 10:02:05 bang bluetoothd[3801]: src/adapter.c:dev_disconnected()
Device B0:B4:48:B9:77:03 disconnected, reason 1
Oct  5 10:02:05 bang bluetoothd[3801]:
src/adapter.c:adapter_remove_connection()
Oct  5 10:02:05 bang bluetoothd[3801]: plugins/policy.c:disconnect_cb()
reason 1
Oct  5 10:02:05 bang bluetoothd[3801]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:B9:77:03
type 1 status 0xe
Oct  5 10:02:05 bang bluetoothd[3801]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct  5 10:02:05 bang bluetoothd[3801]:
src/device.c:device_bonding_failed() status 14
Oct  5 10:02:05 bang bluetoothd[3801]: src/adapter.c:resume_discovery()
Oct  5 10:02:05 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x8048e760: g_attrib_unref=2
Oct  5 10:02:05 bang bluetoothd[3801]: src/device.c:att_disconnected_cb()
Oct  5 10:02:05 bang bluetoothd[3801]:
src/device.c:att_disconnected_cb() Connection timed out (110)
Oct  5 10:02:05 bang bluetoothd[3801]: src/device.c:attio_disconnected()
Oct  5 10:02:05 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x8048e760: g_attrib_unref=1
Oct  5 10:02:05 bang bluetoothd[3801]:
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
Cleaning up.
Oct  5 10:02:05 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x8048e760: g_attrib_unref=0
Oct  5 10:02:07 bang bluetoothd[3801]:
src/adapter.c:connected_callback() hci0 device B0:B4:48:B9:77:03
connected eir_len 14
Oct  5 10:02:07 bang bluetoothd[3801]: src/gatt-database.c:connect_cb()
New incoming LE ATT connection
Oct  5 10:02:07 bang kernel: [303384.162852] Bluetooth: SMP security
requested but not available
Oct  5 10:02:07 bang kernel: [303384.162908] Bluetooth: SMP security
requested but not available
Oct  5 10:02:07 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_ref()
0x8043d920: g_attrib_ref=1
Oct  5 10:02:07 bang bluetoothd[3801]: src/device.c:attio_connected()
Oct  5 10:02:07 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_ref()
0x8043d920: g_attrib_ref=2
Oct  5 10:02:07 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_ref()
0x8043d920: g_attrib_ref=3
Oct  5 10:02:07 bang bluetoothd[3801]:
src/gatt-client.c:btd_gatt_client_connected() Device connected.
Oct  5 10:02:08 bang bluetoothd[3801]: src/device.c:gatt_debug() MTU
exchange complete, with MTU: 23
Oct  5 10:02:09 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_ref()
0x8043d920: g_attrib_ref=4
Oct  5 10:02:09 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x8043d920: g_attrib_unref=3
Oct  5 10:02:09 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x8043d920: g_attrib_unref=2
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() Primary
services found: 13
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x0001, end: 0x0007, uuid: 00001800-0000-1000-8000-00805f9b34fb
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x0008, end: 0x000b, uuid: 00001801-0000-1000-8000-00805f9b34fb
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x000c, end: 0x001e, uuid: 0000180a-0000-1000-8000-00805f9b34fb
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x001f, end: 0x0026, uuid: f000aa00-0451-4000-b000-000000000000
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x0027, end: 0x002e, uuid: f000aa20-0451-4000-b000-000000000000
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x002f, end: 0x0036, uuid: f000aa40-0451-4000-b000-000000000000
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x0037, end: 0x003e, uuid: f000aa80-0451-4000-b000-000000000000
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x003f, end: 0x0046, uuid: f000aa70-0451-4000-b000-000000000000
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x0047, end: 0x004b, uuid: 0000ffe0-0000-1000-8000-00805f9b34fb
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x004c, end: 0x0050, uuid: f000aa64-0451-4000-b000-000000000000
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x0051, end: 0x0058, uuid: f000ac00-0451-4000-b000-000000000000
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x0059, end: 0x0060, uuid: f000ccc0-0451-4000-b000-000000000000
Oct  5 10:02:11 bang bluetoothd[3801]: src/device.c:gatt_debug() start:
0x0061, end: 0xffff, uuid: f000ffc0-0451-4000-b000-000000000000
Oct  5 10:02:11 bang bluetoothd[3801]:
src/device.c:gatt_client_ready_cb() status: success, error: 0
Oct  5 10:02:11 bang bluetoothd[3801]:
src/device.c:device_svc_resolved() /org/bluez/hci0/dev_B0_B4_48_B9_77_03
err 0
Oct  5 10:02:11 bang bluetoothd[3801]:
profiles/gap/gas.c:gap_driver_accept() GAP profile accept
(B0:B4:48:B9:77:03)
Oct  5 10:02:11 bang bluetoothd[3801]:
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 2a04
Oct  5 10:02:11 bang bluetoothd[3801]:
src/gatt-client.c:btd_gatt_client_ready() GATT client ready
Oct  5 10:02:11 bang bluetoothd[3801]:
src/gatt-client.c:create_services() Exporting objects for GATT services:
B0:B4:48:B9:77:03
Oct  5 10:02:12 bang bluetoothd[3801]: src/device.c:gatt_debug()
Registered handler for "Service Changed": 1
Oct  5 10:02:12 bang bluetoothd[3801]:
profiles/gap/gas.c:read_device_name_cb() GAP Device Name: SensorTag 2.0
Oct  5 10:02:12 bang bluetoothd[3801]:
profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0000
Oct  5 10:02:27 bang Thread-4:dbusbackend.py@327 Disconnect from
B0:B4:48:B9:77:03
Oct  5 10:02:27 bang bluetoothd[3801]:
src/device.c:device_set_auto_connect() B0:B4:48:B9:77:03 auto connect: 0
Oct  5 10:02:27 bang bluetoothd[3801]:
src/adapter.c:remove_device_complete() B0:B4:48:B9:77:03 (1) removed
from kernel connect list
Oct  5 10:02:29 bang bluetoothd[3801]: src/adapter.c:dev_disconnected()
Device B0:B4:48:B9:77:03 disconnected, reason 2
Oct  5 10:02:29 bang bluetoothd[3801]:
src/adapter.c:adapter_remove_connection()
Oct  5 10:02:29 bang bluetoothd[3801]: plugins/policy.c:disconnect_cb()
reason 2
Oct  5 10:02:29 bang bluetoothd[3801]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:B9:77:03
type 1 status 0xe
Oct  5 10:02:29 bang bluetoothd[3801]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct  5 10:02:29 bang bluetoothd[3801]:
src/device.c:device_bonding_failed() status 14
Oct  5 10:02:29 bang bluetoothd[3801]: src/adapter.c:resume_discovery()
Oct  5 10:02:29 bang bluetoothd[3801]: src/device.c:att_disconnected_cb()
Oct  5 10:02:29 bang bluetoothd[3801]:
src/device.c:att_disconnected_cb() Software caused connection abort (103)
Oct  5 10:02:29 bang bluetoothd[3801]: src/device.c:attio_disconnected()
Oct  5 10:02:29 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x8043d920: g_attrib_unref=1
Oct  5 10:02:29 bang bluetoothd[3801]:
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
Cleaning up.
Oct  5 10:02:29 bang bluetoothd[3801]:
src/device.c:att_disconnected_cb() Automatic connection disabled
Oct  5 10:02:29 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x8043d920: g_attrib_unref=0
Oct  5 10:02:29 bang Thread-4:dbusbackend.py@315 Connect to
B0:B4:48:B9:77:03
Oct  5 10:02:29 bang bluetoothd[3801]:
src/device.c:device_set_auto_connect() B0:B4:48:B9:77:03 auto connect: 1
Oct  5 10:02:29 bang bluetoothd[3801]: src/device.c:device_connect_le()
Connection attempt to: B0:B4:48:B9:77:03
Oct  5 10:02:29 bang bluetoothd[3801]:
src/adapter.c:add_device_complete() B0:B4:48:B9:77:03 (1) added to
kernel connect list
Oct  5 10:02:29 bang bluetoothd[3801]:
src/adapter.c:connected_callback() hci0 device B0:B4:48:B9:77:03
connected eir_len 0
Oct  5 10:02:29 bang kernel: [303406.303020] Bluetooth: SMP security
requested but not available
Oct  5 10:02:29 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_ref()
0x8049a768: g_attrib_ref=1
Oct  5 10:02:29 bang bluetoothd[3801]: src/device.c:attio_connected()
Oct  5 10:02:29 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_ref()
0x8049a768: g_attrib_ref=2
Oct  5 10:02:29 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_ref()
0x8049a768: g_attrib_ref=3
Oct  5 10:02:29 bang bluetoothd[3801]:
src/gatt-client.c:btd_gatt_client_connected() Device connected.
Oct  5 10:02:30 bang bluetoothd[3801]: src/device.c:gatt_debug() MTU
exchange complete, with MTU: 23
Oct  5 10:02:31 bang bluetoothd[3801]: src/adapter.c:dev_disconnected()
Device B0:B4:48:B9:77:03 disconnected, reason 1
Oct  5 10:02:31 bang bluetoothd[3801]:
src/adapter.c:adapter_remove_connection()
Oct  5 10:02:31 bang bluetoothd[3801]: plugins/policy.c:disconnect_cb()
reason 1
Oct  5 10:02:31 bang bluetoothd[3801]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr B0:B4:48:B9:77:03
type 1 status 0xe
Oct  5 10:02:31 bang bluetoothd[3801]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Oct  5 10:02:31 bang bluetoothd[3801]:
src/device.c:device_bonding_failed() status 14
Oct  5 10:02:31 bang bluetoothd[3801]: src/adapter.c:resume_discovery()
Oct  5 10:02:31 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x8049a768: g_attrib_unref=2
Oct  5 10:02:31 bang bluetoothd[3801]: src/device.c:att_disconnected_cb()
Oct  5 10:02:31 bang bluetoothd[3801]:
src/device.c:att_disconnected_cb() Connection timed out (110)
Oct  5 10:02:31 bang bluetoothd[3801]: src/device.c:attio_disconnected()
Oct  5 10:02:31 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x8049a768: g_attrib_unref=1
Oct  5 10:02:31 bang bluetoothd[3801]:
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected.
Cleaning up.
Oct  5 10:02:31 bang bluetoothd[3801]: attrib/gattrib.c:g_attrib_unref()
0x8049a768: g_attrib_unref=0

Regards
Steven Davies
