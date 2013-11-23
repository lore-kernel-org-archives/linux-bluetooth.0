Return-Path: <cyrus@holtmann.org>
Message-ID: <1385236029.2236.7.camel@linux-3kti>
Subject: openSUSE 13.1:  bt headsets lose connection
From: Colin Beckingham <colbec@start.ca>
Reply-To: colbec@start.ca
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sat, 23 Nov 2013 14:47:09 -0500
Content-Type: multipart/mixed; boundary="=-UPGUCrUHr1kfg6xAwq41"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-UPGUCrUHr1kfg6xAwq41
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit

In openSUSE 12.3 bluetooth operations were mostly ok. In the last few
days I have upgraded from 12.3 to 13.1 and now none of my bt headsets
can remain connected. Pairing is not a problem, but then they
immediately disconnect.

I have posted a bug at gnome-bluetooth, but it seems that a previous
similar bug has been tested and found that gnome-bluetooth may be
excluded. Here is the bug report:

https://bugzilla.gnome.org/show_bug.cgi?id=712379

I have run a test connection using bluetoothd (5.11) in debug mode, and
have attached the output in file bluedump.txt.

Also I have tried running bluetoothd with the -E option and no change.

I understand that it is possible this may already be known, and that
pulseaudio may be involved. But since I have the debug output I thought
I would check with the linux-bluetooth community first.

Thanks.

--=-UPGUCrUHr1kfg6xAwq41
Content-Disposition: attachment; filename="bluedump.txt"
Content-Type: text/plain; name="bluedump.txt"; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit

2013-11-21T09:54:48.362515-05:00 linux-3kti bluetoothd[21678]: Bluetooth daemon 5.11
2013-11-21T09:54:48.365917-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_init() sending read version command
2013-11-21T09:54:48.366414-05:00 linux-3kti bluetoothd[21678]: Starting SDP server
2013-11-21T09:54:48.366858-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:register_device_id() Adding device id record for 0002:1d6b:0246:050b
2013-11-21T09:54:48.367205-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:plugin_init() Loading builtin plugins
2013-11-21T09:54:48.367547-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading hostname plugin
2013-11-21T09:54:48.367940-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading wiimote plugin
2013-11-21T09:54:48.368371-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading autopair plugin
2013-11-21T09:54:48.368701-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading policy plugin
2013-11-21T09:54:48.369043-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading a2dp plugin
2013-11-21T09:54:48.369401-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading avrcp plugin
2013-11-21T09:54:48.369701-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading network plugin
2013-11-21T09:54:48.370009-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading input plugin
2013-11-21T09:54:48.370271-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading hog plugin
2013-11-21T09:54:48.370529-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading gatt plugin
2013-11-21T09:54:48.370892-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading scanparam plugin
2013-11-21T09:54:48.371202-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:add_plugin() Loading deviceinfo plugin
2013-11-21T09:54:48.371465-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:plugin_init() Loading plugins /usr/lib64/bluetooth/plugins
2013-11-21T09:54:48.371731-05:00 linux-3kti bluetoothd[21678]: profiles/input/suspend-dummy.c:suspend_init()
2013-11-21T09:54:48.372070-05:00 linux-3kti bluetoothd[21678]: profiles/input/suspend-dummy.c:suspend_init() Created suspend-dummy FIFO on /tmp/hogsuspend
2013-11-21T09:54:48.372475-05:00 linux-3kti bluetoothd[21678]: profiles/network/manager.c:read_config() Config options: Security=true
2013-11-21T09:54:48.372802-05:00 linux-3kti bluetoothd[21678]: plugins/hostname.c:read_dmi_fallback() chassis: desktop
2013-11-21T09:54:48.373166-05:00 linux-3kti bluetoothd[21678]: plugins/hostname.c:read_dmi_fallback() major: 0x01 minor: 0x01
2013-11-21T09:54:48.373793-05:00 linux-3kti bluetoothd[21678]: src/main.c:main() Entering main loop
2013-11-21T09:54:48.374195-05:00 linux-3kti bluetoothd[21678]: Bluetooth management interface 1.3 initialized
2013-11-21T09:54:48.374563-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:read_version_complete() sending read supported commands command
2013-11-21T09:54:48.374923-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:read_version_complete() sending read index list command
2013-11-21T09:54:48.375245-05:00 linux-3kti bluetoothd[21678]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type 2 op 0 soft 0 hard 0
2013-11-21T09:54:48.375540-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:read_commands_complete() Number of commands: 38
2013-11-21T09:54:48.375819-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:read_commands_complete() Number of events: 21
2013-11-21T09:54:48.376653-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:read_index_list_complete() Number of controllers: 1
2013-11-21T09:54:48.377138-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:read_index_list_complete() Found index 0
2013-11-21T09:54:48.377519-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:index_added() index 0
2013-11-21T09:54:48.377860-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:btd_adapter_new() System name: BlueZ 5.11
2013-11-21T09:54:48.378253-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:btd_adapter_new() Major class: 0
2013-11-21T09:54:48.378580-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:btd_adapter_new() Minor class: 0
2013-11-21T09:54:48.378962-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d050B
2013-11-21T09:54:48.379391-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:btd_adapter_new() Discoverable timeout: 180 seconds
2013-11-21T09:54:48.379979-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 seconds
2013-11-21T09:54:48.380348-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:index_added() sending read info command for index 0
2013-11-21T09:54:48.380712-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:read_info_complete() index 0 status 0x00
2013-11-21T09:54:48.381113-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:clear_uuids() sending clear uuids command for index 0
2013-11-21T09:54:48.381403-05:00 linux-3kti bluetoothd[21678]: src/attrib-server.c:btd_adapter_gatt_server_start() Start GATT server in hci0
2013-11-21T09:54:48.381692-05:00 linux-3kti bluetoothd[21678]: src/attrib-server.c:attrib_db_add_new() handle=0x0001
2013-11-21T09:54:48.382337-05:00 linux-3kti bluetoothd[21678]: src/attrib-server.c:attrib_db_add_new() handle=0x0004
2013-11-21T09:54:48.382645-05:00 linux-3kti bluetoothd[21678]: src/attrib-server.c:attrib_db_add_new() handle=0x0006
2013-11-21T09:54:48.382932-05:00 linux-3kti bluetoothd[21678]: src/attrib-server.c:attrib_db_add_new() handle=0x0007
2013-11-21T09:54:48.383216-05:00 linux-3kti bluetoothd[21678]: src/attrib-server.c:attrib_db_add_new() handle=0x0008
2013-11-21T09:54:48.383498-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_add() /org/bluez/hci0
2013-11-21T09:54:48.383779-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
2013-11-21T09:54:48.384104-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
2013-11-21T09:54:48.384393-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
2013-11-21T09:54:48.384673-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
2013-11-21T09:54:48.384961-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001800-0000-1000-8000-00805f9
2013-11-21T09:54:48.385254-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
2013-11-21T09:54:48.385596-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:add_uuid() sending add uuid command for index 0
2013-11-21T09:54:48.385908-05:00 linux-3kti bluetoothd[21678]: src/attrib-server.c:attrib_db_add_new() handle=0x0010
2013-11-21T09:54:48.386196-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_add() /org/bluez/hci0
2013-11-21T09:54:48.386483-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
2013-11-21T09:54:48.386914-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
2013-11-21T09:54:48.387208-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
2013-11-21T09:54:48.387518-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
2013-11-21T09:54:48.387914-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001801-0000-1000-8000-00805f9
2013-11-21T09:54:48.388203-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
2013-11-21T09:54:48.388493-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:add_uuid() sending add uuid command for index 0
2013-11-21T09:54:48.388779-05:00 linux-3kti bluetoothd[21678]: profiles/audio/a2dp.c:media_server_probe() path /org/bluez/hci0
2013-11-21T09:54:48.389070-05:00 linux-3kti bluetoothd[21678]: plugins/hostname.c:hostname_probe()
2013-11-21T09:54:48.389350-05:00 linux-3kti bluetoothd[21678]: plugins/hostname.c:update_class() major: 0x01 minor: 0x01
2013-11-21T09:54:48.389669-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:btd_adapter_set_class() class: major 1 minor 1
2013-11-21T09:54:48.389963-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:set_dev_class() sending set device class command for index 0
2013-11-21T09:54:48.390245-05:00 linux-3kti bluetoothd[21678]: profiles/network/manager.c:panu_server_probe() path /org/bluez/hci0
2013-11-21T09:54:48.390527-05:00 linux-3kti bluetoothd[21678]: profiles/network/server.c:server_register() Registered interface org.bluez.NetworkServer1 on path /org/bluez/hci0
2013-11-21T09:54:48.390810-05:00 linux-3kti bluetoothd[21678]: profiles/network/manager.c:gn_server_probe() path /org/bluez/hci0
2013-11-21T09:54:48.391113-05:00 linux-3kti bluetoothd[21678]: profiles/network/manager.c:nap_server_probe() path /org/bluez/hci0
2013-11-21T09:54:48.391410-05:00 linux-3kti bluetoothd[21678]: profiles/audio/avrcp.c:avrcp_controller_server_probe() path /org/bluez/hci0
2013-11-21T09:54:48.391690-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_add() /org/bluez/hci0
2013-11-21T09:54:48.391976-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10003
2013-11-21T09:54:48.392255-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
2013-11-21T09:54:48.392535-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
2013-11-21T09:54:48.392857-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
2013-11-21T09:54:48.393154-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
2013-11-21T09:54:48.393434-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110f-0000-1000-8000-00805f9
2013-11-21T09:54:48.393714-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
2013-11-21T09:54:48.394031-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:add_uuid() sending add uuid command for index 0
2013-11-21T09:54:48.394315-05:00 linux-3kti bluetoothd[21678]: profiles/audio/avrcp.c:avrcp_target_server_probe() path /org/bluez/hci0
2013-11-21T09:54:48.394618-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_add() /org/bluez/hci0
2013-11-21T09:54:48.394928-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
2013-11-21T09:54:48.395211-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
2013-11-21T09:54:48.395490-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
2013-11-21T09:54:48.395851-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
2013-11-21T09:54:48.396131-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110c-0000-1000-8000-00805f9
2013-11-21T09:54:48.396411-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
2013-11-21T09:54:48.396711-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
2013-11-21T09:54:48.397112-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:add_uuid() sending add uuid command for index 0
2013-11-21T09:54:48.397446-05:00 linux-3kti bluetoothd[21678]: profiles/audio/a2dp.c:a2dp_sink_server_probe() path /org/bluez/hci0
2013-11-21T09:54:48.397737-05:00 linux-3kti bluetoothd[21678]: profiles/audio/a2dp.c:a2dp_source_server_probe() path /org/bluez/hci0
2013-11-21T09:54:48.398041-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:btd_adapter_unblock_address() hci0 00:00:00:00:00:00
2013-11-21T09:54:48.398372-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys 0
2013-11-21T09:54:48.398709-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
2013-11-21T09:54:48.399000-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:add_uuid() sending add uuid command for index 0
2013-11-21T09:54:48.399281-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b product 246 version 50b
2013-11-21T09:54:48.399559-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_register() Adapter /org/bluez/hci0 registered
2013-11-21T09:54:48.399890-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:set_dev_class() sending set device class command for index 0
2013-11-21T09:54:48.400191-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:set_name() sending set local name command for index 0
2013-11-21T09:54:48.400547-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:set_mode() sending set mode command for index 0
2013-11-21T09:54:48.400859-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:set_mode() sending set mode command for index 0
2013-11-21T09:54:48.401142-05:00 linux-3kti bluetoothd[21678]: plugins/hostname.c:property_changed() static hostname: linux-3kti.site
2013-11-21T09:54:48.401423-05:00 linux-3kti bluetoothd[21678]: plugins/hostname.c:property_changed() pretty hostname:
2013-11-21T09:54:48.401761-05:00 linux-3kti bluetoothd[21678]: plugins/hostname.c:update_name() name: linux-3kti.site
2013-11-21T09:54:48.402053-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_set_name() name: linux-3kti.site
2013-11-21T09:54:48.402335-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_set_name() alias: linux-3kti.site
2013-11-21T09:54:48.402614-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:set_name() sending set local name command for index 0
2013-11-21T09:54:48.402915-05:00 linux-3kti bluetoothd[21678]: plugins/hostname.c:property_changed() chassis: desktop
2013-11-21T09:54:48.403300-05:00 linux-3kti bluetoothd[21678]: plugins/hostname.c:update_class() major: 0x01 minor: 0x01
2013-11-21T09:54:48.403676-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:load_link_keys_complete() link keys loaded for hci0
2013-11-21T09:54:48.404119-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:local_name_changed_callback() Name: BlueZ 5.11
2013-11-21T09:54:48.404396-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:local_name_changed_callback() Short name:
2013-11-21T09:54:48.404664-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:local_name_changed_callback() Current alias: BlueZ 5.11
2013-11-21T09:54:48.405003-05:00 linux-3kti bluetoothd[21678]: src/attrib-server.c:attrib_db_update() handle=0x0006
2013-11-21T09:54:48.405356-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:local_name_changed_callback() Name: linux-3kti.site
2013-11-21T09:54:48.405619-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:local_name_changed_callback() Short name:
2013-11-21T09:54:48.405975-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:local_name_changed_callback() Current alias: linux-3kti.site
2013-11-21T09:54:48.406284-05:00 linux-3kti bluetoothd[21678]: src/attrib-server.c:attrib_db_update() handle=0x0006
2013-11-21T09:54:48.406553-05:00 linux-3kti bluetoothd[21678]: profiles/audio/avdtp.c:avdtp_register_sep() SEP 0x1bdd370 registered: type:0 codec:0 seid:1
2013-11-21T09:54:48.406815-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_add() /org/bluez/hci0
2013-11-21T09:54:48.407087-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10005
2013-11-21T09:54:48.407348-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
2013-11-21T09:54:48.407649-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
2013-11-21T09:54:48.407948-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
2013-11-21T09:54:48.408209-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110a-0000-1000-8000-00805f9
2013-11-21T09:54:48.408471-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
2013-11-21T09:54:48.408733-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
2013-11-21T09:54:48.409007-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:add_uuid() sending add uuid command for index 0
2013-11-21T09:54:48.409365-05:00 linux-3kti bluetoothd[21678]: Endpoint registered: sender=:1.36 path=/MediaEndpoint/A2DPSource
2013-11-21T09:54:48.409725-05:00 linux-3kti bluetoothd[21678]: profiles/audio/avdtp.c:avdtp_register_sep() SEP 0x1be2e60 registered: type:1 codec:0 seid:2
2013-11-21T09:54:48.410006-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_add() /org/bluez/hci0
2013-11-21T09:54:48.410268-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10006
2013-11-21T09:54:48.410527-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
2013-11-21T09:54:48.410789-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
2013-11-21T09:54:48.411089-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
2013-11-21T09:54:48.411436-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110b-0000-1000-8000-00805f9
2013-11-21T09:54:48.411698-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
2013-11-21T09:54:48.411967-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
2013-11-21T09:54:48.412229-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:add_uuid() sending add uuid command for index 0
2013-11-21T09:54:48.412489-05:00 linux-3kti bluetoothd[21678]: Endpoint registered: sender=:1.36 path=/MediaEndpoint/A2DPSink
2013-11-21T09:54:48.420103-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:property_set_mode() sending Set Powered command for index 0
2013-11-21T09:54:48.542912-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:dev_class_changed_callback() Class: 0x0c0104
2013-11-21T09:54:48.543386-05:00 linux-3kti bluetoothd[21678]: src/attrib-server.c:attrib_db_update() handle=0x0008
2013-11-21T09:54:48.546877-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:property_set_mode_complete() Success (0x00)
2013-11-21T09:54:48.547351-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:new_settings_callback() Settings: 0x000000d3
2013-11-21T09:54:48.547783-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:settings_changed() Changed settings: 0x00000001
2013-11-21T09:54:48.548147-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
2013-11-21T09:54:48.549240-05:00 linux-3kti bluetoothd[21678]: src/agent.c:agent_ref() 0x1be3a50: ref=1
2013-11-21T09:54:48.549579-05:00 linux-3kti bluetoothd[21678]: src/agent.c:register_agent() agent :1.44
2013-11-21T09:54:48.549916-05:00 linux-3kti bluetoothd[21678]: src/agent.c:set_default_agent() Default agent set to :1.44 /org/bluez/agent/gnome
2013-11-21T09:55:01.679919-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:connected_callback() hci0 device 00:0D:E6:6E:51:47 connected eir_len 5
2013-11-21T09:55:01.680477-05:00 linux-3kti bluetoothd[21678]: src/device.c:device_create() dst 00:0D:E6:6E:51:47
2013-11-21T09:55:01.680801-05:00 linux-3kti bluetoothd[21678]: src/device.c:device_new() address 00:0D:E6:6E:51:47
2013-11-21T09:55:01.681135-05:00 linux-3kti bluetoothd[21678]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_00_0D_E6_6E_51_47
2013-11-21T09:55:01.681521-05:00 linux-3kti bluetoothd[21678]: src/device.c:device_set_temporary() temporary 1
2013-11-21T09:55:01.681905-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_connect_list_remove() device /org/bluez/hci0/dev_00_0D_E6_6E_51_47 is not on the list, ignoring
2013-11-21T09:55:01.682255-05:00 linux-3kti bluetoothd[21678]: src/device.c:device_set_class() /org/bluez/hci0/dev_00_0D_E6_6E_51_47 0x200404
2013-11-21T09:55:03.865941-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:dev_disconnected() Device 00:0D:E6:6E:51:47 disconnected, reason 3
2013-11-21T09:55:03.866408-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_remove_connection()
2013-11-21T09:55:03.866745-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_remove_connection() Removing temporary device /org/bluez/hci0/dev_00_0D_E6_6E_51_47
2013-11-21T09:55:03.867174-05:00 linux-3kti bluetoothd[21678]: src/device.c:device_remove() Removing device /org/bluez/hci0/dev_00_0D_E6_6E_51_47
2013-11-21T09:55:03.867545-05:00 linux-3kti bluetoothd[21678]: src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_00_0D_E6_6E_51_47
2013-11-21T09:55:03.867891-05:00 linux-3kti bluetoothd[21678]: src/device.c:device_free() 0x1be4100
2013-11-21T09:55:03.868210-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:0D:E6:6E:51:47 type 0 status 0xe
2013-11-21T09:55:03.868478-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:resume_discovery()
2013-11-21T09:55:34.759419-05:00 linux-3kti bluetoothd[21678]: Terminating
2013-11-21T09:55:34.760060-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_shutdown()
2013-11-21T09:55:34.760394-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:set_mode() sending set mode command for index 0
2013-11-21T09:55:34.761394-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:new_settings_callback() Settings: 0x000000d2
2013-11-21T09:55:34.761794-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:settings_changed() Changed settings: 0x00000001
2013-11-21T09:55:34.762218-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_stop() adapter /org/bluez/hci0 has been disabled
2013-11-21T09:55:34.762669-05:00 linux-3kti bluetoothd[21678]: src/plugin.c:plugin_cleanup() Cleanup plugins
2013-11-21T09:55:34.763012-05:00 linux-3kti bluetoothd[21678]: profiles/audio/a2dp.c:media_server_remove() path /org/bluez/hci0
2013-11-21T09:55:34.763362-05:00 linux-3kti bluetoothd[21678]: profiles/audio/media.c:release_endpoint() sender=:1.36 path=/MediaEndpoint/A2DPSource
2013-11-21T09:55:34.763692-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
2013-11-21T09:55:34.764034-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
2013-11-21T09:55:34.764387-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10005
2013-11-21T09:55:34.764736-05:00 linux-3kti bluetoothd[21678]: profiles/audio/media.c:release_endpoint() sender=:1.36 path=/MediaEndpoint/A2DPSource
2013-11-21T09:55:34.765088-05:00 linux-3kti bluetoothd[21678]: Endpoint unregistered: sender=:1.36 path=/MediaEndpoint/A2DPSource
2013-11-21T09:55:34.765570-05:00 linux-3kti bluetoothd[21678]: profiles/audio/media.c:media_endpoint_destroy() sender=:1.36 path=/MediaEndpoint/A2DPSource
2013-11-21T09:55:34.765944-05:00 linux-3kti dbus[587]: [system] Rejected send message, 3 matched rules; type="error", sender=":1.36" (uid=1000 pid=1335 comm="/usr/bin/pulseaudio --start ") interface="(unset)" member="(unset)" error name="org.bluez.MediaEndpoint1.Error.NotImplemented" requested_reply="0" destination=":1.192" (uid=0 pid=21678 comm="/usr/lib/bluetooth/bluetoothd -d ")
2013-11-21T09:55:34.766800-05:00 linux-3kti bluetoothd[21678]: profiles/audio/avdtp.c:avdtp_unregister_sep() SEP 0x1bdd370 unregistered: type:0 codec:0 seid:1
2013-11-21T09:55:34.767263-05:00 linux-3kti bluetoothd[21678]: profiles/audio/media.c:release_endpoint() sender=:1.36 path=/MediaEndpoint/A2DPSink
2013-11-21T09:55:34.767665-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
2013-11-21T09:55:34.768503-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
2013-11-21T09:55:34.768926-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10006
2013-11-21T09:55:34.769253-05:00 linux-3kti bluetoothd[21678]: profiles/audio/media.c:release_endpoint() sender=:1.36 path=/MediaEndpoint/A2DPSink
2013-11-21T09:55:34.769865-05:00 linux-3kti bluetoothd[21678]: Endpoint unregistered: sender=:1.36 path=/MediaEndpoint/A2DPSink
2013-11-21T09:55:34.770175-05:00 linux-3kti bluetoothd[21678]: profiles/audio/media.c:media_endpoint_destroy() sender=:1.36 path=/MediaEndpoint/A2DPSink
2013-11-21T09:55:34.770498-05:00 linux-3kti bluetoothd[21678]: profiles/audio/avdtp.c:avdtp_unregister_sep() SEP 0x1be2e60 unregistered: type:1 codec:0 seid:2
2013-11-21T09:55:34.770792-05:00 linux-3kti bluetoothd[21678]: plugins/hostname.c:hostname_remove()
2013-11-21T09:55:34.771094-05:00 linux-3kti bluetoothd[21678]: src/agent.c:set_default_agent() Default agent cleared
2013-11-21T09:55:34.771381-05:00 linux-3kti bluetoothd[21678]: src/agent.c:agent_destroy() agent :1.44
2013-11-21T09:55:34.771662-05:00 linux-3kti bluetoothd[21678]: src/agent.c:agent_release() Releasing agent :1.44, /org/bluez/agent/gnome
2013-11-21T09:55:34.771950-05:00 linux-3kti bluetoothd[21678]: src/agent.c:agent_unref() 0x1be3a50: ref=0
2013-11-21T09:55:34.772278-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_remove() Removing adapter /org/bluez/hci0
2013-11-21T09:55:34.772564-05:00 linux-3kti bluetoothd[21678]: profiles/audio/a2dp.c:a2dp_source_server_remove() path /org/bluez/hci0
2013-11-21T09:55:34.772853-05:00 linux-3kti bluetoothd[21678]: profiles/audio/a2dp.c:a2dp_sink_server_remove() path /org/bluez/hci0
2013-11-21T09:55:34.769559-05:00 linux-3kti dbus[587]: message repeated 3 times: [ [system] Rejected send message, 3 matched rules; type="error", sender=":1.36" (uid=1000 pid=1335 comm="/usr/bin/pulseaudio --start ") interface="(unset)" member="(unset)" error name="org.bluez.MediaEndpoint1.Error.NotImplemented" requested_reply="0" destination=":1.192" (uid=0 pid=21678 comm="/usr/lib/bluetooth/bluetoothd -d ")]
2013-11-21T09:55:34.773135-05:00 linux-3kti dbus[587]: [system] Rejected send message, 3 matched rules; type="method_return", sender=":1.44" (uid=1000 pid=1383 comm="/usr/bin/gnome-shell ") interface="(unset)" member="(unset)" error name="(unset)" requested_reply="0" destination=":1.192" (uid=0 pid=21678 comm="/usr/lib/bluetooth/bluetoothd -d ")
2013-11-21T09:55:34.773432-05:00 linux-3kti bluetoothd[21678]: profiles/audio/avrcp.c:avrcp_target_server_remove() path /org/bluez/hci0
2013-11-21T09:55:34.773755-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
2013-11-21T09:55:34.774064-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
2013-11-21T09:55:34.774348-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10004
2013-11-21T09:55:34.774629-05:00 linux-3kti bluetoothd[21678]: profiles/audio/avrcp.c:avrcp_controller_server_remove() path /org/bluez/hci0
2013-11-21T09:55:34.774919-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
2013-11-21T09:55:34.775200-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
2013-11-21T09:55:34.775478-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10003
2013-11-21T09:55:34.775814-05:00 linux-3kti bluetoothd[21678]: profiles/network/manager.c:nap_server_remove() path /org/bluez/hci0
2013-11-21T09:55:34.776147-05:00 linux-3kti bluetoothd[21678]: profiles/network/manager.c:gn_server_remove() path /org/bluez/hci0
2013-11-21T09:55:34.776495-05:00 linux-3kti bluetoothd[21678]: profiles/network/manager.c:panu_server_remove() path /org/bluez/hci0
2013-11-21T09:55:34.776857-05:00 linux-3kti bluetoothd[21678]: profiles/network/server.c:path_unregister() Unregistered interface org.bluez.NetworkServer1 on path /org/bluez/hci0
2013-11-21T09:55:34.777199-05:00 linux-3kti bluetoothd[21678]: src/attrib-server.c:btd_adapter_gatt_server_stop() Stop GATT server in hci0
2013-11-21T09:55:34.777613-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
2013-11-21T09:55:34.777977-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
2013-11-21T09:55:34.778404-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10002
2013-11-21T09:55:34.778716-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
2013-11-21T09:55:34.779032-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
2013-11-21T09:55:34.779381-05:00 linux-3kti bluetoothd[21678]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10001
2013-11-21T09:55:34.779526-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:btd_adapter_unref() Freeing adapter /org/bluez/hci0
2013-11-21T09:55:34.779722-05:00 linux-3kti bluetoothd[21678]: src/adapter.c:adapter_free() 0x1bd9d30
2013-11-21T09:55:34.779897-05:00 linux-3kti bluetoothd[21678]: Stopping SDP server
2013-11-21T09:55:34.780060-05:00 linux-3kti bluetoothd[21678]: Exit


--=-UPGUCrUHr1kfg6xAwq41--

