Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 10 Aug 2012 22:32:54 -0400
Message-ID: <CABSPFiQUBj-TPDJw1CnP=EXCG0fT0rABZpv2_azTKAM9UbydKA@mail.gmail.com>
Subject: Bluetooth Device Class not detected properly. Can't even force
 through /etc/bluetooth/main.conf
From: Ryan <kribby@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry if this doesn't come out the way it's suppose to.....this is my
first time sending something to a mailing list

My problem relates to the bluetooth card in my Lenovo Thinkpad T500
(Broadcom BCM2046) not setting the correct device class, resulting in
a very limited number of services being loaded.  The affected
distributions are Arch Linux and the Chakra Project (based off Arch
Linux), and I also talked with someone in #bluez who has the same
problem with a Marvell bluetooth card and Debian Linux.  After the
bootup of Chakra, here's the output of 'hciconfig -a'

hci0:    Type: BR/EDR  Bus: USB
    BD Address: 00:26:5E:BA:00:18  ACL MTU: 1021:8  SCO MTU: 64:1
    UP RUNNING PSCAN ISCAN
    RX bytes:1289 acl:0 sco:0 events:51 errors:0
    TX bytes:1194 acl:0 sco:0 commands:51 errors:0
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy: RSWITCH HOLD SNIFF PARK
    Link mode: SLAVE ACCEPT
    Name: 'chakra-pc-0'
    Class: 0x400100
    Service Classes: Telephony
    Device Class: Computer, Uncategorized
    HCI Version: 2.1 (0x4)  Revision: 0x518f
    LMP Version: 2.1 (0x4)  Subversion: 0x424c
    Manufacturer: Broadcom Corporation (15)

Notice the Class field only says 0x400100.  For me this only loads
Audio Sink and 2 other service.  I should also note that I can set the
class by using 'hciconfig hci0 class 0x7e0100', however, it is always
changed back when stopping and starting bluetoothd.  Setting 0x7e0100
as the default in main.conf also doesn't change the class the card
uses.  Here's the output of 'bluetoothd -d -n'

[root@chakra-pc kurbster]# bluetoothd -d -n > bluetoothd
bluetoothd[2175]: Bluetooth daemon 4.99
bluetoothd[2175]: src/main.c:parse_config() parsing main.conf
bluetoothd[2175]: src/main.c:parse_config() discovto=0
bluetoothd[2175]: src/main.c:parse_config() pairto=0
bluetoothd[2175]: src/main.c:parse_config() pageto=8192
bluetoothd[2175]: src/main.c:parse_config() auto_to=60
bluetoothd[2175]: src/main.c:parse_config() name=%h-%d
bluetoothd[2175]: src/main.c:parse_config() class=0x7e0100
bluetoothd[2175]: src/main.c:parse_config() discov_interval=30
bluetoothd[2175]: src/main.c:parse_config() Key file does not have key
'DeviceID'
bluetoothd[2175]: Starting SDP server
bluetoothd[2175]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[2175]: src/plugin.c:add_plugin() Loading audio plugin
bluetoothd[2175]: src/plugin.c:add_plugin() Loading input plugin
bluetoothd[2175]: src/plugin.c:add_plugin() Loading serial plugin
bluetoothd[2175]: src/plugin.c:add_plugin() Loading network plugin
bluetoothd[2175]: src/plugin.c:add_plugin() Loading service plugin
bluetoothd[2175]: src/plugin.c:add_plugin() Loading hciops plugin
bluetoothd[2175]: src/plugin.c:add_plugin() Loading mgmtops plugin
bluetoothd[2175]: src/plugin.c:add_plugin() Loading formfactor plugin
bluetoothd[2175]: src/plugin.c:add_plugin() Loading storage plugin
bluetoothd[2175]: src/plugin.c:add_plugin() Loading adaptername plugin
bluetoothd[2175]: src/plugin.c:add_plugin() Loading wiimote plugin
bluetoothd[2175]: src/plugin.c:plugin_init() Loading plugins
/usr/lib/bluetooth/plugins
bluetoothd[2175]: plugins/service.c:register_interface() path
/org/bluez/2175/any
bluetoothd[2175]: plugins/service.c:register_interface() Registered
interface org.bluez.Service on path /org/bluez/2175/any
bluetoothd[2175]: network/manager.c:read_config()
/etc/bluetooth/network.conf: Key file does not have key
'DisableSecurity'
bluetoothd[2175]: network/manager.c:read_config() Config options: Security=true
bluetoothd[2175]: input/manager.c:input_manager_init() input.conf: Key
file does not have key 'IdleTimeout'
bluetoothd[2175]: audio/manager.c:audio_manager_init() audio.conf: Key
file does not have key 'AutoConnect'
bluetoothd[2175]: plugins/hciops.c:hciops_init()
bluetoothd[2175]: plugins/hciops.c:hciops_setup()
bluetoothd[2175]: src/main.c:main() Entering main loop
bluetoothd[2175]: src/rfkill.c:rfkill_event() RFKILL event idx 0 type
2 op 0 soft 0 hard 0
bluetoothd[2175]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type
2 op 0 soft 0 hard 0
bluetoothd[2175]: src/rfkill.c:rfkill_event() RFKILL event idx 2 type
1 op 0 soft 0 hard 0
bluetoothd[2175]: plugins/hciops.c:init_known_adapters()
bluetoothd[2175]: plugins/hciops.c:init_device() hci0
bluetoothd[2175]: Listening for HCI events on hci0
bluetoothd[2175]: plugins/hciops.c:init_device() child 2176 forked
bluetoothd[2175]: plugins/hciops.c:read_local_features_complete() Got
features for hci0
bluetoothd[2175]: plugins/hciops.c:read_local_version_complete() Got
version for hci0
bluetoothd[2175]: plugins/hciops.c:read_bd_addr_complete() hci0 status 0
bluetoothd[2175]: plugins/hciops.c:read_bd_addr_complete() Got bdaddr for hci0
bluetoothd[2175]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[2175]: plugins/hciops.c:read_local_name_complete() Got name for hci0
bluetoothd[2175]: plugins/hciops.c:read_tx_power_complete() hci0 status 0
bluetoothd[2175]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2175]: plugins/hciops.c:read_local_ext_features_complete()
hci0 status 0
bluetoothd[2175]: HCI dev 0 up
bluetoothd[2175]: plugins/hciops.c:device_devup_setup() hci0
bluetoothd[2175]: src/adapter.c:btd_adapter_ref() 0x7f5c5619fd90: ref=1
bluetoothd[2175]: plugins/hciops.c:hciops_read_bdaddr() hci0
bluetoothd[2175]: src/sdpd-database.c:sdp_init_services_list()
bluetoothd[2175]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2175]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[2175]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2175]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[2175]: plugins/service.c:register_interface() path
/org/bluez/2175/hci0
bluetoothd[2175]: plugins/service.c:register_interface() Registered
interface org.bluez.Service on path /org/bluez/2175/hci0
bluetoothd[2175]: network/manager.c:network_server_probe() path
/org/bluez/2175/hci0
bluetoothd[2175]: src/adapter.c:btd_adapter_ref() 0x7f5c5619fd90: ref=2
bluetoothd[2175]: network/server.c:server_register() Registered
interface org.bluez.NetworkServer on path /org/bluez/2175/hci0
bluetoothd[2175]: serial/manager.c:proxy_probe() path /org/bluez/2175/hci0
bluetoothd[2175]: src/adapter.c:btd_adapter_ref() 0x7f5c5619fd90: ref=3
bluetoothd[2175]: serial/proxy.c:proxy_register() Registered interface
org.bluez.SerialProxyManager on path /org/bluez/2175/hci0
bluetoothd[2175]: src/adapter.c:btd_adapter_ref() 0x7f5c5619fd90: ref=4
bluetoothd[2175]: audio/manager.c:media_server_probe() path /org/bluez/2175/hci0
bluetoothd[2175]: src/adapter.c:btd_adapter_ref() 0x7f5c5619fd90: ref=5
bluetoothd[2175]: audio/manager.c:audio_adapter_ref() 0x7f5c561a0610: ref=1
bluetoothd[2175]: audio/manager.c:headset_server_probe() path
/org/bluez/2175/hci0
bluetoothd[2175]: audio/manager.c:audio_adapter_ref() 0x7f5c561a0610: ref=2
bluetoothd[2175]: audio/manager.c:headset_server_init() audio.conf:
Key file does not have key 'Master'
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10000
bluetoothd[2175]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2175]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[2175]: audio/headset.c:headset_config_init() audio.conf:
Key file does not have key 'SCORouting'
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10001
bluetoothd[2175]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2175]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[2175]: audio/manager.c:a2dp_server_probe() path /org/bluez/2175/hci0
bluetoothd[2175]: audio/manager.c:audio_adapter_ref() 0x7f5c561a0610: ref=3
bluetoothd[2175]: audio/a2dp.c:a2dp_register() audio.conf: Key file
does not have key 'Enable'
bluetoothd[2175]: audio/a2dp.c:a2dp_register() audio.conf: Key file
does not have key 'Disable'
bluetoothd[2175]: audio/avdtp.c:avdtp_init() audio.conf: Key file does
not have key 'Master'
bluetoothd[2175]: audio/manager.c:avrcp_server_probe() path /org/bluez/2175/hci0
bluetoothd[2175]: audio/manager.c:audio_adapter_ref() 0x7f5c561a0610: ref=4
bluetoothd[2175]: audio/avrcp.c:avrcp_register() audio.conf: Key file
does not have key 'Master'
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10002
bluetoothd[2175]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2175]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10003
bluetoothd[2175]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2175]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2175]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[2175]: plugins/adaptername.c:adaptername_probe() Setting
name 'chakra-pc-0' for device 'hci0'
bluetoothd[2175]: plugins/hciops.c:hciops_set_name() hci0, name chakra-pc-0
bluetoothd[2175]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2175]: plugins/formfactor.c:formfactor_probe() Setting
0x00010c for major/minor device class
bluetoothd[2175]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 12
bluetoothd[2175]: plugins/hciops.c:hciops_unblock_device() hci0 dba
00:00:00:00:00:00
bluetoothd[2175]: plugins/hciops.c:hciops_load_keys() hci0 keys 0 debug_keys 0
bluetoothd[2175]: Unable to load keys to adapter_ops: Function not
implemented (38)
bluetoothd[2175]: plugins/hciops.c:hciops_get_conn_list() hci0
bluetoothd[2175]: src/manager.c:btd_manager_register_adapter() Adapter
/org/bluez/2175/hci0 registered
bluetoothd[2175]: src/adapter.c:btd_adapter_ref() 0x7f5c5619fd90: ref=6
bluetoothd[2175]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 0
bluetoothd[2175]: audio/manager.c:state_changed() /org/bluez/2175/hci0
powered on
bluetoothd[2175]: audio/telephony.c:telephony_init()
bluetoothd[2175]: audio/headset.c:telephony_ready_ind() Telephony
plugin initialized
bluetoothd[2175]: audio/headset.c:print_ag_features() HFP AG features:
"Ability to reject a call" "Enhanced call status" "Extended Error
Result Codes"
bluetoothd[2175]: plugins/hciops.c:hciops_disable_cod_cache() hci0
cache_enable 1
bluetoothd[2175]: plugins/hciops.c:hciops_disable_cod_cache() hci0
current_cod 0x000000 wanted_cod 0x400100
bluetoothd[2175]: plugins/hciops.c:write_class() hci0 class 0x400100
bluetoothd[2175]: Adapter /org/bluez/2175/hci0 has been enabled
bluetoothd[2175]: plugins/hciops.c:hciops_set_discoverable() hci0 discoverable 1
bluetoothd[2175]: plugins/hciops.c:hciops_set_pairable() hci0 pairable 1
bluetoothd[2175]: src/adapter.c:btd_adapter_unref() 0x7f5c5619fd90: ref=5
bluetoothd[2175]: plugins/hciops.c:child_exit() child 2176 exited
bluetoothd[2175]: plugins/hciops.c:read_local_ext_features_complete()
hci0 status 0
bluetoothd[2175]: src/adapter.c:register_agent() Agent registered for
hci0 at :1.11:/blueDevil_agent
bluetoothd[2175]: plugins/hciops.c:read_tx_power_complete() hci0 status 0
bluetoothd[2175]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2175]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2175]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[2175]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2175]: plugins/hciops.c:read_simple_pairing_mode_complete()
hci0 status 0
bluetoothd[2175]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2175]: plugins/hciops.c:read_scan_complete() hci0 status 0
bluetoothd[2175]: plugins/hciops.c:hciops_set_limited_discoverable()
hci0 limited 0
bluetoothd[2175]: src/adapter.c:adapter_mode_changed() old 0x00 new 0x03
bluetoothd[2175]: src/adapter.c:set_mode_complete()
^Cbluetoothd[2175]: Terminating
bluetoothd[2175]: src/adapter.c:adapter_remove() Removing adapter
/org/bluez/2175/hci0
bluetoothd[2175]: audio/manager.c:avrcp_server_remove() path
/org/bluez/2175/hci0
bluetoothd[2175]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10003
bluetoothd[2175]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10002
bluetoothd[2175]: audio/manager.c:audio_adapter_unref() 0x7f5c561a0610: ref=3
bluetoothd[2175]: audio/manager.c:a2dp_server_remove() path /org/bluez/2175/hci0
bluetoothd[2175]: audio/manager.c:audio_adapter_unref() 0x7f5c561a0610: ref=2
bluetoothd[2175]: audio/manager.c:headset_server_remove() path
/org/bluez/2175/hci0
bluetoothd[2175]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10000
bluetoothd[2175]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10001
bluetoothd[2175]: audio/manager.c:audio_adapter_unref() 0x7f5c561a0610: ref=1
bluetoothd[2175]: audio/manager.c:media_server_remove() path
/org/bluez/2175/hci0
bluetoothd[2175]: audio/manager.c:audio_adapter_unref() 0x7f5c561a0610: ref=0
bluetoothd[2175]: src/adapter.c:btd_adapter_unref() 0x7f5c5619fd90: ref=4
bluetoothd[2175]: src/adapter.c:btd_adapter_unref() 0x7f5c5619fd90: ref=3
bluetoothd[2175]: serial/manager.c:proxy_remove() path /org/bluez/2175/hci0
bluetoothd[2175]: src/adapter.c:btd_adapter_unref() 0x7f5c5619fd90: ref=2
bluetoothd[2175]: network/manager.c:network_server_remove() path
/org/bluez/2175/hci0
bluetoothd[2175]: network/server.c:path_unregister() Unregistered
interface org.bluez.NetworkServer on path /org/bluez/2175/hci0
bluetoothd[2175]: src/adapter.c:btd_adapter_unref() 0x7f5c5619fd90: ref=1
bluetoothd[2175]: plugins/service.c:unregister_interface() path
/org/bluez/2175/hci0
bluetoothd[2175]: plugins/hciops.c:hciops_power_off() hci0
bluetoothd[2175]: src/adapter.c:btd_adapter_unref() 0x7f5c5619fd90: ref=0
bluetoothd[2175]: src/agent.c:agent_release() Releasing agent :1.11,
/blueDevil_agent
bluetoothd[2175]: src/adapter.c:adapter_free() 0x7f5c5619fd90
bluetoothd[2175]: src/plugin.c:plugin_cleanup() Cleanup plugins
bluetoothd[2175]: plugins/service.c:unregister_interface() path
/org/bluez/2175/any
bluetoothd[2175]: plugins/hciops.c:hciops_exit()
bluetoothd[2175]: plugins/hciops.c:hciops_cleanup()
bluetoothd[2175]: Stopping hci0 event socket
bluetoothd[2175]: Stopping SDP server
bluetoothd[2175]: Exit

Here's where the fun comes in....Kubuntu detects the device class
correctly and loads all the services I ever need, including Obex.
Here's the output of 'hciconfig -a' on a Kubuntu LiveCD:

hci0:    Type: BR/EDR  Bus: USB
    BD Address: 00:26:5E:BA:00:18  ACL MTU: 1021:8  SCO MTU: 64:1
    UP RUNNING PSCAN
    RX bytes:1145 acl:0 sco:0 events:41 errors:0
    TX bytes:905 acl:0 sco:0 commands:41 errors:0
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy: RSWITCH HOLD SNIFF PARK
    Link mode: SLAVE ACCEPT
    Name: 'kubuntu-0'
    Class: 0x7e0100
    Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio, Telephony
    Device Class: Computer, Uncategorized
    HCI Version: 2.1 (0x4)  Revision: 0x518f
    LMP Version: 2.1 (0x4)  Subversion: 0x424c
    Manufacturer: Broadcom Corporation (15)

I'll be happy to provide any more info you may need to track down this
problem.  And again, sorry for this being my first ever mailing list
post.
