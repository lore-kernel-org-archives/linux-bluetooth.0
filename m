Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Fwd: BLE connections unsuccessful majority of the time
References: <8e557993-7a03-7dae-1075-6e5e4f271afb@successful.com.au>
To: linux-bluetooth@vger.kernel.org
From: Dushara Jayasinghe <dushara@successful.com.au>
Message-ID: <90df9284-1383-2866-52f9-6093d436abf8@successful.com.au>
Date: Tue, 30 Jan 2018 11:39:33 +1100
MIME-Version: 1.0
In-Reply-To: <8e557993-7a03-7dae-1075-6e5e4f271afb@successful.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI All,

I'm working on an application in an embedded linux (version 4.9.36)
system that advertises itself as a BLE peripheral. I've based my app on
the example-advertisement in the bluez test directory.

I'm using nRF Connect by Nordic to test my app.

The device advertises correctly, however, the host fails to connect with
it most of the time.
I have below logs from bluetoothd and hcidump of unsuccessful as well as
the successful connections:

Unsuccessful connection
-----------------------
bluetoothd[202]: ../bluez-5.41/src/adapter.c:connected_callback() hci0
device EC:39:7E:5F:71:94 connected eir_len 0
bluetoothd[202]: ../bluez-5.41/src/device.c:device_create() dst
EC:39:7E:5F:71:94
bluetoothd[202]: ../bluez-5.41/src/device.c:device_new() address
EC:39:7E:5F:71:94
bluetoothd[202]: ../bluez-5.41/src/device.c:device_new() Creating device
/org/bluez/hci0/dev_EC_39_7E_5F_71_94
bluetoothd[202]: ../bluez-5.41/src/gatt-database.c:connect_cb() New
incoming LE ATT connection
NET: Registered protocol family 38
bluetoothd[202]: ../bluez-5.41/attrib/gattrib.c:g_attrib_ref() 0xe1608:
g_attrib_ref=1
bluetoothd[202]:
../bluez-5.41/src/gatt-client.c:btd_gatt_client_connected() Device
connected.
bluetoothd[202]: ../bluez-5.41/src/device.c:load_gatt_db() Restoring
EC:39:7E:5F:71:94 gatt database from file
bluetoothd[202]: No cache for EC:39:7E:5F:71:94
bluetoothd[202]: ../bluez-5.41/src/adapter.c:dev_disconnected() Device
EC:39:7E:5F:71:94 disconnected, reason 0
bluetoothd[202]: ../bluez-5.41/src/adapter.c:adapter_remove_connection()
bluetoothd[202]: ../bluez-5.41/src/adapter.c:adapter_remove_connection()
Removing temporary device /org/bluez/hci0/dev_EC_39_7E_5F_71_94
bluetoothd[202]: ../bluez-5.41/src/device.c:device_remove() Removing
device /org/bluez/hci0/dev_EC_39_7E_5F_71_94
bluetoothd[202]: ../bluez-5.41/src/device.c:btd_device_unref() Freeing
device /org/bluez/hci0/dev_EC_39_7E_5F_71_94
bluetoothd[202]: ../bluez-5.41/attrib/gattrib.c:g_attrib_unref()
0xe1608: g_attrib_unref=0
bluetoothd[202]: ../bluez-5.41/src/device.c:device_free() 0xe5c68
bluetoothd[202]: ../bluez-5.41/plugins/policy.c:disconnect_cb() reason 0
bluetoothd[202]: ../bluez-5.41/src/adapter.c:bonding_attempt_complete()
hci0 bdaddr EC:39:7E:5F:71:94 type 2 status 0xe
bluetoothd[202]: ../bluez-5.41/src/adapter.c:resume_discovery()


Successful connection
---------------------
bluetoothd[202]: ../bluez-5.41/src/adapter.c:connected_callback() hci0
device EC:39:7E:5F:71:94 connected eir_len 0
bluetoothd[202]: ../bluez-5.41/src/device.c:device_create() dst
EC:39:7E:5F:71:94
bluetoothd[202]: ../bluez-5.41/src/device.c:device_new() address
EC:39:7E:5F:71:94
bluetoothd[202]: ../bluez-5.41/src/device.c:device_new() Creating device
/org/bluez/hci0/dev_EC_39_7E_5F_71_94
bluetoothd[202]: ../bluez-5.41/src/gatt-database.c:connect_cb() New
incoming LE ATT connection
bluetoothd[202]: ../bluez-5.41/attrib/gattrib.c:g_attrib_ref() 0xe9d18:
g_attrib_ref=1
bluetoothd[202]:
../bluez-5.41/src/gatt-client.c:btd_gatt_client_connected() Device
connected.
bluetoothd[202]: ../bluez-5.41/src/device.c:load_gatt_db() Restoring
EC:39:7E:5F:71:94 gatt database from file
bluetoothd[202]: No cache for EC:39:7E:5F:71:94
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() Read By Grp
Type - start: 0x0001 end: 0xffff
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() MTU exchange
complete, with MTU: 23
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() Read By Grp
Type - start: 0x000a end: 0xffff
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() Read By Type -
start: 0x0001 end: 0x0005
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() Primary
services found: 2
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() start: 0x0001,
end: 0x0007, uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() start: 0x0008,
end: 0xffff, uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() Read Req -
handle: 0x0003
bluetoothd[202]:
../bluez-5.41/src/gatt-database.c:gap_device_name_read_cb() GAP Device
Name read request
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() Secondary
service discovery failed. ATT ECODE: 0x0a
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() Read Req -
handle: 0x0005
bluetoothd[202]:
../bluez-5.41/src/gatt-database.c:gap_appearance_read_cb() GAP
Appearance read request
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() Find Info -
start: 0x0004 end: 0x0005
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() Find Info -
start: 0x0006 end: 0x0005
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() Read Req -
handle: 0x0003
bluetoothd[202]:
../bluez-5.41/src/gatt-database.c:gap_device_name_read_cb() GAP Device
Name read request
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() Characteristics
found: 3
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() start: 0x0002,
end: 0x0003, value: 0x0003, props: 0x02, uuid: 00002a00-0000-1
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() start: 0x0004,
end: 0x0005, value: 0x0005, props: 0x02, uuid: 00002a01-0000-1
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_debug() start: 0x0006,
end: 0x0007, value: 0x0007, props: 0x02, uuid: 00002a04-0000-1
bluetoothd[202]: ../bluez-5.41/src/device.c:gatt_client_ready_cb()
status: success, error: 10
bluetoothd[202]: ../bluez-5.41/src/device.c:btd_device_set_temporary()
temporary 0
bluetoothd[202]: ../bluez-5.41/src/device.c:device_probe_profiles()
Probing profiles for device EC:39:7E:5F:71:94
bluetoothd[202]: ../bluez-5.41/profiles/gap/gas.c:gap_driver_probe() GAP
profile probe (EC:39:7E:5F:71:94)
bluetoothd[202]: ../bluez-5.41/src/service.c:change_state() 0xe53d8:
device EC:39:7E:5F:71:94 profile gap-profile state changed: unavailable
-> disconnected (0)
bluetoothd[202]: ../bluez-5.41/profiles/gap/gas.c:gap_driver_accept()
GAP profile accept (EC:39:7E:5F:71:94)
bluetoothd[202]:
../bluez-5.41/profiles/gap/gas.c:handle_characteristic() Unsupported
characteristic: 00002a04-0000-1000-8000-00805f9b34fb
bluetoothd[202]: ../bluez-5.41/src/service.c:change_state() 0xe53d8:
device EC:39:7E:5F:71:94 profile gap-profile state changed: disconnected
-> connecting (0)
bluetoothd[202]: ../bluez-5.41/src/device.c:device_probe_profiles()
Probing profiles for device EC:39:7E:5F:71:94
bluetoothd[202]: ../bluez-5.41/src/gatt-client.c:btd_gatt_client_ready()
GATT client ready
bluetoothd[202]: ../bluez-5.41/src/gatt-client.c:create_services()
Exporting objects for GATT services: EC:39:7E:5F:71:94
bluetoothd[202]: ../bluez-5.41/src/gatt-client.c:service_create()
Exported GATT service: /org/bluez/hci0/dev_EC_39_7E_5F_71_94/service0008
bluetoothd[202]: ../bluez-5.41/src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_EC_39_7E_5F_71_94 err 0
bluetoothd[202]: ../bluez-5.41/profiles/gap/gas.c:read_device_name_cb()
GAP Device Name: nRF5x
bluetoothd[202]: ../bluez-5.41/src/device.c:btd_device_device_set_name()
/org/bluez/hci0/dev_EC_39_7E_5F_71_94 nRF5x
bluetoothd[202]: ../bluez-5.41/profiles/gap/gas.c:read_appearance_cb()
GAP Appearance: 0x0000


Output of hcidump during a failed connection attempt is:

< HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15
     min 1280.000ms, max 1280.000ms
     type 0x00 (ADV_IND - Connectable undirected advertising) ownbdaddr
0x00 (Public)
     directbdaddr 0x00 (Public) 00:00:00:00:00:00
     channelmap 0x07 filterpolicy 0x00 (Allow scan from any, connection
from any)
> HCI Event: Command Complete (0x0e) plen 4
     LE Set Advertising Parameters (0x08|0x0006) ncmd 1
     status 0x00
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
> HCI Event: Command Complete (0x0e) plen 4
     LE Set Advertise Enable (0x08|0x000a) ncmd 1
     status 0x00
> HCI Event: LE Meta Event (0x3e) plen 19
     LE Connection Complete
       status 0x00 handle 128, role slave
       bdaddr EC:39:7E:5F:71:94 (Random)
< ACL data: handle 128 flags 0x00 dlen 16
     L2CAP(d): cid 0x0005 len 12 [psm 0]
< ACL data: handle 128 flags 0x00 dlen 7
     ATT: MTU req (0x02)
       client rx mtu 517
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 2
> HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 128 reason 0x3e
     Reason: Connection Failed to be Established
< HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15
     min 1280.000ms, max 1280.000ms
     type 0x00 (ADV_IND - Connectable undirected advertising) ownbdaddr
0x00 (Public)
     directbdaddr 0x00 (Public) 00:00:00:00:00:00
     channelmap 0x07 filterpolicy 0x00 (Allow scan from any, connection
from any)
> HCI Event: Command Complete (0x0e) plen 4
     LE Set Advertising Parameters (0x08|0x0006) ncmd 1
     status 0x00
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
> HCI Event: Command Complete (0x0e) plen 4
     LE Set Advertise Enable (0x08|0x000a) ncmd 1
     status 0x00
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
> HCI Event: Command Complete (0x0e) plen 4
     LE Set Advertise Enable (0x08|0x000a) ncmd 1
     status 0x00

hcidump log of a successful connection is:

> HCI Event: LE Meta Event (0x3e) plen 19
     LE Connection Complete
       status 0x00 handle 128, role slave
       bdaddr EC:39:7E:5F:71:94 (Random)
< ACL data: handle 128 flags 0x00 dlen 16
     L2CAP(d): cid 0x0005 len 12 [psm 0]
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 11
     ATT: Read By Group req (0x10)
       start 0x0001, end 0xffff
       type-uuid 0x2800
> ACL data: handle 128 flags 0x02 dlen 10
     L2CAP(d): cid 0x0005 len 6 [psm 0]
< ACL data: handle 128 flags 0x00 dlen 18
     ATT: Read By Group resp (0x11)
       attr handle 0x0001, end group handle 0x0005
       value 0x00 0x18
       attr handle 0x0006, end group handle 0x0009
       value 0x01 0x18
< ACL data: handle 128 flags 0x00 dlen 7
     ATT: MTU req (0x02)
       client rx mtu 517
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 7
     ATT: MTU resp (0x03)
       server rx mtu 23
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
< ACL data: handle 128 flags 0x00 dlen 11
     ATT: Read By Group req (0x10)
       start 0x0001, end 0xffff
       type-uuid 0x2800
> ACL data: handle 128 flags 0x02 dlen 11
     ATT: Read By Group req (0x10)
       start 0x000a, end 0xffff
       type-uuid 0x2800
> HCI Event: LE Meta Event (0x3e) plen 10
     LE Connection Update Complete
       status 0x00 handle 128
       interval 50.00ms, latency 0.00ms, superv. timeout 4000.00ms
< ACL data: handle 128 flags 0x00 dlen 9
     ATT: Error (0x01)
       Error: Attribute not found (10)
       Read By Group req (0x10) on handle 0x000a
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 18
     ATT: Read By Group resp (0x11)
       attr handle 0x0001, end group handle 0x0007
       value 0x00 0x18
       attr handle 0x0008, end group handle 0xffff
       value 0x01 0x18
> ACL data: handle 128 flags 0x02 dlen 11
     ATT: Read By Type req (0x08)
       start 0x0001, end 0x0005
       type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
< ACL data: handle 128 flags 0x00 dlen 20
     ATT: Read By Type resp (0x09)
       length: 7
         handle 0x0002, value 0x02 0x03 0x00 0x00 0x2a
         handle 0x0004, value 0x02 0x05 0x00 0x01 0x2a
< ACL data: handle 128 flags 0x00 dlen 11
     ATT: Read By Group req (0x10)
       start 0x0001, end 0xffff
       type-uuid 0x2801
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 9
     ATT: Error (0x01)
       Error: Attribute not found (10)
       Read By Group req (0x10) on handle 0x0001
> ACL data: handle 128 flags 0x02 dlen 7
     ATT: Read req (0x0a)
       handle 0x0003
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
< ACL data: handle 128 flags 0x00 dlen 15
     ATT: Read resp (0x0b)
< ACL data: handle 128 flags 0x00 dlen 11
     ATT: Read By Type req (0x08)
       start 0x0001, end 0x0007
       type-uuid 0x2802
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 9
     ATT: Error (0x01)
       Error: Attribute not found (10)
       Read By Type req (0x08) on handle 0x0001
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
< ACL data: handle 128 flags 0x00 dlen 11
     ATT: Read By Type req (0x08)
       start 0x0008, end 0xffff
       type-uuid 0x2802
> ACL data: handle 128 flags 0x02 dlen 7
     ATT: Read req (0x0a)
       handle 0x0005
< ACL data: handle 128 flags 0x00 dlen 7
     ATT: Read resp (0x0b)
> ACL data: handle 128 flags 0x02 dlen 9
     ATT: Error (0x01)
       Error: Attribute not found (10)
       Read By Type req (0x08) on handle 0x0008
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
< ACL data: handle 128 flags 0x00 dlen 11
     ATT: Read By Type req (0x08)
       start 0x0001, end 0x0007
       type-uuid 0x2803
> ACL data: handle 128 flags 0x02 dlen 9
     ATT: Find Information req (0x04)
       start 0x0004, end 0x0005
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
< ACL data: handle 128 flags 0x00 dlen 14
     ATT: Find Information resp (0x05)
       format: uuid-16
         handle 0x0004, uuid 0x2803 (GATT Characteristic)
         handle 0x0005, uuid 0x2a01 (GATT(type) Appearance)
> ACL data: handle 128 flags 0x02 dlen 27
     ATT: Read By Type resp (0x09)
       length: 7
         handle 0x0002, value 0x02 0x03 0x00 0x00 0x2a
         handle 0x0004, value 0x02 0x05 0x00 0x01 0x2a
         handle 0x0006, value 0x02 0x07 0x00 0x04 0x2a
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
< ACL data: handle 128 flags 0x00 dlen 11
     ATT: Read By Type req (0x08)
       start 0x0007, end 0x0007
       type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 9
     ATT: Error (0x01)
       Error: Attribute not found (10)
       Read By Type req (0x08) on handle 0x0007
> ACL data: handle 128 flags 0x02 dlen 9
     ATT: Find Information req (0x04)
       start 0x0006, end 0x0005
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
< ACL data: handle 128 flags 0x00 dlen 9
     ATT: Error (0x01)
       Error: Invalid handle (1)
       Find Information req (0x04) on handle 0x0006
< ACL data: handle 128 flags 0x00 dlen 11
     ATT: Read By Type req (0x08)
       start 0x0008, end 0xffff
       type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 9
     ATT: Error (0x01)
       Error: Attribute not found (10)
       Read By Type req (0x08) on handle 0x0008
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 7
     ATT: Read req (0x0a)
       handle 0x0003
< ACL data: handle 128 flags 0x00 dlen 15
     ATT: Read resp (0x0b)
< ACL data: handle 128 flags 0x00 dlen 7
     ATT: Read req (0x0a)
       handle 0x0003
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
> ACL data: handle 128 flags 0x02 dlen 10
     ATT: Read resp (0x0b)
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1
< ACL data: handle 128 flags 0x00 dlen 7
     ATT: Read req (0x0a)
       handle 0x0005
> ACL data: handle 128 flags 0x02 dlen 7
     ATT: Read resp (0x0b)
> HCI Event: Number of Completed Packets (0x13) plen 5
     handle 128 packets 1

I can't quite work out what the issue might be. Could anyone provide me
with some further insight please?

Thank you

Dushara

