Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Hoover, David" <DHoover@asulab.ch>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Regression? Missing D-Bus GATT characteristics with version 5.38
Date: Tue, 22 Mar 2016 10:33:51 +0000
Message-ID: <13BCED30230BDE4A95185615BD0E58144C982E5A@GDC00215.swatchgroup.net>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0022_01D1842E.B4DDC590"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------=_NextPart_000_0022_01D1842E.B4DDC590
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

With the Feb 29 commit (8e493e8416e5525042b8b4a34eb2b7084725438b) I am =
able
to see BLE device services and query their characteristics, but with =
version
5.38, this no longer works for me.

This breaks test/example-gatt-client. Any idea? I can perform additional
tests if necessary.

For both checkouts I compiled with:

./configure --prefix=3D/share/bluez --enable-maintainer-mode
--enable-backtrace --enable-test --enable-debug --disable-optimization
--enable-experimental --sysconfdir=3D/share/bluez/etc --disable-udev
--disable-systemd

Thanks,

David


Example (8e493e8416e5525042b8b4a34eb2b7084725438b):

dhoover@debian82:~/git/bluez/bluez/test$ qdbus --system org.bluez
/
/org
/org/bluez
/org/bluez/hci0
/org/bluez/hci0/dev_12_34_50_12_34_52
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0002
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0004
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0006
/org/bluez/hci0/dev_12_34_50_12_34_52/service0008
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a/desc000c
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000d
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000f
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0012
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0014
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0016
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001b
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001c

dhoover@debian82:~/git/bluez/bluez/test$ qdbus --system org.bluez
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009
org.freedesktop.DBus.Properties.GetAll org.bluez.GattService1
Characteristics: qdbus: I don't know how to display an argument of type
'ao', run with --literal.
Device:=20
Primary: true
UUID: 0000180d-0000-1000-8000-00805f9b34fb

dhoover@debian82:~/git/bluez/bluez/test$ qdbus --literal --system =
org.bluez
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009
org.freedesktop.DBus.Properties.GetAll org.bluez.GattService1
[Argument: a{sv} {"UUID" =3D [Variant(QString):
"0000180d-0000-1000-8000-00805f9b34fb"], "Device" =3D [Variant: =
[ObjectPath:
/org/bluez/hci0/dev_12_34_50_12_34_52]], "Primary" =3D [Variant(bool): =
true],
"Characteristics" =3D [Variant: [Argument: ao {[ObjectPath:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a], =
[ObjectPath:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000d], =
[ObjectPath:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000f]}]]}]

dhoover@debian82:~/git/bluez/bluez/test$ ./example-gatt-client
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009
Heart Rate Service ready
Body sensor location value: Chest
HR Measurement notifications enabled
New HR Measurement
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HR: 108
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Sensor Contact status: no =
contact detected
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Energy Expended: 20

Example (ver 5.38):

dhoover@debian82:~/git/bluez/bluez/test$ qdbus --system org.bluez
/
/org
/org/bluez
/org/bluez/hci0
/org/bluez/hci0/dev_12_34_50_12_34_52
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0002
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0004
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0006
/org/bluez/hci0/dev_12_34_50_12_34_52/service0008
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a/desc000c
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000d
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000f
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0012
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0014
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0016
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001b
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001c
/org/bluez/hci0/dev_D0_33_11_3A_D4_71
/org/bluez/hci0/dev_EE_34_56_78_9A_BC

dhoover@debian82:~/git/bluez/bluez/test$ qdbus --system org.bluez
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009
org.freedesktop.DBus.Properties.GetAll org.bluez.GattService1
Device:=20
Primary: true
UUID: 0000180d-0000-1000-8000-00805f9b34fb

dhoover@debian82:~/git/bluez/bluez/test$ ./example-gatt-client
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009
Traceback (most recent call last):
=A0 File "./example-gatt-client", line 221, in <module>
=A0=A0=A0 main()
=A0 File "./example-gatt-client", line 207, in main
=A0=A0=A0 if not process_hr_service(service_path):
=A0 File "./example-gatt-client", line 167, in process_hr_service
=A0=A0=A0 chrc_paths =3D service_props['Characteristics']
KeyError: 'Characteristics'



** BLUETOOTHD LOGS BELOW **



Bluetoothd log (8e493e8416e5525042b8b4a34eb2b7084725438b):

root@debian82:/home/dhoover# /share/bluez/libexec/bluetooth/bluetoothd =
-E -p
time -n =96d
bluetoothd[13319]: Bluetooth daemon 5.37
bluetoothd[13319]: src/adapter.c:adapter_init() sending read version =
command
bluetoothd[13319]: Starting SDP server
bluetoothd[13319]: src/sdpd-service.c:register_device_id() Adding device =
id
record for 0002:1d6b:0246:0525
bluetoothd[13319]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[13319]: Ignoring (cli) hostname
bluetoothd[13319]: Ignoring (cli) wiimote
bluetoothd[13319]: Ignoring (cli) autopair
bluetoothd[13319]: Ignoring (cli) policy
bluetoothd[13319]: Ignoring (cli) gatt_example
bluetoothd[13319]: Ignoring (cli) neard
bluetoothd[13319]: Ignoring (cli) sap
bluetoothd[13319]: Ignoring (cli) a2dp
bluetoothd[13319]: Ignoring (cli) avrcp
bluetoothd[13319]: Ignoring (cli) network
bluetoothd[13319]: Ignoring (cli) input
bluetoothd[13319]: Ignoring (cli) hog
bluetoothd[13319]: Ignoring (cli) health
bluetoothd[13319]: Ignoring (cli) gap
bluetoothd[13319]: Ignoring (cli) scanparam
bluetoothd[13319]: Ignoring (cli) deviceinfo
bluetoothd[13319]: Ignoring (cli) alert
bluetoothd[13319]: src/plugin.c:add_plugin() Loading time plugin
bluetoothd[13319]: Ignoring (cli) proximity
bluetoothd[13319]: Ignoring (cli) thermometer
bluetoothd[13319]: Ignoring (cli) heartrate
bluetoothd[13319]: Ignoring (cli) cyclingspeed
bluetoothd[13319]: src/plugin.c:plugin_init() Loading plugins
/home/dhoover/git/bluez/bluez/plugins/.libs
bluetoothd[13319]: Ignoring (cli) external_dummy
bluetoothd[13319]: src/main.c:main() Entering main loop
bluetoothd[13319]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type 2 =
op
0 soft 0 hard 0
bluetoothd[13319]: Bluetooth management interface 1.6 initialized
bluetoothd[13319]: src/adapter.c:read_version_complete() sending read
supported commands command
bluetoothd[13319]: src/adapter.c:read_version_complete() sending read =
index
list command
bluetoothd[13319]: src/adapter.c:read_commands_complete() Number of
commands: 47
bluetoothd[13319]: src/adapter.c:read_commands_complete() Number of =
events:
23
bluetoothd[13319]: src/adapter.c:read_index_list_complete() Number of
controllers: 1
bluetoothd[13319]: src/adapter.c:read_index_list_complete() Found index =
0
bluetoothd[13319]: src/adapter.c:index_added() index 0
bluetoothd[13319]: src/adapter.c:btd_adapter_new() System name: BlueZ =
5.37
bluetoothd[13319]: src/adapter.c:btd_adapter_new() Major class: 0
bluetoothd[13319]: src/adapter.c:btd_adapter_new() Minor class: 0
bluetoothd[13319]: src/adapter.c:btd_adapter_new() Modalias:
usb:v1D6Bp0246d0525
bluetoothd[13319]: src/adapter.c:btd_adapter_new() Discoverable timeout: =
180
seconds
bluetoothd[13319]: src/adapter.c:btd_adapter_new() Pairable timeout: 0
seconds
bluetoothd[13319]: src/adapter.c:index_added() sending read info command =
for
index 0
bluetoothd[13319]: src/adapter.c:read_info_complete() index 0 status =
0x00
bluetoothd[13319]: src/adapter.c:clear_uuids() sending clear uuids =
command
for index 0
bluetoothd[13319]: src/gatt-database.c:btd_gatt_database_new() GATT =
Manager
registered for adapter: /org/bluez/hci0
bluetoothd[13319]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[13319]: src/sdpd-service.c:add_record_to_server() Adding =
record
with handle 0x10001
bluetoothd[13319]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000007-0000-1000-8000-00805f9
bluetoothd[13319]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000100-0000-1000-8000-00805f9
bluetoothd[13319]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001002-0000-1000-8000-00805f9
bluetoothd[13319]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001800-0000-1000-8000-00805f9
bluetoothd[13319]: src/adapter.c:adapter_service_insert() =
/org/bluez/hci0
bluetoothd[13319]: src/adapter.c:add_uuid() sending add uuid command for
index 0
bluetoothd[13319]: src/gatt-database.c:gatt_db_service_added() GATT =
Service
added to local database
bluetoothd[13319]: Failed to obtain handles for "Service Changed"
characteristic
bluetoothd[13319]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[13319]: src/sdpd-service.c:add_record_to_server() Adding =
record
with handle 0x10002
bluetoothd[13319]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000007-0000-1000-8000-00805f9
bluetoothd[13319]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000100-0000-1000-8000-00805f9
bluetoothd[13319]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001002-0000-1000-8000-00805f9
bluetoothd[13319]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001801-0000-1000-8000-00805f9
bluetoothd[13319]: src/adapter.c:adapter_service_insert() =
/org/bluez/hci0
bluetoothd[13319]: src/adapter.c:add_uuid() sending add uuid command for
index 0
bluetoothd[13319]: src/gatt-database.c:gatt_db_service_added() GATT =
Service
added to local database
bluetoothd[13319]: src/advertising.c:btd_advertising_manager_new() LE
Advertising Manager created for adapter: /org/bluez/hci0
bluetoothd[13319]: profiles/time/server.c:time_server_init() path
/org/bluez/hci0
bluetoothd[13319]: Not enough free handles to register service
bluetoothd[13319]: Current Time Service could not be registered
bluetoothd[13319]: gatt-time-server: Input/output error (5)
bluetoothd[13319]: src/adapter.c:btd_adapter_unblock_address() hci0
00:00:00:00:00:00
bluetoothd[13319]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys =
0
bluetoothd[13319]: src/adapter.c:load_ltks() hci0 keys 0
bluetoothd[13319]: src/adapter.c:load_irks() hci0 irks 0
bluetoothd[13319]: src/adapter.c:load_conn_params() hci0 conn params 0
bluetoothd[13319]: src/adapter.c:adapter_service_insert() =
/org/bluez/hci0
bluetoothd[13319]: src/adapter.c:add_uuid() sending add uuid command for
index 0
bluetoothd[13319]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b =
product
246 version 525
bluetoothd[13319]: src/adapter.c:adapter_register() Adapter =
/org/bluez/hci0
registered
bluetoothd[13319]: src/adapter.c:set_dev_class() sending set device =
class
command for index 0
bluetoothd[13319]: src/adapter.c:set_name() sending set local name =
command
for index 0
bluetoothd[13319]: src/adapter.c:set_mode() sending set mode command for
index 0
bluetoothd[13319]: Failed to read advertising features: Unknown Command
(0x01)
bluetoothd[13319]: src/adapter.c:load_link_keys_complete() link keys =
loaded
for hci0
bluetoothd[13319]: src/adapter.c:load_ltks_complete() LTKs loaded for =
hci0
bluetoothd[13319]: src/adapter.c:load_irks_complete() IRKs loaded for =
hci0
bluetoothd[13319]: hci0 Load Connection Parameters failed: Unknown =
Command
(0x01)
bluetoothd[13319]: src/adapter.c:local_name_changed_callback() Name: =
BlueZ
5.37
bluetoothd[13319]: src/adapter.c:local_name_changed_callback() Short =
name:=20
bluetoothd[13319]: src/adapter.c:local_name_changed_callback() Current
alias: BlueZ 5.37
bluetoothd[13319]: src/adapter.c:property_set_mode() sending Set Powered
command for index 0
bluetoothd[13319]: src/adapter.c:property_set_mode_complete() Success =
(0x00)
bluetoothd[13319]: src/adapter.c:new_settings_callback() Settings:
0x000002d3
bluetoothd[13319]: src/adapter.c:settings_changed() Changed settings:
0x00000001
bluetoothd[13319]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 =
has
been enabled
bluetoothd[13319]: src/adapter.c:trigger_passive_scanning()=20

bluetoothd[13319]: src/adapter.c:start_discovery() sender :1.120
bluetoothd[13319]: src/adapter.c:update_discovery_filter()=20
bluetoothd[13319]: src/adapter.c:discovery_filter_to_mgmt_cp()=20
bluetoothd[13319]: src/adapter.c:trigger_start_discovery()=20
bluetoothd[13319]: src/adapter.c:cancel_passive_scanning()=20
bluetoothd[13319]: src/adapter.c:start_discovery_timeout()=20
bluetoothd[13319]: src/adapter.c:start_discovery_timeout()
adapter->current_discovery_filter =3D=3D 0
bluetoothd[13319]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[13319]: src/adapter.c:discovering_callback() hci0 type 7
discovering 1 method 0
bluetoothd[13319]: src/adapter.c:device_found_callback() hci0 addr
12:34:50:12:34:50, rssi -86 flags 0x0000 eir_len 34
bluetoothd[13319]: src/device.c:device_create() dst 12:34:50:12:34:50
bluetoothd[13319]: src/device.c:device_new() address 12:34:50:12:34:50
bluetoothd[13319]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_12_34_50_12_34_50
bluetoothd[13319]: src/device.c:device_set_legacy() legacy 0
bluetoothd[13319]: src/device.c:device_set_rssi_with_delta() rssi -86
bluetoothd[13319]: src/device.c:btd_device_device_set_name()
/org/bluez/hci0/dev_12_34_50_12_34_50 custom_profile_10_03_2015
bluetoothd[13319]: src/adapter.c:device_found_callback() hci0 addr
12:34:50:12:34:52, rssi -59 flags 0x0000 eir_len 51
bluetoothd[13319]: src/device.c:device_create() dst 12:34:50:12:34:52
bluetoothd[13319]: src/device.c:device_new() address 12:34:50:12:34:52
bluetoothd[13319]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_12_34_50_12_34_52
bluetoothd[13319]: src/device.c:device_set_legacy() legacy 0
bluetoothd[13319]: src/device.c:device_set_rssi_with_delta() rssi -59
bluetoothd[13319]: src/device.c:btd_device_device_set_name()
/org/bluez/hci0/dev_12_34_50_12_34_52 Heart Rate Sensor
bluetoothd[13319]: src/adapter.c:stop_discovery() sender :1.120
bluetoothd[13319]: src/adapter.c:discovery_destroy() owner :1.120
bluetoothd[13319]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[13319]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[13319]: src/adapter.c:stop_discovery_complete() status 0x00
bluetoothd[13319]: src/adapter.c:trigger_passive_scanning()=20
bluetoothd[13319]: src/adapter.c:discovering_callback() hci0 type 7
discovering 0 method 0
bluetoothd[13319]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[13319]: src/device.c:bonding_request_new() Requesting bonding =
for
12:34:50:12:34:52
bluetoothd[13319]: src/adapter.c:suspend_discovery()=20
bluetoothd[13319]: src/adapter.c:adapter_bonding_attempt() hci0 bdaddr
12:34:50:12:34:52 type 1 io_cap 0x03
bluetoothd[13319]: src/adapter.c:connected_callback() hci0 device
12:34:50:12:34:52 connected eir_len 0
bluetoothd[13319]: src/gatt-database.c:connect_cb() New incoming LE ATT
connection
bluetoothd[13319]: attrib/gattrib.c:g_attrib_ref() 0xbd51b0: =
g_attrib_ref=3D1=20
bluetoothd[13319]: src/gatt-client.c:btd_gatt_client_connected() Device
connected.
bluetoothd[13319]: src/device.c:load_gatt_db() Restoring =
12:34:50:12:34:52
gatt database from file
bluetoothd[13319]: No cache for 12:34:50:12:34:52
bluetoothd[13319]: src/adapter.c:adapter_connect_list_remove() device
/org/bluez/hci0/dev_12_34_50_12_34_52 is not on the list, ignoring
bluetoothd[13319]: src/device.c:gatt_debug() MTU exchange complete, with
MTU: 23
bluetoothd[13319]: src/adapter.c:new_irk_callback() hci0 new IRK for
12:34:50:12:34:52 RPA 00:00:00:00:00:00
bluetoothd[13319]: src/adapter.c:new_csrk_callback() hci0 new CSRK for
12:34:50:12:34:52 type 1
bluetoothd[13319]: src/adapter.c:new_csrk_callback() hci0 new CSRK for
12:34:50:12:34:52 type 0
bluetoothd[13319]: src/device.c:gatt_debug() Primary services found: 5
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0001, end: 0x0007,
uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0008, end: 0x0008,
uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0009, end: 0x0010,
uuid: 0000180d-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0011, end: 0x0017,
uuid: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0018, end: 0x001c,
uuid: 0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/adapter.c:new_long_term_key_callback() hci0 new =
LTK
for 12:34:50:12:34:52 type 0 enc_size 16
bluetoothd[13319]: src/device.c:device_set_bonded()=20
bluetoothd[13319]: src/device.c:device_bonding_complete() bonding =
0xbd0250
status 0x00
bluetoothd[13319]: src/device.c:device_bonding_complete() Proceeding =
with
service discovery
bluetoothd[13319]: src/adapter.c:resume_discovery()=20
bluetoothd[13319]: src/adapter.c:new_long_term_key_callback() hci0 new =
LTK
for 12:34:50:12:34:52 type 0 enc_size 16
bluetoothd[13319]: src/device.c:device_set_bonded()=20
bluetoothd[13319]: src/device.c:device_bonding_complete() bonding (nil)
status 0x00
bluetoothd[13319]: src/adapter.c:resume_discovery()=20
bluetoothd[13319]: src/adapter.c:pair_device_complete() Success (0x00)
bluetoothd[13319]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
12:34:50:12:34:52 type 1 status 0x0
bluetoothd[13319]: src/device.c:device_bonding_complete() bonding (nil)
status 0x00
bluetoothd[13319]: src/adapter.c:resume_discovery()=20
bluetoothd[13319]: src/device.c:gatt_debug() Secondary service discovery
failed. ATT ECODE: 0x0a
bluetoothd[13319]: src/device.c:gatt_debug() Characteristics found: 3
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0002, end: 0x0003,
value: 0x0003, props: 0x02, uuid: 00002a00-0000-1
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0004, end: 0x0005,
value: 0x0005, props: 0x02, uuid: 00002a01-0000-1
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0006, end: 0x0007,
value: 0x0007, props: 0x02, uuid: 00002a04-0000-1
bluetoothd[13319]: src/device.c:gatt_debug() Characteristics found: 3
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x000a, end: 0x000c,
value: 0x000b, props: 0x10, uuid: 00002a37-0000-1
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x000d, end: 0x000e,
value: 0x000e, props: 0x02, uuid: 00002a38-0000-1
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x000f, end: 0x0010,
value: 0x0010, props: 0x08, uuid: 00002a39-0000-1
bluetoothd[13319]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[13319]: src/device.c:gatt_debug() handle: 0x000c, uuid:
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:gatt_debug() Characteristics found: 3
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0012, end: 0x0013,
value: 0x0013, props: 0x02, uuid: 00002a29-0000-1
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0014, end: 0x0015,
value: 0x0015, props: 0x02, uuid: 00002a24-0000-1
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0016, end: 0x0017,
value: 0x0017, props: 0x02, uuid: 00002a27-0000-1
bluetoothd[13319]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[13319]: src/device.c:gatt_debug() start: 0x0019, end: 0x001c,
value: 0x001a, props: 0x12, uuid: 00002a19-0000-1
bluetoothd[13319]: src/device.c:gatt_debug() Descriptors found: 2
bluetoothd[13319]: src/device.c:gatt_debug() handle: 0x001b, uuid:
00002904-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:gatt_debug() handle: 0x001c, uuid:
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:gatt_client_ready_cb() status: success,
error: 0
bluetoothd[13319]: src/device.c:update_gatt_uuids() UUID Added:
00001800-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:update_gatt_uuids() UUID Added:
00001801-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:update_gatt_uuids() UUID Added:
0000180d-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:update_gatt_uuids() UUID Added:
0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:update_gatt_uuids() UUID Added:
0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[13319]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[13319]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[13319]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[13319]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[13319]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[13319]: src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_12_34_50_12_34_52 err 0
bluetoothd[13319]: src/gatt-client.c:btd_gatt_client_ready() GATT client
ready
bluetoothd[13319]: src/gatt-client.c:create_services() Exporting objects =
for
GATT services: 12:34:50:12:34:52
bluetoothd[13319]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001
bluetoothd[13319]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0002
bluetoothd[13319]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0004
bluetoothd[13319]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0006
bluetoothd[13319]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0008
bluetoothd[13319]: src/device.c:gatt_service_added() start: 0x0008, end:
0x0008
bluetoothd[13319]: Unable to register GATT service with handle 0x0008 =
for
device 12:34:50:12:34:52
bluetoothd[13319]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009
bluetoothd[13319]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a
bluetoothd[13319]: src/gatt-client.c:descriptor_create() Exported GATT
characteristic descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a/desc000c
bluetoothd[13319]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000d
bluetoothd[13319]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000f
bluetoothd[13319]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011
bluetoothd[13319]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0012
bluetoothd[13319]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0014
bluetoothd[13319]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0016
bluetoothd[13319]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018
bluetoothd[13319]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019
bluetoothd[13319]: src/gatt-client.c:descriptor_create() Exported GATT
characteristic descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001b
bluetoothd[13319]: src/gatt-client.c:descriptor_create() Exported GATT
characteristic descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001c
bluetoothd[13319]: src/gatt-client.c:notify_client_ref() owner :1.125
bluetoothd[13319]: src/gatt-client.c:notify_client_disconnect() owner =
:1.125
bluetoothd[13319]: src/gatt-client.c:notify_client_unref() owner :1.125
bluetoothd[13319]: src/gatt-client.c:notify_client_free() owner :1.125
bluetoothd[13319]: src/adapter.c:remove_temp_devices() /org/bluez/hci0
bluetoothd[13319]: src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_12_34_50_12_34_50
bluetoothd[13319]: src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_12_34_50_12_34_50
bluetoothd[13319]: src/device.c:device_free() 0xbcfec0





Bluetoothd Log (ver 5.38)=A0:

root@debian82:/home/dhoover# /share/bluez/libexec/bluetooth/bluetoothd =
-E -p
time -n -d
bluetoothd[1486]: Bluetooth daemon 5.38
bluetoothd[1486]: src/adapter.c:adapter_init() sending read version =
command
bluetoothd[1486]: Starting SDP server
bluetoothd[1486]: src/sdpd-service.c:register_device_id() Adding device =
id
record for 0002:1d6b:0246:0526
bluetoothd[1486]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[1486]: Ignoring (cli) hostname
bluetoothd[1486]: Ignoring (cli) wiimote
bluetoothd[1486]: Ignoring (cli) autopair
bluetoothd[1486]: Ignoring (cli) policy
bluetoothd[1486]: Ignoring (cli) gatt_example
bluetoothd[1486]: Ignoring (cli) neard
bluetoothd[1486]: Ignoring (cli) sap
bluetoothd[1486]: Ignoring (cli) a2dp
bluetoothd[1486]: Ignoring (cli) avrcp
bluetoothd[1486]: Ignoring (cli) network
bluetoothd[1486]: Ignoring (cli) input
bluetoothd[1486]: Ignoring (cli) hog
bluetoothd[1486]: Ignoring (cli) health
bluetoothd[1486]: Ignoring (cli) gap
bluetoothd[1486]: Ignoring (cli) scanparam
bluetoothd[1486]: Ignoring (cli) deviceinfo
bluetoothd[1486]: Ignoring (cli) alert
bluetoothd[1486]: src/plugin.c:add_plugin() Loading time plugin
bluetoothd[1486]: Ignoring (cli) proximity
bluetoothd[1486]: Ignoring (cli) thermometer
bluetoothd[1486]: Ignoring (cli) heartrate
bluetoothd[1486]: Ignoring (cli) cyclingspeed
bluetoothd[1486]: src/plugin.c:plugin_init() Loading plugins
/home/dhoover/git/bluez/bluez/plugins/.libs
bluetoothd[1486]: Ignoring (cli) external_dummy
bluetoothd[1486]: src/main.c:main() Entering main loop
bluetoothd[1486]: Bluetooth management interface 1.6 initialized
bluetoothd[1486]: src/adapter.c:read_version_complete() sending read
supported commands command
bluetoothd[1486]: src/adapter.c:read_version_complete() sending read =
index
list command
bluetoothd[1486]: src/adapter.c:read_commands_complete() Number of =
commands:
47
bluetoothd[1486]: src/adapter.c:read_commands_complete() Number of =
events:
23
bluetoothd[1486]: src/adapter.c:read_index_list_complete() Number of
controllers: 0

bluetoothd[1486]: src/rfkill.c:rfkill_event() RFKILL event idx 0 type 2 =
op 0
soft 0 hard 0
bluetoothd[1486]: src/adapter.c:index_added() index 0
bluetoothd[1486]: src/adapter.c:btd_adapter_new() System name: BlueZ =
5.38
bluetoothd[1486]: src/adapter.c:btd_adapter_new() Major class: 0
bluetoothd[1486]: src/adapter.c:btd_adapter_new() Minor class: 0
bluetoothd[1486]: src/adapter.c:btd_adapter_new() Modalias:
usb:v1D6Bp0246d0526
bluetoothd[1486]: src/adapter.c:btd_adapter_new() Discoverable timeout: =
180
seconds
bluetoothd[1486]: src/adapter.c:btd_adapter_new() Pairable timeout: 0
seconds
bluetoothd[1486]: src/adapter.c:index_added() sending read info command =
for
index 0
bluetoothd[1486]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[1486]: src/adapter.c:clear_uuids() sending clear uuids =
command
for index 0
bluetoothd[1486]: src/adapter.c:set_mode() sending set mode command for
index 0
bluetoothd[1486]: src/adapter.c:set_mode() sending set mode command for
index 0
bluetoothd[1486]: src/gatt-database.c:btd_gatt_database_new() GATT =
Manager
registered for adapter: /org/bluez/hci0
bluetoothd[1486]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Adding =
record
with handle 0x10001
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000007-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000100-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001002-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001800-0000-1000-8000-00805f9
bluetoothd[1486]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[1486]: src/adapter.c:add_uuid() sending add uuid command for
index 0
bluetoothd[1486]: src/gatt-database.c:gatt_db_service_added() GATT =
Service
added to local database
bluetoothd[1486]: Failed to obtain handles for "Service Changed"
characteristic
bluetoothd[1486]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Adding =
record
with handle 0x10002
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000007-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000100-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001002-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001801-0000-1000-8000-00805f9
bluetoothd[1486]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[1486]: src/adapter.c:add_uuid() sending add uuid command for
index 0
bluetoothd[1486]: src/gatt-database.c:gatt_db_service_added() GATT =
Service
added to local database
bluetoothd[1486]: src/advertising.c:btd_advertising_manager_new() LE
Advertising Manager created for adapter: /org/bluez/hci0
bluetoothd[1486]: profiles/time/server.c:time_server_init() path
/org/bluez/hci0
bluetoothd[1486]: Not enough free handles to register service
bluetoothd[1486]: Current Time Service could not be registered
bluetoothd[1486]: gatt-time-server: Input/output error (5)
bluetoothd[1486]: src/adapter.c:btd_adapter_unblock_address() hci0
00:00:00:00:00:00
bluetoothd[1486]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys =
0
bluetoothd[1486]: src/adapter.c:load_ltks() hci0 keys 0
bluetoothd[1486]: src/adapter.c:load_irks() hci0 irks 0
bluetoothd[1486]: src/adapter.c:load_conn_params() hci0 conn params 0
bluetoothd[1486]: src/adapter.c:load_connections() sending get =
connections
command for index 0
bluetoothd[1486]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[1486]: src/adapter.c:add_uuid() sending add uuid command for
index 0
bluetoothd[1486]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b =
product
246 version 526
bluetoothd[1486]: src/adapter.c:adapter_register() Adapter =
/org/bluez/hci0
registered
bluetoothd[1486]: src/adapter.c:set_dev_class() sending set device class
command for index 0
bluetoothd[1486]: src/adapter.c:set_name() sending set local name =
command
for index 0
bluetoothd[1486]: src/adapter.c:set_mode() sending set mode command for
index 0
bluetoothd[1486]: src/adapter.c:set_mode() sending set mode command for
index 0
bluetoothd[1486]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 =
has
been enabled
bluetoothd[1486]: Failed to read advertising features: Unknown Command
(0x01)
bluetoothd[1486]: src/adapter.c:new_settings_callback() Settings: =
0x000000c1
bluetoothd[1486]: src/adapter.c:settings_changed() Changed settings:
0x00000040
bluetoothd[1486]: src/adapter.c:new_settings_callback() Settings: =
0x000002c1
bluetoothd[1486]: src/adapter.c:settings_changed() Changed settings:
0x00000200
bluetoothd[1486]: src/adapter.c:trigger_passive_scanning()=20
bluetoothd[1486]: src/adapter.c:load_link_keys_complete() link keys =
loaded
for hci0
bluetoothd[1486]: src/adapter.c:load_ltks_complete() LTKs loaded for =
hci0
bluetoothd[1486]: src/adapter.c:load_irks_complete() IRKs loaded for =
hci0
bluetoothd[1486]: hci0 Load Connection Parameters failed: Unknown =
Command
(0x01)
bluetoothd[1486]: src/adapter.c:get_connections_complete() Connection =
count:
0
bluetoothd[1486]: src/adapter.c:local_name_changed_callback() Name: =
BlueZ
5.38
bluetoothd[1486]: src/adapter.c:local_name_changed_callback() Short =
name:=20
bluetoothd[1486]: src/adapter.c:local_name_changed_callback() Current =
alias:
BlueZ 5.38
bluetoothd[1486]: src/adapter.c:new_settings_callback() Settings: =
0x000002d1
bluetoothd[1486]: src/adapter.c:settings_changed() Changed settings:
0x00000010
bluetoothd[1486]: src/adapter.c:new_settings_callback() Settings: =
0x000002d3
bluetoothd[1486]: src/adapter.c:settings_changed() Changed settings:
0x00000002

bluetoothd[1486]: src/adapter.c:start_discovery() sender :1.66
bluetoothd[1486]: src/adapter.c:update_discovery_filter()=20
bluetoothd[1486]: src/adapter.c:discovery_filter_to_mgmt_cp()=20
bluetoothd[1486]: src/adapter.c:trigger_start_discovery()=20
bluetoothd[1486]: src/adapter.c:cancel_passive_scanning()=20
bluetoothd[1486]: src/adapter.c:start_discovery_timeout()=20
bluetoothd[1486]: src/adapter.c:start_discovery_timeout()
adapter->current_discovery_filter =3D=3D 0
bluetoothd[1486]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[1486]: src/adapter.c:discovering_callback() hci0 type 7
discovering 1 method 0
bluetoothd[1486]: src/adapter.c:device_found_callback() hci0 addr
12:34:50:12:34:52, rssi -42 flags 0x0000 eir_len 51
bluetoothd[1486]: src/device.c:device_create() dst 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_new() address 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_12_34_50_12_34_52
bluetoothd[1486]: src/device.c:device_set_legacy() legacy 0
bluetoothd[1486]: src/device.c:device_set_rssi_with_delta() rssi -42
bluetoothd[1486]: src/device.c:btd_device_device_set_name()
/org/bluez/hci0/dev_12_34_50_12_34_52 Heart Rate Sensor
bluetoothd[1486]: src/adapter.c:device_found_callback() hci0 addr
12:34:50:12:34:52, rssi -42 flags 0x0000 eir_len 51
bluetoothd[1486]: src/device.c:device_set_legacy() legacy 0
bluetoothd[1486]: src/adapter.c:stop_discovery() sender :1.66
bluetoothd[1486]: src/adapter.c:discovery_destroy() owner :1.66
bluetoothd[1486]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[1486]: src/adapter.c:stop_discovery_complete() status 0x00
bluetoothd[1486]: src/adapter.c:trigger_passive_scanning()=20
bluetoothd[1486]: src/adapter.c:discovering_callback() hci0 type 7
discovering 0 method 0
bluetoothd[1486]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[1486]: src/device.c:bonding_request_new() Requesting bonding =
for
12:34:50:12:34:52
bluetoothd[1486]: src/adapter.c:suspend_discovery()=20
bluetoothd[1486]: src/adapter.c:adapter_bonding_attempt() hci0 bdaddr
12:34:50:12:34:52 type 1 io_cap 0x03
bluetoothd[1486]: src/adapter.c:connected_callback() hci0 device
12:34:50:12:34:52 connected eir_len 0
bluetoothd[1486]: src/gatt-database.c:connect_cb() New incoming LE ATT
connection
bluetoothd[1486]: attrib/gattrib.c:g_attrib_ref() 0x19a8ec0: =
g_attrib_ref=3D1=20
bluetoothd[1486]: src/gatt-client.c:btd_gatt_client_connected() Device
connected.
bluetoothd[1486]: src/device.c:load_gatt_db() Restoring =
12:34:50:12:34:52
gatt database from file
bluetoothd[1486]: No cache for 12:34:50:12:34:52
bluetoothd[1486]: src/adapter.c:adapter_connect_list_remove() device
/org/bluez/hci0/dev_12_34_50_12_34_52 is not on the list, ignoring
bluetoothd[1486]: src/device.c:gatt_debug() MTU exchange complete, with =
MTU:
23
bluetoothd[1486]: src/adapter.c:new_irk_callback() hci0 new IRK for
12:34:50:12:34:52 RPA 00:00:00:00:00:00
bluetoothd[1486]: src/adapter.c:new_csrk_callback() hci0 new CSRK for
12:34:50:12:34:52 type 1
bluetoothd[1486]: src/adapter.c:new_csrk_callback() hci0 new CSRK for
12:34:50:12:34:52 type 0
bluetoothd[1486]: src/adapter.c:new_long_term_key_callback() hci0 new =
LTK
for 12:34:50:12:34:52 type 0 enc_size 16
bluetoothd[1486]: src/device.c:device_set_bonded()=20
bluetoothd[1486]: src/device.c:device_bonding_complete() bonding =
0x19acce0
status 0x00
bluetoothd[1486]: src/device.c:device_bonding_complete() Proceeding with
service discovery
bluetoothd[1486]: src/adapter.c:resume_discovery()=20
bluetoothd[1486]: src/adapter.c:new_long_term_key_callback() hci0 new =
LTK
for 12:34:50:12:34:52 type 0 enc_size 16
bluetoothd[1486]: src/device.c:device_set_bonded()=20
bluetoothd[1486]: src/device.c:device_bonding_complete() bonding (nil)
status 0x00
bluetoothd[1486]: src/adapter.c:resume_discovery()=20
bluetoothd[1486]: src/adapter.c:pair_device_complete() Success (0x00)
bluetoothd[1486]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
12:34:50:12:34:52 type 1 status 0x0
bluetoothd[1486]: src/device.c:device_bonding_complete() bonding (nil)
status 0x00
bluetoothd[1486]: src/adapter.c:resume_discovery()=20
bluetoothd[1486]: src/device.c:gatt_debug() Primary services found: 5
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0001, end: 0x0007,
uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0008, end: 0x0008,
uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0009, end: 0x0010,
uuid: 0000180d-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0011, end: 0x0017,
uuid: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0018, end: 0x001c,
uuid: 0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() Secondary service discovery
failed. ATT ECODE: 0x0a
bluetoothd[1486]: src/device.c:gatt_debug() Characteristics found: 3
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0002, end: 0x0003,
value: 0x0003, props: 0x02, uuid: 00002a00-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0004, end: 0x0005,
value: 0x0005, props: 0x02, uuid: 00002a01-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0006, end: 0x0007,
value: 0x0007, props: 0x02, uuid: 00002a04-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() Characteristics found: 3
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x000a, end: 0x000c,
value: 0x000b, props: 0x10, uuid: 00002a37-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x000d, end: 0x000e,
value: 0x000e, props: 0x02, uuid: 00002a38-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x000f, end: 0x0010,
value: 0x0010, props: 0x08, uuid: 00002a39-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[1486]: src/device.c:gatt_debug() handle: 0x000c, uuid:
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() Characteristics found: 3
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0012, end: 0x0013,
value: 0x0013, props: 0x02, uuid: 00002a29-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0014, end: 0x0015,
value: 0x0015, props: 0x02, uuid: 00002a24-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0016, end: 0x0017,
value: 0x0017, props: 0x02, uuid: 00002a27-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0019, end: 0x001c,
value: 0x001a, props: 0x12, uuid: 00002a19-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() Descriptors found: 2
bluetoothd[1486]: src/device.c:gatt_debug() handle: 0x001b, uuid:
00002904-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() handle: 0x001c, uuid:
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_client_ready_cb() status: success,
error: 0
bluetoothd[1486]: src/device.c:update_gatt_uuids() UUID Added:
00001800-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:update_gatt_uuids() UUID Added:
00001801-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:update_gatt_uuids() UUID Added:
0000180d-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:update_gatt_uuids() UUID Added:
0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:update_gatt_uuids() UUID Added:
0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[1486]: src/gatt-client.c:btd_gatt_client_ready() GATT client
ready
bluetoothd[1486]: src/gatt-client.c:create_services() Exporting objects =
for
GATT services: 12:34:50:12:34:52
bluetoothd[1486]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0002
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0004
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0006
bluetoothd[1486]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0008
bluetoothd[1486]: src/device.c:gatt_service_added() start: 0x0008, end:
0x0008
bluetoothd[1486]: Unable to register GATT service with handle 0x0008 for
device 12:34:50:12:34:52
bluetoothd[1486]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a
bluetoothd[1486]: src/gatt-client.c:descriptor_create() Exported GATT
characteristic descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a/desc000c
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000d
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000f
bluetoothd[1486]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0012
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0014
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0016
bluetoothd[1486]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019
bluetoothd[1486]: src/gatt-client.c:descriptor_create() Exported GATT
characteristic descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001b
bluetoothd[1486]: src/gatt-client.c:descriptor_create() Exported GATT
characteristic descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001c
bluetoothd[1486]: src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_12_34_50_12_34_52 err 0
bluetoothd[1486]: src/adapter.c:remove_temp_devices() /org/bluez/hci0
bluetoothd[1486]: src/adapter.c:dev_disconnected() Device =
12:34:50:12:34:52
disconnected, reason 2
bluetoothd[1486]: src/adapter.c:adapter_remove_connection()=20
bluetoothd[1486]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
12:34:50:12:34:52 type 1 status 0xe
bluetoothd[1486]: src/device.c:device_bonding_complete() bonding (nil)
status 0x0e
bluetoothd[1486]: src/device.c:device_bonding_failed() status 14
bluetoothd[1486]: src/adapter.c:resume_discovery()=20
bluetoothd[1486]: src/device.c:att_disconnected_cb()=20
bluetoothd[1486]: src/device.c:att_disconnected_cb() Software caused
connection abort (103)
bluetoothd[1486]: src/gatt-client.c:btd_gatt_client_disconnected() =
Device
disconnected. Cleaning up.
bluetoothd[1486]: src/device.c:att_disconnected_cb() Automatic =
connection
disabled
bluetoothd[1486]: attrib/gattrib.c:g_attrib_unref() 0x19a8ec0:
g_attrib_unref=3D0=20
bluetoothd[1486]: src/device.c:device_connect_le() Connection attempt =
to:
12:34:50:12:34:52
bluetoothd[1486]: src/adapter.c:connected_callback() hci0 device
12:34:50:12:34:52 connected eir_len 0
bluetoothd[1486]: attrib/gattrib.c:g_attrib_ref() 0x19aaad0: =
g_attrib_ref=3D1=20
bluetoothd[1486]: src/gatt-client.c:btd_gatt_client_connected() Device
connected.
bluetoothd[1486]: src/adapter.c:adapter_connect_list_remove() device
/org/bluez/hci0/dev_12_34_50_12_34_52 is not on the list, ignoring
bluetoothd[1486]: src/device.c:gatt_debug() MTU exchange complete, with =
MTU:
23
bluetoothd[1486]: src/device.c:gatt_debug() Primary services found: 5
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0001, end: 0x0007,
uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0008, end: 0x0008,
uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0009, end: 0x0010,
uuid: 0000180d-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0011, end: 0x0017,
uuid: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0018, end: 0x001c,
uuid: 0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_client_ready_cb() status: success,
error: 10
bluetoothd[1486]: src/gatt-client.c:btd_gatt_client_ready() GATT client
ready
bluetoothd[1486]: src/gatt-client.c:create_services() Exporting objects =
for
GATT services: 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_12_34_50_12_34_52 err 0

bluetoothd[1486]: src/adapter.c:new_settings_callback() Settings: =
0x000002d2
bluetoothd[1486]: src/adapter.c:settings_changed() Changed settings:
0x00000001
bluetoothd[1486]: src/adapter.c:cancel_passive_scanning()=20
bluetoothd[1486]: src/adapter.c:adapter_remove_connection()=20
bluetoothd[1486]: src/adapter.c:adapter_remove_connection()=20
bluetoothd[1486]: src/adapter.c:adapter_stop() adapter /org/bluez/hci0 =
has
been disabled
bluetoothd[1486]: src/rfkill.c:rfkill_event() RFKILL event idx 0 type 2 =
op 1
soft 0 hard 0
bluetoothd[1486]: src/device.c:att_disconnected_cb()=20
bluetoothd[1486]: src/device.c:att_disconnected_cb() Software caused
connection abort (103)
bluetoothd[1486]: src/gatt-client.c:btd_gatt_client_disconnected() =
Device
disconnected. Cleaning up.
bluetoothd[1486]: src/device.c:att_disconnected_cb() Automatic =
connection
disabled
bluetoothd[1486]: attrib/gattrib.c:g_attrib_unref() 0x19aaad0:
g_attrib_unref=3D0=20
bluetoothd[1486]: src/adapter.c:index_removed() index 0
bluetoothd[1486]: src/adapter.c:adapter_unregister() Unregister path:
/org/bluez/hci0
bluetoothd[1486]: src/adapter.c:adapter_remove() Removing adapter
/org/bluez/hci0
bluetoothd[1486]: src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_12_34_50_12_34_52
bluetoothd[1486]: src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_12_34_50_12_34_52
bluetoothd[1486]: src/gatt-client.c:unregister_service() Removing GATT
service: /org/bluez/hci0/dev_12_34_50_12_34_52/service0001
bluetoothd[1486]: src/gatt-client.c:unregister_characteristic() Removing
GATT characteristic:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0002
bluetoothd[1486]: src/gatt-client.c:unregister_characteristic() Removing
GATT characteristic:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0004
bluetoothd[1486]: src/gatt-client.c:unregister_characteristic() Removing
GATT characteristic:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0006
bluetoothd[1486]: src/gatt-client.c:unregister_service() Removing GATT
service: /org/bluez/hci0/dev_12_34_50_12_34_52/service0008
bluetoothd[1486]: src/gatt-client.c:unregister_service() Removing GATT
service: /org/bluez/hci0/dev_12_34_50_12_34_52/service0009
bluetoothd[1486]: src/gatt-client.c:unregister_characteristic() Removing
GATT characteristic:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a
bluetoothd[1486]: src/gatt-client.c:unregister_descriptor() Removing =
GATT
descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a/desc000c
bluetoothd[1486]: src/gatt-client.c:unregister_characteristic() Removing
GATT characteristic:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000d
bluetoothd[1486]: src/gatt-client.c:unregister_characteristic() Removing
GATT characteristic:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000f
bluetoothd[1486]: src/gatt-client.c:unregister_service() Removing GATT
service: /org/bluez/hci0/dev_12_34_50_12_34_52/service0011
bluetoothd[1486]: src/gatt-client.c:unregister_characteristic() Removing
GATT characteristic:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0012
bluetoothd[1486]: src/gatt-client.c:unregister_characteristic() Removing
GATT characteristic:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0014
bluetoothd[1486]: src/gatt-client.c:unregister_characteristic() Removing
GATT characteristic:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0016
bluetoothd[1486]: src/gatt-client.c:unregister_service() Removing GATT
service: /org/bluez/hci0/dev_12_34_50_12_34_52/service0018
bluetoothd[1486]: src/gatt-client.c:unregister_characteristic() Removing
GATT characteristic:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019
bluetoothd[1486]: src/gatt-client.c:unregister_descriptor() Removing =
GATT
descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001b
bluetoothd[1486]: src/gatt-client.c:unregister_descriptor() Removing =
GATT
descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001c
bluetoothd[1486]: src/device.c:device_free() 0x19a7d80
bluetoothd[1486]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
bluetoothd[1486]: src/adapter.c:remove_uuid() sending remove uuid =
command
for index 0
bluetoothd[1486]: src/sdpd-service.c:remove_record_from_server() =
Removing
record with handle 0x10002
bluetoothd[1486]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
bluetoothd[1486]: src/adapter.c:remove_uuid() sending remove uuid =
command
for index 0
bluetoothd[1486]: src/sdpd-service.c:remove_record_from_server() =
Removing
record with handle 0x10001
bluetoothd[1486]: src/adapter.c:btd_adapter_unref() Freeing adapter
/org/bluez/hci0
bluetoothd[1486]: src/adapter.c:adapter_free() 0x19acac0

bluetoothd[1486]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type 2 =
op 0
soft 0 hard 0
bluetoothd[1486]: src/adapter.c:index_added() index 0
bluetoothd[1486]: src/adapter.c:btd_adapter_new() System name: BlueZ =
5.38
bluetoothd[1486]: src/adapter.c:btd_adapter_new() Major class: 0
bluetoothd[1486]: src/adapter.c:btd_adapter_new() Minor class: 0
bluetoothd[1486]: src/adapter.c:btd_adapter_new() Modalias:
usb:v1D6Bp0246d0526
bluetoothd[1486]: src/adapter.c:btd_adapter_new() Discoverable timeout: =
180
seconds
bluetoothd[1486]: src/adapter.c:btd_adapter_new() Pairable timeout: 0
seconds
bluetoothd[1486]: src/adapter.c:index_added() sending read info command =
for
index 0
bluetoothd[1486]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[1486]: src/adapter.c:clear_uuids() sending clear uuids =
command
for index 0
bluetoothd[1486]: src/adapter.c:set_mode() sending set mode command for
index 0
bluetoothd[1486]: src/adapter.c:set_mode() sending set mode command for
index 0
bluetoothd[1486]: src/gatt-database.c:btd_gatt_database_new() GATT =
Manager
registered for adapter: /org/bluez/hci0
bluetoothd[1486]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Adding =
record
with handle 0x10001
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000007-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000100-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001002-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001800-0000-1000-8000-00805f9
bluetoothd[1486]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[1486]: src/adapter.c:add_uuid() sending add uuid command for
index 0
bluetoothd[1486]: src/gatt-database.c:gatt_db_service_added() GATT =
Service
added to local database
bluetoothd[1486]: Failed to obtain handles for "Service Changed"
characteristic
bluetoothd[1486]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Adding =
record
with handle 0x10002
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000007-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00000100-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001002-0000-1000-8000-00805f9
bluetoothd[1486]: src/sdpd-service.c:add_record_to_server() Record =
pattern
UUID 00001801-0000-1000-8000-00805f9
bluetoothd[1486]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[1486]: src/adapter.c:add_uuid() sending add uuid command for
index 0
bluetoothd[1486]: src/gatt-database.c:gatt_db_service_added() GATT =
Service
added to local database
bluetoothd[1486]: src/advertising.c:btd_advertising_manager_new() LE
Advertising Manager created for adapter: /org/bluez/hci0
bluetoothd[1486]: profiles/time/server.c:time_server_init() path
/org/bluez/hci0
bluetoothd[1486]: Not enough free handles to register service
bluetoothd[1486]: Current Time Service could not be registered
bluetoothd[1486]: gatt-time-server: Input/output error (5)
bluetoothd[1486]: src/adapter.c:btd_adapter_unblock_address() hci0
00:00:00:00:00:00
bluetoothd[1486]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys =
0
bluetoothd[1486]: src/adapter.c:load_ltks() hci0 keys 0
bluetoothd[1486]: src/adapter.c:load_irks() hci0 irks 0
bluetoothd[1486]: src/adapter.c:load_conn_params() hci0 conn params 0
bluetoothd[1486]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[1486]: src/adapter.c:add_uuid() sending add uuid command for
index 0
bluetoothd[1486]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b =
product
246 version 526
bluetoothd[1486]: src/adapter.c:adapter_register() Adapter =
/org/bluez/hci0
registered
bluetoothd[1486]: src/adapter.c:set_dev_class() sending set device class
command for index 0
bluetoothd[1486]: src/adapter.c:set_name() sending set local name =
command
for index 0
bluetoothd[1486]: src/adapter.c:set_mode() sending set mode command for
index 0
bluetoothd[1486]: src/adapter.c:set_mode() sending set mode command for
index 0
bluetoothd[1486]: Failed to read advertising features: Unknown Command
(0x01)
bluetoothd[1486]: src/adapter.c:new_settings_callback() Settings: =
0x000000c0
bluetoothd[1486]: src/adapter.c:settings_changed() Changed settings:
0x00000040
bluetoothd[1486]: src/adapter.c:new_settings_callback() Settings: =
0x000002c0
bluetoothd[1486]: src/adapter.c:settings_changed() Changed settings:
0x00000200
bluetoothd[1486]: src/adapter.c:load_link_keys_complete() link keys =
loaded
for hci0
bluetoothd[1486]: src/adapter.c:load_ltks_complete() LTKs loaded for =
hci0
bluetoothd[1486]: src/adapter.c:load_irks_complete() IRKs loaded for =
hci0
bluetoothd[1486]: hci0 Load Connection Parameters failed: Unknown =
Command
(0x01)
bluetoothd[1486]: src/adapter.c:local_name_changed_callback() Name: =
BlueZ
5.38
bluetoothd[1486]: src/adapter.c:local_name_changed_callback() Short =
name:=20
bluetoothd[1486]: src/adapter.c:local_name_changed_callback() Current =
alias:
BlueZ 5.38
bluetoothd[1486]: src/adapter.c:new_settings_callback() Settings: =
0x000002d0
bluetoothd[1486]: src/adapter.c:settings_changed() Changed settings:
0x00000010
bluetoothd[1486]: src/adapter.c:new_settings_callback() Settings: =
0x000002d2
bluetoothd[1486]: src/adapter.c:settings_changed() Changed settings:
0x00000002
bluetoothd[1486]: src/adapter.c:property_set_mode() sending Set Powered
command for index 0
bluetoothd[1486]: src/adapter.c:property_set_mode_complete() Success =
(0x00)
bluetoothd[1486]: src/adapter.c:new_settings_callback() Settings: =
0x000002d3
bluetoothd[1486]: src/adapter.c:settings_changed() Changed settings:
0x00000001
bluetoothd[1486]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 =
has
been enabled
bluetoothd[1486]: src/adapter.c:trigger_passive_scanning()=20

bluetoothd[1486]: src/adapter.c:start_discovery() sender :1.110
bluetoothd[1486]: src/adapter.c:update_discovery_filter()=20
bluetoothd[1486]: src/adapter.c:discovery_filter_to_mgmt_cp()=20
bluetoothd[1486]: src/adapter.c:trigger_start_discovery()=20
bluetoothd[1486]: src/adapter.c:cancel_passive_scanning()=20
bluetoothd[1486]: src/adapter.c:start_discovery_timeout()=20
bluetoothd[1486]: src/adapter.c:start_discovery_timeout()
adapter->current_discovery_filter =3D=3D 0
bluetoothd[1486]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[1486]: src/adapter.c:discovering_callback() hci0 type 7
discovering 1 method 0
bluetoothd[1486]: src/adapter.c:device_found_callback() hci0 addr
D0:33:11:3A:D4:71, rssi -96 flags 0x0000 eir_len 3
bluetoothd[1486]: src/device.c:device_create() dst D0:33:11:3A:D4:71
bluetoothd[1486]: src/device.c:device_new() address D0:33:11:3A:D4:71
bluetoothd[1486]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_D0_33_11_3A_D4_71
bluetoothd[1486]: src/device.c:device_set_legacy() legacy 0
bluetoothd[1486]: src/device.c:device_set_rssi_with_delta() rssi -96
bluetoothd[1486]: src/adapter.c:device_found_callback() hci0 addr
0C:F3:EE:AA:41:AE, rssi -76 flags 0x0000 eir_len 0
bluetoothd[1486]: src/adapter.c:device_found_callback() hci0 addr
EE:34:56:78:9A:BC, rssi -81 flags 0x0000 eir_len 14
bluetoothd[1486]: src/device.c:device_create() dst EE:34:56:78:9A:BC
bluetoothd[1486]: src/device.c:device_new() address EE:34:56:78:9A:BC
bluetoothd[1486]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_EE_34_56_78_9A_BC
bluetoothd[1486]: src/device.c:device_set_legacy() legacy 0
bluetoothd[1486]: src/device.c:device_set_rssi_with_delta() rssi -81
bluetoothd[1486]: src/device.c:btd_device_device_set_name()
/org/bluez/hci0/dev_EE_34_56_78_9A_BC =1E%=20
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A06 l
bluetoothd[1486]: src/adapter.c:device_found_callback() hci0 addr
D0:33:11:3A:D4:71, rssi -96 flags 0x0000 eir_len 0
bluetoothd[1486]: src/device.c:device_set_legacy() legacy 0
bluetoothd[1486]: src/adapter.c:device_found_callback() hci0 addr
12:34:50:12:34:52, rssi -61 flags 0x0000 eir_len 51
bluetoothd[1486]: src/device.c:device_create() dst 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_new() address 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_new() Creating device
/org/bluez/hci0/dev_12_34_50_12_34_52
bluetoothd[1486]: src/device.c:device_set_legacy() legacy 0
bluetoothd[1486]: src/device.c:device_set_rssi_with_delta() rssi -61
bluetoothd[1486]: src/device.c:btd_device_device_set_name()
/org/bluez/hci0/dev_12_34_50_12_34_52 Heart Rate Sensor
bluetoothd[1486]: src/adapter.c:stop_discovery() sender :1.110
bluetoothd[1486]: src/adapter.c:discovery_destroy() owner :1.110
bluetoothd[1486]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[1486]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[1486]: src/device.c:device_set_rssi_with_delta() rssi 0
bluetoothd[1486]: src/adapter.c:stop_discovery_complete() status 0x00
bluetoothd[1486]: src/adapter.c:trigger_passive_scanning()=20
bluetoothd[1486]: src/adapter.c:discovering_callback() hci0 type 7
discovering 0 method 0
bluetoothd[1486]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[1486]: src/device.c:bonding_request_new() Requesting bonding =
for
12:34:50:12:34:52
bluetoothd[1486]: src/adapter.c:suspend_discovery()=20
bluetoothd[1486]: src/adapter.c:adapter_bonding_attempt() hci0 bdaddr
12:34:50:12:34:52 type 1 io_cap 0x03
bluetoothd[1486]: src/adapter.c:connected_callback() hci0 device
12:34:50:12:34:52 connected eir_len 0
bluetoothd[1486]: src/gatt-database.c:connect_cb() New incoming LE ATT
connection
bluetoothd[1486]: attrib/gattrib.c:g_attrib_ref() 0x19a52b0: =
g_attrib_ref=3D1=20
bluetoothd[1486]: src/gatt-client.c:btd_gatt_client_connected() Device
connected.
bluetoothd[1486]: src/device.c:load_gatt_db() Restoring =
12:34:50:12:34:52
gatt database from file
bluetoothd[1486]: No cache for 12:34:50:12:34:52
bluetoothd[1486]: src/adapter.c:adapter_connect_list_remove() device
/org/bluez/hci0/dev_12_34_50_12_34_52 is not on the list, ignoring
bluetoothd[1486]: src/device.c:gatt_debug() MTU exchange complete, with =
MTU:
23
bluetoothd[1486]: src/adapter.c:new_irk_callback() hci0 new IRK for
12:34:50:12:34:52 RPA 00:00:00:00:00:00
bluetoothd[1486]: src/adapter.c:new_csrk_callback() hci0 new CSRK for
12:34:50:12:34:52 type 1
bluetoothd[1486]: src/adapter.c:new_csrk_callback() hci0 new CSRK for
12:34:50:12:34:52 type 0
bluetoothd[1486]: src/device.c:gatt_debug() Primary services found: 5
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0001, end: 0x0007,
uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0008, end: 0x0008,
uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0009, end: 0x0010,
uuid: 0000180d-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0011, end: 0x0017,
uuid: 0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0018, end: 0x001c,
uuid: 0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/adapter.c:new_long_term_key_callback() hci0 new =
LTK
for 12:34:50:12:34:52 type 0 enc_size 16
bluetoothd[1486]: src/device.c:device_set_bonded()=20
bluetoothd[1486]: src/device.c:device_bonding_complete() bonding =
0x19aa7c0
status 0x00
bluetoothd[1486]: src/device.c:device_bonding_complete() Proceeding with
service discovery
bluetoothd[1486]: src/adapter.c:resume_discovery()=20
bluetoothd[1486]: src/adapter.c:new_long_term_key_callback() hci0 new =
LTK
for 12:34:50:12:34:52 type 0 enc_size 16
bluetoothd[1486]: src/device.c:device_set_bonded()=20
bluetoothd[1486]: src/device.c:device_bonding_complete() bonding (nil)
status 0x00
bluetoothd[1486]: src/adapter.c:resume_discovery()=20
bluetoothd[1486]: src/adapter.c:pair_device_complete() Success (0x00)
bluetoothd[1486]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr
12:34:50:12:34:52 type 1 status 0x0
bluetoothd[1486]: src/device.c:device_bonding_complete() bonding (nil)
status 0x00
bluetoothd[1486]: src/adapter.c:resume_discovery()=20
bluetoothd[1486]: src/device.c:gatt_debug() Secondary service discovery
failed. ATT ECODE: 0x0a
bluetoothd[1486]: src/device.c:gatt_debug() Characteristics found: 3
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0002, end: 0x0003,
value: 0x0003, props: 0x02, uuid: 00002a00-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0004, end: 0x0005,
value: 0x0005, props: 0x02, uuid: 00002a01-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0006, end: 0x0007,
value: 0x0007, props: 0x02, uuid: 00002a04-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() Characteristics found: 3
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x000a, end: 0x000c,
value: 0x000b, props: 0x10, uuid: 00002a37-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x000d, end: 0x000e,
value: 0x000e, props: 0x02, uuid: 00002a38-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x000f, end: 0x0010,
value: 0x0010, props: 0x08, uuid: 00002a39-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[1486]: src/device.c:gatt_debug() handle: 0x000c, uuid:
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() Characteristics found: 3
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0012, end: 0x0013,
value: 0x0013, props: 0x02, uuid: 00002a29-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0014, end: 0x0015,
value: 0x0015, props: 0x02, uuid: 00002a24-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0016, end: 0x0017,
value: 0x0017, props: 0x02, uuid: 00002a27-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[1486]: src/device.c:gatt_debug() start: 0x0019, end: 0x001c,
value: 0x001a, props: 0x12, uuid: 00002a19-0000-1
bluetoothd[1486]: src/device.c:gatt_debug() Descriptors found: 2
bluetoothd[1486]: src/device.c:gatt_debug() handle: 0x001b, uuid:
00002904-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_debug() handle: 0x001c, uuid:
00002902-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:gatt_client_ready_cb() status: success,
error: 0
bluetoothd[1486]: src/device.c:update_gatt_uuids() UUID Added:
00001800-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:update_gatt_uuids() UUID Added:
00001801-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:update_gatt_uuids() UUID Added:
0000180d-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:update_gatt_uuids() UUID Added:
0000180a-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:update_gatt_uuids() UUID Added:
0000180f-0000-1000-8000-00805f9b34fb
bluetoothd[1486]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[1486]: src/device.c:device_probe_profiles() Probing profiles =
for
device 12:34:50:12:34:52
bluetoothd[1486]: src/gatt-client.c:btd_gatt_client_ready() GATT client
ready
bluetoothd[1486]: src/gatt-client.c:create_services() Exporting objects =
for
GATT services: 12:34:50:12:34:52
bluetoothd[1486]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0002
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0004
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0001/char0006
bluetoothd[1486]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0008
bluetoothd[1486]: src/device.c:gatt_service_added() start: 0x0008, end:
0x0008
bluetoothd[1486]: Unable to register GATT service with handle 0x0008 for
device 12:34:50:12:34:52
bluetoothd[1486]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a
bluetoothd[1486]: src/gatt-client.c:descriptor_create() Exported GATT
characteristic descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000a/desc000c
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000d
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0009/char000f
bluetoothd[1486]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0012
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0014
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0011/char0016
bluetoothd[1486]: src/gatt-client.c:service_create() Exported GATT =
service:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018
bluetoothd[1486]: src/gatt-client.c:characteristic_create() Exported =
GATT
characteristic: =
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019
bluetoothd[1486]: src/gatt-client.c:descriptor_create() Exported GATT
characteristic descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001b
bluetoothd[1486]: src/gatt-client.c:descriptor_create() Exported GATT
characteristic descriptor:
/org/bluez/hci0/dev_12_34_50_12_34_52/service0018/char0019/desc001c
bluetoothd[1486]: src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_12_34_50_12_34_52 err 0

bluetoothd[1486]: src/adapter.c:remove_temp_devices() /org/bluez/hci0
bluetoothd[1486]: src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_D0_33_11_3A_D4_71
bluetoothd[1486]: src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_D0_33_11_3A_D4_71
bluetoothd[1486]: src/device.c:device_free() 0x19a8980
bluetoothd[1486]: src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_EE_34_56_78_9A_BC
bluetoothd[1486]: src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_EE_34_56_78_9A_BC
bluetoothd[1486]: src/device.c:device_free() 0x19a9c10


------=_NextPart_000_0022_01D1842E.B4DDC590
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIW5DCCA30w
ggJloAMCAQICEHFQdGLvEiS+QeWHXkeOL9gwDQYJKoZIhvcNAQEFBQAwUTETMBEGCgmSJomT8ixk
ARkWA25ldDEbMBkGCgmSJomT8ixkARkWC3N3YXRjaGdyb3VwMR0wGwYDVQQDExRTd2F0Y2ggR3Jv
dXAgUm9vdCBDQTAeFw0wNTA0MTgxMjAzNDZaFw0yNTA0MTgxMjExMTRaMFExEzARBgoJkiaJk/Is
ZAEZFgNuZXQxGzAZBgoJkiaJk/IsZAEZFgtzd2F0Y2hncm91cDEdMBsGA1UEAxMUU3dhdGNoIEdy
b3VwIFJvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDFkKTa9trrjTEPfndk
Fxy3XULhkXAug4PCvjJLVbgifX33vyJsUrsYZ1InVuzEvM2/rMGQnqCaleOVg6N2sL1yPiiCsIKw
2YtRzU83fHtYUM2cAXvl6u7KDZFkleXsWuSyhABCqPx9/mk9EtkI6pak7dlZ1M5Cc8uqMl4Sxdxu
yxnMct5dr4UljAu8gmHZVY24y8P/HxM08YCHKzBIMqBpsVLXIKKlqSLf076Jz+VvidWqDxKJXNkz
kfH/L9f+/7wf7NQWnAqmwRx50UFBZmaaE8sN8REHZLak2dgYhIGpZXMoIYQVQmUNgpHe+kIA0miK
2+1D2pJ0h+iCNLsVZHKBAgMBAAGjUTBPMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB0G
A1UdDgQWBBShDgXedqA+Va8OdVIhYmyLArWzqjAQBgkrBgEEAYI3FQEEAwIBADANBgkqhkiG9w0B
AQUFAAOCAQEAWohULK5YuoDwMYyzZRe8HsuanLgUjYeG1nOCBEpqidhKjt0EP67XcnxPny7h1ZS4
eEUmXPoHorrUr6Jgdt0Ex5+K0USlPIQK6/OfqbmiDy8wVsCBha1wEzClpC7YDVJIXTGrEH0Il8k2
wNPobh7mfiH50WljF1B0i36XwyLEUKZRwV4RLHliUrj7hfOXYhxnQkBoMG1zJKC+fHV5pOIli+++
x8437mu4KQtLDdoHuCt88QDZ0NtddLWAruDKU6EeKh6I5szNi8j1ciLhHxLfbxB6GQ7jHF2RR7hw
S6q6dU+mHNwMj61VpvmB+8Ual6kQgxdOhEnVLPFx2q6CzJoxtzCCBeUwggVOoAMCAQICChZdSHUA
AgBBIw4wDQYJKoZIhvcNAQEFBQAwVDETMBEGCgmSJomT8ixkARkWA25ldDEbMBkGCgmSJomT8ixk
ARkWC3N3YXRjaGdyb3VwMSAwHgYDVQQDExdTd2F0Y2ggR3JvdXAgSXNzdWluZyBDQTAeFw0xNTA4
MjQwNjU4MDlaFw0xNjA4MjMwNjU4MDlaMBgxFjAUBgNVBAMTDUhvb3ZlciwgRGF2aWQwgZ8wDQYJ
KoZIhvcNAQEBBQADgY0AMIGJAoGBALa8n9kxBV3JC+yMr3qo3zAJUj/gu7iGaiJKYvLFlQGYxlVO
XkZDyBCOAJEi6v6v7aD1o59bxXfw+f1A3JUa6Kocp528FX4s3NAthn9r1Jv836g71UrusdSZXyZU
iHXBvDLIcSsv86fuQT/teD/yiDZ+nwGF5YcKhSMMTasSdprFAgMBAAGjggP4MIID9DA+BgkrBgEE
AYI3FQcEMTAvBicrBgEEAYI3FQiBrIRhhODfI4LlnTKFm8RRga3lH4Fqg+C8CYbyn1gCAWQCAQcw
KQYDVR0lBCIwIAYKKwYBBAGCNwoDDAYIKwYBBQUHAwIGCCsGAQUFBwMEMAsGA1UdDwQEAwIHgDBp
BgNVHSAEYjBgMDgGDCsGAQQBga1jAQEBADAoMCYGCCsGAQUFBwIBFhpodHRwOi8vcGtpLnN3YXRj
aGdyb3VwLmNvbTAkBiIrBgEEAYI3FQiBrIRhhODfI4LlnTKFm8RRga3lH4FqAYMQMDUGCSsGAQQB
gjcVCgQoMCYwDAYKKwYBBAGCNwoDDDAKBggrBgEFBQcDAjAKBggrBgEFBQcDBDAcBgNVHREEFTAT
gRFESG9vdmVyQGFzdWxhYi5jaDAdBgNVHQ4EFgQUovpzZBAhsePYCzgf8UWv/dyabnEwHwYDVR0j
BBgwFoAUqDHmizbiY11ZoDMeYewBAAVnRYYwggExBgNVHR8EggEoMIIBJDCCASCgggEcoIIBGIaB
z2xkYXA6Ly8vQ049U3dhdGNoJTIwR3JvdXAlMjBJc3N1aW5nJTIwQ0EoMiksQ049U0dSQ0hHUjA0
NyxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmln
dXJhdGlvbixEQz1zd2F0Y2hncm91cCxEQz1yb290P2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/
YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2ludIZEaHR0cDovL3BraS5zd2F0Y2hn
cm91cC5jb20vY2VydC9Td2F0Y2glMjBHcm91cCUyMElzc3VpbmclMjBDQSgyKS5jcmwwggFDBggr
BgEFBQcBAQSCATUwggExMIHBBggrBgEFBQcwAoaBtGxkYXA6Ly8vQ049U3dhdGNoJTIwR3JvdXAl
MjBJc3N1aW5nJTIwQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c3dhdGNoZ3JvdXAsREM9cm9vdD9jQUNlcnRpZmljYXRl
P2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBrBggrBgEFBQcwAoZfaHR0
cDovL3BraS5zd2F0Y2hncm91cC5jb20vY2VydC9TR1JDSEdSMDQ3LnN3YXRjaGdyb3VwLm5ldF9T
d2F0Y2glMjBHcm91cCUyMElzc3VpbmclMjBDQSgyKS5jcnQwDQYJKoZIhvcNAQEFBQADgYEAnauT
FitaPJPkpMojYOTJC8Ib6LB5wpZtj8LPteLB/VOoTD3krVZQ5HngCXFK0bhyz6cD2kt2OvpY7thT
5Mc/oZxZghQK9+35gTVH8CnCGDT6s5QXE+S9MQ1jDE4EV7R1LWkanI5qxBKxAuVmWumv1RxkE+86
lOrL0QK1XuDokAswggYUMIIFfaADAgECAgoWXURwAAIAQSMNMA0GCSqGSIb3DQEBBQUAMFQxEzAR
BgoJkiaJk/IsZAEZFgNuZXQxGzAZBgoJkiaJk/IsZAEZFgtzd2F0Y2hncm91cDEgMB4GA1UEAxMX
U3dhdGNoIEdyb3VwIElzc3VpbmcgQ0EwHhcNMTUwODI0MDY1ODA4WhcNMTcwODIzMDY1ODA4WjAY
MRYwFAYDVQQDEw1Ib292ZXIsIERhdmlkMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCawgAe
BGQTeZjbIEeozp9LCEV2wwT+C36sSA2T1P2Jh1cjvYsfqI+rtwLO5fqpvgaTM2vwsE3nqHUu86fE
+7iN6eLPgTI6BVid752/VcMIxQKNjYQdugAIjghP4GLTLlGTBZa71Sq0gCcW1MCkmDTYrYz9apKx
qsJ+hgsKSRBHqQIDAQABo4IEJzCCBCMwPQYJKwYBBAGCNxUHBDAwLgYmKwYBBAGCNxUIgayEYYTg
3yOC5Z0yhZvEUYGt5R+BatmHP4W84RICAWQCAQYwHwYDVR0lBBgwFgYIKwYBBQUHAwQGCisGAQQB
gjcKAwQwCwYDVR0PBAQDAgUgMGkGA1UdIARiMGAwOAYMKwYBBAGBrWMBAQEAMCgwJgYIKwYBBQUH
AgEWGmh0dHA6Ly9wa2kuc3dhdGNoZ3JvdXAuY29tMCQGIisGAQQBgjcVCIGshGGE4N8jguWdMoWb
xFGBreUfgWoBgxAwKQYJKwYBBAGCNxUKBBwwGjAKBggrBgEFBQcDBDAMBgorBgEEAYI3CgMEMEQG
CSqGSIb3DQEJDwQ3MDUwDgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAK
BggqhkiG9w0DBzAcBgNVHREEFTATgRFESG9vdmVyQGFzdWxhYi5jaDAdBgNVHQ4EFgQUtgQyYgxx
Ne47AcKxR6V4lyKUg3gwHwYDVR0jBBgwFoAUqDHmizbiY11ZoDMeYewBAAVnRYYwggExBgNVHR8E
ggEoMIIBJDCCASCgggEcoIIBGIaBz2xkYXA6Ly8vQ049U3dhdGNoJTIwR3JvdXAlMjBJc3N1aW5n
JTIwQ0EoMiksQ049U0dSQ0hHUjA0NyxDTj1DRFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMs
Q049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zd2F0Y2hncm91cCxEQz1yb290P2NlcnRp
ZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFzcz1jUkxEaXN0cmlidXRpb25Qb2lu
dIZEaHR0cDovL3BraS5zd2F0Y2hncm91cC5jb20vY2VydC9Td2F0Y2glMjBHcm91cCUyMElzc3Vp
bmclMjBDQSgyKS5jcmwwggFDBggrBgEFBQcBAQSCATUwggExMIHBBggrBgEFBQcwAoaBtGxkYXA6
Ly8vQ049U3dhdGNoJTIwR3JvdXAlMjBJc3N1aW5nJTIwQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtl
eSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c3dhdGNoZ3JvdXAs
REM9cm9vdD9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhv
cml0eTBrBggrBgEFBQcwAoZfaHR0cDovL3BraS5zd2F0Y2hncm91cC5jb20vY2VydC9TR1JDSEdS
MDQ3LnN3YXRjaGdyb3VwLm5ldF9Td2F0Y2glMjBHcm91cCUyMElzc3VpbmclMjBDQSgyKS5jcnQw
DQYJKoZIhvcNAQEFBQADgYEAkG3TlvuuinJTF8FfjAx3JM0F0uWjLDagNrZYwlfSl9AgZyRpA0u2
2nJX9ylEKSzqGoK31DW+bb3KUDoxE6W9SQVIqWTeZ0Di07jxdNpitA5fA9Bz3EBphagAojxT4MQ3
BL69fkkBlzmofDmFk9Co/pLjnDI4KGx0PKtCTncnvpswggdeMIIGRqADAgECAgoR35sQAAAAAAAG
MA0GCSqGSIb3DQEBBQUAMFExEzARBgoJkiaJk/IsZAEZFgNuZXQxGzAZBgoJkiaJk/IsZAEZFgtz
d2F0Y2hncm91cDEdMBsGA1UEAxMUU3dhdGNoIEdyb3VwIFJvb3QgQ0EwHhcNMTIwNTI5MTUwMDM1
WhcNMjIwNTI5MTUxMDM1WjBUMRMwEQYKCZImiZPyLGQBGRYDbmV0MRswGQYKCZImiZPyLGQBGRYL
c3dhdGNoZ3JvdXAxIDAeBgNVBAMTF1N3YXRjaCBHcm91cCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3
DQEBAQUAA4GNADCBiQKBgQC3bgMcjy2uDZAAZ+QiY7jHmXnV+5ipvs8Ov8jR5vGMMQF6NK4mpNNw
yBFRPGckkmNUIl8Q480yyQZ/uztAGhpcZpALepL9SzE9kO8YhIrF7xVOgO37LE+2DWXdMfwo+WWv
DMrbi0MchoFLSI6ldyAQWr7Zz+XTcWP7p/9nRyrKFQIDAQABo4IEtzCCBLMwEgYJKwYBBAGCNxUB
BAUCAwIAAjAjBgkrBgEEAYI3FQIEFgQUweHsRaWRglyTR7otUPOflONwsTcwHQYDVR0OBBYEFKgx
5os24mNdWaAzHmHsAQAFZ0WGMIIBpgYDVR0gBIIBnTCCAZkwgdcGDCsGAQQBga1jAQEBADCBxjBk
BggrBgEFBQcCAjBYHlYAUwB3AGEAdABjAGgAIABHAHIAbwB1AHAAIABDAGUAcgB0AGkAZgBpAGMA
YQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4AdDBeBggrBgEFBQcCARZS
aHR0cDovL3BraS5zd2F0Y2hncm91cC5jb20vU3dhdGNoJTIwR3JvdXAlMjBDZXJ0aWZpY2F0ZSUy
MFByYWN0aWNlJTIwU3RhdGVtZW50Lmh0bTApBicrBgEEAYI3FQiBrIRhhODfI4LlnTKFm8RRga3l
H4Fqh7SjGIHgywAwJAYiKwYBBAGCNxUIgayEYYTg3yOC5Z0yhZvEUYGt5R+BagGDEDAkBiIrBgEE
AYI3FQiBrIRhhODfI4LlnTKFm8RRga3lH4FqAYMRMCQGIisGAQQBgjcVCIGshGGE4N8jguWdMoWb
xFGBreUfgWoBgxIwDAYKKwYBBAGBrWMCATAIBgYEAI5GAQEwCAYGBACORgEEMBkGCSsGAQQBgjcU
AgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaA
FKEOBd52oD5Vrw51UiFibIsCtbOqMIIBJQYDVR0fBIIBHDCCARgwggEUoIIBEKCCAQyGgclsZGFw
Oi8vL0NOPVN3YXRjaCUyMEdyb3VwJTIwUm9vdCUyMENBLENOPVNHUkNIR1IwNDYsQ049Q0RQLENO
PVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9
c3dhdGNoZ3JvdXAsREM9cm9vdD9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0
Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnSGPmh0dHA6Ly9wa2kuc3dhdGNoZ3JvdXAuY29tL2Nl
cnQvU3dhdGNoJTIwR3JvdXAlMjBSb290JTIwQ0EuY3JsMIIBKgYIKwYBBQUHAQEEggEcMIIBGDCB
vgYIKwYBBQUHMAKGgbFsZGFwOi8vL0NOPVN3YXRjaCUyMEdyb3VwJTIwUm9vdCUyMENBLENOPUFJ
QSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9u
LERDPXN3YXRjaGdyb3VwLERDPXJvb3Q/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNzPWNl
cnRpZmljYXRpb25BdXRob3JpdHkwVQYIKwYBBQUHMAKGSWh0dHA6Ly9wa2kuc3dhdGNoZ3JvdXAu
Y29tL2NlcnQvU0dSQ0hHUjA0Nl9Td2F0Y2glMjBHcm91cCUyMFJvb3QlMjBDQS5jcnQwDQYJKoZI
hvcNAQEFBQADggEBAJmCKWBk4xJ89rQxel/kNrAyomOmQtf4NpTT9Q9WJ7f0fNeIfBPBYDkfDVe7
mrNsfd6kCw235V8jeOYhz6wAgrsQ8h6743G/VSgQlo0Tm8rChSou3uI3GgX4YzX3grh89CbXehrz
r5ld3w5sFfS0E/d9/6xH0KWmHPqHslKNbkWP807IPLT6Uvd1nEC/VN3qqp+sgcQ7QW0qMG5RksdF
rxz/71b76aU+9IO4ChqaFOf/JQtwjDjGqQgzmcRUA6CC19fS13P4nnrD9kQCAbh4EI9e7NE5GJ2w
Jdx04IYI0pdYFvtHUCMs7xuBq3jiEweVs/UjfHUZv4hlwPy67NDhZ7sxggL/MIIC+wIBATBiMFQx
EzARBgoJkiaJk/IsZAEZFgNuZXQxGzAZBgoJkiaJk/IsZAEZFgtzd2F0Y2hncm91cDEgMB4GA1UE
AxMXU3dhdGNoIEdyb3VwIElzc3VpbmcgQ0ECChZdSHUAAgBBIw4wCQYFKw4DAhoFAKCCAfMwGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTYwMzIyMTAzMzUwWjAjBgkq
hkiG9w0BCQQxFgQUBPZF2uXXuInctSgsmLM3t3MI0AYwcQYJKwYBBAGCNxAEMWQwYjBUMRMwEQYK
CZImiZPyLGQBGRYDbmV0MRswGQYKCZImiZPyLGQBGRYLc3dhdGNoZ3JvdXAxIDAeBgNVBAMTF1N3
YXRjaCBHcm91cCBJc3N1aW5nIENBAgoWXURwAAIAQSMNMHMGCyqGSIb3DQEJEAILMWSgYjBUMRMw
EQYKCZImiZPyLGQBGRYDbmV0MRswGQYKCZImiZPyLGQBGRYLc3dhdGNoZ3JvdXAxIDAeBgNVBAMT
F1N3YXRjaCBHcm91cCBJc3N1aW5nIENBAgoWXURwAAIAQSMNMIGrBgkqhkiG9w0BCQ8xgZ0wgZow
CwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZI
hvcNAwICAgCAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEoMAcGBSsOAwIa
MAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIGA
It58DsJt+MkXFRt5uaOxIQrNlu9DtuHFe7NlvXikHFbkCLKxlN4VkDN/jzq/qRCPP6GorB1tjl21
r9EQPFifnrqdtKbeBYy/Bg8SX405M1bjzRb38FL7nXuy+lAdjsNYrxkJP5Z3SjV2X32H01fGQcpw
CZwCyK/gbCKI7vNG33MAAAAAAAA=

------=_NextPart_000_0022_01D1842E.B4DDC590--
