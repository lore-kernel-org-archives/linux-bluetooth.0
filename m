Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Austin Riffle <ARiffle@efji.com>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: Failing to receive Serial Port Profile DBus method callbacks.
Date: Tue, 21 Nov 2017 04:40:14 +0000
Message-ID: <4C851F03BEE04A418B7A2D283DDCAB5D35F8FE7E@EFJDFWMB01.EFJDFW.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I'm writing my own application that uses the DBus API to create and manage =
profiles. Specifically, I am looking at HSP and SPP. I am using BlueZ 5.46 =
and Linux Kernel 4.12.0. My situation is that I have a remote Bluetooth dev=
ice which is connected via HSP, then a SPP connection follows. After that I=
 disconnect and then try to reconnect. However, sometimes during disconnect=
 SPP is not always being disconnected. I can reproduce this usually by simp=
ly powering off the remote device. I captured a bluetoothd log and think I =
see the issue, but I'm unsure how to move forward with it - and whether it =
indicates a BlueZ error, or an error in my application code. The log is pas=
ted at the bottom of this message. Line 208 seems very suspect:

bluetoothd[1350]: Unable to get io data for spp: getpeername: Transport end=
point is not connected (107)

 Any thoughts?

Austin

bluetoothd[1350]: Bluetooth daemon 5.46
bluetoothd[1350]: Unknown key FastConnectable in main.conf
bluetoothd[1350]: src/main.c:parse_config() parsing main.conf
bluetoothd[1350]: src/main.c:parse_config() discovto=3D120
bluetoothd[1350]: src/main.c:parse_config() pairto=3D0
bluetoothd[1350]: src/main.c:parse_config() auto_to=3D60
bluetoothd[1350]: src/main.c:parse_config() privacy=3Doff
bluetoothd[1350]: src/main.c:parse_config() name=3Dxxx Subscriber
bluetoothd[1350]: src/main.c:parse_config() class=3D0x620204
bluetoothd[1350]: src/main.c:parse_config() Key file does not have key "Dev=
iceID" in group "General"
bluetoothd[1350]: src/main.c:parse_config() ControllerMode=3Dbredr
bluetoothd[1350]: src/main.c:parse_config() MultiProfile=3Dmultiple
bluetoothd[1350]: src/adapter.c:adapter_init() sending read version command
bluetoothd[1350]: Starting SDP server
bluetoothd[1350]: src/sdpd-service.c:register_device_id() Adding device id =
record for 0002:1d6b:0246:052e
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Adding record w=
ith handle 0x10001
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00001002-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 0000113a-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 0000113b-0000-1000-8000-00805f9
bluetoothd[1350]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[1350]: src/plugin.c:add_plugin() Loading hostname plugin
bluetoothd[1350]: Excluding (cli) wiimote
bluetoothd[1350]: src/plugin.c:add_plugin() Loading autopair plugin
bluetoothd[1350]: src/plugin.c:add_plugin() Loading policy plugin
bluetoothd[1350]: Excluding (cli) a2dp
bluetoothd[1350]: Excluding (cli) avrcp
bluetoothd[1350]: Excluding (cli) network
bluetoothd[1350]: Excluding (cli) input
bluetoothd[1350]: src/plugin.c:add_plugin() Loading hog plugin
bluetoothd[1350]: src/plugin.c:add_plugin() Loading gap plugin
bluetoothd[1350]: src/plugin.c:add_plugin() Loading scanparam plugin
bluetoothd[1350]: src/plugin.c:add_plugin() Loading deviceinfo plugin
bluetoothd[1350]: src/plugin.c:plugin_init() Loading plugins /usr/lib/bluet=
ooth/plugins
bluetoothd[1350]: profiles/input/suspend-none.c:suspend_init()
bluetoothd[1350]: src/main.c:main() Entering main loop
bluetoothd[1350]: src/rfkill.c:rfkill_event() RFKILL event idx 0 type 2 op =
0 soft 0 hard 0
bluetoothd[1350]: Bluetooth management interface 1.14 initialized
bluetoothd[1350]: src/adapter.c:read_version_complete() sending read suppor=
ted commands command
bluetoothd[1350]: src/adapter.c:read_version_complete() sending read index =
list command
bluetoothd[1350]: src/adapter.c:read_commands_complete() Number of commands=
: 65
bluetoothd[1350]: src/adapter.c:read_commands_complete() Number of events: =
35
bluetoothd[1350]: src/adapter.c:read_commands_complete() enabling kernel-si=
de connection control
bluetoothd[1350]: src/adapter.c:read_index_list_complete() Number of contro=
llers: 1
bluetoothd[1350]: src/adapter.c:read_index_list_complete() Found index 0
bluetoothd[1350]: src/adapter.c:index_added() index 0
bluetoothd[1350]: src/adapter.c:btd_adapter_new() System name: xxx Subscrib=
er
bluetoothd[1350]: src/adapter.c:btd_adapter_new() Major class: 2
bluetoothd[1350]: src/adapter.c:btd_adapter_new() Minor class: 1
bluetoothd[1350]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d=
052E
bluetoothd[1350]: src/adapter.c:btd_adapter_new() Discoverable timeout: 120=
 seconds
bluetoothd[1350]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 secon=
ds
bluetoothd[1350]: src/adapter.c:index_added() sending read info command for=
 index 0
bluetoothd[1350]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[1350]: src/adapter.c:clear_uuids() sending clear uuids command f=
or index 0
bluetoothd[1350]: src/adapter.c:clear_devices() sending clear devices comma=
nd for index 0
bluetoothd[1350]: src/adapter.c:set_mode() sending set mode command for ind=
ex 0
bluetoothd[1350]: src/adapter.c:set_mode() sending set mode command for ind=
ex 0
bluetoothd[1350]: src/adapter.c:set_privacy() sending set privacy command f=
or index 0
bluetoothd[1350]: src/adapter.c:set_privacy() setting privacy mode 0x00 for=
 index 0
bluetoothd[1350]: src/adapter.c:set_mode() sending set mode command for ind=
ex 0
bluetoothd[1350]: src/gatt-database.c:btd_gatt_database_new() GATT Manager =
registered for adapter: /org/bluez/hci0
bluetoothd[1350]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Adding record w=
ith handle 0x10002
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00000007-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00000100-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00001002-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00001800-0000-1000-8000-00805f9
bluetoothd[1350]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[1350]: src/adapter.c:add_uuid() sending add uuid command for ind=
ex 0
bluetoothd[1350]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Adding record w=
ith handle 0x10003
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00000007-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00000100-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00001002-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00001801-0000-1000-8000-00805f9
bluetoothd[1350]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[1350]: src/adapter.c:add_uuid() sending add uuid command for ind=
ex 0
bluetoothd[1350]: plugins/policy.c:policy_adapter_probe()
bluetoothd[1350]: src/adapter.c:set_mode() sending set mode command for ind=
ex 0
bluetoothd[1350]: plugins/hostname.c:hostname_probe()
bluetoothd[1350]: src/adapter.c:btd_adapter_unblock_address() hci0 00:00:00=
:00:00:00
bluetoothd[1350]: src/adapter.c:get_ltk_info() 00:12:6F:11:8F:F8
bluetoothd[1350]: src/device.c:device_create_from_storage() address 00:12:6=
F:11:8F:F8
bluetoothd[1350]: src/device.c:device_new() address 00:12:6F:11:8F:F8
bluetoothd[1350]: src/device.c:device_new() Creating device /org/bluez/hci0=
/dev_00_12_6F_11_8F_F8
bluetoothd[1350]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[1350]: src/device.c:device_set_bonded()
bluetoothd[1350]: src/adapter.c:get_ltk_info() 00:12:6F:7E:C9:8C
bluetoothd[1350]: src/device.c:device_create_from_storage() address 00:12:6=
F:7E:C9:8C
bluetoothd[1350]: src/device.c:device_new() address 00:12:6F:7E:C9:8C
bluetoothd[1350]: src/device.c:device_new() Creating device /org/bluez/hci0=
/dev_00_12_6F_7E_C9_8C
bluetoothd[1350]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[1350]: src/device.c:device_set_bonded()
bluetoothd[1350]: src/adapter.c:get_ltk_info() 20:FA:BB:07:08:75
bluetoothd[1350]: src/device.c:device_create_from_storage() address 20:FA:B=
B:07:08:75
bluetoothd[1350]: src/device.c:device_new() address 20:FA:BB:07:08:75
bluetoothd[1350]: src/device.c:device_new() Creating device /org/bluez/hci0=
/dev_20_FA_BB_07_08_75
bluetoothd[1350]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[1350]: src/device.c:device_set_bonded()
bluetoothd[1350]: src/adapter.c:load_link_keys() hci0 keys 3 debug_keys 0
bluetoothd[1350]: src/adapter.c:load_ltks() hci0 keys 0
bluetoothd[1350]: src/adapter.c:load_irks() hci0 irks 0
bluetoothd[1350]: src/adapter.c:load_conn_params() hci0 conn params 0
bluetoothd[1350]: src/device.c:device_probe_profiles() Probing profiles for=
 device 00:12:6F:11:8F:F8
bluetoothd[1350]: src/device.c:device_probe_profiles() Probing profiles for=
 device 00:12:6F:7E:C9:8C
bluetoothd[1350]: src/device.c:device_probe_profiles() Probing profiles for=
 device 20:FA:BB:07:08:75
bluetoothd[1350]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[1350]: src/adapter.c:add_uuid() sending add uuid command for ind=
ex 0
bluetoothd[1350]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b product=
 246 version 52e
bluetoothd[1350]: src/adapter.c:adapter_register() Adapter /org/bluez/hci0 =
registered
bluetoothd[1350]: src/adapter.c:set_dev_class() sending set device class co=
mmand for index 0
bluetoothd[1350]: src/adapter.c:set_name() sending set local name command f=
or index 0
bluetoothd[1350]: src/adapter.c:set_mode() sending set mode command for ind=
ex 0
bluetoothd[1350]: src/adapter.c:new_settings_callback() Settings: 0x000000c=
0
bluetoothd[1350]: src/adapter.c:settings_changed() Changed settings: 0x0000=
0040
bluetoothd[1350]: Failed to set mode: Not Supported (0x0c)
bluetoothd[1350]: src/adapter.c:set_privacy_complete() Successfuly set priv=
acy for index 0
bluetoothd[1350]: src/adapter.c:new_settings_callback() Settings: 0x000000c=
4
bluetoothd[1350]: src/adapter.c:settings_changed() Changed settings: 0x0000=
0004
bluetoothd[1350]: src/adapter.c:dev_class_changed_callback() Class: 0x00000=
0
bluetoothd[1350]: src/adapter.c:new_settings_callback() Settings: 0x000000c=
5
bluetoothd[1350]: src/adapter.c:settings_changed() Changed settings: 0x0000=
0001
bluetoothd[1350]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has=
 been enabled
bluetoothd[1350]: src/adapter.c:add_whitelist_complete() 00:12:6F:11:8F:F8 =
added to kernel whitelist
bluetoothd[1350]: src/adapter.c:add_whitelist_complete() 00:12:6F:7E:C9:8C =
added to kernel whitelist
bluetoothd[1350]: src/adapter.c:add_whitelist_complete() 20:FA:BB:07:08:75 =
added to kernel whitelist
bluetoothd[1350]: src/adapter.c:load_link_keys_complete() link keys loaded =
for hci0
bluetoothd[1350]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[1350]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
bluetoothd[1350]: src/adapter.c:load_conn_params_complete() Connection Para=
meters loaded for hci0
bluetoothd[1350]: src/adapter.c:dev_class_changed_callback() Class: 0x00020=
4
bluetoothd[1350]: src/adapter.c:local_name_changed_callback() Name: RadioDo=
ngle
bluetoothd[1350]: src/adapter.c:local_name_changed_callback() Short name:
bluetoothd[1350]: src/adapter.c:local_name_changed_callback() Current alias=
: RadioDongle
bluetoothd[1350]: src/adapter.c:new_settings_callback() Settings: 0x000000d=
5
bluetoothd[1350]: src/adapter.c:settings_changed() Changed settings: 0x0000=
0010
bluetoothd[1350]: src/agent.c:agent_ref() 0xd1a30: ref=3D1
bluetoothd[1350]: src/agent.c:register_agent() agent :1.0
bluetoothd[1350]: src/agent.c:add_default_agent() Default agent set to :1.0=
 /org/xxx/bluetooth/agent
bluetoothd[1350]: src/profile.c:register_profile() sender :1.0
bluetoothd[1350]: src/profile.c:create_ext() Created "spp"
bluetoothd[1350]: src/profile.c:ext_adapter_probe() "spp" probed
bluetoothd[1350]: src/profile.c:ext_start_servers() spp listening on chan 3
bluetoothd[1350]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Adding record w=
ith handle 0x10004
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00000003-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00000100-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00001002-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00001101-0000-1000-8000-00805f9
bluetoothd[1350]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[1350]: src/adapter.c:add_uuid() sending add uuid command for ind=
ex 0
bluetoothd[1350]: src/profile.c:ext_device_probe() spp probed with UUID 000=
01101-0000-1000-8000-00805f9b34fb
bluetoothd[1350]: src/service.c:change_state() 0xd1a10: device 00:12:6F:11:=
8F:F8 profile spp state changed: unavailable -> disconnected (0)
bluetoothd[1350]: src/profile.c:ext_device_probe() spp probed with UUID 000=
01101-0000-1000-8000-00805f9b34fb
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: unavailable -> disconnected (0)
bluetoothd[1350]: src/profile.c:register_profile() sender :1.0
bluetoothd[1350]: src/profile.c:create_ext() Created "hspag"
bluetoothd[1350]: src/profile.c:ext_adapter_probe() "hspag" probed
bluetoothd[1350]: src/profile.c:ext_start_servers() hspag listening on chan=
 12
bluetoothd[1350]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Adding record w=
ith handle 0x10005
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00000003-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00000100-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00001002-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00001108-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00001112-0000-1000-8000-00805f9
bluetoothd[1350]: src/sdpd-service.c:add_record_to_server() Record pattern =
UUID 00001203-0000-1000-8000-00805f9
bluetoothd[1350]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[1350]: src/adapter.c:add_uuid() sending add uuid command for ind=
ex 0
bluetoothd[1350]: src/profile.c:ext_device_probe() hspag probed with UUID 0=
0001108-0000-1000-8000-00805f9b34fb
bluetoothd[1350]: src/service.c:change_state() 0xcfc70: device 00:12:6F:11:=
8F:F8 profile hspag state changed: unavailable -> disconnected (0)
bluetoothd[1350]: src/profile.c:ext_device_probe() hspag probed with UUID 0=
0001108-0000-1000-8000-00805f9b34fb
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: unavailable -> disconnected (0)
bluetoothd[1350]: src/profile.c:ext_device_probe() hspag probed with UUID 0=
0001108-0000-1000-8000-00805f9b34fb
bluetoothd[1350]: src/service.c:change_state() 0xd3b38: device 20:FA:BB:07:=
08:75 profile hspag state changed: unavailable -> disconnected (0)
bluetoothd[1350]: src/adapter.c:connected_callback() hci0 device 00:12:6F:7=
E:C9:8C connected eir_len 5
bluetoothd[1350]: src/service.c:btd_service_ref() 0xd3b18: ref=3D2
bluetoothd[1350]: src/profile.c:ext_connect() hspag connected to 00:12:6F:7=
E:C9:8C
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: disconnected -> connecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: connecting -> connected (0)
bluetoothd[1350]: src/device.c:device_profile_connected() hspag Success (0)
bluetoothd[1350]: src/service.c:btd_service_ref() 0xd3b18: ref=3D3
bluetoothd[1350]: plugins/policy.c:service_cb() Added hspag reconnect 1
bluetoothd[1350]: src/service.c:btd_service_ref() 0xd02d8: ref=3D2
bluetoothd[1350]: src/profile.c:ext_connect() spp connected to 00:12:6F:7E:=
C9:8C
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: disconnected -> connecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: connecting -> connected (0)
bluetoothd[1350]: src/device.c:device_profile_connected() spp Success (0)
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: connected -> disconnecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: connected -> disconnecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: disconnecting -> disconnected (0)
bluetoothd[1350]: src/service.c:btd_service_unref() 0xd02d8: ref=3D1
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: disconnecting -> disconnected (0)
bluetoothd[1350]: src/service.c:btd_service_unref() 0xd3b18: ref=3D2
bluetoothd[1350]: src/adapter.c:dev_disconnected() Device 00:12:6F:7E:C9:8C=
 disconnected, reason 2
bluetoothd[1350]: src/adapter.c:adapter_remove_connection()
bluetoothd[1350]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[1350]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:1=
2:6F:7E:C9:8C type 0 status 0xe
bluetoothd[1350]: src/device.c:device_bonding_complete() bonding (nil) stat=
us 0x0e
bluetoothd[1350]: src/device.c:device_bonding_failed() status 14
bluetoothd[1350]: src/adapter.c:resume_discovery()
bluetoothd[1350]: src/device.c:connect_profiles() /org/bluez/hci0/dev_00_12=
_6F_7E_C9_8C 00001108-0000-1000-8000-00805f9b34fb, client :1.0
bluetoothd[1350]: src/service.c:btd_service_ref() 0xd3b18: ref=3D3
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: disconnected -> connecting (0)
bluetoothd[1350]: src/adapter.c:connected_callback() hci0 device 00:12:6F:7=
E:C9:8C connected eir_len 9
bluetoothd[1350]: src/profile.c:ext_connect() hspag connected to 00:12:6F:7=
E:C9:8C
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: connecting -> connected (0)
bluetoothd[1350]: src/device.c:device_profile_connected() hspag Success (0)
bluetoothd[1350]: src/device.c:device_profile_connected() returning respons=
e to :1.0
bluetoothd[1350]: plugins/policy.c:service_cb() Added hspag reconnect 1
bluetoothd[1350]: src/service.c:btd_service_ref() 0xd02d8: ref=3D2
bluetoothd[1350]: src/profile.c:ext_connect() spp connected to 00:12:6F:7E:=
C9:8C
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: disconnected -> connecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: connecting -> connected (0)
bluetoothd[1350]: src/device.c:device_profile_connected() spp Success (0)
bluetoothd[1350]: sdp_extract_attr: Unknown data descriptor : 0x3a terminat=
ing

bluetoothd[1350]: src/device.c:search_cb() 00:12:6F:7E:C9:8C: No service up=
date
bluetoothd[1350]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_00=
_12_6F_7E_C9_8C err 0
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: connected -> disconnecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: connected -> disconnecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: disconnecting -> disconnected (0)
bluetoothd[1350]: src/service.c:btd_service_unref() 0xd02d8: ref=3D1
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: disconnecting -> disconnected (0)
bluetoothd[1350]: src/service.c:btd_service_unref() 0xd3b18: ref=3D2
bluetoothd[1350]: src/adapter.c:dev_disconnected() Device 00:12:6F:7E:C9:8C=
 disconnected, reason 2
bluetoothd[1350]: src/adapter.c:adapter_remove_connection()
bluetoothd[1350]: plugins/policy.c:disconnect_cb() reason 2
bluetoothd[1350]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:1=
2:6F:7E:C9:8C type 0 status 0xe
bluetoothd[1350]: src/device.c:device_bonding_complete() bonding (nil) stat=
us 0x0e
bluetoothd[1350]: src/device.c:device_bonding_failed() status 14
bluetoothd[1350]: src/adapter.c:resume_discovery()
bluetoothd[1350]: src/device.c:connect_profiles() /org/bluez/hci0/dev_00_12=
_6F_7E_C9_8C 00001108-0000-1000-8000-00805f9b34fb, client :1.0
bluetoothd[1350]: src/service.c:btd_service_ref() 0xd3b18: ref=3D3
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: disconnected -> connecting (0)
bluetoothd[1350]: src/adapter.c:connected_callback() hci0 device 00:12:6F:7=
E:C9:8C connected eir_len 9
bluetoothd[1350]: src/profile.c:ext_connect() hspag connected to 00:12:6F:7=
E:C9:8C
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: connecting -> connected (0)
bluetoothd[1350]: src/device.c:device_profile_connected() hspag Success (0)
bluetoothd[1350]: src/device.c:device_profile_connected() returning respons=
e to :1.0
bluetoothd[1350]: plugins/policy.c:service_cb() Added hspag reconnect 1
bluetoothd[1350]: src/service.c:btd_service_ref() 0xd02d8: ref=3D2
bluetoothd[1350]: src/profile.c:ext_connect() spp connected to 00:12:6F:7E:=
C9:8C
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: disconnected -> connecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: connecting -> connected (0)
bluetoothd[1350]: src/device.c:device_profile_connected() spp Success (0)
bluetoothd[1350]: sdp_extract_attr: Unknown data descriptor : 0x1 terminati=
ng

bluetoothd[1350]: src/device.c:search_cb() 00:12:6F:7E:C9:8C: No service up=
date
bluetoothd[1350]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_00=
_12_6F_7E_C9_8C err 0
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: connected -> disconnecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: connected -> disconnecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: disconnecting -> disconnected (0)
bluetoothd[1350]: src/service.c:btd_service_unref() 0xd02d8: ref=3D1
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: disconnecting -> disconnected (0)
bluetoothd[1350]: src/service.c:btd_service_unref() 0xd3b18: ref=3D2
bluetoothd[1350]: src/adapter.c:dev_disconnected() Device 00:12:6F:7E:C9:8C=
 disconnected, reason 3
bluetoothd[1350]: src/adapter.c:adapter_remove_connection()
bluetoothd[1350]: plugins/policy.c:disconnect_cb() reason 3
bluetoothd[1350]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:1=
2:6F:7E:C9:8C type 0 status 0xe
bluetoothd[1350]: src/device.c:device_bonding_complete() bonding (nil) stat=
us 0x0e
bluetoothd[1350]: src/device.c:device_bonding_failed() status 14
bluetoothd[1350]: src/adapter.c:resume_discovery()
bluetoothd[1350]: src/device.c:connect_profiles() /org/bluez/hci0/dev_00_12=
_6F_7E_C9_8C 00001108-0000-1000-8000-00805f9b34fb, client :1.0
bluetoothd[1350]: src/service.c:btd_service_ref() 0xd3b18: ref=3D3
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: disconnected -> connecting (0)
bluetoothd[1350]: src/adapter.c:connected_callback() hci0 device 00:12:6F:7=
E:C9:8C connected eir_len 9
bluetoothd[1350]: src/profile.c:ext_connect() hspag connected to 00:12:6F:7=
E:C9:8C
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: connecting -> connected (0)
bluetoothd[1350]: src/device.c:device_profile_connected() hspag Success (0)
bluetoothd[1350]: src/device.c:device_profile_connected() returning respons=
e to :1.0
bluetoothd[1350]: plugins/policy.c:service_cb() Added hspag reconnect 1
bluetoothd[1350]: src/service.c:btd_service_ref() 0xd02d8: ref=3D2
bluetoothd[1350]: src/profile.c:ext_connect() spp connected to 00:12:6F:7E:=
C9:8C
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: disconnected -> connecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: connecting -> connected (0)
bluetoothd[1350]: src/device.c:device_profile_connected() spp Success (0)
bluetoothd[1350]: src/device.c:search_cb() 00:12:6F:7E:C9:8C: No service up=
date
bluetoothd[1350]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_00=
_12_6F_7E_C9_8C err 0
bluetoothd[1350]: Unable to get io data for spp: getpeername: Transport end=
point is not connected (107)
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: connected -> disconnected (0)
bluetoothd[1350]: src/service.c:btd_service_unref() 0xd02d8: ref=3D1
bluetoothd[1350]: Unable to get io data for hspag: getpeername: Transport e=
ndpoint is not connected (107)
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: connected -> disconnected (0)
bluetoothd[1350]: src/service.c:btd_service_unref() 0xd3b18: ref=3D2
bluetoothd[1350]: src/adapter.c:dev_disconnected() Device 00:12:6F:7E:C9:8C=
 disconnected, reason 3
bluetoothd[1350]: src/adapter.c:adapter_remove_connection()
bluetoothd[1350]: plugins/policy.c:disconnect_cb() reason 3
bluetoothd[1350]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:1=
2:6F:7E:C9:8C type 0 status 0xe
bluetoothd[1350]: src/device.c:device_bonding_complete() bonding (nil) stat=
us 0x0e
bluetoothd[1350]: src/device.c:device_bonding_failed() status 14
bluetoothd[1350]: src/adapter.c:resume_discovery()
bluetoothd[1350]: src/adapter.c:connected_callback() hci0 device 00:12:6F:7=
E:C9:8C connected eir_len 5
bluetoothd[1350]: src/service.c:btd_service_ref() 0xd3b18: ref=3D3
bluetoothd[1350]: src/profile.c:ext_connect() hspag connected to 00:12:6F:7=
E:C9:8C
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: disconnected -> connecting (0)
bluetoothd[1350]: src/service.c:change_state() 0xd3b18: device 00:12:6F:7E:=
C9:8C profile hspag state changed: connecting -> connected (0)
bluetoothd[1350]: src/device.c:device_profile_connected() hspag Success (0)
bluetoothd[1350]: plugins/policy.c:service_cb() Added hspag reconnect 1
bluetoothd[1350]: src/service.c:btd_service_ref() 0xd02d8: ref=3D2
bluetoothd[1350]: src/profile.c:ext_connect() spp connected to 00:12:6F:7E:=
C9:8C
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: disconnected -> connecting (0)
bluetoothd[1350]: spp replied with an error: org.freedesktop.DBus.Error.NoR=
eply, Did not receive a reply. Possible causes include: the remote applicat=
ion did not send a reply, the message bus security policy blocked the reply=
, the reply timeout expired, or the network connection was broken.
bluetoothd[1350]: src/service.c:change_state() 0xd02d8: device 00:12:6F:7E:=
C9:8C profile spp state changed: connecting -> disconnected (-111)
bluetoothd[1350]: src/device.c:device_profile_connected() spp Connection re=
fused (111)
bluetoothd[1350]: src/service.c:btd_service_unref() 0xd02d8: ref=3D1

This e-mail transmission, and any documents, files or previous e-mail messa=
ges attached to it, may contain confidential information. If you are not th=
e intended recipient, or a person responsible for delivering it to the inte=
nded recipient, you are hereby notified that any disclosure, distribution, =
review, copy or use of any of the information contained in or attached to t=
his message is STRICTLY PROHIBITED. If you have received this transmission =
in error, please immediately notify us by reply e-mail, and destroy the ori=
ginal transmission and its attachments without reading them or saving them =
to disk. Thank you.

