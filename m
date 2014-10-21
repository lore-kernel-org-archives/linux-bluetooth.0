Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Sujay Sarkhel <ssarkhe@ncsu.edu>
Date: Tue, 21 Oct 2014 15:32:55 -0700
Message-ID: <CAE7yNv91jsatURxRhzLFOHDjA0gvFqTj2xSBqJftEO19UF2tjA@mail.gmail.com>
Subject: Re: BlueZ 5.24: Using the LE Heart Rate Profile
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some more information:

I ran the daemon in foreground with debugging:
  /usr/libexec/bluetooth/bluetoothd -n -d

Subsequently, when I execute ./test-device connect
<bluetooth_address>, I see the following debug information:

bluetoothd[11844]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[11844]: src/device.c:device_connect_le() Connection attempt
to: FC:7A:62:1F:F9:F6
bluetoothd[11844]: src/adapter.c:connected_callback() hci0 device
FC:7A:62:1F:F9:F6 connected eir_len 0
bluetoothd[11844]: attrib/gattrib.c:g_attrib_ref() 0x334c88: ref=1
bluetoothd[11844]: Device object not found for attrib server
bluetoothd[11844]: attrib/gattrib.c:g_attrib_unref() 0x334c88: ref=0
bluetoothd[11844]: Attribute server attach failure!
bluetoothd[11844]: src/adapter.c:dev_disconnected() Device
FC:7A:62:1F:F9:F6 disconnected, reason 2
bluetoothd[11844]: src/adapter.c:adapter_remove_connection()
bluetoothd[11844]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[11844]: src/adapter.c:bonding_attempt_complete() hci0
bdaddr FC:7A:62:1F:F9:F6 type 2 status 0xe
bluetoothd[11844]: src/device.c:device_bonding_complete() bonding
(nil) status 0x0e
bluetoothd[11844]: src/device.c:device_bonding_failed() status 14

I got it to work on an Ubuntu 14.04 VM, running on a x86 system & the
corresponding log looks as follows:

bluetoothd[3519]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[3519]: src/device.c:device_connect_le() Connection attempt
to: FC:7A:62:1F:F9:F6
bluetoothd[3519]: src/adapter.c:connected_callback() hci0 device
FC:7A:62:1F:F9:F6 connected eir_len 0
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=1
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=2
bluetoothd[3519]: src/adapter.c:adapter_connect_list_remove() device
/org/bluez/hci0/dev_FC_7A_62_1F_F9_F6 is not on the list, ignoring
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=3
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=3
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=3
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=3
bluetoothd[3519]: src/device.c:primary_cb() status 0
bluetoothd[3519]: src/device.c:find_included_services() service count 5
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=5
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=3
bluetoothd[3519]: src/device.c:find_included_cb() status 0
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=5
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=3
bluetoothd[3519]: src/device.c:find_included_cb() status 0
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=5
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=3
bluetoothd[3519]: src/device.c:find_included_cb() status 0
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=5
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=3
bluetoothd[3519]: src/device.c:find_included_cb() status 0
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=5
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=3
bluetoothd[3519]: src/device.c:find_included_cb() status 0
bluetoothd[3519]: src/device.c:update_gatt_services() UUID Added:
00001800-0000-1000-8000-00805f9b34fb
bluetoothd[3519]: src/device.c:update_gatt_services() UUID Added:
00001801-0000-1000-8000-00805f9b34fb
bluetoothd[3519]: src/device.c:update_gatt_services() UUID Added:
6c721826-5bf1-4f64-9170-381c08ec57ee
bluetoothd[3519]: src/device.c:update_gatt_services() UUID Added:
0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[3519]: src/device.c:update_gatt_services() UUID Added:
0000180d-0000-1000-8000-00805f9b34fb
bluetoothd[3519]: src/device.c:device_probe_profiles() Probing
profiles for device FC:7A:62:1F:F9:F6
bluetoothd[3519]: src/device.c:btd_device_add_attio_callback()
0x82038b8 registered ATT connection callback
bluetoothd[3519]: src/device.c:device_set_auto_connect()
FC:7A:62:1F:F9:F6 auto connect: 1
bluetoothd[3519]: src/device.c:device_set_auto_connect() Already connected
bluetoothd[3519]: src/service.c:change_state() 0x8205cf8: device
FC:7A:62:1F:F9:F6 profile Heart Rate GATT Driver state changed:
unavailable -> disconnected (0)
bluetoothd[3519]:
profiles/proximity/reporter.c:register_reporter_device() register on
device /org/bluez/hci0/dev_FC_7A_62_1F_F9_F6
bluetoothd[3519]: src/service.c:change_state() 0x8207960: device
FC:7A:62:1F:F9:F6 profile Proximity Reporter GATT Driver state
changed: unavailable -> disconnected (0)
bluetoothd[3519]: src/device.c:btd_device_add_attio_callback()
0x82038b8 registered ATT connection callback
bluetoothd[3519]: src/device.c:device_set_auto_connect()
FC:7A:62:1F:F9:F6 auto connect: 1
bluetoothd[3519]: src/service.c:change_state() 0x82079e0: device
FC:7A:62:1F:F9:F6 profile deviceinfo state changed: unavailable ->
disconnected (0)
bluetoothd[3519]: src/device.c:btd_device_add_attio_callback()
0x82038b8 registered ATT connection callback
bluetoothd[3519]: src/device.c:device_set_auto_connect()
FC:7A:62:1F:F9:F6 auto connect: 1
bluetoothd[3519]: src/service.c:change_state() 0x8200348: device
FC:7A:62:1F:F9:F6 profile gap-gatt-profile state changed: unavailable
-> disconnected (0)
bluetoothd[3519]: src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_FC_7A_62_1F_F9_F6 err 0
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=2
bluetoothd[3519]: src/device.c:notify_attios()
bluetoothd[3519]: src/device.c:attio_connected()
bluetoothd[3519]: profiles/heartrate/heartrate.c:attio_connected_cb()
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=3
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=4
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=5
bluetoothd[3519]: src/device.c:attio_connected()
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=6
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=7
bluetoothd[3519]: src/device.c:attio_connected()
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=8
bluetoothd[3519]: profiles/gatt/gas.c:attio_connected_cb() MTU
Exchange: Requesting 672
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=9
bluetoothd[3519]: src/device.c:notify_attios()
bluetoothd[3519]: src/device.c:notify_attios()
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=8
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=9
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=8
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=9
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=8
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=9
bluetoothd[3519]: profiles/gatt/gas.c:exchange_mtu_cb() MTU exchange
succeeded: 23
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=8
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=9
bluetoothd[3519]: profiles/gatt/gas.c:gap_appearance_cb() GAP Appearance: 0x0340
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=8
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=9
bluetoothd[3519]: Discover Service Changed handle: No attribute found
within the given range
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=8
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=7
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=8
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=9
bluetoothd[3519]: profiles/heartrate/heartrate.c:discover_char_cb()
Body Sensor Location supported
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=8
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=7
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=8
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=7
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=8
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=7
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=6
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=7
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=6
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=7
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=6
bluetoothd[3519]: attrib/gattrib.c:g_attrib_ref() 0x8203360: ref=7
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=6
bluetoothd[3519]: attrib/gattrib.c:g_attrib_unref() 0x8203360: ref=5
bluetoothd[3519]: src/device.c:device_set_auto_connect()
FC:7A:62:1F:F9:F6 auto connect: 0
bluetoothd[3519]: src/adapter.c:adapter_connect_list_remove() device
/org/bluez/hci0/dev_FC_7A_62_1F_F9_F6 is not on the list, ignoring
bluetoothd[3519]: src/adapter.c:dev_disconnected() Device
FC:7A:62:1F:F9:F6 disconnected, reason 2
bluetoothd[3519]: src/adapter.c:adapter_remove_connection()
bluetoothd[3519]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[3519]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
FC:7A:62:1F:F9:F6 type 2 status 0xe
bluetoothd[3519]: src/device.c:device_bonding_complete() bonding (nil)
status 0x0e
bluetoothd[3519]: src/device.c:device_bonding_failed() status 14

Any idea as to why it's working on an x86 machine and not on the ARM
board? As far as I can tell, I've been following the same installation
procedure on both these systems
