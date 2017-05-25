Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: How to use GattProfile1
From: Krasi Georgiev <krasi.root@gmail.com>
In-Reply-To: <CABBYNZKkodmXy+4eRXh_4RA9yci25cEtaNMoywEUk9XZ+GL4LQ@mail.gmail.com>
Date: Thu, 25 May 2017 10:48:49 +0300
Cc: Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <758C2FAB-DBF1-4B88-866D-F036B23B3C95@gmail.com>
References: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com> <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com> <C1394BB3-3C11-410C-916F-80A7863C0A2B@gmail.com> <969738CC-B335-4E2F-BF3C-441110279871@gmail.com> <CAAu3APard0ZM-+++qm8938+iWkUUfNkjvq1M9cLqngtZYJAzRg@mail.gmail.com> <F1876BDF-4DC0-4CB0-A20F-2E64E24A3B92@gmail.com> <CABBYNZ+R7dV5i+BQowigf5eddB4yxSki+xLeLFYBrN4Sfe8mJA@mail.gmail.com> <4AE62BC6-BD11-44C7-9A0E-BC3159ED80DF@gmail.com> <4C907B25-D8E4-462C-89FA-AB312A27CBE9@gmail.com> <CABBYNZK04wxSH78f0maAMHtR-2ra8Kh_nQKkrAY1R8G19ba8TA@mail.gmail.com> <5CDE162E-4828-4485-BF95-50C67DB93B77@gmail.com> <CABBYNZKkodmXy+4eRXh_4RA9yci25cEtaNMoywEUk9XZ+GL4LQ@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just tried it again to double check

connected to the iTag, than turned it off and turned it back on, but =
nothing in the bluetoothd logs shows that it is trying to reconnect.


[bluetooth]# scan on
Discovery started
[CHG] Controller B8:27:EB:D5:54:1C Discovering: yes
[CHG] Device FF:FF:50:00:53:B6 RSSI: -78
[CHG] Device FF:FF:50:00:53:B6 TxPower: 0
[CHG] Device FF:FF:50:00:53:B6 AdvertisingFlags: 0x05
[bluetooth]# devices
Device 34:31:11:00:CD:7A Samsung Galaxy S IV
Device 04:52:C7:57:85:84 Bose Mini II SoundLink
Device FF:FF:50:00:53:B6 iTAG
[bluetooth]# connect FF:FF:50:00:53:B6
Attempting to connect to FF:FF:50:00:53:B6
[CHG] Device FF:FF:50:00:53:B6 Connected: yes
Connection successful
[CHG] Device FF:FF:50:00:53:B6 Icon is nil
[CHG] Device FF:FF:50:00:53:B6 Appearance is nil
[NEW] Primary Service
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0006
	0000180f-0000-1000-8000-00805f9b34fb
	Battery Service
[NEW] Characteristic
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0006/char0007
	00002a19-0000-1000-8000-00805f9b34fb
	Battery Level
[NEW] Primary Service
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0009
	00001802-0000-1000-8000-00805f9b34fb
	Immediate Alert
[NEW] Characteristic
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0009/char000a
	00002a06-0000-1000-8000-00805f9b34fb
	Alert Level
[NEW] Primary Service
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service000c
	0000ffe0-0000-1000-8000-00805f9b34fb
	Unknown
[NEW] Characteristic
	/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service000c/char000d
	0000ffe1-0000-1000-8000-00805f9b34fb
	Unknown
[CHG] Device FF:FF:50:00:53:B6 ServicesResolved: yes

[iTAG            ]# select-attribute =
0000180f-0000-1000-8000-00805f9b34fb
[CHG] Device FF:FF:50:00:53:B6 ServicesResolved: no
[CHG] Device FF:FF:50:00:53:B6 Connected: no
[CHG] Device FF:FF:50:00:53:B6 RSSI: -87
[CHG] Device FF:FF:50:00:53:B6 Appearance: 0x03c1
[CHG] Device FF:FF:50:00:53:B6 Icon: input-keyboard
[CHG] Device FF:FF:50:00:53:B6 RSSI: -77
[bluetooth]# devices
Device 34:31:11:00:CD:7A Samsung Galaxy S IV
Device 04:52:C7:57:85:84 Bose Mini II SoundLink
Device FF:FF:50:00:53:B6 iTAG
[CHG] Device FF:FF:50:00:53:B6 RSSI: -56
[CHG] Device FF:FF:50:00:53:B6 RSSI: -75
[CHG] Device FF:FF:50:00:53:B6 RSSI: -66
[CHG] Device FF:FF:50:00:53:B6 RSSI: -76







May 25 10:37:09 r1 bluetoothd[521]: src/agent.c:agent_ref() 0x12ebea0: =
ref=3D1
May 25 10:37:09 r1 rsyslogd-2007: action 'action 17' suspended, next =
retry is Thu May 25 10:37:39 2017 [try http://www.rsyslog.com/e/2007 ]
May 25 10:37:09 r1 bluetoothd[521]: src/agent.c:register_agent() agent =
:1.7
May 25 10:37:11 r1 bluetoothd[521]: src/adapter.c:start_discovery() =
sender :1.7
May 25 10:37:11 r1 bluetoothd[521]: =
src/adapter.c:update_discovery_filter()
May 25 10:37:11 r1 bluetoothd[521]: =
src/adapter.c:discovery_filter_to_mgmt_cp()
May 25 10:37:11 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:37:11 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:37:12 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:37:12 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:37:12 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:37:12 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:37:12 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-78 flags 0x0000 eir_len 32
May 25 10:37:12 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:37:12 r1 bluetoothd[521]: =
src/device.c:device_set_rssi_with_delta() rssi -78
May 25 10:37:12 r1 bluetoothd[521]: src/device.c:device_set_tx_power() =
tx_power 0
May 25 10:37:12 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:37:22 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:37:22 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:37:22 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:37:25 r1 bluetoothd[521]: src/device.c:device_connect_le() =
Connection attempt to: FF:FF:50:00:53:B6
May 25 10:37:25 r1 bluetoothd[521]: src/adapter.c:connected_callback() =
hci0 device FF:FF:50:00:53:B6 connected eir_len 14
May 25 10:37:28 r1 kernel: [   94.856198] NET: Registered protocol =
family 38
May 25 10:37:28 r1 bluetoothd[521]: attrib/gattrib.c:g_attrib_ref() =
0x12edae8: g_attrib_ref=3D1
May 25 10:37:28 r1 bluetoothd[521]: src/device.c:load_gatt_db() =
Restoring FF:FF:50:00:53:B6 gatt database from file
May 25 10:37:28 r1 bluetoothd[521]: src/device.c:load_service() loading =
service: 0x0001, end: 0x0005, uuid: 00001800-0000-1000-8000-00805f9b34fb
May 25 10:37:28 r1 bluetoothd[521]: src/device.c:load_service() loading =
service: 0x0006, end: 0x0008, uuid: 0000180f-0000-1000-8000-00805f9b34fb
May 25 10:37:28 r1 bluetoothd[521]: src/device.c:load_service() loading =
service: 0x0009, end: 0x000b, uuid: 00001802-0000-1000-8000-00805f9b34fb
May 25 10:37:28 r1 bluetoothd[521]: src/device.c:load_service() loading =
service: 0x000c, end: 0x000e, uuid: 0000ffe0-0000-1000-8000-00805f9b34fb
May 25 10:37:28 r1 bluetoothd[521]: src/device.c:load_chrc() loading =
characteristic handle: 0x0002, value handle: 0x0003, properties 0x0012 =
uuid: 00002a00-0000-1000-8000-00805f9b34fb
May 25 10:37:28 r1 bluetoothd[521]: src/device.c:load_chrc() loading =
characteristic handle: 0x0004, value handle: 0x0005, properties 0x0002 =
uuid: 00002a01-0000-1000-8000-00805f9b34fb
May 25 10:37:28 r1 bluetoothd[521]: src/device.c:load_chrc() loading =
characteristic handle: 0x0007, value handle: 0x0008, properties 0x0012 =
uuid: 00002a19-0000-1000-8000-00805f9b34fb
May 25 10:37:28 r1 bluetoothd[521]: src/device.c:load_chrc() loading =
characteristic handle: 0x000a, value handle: 0x000b, properties 0x001c =
uuid: 00002a06-0000-1000-8000-00805f9b34fb
May 25 10:37:28 r1 bluetoothd[521]: src/device.c:load_chrc() loading =
characteristic handle: 0x000d, value handle: 0x000e, properties 0x0012 =
uuid: 0000ffe1-0000-1000-8000-00805f9b34fb
May 25 10:37:28 r1 bluetoothd[521]: profiles/gap/gas.c:gap_accept() GAP =
profile accept (FF:FF:50:00:53:B6)
May 25 10:37:28 r1 bluetoothd[521]: src/service.c:change_state() =
0x12f5b70: device FF:FF:50:00:53:B6 profile gap-profile state changed: =
disconnected -> connected (0)
May 25 10:37:28 r1 bluetoothd[521]: =
src/gatt-client.c:btd_gatt_client_connected() Device connected.
May 25 10:37:28 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:37:28 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:37:28 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:37:28 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:37:28 r1 bluetoothd[521]: src/device.c:gatt_debug() MTU =
exchange complete, with MTU: 23
May 25 10:37:29 r1 bluetoothd[521]: =
profiles/gap/gas.c:read_device_name_cb() GAP Device Name: iTAG
May 25 10:37:29 r1 bluetoothd[521]: =
profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0000
May 25 10:37:31 r1 bluetoothd[521]: src/device.c:gatt_debug() Primary =
services found: 4
May 25 10:37:31 r1 bluetoothd[521]: src/device.c:gatt_debug() start: =
0x0001, end: 0x0005, uuid: 00001800-0000-1000-8000-00805f9b34fb
May 25 10:37:31 r1 bluetoothd[521]: src/device.c:gatt_debug() start: =
0x0006, end: 0x0008, uuid: 0000180f-0000-1000-8000-00805f9b34fb
May 25 10:37:31 r1 bluetoothd[521]: src/device.c:gatt_debug() start: =
0x0009, end: 0x000b, uuid: 00001802-0000-1000-8000-00805f9b34fb
May 25 10:37:31 r1 bluetoothd[521]: src/device.c:gatt_debug() start: =
0x000c, end: 0x000e, uuid: 0000ffe0-0000-1000-8000-00805f9b34fb
May 25 10:37:31 r1 bluetoothd[521]: src/device.c:gatt_client_ready_cb() =
status: success, error: 10
May 25 10:37:31 r1 bluetoothd[521]: =
src/gatt-client.c:btd_gatt_client_ready() GATT client ready
May 25 10:37:31 r1 bluetoothd[521]: src/gatt-client.c:create_services() =
Exporting objects for GATT services: FF:FF:50:00:53:B6
May 25 10:37:31 r1 bluetoothd[521]: src/gatt-client.c:service_create() =
Exported GATT service: /org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0006
May 25 10:37:31 r1 bluetoothd[521]: =
src/gatt-client.c:characteristic_create() Exported GATT characteristic: =
/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0006/char0007
May 25 10:37:31 r1 bluetoothd[521]: src/gatt-client.c:service_create() =
Exported GATT service: /org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0009
May 25 10:37:31 r1 bluetoothd[521]: =
src/gatt-client.c:characteristic_create() Exported GATT characteristic: =
/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service0009/char000a
May 25 10:37:31 r1 bluetoothd[521]: src/gatt-client.c:service_create() =
Exported GATT service: /org/bluez/hci0/dev_FF_FF_50_00_53_B6/service000c
May 25 10:37:31 r1 bluetoothd[521]: =
src/gatt-client.c:characteristic_create() Exported GATT characteristic: =
/org/bluez/hci0/dev_FF_FF_50_00_53_B6/service000c/char000d
May 25 10:37:31 r1 bluetoothd[521]: src/device.c:device_svc_resolved() =
/org/bluez/hci0/dev_FF_FF_50_00_53_B6 err 0
May 25 10:37:38 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:37:38 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:37:38 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:37:44 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:37:44 r1 rsyslogd-2007: action 'action 17' suspended, next =
retry is Thu May 25 10:38:14 2017 [try http://www.rsyslog.com/e/2007 ]
May 25 10:37:44 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:37:44 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:37:44 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:37:51 r1 kernel: [  117.904072] w1_master_driver =
w1_bus_master1: Family 0 for 00.400000000000.46 is not registered.
May 25 10:37:54 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:37:54 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:37:54 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:38:00 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:38:00 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:38:00 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:38:00 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:38:07 r1 bluetoothd[521]: src/adapter.c:dev_disconnected() =
Device FF:FF:50:00:53:B6 disconnected, reason 1
May 25 10:38:07 r1 bluetoothd[521]: =
src/adapter.c:adapter_remove_connection()
May 25 10:38:07 r1 bluetoothd[521]: plugins/policy.c:disconnect_cb() =
reason 1
May 25 10:38:07 r1 bluetoothd[521]: =
src/adapter.c:bonding_attempt_complete() hci0 bdaddr FF:FF:50:00:53:B6 =
type 1 status 0xe
May 25 10:38:07 r1 bluetoothd[521]: =
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
May 25 10:38:07 r1 bluetoothd[521]: src/device.c:device_bonding_failed() =
status 14
May 25 10:38:07 r1 bluetoothd[521]: src/adapter.c:resume_discovery()
May 25 10:38:07 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:38:07 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:38:07 r1 bluetoothd[521]: src/device.c:att_disconnected_cb()
May 25 10:38:07 r1 bluetoothd[521]: src/device.c:att_disconnected_cb() =
Connection timed out (110)
May 25 10:38:07 r1 bluetoothd[521]: src/service.c:change_state() =
0x12f5b70: device FF:FF:50:00:53:B6 profile gap-profile state changed: =
connected -> disconnecting (0)
May 25 10:38:07 r1 bluetoothd[521]: src/service.c:change_state() =
0x12f5b70: device FF:FF:50:00:53:B6 profile gap-profile state changed: =
disconnecting -> disconnected (0)
May 25 10:38:07 r1 bluetoothd[521]: =
src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. =
Cleaning up.
May 25 10:38:07 r1 bluetoothd[521]: src/device.c:att_disconnected_cb() =
Automatic connection disabled
May 25 10:38:07 r1 bluetoothd[521]: attrib/gattrib.c:g_attrib_unref() =
0x12edae8: g_attrib_unref=3D0
May 25 10:38:10 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:38:10 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:38:10 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:38:16 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:38:16 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:38:16 r1 rsyslogd-2007: action 'action 17' suspended, next =
retry is Thu May 25 10:38:46 2017 [try http://www.rsyslog.com/e/2007 ]
May 25 10:38:16 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:38:16 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:38:17 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-87 flags 0x0000 eir_len 32
May 25 10:38:17 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:38:17 r1 bluetoothd[521]: =
src/device.c:device_set_rssi_with_delta() rssi -87 delta 9
May 25 10:38:17 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:38:26 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:38:26 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:38:26 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:38:32 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:38:32 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:38:32 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:38:32 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:38:32 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-77 flags 0x0000 eir_len 32
May 25 10:38:32 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:38:32 r1 bluetoothd[521]: =
src/device.c:device_set_rssi_with_delta() rssi -77 delta 10
May 25 10:38:32 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:38:38 r1 kernel: [  165.274531] w1_master_driver =
w1_bus_master1: Family 0 for 00.c00000000000.ca is not registered.
May 25 10:38:42 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:38:42 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:38:42 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:38:48 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:38:48 r1 rsyslogd-2007: action 'action 17' suspended, next =
retry is Thu May 25 10:39:18 2017 [try http://www.rsyslog.com/e/2007 ]
May 25 10:38:48 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:38:48 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:38:48 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:38:48 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-71 flags 0x0000 eir_len 32
May 25 10:38:48 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:38:48 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:38:58 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:38:58 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:38:58 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:39:04 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:39:04 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:39:04 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:39:04 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:39:04 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-74 flags 0x0000 eir_len 32
May 25 10:39:04 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:39:04 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:39:14 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:39:14 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:39:14 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:39:20 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:39:20 r1 rsyslogd-2007: action 'action 17' suspended, next =
retry is Thu May 25 10:39:50 2017 [try http://www.rsyslog.com/e/2007 ]
May 25 10:39:20 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:39:20 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:39:20 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:39:20 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-72 flags 0x0000 eir_len 32
May 25 10:39:20 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:39:20 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:39:30 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:39:30 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:39:30 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:39:36 r1 systemd[1]: Starting Session c3 of user root.
May 25 10:39:36 r1 systemd[1]: Started Session c3 of user root.
May 25 10:39:36 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:39:36 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:39:36 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:39:36 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:39:38 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-75 flags 0x0000 eir_len 32
May 25 10:39:38 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:39:38 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:39:46 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:39:46 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:39:46 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:39:50 r1 kernel: [  236.654808] w1_master_driver =
w1_bus_master1: Family 0 for 00.200000000000.23 is not registered.
May 25 10:39:50 r1 rsyslogd-2007: action 'action 17' suspended, next =
retry is Thu May 25 10:40:20 2017 [try http://www.rsyslog.com/e/2007 ]
May 25 10:39:52 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:39:52 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:39:52 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:39:52 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:39:54 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-72 flags 0x0000 eir_len 32
May 25 10:39:54 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:39:54 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:40:02 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:40:02 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:40:02 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:40:08 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:40:08 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:40:08 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:40:08 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:40:12 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-74 flags 0x0000 eir_len 32
May 25 10:40:12 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:40:12 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:40:18 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:40:18 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:40:18 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:40:24 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:40:24 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:40:24 r1 rsyslogd-2007: action 'action 17' suspended, next =
retry is Thu May 25 10:40:54 2017 [try http://www.rsyslog.com/e/2007 ]
May 25 10:40:24 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:40:24 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:40:29 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-56 flags 0x0000 eir_len 14
May 25 10:40:29 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:40:29 r1 bluetoothd[521]: =
src/device.c:device_set_rssi_with_delta() rssi -56 delta 21
May 25 10:40:29 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:40:34 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:40:34 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:40:34 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:40:40 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:40:40 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:40:40 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:40:40 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:40:45 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-60 flags 0x0000 eir_len 14
May 25 10:40:45 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:40:45 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:40:50 r1 kernel: [  296.889635] w1_master_driver =
w1_bus_master1: Family 0 for 00.a00000000000.af is not registered.
May 25 10:40:50 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:40:50 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:40:50 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:40:55 r1 rsyslogd-2007: action 'action 17' suspended, next =
retry is Thu May 25 10:41:25 2017 [try http://www.rsyslog.com/e/2007 ]
May 25 10:40:56 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:40:56 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:40:56 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:40:56 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:40:57 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-75 flags 0x0000 eir_len 32
May 25 10:40:57 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:40:57 r1 bluetoothd[521]: =
src/device.c:device_set_rssi_with_delta() rssi -75 delta 19
May 25 10:40:57 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:41:06 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:41:06 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:41:06 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:41:12 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:41:12 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:41:12 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:41:12 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:41:15 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-74 flags 0x0000 eir_len 32
May 25 10:41:15 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:41:15 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:41:22 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:41:22 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:41:22 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:41:26 r1 kernel: [  332.965857] w1_master_driver =
w1_bus_master1: Family 0 for 00.600000000000.65 is not registered.
May 25 10:41:26 r1 rsyslogd-2007: action 'action 17' suspended, next =
retry is Thu May 25 10:42:26 2017 [try http://www.rsyslog.com/e/2007 ]
May 25 10:41:28 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:41:28 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:41:28 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:41:28 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:41:33 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-66 flags 0x0000 eir_len 14
May 25 10:41:33 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:41:33 r1 bluetoothd[521]: =
src/device.c:device_set_rssi_with_delta() rssi -66 delta 9
May 25 10:41:33 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:41:38 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:41:38 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:41:38 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:41:44 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:41:44 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:41:44 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:41:44 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:41:45 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-76 flags 0x0000 eir_len 32
May 25 10:41:45 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:41:45 r1 bluetoothd[521]: =
src/device.c:device_set_rssi_with_delta() rssi -76 delta 10
May 25 10:41:45 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:41:54 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:41:54 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:41:54 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:42:00 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:42:00 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:42:00 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:42:00 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:42:03 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-74 flags 0x0000 eir_len 32
May 25 10:42:03 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:42:03 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:42:04 r1 kernel: [  370.930206] w1_master_driver =
w1_bus_master1: Family 0 for 00.e00000000000.e9 is not registered.
May 25 10:42:10 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:42:10 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:42:10 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:42:16 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:42:16 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:42:16 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:42:16 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:42:21 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-75 flags 0x0000 eir_len 32
May 25 10:42:23 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:42:23 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:42:26 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:42:26 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:42:26 r1 rsyslogd-2007: action 'action 17' suspended, next =
retry is Thu May 25 10:43:26 2017 [try http://www.rsyslog.com/e/2007 ]
May 25 10:42:26 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:42:32 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:42:32 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:42:32 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:42:32 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:42:37 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-61 flags 0x0000 eir_len 14
May 25 10:42:37 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:42:37 r1 bluetoothd[521]: =
src/device.c:device_set_rssi_with_delta() rssi -61 delta 15
May 25 10:42:37 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:42:42 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:42:42 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:42:42 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:42:48 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:42:48 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:42:48 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:42:48 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:42:53 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-62 flags 0x0000 eir_len 14
May 25 10:42:53 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:42:53 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:42:58 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:42:58 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:42:58 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
May 25 10:43:04 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout()
May 25 10:43:04 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_timeout() =
adapter->current_discovery_filter =3D=3D 0
May 25 10:43:04 r1 bluetoothd[521]: =
src/adapter.c:start_discovery_complete() status 0x00
May 25 10:43:04 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 1 method 0
May 25 10:43:06 r1 kernel: [  433.030777] w1_master_driver =
w1_bus_master1: Family 0 for 00.100000000000.9d is not registered.
May 25 10:43:09 r1 bluetoothd[521]: =
src/adapter.c:device_found_callback() hci0 addr FF:FF:50:00:53:B6, rssi =
-75 flags 0x0000 eir_len 32
May 25 10:43:14 r1 bluetoothd[521]: src/device.c:device_set_legacy() =
legacy 0
May 25 10:43:14 r1 bluetoothd[521]: =
src/device.c:device_set_rssi_with_delta() rssi -75 delta 14
May 25 10:43:14 r1 bluetoothd[521]: src/device.c:device_set_flags() =
flags 5
May 25 10:43:14 r1 bluetoothd[521]: src/adapter.c:discovering_callback() =
hci0 type 7 discovering 0 method 0
May 25 10:43:14 r1 bluetoothd[521]: =
src/adapter.c:trigger_start_discovery()
May 25 10:43:14 r1 bluetoothd[521]: =
src/adapter.c:cancel_passive_scanning()
