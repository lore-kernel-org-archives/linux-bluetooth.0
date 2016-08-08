Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Kropf Johannes <Johannes.Kropf@ait.ac.at>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: 5.41 - Authentication Failed with kernel 4.2.0
Date: Mon, 8 Aug 2016 09:31:41 +0000
Message-ID: <E92610C73D6DE84EB154DC52F5ECCE541D74740E@S0MSMAIL111.arc.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

we had a problem when attempting to pair low energy devices on Ubuntu with kernel version 4.2.0-42-generic:
After scanning there always occured an "authentication failed" error. 
The devices we tried to pair were a A&D UC-352-BLE weighing scale and a A&D UA-651BLE blood pressure monitor. 
Both devices can be paired on the same machine with the same setup but with kernel version 3.13.0.92. 
Unfortunately the log doesn't give me an idea what the problem is.
 
Here is the output using bluetoothctl:
[bluetooth]# pair 5C:31:3E:5E:54:5E 
Attempting to pair with 5C:31:3E:5E:54:5E
[CHG] Device 5C:31:3E:5E:54:5E Connected: yes
Failed to pair: org.bluez.Error.AuthenticationFailed
[CHG] Device 5C:31:3E:5E:54:5E Connected: no

Bluetoothd debug messages:
bluetoothd[2386]: src/device.c:bonding_request_new() Requesting bonding for 5C:31:3E:5E:54:5E
bluetoothd[2386]: src/adapter.c:suspend_discovery() 
bluetoothd[2386]: src/adapter.c:adapter_bonding_attempt() hci0 bdaddr 5C:31:3E:5E:54:5E type 1 io_cap 0x03
bluetoothd[2386]: src/adapter.c:connected_callback() hci0 device 5C:31:3E:5E:54:5E connected eir_len 0
bluetoothd[2386]: src/gatt-database.c:connect_cb() New incoming LE ATT connection
bluetoothd[2386]: attrib/gattrib.c:g_attrib_ref() 0x1232f40: g_attrib_ref=1 
bluetoothd[2386]: src/gatt-client.c:btd_gatt_client_connected() Device connected.
bluetoothd[2386]: src/device.c:load_gatt_db() Restoring 5C:31:3E:5E:54:5E gatt database from file
bluetoothd[2386]: src/device.c:load_service() loading service: 0x0001, end: 0x000b, uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_service() loading service: 0x000c, end: 0x000f, uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_service() loading service: 0x0010, end: 0x0017, uuid: 0000181d-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_service() loading service: 0x0018, end: 0x0028, uuid: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_service() loading service: 0x0029, end: 0x002b, uuid: 0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_service() loading service: 0x002c, end: 0xffff, uuid: 233bf000-5a34-1b6d-975c-000d5690abe4
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0002, value handle: 0x0003, properties 0x0002 uuid: 00002a00-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0004, value handle: 0x0005, properties 0x0002 uuid: 00002a01-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0006, value handle: 0x0007, properties 0x000a uuid: 00002a02-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0008, value handle: 0x0009, properties 0x0008 uuid: 00002a03-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x000a, value handle: 0x000b, properties 0x0002 uuid: 00002a04-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x000d, value handle: 0x000e, properties 0x0020 uuid: 00002a05-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_desc() loading descriptor handle: 0x000f, value: 0x0000, uuid: 00002902-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0011, value handle: 0x0012, properties 0x0020 uuid: 00002a9d-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_desc() loading descriptor handle: 0x0013, value: 0x0000, uuid: 00002902-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0014, value handle: 0x0015, properties 0x0002 uuid: 00002a9e-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0016, value handle: 0x0017, properties 0x000a uuid: 00002a08-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0019, value handle: 0x001a, properties 0x0002 uuid: 00002a29-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x001b, value handle: 0x001c, properties 0x0002 uuid: 00002a24-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x001d, value handle: 0x001e, properties 0x0002 uuid: 00002a25-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x001f, value handle: 0x0020, properties 0x0002 uuid: 00002a27-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0021, value handle: 0x0022, properties 0x0002 uuid: 00002a26-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0023, value handle: 0x0024, properties 0x0002 uuid: 00002a28-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0025, value handle: 0x0026, properties 0x0002 uuid: 00002a23-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x0027, value handle: 0x0028, properties 0x0002 uuid: 00002a2a-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x002a, value handle: 0x002b, properties 0x0002 uuid: 00002a19-0000-1000-8000-00805f9b34fb
bluetoothd[2386]: src/device.c:load_chrc() loading characteristic handle: 0x002d, value handle: 0x002e, properties 0x000a uuid: 233bf001-5a34-1b6d-975c-000d5690abe4
bluetoothd[2386]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
bluetoothd[2386]: src/adapter.c:pair_device_complete() Authentication Failed (0x05)
bluetoothd[2386]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 5C:31:3E:5E:54:5E type 1 status 0x5
bluetoothd[2386]: src/device.c:device_bonding_complete() bonding 0x12344d0 status 0x05
bluetoothd[2386]: src/device.c:device_bonding_failed() status 5
bluetoothd[2386]: src/adapter.c:resume_discovery() 
bluetoothd[2386]: src/adapter.c:dev_disconnected() Device 5C:31:3E:5E:54:5E disconnected, reason 2
bluetoothd[2386]: src/adapter.c:adapter_remove_connection() 
bluetoothd[2386]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[2386]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 5C:31:3E:5E:54:5E type 1 status 0xe
bluetoothd[2386]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[2386]: src/device.c:device_bonding_failed() status 14

Kind regards,
Johannes












