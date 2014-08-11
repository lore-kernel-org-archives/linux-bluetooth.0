Return-Path: <cyrus@holtmann.org>
Message-ID: <53E8BCF6.6040502@linux.intel.com>
Date: Mon, 11 Aug 2014 15:54:14 +0300
From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Bug: bluetoothd dies when connecting device
Content-Type: multipart/mixed;
 boundary="------------000308030402090605070908"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000308030402090605070908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I tried to work on the oFono HFP patches for PulseAudio, but I couldn't 
really do anything, because BlueZ is basically not working at all on my 
machine. When I try to connect my Nokia BH-505 headset, bluetoothd sort 
of dies. The process doesn't terminate, but it disconnects from D-Bus.

I'm on Fedora 20, PulseAudio and BlueZ are compiled from current git 
master. oFono is not involved here in any way. I have attached an 
annotated log of the headset connecting process, in case someone wants 
to investigate this. The starting scenario in the log is that pulseaudio 
and bluetoothd are not running, and I have previously removed the 
headset from the BlueZ database. First I start pulseaudio with verbose 
logging and timestamps in the background, then in the same terminal I 
start bluetoothd with -d -n options in the background, and then still in 
the same terminal I start bluetoothctl to issue the commands for 
connecting the headset, so pulseuadio, bluetoothd and bluetoothctl 
output are all interleaved. Connecting the device appears to work at 
first, but when PulseAudio tries to start streaming to the headset, 
things fall apart.

-- 
Tanu

--------------000308030402090605070908
Content-Type: text/plain; charset=UTF-8;
 name="bluetooth_logs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bluetooth_logs.txt"

tanu@TKKASKIN_MOBL3_GER_CORP_INTEL_COM ~> (   0.000|   0.000) I: [pulseaudio] main.c: setrlimit(RLIMIT_NICE, (31, 31)) failed: Operation not permitted

*** Removed about 1500 lines of irrelevant pulseaudio startup log.

(   0.175|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/local/lib/pulse-5.0/modules/module-bluetooth-policy.so': success
(   0.175|   0.000) I: [pulseaudio] module.c: Loaded "module-bluetooth-policy" (index: #7; argument: "").
(   0.175|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/local/lib/pulse-5.0/modules/module-bluetooth-discover.so': success
(   0.176|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/local/lib/pulse-5.0/modules/module-bluez5-discover.so': success
(   0.177|   0.001) D: [pulseaudio] dbus-util.c: Successfully connected to D-Bus system bus 103c6c2f6f65f03fccdb8d6e53e8792b as :1.335
(   0.178|   0.001) I: [pulseaudio] module.c: Loaded "module-bluez5-discover" (index: #9; argument: "").
(   0.178|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/local/lib/pulse-5.0/modules/module-bluez4-discover.so': success
(   0.180|   0.002) I: [pulseaudio] module.c: Loaded "module-bluez4-discover" (index: #10; argument: "").
(   0.180|   0.000) I: [pulseaudio] module.c: Loaded "module-bluetooth-discover" (index: #8; argument: "").
(   0.180|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/local/lib/pulse-5.0/modules/module-esound-protocol-unix.so': success
(   0.181|   0.000) I: [pulseaudio] module.c: Loaded "module-esound-protocol-unix" (index: #11; argument: "").
(   0.183|   0.001) I: [pulseaudio] module.c: Loaded "module-native-protocol-unix" (index: #12; argument: "").
(   0.183|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/local/lib/pulse-5.0/modules/module-gconf.so': failure
(   0.183|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   0.183|   0.000) I: [pulseaudio] module-default-device-restore.c: Restored default sink 'alsa_output.pci-0000_00_1b.0.analog-stereo'.
(   0.196|   0.012) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   0.196|   0.000) I: [pulseaudio] module-default-device-restore.c: Restored default source 'alsa_input.pci-0000_00_1b.0.analog-stereo'.
(   0.196|   0.000) I: [pulseaudio] module.c: Loaded "module-default-device-restore" (index: #13; argument: "").
(   0.196|   0.000) I: [pulseaudio] module.c: Loaded "module-rescue-streams" (index: #14; argument: "").
(   0.196|   0.000) I: [pulseaudio] module.c: Loaded "module-always-sink" (index: #15; argument: "").
(   0.197|   0.000) I: [pulseaudio] module.c: Loaded "module-intended-roles" (index: #16; argument: "").
(   0.197|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Sink alsa_output.pci-0000_00_1b.0.analog-stereo becomes idle, timeout in 5 seconds.
(   0.197|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Source alsa_input.pci-0000_00_1b.0.analog-stereo becomes idle, timeout in 5 seconds.
(   0.197|   0.000) I: [pulseaudio] module.c: Loaded "module-suspend-on-idle" (index: #17; argument: "").
(   0.197|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/local/lib/pulse-5.0/modules/module-console-kit.so': success
(   0.198|   0.000) I: [pulseaudio] module.c: Loaded "module-console-kit" (index: #18; argument: "").
(   0.198|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/local/lib/pulse-5.0/modules/module-systemd-login.so': success
(   0.199|   0.000) I: [pulseaudio] client.c: Created 0 "Login Session 1"
(   0.199|   0.000) D: [pulseaudio] module-systemd-login.c: Added new session 1
(   0.199|   0.000) I: [pulseaudio] module.c: Loaded "module-systemd-login" (index: #19; argument: "").
(   0.199|   0.000) I: [pulseaudio] module.c: Loaded "module-position-event-sounds" (index: #20; argument: "").
(   0.200|   0.000) D: [pulseaudio] module-role-cork.c: Using role 'phone' as trigger role.
(   0.200|   0.000) D: [pulseaudio] module-role-cork.c: Using roles 'music' and 'video' as cork roles.
(   0.200|   0.000) I: [pulseaudio] module.c: Loaded "module-role-cork" (index: #21; argument: "").
(   0.200|   0.000) I: [pulseaudio] module.c: Loaded "module-filter-heuristics" (index: #22; argument: "").
(   0.201|   0.000) I: [pulseaudio] module.c: Loaded "module-filter-apply" (index: #23; argument: "").
(   0.201|   0.000) D: [pulseaudio] main.c: Got org.PulseAudio1!
(   0.201|   0.000) D: [pulseaudio] main.c: Got org.pulseaudio.Server!
(   0.201|   0.000) I: [pulseaudio] main.c: Daemon startup complete.
(   0.201|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus, path=/org/freedesktop/DBus, member=NameAcquired
(   0.202|   0.000) E: [pulseaudio] hfaudioagent-ofono.c: Failed to register as a handsfree audio agent with ofono: org.freedesktop.DBus.Error.ServiceUnknown: The name org.ofono was not provided by any .service files
(   0.202|   0.000) E: [pulseaudio] bluez5-util.c: GetManagedObjects() failed: org.freedesktop.systemd1.LoadFailed: Unit dbus-org.bluez.service failed to load: No such file or directory.
(   0.202|   0.000) I: [pulseaudio] client.c: Created 1 "Native client (UNIX socket client)"
(   0.202|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC0 is accessible: yes
(   0.202|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.pci-0000_00_1b.0.
(   0.202|   0.000) E: [pulseaudio] bluez4-util.c: org.bluez.Manager.GetProperties() failed: org.freedesktop.systemd1.LoadFailed: Unit dbus-org.bluez.service failed to load: No such file or directory.
(   0.202|   0.000) D: [pulseaudio] protocol-native.c: Protocol version: remote 29, local 30
(   0.202|   0.000) I: [pulseaudio] protocol-native.c: Got credentials: uid=1000 gid=1000 success=1
(   0.202|   0.000) D: [pulseaudio] protocol-native.c: SHM possible: yes
(   0.202|   0.000) D: [pulseaudio] protocol-native.c: Negotiated SHM: yes
(   0.202|   0.000) D: [pulseaudio] protocol-native.c: Disabling srbchannel, reason: Protocol too old
(   0.203|   0.000) D: [pulseaudio] module-augment-properties.c: Looking for .desktop file for gnome-settings-daemon
(   0.211|   0.008) I: [pulseaudio] client.c: Created 2 "Native client (UNIX socket client)"
(   0.212|   0.000) D: [pulseaudio] protocol-native.c: Protocol version: remote 29, local 30
(   0.212|   0.000) I: [pulseaudio] protocol-native.c: Got credentials: uid=1000 gid=1000 success=1
(   0.212|   0.000) D: [pulseaudio] protocol-native.c: SHM possible: yes
(   0.212|   0.000) D: [pulseaudio] protocol-native.c: Negotiated SHM: yes
(   0.212|   0.000) D: [pulseaudio] protocol-native.c: Disabling srbchannel, reason: Protocol too old
(   0.212|   0.000) D: [pulseaudio] module-augment-properties.c: Looking for .desktop file for gnome-shell
(   0.212|   0.000) D: [pulseaudio] module-augment-properties.c: Found /usr/share/applications/gnome-shell.desktop.
(   5.204|   4.991) I: [pulseaudio] module-suspend-on-idle.c: Source alsa_input.pci-0000_00_1b.0.analog-stereo idle for too long, suspending ...
(   5.204|   0.000) D: [pulseaudio] source.c: Suspend cause of source alsa_input.pci-0000_00_1b.0.analog-stereo is 0x0004, suspending
(   5.204|   0.000) I: [alsa-source-ALC269VC Analog] alsa-source.c: Device suspended...
(   5.204|   0.000) D: [pulseaudio] core.c: Hmm, no streams around, trying to vacuum.
(   5.205|   0.000) I: [pulseaudio] module-suspend-on-idle.c: Sink alsa_output.pci-0000_00_1b.0.analog-stereo idle for too long, suspending ...
(   5.205|   0.000) D: [pulseaudio] sink.c: Suspend cause of sink alsa_output.pci-0000_00_1b.0.analog-stereo is 0x0004, suspending
(   5.207|   0.001) I: [alsa-sink-ALC269VC Analog] alsa-sink.c: Device suspended...
(   5.207|   0.000) D: [pulseaudio] core.c: Hmm, no streams around, trying to vacuum.
(   5.208|   0.001) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC0 is accessible: yes
(   5.208|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.pci-0000_00_1b.0.

*** pulseaudio startup complete, let's start bluetoothd.

tanu@TKKASKIN_MOBL3_GER_CORP_INTEL_COM ~> sudo /usr/local/libexec/bluetooth/bluetoothd -n -d &
[2] 9534
tanu@TKKASKIN_MOBL3_GER_CORP_INTEL_COM ~> bluetoothd[9537]: Bluetooth daemon 5.22
bluetoothd[9537]: src/gatt.c:gatt_init() Starting GATT server
(  27.568|  22.359) D: [pulseaudio] bluez5-util.c: Bluetooth daemon appeared
(  27.568|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus, path=/org/freedesktop/DBus, member=NameOwnerChanged
bluetoothd[9537]: src/adapter.c:adapter_init() sending read version command
(  27.568|   0.000) D: [pulseaudio] bluez4-util.c: Bluetooth daemon appeared.
bluetoothd[9537]: Starting SDP server
bluetoothd[9537]: src/sdpd-service.c:register_device_id() Adding device id record for 0002:1d6b:0246:0516
bluetoothd[9537]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[9537]: src/plugin.c:add_plugin() Loading hostname plugin
bluetoothd[9537]: src/plugin.c:add_plugin() Loading wiimote plugin
bluetoothd[9537]: src/plugin.c:add_plugin() Loading autopair plugin
bluetoothd[9537]: src/plugin.c:add_plugin() Loading policy plugin
bluetoothd[9537]: src/plugin.c:add_plugin() Loading a2dp plugin
bluetoothd[9537]: src/plugin.c:add_plugin() Loading avrcp plugin
bluetoothd[9537]: src/plugin.c:add_plugin() Loading network plugin
bluetoothd[9537]: src/plugin.c:add_plugin() Loading input plugin
bluetoothd[9537]: src/plugin.c:add_plugin() Loading hog plugin
bluetoothd[9537]: src/plugin.c:add_plugin() Loading gatt plugin
bluetoothd[9537]: src/plugin.c:add_plugin() Loading scanparam plugin
bluetoothd[9537]: src/plugin.c:add_plugin() Loading deviceinfo plugin
bluetoothd[9537]: src/plugin.c:plugin_init() Loading plugins /usr/local/lib/bluetooth/plugins
bluetoothd[9537]: profiles/input/suspend-dummy.c:suspend_init() 
bluetoothd[9537]: profiles/input/suspend-dummy.c:suspend_init() Created suspend-dummy FIFO on /tmp/hogsuspend
bluetoothd[9537]: profiles/network/manager.c:read_config() Config options: Security=true
bluetoothd[9537]: plugins/hostname.c:read_dmi_fallback() chassis: laptop
bluetoothd[9537]: plugins/hostname.c:read_dmi_fallback() major: 0x01 minor: 0x03
(  27.574|   0.005) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.ObjectManager, path=/, member=InterfacesAdded
bluetoothd[9537]: src/main.c:main() Entering main loop
bluetoothd[9537]: src/rfkill.c:rfkill_event() RFKILL event idx 0 type 2 op 0 soft 0 hard 0
bluetoothd[9537]: Bluetooth management interface 1.5 initialized
bluetoothd[9537]: src/adapter.c:read_version_complete() sending read supported commands command
bluetoothd[9537]: src/adapter.c:read_version_complete() sending read index list command
bluetoothd[9537]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type 5 op 0 soft 0 hard 0
bluetoothd[9537]: src/rfkill.c:rfkill_event() RFKILL event idx 3 type 1 op 0 soft 0 hard 0
bluetoothd[9537]: src/adapter.c:read_commands_complete() Number of commands: 46
bluetoothd[9537]: src/adapter.c:read_commands_complete() Number of events: 23
bluetoothd[9537]: src/rfkill.c:rfkill_event() RFKILL event idx 6 type 2 op 0 soft 0 hard 0
bluetoothd[9537]: src/adapter.c:read_index_list_complete() Number of controllers: 1
bluetoothd[9537]: src/adapter.c:read_index_list_complete() Found index 0
bluetoothd[9537]: src/adapter.c:index_added() index 0
bluetoothd[9537]: src/adapter.c:btd_adapter_new() System name: BlueZ 5.22
bluetoothd[9537]: src/adapter.c:btd_adapter_new() Major class: 0
bluetoothd[9537]: src/adapter.c:btd_adapter_new() Minor class: 0
bluetoothd[9537]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d0516
bluetoothd[9537]: src/adapter.c:btd_adapter_new() Discoverable timeout: 180 seconds
bluetoothd[9537]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 seconds
bluetoothd[9537]: src/adapter.c:index_added() sending read info command for index 0
bluetoothd[9537]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[9537]: src/adapter.c:clear_uuids() sending clear uuids command for index 0
bluetoothd[9537]: src/attrib-server.c:btd_adapter_gatt_server_start() Start GATT server in hci0
bluetoothd[9537]: src/attrib-server.c:attrib_db_add_new() handle=0x0001
bluetoothd[9537]: src/attrib-server.c:attrib_db_add_new() handle=0x0004
bluetoothd[9537]: src/attrib-server.c:attrib_db_add_new() handle=0x0006
bluetoothd[9537]: src/attrib-server.c:attrib_db_add_new() handle=0x0007
bluetoothd[9537]: src/attrib-server.c:attrib_db_add_new() handle=0x0008
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001800-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: src/attrib-server.c:attrib_db_add_new() handle=0x0010
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001801-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: profiles/audio/a2dp.c:media_server_probe() path /org/bluez/hci0
bluetoothd[9537]: plugins/hostname.c:hostname_probe() 
bluetoothd[9537]: plugins/hostname.c:update_class() major: 0x01 minor: 0x03
bluetoothd[9537]: src/adapter.c:btd_adapter_set_class() class: major 1 minor 3
bluetoothd[9537]: src/adapter.c:set_dev_class() sending set device class command for index 0
bluetoothd[9537]: profiles/network/manager.c:panu_server_probe() path /org/bluez/hci0
bluetoothd[9537]: profiles/network/server.c:server_register() Registered interface org.bluez.NetworkServer1 on path /org/bluez/hci0
bluetoothd[9537]: profiles/network/manager.c:gn_server_probe() path /org/bluez/hci0
bluetoothd[9537]: profiles/network/manager.c:nap_server_probe() path /org/bluez/hci0
bluetoothd[9537]: profiles/audio/avrcp.c:avrcp_controller_server_probe() path /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10003
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110f-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: profiles/audio/avrcp.c:avrcp_target_server_probe() path /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: profiles/audio/a2dp.c:a2dp_sink_server_probe() path /org/bluez/hci0
bluetoothd[9537]: profiles/audio/a2dp.c:a2dp_source_server_probe() path /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:btd_adapter_unblock_address() hci0 00:00:00:00:00:00
bluetoothd[9537]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys 0
bluetoothd[9537]: src/adapter.c:load_ltks() hci0 keys 0
bluetoothd[9537]: src/adapter.c:load_irks() hci0 irks 0
bluetoothd[9537]: src/adapter.c:load_conn_params() hci0 conn params 0
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b product 246 version 516
bluetoothd[9537]: src/adapter.c:adapter_register() Adapter /org/bluez/hci0 registered
bluetoothd[9537]: src/adapter.c:set_dev_class() sending set device class command for index 0
bluetoothd[9537]: src/adapter.c:set_name() sending set local name command for index 0
bluetoothd[9537]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[9537]: src/adapter.c:load_link_keys_complete() link keys loaded for hci0
bluetoothd[9537]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[9537]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
bluetoothd[9537]: hci0 Load Connection Parameters failed: Unknown Command (0x01)
bluetoothd[9537]: src/adapter.c:local_name_changed_callback() Name: BlueZ 5.22
bluetoothd[9537]: src/adapter.c:local_name_changed_callback() Short name: 
bluetoothd[9537]: src/adapter.c:local_name_changed_callback() Current alias: BlueZ 5.22
bluetoothd[9537]: src/attrib-server.c:attrib_db_update() handle=0x0006
bluetoothd[9537]: src/profile.c:register_profile() sender :1.73
bluetoothd[9537]: src/profile.c:create_ext() Created "Message Notification"
bluetoothd[9537]: src/profile.c:ext_adapter_probe() "Message Notification" probed
bluetoothd[9537]: src/profile.c:ext_start_servers() Message Notification listening on PSM 4097
bluetoothd[9537]: src/profile.c:ext_start_servers() Message Notification listening on chan 17
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10005
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001133-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001134-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: src/profile.c:register_profile() sender :1.73
bluetoothd[9537]: src/profile.c:create_ext() Created "Message Access"
(  27.600|   0.026) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.ObjectManager, path=/, member=InterfacesAdded
bluetoothd[9537]: src/profile.c:ext_adapter_probe() "Message Access" probed
bluetoothd[9537]: src/profile.c:ext_start_servers() Message Access listening on chan 16
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10006
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001132-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001134-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: src/profile.c:register_profile() sender :1.73
bluetoothd[9537]: src/profile.c:create_ext() Created "Phone Book Access"
bluetoothd[9537]: src/profile.c:ext_adapter_probe() "Phone Book Access" probed
bluetoothd[9537]: src/profile.c:ext_start_servers() Phone Book Access listening on chan 15
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10007
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000112f-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001130-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: src/profile.c:register_profile() sender :1.73
bluetoothd[9537]: src/profile.c:create_ext() Created "Synchronization"
bluetoothd[9537]: src/profile.c:ext_adapter_probe() "Synchronization" probed
bluetoothd[9537]: src/profile.c:ext_start_servers() Synchronization listening on chan 14
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10008
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001104-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: src/profile.c:register_profile() sender :1.73
bluetoothd[9537]: src/profile.c:create_ext() Created "File Transfer"
bluetoothd[9537]: src/profile.c:ext_adapter_probe() "File Transfer" probed
bluetoothd[9537]: src/profile.c:ext_start_servers() File Transfer listening on PSM 4099
bluetoothd[9537]: src/profile.c:ext_start_servers() File Transfer listening on chan 10
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10009
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001106-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: src/profile.c:register_profile() sender :1.73
bluetoothd[9537]: src/profile.c:create_ext() Created "Object Push"
bluetoothd[9537]: src/profile.c:ext_adapter_probe() "Object Push" probed
bluetoothd[9537]: src/profile.c:ext_start_servers() Object Push listening on PSM 4101
bluetoothd[9537]: src/profile.c:ext_start_servers() Object Push listening on chan 9
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x1000a
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000008-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001105-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: plugins/hostname.c:property_changed() static hostname: tkkaskin-mobl3.ger.corp.intel.com
bluetoothd[9537]: plugins/hostname.c:property_changed() pretty hostname: 
(  27.620|   0.019) D: [pulseaudio] bluez5-util.c: Unknown interface org.freedesktop.DBus.Introspectable found, skipping
(  27.620|   0.000) D: [pulseaudio] bluez5-util.c: Unknown interface org.bluez.AgentManager1 found, skipping
(  27.620|   0.000) D: [pulseaudio] bluez5-util.c: Unknown interface org.bluez.ProfileManager1 found, skipping
(  27.620|   0.000) D: [pulseaudio] bluez5-util.c: Unknown interface org.freedesktop.DBus.Introspectable found, skipping
(  27.620|   0.000) D: [pulseaudio] bluez5-util.c: Adapter /org/bluez/hci0 found
(  27.620|   0.000) D: [pulseaudio] bluez5-util.c: Registering /MediaEndpoint/A2DPSource on adapter /org/bluez/hci0
bluetoothd[9537]: plugins/hostname.c:update_name() name: tkkaskin-mobl3.ger.corp.intel.com
(  27.620|   0.000) D: [pulseaudio] bluez5-util.c: Registering /MediaEndpoint/A2DPSink on adapter /org/bluez/hci0
(  27.620|   0.000) D: [pulseaudio] bluez5-util.c: Unknown interface org.freedesktop.DBus.Properties found, skipping
(  27.620|   0.000) D: [pulseaudio] bluez5-util.c: Unknown interface org.bluez.Media1 found, skipping
(  27.620|   0.000) D: [pulseaudio] bluez5-util.c: Unknown interface org.bluez.NetworkServer1 found, skipping
(  27.621|   0.000) E: [pulseaudio] bluez4-util.c: org.bluez.Manager.GetProperties() failed: org.freedesktop.DBus.Error.UnknownMethod: Method "GetProperties" with signature "" on interface "org.bluez.Manager" doesn't exist
bluetoothd[9537]: src/adapter.c:adapter_set_name() name: tkkaskin-mobl3.ger.corp.intel.com
bluetoothd[9537]: src/adapter.c:adapter_set_name() alias: tkkaskin-mobl3.ger.corp.intel.com
bluetoothd[9537]: src/adapter.c:set_name() sending set local name command for index 0
bluetoothd[9537]: plugins/hostname.c:property_changed() chassis: laptop
bluetoothd[9537]: plugins/hostname.c:update_class() major: 0x01 minor: 0x03
bluetoothd[9537]: src/adapter.c:local_name_changed_callback() Name: tkkaskin-mobl3.ger.corp.intel.com
bluetoothd[9537]: src/adapter.c:local_name_changed_callback() Short name: 
bluetoothd[9537]: src/adapter.c:local_name_changed_callback() Current alias: tkkaskin-mobl3.ger.corp.intel.com
bluetoothd[9537]: src/attrib-server.c:attrib_db_update() handle=0x0006
(  27.623|   0.002) D: [pulseaudio] bluez5-util.c: Properties changed in adapter /org/bluez/hci0
(  27.623|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.Properties, path=/org/bluez/hci0, member=PropertiesChanged
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_register_sep() SEP 0xe4e1d0 registered: type:0 codec:0 seid:1
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x1000b
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: Endpoint registered: sender=:1.335 path=/MediaEndpoint/A2DPSource
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_register_sep() SEP 0xe491c0 registered: type:1 codec:0 seid:2
(  27.626|   0.003) D: [pulseaudio] bluez5-util.c: Properties changed in adapter /org/bluez/hci0
(  27.626|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.Properties, path=/org/bluez/hci0, member=PropertiesChanged
bluetoothd[9537]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x1000c
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110b-0000-1000-8000-00805f9
bluetoothd[9537]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[9537]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[9537]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[9537]: Endpoint registered: sender=:1.335 path=/MediaEndpoint/A2DPSink
(  27.629|   0.002) D: [pulseaudio] bluez5-util.c: Properties changed in adapter /org/bluez/hci0
(  27.629|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.Properties, path=/org/bluez/hci0, member=PropertiesChanged
bluetoothd[9537]: src/adapter.c:property_set_mode() sending Set Powered command for index 0
bluetoothd[9537]: src/adapter.c:dev_class_changed_callback() Class: 0x1c010c
bluetoothd[9537]: src/attrib-server.c:attrib_db_update() handle=0x0008
(  27.749|   0.119) D: [pulseaudio] bluez5-util.c: Properties changed in adapter /org/bluez/hci0
(  27.749|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.Properties, path=/org/bluez/hci0, member=PropertiesChanged
bluetoothd[9537]: src/adapter.c:property_set_mode_complete() Success (0x00)
bluetoothd[9537]: src/adapter.c:new_settings_callback() Settings: 0x000002d3
bluetoothd[9537]: src/adapter.c:settings_changed() Changed settings: 0x00000001
bluetoothd[9537]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
bluetoothd[9537]: src/adapter.c:trigger_passive_scanning() 
(  27.753|   0.003) D: [pulseaudio] bluez5-util.c: Properties changed in adapter /org/bluez/hci0
(  27.753|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.Properties, path=/org/bluez/hci0, member=PropertiesChanged
bluetoothd[9537]: src/agent.c:agent_ref() 0xe3f880: ref=1
bluetoothd[9537]: src/agent.c:register_agent() agent :1.67
bluetoothd[9537]: src/agent.c:add_default_agent() Default agent set to :1.67 /org/bluez/agent/gnome
bluetoothd[9537]: src/agent.c:unregister_agent() agent :1.67
bluetoothd[9537]: src/agent.c:agent_disconnect() Agent :1.67 disconnected
bluetoothd[9537]: src/agent.c:remove_default_agent() Default agent cleared
bluetoothd[9537]: src/agent.c:agent_destroy() agent :1.67
bluetoothd[9537]: src/agent.c:agent_unref() 0xe3f880: ref=0
bluetoothd[9537]: src/agent.c:agent_ref() 0xe426f0: ref=1
bluetoothd[9537]: src/agent.c:register_agent() agent :1.67
bluetoothd[9537]: src/agent.c:add_default_agent() Default agent set to :1.67 /org/bluez/agent/gnome

*** bluetoothd startup complete, let's start bluetoothctl.

tanu@TKKASKIN_MOBL3_GER_CORP_INTEL_COM ~> bluetoothctl
[NEW] Controller 7C:E9:D3:EA:69:B2 tkkaskin-mobl3.ger.corp.intel.com [default]

*** Turn on the headset in discovery mode.

[bluetooth]# scan on
[bluetooth]# bluetoothd[9537]: src/adapter.c:start_discovery() sender :1.337
bluetoothd[9537]: src/adapter.c:trigger_start_discovery() 
bluetoothd[9537]: src/adapter.c:cancel_passive_scanning() 
Discovery started
[bluetooth]# bluetoothd[9537]: src/adapter.c:start_discovery_timeout() 
bluetoothd[9537]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[9537]: src/adapter.c:discovering_callback() hci0 type 7 discovering 1
(  61.290|  33.537) D: [pulseaudio] bluez5-util.c: Properties changed in adapter /org/bluez/hci0
(  61.290|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.Properties, path=/org/bluez/hci0, member=PropertiesChanged
[CHG] Controller 7C:E9:D3:EA:69:B2 Discovering: yes
[bluetooth]# bluetoothd[9537]: src/adapter.c:device_found_callback() hci0 addr 00:1E:DE:29:B7:3B, rssi -48 flags 0x0001 eir_len 31
bluetoothd[9537]: src/device.c:device_create() dst 00:1E:DE:29:B7:3B
bluetoothd[9537]: src/device.c:device_new() address 00:1E:DE:29:B7:3B
bluetoothd[9537]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
bluetoothd[9537]: src/device.c:device_set_legacy() legacy 0
bluetoothd[9537]: src/device.c:device_set_rssi() rssi -48
bluetoothd[9537]: src/device.c:device_set_class() /org/bluez/hci0/dev_00_1E_DE_29_B7_3B 0x240404
bluetoothd[9537]: src/adapter.c:confirm_name() hci0 bdaddr 00:1E:DE:29:B7:3B name_known 1
bluetoothd[9537]: src/adapter.c:confirm_name_complete() Confirm name complete for hci0
(  71.238|   9.947) D: [pulseaudio] bluez5-util.c: Unknown interface org.freedesktop.DBus.Introspectable found, skipping
(  71.238|   0.000) D: [pulseaudio] bluez5-util.c: Device /org/bluez/hci0/dev_00_1E_DE_29_B7_3B found
(  71.238|   0.000) D: [pulseaudio] bluez5-util.c: Address: 00:1E:DE:29:B7:3B
(  71.238|   0.000) D: [pulseaudio] bluez5-util.c: Alias: Nokia BH-505
(  71.238|   0.000) D: [pulseaudio] bluez5-util.c: Class: 2360324
(  71.238|   0.000) D: [pulseaudio] bluez5-util.c: UUIDs: 0000111e-0000-1000-8000-00805f9b34fb
(  71.238|   0.000) D: [pulseaudio] bluez5-util.c: UUIDs: 00001108-0000-1000-8000-00805f9b34fb
(  71.238|   0.000) D: [pulseaudio] bluez5-util.c: UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
(  71.238|   0.000) D: [pulseaudio] bluez5-util.c: UUIDs: 0000110d-0000-1000-8000-00805f9b34fb
(  71.238|   0.000) D: [pulseaudio] bluez5-util.c: UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
(  71.238|   0.000) D: [pulseaudio] bluez5-util.c: Adapter: /org/bluez/hci0
(  71.238|   0.000) D: [pulseaudio] bluez5-util.c: Unknown interface org.freedesktop.DBus.Properties found, skipping
(  71.239|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.ObjectManager, path=/, member=InterfacesAdded
[NEW] Device 00:1E:DE:29:B7:3B Nokia BH-505
[bluetooth]# bluetoothd[9537]: src/adapter.c:discovering_callback() hci0 type 7 discovering 0
bluetoothd[9537]: src/adapter.c:trigger_start_discovery() 
bluetoothd[9537]: src/adapter.c:cancel_passive_scanning() 

*** Headset found, let's turn off scanning.

[bluetooth]# scan off
[bluetooth]# bluetoothd[9537]: src/adapter.c:stop_discovery() sender :1.337
bluetoothd[9537]: src/adapter.c:discovery_destroy() owner :1.337
bluetoothd[9537]: src/device.c:device_set_rssi() rssi 0
bluetoothd[9537]: src/adapter.c:trigger_passive_scanning() 
(  75.870|   4.631) D: [pulseaudio] bluez5-util.c: Properties changed in device /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
(  75.870|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.Properties, path=/org/bluez/hci0/dev_00_1E_DE_29_B7_3B, member=PropertiesChanged
(  75.870|   0.000) D: [pulseaudio] bluez5-util.c: Properties changed in adapter /org/bluez/hci0
(  75.871|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.Properties, path=/org/bluez/hci0, member=PropertiesChanged
[CHG] Device 00:1E:DE:29:B7:3B RSSI is nil
[CHG] Controller 7C:E9:D3:EA:69:B2 Discovering: no
Discovery stopped

*** I was supposed to pair the device at this point, but I forgot that and went straight to connecting, which appeared to work anyway without explicit pairing step.

[bluetooth]# connect 00:1E:DE:29:B7:3B
Attempting to connect to 00:1E:DE:29:B7:3B
[bluetooth]# bluetoothd[9537]: src/device.c:connect_profiles() /org/bluez/hci0/dev_00_1E_DE_29_B7_3B (all), client :1.337
bluetoothd[9537]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[9537]: src/device.c:connect_profiles() Resolving services for /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
[bluetooth]# bluetoothd[9537]: src/adapter.c:connected_callback() hci0 device 00:1E:DE:29:B7:3B connected eir_len 19
(  97.389|  21.518) D: [pulseaudio] bluez5-util.c: Properties changed in device /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
[CHG] Device 00:1E:DE:29:B7:3B Connected: yes
[bluetooth]# (  97.389|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.Properties, path=/org/bluez/hci0/dev_00_1E_DE_29_B7_3B, member=PropertiesChanged
bluetoothd[9537]: src/device.c:device_probe_profiles() Probing profiles for device 00:1E:DE:29:B7:3B
bluetoothd[9537]: profiles/audio/avrcp.c:avrcp_controller_probe() path /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
bluetoothd[9537]: profiles/audio/control.c:control_init() Registered interface org.bluez.MediaControl1 on path /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
bluetoothd[9537]: src/service.c:btd_service_ref() 0xe63670: ref=2
bluetoothd[9537]: src/service.c:change_state() 0xe63670: device 00:1E:DE:29:B7:3B profile avrcp-controller state changed: unavailable -> disconnected (0)
bluetoothd[9537]: profiles/audio/avrcp.c:avrcp_target_probe() path /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
bluetoothd[9537]: src/service.c:btd_service_ref() 0xe636f0: ref=2
bluetoothd[9537]: src/service.c:change_state() 0xe636f0: device 00:1E:DE:29:B7:3B profile audio-avrcp-target state changed: unavailable -> disconnected (0)
bluetoothd[9537]: profiles/audio/a2dp.c:a2dp_sink_probe() path /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
bluetoothd[9537]: profiles/audio/sink.c:sink_init() /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
bluetoothd[9537]: src/service.c:btd_service_ref() 0xe63720: ref=2
bluetoothd[9537]: src/service.c:change_state() 0xe63720: device 00:1E:DE:29:B7:3B profile a2dp-sink state changed: unavailable -> disconnected (0)
bluetoothd[9537]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_00_1E_DE_29_B7_3B err 0
bluetoothd[9537]: src/device.c:connect_profiles() /org/bluez/hci0/dev_00_1E_DE_29_B7_3B (all), client :1.337
bluetoothd[9537]: profiles/audio/a2dp.c:a2dp_sink_connect() path /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_ref() 0xe61030: ref=1
bluetoothd[9537]: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci0/dev_00_1E_DE_29_B7_3B: SINK_STATE_DISCONNECTED -> SINK_STATE_CONNECTING
bluetoothd[9537]: profiles/audio/sink.c:sink_connect() stream creation in progress
bluetoothd[9537]: src/service.c:change_state() 0xe63720: device 00:1E:DE:29:B7:3B profile a2dp-sink state changed: disconnected -> connecting (0)
(  97.502|   0.113) D: [pulseaudio] bluez5-util.c: Unknown interface org.bluez.MediaControl1 found, skipping
(  97.503|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.ObjectManager, path=/, member=InterfacesAdded
(  97.503|   0.000) D: [pulseaudio] bluez5-util.c: Properties changed in device /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
(  97.503|   0.000) D: [pulseaudio] bluez5-util.c: UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
(  97.503|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.Properties, path=/org/bluez/hci0/dev_00_1E_DE_29_B7_3B, member=PropertiesChanged
[CHG] Device 00:1E:DE:29:B7:3B UUIDs:
	00001108-0000-1000-8000-00805f9b34fb
	0000110b-0000-1000-8000-00805f9b34fb
	0000110c-0000-1000-8000-00805f9b34fb
	0000110e-0000-1000-8000-00805f9b34fb
	0000111e-0000-1000-8000-00805f9b34fb
[bluetooth]# bluetoothd[9537]: src/adapter.c:new_link_key_callback() hci0 new key for 00:1E:DE:29:B7:3B type 4 pin_len 0
bluetoothd[9537]: src/device.c:device_set_bonded() 
bluetoothd[9537]: src/device.c:device_bonding_complete() bonding (nil) status 0x00
bluetoothd[9537]: src/adapter.c:resume_discovery() 
(  98.998|   1.495) D: [pulseaudio] bluez5-util.c: Properties changed in device /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
(  98.998|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.Properties, path=/org/bluez/hci0/dev_00_1E_DE_29_B7_3B, member=PropertiesChanged
[CHG] Device 00:1E:DE:29:B7:3B Paired: yes
[bluetooth]# bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP: connected signaling channel to 00:1E:DE:29:B7:3B
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=672, omtu=895
bluetoothd[9537]: profiles/audio/avdtp.c:session_cb() 
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_parse_resp() DISCOVER request succeeded
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_discover_resp() seid 1 type 1 media 0 in use 0
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_discover_resp() seid 2 type 1 media 0 in use 0
bluetoothd[9537]: profiles/audio/avdtp.c:session_cb() 
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_parse_resp() GET_CAPABILITIES request succeeded
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_get_capabilities_resp() seid 1 type 1 media 0
bluetoothd[9537]: profiles/audio/avdtp.c:session_cb() 
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_parse_resp() GET_CAPABILITIES request succeeded
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_get_capabilities_resp() seid 2 type 1 media 0
bluetoothd[9537]: profiles/audio/sink.c:discovery_complete() Discovery complete
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_ref() 0xe61030: ref=2
bluetoothd[9537]: profiles/audio/a2dp.c:setup_ref() 0xe42e00: ref=1
bluetoothd[9537]: profiles/audio/media.c:media_endpoint_async_call() Calling SelectConfiguration: name = :1.335 path = /MediaEndpoint/A2DPSource
( 101.778|   2.779) D: [pulseaudio] bluez4-util.c: dbus: interface=org.bluez.MediaEndpoint1, path=/MediaEndpoint/A2DPSource, member=SelectConfiguration
( 101.778|   0.000) D: [pulseaudio] bluez5-util.c: dbus: path=/MediaEndpoint/A2DPSource, interface=org.bluez.MediaEndpoint1, member=SelectConfiguration
bluetoothd[9537]: profiles/audio/a2dp.c:a2dp_config() a2dp_config: selected SEP 0xe4e1d0
bluetoothd[9537]: profiles/audio/a2dp.c:setup_ref() 0xe42e00: ref=2
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_set_configuration() 0xe61030: int_seid=1, acp_seid=1
bluetoothd[9537]: profiles/audio/a2dp.c:setup_unref() 0xe42e00: ref=1
bluetoothd[9537]: profiles/audio/avdtp.c:session_cb() 
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_parse_resp() SET_CONFIGURATION request succeeded
bluetoothd[9537]: profiles/audio/a2dp.c:setconf_cfm() Source 0xe4e1d0: Set_Configuration_Cfm
bluetoothd[9537]: profiles/audio/media.c:media_endpoint_async_call() Calling SetConfiguration: name = :1.335 path = /MediaEndpoint/A2DPSource
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: IDLE -> CONFIGURED
( 101.811|   0.032) D: [pulseaudio] bluez5-util.c: Unknown interface org.freedesktop.DBus.Introspectable found, skipping
( 101.811|   0.000) D: [pulseaudio] bluez5-util.c: Unknown interface org.bluez.MediaTransport1 found, skipping
( 101.811|   0.000) D: [pulseaudio] bluez5-util.c: Unknown interface org.freedesktop.DBus.Properties found, skipping
( 101.811|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus.ObjectManager, path=/, member=InterfacesAdded
( 101.811|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.bluez.MediaEndpoint1, path=/MediaEndpoint/A2DPSource, member=SetConfiguration
( 101.811|   0.000) D: [pulseaudio] bluez5-util.c: dbus: path=/MediaEndpoint/A2DPSource, interface=org.bluez.MediaEndpoint1, member=SetConfiguration
( 101.811|   0.000) D: [pulseaudio] bluez5-util.c: Transport /org/bluez/hci0/dev_00_1E_DE_29_B7_3B/fd0 state changed from disconnected to idle
( 101.811|   0.000) D: [pulseaudio] module-bluez5-discover.c: Loading module-bluez5-device path=/org/bluez/hci0/dev_00_1E_DE_29_B7_3B
( 101.813|   0.001) I: [pulseaudio] module-card-restore.c: Restored profile 'a2dp' for card bluez_card.00_1E_DE_29_B7_3B.
( 101.813|   0.000) I: [pulseaudio] module-card-restore.c: Restoring port latency offsets for card bluez_card.00_1E_DE_29_B7_3B.
( 101.813|   0.000) I: [pulseaudio] card.c: Created 1 "bluez_card.00_1E_DE_29_B7_3B"
( 101.813|   0.000) D: [pulseaudio] module-bluez5-device.c: Acquiring transport /org/bluez/hci0/dev_00_1E_DE_29_B7_3B/fd0
bluetoothd[9537]: profiles/audio/transport.c:media_owner_create() Owner created: sender=:1.335
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_ref() 0xe61030: ref=3
bluetoothd[9537]: profiles/audio/a2dp.c:a2dp_sep_lock() SEP 0xe4e1d0 locked
bluetoothd[9537]: profiles/audio/a2dp.c:setup_ref() 0xe42e00: ref=2
bluetoothd[9537]: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci0/dev_00_1E_DE_29_B7_3B/fd0: TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_REQUESTING
bluetoothd[9537]: profiles/audio/transport.c:media_request_create() Request created: method=Acquire id=3
bluetoothd[9537]: profiles/audio/transport.c:media_owner_add() Owner :1.335 Request Acquire
bluetoothd[9537]: profiles/audio/transport.c:media_transport_set_owner() Transport /org/bluez/hci0/dev_00_1E_DE_29_B7_3B/fd0 Owner :1.335
bluetoothd[9537]: profiles/audio/avdtp.c:session_cb() 
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_parse_resp() OPEN request succeeded
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP: connected transport channel to 00:1E:DE:29:B7:3B
bluetoothd[9537]: profiles/audio/avdtp.c:handle_transport_connect() Flushable packets enabled
bluetoothd[9537]: profiles/audio/avdtp.c:handle_transport_connect() sk 29, omtu 895, send buffer size 106496
bluetoothd[9537]: profiles/audio/a2dp.c:open_cfm() Source 0xe4e1d0: Open_Cfm
bluetoothd[9537]: profiles/audio/a2dp.c:setup_unref() 0xe42e00: ref=1
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: CONFIGURED -> OPEN
bluetoothd[9537]: src/service.c:change_state() 0xe63720: device 00:1E:DE:29:B7:3B profile a2dp-sink state changed: connecting -> connected (0)
bluetoothd[9537]: src/device.c:device_profile_connected() a2dp-sink Success (0)
bluetoothd[9537]: src/device.c:device_profile_connected() returning response to :1.337
bluetoothd[9537]: plugins/policy.c:policy_connect() /org/bluez/hci0/dev_00_1E_DE_29_B7_3B profile avrcp-controller
bluetoothd[9537]: profiles/audio/avrcp.c:avrcp_connect() path /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
bluetoothd[9537]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
bluetoothd[9537]: src/service.c:change_state() 0xe63670: device 00:1E:DE:29:B7:3B profile avrcp-controller state changed: disconnected -> connecting (0)
Connection successful
[bluetooth]# bluetoothd[9537]: src/service.c:btd_service_ref() 0xe63720: ref=3
bluetoothd[9537]: plugins/policy.c:service_cb() Added a2dp-sink reconnect 0
bluetoothd[9537]: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci0/dev_00_1E_DE_29_B7_3B: SINK_STATE_CONNECTING -> SINK_STATE_CONNECTED
bluetoothd[9537]: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci0/dev_00_1E_DE_29_B7_3B/fd0 State=TRANSPORT_STATE_REQUESTING Playing=0
bluetoothd[9537]: profiles/audio/avdtp.c:session_cb() 
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_parse_resp() START request succeeded
bluetoothd[9537]: profiles/audio/a2dp.c:start_cfm() Source 0xe4e1d0: Start_Cfm
bluetoothd[9537]: /org/bluez/hci0/dev_00_1E_DE_29_B7_3B/fd0: fd(29) ready
bluetoothd[9537]: profiles/audio/transport.c:media_owner_remove() Owner :1.335 Request Acquire
bluetoothd[9537]: profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci0/dev_00_1E_DE_29_B7_3B/fd0: TRANSPORT_STATE_REQUESTING -> TRANSPORT_STATE_ACTIVE
bluetoothd[9537]: profiles/audio/a2dp.c:setup_unref() 0xe42e00: ref=0
bluetoothd[9537]: profiles/audio/a2dp.c:setup_free() 0xe42e00
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_unref() 0xe61030: ref=2
bluetoothd[9537]: profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed: OPEN -> STREAMING
bluetoothd[9537]: profiles/audio/sink.c:sink_set_state() State changed /org/bluez/hci0/dev_00_1E_DE_29_B7_3B: SINK_STATE_CONNECTED -> SINK_STATE_PLAYING
bluetoothd[9537]: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci0/dev_00_1E_DE_29_B7_3B/fd0 State=TRANSPORT_STATE_ACTIVE Playing=1
( 102.747|   0.934) E: [pulseaudio] bluez5-util.c: Transport Acquire() failed for transport /org/bluez/hci0/dev_00_1E_DE_29_B7_3B/fd0 (Message did not receive a reply (timeout by message bus))
( 102.747|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
( 102.747|   0.000) I: [pulseaudio] card.c: Changed profile of card 1 "bluez_card.00_1E_DE_29_B7_3B" to off
( 102.747|   0.000) I: [pulseaudio] module.c: Loaded "module-bluez5-device" (index: #24; argument: "path=/org/bluez/hci0/dev_00_1E_DE_29_B7_3B").
( 102.748|   0.000) D: [pulseaudio] bluez5-util.c: Transport /org/bluez/hci0/dev_00_1E_DE_29_B7_3B/fd0 available for profile a2dp_sink
( 102.748|   0.000) D: [pulseaudio] bluez5-util.c: Bluetooth daemon disappeared

*** Note the above message, apparently bluetoothd disconnected from D-Bus. I suppose that should never happen.

( 102.748|   0.000) D: [pulseaudio] bluez5-util.c: Transport /org/bluez/hci0/dev_00_1E_DE_29_B7_3B/fd0 state changed from idle to disconnected
( 102.748|   0.000) D: [pulseaudio] card.c: Setting card bluez_card.00_1E_DE_29_B7_3B profile a2dp_sink to availability status no
( 102.748|   0.000) D: [pulseaudio] device-port.c: Setting port headset-output to status no
( 102.748|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
( 102.748|   0.000) D: [pulseaudio] module-bluez5-discover.c: Unregistering module for /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
( 102.748|   0.000) D: [pulseaudio] module-bluez5-device.c: Unloading module for device /org/bluez/hci0/dev_00_1E_DE_29_B7_3B
[DEL] Controller 7C:E9:D3:EA:69:B2 tkkaskin-mobl3.ger.corp.intel.com [default]
( 102.748|   0.000) I: [pulseaudio] module.c: Unloading "module-bluez5-device" (index: #24).
[bluetooth]# ( 102.748|   0.000) I: [pulseaudio] card.c: Freed 1 "bluez_card.00_1E_DE_29_B7_3B"
( 102.748|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 102.748|   0.000) I: [pulseaudio] module.c: Unloaded "module-bluez5-device" (index: #24).
( 102.749|   0.000) D: [pulseaudio] bluez4-util.c: dbus: interface=org.freedesktop.DBus, path=/org/freedesktop/DBus, member=NameOwnerChanged
( 102.749|   0.000) D: [pulseaudio] bluez4-util.c: Bluetooth daemon disappeared.
[bluetooth]# bluetoothd[9537]: profiles/audio/avctp.c:avctp_confirm_cb() AVCTP: incoming connect from 00:1E:DE:29:B7:3B
bluetoothd[9537]: Control: Refusing unexpected connect
bluetoothd[9537]: profiles/audio/avctp.c:avctp_set_state() AVCTP Disconnected
bluetoothd[9537]: connect error: Connection refused (111)

--------------000308030402090605070908--
