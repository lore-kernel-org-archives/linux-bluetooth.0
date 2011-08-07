Return-Path: <cyrus@holtmann.org>
From: Daniel Schaal <farbing@web.de>
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd crashes on exit when Media is enabled
Date: Sun, 7 Aug 2011 16:13:05 +0200
References: <201108061317.19221.farbing@web.de> <CABBYNZLWuSCs0odKL3AuXETiSZjEniu7J5gQ=Db8mm6d3yUwyQ@mail.gmail.com>
In-Reply-To: <CABBYNZLWuSCs0odKL3AuXETiSZjEniu7J5gQ=Db8mm6d3yUwyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_y1pPOtWNYD64oXB"
Message-Id: <201108071613.06423.farbing@web.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_y1pPOtWNYD64oXB
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Hi Daniel,
> 
> Could you please try with attached patch. It has been posted here
> before, but we decide to rework it a little bit.

Seems to work fine now.

Attached is the log of bluetoothd with the patch.

Thanks,
Daniel Schaal

--Boundary-00=_y1pPOtWNYD64oXB
Content-Type: text/plain;
  charset="us-ascii";
  name="bluetoothd.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluetoothd.log"

bluetoothd[26883]: Bluetooth daemon 4.96
bluetoothd[26883]: src/main.c:parse_config() parsing main.conf
bluetoothd[26883]: src/main.c:parse_config() discovto=0
bluetoothd[26883]: src/main.c:parse_config() pairto=0
bluetoothd[26883]: src/main.c:parse_config() pageto=8192
bluetoothd[26883]: src/main.c:parse_config() name=%h-%d
bluetoothd[26883]: src/main.c:parse_config() class=0x000100
bluetoothd[26883]: src/main.c:parse_config() discov_interval=30
bluetoothd[26883]: src/main.c:parse_config() Key file does not have key 'DeviceID'
bluetoothd[26883]: Starting SDP server
bluetoothd[26883]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[26883]: Excluding (conf) pnat
bluetoothd[26883]: src/plugin.c:add_plugin() Loading audio plugin
bluetoothd[26883]: Excluding (conf) sap
bluetoothd[26883]: Excluding (conf) input
bluetoothd[26883]: src/plugin.c:add_plugin() Loading serial plugin
bluetoothd[26883]: Excluding (conf) network
bluetoothd[26883]: Excluding (conf) proximity
bluetoothd[26883]: src/plugin.c:add_plugin() Loading service plugin
bluetoothd[26883]: Excluding (conf) health
bluetoothd[26883]: Excluding (conf) thermometer
bluetoothd[26883]: src/plugin.c:add_plugin() Loading hciops plugin
bluetoothd[26883]: src/plugin.c:add_plugin() Loading mgmtops plugin
bluetoothd[26883]: src/plugin.c:add_plugin() Loading formfactor plugin
bluetoothd[26883]: src/plugin.c:add_plugin() Loading storage plugin
bluetoothd[26883]: src/plugin.c:add_plugin() Loading adaptername plugin
bluetoothd[26883]: Excluding (conf) wiimote
bluetoothd[26883]: Excluding (conf) dbusoob
bluetoothd[26883]: src/plugin.c:plugin_init() Loading plugins /usr/lib/x86_64-linux-gnu/bluetooth/plugins
bluetoothd[26883]: plugins/service.c:register_interface() path /org/bluez/26883/any
bluetoothd[26883]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/26883/any
bluetoothd[26883]: audio/unix.c:unix_init() Unix socket created: 7
bluetoothd[26883]: plugins/hciops.c:hciops_init() 
bluetoothd[26883]: Bluetooth Management interface initialized
bluetoothd[26883]: src/main.c:main() Entering main loop
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 11 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:read_version_complete() version 0 revision 1
bluetoothd[26883]: src/rfkill.c:rfkill_event() RFKILL event idx 0 type 1 op 0 soft 0 hard 0
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 12 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:add_controller() Added controller 0
bluetoothd[26883]: plugins/mgmtops.c:mgmt_remove_uuid() index 0
bluetoothd[26883]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type 2 op 0 soft 0 hard 0
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 10 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 285 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:read_info_complete() hci0 type 0 addr 00:1B:DC:00:30:05
bluetoothd[26883]: plugins/mgmtops.c:read_info_complete() hci0 class 0x580100
bluetoothd[26883]: plugins/mgmtops.c:read_info_complete() hci0 manufacturer 10 HCI ver 4:4839
bluetoothd[26883]: plugins/mgmtops.c:read_info_complete() hci0 enabled 1 discoverable 0 pairable 1 sec_mode 4
bluetoothd[26883]: plugins/mgmtops.c:read_info_complete() hci0 name CSR - bc4
bluetoothd[26883]: src/adapter.c:btd_adapter_ref() 0x7fe2517de090: ref=1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_read_bdaddr() index 0 addr 00:1B:DC:00:30:05
bluetoothd[26883]: src/sdpd-database.c:sdp_init_services_list() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[26883]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[26883]: plugins/service.c:register_interface() path /org/bluez/26883/hci0
bluetoothd[26883]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/26883/hci0
bluetoothd[26883]: serial/manager.c:proxy_probe() path /org/bluez/26883/hci0
bluetoothd[26883]: src/adapter.c:btd_adapter_ref() 0x7fe2517de090: ref=2
bluetoothd[26883]: serial/proxy.c:proxy_register() Registered interface org.bluez.SerialProxyManager on path /org/bluez/26883/hci0
bluetoothd[26883]: audio/manager.c:media_server_probe() path /org/bluez/26883/hci0
bluetoothd[26883]: src/adapter.c:btd_adapter_ref() 0x7fe2517de090: ref=3
bluetoothd[26883]: audio/manager.c:audio_adapter_ref() 0x7fe2517db990: ref=1
bluetoothd[26883]: audio/manager.c:headset_server_probe() path /org/bluez/26883/hci0
bluetoothd[26883]: audio/manager.c:audio_adapter_ref() 0x7fe2517db990: ref=2
bluetoothd[26883]: audio/manager.c:state_changed() /org/bluez/26883/hci0 powered on
bluetoothd[26883]: audio/telephony.c:telephony_init() 
bluetoothd[26883]: audio/headset.c:telephony_ready_ind() Telephony plugin initialized
bluetoothd[26883]: audio/headset.c:print_ag_features() HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[26883]: audio/manager.c:headset_server_init() audio.conf: Key file does not have key 'Master'
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10000
bluetoothd[26883]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[26883]: audio/headset.c:headset_config_init() audio.conf: Key file does not have key 'SCORouting'
bluetoothd[26883]: plugins/mgmtops.c:mgmt_fast_connectable() index 0 enable 0
bluetoothd[26883]: Changing fast connectable for hci0 failed
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
bluetoothd[26883]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[26883]: audio/manager.c:a2dp_server_probe() path /org/bluez/26883/hci0
bluetoothd[26883]: audio/manager.c:audio_adapter_ref() 0x7fe2517db990: ref=3
bluetoothd[26883]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have key 'Disable'
bluetoothd[26883]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[26883]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[26883]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[26883]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[26883]: audio/avdtp.c:avdtp_init() audio.conf: Key file does not have key 'Master'
bluetoothd[26883]: audio/avdtp.c:avdtp_register_sep() SEP 0x7fe2517dfbc0 registered: type:0 codec:0 seid:1
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
bluetoothd[26883]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[26883]: audio/manager.c:avrcp_server_probe() path /org/bluez/26883/hci0
bluetoothd[26883]: audio/manager.c:audio_adapter_ref() 0x7fe2517db990: ref=4
bluetoothd[26883]: audio/control.c:avrcp_register() audio.conf: Key file does not have key 'Master'
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10003
bluetoothd[26883]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
bluetoothd[26883]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[26883]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[26883]: plugins/adaptername.c:adaptername_probe() Setting name 'CSR - bc4' for device 'hci0'
bluetoothd[26883]: plugins/mgmtops.c:mgmt_set_name() index 0, name CSR - bc4
bluetoothd[26883]: plugins/formfactor.c:formfactor_probe() Setting 0x000110 for major/minor device class
bluetoothd[26883]: plugins/mgmtops.c:mgmt_set_dev_class() index 0 major 1 minor 16
bluetoothd[26883]: plugins/mgmtops.c:mgmt_unblock_device() index 0 addr 00:00:00:00:00:00
bluetoothd[26883]: src/device.c:device_create() Creating device /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: src/device.c:device_set_bonded() bonded 1
bluetoothd[26883]: src/device.c:btd_device_ref() 0x7fe2517e1730: ref=1
bluetoothd[26883]: src/device.c:device_set_temporary() temporary 0
bluetoothd[26883]: src/device.c:device_probe_drivers() Probing drivers for 00:0B:E4:91:5D:0D
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D: 00001108-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/port.c:create_serial_device() Registered interface org.bluez.Serial on path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D: 0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: src/adapter.c:adapter_get_device() 00:0B:E4:91:5D:0D
bluetoothd[26883]: src/device.c:btd_device_ref() 0x7fe2517e1730: ref=2
bluetoothd[26883]: audio/device.c:audio_device_register() Registered interface org.bluez.Audio on path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: audio/manager.c:handle_uuid() Found Headset record
bluetoothd[26883]: audio/headset.c:headset_init() Registered interface org.bluez.Headset on path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: audio/manager.c:handle_uuid() Found Handsfree record
bluetoothd[26883]: audio/manager.c:handle_uuid() Found Audio Sink
bluetoothd[26883]: audio/sink.c:sink_init() Registered interface org.bluez.AudioSink on path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: audio/manager.c:handle_uuid() Found AV Target
bluetoothd[26883]: audio/control.c:control_init() Registered interface org.bluez.Control on path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: audio/manager.c:handle_uuid() Found AV Remote
bluetoothd[26883]: src/device.c:device_create() Creating device /org/bluez/26883/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[26883]: src/device.c:device_set_bonded() bonded 1
bluetoothd[26883]: src/device.c:btd_device_ref() 0x7fe2517e45d0: ref=1
bluetoothd[26883]: src/device.c:device_set_temporary() temporary 0
bluetoothd[26883]: src/device.c:device_probe_drivers() Probing drivers for 00:22:98:CD:7A:E9
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_00_22_98_CD_7A_E9: 00001105-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/port.c:create_serial_device() Registered interface org.bluez.Serial on path /org/bluez/26883/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_00_22_98_CD_7A_E9: 00001112-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_00_22_98_CD_7A_E9: 0000111f-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: src/adapter.c:adapter_get_device() 00:22:98:CD:7A:E9
bluetoothd[26883]: src/device.c:btd_device_ref() 0x7fe2517e45d0: ref=2
bluetoothd[26883]: audio/device.c:audio_device_register() Registered interface org.bluez.Audio on path /org/bluez/26883/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[26883]: audio/manager.c:handle_uuid() server not enabled for 0000111f-0000-1000-8000-00805f9b34fb (0x111f)
bluetoothd[26883]: audio/manager.c:handle_uuid() server not enabled for 00001112-0000-1000-8000-00805f9b34fb (0x1112)
bluetoothd[26883]: src/device.c:device_create() Creating device /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[26883]: src/device.c:device_set_bonded() bonded 1
bluetoothd[26883]: src/device.c:btd_device_ref() 0x7fe2517e6a10: ref=1
bluetoothd[26883]: src/device.c:device_set_temporary() temporary 0
bluetoothd[26883]: src/device.c:device_probe_drivers() Probing drivers for E0:A6:70:2F:3A:B6
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 00000002-0000-1000-8000-0002ee000002
bluetoothd[26883]: serial/port.c:create_serial_device() Registered interface org.bluez.Serial on path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 00001101-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 00001103-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 00001105-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 00001106-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 00001112-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 0000111f-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 0000112d-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 0000112f-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 00005002-0000-1000-8000-0002ee000001
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 00005557-0000-1000-8000-0002ee000001
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6: 00005601-0000-1000-8000-0002ee000001
bluetoothd[26883]: src/adapter.c:adapter_get_device() E0:A6:70:2F:3A:B6
bluetoothd[26883]: src/device.c:btd_device_ref() 0x7fe2517e6a10: ref=2
bluetoothd[26883]: audio/device.c:audio_device_register() Registered interface org.bluez.Audio on path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[26883]: audio/manager.c:handle_uuid() server not enabled for 00001112-0000-1000-8000-00805f9b34fb (0x1112)
bluetoothd[26883]: audio/manager.c:handle_uuid() server not enabled for 0000111f-0000-1000-8000-00805f9b34fb (0x111f)
bluetoothd[26883]: src/device.c:device_create() Creating device /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: src/device.c:device_set_bonded() bonded 1
bluetoothd[26883]: src/device.c:btd_device_ref() 0x7fe2517eee40: ref=1
bluetoothd[26883]: src/device.c:device_set_temporary() temporary 0
bluetoothd[26883]: src/device.c:device_probe_drivers() Probing drivers for 40:2B:A1:61:DD:C5
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5: 00001108-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/port.c:create_serial_device() Registered interface org.bluez.Serial on path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5: 0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: src/adapter.c:adapter_get_device() 40:2B:A1:61:DD:C5
bluetoothd[26883]: src/device.c:btd_device_ref() 0x7fe2517eee40: ref=2
bluetoothd[26883]: audio/device.c:audio_device_register() Registered interface org.bluez.Audio on path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: audio/manager.c:handle_uuid() Found Headset record
bluetoothd[26883]: audio/headset.c:headset_init() Registered interface org.bluez.Headset on path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: audio/manager.c:handle_uuid() Found Handsfree record
bluetoothd[26883]: audio/manager.c:handle_uuid() Found Audio Sink
bluetoothd[26883]: audio/sink.c:sink_init() Registered interface org.bluez.AudioSink on path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: audio/manager.c:handle_uuid() Found AV Target
bluetoothd[26883]: audio/control.c:control_init() Registered interface org.bluez.Control on path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: audio/manager.c:handle_uuid() Found AV Remote
bluetoothd[26883]: src/device.c:device_create() Creating device /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: src/device.c:device_set_bonded() bonded 1
bluetoothd[26883]: src/device.c:btd_device_ref() 0x7fe2517f2530: ref=1
bluetoothd[26883]: src/device.c:device_set_temporary() temporary 0
bluetoothd[26883]: src/device.c:device_probe_drivers() Probing drivers for 00:22:FC:74:CA:27
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27: 00001108-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: serial/port.c:create_serial_device() Registered interface org.bluez.Serial on path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: serial/manager.c:serial_probe() path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27: 0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[26883]: src/adapter.c:adapter_get_device() 00:22:FC:74:CA:27
bluetoothd[26883]: src/device.c:btd_device_ref() 0x7fe2517f2530: ref=2
bluetoothd[26883]: audio/device.c:audio_device_register() Registered interface org.bluez.Audio on path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: audio/manager.c:handle_uuid() Found Headset record
bluetoothd[26883]: audio/headset.c:headset_init() Registered interface org.bluez.Headset on path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: audio/manager.c:handle_uuid() Found Handsfree record
bluetoothd[26883]: audio/manager.c:handle_uuid() Found Audio Sink
bluetoothd[26883]: audio/sink.c:sink_init() Registered interface org.bluez.AudioSink on path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: audio/manager.c:handle_uuid() Found AV Target
bluetoothd[26883]: audio/control.c:control_init() Registered interface org.bluez.Control on path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: audio/manager.c:handle_uuid() Found AV Remote
bluetoothd[26883]: plugins/mgmtops.c:mgmt_load_keys() index 0 keys 5 debug_keys 0
bluetoothd[26883]: plugins/mgmtops.c:mgmt_get_conn_list() index 0
bluetoothd[26883]: src/manager.c:btd_manager_register_adapter() Adapter /org/bluez/26883/hci0 registered
bluetoothd[26883]: src/adapter.c:btd_adapter_ref() 0x7fe2517de090: ref=4
bluetoothd[26883]: plugins/mgmtops.c:mgmt_set_name() index 0, name CSR - bc4
bluetoothd[26883]: plugins/mgmtops.c:mgmt_set_dev_class() index 0 major 1 minor 0
bluetoothd[26883]: audio/manager.c:state_changed() /org/bluez/26883/hci0 powered on
bluetoothd[26883]: plugins/mgmtops.c:mgmt_disable_cod_cache() index 0
bluetoothd[26883]: Adapter /org/bluez/26883/hci0 has been enabled
bluetoothd[26883]: src/adapter.c:adapter_mode_changed() old 0x00 new 0x02
bluetoothd[26883]: src/adapter.c:adapter_set_limited_discoverable() FALSE
bluetoothd[26883]: plugins/mgmtops.c:mgmt_set_limited_discoverable() index 0 limited 0
bluetoothd[26883]: src/adapter.c:set_mode_complete() 
bluetoothd[26883]: src/adapter.c:btd_adapter_unref() 0x7fe2517de090: ref=3
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() set_service_cache complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() set_dev_class complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 9 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_status() status 1 opcode 30 (index 0)
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 257 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:set_local_name_complete() hci0 name CSR - bc4
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() set_dev_class complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() set_service_cache complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 257 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:set_local_name_complete() hci0 name CSR - bc4
bluetoothd[26883]: Endpoint registered: sender=:1.36 path=/MediaEndpoint/HFPAG
bluetoothd[26883]: audio/avdtp.c:avdtp_register_sep() SEP 0x7fe2517f6450 registered: type:0 codec:0 seid:2
bluetoothd[26883]: Endpoint registered: sender=:1.36 path=/MediaEndpoint/A2DPSource
bluetoothd[26883]: audio/avdtp.c:avdtp_register_sep() SEP 0x7fe2517f6610 registered: type:0 codec:0 seid:3
bluetoothd[26883]: Endpoint registered: sender=:1.36 path=/MediaEndpoint/A2DPSink
bluetoothd[26883]: src/adapter.c:register_agent() Agent registered for hci0 at :1.11:/blueDevil_agent
bluetoothd[26883]: plugins/mgmtops.c:mgmt_set_io_capability() hci0 io_capability 0x01
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() set_io_capability complete
bluetoothd[26883]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[26883]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[26883]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[26883]: src/adapter.c:adapter_remove() Removing adapter /org/bluez/26883/hci0
bluetoothd[26883]: src/device.c:device_remove() Removing device /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: serial/manager.c:serial_remove() path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: serial/port.c:path_unregister() Unregistered interface org.bluez.Serial on path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: audio/unix.c:unix_device_removed() unix_device_removed(0x7fe2517e3e30)
bluetoothd[26883]: audio/headset.c:path_unregister() Unregistered interface org.bluez.Headset on path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: audio/sink.c:path_unregister() Unregistered interface org.bluez.AudioSink on path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: audio/control.c:path_unregister() Unregistered interface org.bluez.Control on path /org/bluez/26883/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[26883]: src/device.c:btd_device_unref() 0x7fe2517e1730: ref=1
bluetoothd[26883]: src/device.c:btd_device_unref() 0x7fe2517e1730: ref=0
bluetoothd[26883]: src/device.c:device_free() 0x7fe2517e1730
bluetoothd[26883]: src/device.c:device_remove() Removing device /org/bluez/26883/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[26883]: serial/manager.c:serial_remove() path /org/bluez/26883/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[26883]: serial/port.c:path_unregister() Unregistered interface org.bluez.Serial on path /org/bluez/26883/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[26883]: audio/unix.c:unix_device_removed() unix_device_removed(0x7fe2517e65f0)
bluetoothd[26883]: src/device.c:btd_device_unref() 0x7fe2517e45d0: ref=1
bluetoothd[26883]: src/device.c:btd_device_unref() 0x7fe2517e45d0: ref=0
bluetoothd[26883]: src/device.c:device_free() 0x7fe2517e45d0
bluetoothd[26883]: src/device.c:device_remove() Removing device /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[26883]: serial/manager.c:serial_remove() path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[26883]: serial/port.c:path_unregister() Unregistered interface org.bluez.Serial on path /org/bluez/26883/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[26883]: audio/unix.c:unix_device_removed() unix_device_removed(0x7fe2517eed10)
bluetoothd[26883]: src/device.c:btd_device_unref() 0x7fe2517e6a10: ref=1
bluetoothd[26883]: src/device.c:btd_device_unref() 0x7fe2517e6a10: ref=0
bluetoothd[26883]: src/device.c:device_free() 0x7fe2517e6a10
bluetoothd[26883]: src/device.c:device_remove() Removing device /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: serial/manager.c:serial_remove() path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: serial/port.c:path_unregister() Unregistered interface org.bluez.Serial on path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: audio/unix.c:unix_device_removed() unix_device_removed(0x7fe2517f21f0)
bluetoothd[26883]: audio/headset.c:path_unregister() Unregistered interface org.bluez.Headset on path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: audio/sink.c:path_unregister() Unregistered interface org.bluez.AudioSink on path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: audio/control.c:path_unregister() Unregistered interface org.bluez.Control on path /org/bluez/26883/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[26883]: src/device.c:btd_device_unref() 0x7fe2517eee40: ref=1
bluetoothd[26883]: src/device.c:btd_device_unref() 0x7fe2517eee40: ref=0
bluetoothd[26883]: src/device.c:device_free() 0x7fe2517eee40
bluetoothd[26883]: src/device.c:device_remove() Removing device /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: serial/manager.c:serial_remove() path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: serial/port.c:path_unregister() Unregistered interface org.bluez.Serial on path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: audio/unix.c:unix_device_removed() unix_device_removed(0x7fe2517f4c70)
bluetoothd[26883]: audio/headset.c:path_unregister() Unregistered interface org.bluez.Headset on path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: audio/sink.c:path_unregister() Unregistered interface org.bluez.AudioSink on path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: audio/control.c:path_unregister() Unregistered interface org.bluez.Control on path /org/bluez/26883/hci0/dev_00_22_FC_74_CA_27
bluetoothd[26883]: src/device.c:btd_device_unref() 0x7fe2517f2530: ref=1
bluetoothd[26883]: src/device.c:btd_device_unref() 0x7fe2517f2530: ref=0
bluetoothd[26883]: src/device.c:device_free() 0x7fe2517f2530
bluetoothd[26883]: audio/manager.c:avrcp_server_remove() path /org/bluez/26883/hci0
bluetoothd[26883]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10004
bluetoothd[26883]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10003
bluetoothd[26883]: audio/manager.c:audio_adapter_unref() 0x7fe2517db990: ref=3
bluetoothd[26883]: audio/manager.c:a2dp_server_remove() path /org/bluez/26883/hci0
bluetoothd[26883]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7fe2517dfbc0 unregistered: type:0 codec:0 seid:1
bluetoothd[26883]: audio/media.c:release_endpoint() sender=:1.36 path=/MediaEndpoint/A2DPSource
bluetoothd[26883]: Endpoint unregistered: sender=:1.36 path=/MediaEndpoint/A2DPSource
bluetoothd[26883]: audio/media.c:media_endpoint_destroy() sender=:1.36 path=/MediaEndpoint/A2DPSource
bluetoothd[26883]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7fe2517f6450 unregistered: type:0 codec:0 seid:2
bluetoothd[26883]: audio/media.c:release_endpoint() sender=:1.36 path=/MediaEndpoint/A2DPSink
bluetoothd[26883]: Endpoint unregistered: sender=:1.36 path=/MediaEndpoint/A2DPSink
bluetoothd[26883]: audio/media.c:media_endpoint_destroy() sender=:1.36 path=/MediaEndpoint/A2DPSink
bluetoothd[26883]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7fe2517f6610 unregistered: type:0 codec:0 seid:3
bluetoothd[26883]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10002
bluetoothd[26883]: audio/manager.c:audio_adapter_unref() 0x7fe2517db990: ref=2
bluetoothd[26883]: audio/manager.c:headset_server_remove() path /org/bluez/26883/hci0
bluetoothd[26883]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10000
bluetoothd[26883]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10001
bluetoothd[26883]: audio/manager.c:audio_adapter_unref() 0x7fe2517db990: ref=1
bluetoothd[26883]: audio/manager.c:media_server_remove() path /org/bluez/26883/hci0
bluetoothd[26883]: audio/media.c:release_endpoint() sender=:1.36 path=/MediaEndpoint/HFPAG
bluetoothd[26883]: Endpoint unregistered: sender=:1.36 path=/MediaEndpoint/HFPAG
bluetoothd[26883]: audio/media.c:media_endpoint_destroy() sender=:1.36 path=/MediaEndpoint/HFPAG
bluetoothd[26883]: audio/manager.c:audio_adapter_unref() 0x7fe2517db990: ref=0
bluetoothd[26883]: src/adapter.c:btd_adapter_unref() 0x7fe2517de090: ref=2
bluetoothd[26883]: serial/manager.c:proxy_remove() path /org/bluez/26883/hci0
bluetoothd[26883]: src/adapter.c:btd_adapter_unref() 0x7fe2517de090: ref=1
bluetoothd[26883]: plugins/service.c:unregister_interface() path /org/bluez/26883/hci0
bluetoothd[26883]: plugins/mgmtops.c:mgmt_restore_powered() index 0
bluetoothd[26883]: src/adapter.c:btd_adapter_unref() 0x7fe2517de090: ref=0
bluetoothd[26883]: plugins/mgmtops.c:mgmt_set_io_capability() hci0 io_capability 0x03
bluetoothd[26883]: src/agent.c:agent_release() Releasing agent :1.11, /blueDevil_agent
bluetoothd[26883]: src/adapter.c:adapter_free() 0x7fe2517de090
bluetoothd[26883]: src/plugin.c:plugin_cleanup() Cleanup plugins
bluetoothd[26883]: plugins/service.c:unregister_interface() path /org/bluez/26883/any
bluetoothd[26883]: plugins/hciops.c:hciops_exit() 
bluetoothd[26883]: plugins/hciops.c:hciops_cleanup() 
bluetoothd[26883]: Stopping SDP server
bluetoothd[26883]: Exit

--Boundary-00=_y1pPOtWNYD64oXB--
