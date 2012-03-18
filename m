Return-Path: <cyrus@holtmann.org>
Message-ID: <1332044343.2998.8.camel@maxim-laptop>
Subject: bluez doesn't handle hotplug well
From: Maxim Levitsky <maximlevitsky@gmail.com>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 18 Mar 2012 06:19:03 +0200
Content-Type: multipart/mixed; boundary="=-koWDtjP5kfwmxq8gSaIC"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-koWDtjP5kfwmxq8gSaIC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Recently I began using Bluetooth, and I noticed that it sometimes
doesn't work after suspend to ram.

It turns out to be 100% reproduciable and not related to ether bluetooth
dongle (tested 2 of them) nor related to KDE/Gnome - happens in both,
and nether its related to actual suspend.

To reproduce, I just start bluetoothd, then:
1. I plug the dongle, its recognized (or start bluetoothd after I plug
it, doesn't matter)

2. I unplug it.
3. I plug it again, and it is recognized again
4. I unplug it.
5. I plug it, and it doesn't work.

Reproducible, always, tested many times.
restarting bluetoothd fixes the problem until, I repeat the above.

bluetoothd log attached.
I am (still) using ubuntu 12.04.

Best regards,
Maxim Levitsky

--=-koWDtjP5kfwmxq8gSaIC
Content-Disposition: attachment; filename="log"
Content-Type: text/plain; name="log"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

bluetoothd[3135]: Bluetooth daemon 4.98
bluetoothd[3135]: src/main.c:parse_config() parsing main.conf
bluetoothd[3135]: src/main.c:parse_config() discovto=0
bluetoothd[3135]: src/main.c:parse_config() pairto=0
bluetoothd[3135]: src/main.c:parse_config() pageto=8192
bluetoothd[3135]: src/main.c:parse_config() auto_to=60
bluetoothd[3135]: src/main.c:parse_config() name=%h-%d
bluetoothd[3135]: src/main.c:parse_config() class=0x000100
bluetoothd[3135]: src/main.c:parse_config() discov_interval=30
bluetoothd[3135]: src/main.c:parse_config() Key file does not have key 'DeviceID'
bluetoothd[3135]: Starting SDP server
bluetoothd[3135]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[3135]: src/plugin.c:add_plugin() Loading pnat plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading audio plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading sap plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading input plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading serial plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading network plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading proximity plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading service plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading gatt_example plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading time plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading alert plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading health plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading thermometer plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading hciops plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading mgmtops plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading formfactor plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading storage plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading adaptername plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading wiimote plugin
bluetoothd[3135]: src/plugin.c:add_plugin() Loading dbusoob plugin
bluetoothd[3135]: src/plugin.c:plugin_init() Loading plugins /usr/lib/x86_64-linux-gnu/bluetooth/plugins
bluetoothd[3135]: plugins/service.c:register_interface() path /org/bluez/3135/any
bluetoothd[3135]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/3135/any
bluetoothd[3135]: plugins/dbusoob.c:dbusoob_init() Setup dbusoob plugin
bluetoothd[3135]: health/hdp.c:hdp_manager_start() Starting Health manager
bluetoothd[3135]: alert/main.c:alert_init() Attribute server is disabled
bluetoothd[3135]: Failed to init alert plugin
bluetoothd[3135]: time/main.c:time_init() Attribute server is disabled
bluetoothd[3135]: Failed to init time plugin
bluetoothd[3135]: proximity/reporter.c:reporter_init() Attribute server is disabled
bluetoothd[3135]: Failed to init proximity plugin
bluetoothd[3135]: network/manager.c:read_config() /etc/bluetooth/network.conf: Key file does not have key 'DisableSecurity'
bluetoothd[3135]: network/manager.c:read_config() Config options: Security=true
bluetoothd[3135]: input/manager.c:input_manager_init() input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[3135]: audio/manager.c:audio_manager_init() audio.conf: Key file does not have key 'AutoConnect'
bluetoothd[3135]: audio/unix.c:unix_init() Unix socket created: 10
bluetoothd[3135]: plugins/pnat.c:pnat_init() Setup Phonet AT (DUN) plugin
bluetoothd[3135]: plugins/hciops.c:hciops_init() 
bluetoothd[3135]: plugins/gatt-example.c:gatt_example_init() Attribute server is disabled
bluetoothd[3135]: Failed to init gatt_example plugin
bluetoothd[3135]: plugins/hciops.c:hciops_setup() 
bluetoothd[3135]: src/main.c:main() Entering main loop
bluetoothd[3135]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type 1 op 0 soft 0 hard 0
bluetoothd[3135]: src/rfkill.c:rfkill_event() RFKILL event idx 49 type 2 op 0 soft 0 hard 0
bluetoothd[3135]: plugins/hciops.c:init_known_adapters() 
bluetoothd[3135]: plugins/hciops.c:init_device() hci0
bluetoothd[3135]: Listening for HCI events on hci0
bluetoothd[3135]: plugins/hciops.c:init_conn_list() hci0
bluetoothd[3135]: HCI dev 0 up
bluetoothd[3135]: plugins/hciops.c:device_devup_setup() hci0
bluetoothd[3135]: plugins/hciops.c:read_local_version_complete() Got version for hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f903480: ref=1
bluetoothd[3135]: plugins/hciops.c:hciops_read_bdaddr() hci0
bluetoothd[3135]: src/sdpd-database.c:sdp_init_services_list() 
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[3135]: plugins/service.c:register_interface() path /org/bluez/3135/hci0
bluetoothd[3135]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f903480: ref=2
bluetoothd[3135]: network/manager.c:network_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f903480: ref=3
bluetoothd[3135]: network/server.c:server_register() Registered interface org.bluez.NetworkServer on path /org/bluez/3135/hci0
bluetoothd[3135]: serial/manager.c:proxy_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f903480: ref=4
bluetoothd[3135]: serial/proxy.c:proxy_register() Registered interface org.bluez.SerialProxyManager on path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f903480: ref=5
bluetoothd[3135]: sap/manager.c:sap_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10000
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000112d-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001204-0000-1000-8000-00805f9
bluetoothd[3135]: sap/server.c:sap_server_register() Listen socket 0x15
bluetoothd[3135]: audio/manager.c:media_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f903480: ref=6
bluetoothd[3135]: audio/manager.c:audio_adapter_ref() 0x7f371f904d90: ref=1
bluetoothd[3135]: audio/manager.c:headset_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: audio/manager.c:audio_adapter_ref() 0x7f371f904d90: ref=2
bluetoothd[3135]: audio/manager.c:state_changed() /org/bluez/3135/hci0 powered on
bluetoothd[3135]: audio/telephony.c:telephony_init() 
bluetoothd[3135]: audio/headset.c:telephony_ready_ind() Telephony plugin initialized
bluetoothd[3135]: audio/headset.c:print_ag_features() HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[3135]: audio/manager.c:headset_server_init() audio.conf: Key file does not have key 'Master'
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3135]: audio/headset.c:headset_config_init() audio.conf: Key file does not have key 'SCORouting'
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3135]: audio/manager.c:audio_adapter_ref() 0x7f371f904d90: ref=3
bluetoothd[3135]: audio/manager.c:gateway_server_init() audio.conf: Key file does not have key 'Master'
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10003
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 96
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3135]: audio/manager.c:a2dp_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: audio/manager.c:audio_adapter_ref() 0x7f371f904d90: ref=4
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have key 'Enable'
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have key 'Disable'
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3135]: audio/avdtp.c:avdtp_init() audio.conf: Key file does not have key 'Master'
bluetoothd[3135]: audio/avdtp.c:avdtp_register_sep() SEP 0x7f371f906d40 registered: type:0 codec:0 seid:1
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 104
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3135]: audio/avdtp.c:avdtp_register_sep() SEP 0x7f371f9075b0 registered: type:1 codec:0 seid:2
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10005
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 108
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110b-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3135]: audio/manager.c:avrcp_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: audio/manager.c:audio_adapter_ref() 0x7f371f904d90: ref=5
bluetoothd[3135]: audio/avrcp.c:avrcp_register() audio.conf: Key file does not have key 'Master'
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10006
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 108
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10007
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 108
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10008
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 110
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001103-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001201-0000-1000-8000-00805f9
bluetoothd[3135]: plugins/adaptername.c:adaptername_probe() Setting name 'bt123' for device 'hci0'
bluetoothd[3135]: plugins/hciops.c:hciops_set_name() hci0, name bt123
bluetoothd[3135]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[3135]: plugins/formfactor.c:formfactor_probe() Setting 0x000100 for major/minor device class
bluetoothd[3135]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 0
bluetoothd[3135]: plugins/hciops.c:hciops_unblock_device() hci0 dba 00:00:00:00:00:00
bluetoothd[3135]: plugins/hciops.c:hciops_load_keys() hci0 keys 0 debug_keys 0
bluetoothd[3135]: plugins/hciops.c:hciops_get_conn_list() hci0
bluetoothd[3135]: src/manager.c:btd_manager_register_adapter() Adapter /org/bluez/3135/hci0 registered
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f903480: ref=7
bluetoothd[3135]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 0
bluetoothd[3135]: audio/manager.c:state_changed() /org/bluez/3135/hci0 powered on
bluetoothd[3135]: plugins/hciops.c:hciops_disable_cod_cache() hci0 cache_enable 1
bluetoothd[3135]: plugins/hciops.c:hciops_disable_cod_cache() hci0 current_cod 0x000000 wanted_cod 0x6e0100
bluetoothd[3135]: plugins/hciops.c:write_class() hci0 class 0x6e0100
bluetoothd[3135]: Adapter /org/bluez/3135/hci0 has been enabled
bluetoothd[3135]: plugins/hciops.c:hciops_set_discoverable() hci0 discoverable 1
bluetoothd[3135]: plugins/hciops.c:hciops_set_pairable() hci0 pairable 1
bluetoothd[3135]: plugins/hciops.c:hciops_stop_inquiry() hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f903480: ref=6
bluetoothd[3135]: Endpoint registered: sender=:1.498 path=/MediaEndpoint/HFPAG
bluetoothd[3135]: audio/avdtp.c:avdtp_register_sep() SEP 0x7f371f90b3a0 registered: type:0 codec:0 seid:3
bluetoothd[3135]: Endpoint registered: sender=:1.498 path=/MediaEndpoint/A2DPSource
bluetoothd[3135]: audio/avdtp.c:avdtp_register_sep() SEP 0x7f371f90baf0 registered: type:1 codec:0 seid:4
bluetoothd[3135]: Endpoint registered: sender=:1.498 path=/MediaEndpoint/A2DPSink
bluetoothd[3135]: plugins/hciops.c:read_local_ext_features_complete() hci0 status 0
bluetoothd[3135]: src/adapter.c:register_agent() Agent registered for hci0 at :1.607:/blueDevil_agent
bluetoothd[3135]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 126
bluetoothd[3135]: plugins/hciops.c:update_service_classes() Changing service classes to 0x7e0100
bluetoothd[3135]: plugins/hciops.c:write_class() hci0 class 0x7e0100
bluetoothd[3135]: Inquiry Cancel Failed with status 0x12
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 126
bluetoothd[3135]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[3135]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[3135]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[3135]: plugins/hciops.c:read_scan_complete() hci0 status 0
bluetoothd[3135]: src/adapter.c:adapter_mode_changed() old 0x00 new 0x03
bluetoothd[3135]: src/adapter.c:set_mode_complete() 
bluetoothd[3135]: HCI dev 0 down
bluetoothd[3135]: plugins/hciops.c:hciops_stop_discovery() index 0
bluetoothd[3135]: audio/manager.c:state_changed() /org/bluez/3135/hci0 powered off
bluetoothd[3135]: audio/telephony.c:telephony_exit() 
bluetoothd[3135]: audio/headset.c:telephony_deinit() Telephony deinitialized
bluetoothd[3135]: Adapter /org/bluez/3135/hci0 has been disabled
bluetoothd[3135]: src/adapter.c:set_mode_complete() 
bluetoothd[3135]: HCI dev 0 unregistered
bluetoothd[3135]: Stopping hci0 event socket
bluetoothd[3135]: Unregister path: /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:adapter_remove() Removing adapter /org/bluez/3135/hci0
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10008
bluetoothd[3135]: audio/manager.c:avrcp_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10007
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10006
bluetoothd[3135]: audio/manager.c:audio_adapter_unref() 0x7f371f904d90: ref=4
bluetoothd[3135]: audio/manager.c:a2dp_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7f371f9075b0 unregistered: type:1 codec:0 seid:2
bluetoothd[3135]: audio/media.c:release_endpoint() sender=:1.498 path=/MediaEndpoint/A2DPSink
bluetoothd[3135]: Endpoint unregistered: sender=:1.498 path=/MediaEndpoint/A2DPSink
bluetoothd[3135]: audio/media.c:media_endpoint_destroy() sender=:1.498 path=/MediaEndpoint/A2DPSink
bluetoothd[3135]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7f371f90baf0 unregistered: type:1 codec:0 seid:4
bluetoothd[3135]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7f371f906d40 unregistered: type:0 codec:0 seid:1
bluetoothd[3135]: audio/media.c:release_endpoint() sender=:1.498 path=/MediaEndpoint/A2DPSource
bluetoothd[3135]: Endpoint unregistered: sender=:1.498 path=/MediaEndpoint/A2DPSource
bluetoothd[3135]: audio/media.c:media_endpoint_destroy() sender=:1.498 path=/MediaEndpoint/A2DPSource
bluetoothd[3135]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7f371f90b3a0 unregistered: type:0 codec:0 seid:3
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10004
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10005
bluetoothd[3135]: audio/manager.c:audio_adapter_unref() 0x7f371f904d90: ref=3
bluetoothd[3135]: audio/manager.c:gateway_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10003
bluetoothd[3135]: audio/manager.c:audio_adapter_unref() 0x7f371f904d90: ref=2
bluetoothd[3135]: audio/manager.c:headset_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10001
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10002
bluetoothd[3135]: audio/manager.c:audio_adapter_unref() 0x7f371f904d90: ref=1
bluetoothd[3135]: audio/manager.c:media_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: audio/media.c:release_endpoint() sender=:1.498 path=/MediaEndpoint/HFPAG
bluetoothd[3135]: Endpoint unregistered: sender=:1.498 path=/MediaEndpoint/HFPAG
bluetoothd[3135]: audio/media.c:media_endpoint_destroy() sender=:1.498 path=/MediaEndpoint/HFPAG
bluetoothd[3135]: audio/manager.c:audio_adapter_unref() 0x7f371f904d90: ref=0
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f903480: ref=5
bluetoothd[3135]: sap/manager.c:sap_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10000
bluetoothd[3135]: sap/server.c:destroy_sap_interface() Unregistered interface org.bluez.SimAccess on path /org/bluez/3135/hci0
bluetoothd[3135]: sap/server.c:sap_conn_remove() conn (nil)
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f903480: ref=4
bluetoothd[3135]: serial/manager.c:proxy_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f903480: ref=3
bluetoothd[3135]: network/manager.c:network_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: network/server.c:path_unregister() Unregistered interface org.bluez.NetworkServer on path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f903480: ref=2
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f903480: ref=1
bluetoothd[3135]: plugins/service.c:unregister_interface() path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f903480: ref=0
bluetoothd[3135]: src/agent.c:agent_release() Releasing agent :1.607, /blueDevil_agent
bluetoothd[3135]: src/adapter.c:adapter_free() 0x7f371f903480
bluetoothd[3135]: src/rfkill.c:rfkill_event() RFKILL event idx 49 type 2 op 1 soft 0 hard 0
bluetoothd[3135]: HCI dev 0 registered
bluetoothd[3135]: plugins/hciops.c:init_device() hci0
bluetoothd[3135]: Listening for HCI events on hci0
bluetoothd[3135]: plugins/hciops.c:init_device() child 3162 forked
bluetoothd[3135]: src/rfkill.c:rfkill_event() RFKILL event idx 50 type 2 op 0 soft 0 hard 0
bluetoothd[3135]: src/rfkill.c:rfkill_event() RFKILL event idx 50 type 2 op 2 soft 0 hard 0
bluetoothd[3135]: plugins/hciops.c:read_local_features_complete() Got features for hci0
bluetoothd[3135]: plugins/hciops.c:read_local_version_complete() Got version for hci0
bluetoothd[3135]: plugins/hciops.c:read_bd_addr_complete() hci0 status 0
bluetoothd[3135]: plugins/hciops.c:read_bd_addr_complete() Got bdaddr for hci0
bluetoothd[3135]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[3135]: plugins/hciops.c:read_local_name_complete() Got name for hci0
bluetoothd[3135]: plugins/hciops.c:read_local_ext_features_complete() hci0 status 0
bluetoothd[3135]: HCI dev 0 up
bluetoothd[3135]: plugins/hciops.c:device_devup_setup() hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f8ff5b0: ref=1
bluetoothd[3135]: plugins/hciops.c:hciops_read_bdaddr() hci0
bluetoothd[3135]: src/sdpd-database.c:sdp_init_services_list() 
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[3135]: plugins/service.c:register_interface() path /org/bluez/3135/hci0
bluetoothd[3135]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f8ff5b0: ref=2
bluetoothd[3135]: network/manager.c:network_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f8ff5b0: ref=3
bluetoothd[3135]: network/server.c:server_register() Registered interface org.bluez.NetworkServer on path /org/bluez/3135/hci0
bluetoothd[3135]: serial/manager.c:proxy_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f8ff5b0: ref=4
bluetoothd[3135]: serial/proxy.c:proxy_register() Registered interface org.bluez.SerialProxyManager on path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f8ff5b0: ref=5
bluetoothd[3135]: sap/manager.c:sap_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: sap-dummy interface org.bluez.SimAccessTest init failed on path /org/bluez/test
bluetoothd[3135]: Sap driver initialization failed.
bluetoothd[3135]: sap-server: Operation not permitted (1)
bluetoothd[3135]: audio/manager.c:media_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f8ff5b0: ref=6
bluetoothd[3135]: audio/manager.c:audio_adapter_ref() 0x7f371f8ff070: ref=1
bluetoothd[3135]: audio/manager.c:headset_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: audio/manager.c:audio_adapter_ref() 0x7f371f8ff070: ref=2
bluetoothd[3135]: audio/manager.c:state_changed() /org/bluez/3135/hci0 powered on
bluetoothd[3135]: audio/telephony.c:telephony_init() 
bluetoothd[3135]: audio/headset.c:telephony_ready_ind() Telephony plugin initialized
bluetoothd[3135]: audio/headset.c:print_ag_features() HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[3135]: audio/manager.c:headset_server_init() audio.conf: Key file does not have key 'Master'
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10000
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3135]: audio/headset.c:headset_config_init() audio.conf: Key file does not have key 'SCORouting'
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3135]: audio/manager.c:audio_adapter_ref() 0x7f371f8ff070: ref=3
bluetoothd[3135]: audio/manager.c:gateway_server_init() audio.conf: Key file does not have key 'Master'
bluetoothd[3135]: rfcomm_bind: Address already in use (98)
bluetoothd[3135]: audio-gateway: Operation not permitted (1)
bluetoothd[3135]: audio/manager.c:a2dp_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: audio/manager.c:audio_adapter_ref() 0x7f371f8ff070: ref=4
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have key 'Enable'
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have key 'Disable'
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3135]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3135]: audio/avdtp.c:avdtp_init() audio.conf: Key file does not have key 'Master'
bluetoothd[3135]: audio/avdtp.c:avdtp_register_sep() SEP 0x7f371f9055b0 registered: type:0 codec:0 seid:1
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 72
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3135]: audio/avdtp.c:avdtp_register_sep() SEP 0x7f371f905da0 registered: type:1 codec:0 seid:2
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10003
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 76
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110b-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3135]: audio/manager.c:avrcp_server_probe() path /org/bluez/3135/hci0
bluetoothd[3135]: audio/manager.c:audio_adapter_ref() 0x7f371f8ff070: ref=5
bluetoothd[3135]: audio/avrcp.c:avrcp_register() audio.conf: Key file does not have key 'Master'
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 76
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10005
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 76
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10006
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 78
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001103-0000-1000-8000-00805f9
bluetoothd[3135]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001201-0000-1000-8000-00805f9
bluetoothd[3135]: plugins/adaptername.c:adaptername_probe() Setting name 'bt123' for device 'hci0'
bluetoothd[3135]: plugins/hciops.c:hciops_set_name() hci0, name bt123
bluetoothd[3135]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[3135]: plugins/formfactor.c:formfactor_probe() Setting 0x000100 for major/minor device class
bluetoothd[3135]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 0
bluetoothd[3135]: plugins/hciops.c:hciops_unblock_device() hci0 dba 00:00:00:00:00:00
bluetoothd[3135]: plugins/hciops.c:hciops_load_keys() hci0 keys 0 debug_keys 0
bluetoothd[3135]: plugins/hciops.c:hciops_get_conn_list() hci0
bluetoothd[3135]: src/manager.c:btd_manager_register_adapter() Adapter /org/bluez/3135/hci0 registered
bluetoothd[3135]: src/adapter.c:btd_adapter_ref() 0x7f371f8ff5b0: ref=7
bluetoothd[3135]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 0
bluetoothd[3135]: audio/manager.c:state_changed() /org/bluez/3135/hci0 powered on
bluetoothd[3135]: plugins/hciops.c:hciops_disable_cod_cache() hci0 cache_enable 1
bluetoothd[3135]: plugins/hciops.c:hciops_disable_cod_cache() hci0 current_cod 0x000000 wanted_cod 0x4e0100
bluetoothd[3135]: plugins/hciops.c:write_class() hci0 class 0x4e0100
bluetoothd[3135]: Adapter /org/bluez/3135/hci0 has been enabled
bluetoothd[3135]: plugins/hciops.c:hciops_set_discoverable() hci0 discoverable 1
bluetoothd[3135]: plugins/hciops.c:hciops_set_pairable() hci0 pairable 1
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f8ff5b0: ref=6
bluetoothd[3135]: plugins/hciops.c:child_exit() child 3162 exited
bluetoothd[3135]: Endpoint registered: sender=:1.498 path=/MediaEndpoint/HFPAG
bluetoothd[3135]: audio/avdtp.c:avdtp_register_sep() SEP 0x7f371f907df0 registered: type:0 codec:0 seid:3
bluetoothd[3135]: Endpoint registered: sender=:1.498 path=/MediaEndpoint/A2DPSource
bluetoothd[3135]: audio/avdtp.c:avdtp_register_sep() SEP 0x7f371f908250 registered: type:1 codec:0 seid:4
bluetoothd[3135]: Endpoint registered: sender=:1.498 path=/MediaEndpoint/A2DPSink
bluetoothd[3135]: plugins/hciops.c:read_local_ext_features_complete() hci0 status 0
bluetoothd[3135]: src/adapter.c:register_agent() Agent registered for hci0 at :1.607:/blueDevil_agent
bluetoothd[3135]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 94
bluetoothd[3135]: plugins/hciops.c:update_service_classes() Changing service classes to 0x5e0100
bluetoothd[3135]: plugins/hciops.c:write_class() hci0 class 0x5e0100
bluetoothd[3135]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[3135]: plugins/hciops.c:update_service_classes() hci0 value 94
bluetoothd[3135]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[3135]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[3135]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[3135]: plugins/hciops.c:read_scan_complete() hci0 status 0
bluetoothd[3135]: src/adapter.c:adapter_mode_changed() old 0x00 new 0x03
bluetoothd[3135]: src/adapter.c:set_mode_complete() 
bluetoothd[3135]: HCI dev 0 down
bluetoothd[3135]: plugins/hciops.c:hciops_stop_discovery() index 0
bluetoothd[3135]: audio/manager.c:state_changed() /org/bluez/3135/hci0 powered off
bluetoothd[3135]: audio/telephony.c:telephony_exit() 
bluetoothd[3135]: audio/headset.c:telephony_deinit() Telephony deinitialized
bluetoothd[3135]: Adapter /org/bluez/3135/hci0 has been disabled
bluetoothd[3135]: src/adapter.c:set_mode_complete() 
bluetoothd[3135]: HCI dev 0 unregistered
bluetoothd[3135]: Stopping hci0 event socket
bluetoothd[3135]: Unregister path: /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:adapter_remove() Removing adapter /org/bluez/3135/hci0
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10006
bluetoothd[3135]: audio/manager.c:avrcp_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10005
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10004
bluetoothd[3135]: audio/manager.c:audio_adapter_unref() 0x7f371f8ff070: ref=4
bluetoothd[3135]: audio/manager.c:a2dp_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7f371f905da0 unregistered: type:1 codec:0 seid:2
bluetoothd[3135]: audio/media.c:release_endpoint() sender=:1.498 path=/MediaEndpoint/A2DPSink
bluetoothd[3135]: Endpoint unregistered: sender=:1.498 path=/MediaEndpoint/A2DPSink
bluetoothd[3135]: audio/media.c:media_endpoint_destroy() sender=:1.498 path=/MediaEndpoint/A2DPSink
bluetoothd[3135]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7f371f908250 unregistered: type:1 codec:0 seid:4
bluetoothd[3135]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7f371f9055b0 unregistered: type:0 codec:0 seid:1
bluetoothd[3135]: audio/media.c:release_endpoint() sender=:1.498 path=/MediaEndpoint/A2DPSource
bluetoothd[3135]: Endpoint unregistered: sender=:1.498 path=/MediaEndpoint/A2DPSource
bluetoothd[3135]: audio/media.c:media_endpoint_destroy() sender=:1.498 path=/MediaEndpoint/A2DPSource
bluetoothd[3135]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7f371f907df0 unregistered: type:0 codec:0 seid:3
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10002
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10003
bluetoothd[3135]: audio/manager.c:audio_adapter_unref() 0x7f371f8ff070: ref=3
bluetoothd[3135]: audio/manager.c:headset_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10000
bluetoothd[3135]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10001
bluetoothd[3135]: audio/manager.c:audio_adapter_unref() 0x7f371f8ff070: ref=2
bluetoothd[3135]: audio/manager.c:media_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: audio/media.c:release_endpoint() sender=:1.498 path=/MediaEndpoint/HFPAG
bluetoothd[3135]: Endpoint unregistered: sender=:1.498 path=/MediaEndpoint/HFPAG
bluetoothd[3135]: audio/media.c:media_endpoint_destroy() sender=:1.498 path=/MediaEndpoint/HFPAG
bluetoothd[3135]: audio/manager.c:audio_adapter_unref() 0x7f371f8ff070: ref=1
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f8ff5b0: ref=5
bluetoothd[3135]: serial/manager.c:proxy_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f8ff5b0: ref=4
bluetoothd[3135]: network/manager.c:network_server_remove() path /org/bluez/3135/hci0
bluetoothd[3135]: network/server.c:path_unregister() Unregistered interface org.bluez.NetworkServer on path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f8ff5b0: ref=3
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f8ff5b0: ref=2
bluetoothd[3135]: plugins/service.c:unregister_interface() path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:btd_adapter_unref() 0x7f371f8ff5b0: ref=1
bluetoothd[3135]: src/rfkill.c:rfkill_event() RFKILL event idx 50 type 2 op 1 soft 0 hard 0
bluetoothd[3135]: HCI dev 0 registered
bluetoothd[3135]: plugins/hciops.c:init_device() hci0
bluetoothd[3135]: Listening for HCI events on hci0
bluetoothd[3135]: plugins/hciops.c:init_device() child 3189 forked
bluetoothd[3135]: src/rfkill.c:rfkill_event() RFKILL event idx 51 type 2 op 0 soft 0 hard 0
bluetoothd[3135]: src/rfkill.c:rfkill_event() RFKILL event idx 51 type 2 op 2 soft 0 hard 0
bluetoothd[3135]: plugins/hciops.c:read_local_features_complete() Got features for hci0
bluetoothd[3135]: plugins/hciops.c:read_local_version_complete() Got version for hci0
bluetoothd[3135]: plugins/hciops.c:read_bd_addr_complete() hci0 status 0
bluetoothd[3135]: plugins/hciops.c:read_bd_addr_complete() Got bdaddr for hci0
bluetoothd[3135]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[3135]: plugins/hciops.c:read_local_name_complete() Got name for hci0
bluetoothd[3135]: plugins/hciops.c:read_local_ext_features_complete() hci0 status 0
bluetoothd[3135]: HCI dev 0 up
bluetoothd[3135]: plugins/hciops.c:device_devup_setup() hci0
bluetoothd[3135]: Adapter interface init failed on path /org/bluez/3135/hci0
bluetoothd[3135]: src/adapter.c:adapter_free() 0x7f371f8fcbc0
bluetoothd[3135]: plugins/hciops.c:child_exit() child 3189 exited
bluetoothd[3135]: plugins/hciops.c:read_local_ext_features_complete() hci0 status 0

--=-koWDtjP5kfwmxq8gSaIC--

