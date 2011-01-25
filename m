Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinkEr1FcmZAyvS68=nU-SR8QpfYi5z=Pmqe6V-H@mail.gmail.com>
References: <AANLkTi=CufNvvAr0w2JfsG8b3ddgAsHh31pRANoW+z1r@mail.gmail.com>
	<20110125030703.GA2833@joana>
	<AANLkTinkEr1FcmZAyvS68=nU-SR8QpfYi5z=Pmqe6V-H@mail.gmail.com>
Date: Mon, 24 Jan 2011 21:38:12 -0600
Message-ID: <AANLkTinwD7W66qfpxQWJ62UPwSJjF+msYNwac90SEEu=@mail.gmail.com>
Subject: Re: Refusing SCO from non-connected headset
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 24, 2011 at 9:07 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Mike,
>
> * Mike <puffy.taco@gmail.com> [2011-01-24 20:35:51 -0600]:
>
>> I get the following error when I try to dial a phone number from my
>> cell phone and am connected using HFP:
>>
>> bluetoothd[14651]: audio/main.c:sco_server_cb() Refusing SCO from
>> non-connected headset
>
> Please post full logs of bluetoothd -nd

Log is pasted below.  One thing to note, if I comment out the section
of audio/main.c that is the "if (device->headset) {" block (around
line 102), then the connection goes through as a gateway.  I can then
see SCO packets scroll by in hcidump, though pulseaudio does not seem
to notice so I have no way of playing that audio.  The log though is
of unaltered source.

bluetoothd[15602]: Bluetooth deamon 4.86
bluetoothd[15602]: src/main.c:parse_config() parsing main.conf
bluetoothd[15602]: src/main.c:parse_config() discovto=0
bluetoothd[15602]: src/main.c:parse_config() pairto=0
bluetoothd[15602]: src/main.c:parse_config() pageto=8192
bluetoothd[15602]: src/main.c:parse_config() name=%h-%d
bluetoothd[15602]: src/main.c:parse_config() class=0x000100
bluetoothd[15602]: src/main.c:parse_config() discov_interval=0
bluetoothd[15602]: src/main.c:parse_config() Key file does not have
key 'DeviceID'
bluetoothd[15602]: Starting SDP server
bluetoothd[15602]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[15602]: src/plugin.c:add_plugin() Loading audio plugin
bluetoothd[15602]: src/plugin.c:add_plugin() Loading input plugin
bluetoothd[15602]: src/plugin.c:add_plugin() Loading serial plugin
bluetoothd[15602]: src/plugin.c:add_plugin() Loading network plugin
bluetoothd[15602]: src/plugin.c:add_plugin() Loading service plugin
bluetoothd[15602]: src/plugin.c:add_plugin() Loading hciops plugin
bluetoothd[15602]: src/plugin.c:add_plugin() Loading mgmtops plugin
bluetoothd[15602]: src/plugin.c:add_plugin() Loading formfactor plugin
bluetoothd[15602]: src/plugin.c:add_plugin() Loading storage plugin
bluetoothd[15602]: src/plugin.c:plugin_init() Loading plugins
/usr/local/lib/bluetooth/plugins
bluetoothd[15602]: plugins/service.c:register_interface() path
/org/bluez/15602/any
bluetoothd[15602]: plugins/service.c:register_interface() Registered
interface org.bluez.Service on path /org/bluez/15602/any
bluetoothd[15602]: network/manager.c:read_config()
/etc/bluetooth/network.conf: Key file does not have key
'DisableSecurity'
bluetoothd[15602]: network/manager.c:read_config() Config options: Security=true
bluetoothd[15602]: input/manager.c:input_manager_init() input.conf:
Key file does not have key 'IdleTimeout'
bluetoothd[15602]: audio/manager.c:audio_manager_init() audio.conf:
Key file does not have key 'AutoConnect'
bluetoothd[15602]: audio/unix.c:unix_init() Unix socket created: 8
bluetoothd[15602]: plugins/hciops.c:hciops_init()
bluetoothd[15602]: plugins/hciops.c:hciops_setup()
bluetoothd[15602]: src/main.c:main() Entering main loop
bluetoothd[15602]: src/rfkill.c:rfkill_event() RFKILL event idx 2 type
2 op 0 soft 0 hard 0
bluetoothd[15602]: plugins/hciops.c:init_known_adapters()
bluetoothd[15602]: HCI dev 0 registered
bluetoothd[15602]: plugins/hciops.c:device_devreg_setup() hci0
bluetoothd[15602]: plugins/hciops.c:init_device() hci0
bluetoothd[15602]: Listening for HCI events on hci0
bluetoothd[15602]: plugins/hciops.c:init_device() child 15603 forked
bluetoothd[15602]: HCI dev 0 up
bluetoothd[15602]: plugins/hciops.c:device_devup_setup() hci0
bluetoothd[15602]: plugins/hciops.c:child_exit() child 15603 exited
bluetoothd[15602]: plugins/hciops.c:read_local_features_complete() Got
features for hci0
bluetoothd[15602]: plugins/hciops.c:read_local_version_complete() Got
version for hci0
bluetoothd[15602]: plugins/hciops.c:read_bd_addr_complete() hci0 status 0
bluetoothd[15602]: plugins/hciops.c:read_bd_addr_complete() Got bdaddr for hci0
bluetoothd[15602]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[15602]: plugins/hciops.c:read_local_name_complete() Got name for hci0
bluetoothd[15602]: src/adapter.c:btd_adapter_ref() 0x21ef94a0: ref=1
bluetoothd[15602]: plugins/hciops.c:hciops_read_bdaddr() hci0
bluetoothd[15602]: plugins/hciops.c:hciops_read_local_version() hci0
bluetoothd[15602]: plugins/hciops.c:hciops_read_local_features() hci0
bluetoothd[15602]: src/sdpd-database.c:sdp_init_services_list()
bluetoothd[15602]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[15602]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[15602]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[15602]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[15602]: plugins/service.c:register_interface() path
/org/bluez/15602/hci0
bluetoothd[15602]: plugins/service.c:register_interface() Registered
interface org.bluez.Service on path /org/bluez/15602/hci0
bluetoothd[15602]: network/manager.c:network_server_probe() path
/org/bluez/15602/hci0
bluetoothd[15602]: src/adapter.c:btd_adapter_ref() 0x21ef94a0: ref=2
bluetoothd[15602]: network/server.c:server_register() Registered
interface org.bluez.NetworkServer on path /org/bluez/15602/hci0
bluetoothd[15602]: serial/manager.c:proxy_probe() path /org/bluez/15602/hci0
bluetoothd[15602]: src/adapter.c:btd_adapter_ref() 0x21ef94a0: ref=3
bluetoothd[15602]: serial/proxy.c:proxy_register() Registered
interface org.bluez.SerialProxyManager on path /org/bluez/15602/hci0
bluetoothd[15602]: src/adapter.c:btd_adapter_ref() 0x21ef94a0: ref=4
bluetoothd[15602]: audio/manager.c:headset_server_probe() path
/org/bluez/15602/hci0
bluetoothd[15602]: src/adapter.c:btd_adapter_ref() 0x21ef94a0: ref=5
bluetoothd[15602]: audio/manager.c:audio_adapter_ref() 0x21ef9820: ref=1
bluetoothd[15602]: audio/manager.c:headset_server_init() audio.conf:
Key file does not have key 'Master'
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10000
bluetoothd[15602]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[15602]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[15602]: audio/headset.c:headset_config_init() audio.conf:
Key file does not have key 'SCORouting'
bluetoothd[15602]: audio/headset.c:headset_config_init() audio.conf:
Key file does not have key 'FastConnectable'
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10001
bluetoothd[15602]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[15602]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[15602]: audio/manager.c:state_changed()
/org/bluez/15602/hci0 powered on
bluetoothd[15602]: audio/telephony.c:telephony_init()
bluetoothd[15602]: audio/headset.c:telephony_ready_ind() Telephony
plugin initialized
bluetoothd[15602]: audio/headset.c:print_ag_features() HFP AG
features: "Ability to reject a call" "Enhanced call status" "Extended
Error Result Codes"
bluetoothd[15602]: audio/manager.c:audio_adapter_ref() 0x21ef9820: ref=2
bluetoothd[15602]: audio/manager.c:gateway_server_init() audio.conf:
Key file does not have key 'Master'
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10002
bluetoothd[15602]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[15602]: plugins/hciops.c:update_service_classes() hci0 value 96
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[15602]: audio/manager.c:a2dp_server_probe() path
/org/bluez/15602/hci0
bluetoothd[15602]: audio/manager.c:audio_adapter_ref() 0x21ef9820: ref=3
bluetoothd[15602]: audio/a2dp.c:a2dp_register() audio.conf: Key file
does not have key 'Disable'
bluetoothd[15602]: audio/a2dp.c:a2dp_register() audio.conf: Key file
does not have group 'A2DP'
bluetoothd[15602]: audio/a2dp.c:a2dp_register() audio.conf: Key file
does not have group 'A2DP'
bluetoothd[15602]: audio/a2dp.c:a2dp_register() audio.conf: Key file
does not have group 'A2DP'
bluetoothd[15602]: audio/a2dp.c:a2dp_register() audio.conf: Key file
does not have group 'A2DP'
bluetoothd[15602]: audio/avdtp.c:avdtp_init() audio.conf: Key file
does not have key 'Master'
bluetoothd[15602]: audio/avdtp.c:avdtp_register_sep() SEP 0x21ef6d30
registered: type:0 codec:0 seid:1
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10003
bluetoothd[15602]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[15602]: plugins/hciops.c:update_service_classes() hci0 value 104
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[15602]: audio/manager.c:avrcp_server_probe() path
/org/bluez/15602/hci0
bluetoothd[15602]: audio/manager.c:audio_adapter_ref() 0x21ef9820: ref=4
bluetoothd[15602]: audio/control.c:avrcp_register() audio.conf: Key
file does not have key 'Master'
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10004
bluetoothd[15602]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[15602]: plugins/hciops.c:update_service_classes() hci0 value 104
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Adding
record with handle 0x10005
bluetoothd[15602]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[15602]: plugins/hciops.c:update_service_classes() hci0 value 104
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[15602]: src/sdpd-service.c:add_record_to_server() Record
pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[15602]: plugins/formfactor.c:formfactor_probe() Setting
0x000100 for major/minor device class
bluetoothd[15602]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 0
bluetoothd[15602]: plugins/hciops.c:hciops_unblock_device() hci0 dba
00:00:00:00:00:00
bluetoothd[15602]: Clearing blocked list failed: Invalid argument (22)
bluetoothd[15602]: plugins/hciops.c:hciops_load_keys() hci0 keys 0 debug_keys 0
bluetoothd[15602]: plugins/hciops.c:hciops_get_conn_list() hci0
bluetoothd[15602]: src/manager.c:btd_manager_register_adapter()
Adapter /org/bluez/15602/hci0 registered
bluetoothd[15602]: src/adapter.c:btd_adapter_ref() 0x21ef94a0: ref=6
bluetoothd[15602]: plugins/hciops.c:hciops_set_name() hci0, name rome-0
bluetoothd[15602]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[15602]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 4
bluetoothd[15602]: audio/manager.c:state_changed()
/org/bluez/15602/hci0 powered on
bluetoothd[15602]: plugins/hciops.c:hciops_disable_cod_cache() hci0
cache_enable 1
bluetoothd[15602]: plugins/hciops.c:hciops_disable_cod_cache() hci0
current_cod 0x000000 wanted_cod 0x680104
bluetoothd[15602]: plugins/hciops.c:write_class() hci0 class 0x680104
bluetoothd[15602]: Adapter /org/bluez/15602/hci0 has been enabled
bluetoothd[15602]: plugins/hciops.c:hciops_set_discoverable() hci0
discoverable 1
bluetoothd[15602]: plugins/hciops.c:hciops_set_pairable() hci0 pairable 1
bluetoothd[15602]: src/adapter.c:btd_adapter_unref() 0x21ef94a0: ref=5
bluetoothd[15602]: src/adapter.c:register_agent() Agent registered for
hci0 at :1.32:/org/bluez/agent/hci0
bluetoothd[15602]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[15602]: plugins/hciops.c:hciops_read_scan_enable() hci0
bluetoothd[15602]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[15602]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[15602]: plugins/hciops.c:read_scan_complete() hci0 status 0
bluetoothd[15602]: src/adapter.c:adapter_mode_changed() old 0x00 new 0x03
bluetoothd[15602]: src/adapter.c:set_mode_complete()
bluetoothd[15602]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[15602]: src/adapter.c:adapter_create_device() 00:17:E3:3B:4F:DD
bluetoothd[15602]: src/device.c:device_create() Creating device
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: src/device.c:btd_device_ref() 0x21efc148: ref=1
bluetoothd[15602]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[15602]: plugins/hciops.c:link_key_request() hci0 dba
00:17:E3:3B:4F:DD
bluetoothd[15602]: plugins/hciops.c:link_key_request() kernel auth
requirements = 0x04
bluetoothd[15602]: plugins/hciops.c:link_key_request() Matching key not found
bluetoothd[15602]: plugins/hciops.c:pin_code_request() hci0 PIN
request for 00:17:E3:3B:4F:DD
bluetoothd[15602]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[15602]: src/device.c:device_request_authentication()
Requesting agent authentication for 00:17:E3:3B:4F:DD
bluetoothd[15602]: plugins/hciops.c:hciops_pincode_reply() hci0 dba
00:17:E3:3B:4F:DD
bluetoothd[15602]: plugins/hciops.c:link_key_notify() hci0 dba
00:17:E3:3B:4F:DD type 0
bluetoothd[15602]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[15602]: plugins/hciops.c:hciops_get_auth_info() hci0 dba
00:17:E3:3B:4F:DD
bluetoothd[15602]: src/event.c:btd_event_link_key_notify() key type
0x00 old key type 0xff new key type 0x00
bluetoothd[15602]: src/event.c:btd_event_link_key_notify() local auth
0x04 and remote auth 0xff
bluetoothd[15602]: src/event.c:btd_event_link_key_notify() storing
link key of type 0x00
bluetoothd[15602]: src/event.c:btd_event_bonding_process_complete() status=00
bluetoothd[15602]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[15602]: src/device.c:device_bonding_complete() setting
timer for reverse service discovery
bluetoothd[15602]: plugins/hciops.c:auth_complete() hci0 status 0
bluetoothd[15602]: src/event.c:btd_event_bonding_process_complete() status=00
bluetoothd[15602]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[15602]: src/event.c:btd_event_bonding_process_complete() no
pending auth request
bluetoothd[15602]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[15602]: src/device.c:btd_device_ref() 0x21efc148: ref=2
bluetoothd[15602]: audio/device.c:audio_device_register() Registered
interface org.bluez.Audio on path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: src/device.c:device_probe_drivers() Probing drivers
for 00:17:E3:3B:4F:DD
bluetoothd[15602]: audio/manager.c:handle_uuid() Found Handsfree record
bluetoothd[15602]: audio/headset.c:headset_init() Registered interface
org.bluez.Headset on path /org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: src/device.c:btd_device_ref() 0x21efc148: ref=3
bluetoothd[15602]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[15602]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[15602]: src/device.c:device_probe_drivers() Probing drivers
for 00:17:E3:3B:4F:DD
bluetoothd[15602]: serial/manager.c:serial_probe() path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD:
00001103-0000-1000-8000-00805f9b34fb
bluetoothd[15602]: serial/port.c:create_serial_device() Registered
interface org.bluez.Serial on path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: serial/manager.c:serial_probe() path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD:
00001112-0000-1000-8000-00805f9b34fb
bluetoothd[15602]: serial/manager.c:serial_probe() path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD:
0000111f-0000-1000-8000-00805f9b34fb
bluetoothd[15602]: serial/manager.c:serial_probe() path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD:
00001105-0000-1000-8000-00805f9b34fb
bluetoothd[15602]: serial/manager.c:serial_probe() path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD:
00001106-0000-1000-8000-00805f9b34fb
bluetoothd[15602]: serial/manager.c:serial_probe() path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD:
0000111b-0000-1000-8000-00805f9b34fb
bluetoothd[15602]: serial/manager.c:serial_probe() path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD:
00000002-0000-1000-8000-0002ee000002
bluetoothd[15602]: input/manager.c:headset_probe() path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: input-headset driver probe failed for device
00:17:E3:3B:4F:DD
bluetoothd[15602]: audio/manager.c:handle_uuid() server not enabled
for 00001112-0000-1000-8000-00805f9b34fb (0x1112)
bluetoothd[15602]: audio/manager.c:handle_uuid() Found Handsfree AG record
bluetoothd[15602]: audio/manager.c:handle_uuid() server not enabled
for 0000110a-0000-1000-8000-00805f9b34fb (0x110a)
bluetoothd[15602]: audio/manager.c:handle_uuid() Found AV Target
bluetoothd[15602]: audio/control.c:control_init() Registered interface
org.bluez.Control on path /org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: src/device.c:btd_device_unref() 0x21efc148: ref=2
bluetoothd[15602]: plugins/hciops.c:link_key_request() hci0 dba
00:17:E3:3B:4F:DD
bluetoothd[15602]: plugins/hciops.c:link_key_request() kernel auth
requirements = 0x04
bluetoothd[15602]: plugins/hciops.c:link_key_request() Matching key found
bluetoothd[15602]: plugins/hciops.c:link_key_request() link key type 0x00
bluetoothd[15602]: plugins/hciops.c:auth_complete() hci0 status 0
bluetoothd[15602]: src/event.c:btd_event_bonding_process_complete() status=00
bluetoothd[15602]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[15602]: src/event.c:btd_event_bonding_process_complete() no
pending auth request
bluetoothd[15602]: src/agent.c:agent_authorize() authorize request was
sent for /org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: audio/manager.c:gateway_auth_cb() Accepted AG
connection from 00:17:E3:3B:4F:DD for
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: audio/gateway.c:newconnection_reply() Agent reply:
file descriptor passed successfully
bluetoothd[15602]: audio/main.c:sco_server_cb() Refusing SCO from
non-connected headset
bluetoothd[15602]: src/event.c:btd_event_disconn_complete() No
matching connection found for handle 42
bluetoothd[15602]: audio/main.c:sco_server_cb() Refusing SCO from
non-connected headset
bluetoothd[15602]: src/event.c:btd_event_disconn_complete() No
matching connection found for handle 46
bluetoothd[15602]: src/adapter.c:adapter_remove() Removing adapter
/org/bluez/15602/hci0
bluetoothd[15602]: src/device.c:device_remove() Removing device
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: audio/unix.c:unix_device_removed()
unix_device_removed(0x21efbdd8)
bluetoothd[15602]: audio/headset.c:path_unregister() Unregistered
interface org.bluez.Headset on path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: audio/gateway.c:path_unregister() Unregistered
interface org.bluez.HandsfreeGateway on path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: audio/control.c:path_unregister() Unregistered
interface org.bluez.Control on path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: src/device.c:btd_device_unref() 0x21efc148: ref=1
bluetoothd[15602]: serial/manager.c:serial_remove() path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: serial/port.c:path_unregister() Unregistered
interface org.bluez.Serial on path
/org/bluez/15602/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[15602]: src/device.c:btd_device_unref() 0x21efc148: ref=0
bluetoothd[15602]: src/device.c:device_free() 0x21efc148
bluetoothd[15602]: plugins/service.c:unregister_interface() path
/org/bluez/15602/hci0
bluetoothd[15602]: network/manager.c:network_server_remove() path
/org/bluez/15602/hci0
bluetoothd[15602]: network/server.c:path_unregister() Unregistered
interface org.bluez.NetworkServer on path /org/bluez/15602/hci0
bluetoothd[15602]: src/adapter.c:btd_adapter_unref() 0x21ef94a0: ref=4
bluetoothd[15602]: serial/manager.c:proxy_remove() path /org/bluez/15602/hci0
bluetoothd[15602]: src/adapter.c:btd_adapter_unref() 0x21ef94a0: ref=3
bluetoothd[15602]: src/adapter.c:btd_adapter_unref() 0x21ef94a0: ref=2
bluetoothd[15602]: audio/manager.c:headset_server_remove() path
/org/bluez/15602/hci0
bluetoothd[15602]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10000
bluetoothd[15602]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10001
bluetoothd[15602]: audio/manager.c:audio_adapter_unref() 0x21ef9820: ref=3
bluetoothd[15602]: audio/manager.c:gateway_server_remove() path
/org/bluez/15602/hci0
bluetoothd[15602]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10002
bluetoothd[15602]: audio/manager.c:audio_adapter_unref() 0x21ef9820: ref=2
bluetoothd[15602]: audio/manager.c:a2dp_server_remove() path
/org/bluez/15602/hci0
bluetoothd[15602]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10003
bluetoothd[15602]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x21ef6d30
unregistered: type:0 codec:0 seid:1
bluetoothd[15602]: audio/manager.c:audio_adapter_unref() 0x21ef9820: ref=1
bluetoothd[15602]: audio/manager.c:avrcp_server_remove() path
/org/bluez/15602/hci0
bluetoothd[15602]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10005
bluetoothd[15602]: src/sdpd-service.c:remove_record_from_server()
Removing record with handle 0x10004
bluetoothd[15602]: audio/manager.c:audio_adapter_unref() 0x21ef9820: ref=0
bluetoothd[15602]: src/adapter.c:btd_adapter_unref() 0x21ef94a0: ref=1
bluetoothd[15602]: plugins/hciops.c:hciops_power_off() hci0
bluetoothd[15602]: src/adapter.c:btd_adapter_unref() 0x21ef94a0: ref=0
bluetoothd[15602]: src/agent.c:agent_release() Releasing agent :1.32,
/org/bluez/agent/hci0
bluetoothd[15602]: src/adapter.c:adapter_free() 0x21ef94a0
bluetoothd[15602]: src/plugin.c:plugin_cleanup() Cleanup plugins
bluetoothd[15602]: plugins/service.c:unregister_interface() path
/org/bluez/15602/any
bluetoothd[15602]: plugins/hciops.c:hciops_exit()
bluetoothd[15602]: plugins/hciops.c:hciops_cleanup()
bluetoothd[15602]: Stopping hci0 event socket
bluetoothd[15602]: Stopping SDP server
bluetoothd[15602]: Exit
