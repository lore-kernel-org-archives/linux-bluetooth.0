Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1447165261.25253.16.camel@cortland.com>
Subject: Dual-mode peripheral with both classic profiles and GATT services
From: Steve Brown <sbrown@cortland.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 10 Nov 2015 09:21:01 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a device that supports A2DP, HFP and HSP, but also uses LE GATT
services for controlling an equalizer and other functions. The device
is a Sound World HD-100 hearing aid.

After pairing, the device->services list contains both the classic and
LE services. But when device_accept_gatt_profiles iterates over these
services, btd_profile.accept is null for the classic profiles so no
action is taken.

Is this the intended behavior? If so, are there plans to be able to
connect to both classic and GATT services on the same device in the
future?

Thanks,

Steve

Nov 10 04:18:30 w7 bluetoothd[2968]: src/adapter.c:connect_failed_callback() hci0 F4:73:CA:00:38:EB status 2
Nov 10 04:18:30 w7 bluetoothd[2968]: plugins/policy.c:conn_fail_cb() status 2
Nov 10 04:18:30 w7 bluetoothd[2968]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr F4:73:CA:00:38:EB type 1 status 0x2
Nov 10 04:18:30 w7 bluetoothd[2968]: src/device.c:device_bonding_complete() bonding (nil) status 0x02
Nov 10 04:18:30 w7 bluetoothd[2968]: src/device.c:device_bonding_failed() status 2
Nov 10 04:18:30 w7 bluetoothd[2968]: src/adapter.c:resume_discovery()
Nov 10 04:18:33 w7 bluetoothd[2968]: src/adapter.c:connected_callback() hci0 device F4:73:CA:00:38:EB connected eir_len 28
Nov 10 04:18:33 w7 pulseaudio[5638]: [pulseaudio] bluez5-util.c: Properties changed in device /org/bluez/hci0/dev_F4_73_CA_00_38_EB
Nov 10 04:18:33 w7 bluetoothd[2968]: src/gatt-database.c:connect_cb() New incoming LE ATT connection
Nov 10 04:18:34 w7 kernel: [13580.150475] NET: Registered protocol family 38
Nov 10 04:18:34 w7 bluetoothd[2968]: attrib/gattrib.c:g_attrib_ref() 0x1ec8720: g_attrib_ref=1
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_gatt_db() Restoring F4:73:CA:00:38:EB gatt database from file
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_service() loading service: 0x0001, end: 0x0001, uuid: 00001801-0000-1000-8000-00805f9b34fb
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_service() loading service: 0x0002, end: 0x0006, uuid: 00001800-0000-1000-8000-00805f9b34fb
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_service() loading service: 0x0007, end: 0xffff, uuid: 22b40208-a947-44b5-90cb-b1f23992914c
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0003, value handle: 0x0004, properties 0x001e uuid: 00002a00-0000-1000-8000-00805f9b34fb
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0005, value handle: 0x0006, properties 0x0012 uuid: 00002a01-0000-1000-8000-00805f9b34fb
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0008, value handle: 0x0009, properties 0x0032 uuid: 79e85d91-29e8-4212-b1cf-e767e0e8b972
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x000a, value handle: 0x000b, properties 0x003e uuid: 6ce9115d-7c60-4d60-b37f-f5e00057cb29
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x000c, value handle: 0x000d, properties 0x003e uuid: 3a94a850-3bd4-48fb-b18b-a69fa042b087
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x000e, value handle: 0x000f, properties 0x003e uuid: 975ff10e-8dc5-4d1a-bc85-145f3f5f7f23
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0010, value handle: 0x0011, properties 0x003e uuid: 7eab3cd9-b471-4a46-8f73-9da458b4ec45
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0012, value handle: 0x0013, properties 0x003e uuid: 7b48855b-4938-498c-b214-3a4be8432c3e
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0014, value handle: 0x0015, properties 0x003e uuid: 5a3c06e3-f3d3-4dfd-ac9e-e385630cfac3
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0016, value handle: 0x0017, properties 0x003e uuid: 85bf2e4d-6cbc-401f-ab13-610cc5f6ee3f
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0018, value handle: 0x0019, properties 0x003e uuid: f3f0a39e-5ecd-4547-868e-6738dbe39c13
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x001a, value handle: 0x001b, properties 0x003e uuid: f0cc4c32-8815-4942-8dd0-7f832d783c36
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x001c, value handle: 0x001d, properties 0x003e uuid: aba448f6-440a-4c14-9a1a-bc25946efc99
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x001e, value handle: 0x001f, properties 0x000c uuid: 74f99c47-398e-4073-b063-295ed73a0e52
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0020, value handle: 0x0021, properties 0x000e uuid: b7bb8646-4a6b-43a2-b449-8da79d585f9d
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0022, value handle: 0x0023, properties 0x0002 uuid: 2a2dec8b-5e69-4760-ba40-06ed1fb1d411
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0024, value handle: 0x0025, properties 0x003e uuid: 4b4ea01e-37f3-4895-bd4f-06b7bf387809
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0026, value handle: 0x0027, properties 0x0002 uuid: ec74560e-e7b1-422e-b8f5-fb2b38b821ee
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0028, value handle: 0x0029, properties 0x0002 uuid: 39ec9553-788a-4e4d-9e18-0df256896634
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x002a, value handle: 0x002b, properties 0x000c uuid: b7353db0-a6bd-4d2f-912a-57dced65e73b
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x002c, value handle: 0x002d, properties 0x000c uuid: aa3d29e6-9475-4189-9c9b-83beadc04d9e
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x002e, value handle: 0x002f, properties 0x000c uuid: 7c1e61f5-2c98-4b31-a249-f237bdd0f2f3
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0030, value handle: 0x0031, properties 0x000c uuid: d787bf1c-dc38-4d3b-b8b5-e7c94cd48cc9
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0032, value handle: 0x0033, properties 0x000c uuid: f375bac5-f983-46e2-821b-d01e0e69b9e7
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0034, value handle: 0x0035, properties 0x000e uuid: 1fa4c98f-44e7-414a-b2ef-7733e2ac7d1c
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0036, value handle: 0x0037, properties 0x000c uuid: a6d5fc7a-1864-4d20-9ec9-54fde7f5ba4c
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:load_chrc() loading characteristic handle: 0x0038, value handle: 0x0039, properties 0x000e uuid: e11e146c-4f9d-40db-8620-061a38eca3c7
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:device_accept_gatt_profiles()
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:service_accept() accept:(nil)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:change_state() 0x1edeb10: device F4:73:CA:00:38:EB profile Proximity Reporter GATT Driver uuid (null)/00001801 state changed: disconnected -> connecting (0)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:service_accept() accept:0x43d2d0
Nov 10 04:18:34 w7 bluetoothd[2968]: profiles/gap/gas.c:gap_driver_accept() GAP profile accept (F4:73:CA:00:38:EB)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:change_state() 0x1edc4d0: device F4:73:CA:00:38:EB profile gap-profile uuid (null)/00001800 state changed: disconnected -> connecting (0)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:service_accept() accept:(nil)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:change_state() 0x1edc460: device F4:73:CA:00:38:EB profile avrcp-controller uuid (null)/0000110e state changed: disconnected -> connecting (0)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:service_accept() accept:(nil)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:change_state() 0x1eddf30: device F4:73:CA:00:38:EB profile audio-avrcp-target uuid (null)/0000110c state changed: disconnected -> connecting (0)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:service_accept() accept:(nil)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:change_state() 0x1eddf60: device F4:73:CA:00:38:EB profile a2dp-sink uuid (null)/0000110b state changed: disconnected -> connecting (0)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:service_accept() accept:(nil)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:change_state() 0x1ed7700: device F4:73:CA:00:38:EB profile Headset Voice gateway uuid 00001112/00001108 state changed: disconnected -> connecting (0)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/gatt-client.c:btd_gatt_client_connected() Device connected.
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
Nov 10 04:18:34 w7 bluetoothd[2968]: profiles/gap/gas.c:read_device_name_cb() GAP Device Name: HD100-5201626
Nov 10 04:18:34 w7 bluetoothd[2968]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0000
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:gatt_debug() Primary services found: 3
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:gatt_debug() start: 0x0001, end: 0x0001, uuid: 00001801-0000-1000-8000-00805f9b34fb
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:gatt_debug() start: 0x0002, end: 0x0006, uuid: 00001800-0000-1000-8000-00805f9b34fb
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:gatt_debug() start: 0x0007, end: 0xffff, uuid: 22b40208-a947-44b5-90cb-b1f23992914c
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:gatt_client_ready_cb() status: success, error: 0
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:add_gatt_service()
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:service_accept() accept:(nil)
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:add_gatt_service()
Nov 10 04:18:34 w7 bluetoothd[2968]: src/service.c:service_accept() accept:0x43d2d0
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:add_gatt_service()
Nov 10 04:18:34 w7 bluetoothd[2968]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_F4_73_CA_00_38_EB err 0
Nov 10 04:18:34 w7 bluetoothd[2968]: src/gatt-client.c:btd_gatt_client_ready() GATT client ready


