Return-Path: <cyrus@holtmann.org>
Message-ID: <55082D38.4020306@ubnt.com>
Date: Tue, 17 Mar 2015 15:33:44 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	Arman Uguray <armansito@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcin Kraglak <marcin.kraglak@tieto.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: Re: Non-consecutive handle values in GATT
References: <54F752D8.1000605@ubnt.com>	<CAHrH25RVKCL9RQCeFBJAsUsNV1umOR92VWV1JQgkwy-RNh-GAg@mail.gmail.com>	<CAN_7+Yagp-R+H+nhCtmdqWyAJm4jO_VsB5c343A=39zurwqpPw@mail.gmail.com>	<007858C7-D538-407D-8212-D3B0CB880165@ubnt.com>	<CABBYNZLKfh7xPufAMfjG6P--Q-NkOVq4oYUdXEpqc5WsvQpu2g@mail.gmail.com>	<CABBYNZLHtCJCoUp_4miapZJOReh=FP4_sJVFkyh5uE+NHV2x=A@mail.gmail.com>	<5506D8AB.1040903@ubnt.com>	<5506E0A6.1080709@ubnt.com>	<CABBYNZKg1gMsoZyD4mHiZDiGkvFuzAcTPGauFTaLRr0V7ntkbg@mail.gmail.com>	<5506E715.3000709@ubnt.com> <CABBYNZJK7SVUbThK_wfVFa2NvxK5NiFJ4HRA-FK3Pmo9+peYZw@mail.gmail.com>
In-Reply-To: <CABBYNZJK7SVUbThK_wfVFa2NvxK5NiFJ4HRA-FK3Pmo9+peYZw@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070000090306050204030401"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070000090306050204030401
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Luiz,

On 2015.03.17. 15:07, Luiz Augusto von Dentz wrote:
> Hi Andrejs,
> 
> 
>>>>> ACL data: handle 64 flags 0x02 dlen 20
>>>>     ATT: Read By Type resp (0x09)
>>>>       length: 7
>>>>         handle 0x0110, value 0x02 0x11 0x01 0x00 0x2a
>>>>         handle 0x0120, value 0x02 0x21 0x01 0x01 0x2a
>>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>>     ATT: Read By Type req (0x08)
>>>>       start 0x0121, end 0x0121
>>>>       type-uuid 0x2803      <--- as without patch, this seems to be suspicious. Single att read request with wrong UUID.
>>>
>>> Maybe this is off by 1 error except if start 0x0100, end 0x0121 range
>>> actually exclude the last, but it would be still wrong the start
>>> 0x0121, end 0x0121, anyway this seems to be some other problem.
> 
> Actually this is fine, we are discovering the characteristics since
> they may not fit in a single frame we just continue from where we stop
> at 0x0121 until the end of the service range with just happen to be
> 0x0121.
> 
>>>
>>>>
>>>>
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>     handle 64 packets 2
>>>>> ACL data: handle 64 flags 0x02 dlen 9
>>>>     ATT: Error (0x01)
>>>>       Error: Attribute not found (10)
>>>>       Read By Type req (0x08) on handle 0x0121
>>>> < ACL data: handle 64 flags 0x00 dlen 9
>>>>     ATT: Find Information req (0x04)
>>>>       start 0x0112, end 0x011f
>>>>> ACL data: handle 64 flags 0x02 dlen 9
>>>>     ATT: Error (0x01)
>>>>       Error: Attribute not found (10)
>>>>       Find Information req (0x04) on handle 0x0112
>>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>>     ATT: Read By Type req (0x08)
>>>>       start 0x0300, end 0x0320
>>>>       type-uuid 0x2803
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>     handle 64 packets 1
>>>>> ACL data: handle 64 flags 0x02 dlen 27
>>>>     ATT: Read By Type resp (0x09)
>>>>       length: 21
>>>>         handle 0x0310, value 0x3e 0x11 0x03 0x34 0x5b 0xe2 0x12 0x5e 0xb1 0x45 0x03 0xb6 0x29 0x24 0x55 0x8a 0x11 0x1e 0x36
>>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>>     ATT: Read By Type req (0x08)
>>>>       start 0x0311, end 0x0320
>>>>       type-uuid 0x2803
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>     handle 64 packets 2
>>>>> ACL data: handle 64 flags 0x02 dlen 9
>>>>     ATT: Error (0x01)
>>>>       Error: Attribute not found (10)
>>>>       Read By Type req (0x08) on handle 0x0311
>>>
>>> Can you collect the trace in binary format, e.g. btmon -w <file>, I
>>> can perhaps try to create the very same database for unit tests, also
>>> it would be good to have bluetoothd traces.
>> Traces attached.
> 
> Can you please enable bt_gatt_client debug with the following patch:
> 
> diff --git a/src/device.c b/src/device.c
> index aaa9f43..6a23adc 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3989,6 +3989,11 @@ static void
> gatt_client_service_changed(uint16_t start_handle,
>         DBG("start 0x%04x, end: 0x%04x", start_handle, end_handle);
>  }
> 
> +static void gatt_debug(const char *str, void *user_data)
> +{
> +       DBG("%s", str);
> +}
> +
>  static void gatt_client_init(struct btd_device *device)
>  {
>         gatt_client_cleanup(device);
> @@ -4000,6 +4005,8 @@ static void gatt_client_init(struct btd_device *device)
>                 return;
>         }
> 
> +       bt_gatt_client_set_debug(device->client, gatt_debug, NULL, NULL);
> +
>         /* Notify attio so it can react to notifications */
>         g_slist_foreach(device->attios, attio_connected, device->attrib);
> 
> 
See attachments. Fresh dumps from both btmon and daemon. With your patch "shared/gatt-client: Fix handling of services" applied.

--------------070000090306050204030401
Content-Type: application/octet-stream;
 name="noncons_handles.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="noncons_handles.dump"

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
--------------070000090306050204030401
Content-Type: text/x-log;
 name="bluez.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bluez.log"

bluetoothd[12005]: Bluetooth daemon 5.29
bluetoothd[12005]: src/main.c:parse_config() parsing main.conf
bluetoothd[12005]: src/main.c:parse_config() Key file does not have key 'DiscoverableTimeout'
bluetoothd[12005]: src/main.c:parse_config() Key file does not have key 'PairableTimeout'
bluetoothd[12005]: src/main.c:parse_config() Key file does not have key 'AutoConnectTimeout'
bluetoothd[12005]: src/main.c:parse_config() Key file does not have key 'Name'
bluetoothd[12005]: src/main.c:parse_config() Key file does not have key 'Class'
bluetoothd[12005]: src/main.c:parse_config() Key file does not have key 'DeviceID'
bluetoothd[12005]: src/main.c:parse_config() Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[12005]: src/main.c:parse_config() ControllerMode=le
bluetoothd[12005]: src/adapter.c:adapter_init() sending read version command
bluetoothd[12005]: Starting SDP server
bluetoothd[12005]: src/sdpd-service.c:register_device_id() Adding device id record for 0002:1d6b:0246:051d
bluetoothd[12005]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[12005]: src/plugin.c:add_plugin() Loading hostname plugin
bluetoothd[12005]: Ignoring (cli) wiimote
bluetoothd[12005]: Ignoring (cli) autopair
bluetoothd[12005]: Ignoring (cli) policy
bluetoothd[12005]: Ignoring (cli) gatt_example
bluetoothd[12005]: Ignoring (cli) neard
bluetoothd[12005]: Ignoring (cli) sap
bluetoothd[12005]: Ignoring (cli) a2dp
bluetoothd[12005]: Ignoring (cli) avrcp
bluetoothd[12005]: Ignoring (cli) network
bluetoothd[12005]: Ignoring (cli) input
bluetoothd[12005]: Ignoring (cli) hog
bluetoothd[12005]: Ignoring (cli) health
bluetoothd[12005]: Ignoring (cli) gap
bluetoothd[12005]: Ignoring (cli) scanparam
bluetoothd[12005]: Ignoring (cli) deviceinfo
bluetoothd[12005]: Ignoring (cli) alert
bluetoothd[12005]: Ignoring (cli) time
bluetoothd[12005]: Ignoring (cli) proximity
bluetoothd[12005]: Ignoring (cli) thermometer
bluetoothd[12005]: Ignoring (cli) heartrate
bluetoothd[12005]: Ignoring (cli) cyclingspeed
bluetoothd[12005]: src/plugin.c:plugin_init() Loading plugins /home/andrey/git/bluez/plugins/.libs
bluetoothd[12005]: Ignoring (cli) external_dummy
bluetoothd[12005]: src/main.c:main() Entering main loop
bluetoothd[12005]: src/rfkill.c:rfkill_event() RFKILL event idx 2 type 2 op 0 soft 0 hard 0
bluetoothd[12005]: Bluetooth management interface 1.8 initialized
bluetoothd[12005]: src/adapter.c:read_version_complete() sending read supported commands command
bluetoothd[12005]: src/adapter.c:read_version_complete() sending read index list command
bluetoothd[12005]: src/adapter.c:read_commands_complete() Number of commands: 56
bluetoothd[12005]: src/adapter.c:read_commands_complete() Number of events: 29
bluetoothd[12005]: src/adapter.c:read_commands_complete() enabling kernel-side connection control
bluetoothd[12005]: src/adapter.c:read_index_list_complete() Number of controllers: 1
bluetoothd[12005]: src/adapter.c:read_index_list_complete() Found index 0
bluetoothd[12005]: src/adapter.c:index_added() index 0
bluetoothd[12005]: src/adapter.c:btd_adapter_new() System name: BlueZ 5.29
bluetoothd[12005]: src/adapter.c:btd_adapter_new() Major class: 0
bluetoothd[12005]: src/adapter.c:btd_adapter_new() Minor class: 0
bluetoothd[12005]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d051D
bluetoothd[12005]: src/adapter.c:btd_adapter_new() Discoverable timeout: 180 seconds
bluetoothd[12005]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 seconds
bluetoothd[12005]: src/adapter.c:index_added() sending read info command for index 0
bluetoothd[12005]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[12005]: src/adapter.c:clear_uuids() sending clear uuids command for index 0
bluetoothd[12005]: src/adapter.c:clear_devices() sending clear devices command for index 0
bluetoothd[12005]: src/gatt-database.c:btd_gatt_database_new() GATT Manager registered for adapter: /org/bluez/hci0
bluetoothd[12005]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[12005]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
bluetoothd[12005]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[12005]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[12005]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[12005]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001800-0000-1000-8000-00805f9
bluetoothd[12005]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[12005]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[12005]: src/gatt-database.c:gatt_db_service_added() GATT Service added to local database
bluetoothd[12005]: Failed to obtain handles for "Service Changed" characteristic
bluetoothd[12005]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[12005]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
bluetoothd[12005]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[12005]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[12005]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[12005]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001801-0000-1000-8000-00805f9
bluetoothd[12005]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[12005]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[12005]: src/gatt-database.c:gatt_db_service_added() GATT Service added to local database
bluetoothd[12005]: plugins/hostname.c:hostname_probe() 
bluetoothd[12005]: src/adapter.c:btd_adapter_unblock_address() hci0 00:00:00:00:00:00
bluetoothd[12005]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys 0
bluetoothd[12005]: src/adapter.c:load_ltks() hci0 keys 0
bluetoothd[12005]: src/adapter.c:load_irks() hci0 irks 0
bluetoothd[12005]: src/adapter.c:load_conn_params() hci0 conn params 0
bluetoothd[12005]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[12005]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[12005]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b product 246 version 51d
bluetoothd[12005]: src/adapter.c:adapter_register() Adapter /org/bluez/hci0 registered
bluetoothd[12005]: src/adapter.c:set_dev_class() sending set device class command for index 0
bluetoothd[12005]: src/adapter.c:set_name() sending set local name command for index 0
bluetoothd[12005]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[12005]: src/adapter.c:set_discoverable() sending set mode command for index 0
bluetoothd[12005]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[12005]: src/adapter.c:load_link_keys_complete() link keys loaded for hci0
bluetoothd[12005]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[12005]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
bluetoothd[12005]: src/adapter.c:load_conn_params_complete() Connection Parameters loaded for hci0
bluetoothd[12005]: src/adapter.c:local_name_changed_callback() Name: BlueZ 5.29
bluetoothd[12005]: src/adapter.c:local_name_changed_callback() Short name: 
bluetoothd[12005]: src/adapter.c:local_name_changed_callback() Current alias: BlueZ 5.29
bluetoothd[12005]: src/adapter.c:new_settings_callback() Settings: 0x00000a10
bluetoothd[12005]: src/adapter.c:settings_changed() Changed settings: 0x0000000a
bluetoothd[12005]: src/adapter.c:new_settings_callback() Settings: 0x00000a12
bluetoothd[12005]: src/adapter.c:settings_changed() Changed settings: 0x00000002
bluetoothd[12005]: src/adapter.c:new_settings_callback() Settings: 0x00000a1a
bluetoothd[12005]: src/adapter.c:settings_changed() Changed settings: 0x00000008
bluetoothd[12005]: plugins/hostname.c:property_changed() static hostname: UFHR
bluetoothd[12005]: plugins/hostname.c:property_changed() pretty hostname: 
bluetoothd[12005]: plugins/hostname.c:update_name() name: UFHR
bluetoothd[12005]: src/adapter.c:adapter_set_name() name: UFHR
bluetoothd[12005]: src/adapter.c:adapter_set_name() alias: UFHR
bluetoothd[12005]: src/adapter.c:set_name() sending set local name command for index 0
bluetoothd[12005]: plugins/hostname.c:property_changed() chassis: vm
bluetoothd[12005]: src/adapter.c:local_name_changed_callback() Name: UFHR
bluetoothd[12005]: src/adapter.c:local_name_changed_callback() Short name: 
bluetoothd[12005]: src/adapter.c:local_name_changed_callback() Current alias: UFHR
bluetoothd[12005]: src/adapter.c:new_settings_callback() Settings: 0x00000a1b
bluetoothd[12005]: src/adapter.c:settings_changed() Changed settings: 0x00000001
bluetoothd[12005]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
bluetoothd[12005]: src/adapter.c:trigger_passive_scanning() 
bluetoothd[12005]: src/adapter.c:start_discovery() sender :1.6
bluetoothd[12005]: src/adapter.c:trigger_start_discovery() 
bluetoothd[12005]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[12005]: src/adapter.c:start_discovery_timeout() 
bluetoothd[12005]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[12005]: src/adapter.c:discovering_callback() hci0 type 6 discovering 1
bluetoothd[12005]: src/adapter.c:device_found_callback() hci0 addr 20:73:6A:17:69:31, rssi -59 flags 0x0000 eir_len 35
bluetoothd[12005]: src/device.c:device_create() dst 20:73:6A:17:69:31
bluetoothd[12005]: src/device.c:device_new() address 20:73:6A:17:69:31
bluetoothd[12005]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_20_73_6A_17_69_31
bluetoothd[12005]: src/device.c:device_set_legacy() legacy 0
bluetoothd[12005]: src/device.c:device_set_rssi() rssi -59
bluetoothd[12005]: src/adapter.c:device_found_callback() hci0 addr 60:03:08:D2:5B:20, rssi -66 flags 0x0000 eir_len 15
bluetoothd[12005]: src/device.c:device_create() dst 60:03:08:D2:5B:20
bluetoothd[12005]: src/device.c:device_new() address 60:03:08:D2:5B:20
bluetoothd[12005]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_60_03_08_D2_5B_20
bluetoothd[12005]: src/device.c:device_set_legacy() legacy 0
bluetoothd[12005]: src/device.c:device_set_rssi() rssi -66
bluetoothd[12005]: src/adapter.c:stop_discovery() sender :1.6
bluetoothd[12005]: src/adapter.c:discovery_destroy() owner :1.6
bluetoothd[12005]: src/device.c:device_set_rssi() rssi 0
bluetoothd[12005]: src/device.c:device_set_rssi() rssi 0
bluetoothd[12005]: src/adapter.c:stop_discovery_complete() status 0x00
bluetoothd[12005]: src/adapter.c:trigger_passive_scanning() 
bluetoothd[12005]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0
bluetoothd[12005]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[12005]: src/device.c:device_connect_le() Connection attempt to: 20:73:6A:17:69:31
bluetoothd[12005]: src/adapter.c:connected_callback() hci0 device 20:73:6A:17:69:31 connected eir_len 0
bluetoothd[12005]: attrib/gattrib.c:g_attrib_ref() 0x24cbd00: g_attrib_ref=1 
bluetoothd[12005]: src/device.c:gatt_debug() MTU exchange complete, with MTU: 23
bluetoothd[12005]: src/device.c:gatt_debug() Primary services found: 3
bluetoothd[12005]: src/device.c:gatt_debug() start: 0x0100, end: 0x0121, uuid: 00001800-0000-1000-8000-00805f9b34fb
bluetoothd[12005]: src/device.c:gatt_debug() start: 0x0200, end: 0x0200, uuid: 00001801-0000-1000-8000-00805f9b34fb
bluetoothd[12005]: src/device.c:gatt_debug() start: 0x0300, end: 0x0320, uuid: 8832ab08-ba2d-0184-004c-68c08e2190bf
bluetoothd[12005]: src/device.c:gatt_debug() Secondary service discovery failed. ATT ECODE: 0x0a
bluetoothd[12005]: src/device.c:gatt_debug() Characteristics found: 2
bluetoothd[12005]: src/device.c:gatt_debug() start: 0x0110, end: 0x011f, value: 0x0111, props: 0x02, uuid: 00002a00-0000-1
bluetoothd[12005]: src/device.c:gatt_debug() start: 0x0120, end: 0x0121, value: 0x0121, props: 0x02, uuid: 00002a01-0000-1
bluetoothd[12005]: src/device.c:gatt_debug() Characteristics found: 1
bluetoothd[12005]: src/device.c:gatt_debug() start: 0x0310, end: 0x0320, value: 0x0311, props: 0x3e, uuid: 361e118a-5524-2
bluetoothd[12005]: src/device.c:gatt_debug() Failed to initialize gatt-client
bluetoothd[12005]: src/device.c:gatt_client_ready_cb() status: failed, error: 10
bluetoothd[12005]: src/device.c:gatt_service_removed() start: 0x0100, end: 0x0121
--------------070000090306050204030401--
