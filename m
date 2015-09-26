Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
From: linux-bluetooth-list@steev.me.uk
Subject: Unable to connect to device after connected_callback() has run
Message-ID: <5606F366.3040207@steev.me.uk>
Date: Sat, 26 Sep 2015 20:35:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Following on from my problems with GATT discovery, I now have another
issue: I have a Python program which waits for the Connected=True
PropertiesChanged callback from dbus, then sends a WriteValue to a
GattCharacteristic1 interface.

The issue is that immediately after the Connected=True message comes
back, a WriteValue fails with "DBusException: org.bluez.Error.Failed:
Not connected". However, calling the WriteValue a few seconds later
executes correctly.

I have bluetoothd running with the debug flag and this is the output
(sorry it's long - also in pastebin at http://pastebin.com/bnNRGpMq):

Sep 26 19:43:17 bang MainThread:dbusbackend.py@298 Connect to
B0:B4:48:B9:77:03
Sep 26 19:43:17 bang bluetoothd[22254]:
src/device.c:device_set_auto_connect() B0:B4:48:B9:77:03 auto connect: 1
Sep 26 19:43:17 bang bluetoothd[22254]: src/device.c:device_connect_le()
Connection attempt to: B0:B4:48:B9:77:03
Sep 26 19:43:17 bang bluetoothd[22254]:
src/adapter.c:add_device_complete() B0:B4:48:B9:77:03 (1) added to
kernel connect list
Sep 26 19:43:17 bang bluetoothd[22254]: src/device.c:gatt_debug() MTU
exchange complete, with MTU: 23
Sep 26 19:43:18 bang bluetoothd[22254]:
src/adapter.c:connected_callback() hci0 device B0:B4:48:B9:77:03
connected eir_len 0
Sep 26 19:43:18 bang kernel: [21277.597432] Bluetooth: SMP security
requested but not available
Sep 26 19:43:18 bang bluetoothd[22254]: attrib/gattrib.c:g_attrib_ref()
0x80f0f148: g_attrib_ref=1
Sep 26 19:43:18 bang bluetoothd[22254]: src/device.c:attio_connected()
Sep 26 19:43:18 bang bluetoothd[22254]: attrib/gattrib.c:g_attrib_ref()
0x80f0f148: g_attrib_ref=2
Sep 26 19:43:18 bang bluetoothd[22254]: attrib/gattrib.c:g_attrib_ref()
0x80f0f148: g_attrib_ref=3
Sep 26 19:43:18 bang bluetoothd[22254]: src/device.c:gatt_debug() MTU
exchange complete, with MTU: 23

Sep 26 19:43:18 bang Thread-4:base.py@114 Job "Heating.get_temperature
(trigger: cron[second='0'], next run at: 2015-09-26 19:44:00 BST)"
raised an exception: DBusException: org.bluez.Error.Failed: Not connected

Sep 26 19:43:18 bang bluetoothd[22254]: attrib/gattrib.c:g_attrib_ref()
0x80edbed8: g_attrib_ref=4
Sep 26 19:43:18 bang bluetoothd[22254]:
attrib/gattrib.c:g_attrib_unref() 0x80edbed8: g_attrib_unref=3
Sep 26 19:43:18 bang bluetoothd[22254]:
attrib/gattrib.c:g_attrib_unref() 0x80edbed8: g_attrib_unref=2
Sep 26 19:43:19 bang bluetoothd[22254]: attrib/gattrib.c:g_attrib_ref()
0x80f0f148: g_attrib_ref=4
Sep 26 19:43:19 bang bluetoothd[22254]:
attrib/gattrib.c:g_attrib_unref() 0x80f0f148: g_attrib_unref=3
Sep 26 19:43:19 bang bluetoothd[22254]:
attrib/gattrib.c:g_attrib_unref() 0x80f0f148: g_attrib_unref=2
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug()
Primary services found: 13
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x0001, end: 0x0007, uuid: 00001800-0000-1000-8000-00805f9b34fb
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x0008, end: 0x000b, uuid: 00001801-0000-1000-8000-00805f9b34fb
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x000c, end: 0x001e, uuid: 0000180a-0000-1000-8000-00805f9b34fb
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x001f, end: 0x0026, uuid: f000aa00-0451-4000-b000-000000000000
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x0027, end: 0x002e, uuid: f000aa20-0451-4000-b000-000000000000
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x002f, end: 0x0036, uuid: f000aa40-0451-4000-b000-000000000000
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x0037, end: 0x003e, uuid: f000aa80-0451-4000-b000-000000000000
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x003f, end: 0x0046, uuid: f000aa70-0451-4000-b000-000000000000
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x0047, end: 0x004b, uuid: 0000ffe0-0000-1000-8000-00805f9b34fb
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x004c, end: 0x0050, uuid: f000aa64-0451-4000-b000-000000000000
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x0051, end: 0x0058, uuid: f000ac00-0451-4000-b000-000000000000
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x0059, end: 0x0060, uuid: f000ccc0-0451-4000-b000-000000000000
Sep 26 19:43:19 bang bluetoothd[22254]: src/device.c:gatt_debug() start:
0x0061, end: 0xffff, uuid: f000ffc0-0451-4000-b000-000000000000
Sep 26 19:43:19 bang bluetoothd[22254]:
src/device.c:gatt_client_ready_cb() status: success, error: 0
Sep 26 19:43:19 bang bluetoothd[22254]:
src/device.c:device_svc_resolved() /org/bluez/hci0/dev_B0_B4_48_BA_47_03
err 0
Sep 26 19:43:19 bang bluetoothd[22254]:
profiles/gap/gas.c:gap_driver_accept() GAP profile accept
(B0:B4:48:BA:47:03)
Sep 26 19:43:19 bang bluetoothd[22254]:
profiles/gap/gas.c:handle_characteristic() Unsupported characteristic:
00002a04-0000-1000-8000-00805f9b34fb
Sep 26 19:43:19 bang bluetoothd[22254]:
src/gatt-client.c:btd_gatt_client_ready() GATT client ready
Sep 26 19:43:20 bang bluetoothd[22254]: src/device.c:gatt_debug()
Registered handler for "Service Changed": 1
Sep 26 19:43:20 bang bluetoothd[22254]:
profiles/gap/gas.c:read_device_name_cb() GAP Device Name: SensorTag 2.0
Sep 26 19:43:20 bang bluetoothd[22254]:
src/device.c:btd_device_device_set_name()
/org/bluez/hci0/dev_B0_B4_48_BA_47_03 SensorTag 2.0
Sep 26 19:43:20 bang bluetoothd[22254]:
profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0000

And after this point if my code calls WriteValue again it completes
successfully.

Note: I have two of the same device so if there are duplicate lines that
would explain why. The same thing happens with both devices.

Any help would be gratefully received.

Thanks
Steven Davies
