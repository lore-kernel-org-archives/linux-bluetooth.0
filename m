Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Dec 2015 21:46:04 +0100
Message-ID: <CAG=SMqaQik3OAVKHsto5oSBkpX-vNft-X61HBuLKP00502k=bA@mail.gmail.com>
Subject: bluetoothd aborted
From: Fabian Bergmark <fabian.bergmark@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I (rarely) get segfaults or aborts while running bluetoothd with the
-nEd command line arguments. I'm running commit 1b9e48f4c2b98e

If I can provide more useful information let me know. Here are the last lines:

bluetoothd[3623]: src/gatt-client.c:btd_gatt_client_ready() GATT client ready
bluetoothd[3623]: src/gatt-client.c:create_services() Exporting
objects for GATT services: 80:E4:DA:70:08:9E
bluetoothd[3623]: src/adapter.c:new_conn_param() hci0
80:E4:DA:70:08:9E (1) min 0x0012 max 0x0024 latency 0x0004 timeout
0x0064
bluetoothd[3623]: src/adapter.c:store_conn_param()
bluetoothd[3623]: src/device.c:gatt_debug() Registered handler for
"Service Changed": 3
bluetoothd[3623]: src/adapter.c:dev_disconnected() Device
80:E4:DA:70:08:9E disconnected, reason 1
bluetoothd[3623]: src/adapter.c:adapter_remove_connection()
bluetoothd[3623]: plugins/policy.c:disconnect_cb() reason 1
bluetoothd[3623]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
80:E4:DA:70:08:9E type 1 status 0xe
bluetoothd[3623]: src/device.c:device_bonding_complete() bonding (nil)
status 0x0e
bluetoothd[3623]: src/device.c:device_bonding_failed() status 14
bluetoothd[3623]: src/adapter.c:resume_discovery()
bluetoothd[3623]: src/device.c:att_disconnected_cb()
bluetoothd[3623]: src/device.c:att_disconnected_cb() Connection timed out (110)
bluetoothd[3623]: src/gatt-client.c:btd_gatt_client_disconnected()
Device disconnected. Cleaning up.
bluetoothd[3623]: attrib/gattrib.c:g_attrib_unref() 0x1454f30: g_attrib_unref=0
bluetoothd[3623]: src/adapter.c:connected_callback() hci0 device
80:E4:DA:70:08:9E connected eir_len 31
bluetoothd[3623]: src/gatt-client.c:notify_client_unref() owner :1.2735
bluetoothd[3623]: src/gatt-client.c:notify_client_free() owner :1.2735
bluetoothd[3623]: src/gatt-database.c:connect_cb() New incoming LE ATT
connection
bluetoothd[3623]: attrib/gattrib.c:g_attrib_ref() 0x1454f30: g_attrib_ref=1
bluetoothd[3623]: src/gatt-client.c:btd_gatt_client_connected() Device
connected.
bluetoothd[3623]: src/gatt-client.c:register_notify() Re-register
subscribed notification client
bluetoothd: src/shared/gatt-client.c:2962:
bt_gatt_client_unregister_notify: Assertion
`notify_data->chrc->notify_count > 0' failed.
