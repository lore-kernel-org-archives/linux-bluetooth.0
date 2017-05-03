Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Robert Schneider <Robert.Schneider@aramar.de>
Subject: KORG nanoKONTROL Studio MIDI over Bluetooth problem
Message-ID: <7ea3e489-8dff-4178-906f-cae18da6647c@aramar.de>
Date: Wed, 3 May 2017 20:02:48 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E06E46533C2ECD808386FD4F"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------E06E46533C2ECD808386FD4F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I'm trying to get my KORG nanoKONTROL Studio working with the current BlueZ 
stack (GIT as of May 3rd).
However, it seems the bonding fails for some reason.

May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() 
hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0x5
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() 
bonding (nil) status 0x05
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() 
status 5
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:dev_disconnected() Device 
60:F1:89:28:DA:1F disconnected, reason 2
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:adapter_remove_connection()
May  3 19:48:30 Maui bluetoothd[32743]: plugins/policy.c:disconnect_cb() reason 2
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() 
hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0xe
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() 
bonding (nil) status 0x0e
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() 
status 14
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:30 Maui bluetoothd[32743]: MIDI I/O: Failed to read initial request

I do not have any thorough bluetooth skill. Could somebody look at the attached 
log and point me into some direction?
I restarted bluetoothd freshly with nothing in /var/lib/bluetooth.
Thanks in advance and best regards,
Robert


--------------E06E46533C2ECD808386FD4F
Content-Type: text/x-log;
 name="Korg-nanoKONTROL-Studio-bluetooth.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Korg-nanoKONTROL-Studio-bluetooth.log"

May  3 19:47:12 Maui systemd[1]: Starting Bluetooth service...
May  3 19:47:12 Maui bluetoothd[32743]: Bluetooth daemon 5.44
May  3 19:47:12 Maui systemd[1]: Started Bluetooth service.
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_init() sending read version command
May  3 19:47:12 Maui bluetoothd[32743]: Starting SDP server
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:register_device_id() Adding device id record for 0002:1d6b:0246:052c
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:plugin_init() Loading builtin plugins
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading hostname plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading wiimote plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading autopair plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading policy plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading a2dp plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading avrcp plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading network plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading input plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading hog plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading gap plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading scanparam plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading deviceinfo plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:add_plugin() Loading midi plugin
May  3 19:47:12 Maui bluetoothd[32743]: src/plugin.c:plugin_init() Loading plugins /usr/local/lib/bluetooth/plugins
May  3 19:47:12 Maui bluetoothd[32743]: profiles/input/suspend-none.c:suspend_init()
May  3 19:47:12 Maui bluetoothd[32743]: profiles/network/manager.c:read_config() Config options: Security=true
May  3 19:47:12 Maui systemd[1]: Starting Hostname Service...
May  3 19:47:12 Maui bluetoothd[32743]: plugins/hostname.c:read_dmi_fallback() chassis: desktop
May  3 19:47:12 Maui pulseaudio[27272]: Failed to register as a handsfree audio agent with ofono: org.freedesktop.DBus.Error.ServiceUnknown: The name org.ofono was not provided by any .service files
May  3 19:47:12 Maui bluetoothd[32743]: plugins/hostname.c:read_dmi_fallback() major: 0x01 minor: 0x01
May  3 19:47:12 Maui bluetoothd[32743]: src/main.c:main() Entering main loop
May  3 19:47:12 Maui dbus[1218]: [system] Activating via systemd: service name='org.freedesktop.hostname1' unit='dbus-org.freedesktop.hostname1.service'
May  3 19:47:12 Maui bluetoothd[32743]: src/rfkill.c:rfkill_event() RFKILL event idx 30 type 2 op 0 soft 0 hard 0
May  3 19:47:12 Maui bluetoothd[32743]: Bluetooth management interface 1.14 initialized
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:read_version_complete() sending read supported commands command
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:read_version_complete() sending read index list command
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:read_commands_complete() Number of commands: 65
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:read_commands_complete() Number of events: 35
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:read_commands_complete() enabling kernel-side connection control
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:read_index_list_complete() Number of controllers: 1
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:read_index_list_complete() Found index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:index_added() index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:btd_adapter_new() System name: BlueZ 5.44
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:btd_adapter_new() Major class: 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:btd_adapter_new() Minor class: 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d052C
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:btd_adapter_new() Discoverable timeout: 180 seconds
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 seconds
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:index_added() sending read info command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:read_info_complete() index 0 status 0x00
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:clear_uuids() sending clear uuids command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:clear_devices() sending clear devices command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:set_privacy() sending set privacy command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:set_privacy() setting privacy mode 0x00 for index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/gatt-database.c:btd_gatt_database_new() GATT Manager registered for adapter: /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_add() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001800-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:add_uuid() sending add uuid command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_add() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001801-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:add_uuid() sending add uuid command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: profiles/audio/a2dp.c:media_server_probe() path /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: plugins/hostname.c:hostname_probe()
May  3 19:47:12 Maui bluetoothd[32743]: plugins/hostname.c:update_class() major: 0x01 minor: 0x01
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:btd_adapter_set_class() class: major 1 minor 1
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:set_dev_class() sending set device class command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: profiles/network/manager.c:panu_server_probe() path /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: profiles/network/server.c:server_register() Registered interface org.bluez.NetworkServer1 on path /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: profiles/network/manager.c:gn_server_probe() path /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: profiles/network/manager.c:nap_server_probe() path /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: profiles/audio/avrcp.c:avrcp_controller_server_probe() path /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_add() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10003
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110f-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:add_uuid() sending add uuid command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: profiles/audio/avrcp.c:avrcp_target_server_probe() path /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_add() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110c-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:add_uuid() sending add uuid command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: profiles/audio/a2dp.c:a2dp_sink_server_probe() path /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: profiles/audio/a2dp.c:a2dp_source_server_probe() path /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:btd_adapter_unblock_address() hci0 00:00:00:00:00:00
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:load_ltks() hci0 keys 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:load_irks() hci0 irks 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:load_conn_params() hci0 conn params 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:add_uuid() sending add uuid command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b product 246 version 52c
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_register() Adapter /org/bluez/hci0 registered
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:set_dev_class() sending set device class command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:set_name() sending set local name command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:set_privacy_complete() Successfuly set privacy for index 0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:load_link_keys_complete() link keys loaded for hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:load_conn_params_complete() Connection Parameters loaded for hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:local_name_changed_callback() Name: BlueZ 5.44
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:local_name_changed_callback() Short name:
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:local_name_changed_callback() Current alias: BlueZ 5.44
May  3 19:47:12 Maui bluetoothd[32743]: profiles/audio/avdtp.c:avdtp_register_sep() SEP 0x5568f2cde300 registered: type:0 codec:0 seid:1
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_add() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10005
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110a-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:add_uuid() sending add uuid command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: Endpoint registered: sender=:1.1576 path=/MediaEndpoint/A2DPSource
May  3 19:47:12 Maui bluetoothd[32743]: profiles/audio/avdtp.c:avdtp_register_sep() SEP 0x5568f2ce2990 registered: type:1 codec:0 seid:2
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_add() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10006
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110b-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:add_uuid() sending add uuid command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: Endpoint registered: sender=:1.1576 path=/MediaEndpoint/A2DPSink
May  3 19:47:12 Maui bluetoothd[32743]: src/profile.c:register_profile() sender :1.1576
May  3 19:47:12 Maui bluetoothd[32743]: src/profile.c:create_ext() Created "Headset Voice gateway"
May  3 19:47:12 Maui bluetoothd[32743]: src/profile.c:ext_adapter_probe() "Headset Voice gateway" probed
May  3 19:47:12 Maui bluetoothd[32743]: src/profile.c:ext_start_servers() Headset Voice gateway listening on chan 12
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_add() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10007
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001108-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001112-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:add_uuid() sending add uuid command for index 0
May  3 19:47:12 Maui dbus[1218]: [system] Successfully activated service 'org.freedesktop.hostname1'
May  3 19:47:12 Maui systemd[1]: Started Hostname Service.
May  3 19:47:12 Maui bluetoothd[32743]: plugins/hostname.c:property_changed() static hostname: Maui
May  3 19:47:12 Maui bluetoothd[32743]: plugins/hostname.c:property_changed() pretty hostname:
May  3 19:47:12 Maui bluetoothd[32743]: plugins/hostname.c:update_name() name: Maui
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_set_name() name: Maui
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:adapter_set_name() alias: Maui
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:set_name() sending set local name command for index 0
May  3 19:47:12 Maui bluetoothd[32743]: plugins/hostname.c:property_changed() chassis: desktop
May  3 19:47:12 Maui bluetoothd[32743]: plugins/hostname.c:update_class() major: 0x01 minor: 0x01
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:local_name_changed_callback() Name: Maui
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:local_name_changed_callback() Short name:
May  3 19:47:12 Maui bluetoothd[32743]: src/adapter.c:local_name_changed_callback() Current alias: Maui
May  3 19:47:20 Maui dbus-daemon[2288]: Activating via systemd: service name='org.bluez.obex' unit='dbus-org.bluez.obex.service'
May  3 19:47:20 Maui dbus-daemon[2288]: Activation via systemd failed for unit 'dbus-org.bluez.obex.service': Unit dbus-org.bluez.obex.service not found.
May  3 19:47:20 Maui dbus[1218]: [system] Activating service name='org.blueman.Mechanism' (using servicehelper)
May  3 19:47:20 Maui bluetoothd[32743]: src/agent.c:agent_ref() 0x5568f2cdacd0: ref=1
May  3 19:47:20 Maui bluetoothd[32743]: src/agent.c:register_agent() agent :1.2332
May  3 19:47:20 Maui bluetoothd[32743]: src/agent.c:add_default_agent() Default agent set to :1.2332 /org/blueman/agent/global
May  3 19:47:20 Maui org.blueman.Mechanism[1218]: Unable to init server: Could not connect: Connection refused
May  3 19:47:20 Maui org.blueman.Mechanism[1218]: Unable to init server: Could not connect: Connection refused
May  3 19:47:20 Maui blueman-mechanism: Starting blueman-mechanism
May  3 19:47:20 Maui dbus[1218]: [system] Successfully activated service 'org.blueman.Mechanism'
May  3 19:47:20 Maui blueman-mechani[313]: gtk_icon_theme_get_for_screen: assertion 'GDK_IS_SCREEN (screen)' failed
May  3 19:47:20 Maui blueman-mechanism: loading Network
May  3 19:47:20 Maui blueman-mechanism: loading RfKill
May  3 19:47:20 Maui blueman-mechanism: loading Ppp
May  3 19:47:20 Maui blueman-mechanism: loading Rfcomm
May  3 19:47:21 Maui bluetoothd[32743]: src/adapter.c:property_set_mode() sending Set Powered command for index 0
May  3 19:47:21 Maui bluetoothd[32743]: src/adapter.c:dev_class_changed_callback() Class: 0x0c0104
May  3 19:47:21 Maui bluetoothd[32743]: src/adapter.c:property_set_mode_complete() Success (0x00)
May  3 19:47:21 Maui bluetoothd[32743]: src/adapter.c:new_settings_callback() Settings: 0x00000ad1
May  3 19:47:21 Maui bluetoothd[32743]: src/adapter.c:settings_changed() Changed settings: 0x00000001
May  3 19:47:21 Maui bluetoothd[32743]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
May  3 19:47:21 Maui bluetoothd[32743]: src/adapter.c:trigger_passive_scanning()
May  3 19:47:50 Maui blueman-mechanism: Exiting
May  3 19:48:00 Maui kernel: [128727.647572] usb 3-1.7.3: new full-speed USB device number 60 using ehci-pci
May  3 19:48:00 Maui kernel: [128727.727996] usb 3-1.7.3: New USB device found, idVendor=0944, idProduct=0134
May  3 19:48:00 Maui kernel: [128727.728001] usb 3-1.7.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
May  3 19:48:00 Maui kernel: [128727.728004] usb 3-1.7.3: Product: nanoKONTROL Studio
May  3 19:48:00 Maui kernel: [128727.728007] usb 3-1.7.3: Manufacturer: KORG INC.
May  3 19:48:00 Maui mtp-probe: checking bus 3, device 60: "/sys/devices/pci0000:00/0000:00:16.2/usb3/3-1/3-1.7/3-1.7.3"
May  3 19:48:00 Maui mtp-probe: bus: 3, device: 60 was not an MTP device
May  3 19:48:00 Maui kernel: [128727.784654] TCP: request_sock_TCP: Possible SYN flooding on port 33119. Sending cookies.  Check SNMP counters.
May  3 19:48:00 Maui pulseaudio[27272]: Failed to find a working profile.
May  3 19:48:00 Maui pulseaudio[27272]: Failed to load module "module-alsa-card" (argument: "device_id="4" name="usb-KORG_INC._nanoKONTROL_Studio-00" card_name="alsa_card.usb-KORG_INC._nanoKONTROL_Studio-00" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1""): initialization failed.
May  3 19:48:29 Maui bluetoothd[32743]: src/adapter.c:connected_callback() hci0 device 60:F1:89:28:DA:1F connected eir_len 0
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:device_create() dst 60:F1:89:28:DA:1F
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:device_new() address 60:F1:89:28:DA:1F
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_60_F1_89_28_DA_1F
May  3 19:48:29 Maui bluetoothd[32743]: src/gatt-database.c:connect_cb() New incoming LE ATT connection
May  3 19:48:29 Maui bluetoothd[32743]: attrib/gattrib.c:g_attrib_ref() 0x5568f2ce8100: g_attrib_ref=1
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:load_gatt_db() Restoring 60:F1:89:28:DA:1F gatt database from file
May  3 19:48:29 Maui bluetoothd[32743]: No cache for 60:F1:89:28:DA:1F
May  3 19:48:29 Maui bluetoothd[32743]: src/gatt-client.c:btd_gatt_client_connected() Device connected.
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() Primary services found: 5
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x0001, end: 0x0009, uuid: 00001800-0000-1000-8000-00805f9b34fb
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x000c, end: 0x000f, uuid: 00001801-0000-1000-8000-00805f9b34fb
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x0010, end: 0x0014, uuid: 0000180a-0000-1000-8000-00805f9b34fb
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x0015, end: 0x0018, uuid: d0611e78-bbb4-4591-a5f8-487910ae4366
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x0019, end: 0x001c, uuid: 03b80e5a-ede8-4b33-a751-6ce34ec4c700
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() Secondary service discovery failed. ATT ECODE: 0x0a
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() Characteristics found: 4
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x0002, end: 0x0003, value: 0x0003, props: 0x02, uuid: 00002a00-0000-1
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x0004, end: 0x0005, value: 0x0005, props: 0x02, uuid: 00002a01-0000-1
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x0006, end: 0x0007, value: 0x0007, props: 0x0a, uuid: 00002a02-0000-1
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x0008, end: 0x0009, value: 0x0009, props: 0x02, uuid: 00002a04-0000-1
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() Characteristics found: 1
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x000d, end: 0x000f, value: 0x000e, props: 0x22, uuid: 00002a05-0000-1
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() Descriptors found: 1
May  3 19:48:29 Maui bluetoothd[32743]: src/device.c:gatt_debug() handle: 0x000f, uuid: 00002902-0000-1000-8000-00805f9b34fb
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() Characteristics found: 2
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x0011, end: 0x0012, value: 0x0012, props: 0x02, uuid: 00002a29-0000-1
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x0013, end: 0x0014, value: 0x0014, props: 0x02, uuid: 00002a24-0000-1
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() Characteristics found: 1
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x0016, end: 0x0018, value: 0x0017, props: 0x18, uuid: 8667556c-9a37-4
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() Descriptors found: 1
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() handle: 0x0018, uuid: 00002902-0000-1000-8000-00805f9b34fb
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() Characteristics found: 1
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() start: 0x001a, end: 0x001c, value: 0x001b, props: 0x16, uuid: 7772e5db-3868-4
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() Descriptors found: 1
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() handle: 0x001c, uuid: 00002902-0000-1000-8000-00805f9b34fb
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_client_ready_cb() status: success, error: 0
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:btd_device_set_temporary() temporary 0
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_probe_profiles() Probing profiles for device 60:F1:89:28:DA:1F
May  3 19:48:30 Maui bluetoothd[32743]: profiles/gap/gas.c:gap_probe() GAP profile probe (60:F1:89:28:DA:1F)
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: unavailable -> disconnected (0)
May  3 19:48:30 Maui bluetoothd[32743]: profiles/gap/gas.c:gap_accept() GAP profile accept (60:F1:89:28:DA:1F)
May  3 19:48:30 Maui bluetoothd[32743]: profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 00002a02-0000-1000-8000-00805f9b34fb
May  3 19:48:30 Maui bluetoothd[32743]: profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 00002a04-0000-1000-8000-00805f9b34fb
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: disconnected -> connected (0)
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_probe_profiles() Probing profiles for device 60:F1:89:28:DA:1F
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_probe_profiles() Probing profiles for device 60:F1:89:28:DA:1F
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: unavailable -> disconnected (0)
May  3 19:48:30 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:deviceinfo_accept() deviceinfo profile accept (60:F1:89:28:DA:1F)
May  3 19:48:30 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported characteristic: 00002a29-0000-1000-8000-00805f9b34fb
May  3 19:48:30 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported characteristic: 00002a24-0000-1000-8000-00805f9b34fb
May  3 19:48:30 Maui bluetoothd[32743]: Failed to create secure directory (/root/.config/pulse): Permission denied
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: disconnected -> connected (0)
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_probe_profiles() Probing profiles for device 60:F1:89:28:DA:1F
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_probe_profiles() Probing profiles for device 60:F1:89:28:DA:1F
May  3 19:48:30 Maui bluetoothd[32743]: profiles/midi/midi.c:midi_device_probe() MIDI GATT Driver profile probe (60:F1:89:28:DA:1F)
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: unavailable -> disconnected (0)
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_set_auto_connect() 60:F1:89:28:DA:1F auto connect: 1
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_set_auto_connect() Already connected
May  3 19:48:30 Maui bluetoothd[32743]: profiles/midi/midi.c:midi_accept() MIDI GATT Driver profile accept (60:F1:89:28:DA:1F)
May  3 19:48:30 Maui bluetoothd[32743]: profiles/midi/midi.c:handle_midi_io() MIDI I/O handle: 0x001b
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnected -> connected (0)
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:btd_service_ref() 0x5568f2ce87b0: ref=2
May  3 19:48:30 Maui bluetoothd[32743]: plugins/policy.c:service_cb() Added MIDI GATT Driver reconnect 0
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:btd_gatt_client_ready() GATT client ready
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:create_services() Exporting objects for GATT services: 60:F1:89:28:DA:1F
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:service_create() Exported GATT service: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service000c
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service000c/char000d
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:descriptor_create() Exported GATT characteristic descriptor: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service000c/char000d/desc000f
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:service_create() Exported GATT service: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0010
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0010/char0011
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0010/char0013
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:service_create() Exported GATT service: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0015
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0015/char0016
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:descriptor_create() Exported GATT characteristic descriptor: /org/bluez/hci0/dev_60_F1_89_28_DA_1F/service0015/char0016/desc0018
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_60_F1_89_28_DA_1F err 0
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:add_device_complete() 60:F1:89:28:DA:1F (1) added to kernel connect list
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:gatt_debug() Registered handler for "Service Changed": 1
May  3 19:48:30 Maui bluetoothd[32743]: profiles/gap/gas.c:read_device_name_cb() GAP Device Name: nanoKONTROL Studio
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:btd_device_device_set_name() /org/bluez/hci0/dev_60_F1_89_28_DA_1F nanoKONTROL Studio
May  3 19:48:30 Maui bluetoothd[32743]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0080
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0x5
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() bonding (nil) status 0x05
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() status 5
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:dev_disconnected() Device 60:F1:89:28:DA:1F disconnected, reason 2
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:adapter_remove_connection()
May  3 19:48:30 Maui bluetoothd[32743]: plugins/policy.c:disconnect_cb() reason 2
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0xe
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() status 14
May  3 19:48:30 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:30 Maui bluetoothd[32743]: MIDI I/O: Failed to read initial request
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:att_disconnected_cb()
May  3 19:48:30 Maui bluetoothd[32743]: src/device.c:att_disconnected_cb() Software caused connection abort (103)
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: connected -> disconnecting (0)
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: disconnecting -> disconnected (0)
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: connected -> disconnecting (0)
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: disconnecting -> disconnected (0)
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: connected -> disconnecting (0)
May  3 19:48:30 Maui bluetoothd[32743]: profiles/midi/midi.c:midi_disconnect() MIDI GATT Driver profile disconnect (60:F1:89:28:DA:1F)
May  3 19:48:30 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnecting -> disconnected (0)
May  3 19:48:30 Maui bluetoothd[32743]: src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. Cleaning up.
May  3 19:48:30 Maui bluetoothd[32743]: attrib/gattrib.c:g_attrib_unref() 0x5568f2ce8100: g_attrib_unref=0
May  3 19:48:31 Maui bluetoothd[32743]: src/adapter.c:connected_callback() hci0 device 60:F1:89:28:DA:1F connected eir_len 21
May  3 19:48:31 Maui bluetoothd[32743]: src/gatt-database.c:connect_cb() New incoming LE ATT connection
May  3 19:48:31 Maui bluetoothd[32743]: attrib/gattrib.c:g_attrib_ref() 0x5568f2d0aa60: g_attrib_ref=1
May  3 19:48:31 Maui bluetoothd[32743]: profiles/gap/gas.c:gap_accept() GAP profile accept (60:F1:89:28:DA:1F)
May  3 19:48:31 Maui bluetoothd[32743]: profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 00002a02-0000-1000-8000-00805f9b34fb
May  3 19:48:31 Maui bluetoothd[32743]: profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 00002a04-0000-1000-8000-00805f9b34fb
May  3 19:48:31 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: disconnected -> connected (0)
May  3 19:48:31 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:deviceinfo_accept() deviceinfo profile accept (60:F1:89:28:DA:1F)
May  3 19:48:31 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported characteristic: 00002a29-0000-1000-8000-00805f9b34fb
May  3 19:48:31 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported characteristic: 00002a24-0000-1000-8000-00805f9b34fb
May  3 19:48:31 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: disconnected -> connected (0)
May  3 19:48:31 Maui bluetoothd[32743]: profiles/midi/midi.c:midi_accept() MIDI GATT Driver profile accept (60:F1:89:28:DA:1F)
May  3 19:48:31 Maui bluetoothd[32743]: profiles/midi/midi.c:handle_midi_io() MIDI I/O handle: 0x001b
May  3 19:48:31 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnected -> connected (0)
May  3 19:48:31 Maui bluetoothd[32743]: plugins/policy.c:service_cb() Added MIDI GATT Driver reconnect 0
May  3 19:48:31 Maui bluetoothd[32743]: src/gatt-client.c:btd_gatt_client_connected() Device connected.
May  3 19:48:31 Maui bluetoothd[32743]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
May  3 19:48:31 Maui bluetoothd[32743]: profiles/gap/gas.c:read_device_name_cb() GAP Device Name: nanoKONTROL Studio
May  3 19:48:31 Maui bluetoothd[32743]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0080
May  3 19:48:31 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0x5
May  3 19:48:31 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() bonding (nil) status 0x05
May  3 19:48:31 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() status 5
May  3 19:48:31 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:31 Maui bluetoothd[32743]: src/adapter.c:dev_disconnected() Device 60:F1:89:28:DA:1F disconnected, reason 2
May  3 19:48:31 Maui bluetoothd[32743]: src/adapter.c:adapter_remove_connection()
May  3 19:48:31 Maui bluetoothd[32743]: plugins/policy.c:disconnect_cb() reason 2
May  3 19:48:31 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0xe
May  3 19:48:31 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
May  3 19:48:31 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() status 14
May  3 19:48:31 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:31 Maui bluetoothd[32743]: MIDI I/O: Failed to read initial request
May  3 19:48:31 Maui bluetoothd[32743]: src/device.c:gatt_debug() Primary service discovery failed. ATT ECODE: 0x00
May  3 19:48:31 Maui bluetoothd[32743]: src/device.c:gatt_debug() Failed to initialize gatt-client
May  3 19:48:31 Maui bluetoothd[32743]: src/device.c:gatt_client_ready_cb() status: failed, error: 0
May  3 19:48:31 Maui bluetoothd[32743]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_60_F1_89_28_DA_1F err -5
May  3 19:48:31 Maui bluetoothd[32743]: src/device.c:att_disconnected_cb()
May  3 19:48:31 Maui bluetoothd[32743]: src/device.c:att_disconnected_cb() Software caused connection abort (103)
May  3 19:48:31 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: connected -> disconnecting (0)
May  3 19:48:31 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: disconnecting -> disconnected (0)
May  3 19:48:31 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: connected -> disconnecting (0)
May  3 19:48:31 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: disconnecting -> disconnected (0)
May  3 19:48:31 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: connected -> disconnecting (0)
May  3 19:48:31 Maui bluetoothd[32743]: profiles/midi/midi.c:midi_disconnect() MIDI GATT Driver profile disconnect (60:F1:89:28:DA:1F)
May  3 19:48:31 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnecting -> disconnected (0)
May  3 19:48:31 Maui bluetoothd[32743]: src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. Cleaning up.
May  3 19:48:31 Maui bluetoothd[32743]: attrib/gattrib.c:g_attrib_unref() 0x5568f2d0aa60: g_attrib_unref=0
May  3 19:48:32 Maui bluetoothd[32743]: src/adapter.c:connected_callback() hci0 device 60:F1:89:28:DA:1F connected eir_len 21
May  3 19:48:32 Maui bluetoothd[32743]: src/gatt-database.c:connect_cb() New incoming LE ATT connection
May  3 19:48:32 Maui bluetoothd[32743]: attrib/gattrib.c:g_attrib_ref() 0x5568f2d0aa60: g_attrib_ref=1
May  3 19:48:32 Maui bluetoothd[32743]: profiles/gap/gas.c:gap_accept() GAP profile accept (60:F1:89:28:DA:1F)
May  3 19:48:32 Maui bluetoothd[32743]: profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 00002a02-0000-1000-8000-00805f9b34fb
May  3 19:48:32 Maui bluetoothd[32743]: profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 00002a04-0000-1000-8000-00805f9b34fb
May  3 19:48:32 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: disconnected -> connected (0)
May  3 19:48:32 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:deviceinfo_accept() deviceinfo profile accept (60:F1:89:28:DA:1F)
May  3 19:48:32 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported characteristic: 00002a29-0000-1000-8000-00805f9b34fb
May  3 19:48:32 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported characteristic: 00002a24-0000-1000-8000-00805f9b34fb
May  3 19:48:32 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: disconnected -> connected (0)
May  3 19:48:32 Maui bluetoothd[32743]: profiles/midi/midi.c:midi_accept() MIDI GATT Driver profile accept (60:F1:89:28:DA:1F)
May  3 19:48:32 Maui bluetoothd[32743]: profiles/midi/midi.c:handle_midi_io() MIDI I/O handle: 0x001b
May  3 19:48:32 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnected -> connected (0)
May  3 19:48:32 Maui bluetoothd[32743]: plugins/policy.c:service_cb() Added MIDI GATT Driver reconnect 0
May  3 19:48:32 Maui bluetoothd[32743]: src/gatt-client.c:btd_gatt_client_connected() Device connected.
May  3 19:48:32 Maui bluetoothd[32743]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
May  3 19:48:32 Maui bluetoothd[32743]: profiles/gap/gas.c:read_device_name_cb() GAP Device Name: nanoKONTROL Studio
May  3 19:48:33 Maui bluetoothd[32743]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0080
May  3 19:48:33 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0x5
May  3 19:48:33 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() bonding (nil) status 0x05
May  3 19:48:33 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() status 5
May  3 19:48:33 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:33 Maui bluetoothd[32743]: src/adapter.c:dev_disconnected() Device 60:F1:89:28:DA:1F disconnected, reason 2
May  3 19:48:33 Maui bluetoothd[32743]: src/adapter.c:adapter_remove_connection()
May  3 19:48:33 Maui bluetoothd[32743]: plugins/policy.c:disconnect_cb() reason 2
May  3 19:48:33 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0xe
May  3 19:48:33 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
May  3 19:48:33 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() status 14
May  3 19:48:33 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:33 Maui bluetoothd[32743]: MIDI I/O: Failed to read initial request
May  3 19:48:33 Maui bluetoothd[32743]: src/device.c:gatt_debug() Primary service discovery failed. ATT ECODE: 0x00
May  3 19:48:33 Maui bluetoothd[32743]: src/device.c:gatt_debug() Failed to initialize gatt-client
May  3 19:48:33 Maui bluetoothd[32743]: src/device.c:gatt_client_ready_cb() status: failed, error: 0
May  3 19:48:33 Maui bluetoothd[32743]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_60_F1_89_28_DA_1F err -5
May  3 19:48:33 Maui bluetoothd[32743]: src/device.c:att_disconnected_cb()
May  3 19:48:33 Maui bluetoothd[32743]: src/device.c:att_disconnected_cb() Software caused connection abort (103)
May  3 19:48:33 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: connected -> disconnecting (0)
May  3 19:48:33 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: disconnecting -> disconnected (0)
May  3 19:48:33 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: connected -> disconnecting (0)
May  3 19:48:33 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: disconnecting -> disconnected (0)
May  3 19:48:33 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: connected -> disconnecting (0)
May  3 19:48:33 Maui bluetoothd[32743]: profiles/midi/midi.c:midi_disconnect() MIDI GATT Driver profile disconnect (60:F1:89:28:DA:1F)
May  3 19:48:33 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnecting -> disconnected (0)
May  3 19:48:33 Maui bluetoothd[32743]: src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. Cleaning up.
May  3 19:48:33 Maui bluetoothd[32743]: attrib/gattrib.c:g_attrib_unref() 0x5568f2d0aa60: g_attrib_unref=0
May  3 19:48:34 Maui bluetoothd[32743]: src/adapter.c:connected_callback() hci0 device 60:F1:89:28:DA:1F connected eir_len 21
May  3 19:48:34 Maui bluetoothd[32743]: src/gatt-database.c:connect_cb() New incoming LE ATT connection
May  3 19:48:34 Maui bluetoothd[32743]: attrib/gattrib.c:g_attrib_ref() 0x5568f2d0c2d0: g_attrib_ref=1
May  3 19:48:34 Maui bluetoothd[32743]: profiles/gap/gas.c:gap_accept() GAP profile accept (60:F1:89:28:DA:1F)
May  3 19:48:34 Maui bluetoothd[32743]: profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 00002a02-0000-1000-8000-00805f9b34fb
May  3 19:48:34 Maui bluetoothd[32743]: profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 00002a04-0000-1000-8000-00805f9b34fb
May  3 19:48:34 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: disconnected -> connected (0)
May  3 19:48:34 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:deviceinfo_accept() deviceinfo profile accept (60:F1:89:28:DA:1F)
May  3 19:48:34 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported characteristic: 00002a29-0000-1000-8000-00805f9b34fb
May  3 19:48:34 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported characteristic: 00002a24-0000-1000-8000-00805f9b34fb
May  3 19:48:34 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: disconnected -> connected (0)
May  3 19:48:34 Maui bluetoothd[32743]: profiles/midi/midi.c:midi_accept() MIDI GATT Driver profile accept (60:F1:89:28:DA:1F)
May  3 19:48:34 Maui bluetoothd[32743]: profiles/midi/midi.c:handle_midi_io() MIDI I/O handle: 0x001b
May  3 19:48:34 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnected -> connected (0)
May  3 19:48:34 Maui bluetoothd[32743]: plugins/policy.c:service_cb() Added MIDI GATT Driver reconnect 0
May  3 19:48:34 Maui bluetoothd[32743]: src/gatt-client.c:btd_gatt_client_connected() Device connected.
May  3 19:48:34 Maui bluetoothd[32743]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
May  3 19:48:34 Maui bluetoothd[32743]: profiles/gap/gas.c:read_device_name_cb() GAP Device Name: nanoKONTROL Studio
May  3 19:48:34 Maui bluetoothd[32743]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0080
May  3 19:48:34 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0x5
May  3 19:48:34 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() bonding (nil) status 0x05
May  3 19:48:34 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() status 5
May  3 19:48:34 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:34 Maui bluetoothd[32743]: src/adapter.c:dev_disconnected() Device 60:F1:89:28:DA:1F disconnected, reason 2
May  3 19:48:34 Maui bluetoothd[32743]: src/adapter.c:adapter_remove_connection()
May  3 19:48:34 Maui bluetoothd[32743]: plugins/policy.c:disconnect_cb() reason 2
May  3 19:48:34 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0xe
May  3 19:48:34 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
May  3 19:48:34 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() status 14
May  3 19:48:34 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:34 Maui bluetoothd[32743]: MIDI I/O: Failed to read initial request
May  3 19:48:34 Maui bluetoothd[32743]: src/device.c:gatt_debug() Primary service discovery failed. ATT ECODE: 0x00
May  3 19:48:34 Maui bluetoothd[32743]: src/device.c:gatt_debug() Failed to initialize gatt-client
May  3 19:48:34 Maui bluetoothd[32743]: src/device.c:gatt_client_ready_cb() status: failed, error: 0
May  3 19:48:34 Maui bluetoothd[32743]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_60_F1_89_28_DA_1F err -5
May  3 19:48:34 Maui bluetoothd[32743]: src/device.c:att_disconnected_cb()
May  3 19:48:34 Maui bluetoothd[32743]: src/device.c:att_disconnected_cb() Software caused connection abort (103)
May  3 19:48:34 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: connected -> disconnecting (0)
May  3 19:48:34 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: disconnecting -> disconnected (0)
May  3 19:48:34 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: connected -> disconnecting (0)
May  3 19:48:34 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: disconnecting -> disconnected (0)
May  3 19:48:34 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: connected -> disconnecting (0)
May  3 19:48:34 Maui bluetoothd[32743]: profiles/midi/midi.c:midi_disconnect() MIDI GATT Driver profile disconnect (60:F1:89:28:DA:1F)
May  3 19:48:34 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnecting -> disconnected (0)
May  3 19:48:34 Maui bluetoothd[32743]: src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. Cleaning up.
May  3 19:48:34 Maui bluetoothd[32743]: attrib/gattrib.c:g_attrib_unref() 0x5568f2d0c2d0: g_attrib_unref=0
May  3 19:48:35 Maui bluetoothd[32743]: src/adapter.c:connected_callback() hci0 device 60:F1:89:28:DA:1F connected eir_len 21
May  3 19:48:35 Maui bluetoothd[32743]: src/gatt-database.c:connect_cb() New incoming LE ATT connection
May  3 19:48:35 Maui bluetoothd[32743]: attrib/gattrib.c:g_attrib_ref() 0x5568f2d0c2d0: g_attrib_ref=1
May  3 19:48:35 Maui bluetoothd[32743]: profiles/gap/gas.c:gap_accept() GAP profile accept (60:F1:89:28:DA:1F)
May  3 19:48:35 Maui bluetoothd[32743]: profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 00002a02-0000-1000-8000-00805f9b34fb
May  3 19:48:35 Maui bluetoothd[32743]: profiles/gap/gas.c:handle_characteristic() Unsupported characteristic: 00002a04-0000-1000-8000-00805f9b34fb
May  3 19:48:35 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: disconnected -> connected (0)
May  3 19:48:35 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:deviceinfo_accept() deviceinfo profile accept (60:F1:89:28:DA:1F)
May  3 19:48:35 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported characteristic: 00002a29-0000-1000-8000-00805f9b34fb
May  3 19:48:35 Maui bluetoothd[32743]: profiles/deviceinfo/deviceinfo.c:handle_characteristic() Unsupported characteristic: 00002a24-0000-1000-8000-00805f9b34fb
May  3 19:48:35 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: disconnected -> connected (0)
May  3 19:48:35 Maui bluetoothd[32743]: profiles/midi/midi.c:midi_accept() MIDI GATT Driver profile accept (60:F1:89:28:DA:1F)
May  3 19:48:35 Maui bluetoothd[32743]: profiles/midi/midi.c:handle_midi_io() MIDI I/O handle: 0x001b
May  3 19:48:35 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnected -> connected (0)
May  3 19:48:35 Maui bluetoothd[32743]: plugins/policy.c:service_cb() Added MIDI GATT Driver reconnect 0
May  3 19:48:35 Maui bluetoothd[32743]: src/gatt-client.c:btd_gatt_client_connected() Device connected.
May  3 19:48:35 Maui bluetoothd[32743]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
May  3 19:48:35 Maui bluetoothd[32743]: profiles/gap/gas.c:read_device_name_cb() GAP Device Name: nanoKONTROL Studio
May  3 19:48:35 Maui bluetoothd[32743]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance: 0x0080
May  3 19:48:36 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0x5
May  3 19:48:36 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() bonding (nil) status 0x05
May  3 19:48:36 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() status 5
May  3 19:48:36 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:36 Maui kernel: [128763.055431] usb 3-1.7.3: USB disconnect, device number 60
May  3 19:48:36 Maui kernel: [128763.088726] TCP: request_sock_TCP: Possible SYN flooding on port 39295. Sending cookies.  Check SNMP counters.
May  3 19:48:36 Maui bluetoothd[32743]: src/adapter.c:dev_disconnected() Device 60:F1:89:28:DA:1F disconnected, reason 1
May  3 19:48:36 Maui bluetoothd[32743]: src/adapter.c:adapter_remove_connection()
May  3 19:48:36 Maui bluetoothd[32743]: plugins/policy.c:disconnect_cb() reason 1
May  3 19:48:36 Maui bluetoothd[32743]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 60:F1:89:28:DA:1F type 1 status 0xe
May  3 19:48:36 Maui bluetoothd[32743]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
May  3 19:48:36 Maui bluetoothd[32743]: src/device.c:device_bonding_failed() status 14
May  3 19:48:36 Maui bluetoothd[32743]: src/adapter.c:resume_discovery()
May  3 19:48:36 Maui bluetoothd[32743]: MIDI I/O: Failed to read initial request
May  3 19:48:36 Maui bluetoothd[32743]: src/device.c:gatt_debug() Primary service discovery failed. ATT ECODE: 0x00
May  3 19:48:36 Maui bluetoothd[32743]: src/device.c:gatt_debug() Failed to initialize gatt-client
May  3 19:48:36 Maui bluetoothd[32743]: src/device.c:gatt_client_ready_cb() status: failed, error: 0
May  3 19:48:36 Maui bluetoothd[32743]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_60_F1_89_28_DA_1F err -5
May  3 19:48:36 Maui bluetoothd[32743]: src/device.c:att_disconnected_cb()
May  3 19:48:36 Maui bluetoothd[32743]: src/device.c:att_disconnected_cb() Connection timed out (110)
May  3 19:48:36 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: connected -> disconnecting (0)
May  3 19:48:36 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2cec150: device 60:F1:89:28:DA:1F profile gap-profile state changed: disconnecting -> disconnected (0)
May  3 19:48:36 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: connected -> disconnecting (0)
May  3 19:48:36 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce8720: device 60:F1:89:28:DA:1F profile deviceinfo state changed: disconnecting -> disconnected (0)
May  3 19:48:36 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: connected -> disconnecting (0)
May  3 19:48:36 Maui bluetoothd[32743]: profiles/midi/midi.c:midi_disconnect() MIDI GATT Driver profile disconnect (60:F1:89:28:DA:1F)
May  3 19:48:36 Maui bluetoothd[32743]: src/service.c:change_state() 0x5568f2ce87b0: device 60:F1:89:28:DA:1F profile MIDI GATT Driver state changed: disconnecting -> disconnected (0)
May  3 19:48:36 Maui bluetoothd[32743]: src/gatt-client.c:btd_gatt_client_disconnected() Device disconnected. Cleaning up.
May  3 19:48:36 Maui bluetoothd[32743]: attrib/gattrib.c:g_attrib_unref() 0x5568f2d0c2d0: g_attrib_unref=0


--------------E06E46533C2ECD808386FD4F
Content-Type: text/x-vcard; charset=utf-8;
 name="Robert_Schneider.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Robert_Schneider.vcf"

begin:vcard
fn:Robert Schneider
n:Schneider;Robert
email;internet:Robert.Schneider@aramar.de
tel;home:+49 8139 92850
tel;cell:+49 176 3892 7669
version:2.1
end:vcard


--------------E06E46533C2ECD808386FD4F--
