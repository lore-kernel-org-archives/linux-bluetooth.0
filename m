Return-Path: <cyrus@holtmann.org>
Message-ID: <550A7C86.8050403@ubnt.com>
Date: Thu, 19 Mar 2015 09:36:38 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 5/5] shared/gatt-client: Fix service discovery
References: <1426712691-5048-1-git-send-email-luiz.dentz@gmail.com> <1426712691-5048-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426712691-5048-6-git-send-email-luiz.dentz@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030305050904060604020101"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030305050904060604020101
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hi Luiz

On 2015.03.18. 23:04, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The code should proceed to discover all descriptors before moving to
> next service otherwise it may attempt to insert characteristics in the
> wrong service which would probably fail.
> ---
>  src/shared/gatt-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 3e28c6e..729bd87 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -690,13 +690,13 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
>  			goto failed;
>  	}
>  
> +next:
>  	if (!discover_descs(op, &discovering))
>  		goto failed;
>  
>  	if (discovering)
>  		return;
>  
> -next:
>  	/* Done with the current service */
>  	gatt_db_service_set_active(op->cur_svc, true);
>  
> 

I tested this new patch-set and and results are the following:
1. Three characteristics (GAP, GATT and custom) do appear on D-BUs. This was not the case before.
2. CCC descriptor still does not appear on D-Bus. If I change handles on the peripheral back to sequential, then CCC appears on D-Bus also.
3. Reading of any characteristic times out with 'g-io-error-quark: Timeout was reached (24)'. Logs attached. Based on HCI dumps the ATT reading is OK, but for some reason result is not propagated to the D-Bus level, so D-Dbus method times out. With sequential handles reading works fine.

--------------030305050904060604020101
Content-Type: text/x-log;
 name="bluez_fix2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bluez_fix2.log"

bluetoothd[700]: Bluetooth daemon 5.29
bluetoothd[700]: src/main.c:parse_config() parsing main.conf
bluetoothd[700]: src/main.c:parse_config() Key file does not have key 'DiscoverableTimeout'
bluetoothd[700]: src/main.c:parse_config() Key file does not have key 'PairableTimeout'
bluetoothd[700]: src/main.c:parse_config() Key file does not have key 'AutoConnectTimeout'
bluetoothd[700]: src/main.c:parse_config() Key file does not have key 'Name'
bluetoothd[700]: src/main.c:parse_config() Key file does not have key 'Class'
bluetoothd[700]: src/main.c:parse_config() Key file does not have key 'DeviceID'
bluetoothd[700]: src/main.c:parse_config() Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[700]: src/main.c:parse_config() ControllerMode=le
bluetoothd[700]: src/adapter.c:adapter_init() sending read version command
bluetoothd[700]: Starting SDP server
bluetoothd[700]: src/sdpd-service.c:register_device_id() Adding device id record for 0002:1d6b:0246:051d
bluetoothd[700]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[700]: src/plugin.c:add_plugin() Loading hostname plugin
bluetoothd[700]: Ignoring (cli) wiimote
bluetoothd[700]: Ignoring (cli) autopair
bluetoothd[700]: Ignoring (cli) policy
bluetoothd[700]: Ignoring (cli) gatt_example
bluetoothd[700]: Ignoring (cli) neard
bluetoothd[700]: Ignoring (cli) sap
bluetoothd[700]: Ignoring (cli) a2dp
bluetoothd[700]: Ignoring (cli) avrcp
bluetoothd[700]: Ignoring (cli) network
bluetoothd[700]: Ignoring (cli) input
bluetoothd[700]: Ignoring (cli) hog
bluetoothd[700]: Ignoring (cli) health
bluetoothd[700]: Ignoring (cli) gap
bluetoothd[700]: Ignoring (cli) scanparam
bluetoothd[700]: Ignoring (cli) deviceinfo
bluetoothd[700]: Ignoring (cli) alert
bluetoothd[700]: Ignoring (cli) time
bluetoothd[700]: Ignoring (cli) proximity
bluetoothd[700]: Ignoring (cli) thermometer
bluetoothd[700]: Ignoring (cli) heartrate
bluetoothd[700]: Ignoring (cli) cyclingspeed
bluetoothd[700]: src/plugin.c:plugin_init() Loading plugins /home/andrey/git/bluez/plugins/.libs
bluetoothd[700]: Ignoring (cli) external_dummy
bluetoothd[700]: src/main.c:main() Entering main loop
bluetoothd[700]: src/rfkill.c:rfkill_event() RFKILL event idx 4 type 2 op 0 soft 0 hard 0
bluetoothd[700]: Bluetooth management interface 1.8 initialized
bluetoothd[700]: src/adapter.c:read_version_complete() sending read supported commands command
bluetoothd[700]: src/adapter.c:read_version_complete() sending read index list command
bluetoothd[700]: src/adapter.c:read_commands_complete() Number of commands: 56
bluetoothd[700]: src/adapter.c:read_commands_complete() Number of events: 29
bluetoothd[700]: src/adapter.c:read_commands_complete() enabling kernel-side connection control
bluetoothd[700]: src/adapter.c:read_index_list_complete() Number of controllers: 1
bluetoothd[700]: src/adapter.c:read_index_list_complete() Found index 0
bluetoothd[700]: src/adapter.c:index_added() index 0
bluetoothd[700]: src/adapter.c:btd_adapter_new() System name: BlueZ 5.29
bluetoothd[700]: src/adapter.c:btd_adapter_new() Major class: 0
bluetoothd[700]: src/adapter.c:btd_adapter_new() Minor class: 0
bluetoothd[700]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d051D
bluetoothd[700]: src/adapter.c:btd_adapter_new() Discoverable timeout: 180 seconds
bluetoothd[700]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 seconds
bluetoothd[700]: src/adapter.c:index_added() sending read info command for index 0
bluetoothd[700]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[700]: src/adapter.c:clear_uuids() sending clear uuids command for index 0
bluetoothd[700]: src/adapter.c:clear_devices() sending clear devices command for index 0
bluetoothd[700]: src/gatt-database.c:btd_gatt_database_new() GATT Manager registered for adapter: /org/bluez/hci0
bluetoothd[700]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[700]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
bluetoothd[700]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[700]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[700]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[700]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001800-0000-1000-8000-00805f9
bluetoothd[700]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[700]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[700]: src/gatt-database.c:gatt_db_service_added() GATT Service added to local database
bluetoothd[700]: Failed to obtain handles for "Service Changed" characteristic
bluetoothd[700]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[700]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
bluetoothd[700]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[700]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[700]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[700]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001801-0000-1000-8000-00805f9
bluetoothd[700]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[700]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[700]: src/gatt-database.c:gatt_db_service_added() GATT Service added to local database
bluetoothd[700]: plugins/hostname.c:hostname_probe() 
bluetoothd[700]: src/adapter.c:btd_adapter_unblock_address() hci0 00:00:00:00:00:00
bluetoothd[700]: src/adapter.c:get_ltk_info() 20:73:6A:17:69:31
bluetoothd[700]: src/device.c:device_create_from_storage() address 20:73:6A:17:69:31
bluetoothd[700]: src/device.c:device_new() address 20:73:6A:17:69:31
bluetoothd[700]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_20_73_6A_17_69_31
bluetoothd[700]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[700]: src/device.c:device_probe_profiles() Probing profiles for device 20:73:6A:17:69:31
bluetoothd[700]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys 0
bluetoothd[700]: src/adapter.c:load_ltks() hci0 keys 0
bluetoothd[700]: src/adapter.c:load_irks() hci0 irks 0
bluetoothd[700]: src/adapter.c:load_conn_params() hci0 conn params 0
bluetoothd[700]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[700]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[700]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b product 246 version 51d
bluetoothd[700]: src/adapter.c:adapter_register() Adapter /org/bluez/hci0 registered
bluetoothd[700]: src/adapter.c:set_dev_class() sending set device class command for index 0
bluetoothd[700]: src/adapter.c:set_name() sending set local name command for index 0
bluetoothd[700]: src/adapter.c:load_link_keys_complete() link keys loaded for hci0
bluetoothd[700]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[700]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
bluetoothd[700]: src/adapter.c:load_conn_params_complete() Connection Parameters loaded for hci0
bluetoothd[700]: src/adapter.c:local_name_changed_callback() Name: BlueZ 5.29
bluetoothd[700]: src/adapter.c:local_name_changed_callback() Short name: 
bluetoothd[700]: src/adapter.c:local_name_changed_callback() Current alias: BlueZ 5.29
bluetoothd[700]: plugins/hostname.c:property_changed() static hostname: UFHR
bluetoothd[700]: plugins/hostname.c:property_changed() pretty hostname: 
bluetoothd[700]: plugins/hostname.c:update_name() name: UFHR
bluetoothd[700]: src/adapter.c:adapter_set_name() name: UFHR
bluetoothd[700]: src/adapter.c:adapter_set_name() alias: UFHR
bluetoothd[700]: src/adapter.c:set_name() sending set local name command for index 0
bluetoothd[700]: plugins/hostname.c:property_changed() chassis: vm
bluetoothd[700]: src/adapter.c:local_name_changed_callback() Name: UFHR
bluetoothd[700]: src/adapter.c:local_name_changed_callback() Short name: 
bluetoothd[700]: src/adapter.c:local_name_changed_callback() Current alias: UFHR


bluetoothd[700]: src/adapter.c:new_settings_callback() Settings: 0x00000a11
bluetoothd[700]: src/adapter.c:settings_changed() Changed settings: 0x00000001
bluetoothd[700]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
bluetoothd[700]: src/adapter.c:trigger_passive_scanning() 
bluetoothd[700]: src/adapter.c:start_discovery() sender :1.60
bluetoothd[700]: src/adapter.c:trigger_start_discovery() 
bluetoothd[700]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[700]: src/adapter.c:start_discovery_timeout() 
bluetoothd[700]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[700]: src/adapter.c:discovering_callback() hci0 type 6 discovering 1
bluetoothd[700]: src/adapter.c:device_found_callback() hci0 addr 60:03:08:D2:5B:20, rssi -70 flags 0x0000 eir_len 15
bluetoothd[700]: src/device.c:device_create() dst 60:03:08:D2:5B:20
bluetoothd[700]: src/device.c:device_new() address 60:03:08:D2:5B:20
bluetoothd[700]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_60_03_08_D2_5B_20
bluetoothd[700]: src/device.c:device_set_legacy() legacy 0
bluetoothd[700]: src/device.c:device_set_rssi() rssi -70
bluetoothd[700]: src/adapter.c:device_found_callback() hci0 addr 20:73:6A:17:69:31, rssi -67 flags 0x0000 eir_len 35
bluetoothd[700]: src/device.c:device_set_legacy() legacy 0
bluetoothd[700]: src/device.c:device_set_rssi() rssi -67
bluetoothd[700]: src/adapter.c:stop_discovery() sender :1.60
bluetoothd[700]: src/adapter.c:discovery_destroy() owner :1.60
bluetoothd[700]: src/device.c:device_set_rssi() rssi 0
bluetoothd[700]: src/device.c:device_set_rssi() rssi 0
bluetoothd[700]: src/adapter.c:stop_discovery_complete() status 0x00
bluetoothd[700]: src/adapter.c:trigger_passive_scanning() 
bluetoothd[700]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0



bluetoothd[700]: src/device.c:device_connect_le() Connection attempt to: 20:73:6A:17:69:31
bluetoothd[700]: src/adapter.c:connected_callback() hci0 device 20:73:6A:17:69:31 connected eir_len 0
bluetoothd[700]: attrib/gattrib.c:g_attrib_ref() 0x1f60d00: g_attrib_ref=1 
bluetoothd[700]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
bluetoothd[700]: src/device.c:gatt_debug() Primary services found: 3
bluetoothd[700]: src/device.c:gatt_debug() start: 0x0100, end: 0x0121, uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[700]: src/device.c:gatt_debug() start: 0x0200, end: 0x0200, uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[700]: src/device.c:gatt_debug() start: 0x0300, end: 0x0320, uuid: 8832ab08-ba2d-0184-004c-68c08e2190bf
bluetoothd[700]: src/device.c:gatt_debug() Secondary service discovery failed. ATT ECODE: 0x0a
bluetoothd[700]: src/device.c:gatt_debug() Characteristics found: 2
bluetoothd[700]: src/device.c:gatt_debug() start: 0x0110, end: 0x011f, value: 0x0111, props: 0x02, uuid: 00002a00-0000-1
bluetoothd[700]: src/device.c:gatt_debug() start: 0x0120, end: 0x0121, value: 0x0121, props: 0x02, uuid: 00002a01-0000-1
bluetoothd[700]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[700]: src/device.c:gatt_debug() start: 0x0310, end: 0x0320, value: 0x0311, props: 0x3e, uuid: 361e118a-5524-2
bluetoothd[700]: src/device.c:gatt_debug() Descriptors found: 1
bluetoothd[700]: src/device.c:gatt_debug() handle: 0x0320, uuid: 00002902-0000-1000-8000-00805f9b34fb
bluetoothd[700]: src/device.c:gatt_client_ready_cb() status: success, error: 0
bluetoothd[700]: src/device.c:device_svc_resolved() /org/bluez/hci0/dev_20_73_6A_17_69_31 err 0
bluetoothd[700]: src/gatt-client.c:btd_gatt_client_ready() GATT client ready
bluetoothd[700]: src/gatt-client.c:btd_gatt_client_ready() Exporting services
bluetoothd[700]: src/gatt-client.c:create_services() Exporting objects for GATT services: 20:73:6A:17:69:31
bluetoothd[700]: src/gatt-client.c:service_create() Exported GATT service: /org/bluez/hci0/dev_20_73_6A_17_69_31/service0100
bluetoothd[700]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_20_73_6A_17_69_31/service0100/char0110
bluetoothd[700]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_20_73_6A_17_69_31/service0100/char0120
bluetoothd[700]: src/gatt-client.c:service_create() Exported GATT service: /org/bluez/hci0/dev_20_73_6A_17_69_31/service0200
bluetoothd[700]: src/gatt-client.c:service_create() Exported GATT service: /org/bluez/hci0/dev_20_73_6A_17_69_31/service0300
bluetoothd[700]: src/gatt-client.c:characteristic_create() Exported GATT characteristic: /org/bluez/hci0/dev_20_73_6A_17_69_31/service0300/char0310
--------------030305050904060604020101
Content-Type: application/octet-stream;
 name="noncons_handles_fix2.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="noncons_handles_fix2.dump"

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
--------------030305050904060604020101--
