Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 01 Dec 2011 18:15:51 +0100
From: krisztian.kocsis@optimaster.eu
To: <linux-bluetooth@vger.kernel.org>
Subject: Cracking Sound (bluez output)
Message-ID: <eedb84740072cc74570108db34816519@optimaster.eu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here is the BlueZ output (it seems that everything is OK):

bluetoothd[2678]: Bluetooth daemon 4.96
bluetoothd[2678]: src/main.c:parse_config() parsing main.conf
bluetoothd[2678]: src/main.c:parse_config() discovto=0
bluetoothd[2678]: src/main.c:parse_config() pairto=0
bluetoothd[2678]: src/main.c:parse_config() pageto=8192
bluetoothd[2678]: src/main.c:parse_config() name=%h-%d
bluetoothd[2678]: src/main.c:parse_config() class=0x000100
bluetoothd[2678]: src/main.c:parse_config() discov_interval=30
bluetoothd[2678]: src/main.c:parse_config() Key file does not have key 
'DeviceID'
bluetoothd[2678]: Starting SDP server
bluetoothd[2678]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[2678]: src/plugin.c:add_plugin() Loading audio plugin
bluetoothd[2678]: Excluding (conf) input
bluetoothd[2678]: Excluding (conf) serial
bluetoothd[2678]: Excluding (conf) network
bluetoothd[2678]: src/plugin.c:add_plugin() Loading service plugin
bluetoothd[2678]: src/plugin.c:add_plugin() Loading hciops plugin
bluetoothd[2678]: src/plugin.c:add_plugin() Loading mgmtops plugin
bluetoothd[2678]: src/plugin.c:add_plugin() Loading formfactor plugin
bluetoothd[2678]: src/plugin.c:add_plugin() Loading storage plugin
bluetoothd[2678]: src/plugin.c:add_plugin() Loading adaptername plugin
bluetoothd[2678]: src/plugin.c:plugin_init() Loading plugins 
/afc/lib/bluetooth/plugins
bluetoothd[2678]: plugins/service.c:register_interface() path 
/org/bluez/2678/any
bluetoothd[2678]: plugins/service.c:register_interface() Registered 
interface org.bluez.Service on path /org/bluez/2678/any
bluetoothd[2678]: audio/unix.c:unix_init() Unix socket created: 8
bluetoothd[2678]: plugins/hciops.c:hciops_init()
bluetoothd[2678]: plugins/hciops.c:hciops_setup()
bluetoothd[2678]: src/main.c:main() Entering main loop
bluetoothd[2678]: plugins/hciops.c:init_known_adapters()
bluetoothd[2678]: plugins/hciops.c:init_device() hci0
bluetoothd[2678]: Listening for HCI events on hci0
bluetoothd[2678]: plugins/hciops.c:init_device() child 2679 forked
bluetoothd[2678]: plugins/hciops.c:child_exit() child 2679 exited
bluetoothd[2678]: HCI dev 0 up
bluetoothd[2678]: plugins/hciops.c:device_devup_setup() hci0
bluetoothd[2678]: plugins/hciops.c:read_local_features_complete() Got 
features for hci0
bluetoothd[2678]: plugins/hciops.c:read_local_version_complete() Got 
version for hci0
bluetoothd[2678]: plugins/hciops.c:read_bd_addr_complete() hci0 status 
0
bluetoothd[2678]: plugins/hciops.c:read_bd_addr_complete() Got bdaddr 
for hci0
bluetoothd[2678]: plugins/hciops.c:read_local_name_complete() hci0 
status 0
bluetoothd[2678]: plugins/hciops.c:read_local_name_complete() Got name 
for hci0
bluetoothd[2678]: src/adapter.c:btd_adapter_ref() 0x200b5690: ref=1
bluetoothd[2678]: plugins/hciops.c:hciops_read_bdaddr() hci0
bluetoothd[2678]: src/sdpd-database.c:sdp_init_services_list()
bluetoothd[2678]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2678]: plugins/hciops.c:update_service_classes() hci0 value 
0
bluetoothd[2678]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2678]: plugins/hciops.c:update_service_classes() hci0 value 
0
bluetoothd[2678]: plugins/service.c:register_interface() path 
/org/bluez/2678/hci0
bluetoothd[2678]: plugins/service.c:register_interface() Registered 
interface org.bluez.Service on path /org/bluez/2678/hci0
bluetoothd[2678]: audio/manager.c:headset_server_probe() path 
/org/bluez/2678/hci0
bluetoothd[2678]: src/adapter.c:btd_adapter_ref() 0x200b5690: ref=2
bluetoothd[2678]: audio/manager.c:audio_adapter_ref() 0x200b5860: ref=1
bluetoothd[2678]: audio/manager.c:state_changed() /org/bluez/2678/hci0 
powered on
bluetoothd[2678]: audio/telephony.c:telephony_init()
bluetoothd[2678]: audio/headset.c:telephony_ready_ind() Telephony 
plugin initialized
bluetoothd[2678]: audio/headset.c:print_ag_features() HFP AG features: 
"Ability to reject a call" "Enhanced call status" "Extended Error Result 
Codes"
bluetoothd[2678]: audio/manager.c:headset_server_init() audio.conf: Key 
file does not have key 'Master'
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Adding 
record with handle 0x10000
bluetoothd[2678]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2678]: plugins/hciops.c:update_service_classes() hci0 value 
0
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[2678]: audio/headset.c:headset_config_init() audio.conf: Key 
file does not have key 'FastConnectable'
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Adding 
record with handle 0x10001
bluetoothd[2678]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2678]: plugins/hciops.c:update_service_classes() hci0 value 
64
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[2678]: audio/manager.c:a2dp_server_probe() path 
/org/bluez/2678/hci0
bluetoothd[2678]: audio/manager.c:audio_adapter_ref() 0x200b5860: ref=2
bluetoothd[2678]: audio/a2dp.c:a2dp_register() audio.conf: Key file 
does not have key 'Enable'
bluetoothd[2678]: audio/a2dp.c:a2dp_register() audio.conf: Key file 
does not have key 'Disable'
bluetoothd[2678]: audio/a2dp.c:a2dp_register() audio.conf: Key file 
does not have group 'A2DP'
bluetoothd[2678]: audio/a2dp.c:a2dp_register() audio.conf: Key file 
does not have group 'A2DP'
bluetoothd[2678]: audio/a2dp.c:a2dp_register() audio.conf: Key file 
does not have group 'A2DP'
bluetoothd[2678]: audio/a2dp.c:a2dp_register() audio.conf: Key file 
does not have group 'A2DP'
bluetoothd[2678]: audio/avdtp.c:avdtp_init() audio.conf: Key file does 
not have key 'Master'
bluetoothd[2678]: audio/avdtp.c:avdtp_register_sep() SEP 0x200b6a70 
registered: type:0 codec:0 seid:1
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Adding 
record with handle 0x10002
bluetoothd[2678]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2678]: plugins/hciops.c:update_service_classes() hci0 value 
72
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[2678]: audio/manager.c:avrcp_server_probe() path 
/org/bluez/2678/hci0
bluetoothd[2678]: audio/manager.c:audio_adapter_ref() 0x200b5860: ref=3
bluetoothd[2678]: audio/control.c:avrcp_register() audio.conf: Key file 
does not have key 'Master'
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Adding 
record with handle 0x10003
bluetoothd[2678]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2678]: plugins/hciops.c:update_service_classes() hci0 value 
72
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Adding 
record with handle 0x10004
bluetoothd[2678]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2678]: plugins/hciops.c:update_service_classes() hci0 value 
72
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2678]: src/sdpd-service.c:add_record_to_server() Record 
pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[2678]: plugins/adaptername.c:adaptername_probe() Setting 
name 'Viper-0' for device 'hci0'
bluetoothd[2678]: plugins/hciops.c:hciops_set_name() hci0, name Viper-0
bluetoothd[2678]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2678]: Could not get the contents of DMI chassis type
bluetoothd[2678]: plugins/hciops.c:hciops_unblock_device() hci0 dba 
00:00:00:00:00:00
bluetoothd[2678]: Clearing blocked list failed: Invalid argument (22)
bluetoothd[2678]: src/device.c:device_create() Creating device 
/org/bluez/2678/hci0/dev_50_C9_71_0B_E2_3B
bluetoothd[2678]: src/device.c:device_set_bonded() bonded 1
bluetoothd[2678]: src/device.c:btd_device_ref() 0x200b7b48: ref=1
bluetoothd[2678]: src/device.c:device_set_temporary() temporary 0
bluetoothd[2678]: src/device.c:device_probe_drivers() Probing drivers 
for 50:C9:71:0B:E2:3B
bluetoothd[2678]: src/adapter.c:adapter_get_device() 50:C9:71:0B:E2:3B
bluetoothd[2678]: src/device.c:btd_device_ref() 0x200b7b48: ref=2
bluetoothd[2678]: audio/device.c:audio_device_register() Registered 
interface org.bluez.Audio on path 
/org/bluez/2678/hci0/dev_50_C9_71_0B_E2_3B
bluetoothd[2678]: audio/manager.c:handle_uuid() Found Headset record
bluetoothd[2678]: audio/headset.c:headset_init() Registered interface 
org.bluez.Headset on path /org/bluez/2678/hci0/dev_50_C9_71_0B_E2_3B
bluetoothd[2678]: audio/manager.c:handle_uuid() Found Handsfree record
bluetoothd[2678]: src/device.c:device_create() Creating device 
/org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2678]: src/device.c:device_set_bonded() bonded 1
bluetoothd[2678]: src/device.c:btd_device_ref() 0x200b9538: ref=1
bluetoothd[2678]: src/device.c:device_set_temporary() temporary 0
bluetoothd[2678]: src/device.c:device_probe_drivers() Probing drivers 
for 00:07:A4:EE:8F:03
bluetoothd[2678]: src/adapter.c:adapter_get_device() 00:07:A4:EE:8F:03
bluetoothd[2678]: src/device.c:btd_device_ref() 0x200b9538: ref=2
bluetoothd[2678]: audio/device.c:audio_device_register() Registered 
interface org.bluez.Audio on path 
/org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2678]: audio/manager.c:handle_uuid() Found Headset record
bluetoothd[2678]: audio/headset.c:headset_init() Registered interface 
org.bluez.Headset on path /org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2678]: audio/manager.c:handle_uuid() Found Handsfree record
bluetoothd[2678]: plugins/hciops.c:hciops_load_keys() hci0 keys 2 
debug_keys 0
bluetoothd[2678]: plugins/hciops.c:hciops_get_conn_list() hci0
bluetoothd[2678]: src/manager.c:btd_manager_register_adapter() Adapter 
/org/bluez/2678/hci0 registered
bluetoothd[2678]: src/adapter.c:btd_adapter_ref() 0x200b5690: ref=3
bluetoothd[2678]: plugins/hciops.c:hciops_set_name() hci0, name Viper-0
bluetoothd[2678]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2678]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 
minor 0
bluetoothd[2678]: audio/manager.c:state_changed() /org/bluez/2678/hci0 
powered on
bluetoothd[2678]: plugins/hciops.c:hciops_disable_cod_cache() hci0 
cache_enable 1
bluetoothd[2678]: plugins/hciops.c:hciops_disable_cod_cache() hci0 
current_cod 0x000000 wanted_cod 0x480100
bluetoothd[2678]: plugins/hciops.c:write_class() hci0 class 0x480100
bluetoothd[2678]: Adapter /org/bluez/2678/hci0 has been enabled
bluetoothd[2678]: plugins/hciops.c:hciops_set_discoverable() hci0 
discoverable 0
bluetoothd[2678]: plugins/hciops.c:hciops_set_pairable() hci0 pairable 
1
bluetoothd[2678]: src/adapter.c:btd_adapter_unref() 0x200b5690: ref=2
bluetoothd[2678]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2678]: plugins/hciops.c:read_local_name_complete() hci0 
status 0
bluetoothd[2678]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2678]: plugins/hciops.c:read_local_name_complete() hci0 
status 0
bluetoothd[2678]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2678]: plugins/hciops.c:read_scan_complete() hci0 status 0
bluetoothd[2678]: src/adapter.c:adapter_mode_changed() old 0x00 new 
0x02
bluetoothd[2678]: src/adapter.c:adapter_set_limited_discoverable() 
FALSE
bluetoothd[2678]: plugins/hciops.c:hciops_set_limited_discoverable() 
hci0 limited 0
bluetoothd[2678]: src/adapter.c:set_mode_complete()
bluetoothd[2678]: audio/unix.c:server_cb() Accepted new client 
connection on unix socket (fd=19)
bluetoothd[2678]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- 
BT_GET_CAPABILITIES
bluetoothd[2678]: audio/unix.c:unix_ipc_sendmsg() Audio API: 
BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[2678]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- 
BT_OPEN
bluetoothd[2678]: audio/unix.c:handle_sco_open() open sco - object=ANY 
source=ANY destination=00:07:A4:EE:8F:03 lock=write
bluetoothd[2678]: audio/unix.c:unix_ipc_sendmsg() Audio API: 
BT_RESPONSE -> BT_OPEN
bluetoothd[2678]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- 
BT_SET_CONFIGURATION
bluetoothd[2678]: audio/headset.c:headset_set_state() State changed 
/org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_DISCONNECTED 
-> HEADSET_STATE_CONNECTING



bluetoothd[2678]: plugins/hciops.c:link_key_request() hci0 dba 
00:07:A4:EE:8F:03
bluetoothd[2678]: plugins/hciops.c:get_auth_info() hci0 dba 
00:07:A4:EE:8F:03
bluetoothd[2678]: plugins/hciops.c:link_key_request() kernel auth 
requirements = 0xff
bluetoothd[2678]: plugins/hciops.c:link_key_request() Matching key 
found
bluetoothd[2678]: plugins/hciops.c:link_key_request() link key type 
0x00

bluetoothd[2678]: audio/headset.c:headset_set_channel() Discovered 
Handsfree service on channel 2
bluetoothd[2678]: audio/headset.c:rfcomm_connect() 
/org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03: Connecting to 
00:07:A4:EE:8F:03 channel 2
bluetoothd[2678]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[2678]: src/adapter.c:adapter_get_device() 00:07:A4:EE:8F:03
bluetoothd[2678]: plugins/hciops.c:bonding_complete() status 0x00
bluetoothd[2678]: src/event.c:btd_event_bonding_complete() status 0x00
bluetoothd[2678]: src/adapter.c:adapter_get_device() 00:07:A4:EE:8F:03
bluetoothd[2678]: src/device.c:device_bonding_complete() bonding (nil) 
status 0x00
bluetoothd[2678]: audio/headset.c:headset_connect_cb() 
/org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03: Connected to 
00:07:A4:EE:8F:03
bluetoothd[2678]: audio/headset.c:handle_event() Received AT+BRSF=26
bluetoothd[2678]: audio/headset.c:print_hf_features() HFP HF features: 
"Call waiting and 3-way calling" "Voice recognition activation" "Remote 
volume control"
bluetoothd[2678]: plugins/hciops.c:remote_features_information() hci0 
status 0
bluetoothd[2678]: audio/headset.c:handle_event() Received AT+CIND=?
bluetoothd[2678]: audio/headset.c:handle_event() Received AT+CIND?
bluetoothd[2678]: audio/headset.c:handle_event() Received 
AT+CMER=3,0,0,1
bluetoothd[2678]: audio/headset.c:event_reporting() Event reporting 
(CMER): mode=3, ind=1
bluetoothd[2678]: audio/headset.c:hfp_slc_complete() HFP Service Level 
Connection established
bluetoothd[2678]: audio/telephony.c:telephony_device_connected() 
telephony-dummy: device 0x200ba140 connected
bluetoothd[2678]: audio/headset.c:headset_set_state() State changed 
/org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_CONNECTING -> 
HEADSET_STATE_CONNECTED
bluetoothd[2678]: audio/unix.c:unix_ipc_sendmsg() Audio API: 
BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[2678]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- 
BT_START_STREAM
bluetoothd[2678]: audio/headset.c:headset_set_state() State changed 
/org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_CONNECTED -> 
HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2678]: audio/headset.c:sco_connect_cb() SCO socket opened 
for headset /org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2678]: audio/headset.c:sco_connect_cb() SCO fd=20
bluetoothd[2678]: audio/unix.c:unix_ipc_sendmsg() Audio API: 
BT_RESPONSE -> BT_START_STREAM
bluetoothd[2678]: audio/unix.c:unix_ipc_sendmsg() Audio API: 
BT_INDICATION -> BT_NEW_STREAM
bluetoothd[2678]: audio/headset.c:headset_set_state() State changed 
/org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03: 
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[2678]: audio/headset.c:handle_event() Received AT+VGS=15
bluetoothd[2678]: audio/headset.c:headset_set_gain() Ignoring no-change 
in speaker gain
bluetoothd[2678]: audio/unix.c:client_cb() Unix client disconnected 
(fd=19)
bluetoothd[2678]: audio/headset.c:headset_set_state() State changed 
/org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_PLAYING -> 
HEADSET_STATE_CONNECTED
bluetoothd[2678]: audio/unix.c:client_free() client_free(0x200b5320)
bluetoothd[2678]: plugins/hciops.c:disconn_complete() handle 2 status 
0x00
bluetoothd[2678]: audio/telephony.c:telephony_device_disconnected() 
telephony-dummy: device 0x200ba140 disconnected
bluetoothd[2678]: audio/headset.c:headset_set_state() State changed 
/org/bluez/2678/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_CONNECTED -> 
HEADSET_STATE_DISCONNECTED
bluetoothd[2678]: plugins/hciops.c:disconn_complete() handle 1 status 
0x00
bluetoothd[2678]: src/event.c:btd_event_disconn_complete()
bluetoothd[2678]: src/adapter.c:adapter_remove_connection()

BR,
Krisztian

