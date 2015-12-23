Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAG=SMqZaBR-8HGsYmy3p_02vJhjnhcTu2sUBc5BqyqBEbt2Jag@mail.gmail.com>
References: <CAG=SMqZaBR-8HGsYmy3p_02vJhjnhcTu2sUBc5BqyqBEbt2Jag@mail.gmail.com>
Date: Wed, 23 Dec 2015 23:49:02 +0100
Message-ID: <CAG=SMqbo6mOOFjEjn_Kh9eFaUYH7f+xYLx3XP35j9Bw5JSCotA@mail.gmail.com>
Subject: Fwd: BLE GATT connection problem
From: Fabian Bergmark <fabian.bergmark@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I use the glib D-Bus interface to connect to a BLE button. This works
great some times but I regularly get this connection error:
GDBus.Error:org.bluez.Error.Failed: Software caused connection abort,
36

 The debug output in bluetoothd is:

bluetoothd[17071]: src/device.c:device_set_auto_connect()
80:E4:DA:70:07:A7 auto connect: 1
bluetoothd[17071]: src/device.c:device_connect_le() Connection attempt
to: 80:E4:DA:70:07:A7
bluetoothd[17071]: src/adapter.c:add_device_complete()
80:E4:DA:70:07:A7 (1) added to kernel connect list
bluetoothd[17071]: src/adapter.c:connected_callback() hci0 device
80:E4:DA:70:07:A7 connected eir_len 0
bluetoothd[17071]: src/gatt-client.c:notify_client_ref() owner :1.2517
bluetoothd[17071]: src/gatt-client.c:notify_client_ref() owner :1.2517
bluetoothd[17071]: src/device.c:att_connect_cb() connect error:
Function not implemented (38)
bluetoothd[17071]: src/device.c:att_error_cb() Enabling automatic connections
bluetoothd[17071]: src/adapter.c:dev_disconnected() Device
80:E4:DA:70:07:A7 disconnected, reason 0
bluetoothd[17071]: src/adapter.c:adapter_remove_connection()
bluetoothd[17071]: plugins/policy.c:disconnect_cb() reason 0
bluetoothd[17071]: src/adapter.c:bonding_attempt_complete() hci0
bdaddr 80:E4:DA:70:07:A7 type 1 status 0xe
bluetoothd[17071]: src/device.c:device_bonding_complete() bonding
(nil) status 0x0e
bluetoothd[17071]: src/device.c:device_bonding_failed() status 14
bluetoothd[17071]: src/adapter.c:resume_discovery()


What worries me is the connect error: Function not implemented (38) line.

I'm on commit 1b9e48f4c2b98ea88e43bd493c098dcca822a1d0

Is this a potential bluez bug?

When I manage to connect to a button, the output is as follows:

bluetoothd[17071]: src/device.c:device_connect_le() Connection attempt
to: 80:E4:DA:70:08:9E
bluetoothd[17071]: src/adapter.c:connected_callback() hci0 device
80:E4:DA:70:08:9E connected eir_len 0
bluetoothd[17071]: attrib/gattrib.c:g_attrib_ref() 0x23f9640: g_attrib_ref=1
bluetoothd[17071]: src/service.c:change_state() 0x240e2f0: device
80:E4:DA:70:08:9E profile Proximity Reporter GATT Driver state
changed: disconnected -> connecting (0)
bluetoothd[17071]: profiles/gap/gas.c:gap_driver_accept() GAP profile
accept (80:E4:DA:70:08:9E)
bluetoothd[17071]: src/service.c:change_state() 0x240e350: device
80:E4:DA:70:08:9E profile gap-profile state changed: disconnected ->
connecting (0)
bluetoothd[17071]: src/service.c:change_state() 0x23fd080: device
80:E4:DA:70:08:9E profile
:1.2517/org/flic/F4_B7_E2_F6_D2_DD/f02adfc0-26e7-11e4-9edc-0002a5d5c51b
state changed: disconnected -> connecting (0)
bluetoothd[17071]: src/gatt-client.c:btd_gatt_client_connected()
Device connected.
bluetoothd[17071]: src/device.c:load_gatt_db() Restoring
80:E4:DA:70:08:9E gatt database from file
bluetoothd[17071]: src/device.c:load_service() loading service:
0x0001, end: 0x0009, uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:load_service() loading service:
0x000c, end: 0x000f, uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:load_service() loading service:
0x0010, end: 0x0016, uuid: f02adfc0-26e7-11e4-9edc-0002a5d5c51b
bluetoothd[17071]: src/device.c:load_chrc() loading characteristic
handle: 0x0002, value handle: 0x0003, properties 0x0002 uuid:
00002a00-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:load_chrc() loading characteristic
handle: 0x0004, value handle: 0x0005, properties 0x0002 uuid:
00002a01-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:load_chrc() loading characteristic
handle: 0x0006, value handle: 0x0007, properties 0x000a uuid:
00002a02-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:load_chrc() loading characteristic
handle: 0x0008, value handle: 0x0009, properties 0x0002 uuid:
00002a04-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:load_chrc() loading characteristic
handle: 0x000d, value handle: 0x000e, properties 0x0022 uuid:
00002a05-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:load_desc() loading descriptor handle:
0x000f, uuid: 00002902-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:load_chrc() loading characteristic
handle: 0x0011, value handle: 0x0012, properties 0x001a uuid:
cc7efce0-26e8-11e4-8fd2-0002a5d5c51b
bluetoothd[17071]: src/device.c:load_desc() loading descriptor handle:
0x0013, uuid: 00002902-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:load_chrc() loading characteristic
handle: 0x0014, value handle: 0x0015, properties 0x0012 uuid:
06053ec0-26e9-11e4-adc2-0002a5d5c51b
bluetoothd[17071]: src/device.c:load_desc() loading descriptor handle:
0x0016, uuid: 00002902-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
bluetoothd[17071]: src/device.c:gatt_debug() Primary services found: 3
bluetoothd[17071]: src/device.c:gatt_debug() start: 0x0001, end:
0x0009, uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:gatt_debug() start: 0x000c, end:
0x000f, uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[17071]: src/device.c:gatt_debug() start: 0x0010, end:
0x0016, uuid: f02adfc0-26e7-11e4-9edc-0002a5d5c51b
bluetoothd[17071]: src/device.c:gatt_client_ready_cb() status:
success, error: 10
bluetoothd[17071]: src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_80_E4_DA_70_08_9E err 0
bluetoothd[17071]: src/gatt-client.c:btd_gatt_client_ready() GATT client ready
bluetoothd[17071]: src/gatt-client.c:create_services() Exporting
objects for GATT services: 80:E4:DA:70:08:9E
bluetoothd[17071]: src/gatt-client.c:service_create() Exported GATT
service: /org/bluez/hci0/dev_80_E4_DA_70_08_9E/service0010
bluetoothd[17071]: src/gatt-client.c:characteristic_create() Exported
GATT characteristic:
/org/bluez/hci0/dev_80_E4_DA_70_08_9E/service0010/char0011
bluetoothd[17071]: src/gatt-client.c:descriptor_create() Exported GATT
characteristic descriptor:
/org/bluez/hci0/dev_80_E4_DA_70_08_9E/service0010/char0011/desc0013
bluetoothd[17071]: src/gatt-client.c:characteristic_create() Exported
GATT characteristic:
/org/bluez/hci0/dev_80_E4_DA_70_08_9E/service0010/char0014
bluetoothd[17071]: src/gatt-client.c:descriptor_create() Exported GATT
characteristic descriptor:
/org/bluez/hci0/dev_80_E4_DA_70_08_9E/service0010/char0014/desc0016
bluetoothd[17071]: src/gatt-client.c:notify_client_ref() owner :1.2517
bluetoothd[17071]: src/gatt-client.c:notify_client_ref() owner :1.2517
bluetoothd[17071]: src/device.c:gatt_debug() Registered handler for
"Service Changed": 1
bluetoothd[17071]: src/adapter.c:new_conn_param() hci0
80:E4:DA:70:08:9E (1) min 0x00e0 max 0x00f0 latency 0x0004 timeout
0x01f4
bluetoothd[17071]: src/adapter.c:store_conn_param()
