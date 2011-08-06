Return-Path: <cyrus@holtmann.org>
From: Daniel Schaal <farbing@web.de>
To: linux-bluetooth@vger.kernel.org
Subject: bluetoothd crashes on exit when Media is enabled
Date: Sat, 6 Aug 2011 13:17:18 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/KSPORYEWJG6tNJ"
Message-Id: <201108061317.19221.farbing@web.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_/KSPORYEWJG6tNJ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

after enabling Media in audio.conf, bluetoothd always crashes when exiting.

=46rom the log I suspect the problem is that avdtp_unregister_sep is called=
=20
twice with the same sep:

audio/avdtp.c:avdtp_unregister_sep() SEP 0x7ffff822b650 unregistered: type:=
0=20
codec:0 seid:2
audio/avdtp.c:avdtp_unregister_sep() SEP 0x7ffff822b650 unregistered: type:=
0=20
codec:0 seid:2
*** glibc detected *** /usr/sbin/bluetoothd: double free or corruption=20
(!prev): 0x00007ffff822a920 ***

Attached is the backtrace and the debug output of bluetoothd

I'm using 4.96 with Kernel 3.0

Thanks

--Boundary-00=_/KSPORYEWJG6tNJ
Content-Type: text/plain;
  charset="us-ascii";
  name="bluetoothd.bt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluetoothd.bt"

#0  0x00007ffff6a66405 in raise (sig=<value optimized out>) at ../nptl/sysdeps/unix/sysv/linux/raise.c:64
#1  0x00007ffff6a69680 in abort () at abort.c:92
#2  0x00007ffff6a9cdbb in __libc_message (do_abort=<value optimized out>, fmt=<value optimized out>) at ../sysdeps/unix/sysv/linux/libc_fatal.c:189
#3  0x00007ffff6aa6606 in malloc_printerr (action=3, str=0x7ffff6b7d2a8 "double free or corruption (!prev)", ptr=<value optimized out>) at malloc.c:6283
#4  0x00007ffff6aab33c in __libc_free (mem=<value optimized out>) at malloc.c:3738
#5  0x00007ffff788e447 in g_slist_foreach (list=<value optimized out>, func=0x7ffff7f80780 <a2dp_unregister_sep>, user_data=0x0) at /tmp/buildd/glib2.0-2.28.6/./glib/gslist.c:880
#6  0x00007ffff788e46b in g_slist_free_full (list=0x7ffff82132b0, free_func=<value optimized out>) at /tmp/buildd/glib2.0-2.28.6/./glib/gslist.c:209
#7  0x00007ffff7f82820 in a2dp_unregister (src=0x7fffffffe410) at audio/a2dp.c:1551
#8  0x00007ffff7f738bd in a2dp_server_remove (adapter=0x7ffff8212aa0) at audio/manager.c:1032
#9  0x00007ffff788e447 in g_slist_foreach (list=<value optimized out>, func=0x7ffff7fc7190 <remove_driver>, user_data=0x7ffff8212aa0) at /tmp/buildd/glib2.0-2.28.6/./glib/gslist.c:
880
#10 0x00007ffff7fca63e in unload_drivers (adapter=0x7ffff8212aa0) at src/adapter.c:2329
#11 adapter_remove (adapter=0x7ffff8212aa0) at src/adapter.c:2578
#12 0x00007ffff7fc6b42 in manager_cleanup (conn=0x7ffff820cb20, path=<value optimized out>) at src/manager.c:306
#13 0x00007ffff7f6f049 in disconnect_dbus (argc=1, argv=0x7fffffffe668) at src/main.c:304
#14 main (argc=1, argv=0x7fffffffe668) at src/main.c:481

--Boundary-00=_/KSPORYEWJG6tNJ
Content-Type: text/plain;
  charset="us-ascii";
  name="bluetoothd.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluetoothd.log"

bluetoothd[3276]: Bluetooth daemon 4.96
bluetoothd[3276]: src/main.c:parse_config() parsing main.conf
bluetoothd[3276]: src/main.c:parse_config() discovto=0
bluetoothd[3276]: src/main.c:parse_config() pairto=0
bluetoothd[3276]: src/main.c:parse_config() pageto=8192
bluetoothd[3276]: src/main.c:parse_config() name=%h-%d
bluetoothd[3276]: src/main.c:parse_config() class=0x000100
bluetoothd[3276]: src/main.c:parse_config() discov_interval=30
bluetoothd[3276]: src/main.c:parse_config() Key file does not have key 'DeviceID'
bluetoothd[3276]: Starting SDP server
bluetoothd[3276]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[3276]: Excluding (conf) pnat
bluetoothd[3276]: src/plugin.c:add_plugin() Loading audio plugin
bluetoothd[3276]: Excluding (conf) sap
bluetoothd[3276]: Excluding (conf) input
bluetoothd[3276]: src/plugin.c:add_plugin() Loading serial plugin
bluetoothd[3276]: Excluding (conf) network
bluetoothd[3276]: Excluding (conf) proximity
bluetoothd[3276]: src/plugin.c:add_plugin() Loading service plugin
bluetoothd[3276]: Excluding (conf) health
bluetoothd[3276]: Excluding (conf) thermometer
bluetoothd[3276]: src/plugin.c:add_plugin() Loading hciops plugin
bluetoothd[3276]: src/plugin.c:add_plugin() Loading mgmtops plugin
bluetoothd[3276]: src/plugin.c:add_plugin() Loading formfactor plugin
bluetoothd[3276]: src/plugin.c:add_plugin() Loading storage plugin
bluetoothd[3276]: src/plugin.c:add_plugin() Loading adaptername plugin
bluetoothd[3276]: Excluding (conf) wiimote
bluetoothd[3276]: Excluding (conf) dbusoob
bluetoothd[3276]: src/plugin.c:plugin_init() Loading plugins /usr/lib/x86_64-linux-gnu/bluetooth/plugins
bluetoothd[3276]: plugins/service.c:register_interface() path /org/bluez/3276/any
bluetoothd[3276]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/3276/any
bluetoothd[3276]: audio/unix.c:unix_init() Unix socket created: 14
bluetoothd[3276]: plugins/hciops.c:hciops_init() 
bluetoothd[3276]: Bluetooth Management interface initialized
bluetoothd[3276]: src/main.c:main() Entering main loop
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 11 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:read_version_complete() version 0 revision 1
bluetoothd[3276]: src/rfkill.c:rfkill_event() RFKILL event idx 0 type 1 op 0 soft 0 hard 0
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 12 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:add_controller() Added controller 0
bluetoothd[3276]: plugins/mgmtops.c:mgmt_remove_uuid() index 0
bluetoothd[3276]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type 2 op 0 soft 0 hard 0
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 10 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 285 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:read_info_complete() hci0 type 0 addr 00:1B:DC:00:30:05
bluetoothd[3276]: plugins/mgmtops.c:read_info_complete() hci0 class 0x580100
bluetoothd[3276]: plugins/mgmtops.c:read_info_complete() hci0 manufacturer 10 HCI ver 4:4839
bluetoothd[3276]: plugins/mgmtops.c:read_info_complete() hci0 enabled 1 discoverable 0 pairable 1 sec_mode 4
bluetoothd[3276]: plugins/mgmtops.c:read_info_complete() hci0 name CSR - bc4
bluetoothd[3276]: src/adapter.c:btd_adapter_ref() 0x7ffff8212aa0: ref=1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_read_bdaddr() index 0 addr 00:1B:DC:00:30:05
bluetoothd[3276]: src/sdpd-database.c:sdp_init_services_list() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[3276]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[3276]: plugins/service.c:register_interface() path /org/bluez/3276/hci0
bluetoothd[3276]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/3276/hci0
bluetoothd[3276]: serial/manager.c:proxy_probe() path /org/bluez/3276/hci0
bluetoothd[3276]: src/adapter.c:btd_adapter_ref() 0x7ffff8212aa0: ref=2
bluetoothd[3276]: serial/proxy.c:proxy_register() Registered interface org.bluez.SerialProxyManager on path /org/bluez/3276/hci0
bluetoothd[3276]: audio/manager.c:media_server_probe() path /org/bluez/3276/hci0
bluetoothd[3276]: src/adapter.c:btd_adapter_ref() 0x7ffff8212aa0: ref=3
bluetoothd[3276]: audio/manager.c:audio_adapter_ref() 0x7ffff8213350: ref=1
bluetoothd[3276]: audio/manager.c:headset_server_probe() path /org/bluez/3276/hci0
bluetoothd[3276]: audio/manager.c:audio_adapter_ref() 0x7ffff8213350: ref=2
bluetoothd[3276]: audio/manager.c:state_changed() /org/bluez/3276/hci0 powered on
bluetoothd[3276]: audio/telephony.c:telephony_init() 
bluetoothd[3276]: audio/headset.c:telephony_ready_ind() Telephony plugin initialized
bluetoothd[3276]: audio/headset.c:print_ag_features() HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[3276]: audio/manager.c:headset_server_init() audio.conf: Key file does not have key 'Master'
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10000
bluetoothd[3276]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3276]: audio/headset.c:headset_config_init() audio.conf: Key file does not have key 'SCORouting'
bluetoothd[3276]: plugins/mgmtops.c:mgmt_fast_connectable() index 0 enable 0
bluetoothd[3276]: Changing fast connectable for hci0 failed
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
bluetoothd[3276]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[3276]: audio/manager.c:a2dp_server_probe() path /org/bluez/3276/hci0
bluetoothd[3276]: audio/manager.c:audio_adapter_ref() 0x7ffff8213350: ref=3
bluetoothd[3276]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have key 'Disable'
bluetoothd[3276]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3276]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3276]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3276]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[3276]: audio/avdtp.c:avdtp_init() audio.conf: Key file does not have key 'Master'
bluetoothd[3276]: audio/avdtp.c:avdtp_register_sep() SEP 0x7ffff8214be0 registered: type:0 codec:0 seid:1
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
bluetoothd[3276]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[3276]: audio/manager.c:avrcp_server_probe() path /org/bluez/3276/hci0
bluetoothd[3276]: audio/manager.c:audio_adapter_ref() 0x7ffff8213350: ref=4
bluetoothd[3276]: audio/control.c:avrcp_register() audio.conf: Key file does not have key 'Master'
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10003
bluetoothd[3276]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
bluetoothd[3276]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[3276]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[3276]: plugins/adaptername.c:adaptername_probe() Setting name 'CSR - bc4' for device 'hci0'
bluetoothd[3276]: plugins/mgmtops.c:mgmt_set_name() index 0, name CSR - bc4
bluetoothd[3276]: plugins/formfactor.c:formfactor_probe() Setting 0x000110 for major/minor device class
bluetoothd[3276]: plugins/mgmtops.c:mgmt_set_dev_class() index 0 major 1 minor 16
bluetoothd[3276]: plugins/mgmtops.c:mgmt_unblock_device() index 0 addr 00:00:00:00:00:00
bluetoothd[3276]: src/device.c:device_create() Creating device /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: src/device.c:device_set_bonded() bonded 1
bluetoothd[3276]: src/device.c:btd_device_ref() 0x7ffff8216760: ref=1
bluetoothd[3276]: src/device.c:device_set_temporary() temporary 0
bluetoothd[3276]: src/device.c:device_probe_drivers() Probing drivers for 00:0B:E4:91:5D:0D
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D: 00001108-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/port.c:create_serial_device() Registered interface org.bluez.Serial on path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D: 0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: src/adapter.c:adapter_get_device() 00:0B:E4:91:5D:0D
bluetoothd[3276]: src/device.c:btd_device_ref() 0x7ffff8216760: ref=2
bluetoothd[3276]: audio/device.c:audio_device_register() Registered interface org.bluez.Audio on path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: audio/manager.c:handle_uuid() Found Headset record
bluetoothd[3276]: audio/headset.c:headset_init() Registered interface org.bluez.Headset on path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: audio/manager.c:handle_uuid() Found Handsfree record
bluetoothd[3276]: audio/manager.c:handle_uuid() Found Audio Sink
bluetoothd[3276]: audio/sink.c:sink_init() Registered interface org.bluez.AudioSink on path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: audio/manager.c:handle_uuid() Found AV Target
bluetoothd[3276]: audio/control.c:control_init() Registered interface org.bluez.Control on path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: audio/manager.c:handle_uuid() Found AV Remote
bluetoothd[3276]: src/device.c:device_create() Creating device /org/bluez/3276/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[3276]: src/device.c:device_set_bonded() bonded 1
bluetoothd[3276]: src/device.c:btd_device_ref() 0x7ffff82195d0: ref=1
bluetoothd[3276]: src/device.c:device_set_temporary() temporary 0
bluetoothd[3276]: src/device.c:device_probe_drivers() Probing drivers for 00:22:98:CD:7A:E9
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_00_22_98_CD_7A_E9: 00001105-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/port.c:create_serial_device() Registered interface org.bluez.Serial on path /org/bluez/3276/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_00_22_98_CD_7A_E9: 00001112-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_00_22_98_CD_7A_E9: 0000111f-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: src/adapter.c:adapter_get_device() 00:22:98:CD:7A:E9
bluetoothd[3276]: src/device.c:btd_device_ref() 0x7ffff82195d0: ref=2
bluetoothd[3276]: audio/device.c:audio_device_register() Registered interface org.bluez.Audio on path /org/bluez/3276/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[3276]: audio/manager.c:handle_uuid() server not enabled for 0000111f-0000-1000-8000-00805f9b34fb (0x111f)
bluetoothd[3276]: audio/manager.c:handle_uuid() server not enabled for 00001112-0000-1000-8000-00805f9b34fb (0x1112)
bluetoothd[3276]: src/device.c:device_create() Creating device /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[3276]: src/device.c:device_set_bonded() bonded 1
bluetoothd[3276]: src/device.c:btd_device_ref() 0x7ffff821ba40: ref=1
bluetoothd[3276]: src/device.c:device_set_temporary() temporary 0
bluetoothd[3276]: src/device.c:device_probe_drivers() Probing drivers for E0:A6:70:2F:3A:B6
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 00000002-0000-1000-8000-0002ee000002
bluetoothd[3276]: serial/port.c:create_serial_device() Registered interface org.bluez.Serial on path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 00001101-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 00001103-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 00001105-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 00001106-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 00001112-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 0000111f-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 0000112d-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 0000112f-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 00005002-0000-1000-8000-0002ee000001
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 00005557-0000-1000-8000-0002ee000001
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6: 00005601-0000-1000-8000-0002ee000001
bluetoothd[3276]: src/adapter.c:adapter_get_device() E0:A6:70:2F:3A:B6
bluetoothd[3276]: src/device.c:btd_device_ref() 0x7ffff821ba40: ref=2
bluetoothd[3276]: audio/device.c:audio_device_register() Registered interface org.bluez.Audio on path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[3276]: audio/manager.c:handle_uuid() server not enabled for 00001112-0000-1000-8000-00805f9b34fb (0x1112)
bluetoothd[3276]: audio/manager.c:handle_uuid() server not enabled for 0000111f-0000-1000-8000-00805f9b34fb (0x111f)
bluetoothd[3276]: src/device.c:device_create() Creating device /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: src/device.c:device_set_bonded() bonded 1
bluetoothd[3276]: src/device.c:btd_device_ref() 0x7ffff8223e40: ref=1
bluetoothd[3276]: src/device.c:device_set_temporary() temporary 0
bluetoothd[3276]: src/device.c:device_probe_drivers() Probing drivers for 40:2B:A1:61:DD:C5
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5: 00001108-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/port.c:create_serial_device() Registered interface org.bluez.Serial on path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5: 0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: src/adapter.c:adapter_get_device() 40:2B:A1:61:DD:C5
bluetoothd[3276]: src/device.c:btd_device_ref() 0x7ffff8223e40: ref=2
bluetoothd[3276]: audio/device.c:audio_device_register() Registered interface org.bluez.Audio on path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: audio/manager.c:handle_uuid() Found Headset record
bluetoothd[3276]: audio/headset.c:headset_init() Registered interface org.bluez.Headset on path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: audio/manager.c:handle_uuid() Found Handsfree record
bluetoothd[3276]: audio/manager.c:handle_uuid() Found Audio Sink
bluetoothd[3276]: audio/sink.c:sink_init() Registered interface org.bluez.AudioSink on path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: audio/manager.c:handle_uuid() Found AV Target
bluetoothd[3276]: audio/control.c:control_init() Registered interface org.bluez.Control on path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: audio/manager.c:handle_uuid() Found AV Remote
bluetoothd[3276]: src/device.c:device_create() Creating device /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: src/device.c:device_set_bonded() bonded 1
bluetoothd[3276]: src/device.c:btd_device_ref() 0x7ffff8227530: ref=1
bluetoothd[3276]: src/device.c:device_set_temporary() temporary 0
bluetoothd[3276]: src/device.c:device_probe_drivers() Probing drivers for 00:22:FC:74:CA:27
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27: 00001108-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: serial/port.c:create_serial_device() Registered interface org.bluez.Serial on path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: serial/manager.c:serial_probe() path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27: 0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[3276]: src/adapter.c:adapter_get_device() 00:22:FC:74:CA:27
bluetoothd[3276]: src/device.c:btd_device_ref() 0x7ffff8227530: ref=2
bluetoothd[3276]: audio/device.c:audio_device_register() Registered interface org.bluez.Audio on path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: audio/manager.c:handle_uuid() Found Headset record
bluetoothd[3276]: audio/headset.c:headset_init() Registered interface org.bluez.Headset on path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: audio/manager.c:handle_uuid() Found Handsfree record
bluetoothd[3276]: audio/manager.c:handle_uuid() Found Audio Sink
bluetoothd[3276]: audio/sink.c:sink_init() Registered interface org.bluez.AudioSink on path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: audio/manager.c:handle_uuid() Found AV Target
bluetoothd[3276]: audio/control.c:control_init() Registered interface org.bluez.Control on path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: audio/manager.c:handle_uuid() Found AV Remote
bluetoothd[3276]: plugins/mgmtops.c:mgmt_load_keys() index 0 keys 5 debug_keys 0
bluetoothd[3276]: plugins/mgmtops.c:mgmt_get_conn_list() index 0
bluetoothd[3276]: src/manager.c:btd_manager_register_adapter() Adapter /org/bluez/3276/hci0 registered
bluetoothd[3276]: src/adapter.c:btd_adapter_ref() 0x7ffff8212aa0: ref=4
bluetoothd[3276]: plugins/mgmtops.c:mgmt_set_name() index 0, name CSR - bc4
bluetoothd[3276]: plugins/mgmtops.c:mgmt_set_dev_class() index 0 major 1 minor 0
bluetoothd[3276]: audio/manager.c:state_changed() /org/bluez/3276/hci0 powered on
bluetoothd[3276]: plugins/mgmtops.c:mgmt_disable_cod_cache() index 0
bluetoothd[3276]: Adapter /org/bluez/3276/hci0 has been enabled
bluetoothd[3276]: src/adapter.c:adapter_mode_changed() old 0x00 new 0x02
bluetoothd[3276]: src/adapter.c:adapter_set_limited_discoverable() FALSE
bluetoothd[3276]: plugins/mgmtops.c:mgmt_set_limited_discoverable() index 0 limited 0
bluetoothd[3276]: src/adapter.c:set_mode_complete() 
bluetoothd[3276]: src/adapter.c:btd_adapter_unref() 0x7ffff8212aa0: ref=3
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() set_service_cache complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() set_dev_class complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 9 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_status() status 1 opcode 30 (index 0)
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 257 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:set_local_name_complete() hci0 name CSR - bc4
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() set_dev_class complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() set_service_cache complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 257 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:set_local_name_complete() hci0 name CSR - bc4
bluetoothd[3276]: Endpoint registered: sender=:1.28 path=/MediaEndpoint/HFPAG
bluetoothd[3276]: audio/avdtp.c:avdtp_register_sep() SEP 0x7ffff822b650 registered: type:0 codec:0 seid:2
bluetoothd[3276]: Endpoint registered: sender=:1.28 path=/MediaEndpoint/A2DPSource
bluetoothd[3276]: src/adapter.c:register_agent() Agent registered for hci0 at :1.13:/blueDevil_agent
bluetoothd[3276]: plugins/mgmtops.c:mgmt_set_io_capability() hci0 io_capability 0x01
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() set_io_capability complete
bluetoothd[3276]: plugins/mgmtops.c:mgmt_add_uuid() index 0
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() cond 1
bluetoothd[3276]: plugins/mgmtops.c:mgmt_event() Received 8 bytes from management socket
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() 
bluetoothd[3276]: plugins/mgmtops.c:mgmt_cmd_complete() add_uuid complete
bluetoothd[3276]: src/adapter.c:adapter_remove() Removing adapter /org/bluez/3276/hci0
bluetoothd[3276]: src/device.c:device_remove() Removing device /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: serial/manager.c:serial_remove() path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: serial/port.c:path_unregister() Unregistered interface org.bluez.Serial on path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: audio/unix.c:unix_device_removed() unix_device_removed(0x7ffff8218e60)
bluetoothd[3276]: audio/headset.c:path_unregister() Unregistered interface org.bluez.Headset on path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: audio/sink.c:path_unregister() Unregistered interface org.bluez.AudioSink on path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: audio/control.c:path_unregister() Unregistered interface org.bluez.Control on path /org/bluez/3276/hci0/dev_00_0B_E4_91_5D_0D
bluetoothd[3276]: src/device.c:btd_device_unref() 0x7ffff8216760: ref=1
bluetoothd[3276]: src/device.c:btd_device_unref() 0x7ffff8216760: ref=0
bluetoothd[3276]: src/device.c:device_free() 0x7ffff8216760
bluetoothd[3276]: src/device.c:device_remove() Removing device /org/bluez/3276/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[3276]: serial/manager.c:serial_remove() path /org/bluez/3276/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[3276]: serial/port.c:path_unregister() Unregistered interface org.bluez.Serial on path /org/bluez/3276/hci0/dev_00_22_98_CD_7A_E9
bluetoothd[3276]: audio/unix.c:unix_device_removed() unix_device_removed(0x7ffff821b620)
bluetoothd[3276]: src/device.c:btd_device_unref() 0x7ffff82195d0: ref=1
bluetoothd[3276]: src/device.c:btd_device_unref() 0x7ffff82195d0: ref=0
bluetoothd[3276]: src/device.c:device_free() 0x7ffff82195d0
bluetoothd[3276]: src/device.c:device_remove() Removing device /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[3276]: serial/manager.c:serial_remove() path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[3276]: serial/port.c:path_unregister() Unregistered interface org.bluez.Serial on path /org/bluez/3276/hci0/dev_E0_A6_70_2F_3A_B6
bluetoothd[3276]: audio/unix.c:unix_device_removed() unix_device_removed(0x7ffff8223d10)
bluetoothd[3276]: src/device.c:btd_device_unref() 0x7ffff821ba40: ref=1
bluetoothd[3276]: src/device.c:btd_device_unref() 0x7ffff821ba40: ref=0
bluetoothd[3276]: src/device.c:device_free() 0x7ffff821ba40
bluetoothd[3276]: src/device.c:device_remove() Removing device /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: serial/manager.c:serial_remove() path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: serial/port.c:path_unregister() Unregistered interface org.bluez.Serial on path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: audio/unix.c:unix_device_removed() unix_device_removed(0x7ffff82271f0)
bluetoothd[3276]: audio/headset.c:path_unregister() Unregistered interface org.bluez.Headset on path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: audio/sink.c:path_unregister() Unregistered interface org.bluez.AudioSink on path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: audio/control.c:path_unregister() Unregistered interface org.bluez.Control on path /org/bluez/3276/hci0/dev_40_2B_A1_61_DD_C5
bluetoothd[3276]: src/device.c:btd_device_unref() 0x7ffff8223e40: ref=1
bluetoothd[3276]: src/device.c:btd_device_unref() 0x7ffff8223e40: ref=0
bluetoothd[3276]: src/device.c:device_free() 0x7ffff8223e40
bluetoothd[3276]: src/device.c:device_remove() Removing device /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: serial/manager.c:serial_remove() path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: serial/port.c:path_unregister() Unregistered interface org.bluez.Serial on path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: audio/unix.c:unix_device_removed() unix_device_removed(0x7ffff8229c70)
bluetoothd[3276]: audio/headset.c:path_unregister() Unregistered interface org.bluez.Headset on path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: audio/sink.c:path_unregister() Unregistered interface org.bluez.AudioSink on path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: audio/control.c:path_unregister() Unregistered interface org.bluez.Control on path /org/bluez/3276/hci0/dev_00_22_FC_74_CA_27
bluetoothd[3276]: src/device.c:btd_device_unref() 0x7ffff8227530: ref=1
bluetoothd[3276]: src/device.c:btd_device_unref() 0x7ffff8227530: ref=0
bluetoothd[3276]: src/device.c:device_free() 0x7ffff8227530
bluetoothd[3276]: audio/manager.c:avrcp_server_remove() path /org/bluez/3276/hci0
bluetoothd[3276]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10004
bluetoothd[3276]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10003
bluetoothd[3276]: audio/manager.c:audio_adapter_unref() 0x7ffff8213350: ref=3
bluetoothd[3276]: audio/manager.c:a2dp_server_remove() path /org/bluez/3276/hci0
bluetoothd[3276]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7ffff8214be0 unregistered: type:0 codec:0 seid:1
bluetoothd[3276]: audio/media.c:media_endpoint_release() sender=:1.28 path=/MediaEndpoint/A2DPSource
bluetoothd[3276]: Endpoint unregistered: sender=:1.28 path=/MediaEndpoint/A2DPSource
bluetoothd[3276]: audio/media.c:media_endpoint_release() sender=:1.28 path=/MediaEndpoint/A2DPSource
bluetoothd[3276]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7ffff822b650 unregistered: type:0 codec:0 seid:2
bluetoothd[3276]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x7ffff822b650 unregistered: type:0 codec:0 seid:2
*** glibc detected *** /usr/sbin/bluetoothd: double free or corruption (!prev): 0x00007ffff822a920 ***
======= Backtrace: =========
/lib/x86_64-linux-gnu/libc.so.6(+0x72606)[0x7ffff6aa6606]
/lib/x86_64-linux-gnu/libc.so.6(cfree+0x6c)[0x7ffff6aab33c]
/lib/libglib-2.0.so.0(g_slist_foreach+0x27)[0x7ffff788e447]
/lib/libglib-2.0.so.0(g_slist_free_full+0xb)[0x7ffff788e46b]
/usr/sbin/bluetoothd(+0x29820)[0x7ffff7f82820]
/usr/sbin/bluetoothd(+0x1a8bd)[0x7ffff7f738bd]
/lib/libglib-2.0.so.0(g_slist_foreach+0x27)[0x7ffff788e447]
/usr/sbin/bluetoothd(+0x7163e)[0x7ffff7fca63e]
/usr/sbin/bluetoothd(+0x6db42)[0x7ffff7fc6b42]
/usr/sbin/bluetoothd(+0x16049)[0x7ffff7f6f049]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xfd)[0x7ffff6a52ead]
/usr/sbin/bluetoothd(+0x16335)[0x7ffff7f6f335]
======= Memory map: ========
7ffff0000000-7ffff0021000 rw-p 00000000 00:00 0 
7ffff0021000-7ffff4000000 ---p 00000000 00:00 0 
7ffff65e2000-7ffff65f7000 r-xp 00000000 08:01 1753108                    /lib/x86_64-linux-gnu/libgcc_s.so.1
7ffff65f7000-7ffff67f7000 ---p 00015000 08:01 1753108                    /lib/x86_64-linux-gnu/libgcc_s.so.1
7ffff67f7000-7ffff67f8000 rw-p 00015000 08:01 1753108                    /lib/x86_64-linux-gnu/libgcc_s.so.1
7ffff67f8000-7ffff6834000 r-xp 00000000 08:01 1753119                    /lib/x86_64-linux-gnu/libpcre.so.3.12.1
7ffff6834000-7ffff6a33000 ---p 0003c000 08:01 1753119                    /lib/x86_64-linux-gnu/libpcre.so.3.12.1
7ffff6a33000-7ffff6a34000 rw-p 0003b000 08:01 1753119                    /lib/x86_64-linux-gnu/libpcre.so.3.12.1
7ffff6a34000-7ffff6bae000 r-xp 00000000 08:01 1753090                    /lib/x86_64-linux-gnu/libc-2.13.so
7ffff6bae000-7ffff6dae000 ---p 0017a000 08:01 1753090                    /lib/x86_64-linux-gnu/libc-2.13.so
7ffff6dae000-7ffff6db2000 r--p 0017a000 08:01 1753090                    /lib/x86_64-linux-gnu/libc-2.13.so
7ffff6db2000-7ffff6db3000 rw-p 0017e000 08:01 1753090                    /lib/x86_64-linux-gnu/libc-2.13.so
7ffff6db3000-7ffff6db8000 rw-p 00000000 00:00 0 
7ffff6db8000-7ffff6dbf000 r-xp 00000000 08:01 1753407                    /lib/x86_64-linux-gnu/librt-2.13.so
7ffff6dbf000-7ffff6fbe000 ---p 00007000 08:01 1753407                    /lib/x86_64-linux-gnu/librt-2.13.so
7ffff6fbe000-7ffff6fbf000 r--p 00006000 08:01 1753407                    /lib/x86_64-linux-gnu/librt-2.13.so
7ffff6fbf000-7ffff6fc0000 rw-p 00007000 08:01 1753407                    /lib/x86_64-linux-gnu/librt-2.13.so
7ffff6fc0000-7ffff6fc2000 r-xp 00000000 08:01 1753395                    /lib/x86_64-linux-gnu/libdl-2.13.so
7ffff6fc2000-7ffff71c2000 ---p 00002000 08:01 1753395                    /lib/x86_64-linux-gnu/libdl-2.13.so
7ffff71c2000-7ffff71c3000 r--p 00002000 08:01 1753395                    /lib/x86_64-linux-gnu/libdl-2.13.so
7ffff71c3000-7ffff71c4000 rw-p 00003000 08:01 1753395                    /lib/x86_64-linux-gnu/libdl-2.13.so
7ffff71c4000-7ffff71c8000 r-xp 00000000 08:01 3024602                    /usr/lib/libcap-ng.so.0.0.0
7ffff71c8000-7ffff73c7000 ---p 00004000 08:01 3024602                    /usr/lib/libcap-ng.so.0.0.0
7ffff73c7000-7ffff73c8000 r--p 00003000 08:01 3024602                    /usr/lib/libcap-ng.so.0.0.0
7ffff73c8000-7ffff73c9000 rw-p 00004000 08:01 3024602                    /usr/lib/libcap-ng.so.0.0.0
7ffff73c9000-7ffff73e0000 r-xp 00000000 08:01 1753405                    /lib/x86_64-linux-gnu/libpthread-2.13.so
7ffff73e0000-7ffff75df000 ---p 00017000 08:01 1753405                    /lib/x86_64-linux-gnu/libpthread-2.13.so
7ffff75df000-7ffff75e0000 r--p 00016000 08:01 1753405                    /lib/x86_64-linux-gnu/libpthread-2.13.so
7ffff75e0000-7ffff75e1000 rw-p 00017000 08:01 1753405                    /lib/x86_64-linux-gnu/libpthread-2.13.so
7ffff75e1000-7ffff75e5000 rw-p 00000000 00:00 0 
7ffff75e5000-7ffff7628000 r-xp 00000000 08:01 1753124                    /lib/x86_64-linux-gnu/libdbus-1.so.3.6.3
7ffff7628000-7ffff7827000 ---p 00043000 08:01 1753124                    /lib/x86_64-linux-gnu/libdbus-1.so.3.6.3
7ffff7827000-7ffff7829000 r--p 00042000 08:01 1753124                    /lib/x86_64-linux-gnu/libdbus-1.so.3.6.3
7ffff7829000-7ffff782a000 rw-p 00044000 08:01 1753124                    /lib/x86_64-linux-gnu/libdbus-1.so.3.6.3
7ffff782a000-7ffff791a000 r-xp 00000000 08:01 1753205                    /lib/libglib-2.0.so.0.2800.6
7ffff791a000-7ffff7b19000 ---p 000f0000 08:01 1753205                    /lib/libglib-2.0.so.0.2800.6
7ffff7b19000-7ffff7b1a000 rw-p 000ef000 08:01 1753205                    /lib/libglib-2.0.so.0.2800.6
7ffff7b1a000-7ffff7b1b000 rw-p 00000000 00:00 0 
7ffff7b1b000-7ffff7b35000 r-xp 00000000 08:01 163913                     /usr/lib/x86_64-linux-gnu/libbluetooth.so.3.11.4
7ffff7b35000-7ffff7d34000 ---p 0001a000 08:01 163913                     /usr/lib/x86_64-linux-gnu/libbluetooth.so.3.11.4
7ffff7d34000-7ffff7d37000 rw-p 00019000 08:01 163913                     /usr/lib/x86_64-linux-gnu/libbluetooth.so.3.11.4
7ffff7d37000-7ffff7d56000 r-xp 00000000 08:01 1753410                    /lib/x86_64-linux-gnu/ld-2.13.so
7ffff7f2b000-7ffff7f31000 rw-p 00000000 00:00 0 
7ffff7f4c000-7ffff7f53000 r--s 00000000 08:01 207270                     /usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache
7ffff7f53000-7ffff7f55000 rw-p 00000000 00:00 0 
7ffff7f55000-7ffff7f56000 r-xp 00000000 00:00 0                          [vdso]
7ffff7f56000-7ffff7f57000 r--p 0001f000 08:01 1753410                    /lib/x86_64-linux-gnu/ld-2.13.so
7ffff7f57000-7ffff7f58000 rw-p 00020000 08:01 1753410                    /lib/x86_64-linux-gnu/ld-2.13.so
7ffff7f58000-7ffff7f59000 rw-p 00000000 00:00 0 
7ffff7f59000-7ffff7fff000 r-xp 00000000 08:01 3023299                    /usr/sbin/bluetoothd
7ffff81fe000-7ffff8206000 rw-p 000a5000 08:01 3023299                    /usr/sbin/bluetoothd
7ffff8206000-7ffff8247000 rw-p 00000000 00:00 0                          [heap]
7ffffffde000-7ffffffff000 rw-p 00000000 00:00 0                          [stack]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]

--Boundary-00=_/KSPORYEWJG6tNJ--
