Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Juha Kuikka <juha.kuikka@gmail.com>
Date: Wed, 21 Dec 2016 21:46:03 -0800
Message-ID: <CAKvrXUojNa-vAn1DQ5WGnj-4wshk7WB+LtTmZTZ8ae8b7JtEyg@mail.gmail.com>
Subject: Possible race condition between DIS and HoG
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I believe I have identified an issue with BLE HoG service.

It is possible for the HoG service to get probed before the Device
Information Service has finished reading the VID&PID of the
peripheral.

This causes the uHID device to get created with zero VID&PID. For most
devices this is not an issue but if there is a need to have a quirk
driver or use of hidraw this will make identifying the device
impossible.

This only seems to affect the first connection, on subsequent
connections the cached VID&PID are used.

Here is the output from a slightly instrumented bluetoothd 5.43.
bluetoothd[2479]: profiles/gap/gas.c:gap_probe() GAP profile probe
(AA:BB:CC:44:16:AF)
bluetoothd[2479]: src/service.c:change_state() 0x22aef10: device
AA:BB:CC:44:16:AF profile gap-profile state changed: unavailable ->
disconnected (0)
bluetoothd[2479]: profiles/gap/gas.c:gap_accept() GAP profile accept
(AA:BB:CC:44:16:AF)
bluetoothd[2479]: profiles/gap/gas.c:handle_characteristic()
Unsupported characteristic: 00002a04-0000-1000-8000-00805f9b34fb
bluetoothd[2479]: src/service.c:change_state() 0x22aef10: device
AA:BB:CC:44:16:AF profile gap-profile state changed: disconnected ->
connected (0)
bluetoothd[2479]: src/device.c:device_probe_profiles() Probing
profiles for device AA:BB:CC:44:16:AF
bluetoothd[2479]: src/device.c:device_probe_profiles() Probing
profiles for device AA:BB:CC:44:16:AF
bluetoothd[2479]: src/service.c:change_state() 0x22b4180: device
AA:BB:CC:44:16:AF profile deviceinfo state changed: unavailable ->
disconnected (0)
bluetoothd[2479]: profiles/deviceinfo/deviceinfo.c:deviceinfo_accept()
deviceinfo profile accept (AA:BB:CC:44:16:AF)
bluetoothd[2479]:
profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported
characteristic: 00002a29-0000-1000-8000-00805f9b34fb
bluetoothd[2479]: src/service.c:change_state() 0x22b4180: device
AA:BB:CC:44:16:AF profile deviceinfo state changed: disconnected ->
connected (0)
bluetoothd[2479]: src/device.c:device_probe_profiles() Probing
profiles for device AA:BB:CC:44:16:AF
bluetoothd[2479]: profiles/input/hog.c:hog_probe() path
/org/bluez/hci0/dev_AA_BB_CC_44_16_AF

Here VID and PID are zeroes when the HoG device is created.

bluetoothd[2479]: profiles/input/hog.c:hog_device_new() name=MyDevice
vendor=0x0, product=0x0, version=0x0
bluetoothd[2479]: src/service.c:change_state() 0x22c8220: device
AA:BB:CC:44:16:AF profile input-hog state changed: unavailable ->
disconnected (0)
bluetoothd[2479]: src/device.c:device_set_auto_connect()
AA:BB:CC:44:16:AF auto connect: 1
bluetoothd[2479]: src/device.c:device_set_auto_connect() Already connected
bluetoothd[2479]: attrib/gattrib.c:g_attrib_ref() 0x22aecf0: g_attrib_ref=2
bluetoothd[2479]: profiles/input/hog-lib.c:bt_hog_attach() HoG
discovering characteristics
bluetoothd[2479]: attrib/gattrib.c:g_attrib_ref() 0x22aecf0: g_attrib_ref=3
bluetoothd[2479]: src/service.c:change_state() 0x22c8220: device
AA:BB:CC:44:16:AF profile input-hog state changed: disconnected ->
connected (0)
bluetoothd[2479]: src/service.c:btd_service_ref() 0x22c8220: ref=2
bluetoothd[2479]: plugins/policy.c:service_cb() Added input-hog reconnect 0
bluetoothd[2479]: src/gatt-client.c:btd_gatt_client_ready() GATT client ready
bluetoothd[2479]: src/gatt-client.c:create_services() Exporting
objects for GATT services: AA:BB:CC:44:16:AF
bluetoothd[2479]: src/gatt-client.c:service_create() Exported GATT
service: /org/bluez/hci0/dev_AA_BB_CC_44_16_AF/service0008
bluetoothd[2479]: src/gatt-client.c:service_create() Exported GATT
service: /org/bluez/hci0/dev_AA_BB_CC_44_16_AF/service0009
bluetoothd[2479]: src/gatt-client.c:characteristic_create() Exported
GATT characteristic:
/org/bluez/hci0/dev_AA_BB_CC_44_16_AF/service0009/char000a
bluetoothd[2479]: src/gatt-client.c:characteristic_create() Exported
GATT characteristic:
/org/bluez/hci0/dev_AA_BB_CC_44_16_AF/service0009/char000c
bluetoothd[2479]: src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_AA_BB_CC_44_16_AF err 0
bluetoothd[2479]: src/adapter.c:add_device_complete()
AA:BB:CC:44:16:AF (2) added to kernel connect list
bluetoothd[2479]: profiles/gap/gas.c:read_device_name_cb() GAP Device
Name: MyDevice
bluetoothd[2479]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x03c2
bluetoothd[2479]: src/adapter.c:new_conn_param() hci0
AA:BB:CC:44:16:AF (2) min 0x0006 max 0x0008 latency 0x000a timeout
0x012c
bluetoothd[2479]: src/adapter.c:store_conn_param()
bluetoothd[2479]: src/adapter.c:new_irk_callback() hci0 new IRK for
AA:BB:CC:44:16:AF RPA 00:00:00:00:00:00

And they are set here.

bluetoothd[2479]: src/device.c:btd_device_set_pnpid() source=2
vendor=1234 product=5678 version=1
bluetoothd[2479]: src/adapter.c:new_long_term_key_callback() hci0 new
LTK for AA:BB:CC:44:16:AF type 0 enc_size 16
bluetoothd[2479]: src/device.c:device_set_bonded()
bluetoothd[2479]: src/device.c:device_bonding_complete() bonding (nil)
status 0x00
bluetoothd[2479]: src/adapter.c:resume_discovery()

What would be a good approach to defer the HoG probe until the DIS is
ready? Or should I look into a mechanism to indicate

Thanks,
 - Juha
