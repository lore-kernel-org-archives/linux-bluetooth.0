Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAFD1m3FJyojPvf_f-=UTH7P+-_qgvt2iomWP+2oC3YAKxh_Rpg@mail.gmail.com>
References: <CAFD1m3FJyojPvf_f-=UTH7P+-_qgvt2iomWP+2oC3YAKxh_Rpg@mail.gmail.com>
Date: Wed, 13 May 2015 19:41:30 -0700
Message-ID: <CAHrH25Rxdqucm04R_2dTzAFCqcnJ1nnC++7Es-_z+m=goK_18w@mail.gmail.com>
Subject: Re: What does "Not enough free handles to register service" in
 bluetoothd logs mean?
From: Arman Uguray <armansito@chromium.org>
To: John Carter <john.carter@taitradio.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> On Wed, May 13, 2015 at 6:58 PM, John Carter <john.carter@taitradio.com> wrote:
> I'm trying to get the proximity profile working...
>
> "hcitool lescan" works, but I can't see the Proximity reporter or link
> loss api's on the dbus.
>
> My best guess is it is something to do with the "Not enough free
> handles to register service" error message in the bluetoothd logs.
>
> Here are the logs from bluetoothd -n -d --plugin=proximity
> bluetoothd[476]: Bluetooth daemon 5.30
> bluetoothd[476]: src/adapter.c:adapter_init() sending read version command
> bluetoothd[476]: Starting SDP server
> bluetoothd[476]: src/sdpd-service.c:register_device_id() Adding device
> id record for 0002:1d6b:0246:051e
> bluetoothd[476]: src/plugin.c:plugin_init() Loading builtin plugins
> bluetoothd[476]: Ignoring (cli) hostname
> bluetoothd[476]: Ignoring (cli) wiimote
> bluetoothd[476]: Ignoring (cli) autopair
> bluetoothd[476]: Ignoring (cli) policy
> bluetoothd[476]: Ignoring (cli) neard
> bluetoothd[476]: Ignoring (cli) sap
> bluetoothd[476]: Ignoring (cli) a2dp
> bluetoothd[476]: Ignoring (cli) avrcp
> bluetoothd[476]: Ignoring (cli) network
> bluetoothd[476]: Ignoring (cli) input
> bluetoothd[476]: Ignoring (cli) hog
> bluetoothd[476]: Ignoring (cli) health
> bluetoothd[476]: Ignoring (cli) gap
> bluetoothd[476]: Ignoring (cli) scanparam
> bluetoothd[476]: Ignoring (cli) deviceinfo
> bluetoothd[476]: Ignoring (cli) alert
> bluetoothd[476]: Ignoring (cli) time
> bluetoothd[476]: src/plugin.c:add_plugin() Loading proximity plugin
> bluetoothd[476]: Ignoring (cli) thermometer
> bluetoothd[476]: Ignoring (cli) heartrate
> bluetoothd[476]: Ignoring (cli) cyclingspeed
> bluetoothd[476]: src/plugin.c:plugin_init() Loading plugins
> /usr/lib/bluetooth/plugins
> bluetoothd[476]: src/main.c:main() Entering main loop
> bluetoothd[476]: src/rfkill.c:rfkill_event() RFKILL event idx 0 type 2
> op 0 soft 0 hard 0
> bluetoothd[476]: Bluetooth management interface 1.4 initialized
> bluetoothd[476]: src/adapter.c:read_version_complete() sending read
> supported commands command
> bluetoothd[476]: src/adapter.c:read_version_complete() sending read
> index list command
> bluetoothd[476]: src/adapter.c:read_commands_complete() Number of commands: 42
> bluetoothd[476]: src/adapter.c:read_commands_complete() Number of events: 21
> bluetoothd[476]: src/adapter.c:read_index_list_complete() Number of
> controllers: 1
> bluetoothd[476]: src/adapter.c:read_index_list_complete() Found index 0
> bluetoothd[476]: src/adapter.c:index_added() index 0
> bluetoothd[476]: src/adapter.c:btd_adapter_new() System name: BlueZ 5.30
> bluetoothd[476]: src/adapter.c:btd_adapter_new() Major class: 0
> bluetoothd[476]: src/adapter.c:btd_adapter_new() Minor class: 0
> bluetoothd[476]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d051E
> bluetoothd[476]: src/adapter.c:btd_adapter_new() Discoverable timeout:
> 180 seconds
> bluetoothd[476]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 seconds
> bluetoothd[476]: src/adapter.c:index_added() sending read info command
> for index 0
> bluetoothd[476]: src/adapter.c:read_info_complete() index 0 status 0x00
> bluetoothd[476]: src/adapter.c:clear_uuids() sending clear uuids
> command for index 0
> bluetoothd[476]: src/adapter.c:adapter_service_add() /org/bluez/hci0
> bluetoothd[476]: src/sdpd-service.c:add_record_to_server() Adding
> record with handle 0x10001
> bluetoothd[476]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00000007-0000-1000-8000-00805f9
> bluetoothd[476]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00000100-0000-1000-8000-00805f9
> bluetoothd[476]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001002-0000-1000-8000-00805f9
> bluetoothd[476]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001800-0000-1000-8000-00805f9
> bluetoothd[476]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
> bluetoothd[476]: src/adapter.c:add_uuid() sending add uuid command for index 0
> bluetoothd[476]: src/gatt-database.c:gatt_db_service_added() GATT
> Service added to local database
> bluetoothd[476]: Failed to obtain handles for "Service Changed" characteristic
> bluetoothd[476]: src/adapter.c:adapter_service_add() /org/bluez/hci0
> bluetoothd[476]: src/sdpd-service.c:add_record_to_server() Adding
> record with handle 0x10002
> bluetoothd[476]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00000007-0000-1000-8000-00805f9
> bluetoothd[476]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00000100-0000-1000-8000-00805f9
> bluetoothd[476]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001002-0000-1000-8000-00805f9
> bluetoothd[476]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001801-0000-1000-8000-00805f9
> bluetoothd[476]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
> bluetoothd[476]: src/adapter.c:add_uuid() sending add uuid command for index 0
> bluetoothd[476]: src/gatt-database.c:gatt_db_service_added() GATT
> Service added to local database
> bluetoothd[476]: Failed to register org.bluez.LEAdvertisingManager1
> bluetoothd[476]: Failed to register LEAdvertisingManager1 interface for adapter
> bluetoothd[476]: Not enough free handles to register service
> bluetoothd[476]: Error adding Link Loss service
> bluetoothd[476]: Not enough free handles to register service
> bluetoothd[476]: Not enough free handles to register service
> bluetoothd[476]:
> profiles/proximity/reporter.c:reporter_adapter_probe() Proximity
> Reporter for adapter 0xd3478
> bluetoothd[476]: src/adapter.c:btd_adapter_unblock_address() hci0
> 00:00:00:00:00:00
> bluetoothd[476]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys 0
> bluetoothd[476]: src/adapter.c:load_ltks() hci0 keys 0
> bluetoothd[476]: src/adapter.c:load_conn_params() hci0 conn params 0
> bluetoothd[476]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
> bluetoothd[476]: src/adapter.c:add_uuid() sending add uuid command for index 0
> bluetoothd[476]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b
> product 246 version 51e
> bluetoothd[476]: src/adapter.c:adapter_register() Adapter
> /org/bluez/hci0 registered
> bluetoothd[476]: src/adapter.c:set_dev_class() sending set device
> class command for index 0
> bluetoothd[476]: src/adapter.c:set_name() sending set local name
> command for index 0
> bluetoothd[476]: src/adapter.c:set_mode() sending set mode command for index 0
> bluetoothd[476]: src/adapter.c:load_link_keys_complete() link keys
> loaded for hci0
> bluetoothd[476]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
> bluetoothd[476]: hci0 Load Connection Parameters failed: Unknown Command (0x01)
> ^Cbluetoothd[476]: Terminating
> bluetoothd[476]: src/adapter.c:adapter_shutdown()
> bluetoothd[476]: src/plugin.c:plugin_cleanup() Cleanup plugins
> bluetoothd[476]: src/adapter.c:adapter_remove() Removing adapter /org/bluez/hci0
> bluetoothd[476]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
> bluetoothd[476]: src/adapter.c:remove_uuid() sending remove uuid
> command for index 0
> bluetoothd[476]: src/sdpd-service.c:remove_record_from_server()
> Removing record with handle 0x10002
> bluetoothd[476]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
> bluetoothd[476]: src/adapter.c:remove_uuid() sending remove uuid
> command for index 0
> bluetoothd[476]: src/sdpd-service.c:remove_record_from_server()
> Removing record with handle 0x10001
> bluetoothd[476]: src/adapter.c:btd_adapter_unref() Freeing adapter
> /org/bluez/hci0
> bluetoothd[476]: src/adapter.c:adapter_free() 0xd3478
> bluetoothd[476]: Stopping SDP server
> bluetoothd[476]: Exit
> root@trex:~# ./fred -n -d --plugin=proximity
> bluetoothd[486]: Bluetooth daemon 5.30
> bluetoothd[486]: src/adapter.c:adapter_init() sending read version command
> bluetoothd[486]: Starting SDP server
> bluetoothd[486]: src/sdpd-service.c:register_device_id() Adding device
> id record for 0002:1d6b:0246:051e
> bluetoothd[486]: src/plugin.c:plugin_init() Loading builtin plugins
> bluetoothd[486]: Ignoring (cli) hostname
> bluetoothd[486]: Ignoring (cli) wiimote
> bluetoothd[486]: Ignoring (cli) autopair
> bluetoothd[486]: Ignoring (cli) policy
> bluetoothd[486]: Ignoring (cli) neard
> bluetoothd[486]: Ignoring (cli) sap
> bluetoothd[486]: Ignoring (cli) a2dp
> bluetoothd[486]: Ignoring (cli) avrcp
> bluetoothd[486]: Ignoring (cli) network
> bluetoothd[486]: Ignoring (cli) input
> bluetoothd[486]: Ignoring (cli) hog
> bluetoothd[486]: Ignoring (cli) health
> bluetoothd[486]: Ignoring (cli) gap
> bluetoothd[486]: Ignoring (cli) scanparam
> bluetoothd[486]: Ignoring (cli) deviceinfo
> bluetoothd[486]: Ignoring (cli) alert
> bluetoothd[486]: Ignoring (cli) time
> bluetoothd[486]: src/plugin.c:add_plugin() Loading proximity plugin
> bluetoothd[486]: Ignoring (cli) thermometer
> bluetoothd[486]: Ignoring (cli) heartrate
> bluetoothd[486]: Ignoring (cli) cyclingspeed
> bluetoothd[486]: src/plugin.c:plugin_init() Loading plugins
> /usr/lib/bluetooth/plugins
> bluetoothd[486]: src/main.c:main() Entering main loop
> bluetoothd[486]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type 2
> op 0 soft 0 hard 0
> bluetoothd[486]: Bluetooth management interface 1.4 initialized
> bluetoothd[486]: src/adapter.c:read_version_complete() sending read
> supported commands command
> bluetoothd[486]: src/adapter.c:read_version_complete() sending read
> index list command
> bluetoothd[486]: src/adapter.c:read_commands_complete() Number of commands: 42
> bluetoothd[486]: src/adapter.c:read_commands_complete() Number of events: 21
> bluetoothd[486]: src/adapter.c:read_index_list_complete() Number of
> controllers: 1
> bluetoothd[486]: src/adapter.c:read_index_list_complete() Found index 0
> bluetoothd[486]: src/adapter.c:index_added() index 0
> bluetoothd[486]: src/adapter.c:btd_adapter_new() System name: BlueZ 5.30
> bluetoothd[486]: src/adapter.c:btd_adapter_new() Major class: 0
> bluetoothd[486]: src/adapter.c:btd_adapter_new() Minor class: 0
> bluetoothd[486]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d051E
> bluetoothd[486]: src/adapter.c:btd_adapter_new() Discoverable timeout:
> 180 seconds
> bluetoothd[486]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 seconds
> bluetoothd[486]: src/adapter.c:index_added() sending read info command
> for index 0
> bluetoothd[486]: src/adapter.c:read_info_complete() index 0 status 0x00
> bluetoothd[486]: src/adapter.c:clear_uuids() sending clear uuids
> command for index 0
> bluetoothd[486]: src/adapter.c:set_mode() sending set mode command for index 0
> bluetoothd[486]: src/adapter.c:set_mode() sending set mode command for index 0
> bluetoothd[486]: src/adapter.c:adapter_service_add() /org/bluez/hci0
> bluetoothd[486]: src/sdpd-service.c:add_record_to_server() Adding
> record with handle 0x10001
> bluetoothd[486]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00000007-0000-1000-8000-00805f9
> bluetoothd[486]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00000100-0000-1000-8000-00805f9
> bluetoothd[486]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001002-0000-1000-8000-00805f9
> bluetoothd[486]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001800-0000-1000-8000-00805f9
> bluetoothd[486]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
> bluetoothd[486]: src/adapter.c:add_uuid() sending add uuid command for index 0
> bluetoothd[486]: src/gatt-database.c:gatt_db_service_added() GATT
> Service added to local database
> bluetoothd[486]: Failed to obtain handles for "Service Changed" characteristic
> bluetoothd[486]: src/adapter.c:adapter_service_add() /org/bluez/hci0
> bluetoothd[486]: src/sdpd-service.c:add_record_to_server() Adding
> record with handle 0x10002
> bluetoothd[486]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00000007-0000-1000-8000-00805f9
> bluetoothd[486]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00000100-0000-1000-8000-00805f9
> bluetoothd[486]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001002-0000-1000-8000-00805f9
> bluetoothd[486]: src/sdpd-service.c:add_record_to_server() Record
> pattern UUID 00001801-0000-1000-8000-00805f9
> bluetoothd[486]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
> bluetoothd[486]: src/adapter.c:add_uuid() sending add uuid command for index 0
> bluetoothd[486]: src/gatt-database.c:gatt_db_service_added() GATT
> Service added to local database
> bluetoothd[486]: Failed to register org.bluez.LEAdvertisingManager1
> bluetoothd[486]: Failed to register LEAdvertisingManager1 interface for adapter
> bluetoothd[486]: Not enough free handles to register service
> bluetoothd[486]: Error adding Link Loss service
> bluetoothd[486]: Not enough free handles to register service
> bluetoothd[486]: Not enough free handles to register service
> bluetoothd[486]:
> profiles/proximity/reporter.c:reporter_adapter_probe() Proximity
> Reporter for adapter 0xd3478
> bluetoothd[486]: src/adapter.c:btd_adapter_unblock_address() hci0
> 00:00:00:00:00:00
> bluetoothd[486]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys 0
> bluetoothd[486]: src/adapter.c:load_ltks() hci0 keys 0
> bluetoothd[486]: src/adapter.c:load_conn_params() hci0 conn params 0
> bluetoothd[486]: src/adapter.c:load_connections() sending get
> connections command for index 0
> bluetoothd[486]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
> bluetoothd[486]: src/adapter.c:add_uuid() sending add uuid command for index 0
> bluetoothd[486]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b
> product 246 version 51e
> bluetoothd[486]: src/adapter.c:adapter_register() Adapter
> /org/bluez/hci0 registered
> bluetoothd[486]: src/adapter.c:set_dev_class() sending set device
> class command for index 0
> bluetoothd[486]: src/adapter.c:set_name() sending set local name
> command for index 0
> bluetoothd[486]: src/adapter.c:set_mode() sending set mode command for index 0
> bluetoothd[486]: src/adapter.c:set_mode() sending set mode command for index 0
> bluetoothd[486]: src/adapter.c:adapter_start() adapter /org/bluez/hci0
> has been enabled
> bluetoothd[486]: src/adapter.c:new_settings_callback() Settings: 0x000000c1
> bluetoothd[486]: src/adapter.c:settings_changed() Changed settings: 0x00000040
> bluetoothd[486]: src/adapter.c:new_settings_callback() Settings: 0x000002c1
> bluetoothd[486]: src/adapter.c:settings_changed() Changed settings: 0x00000200
> bluetoothd[486]: src/adapter.c:trigger_passive_scanning()
> bluetoothd[486]: src/adapter.c:load_link_keys_complete() link keys
> loaded for hci0
> bluetoothd[486]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
> bluetoothd[486]: hci0 Load Connection Parameters failed: Unknown Command (0x01)
> bluetoothd[486]: src/adapter.c:get_connections_complete() Connection count: 0
> bluetoothd[486]: src/adapter.c:dev_class_changed_callback() Class: 0x000000
> bluetoothd[486]: src/adapter.c:local_name_changed_callback() Name: BlueZ 5.30
> bluetoothd[486]: src/adapter.c:local_name_changed_callback() Short name:
> bluetoothd[486]: src/adapter.c:local_name_changed_callback() Current
> alias: BlueZ 5.30
> bluetoothd[486]: src/adapter.c:new_settings_callback() Settings: 0x000002d1
> bluetoothd[486]: src/adapter.c:settings_changed() Changed settings: 0x00000010
> bluetoothd[486]: src/adapter.c:new_settings_callback() Settings: 0x000002d3
> bluetoothd[486]: src/adapter.c:settings_changed() Changed settings: 0x00000002
>
> Here are the matching hcidump logs....
>
> hcidump
> HCI sniffer - Bluetooth packet analyzer ver 5.30
> device: hci0 snap_len: 1500 filter: 0xffffffff
> < HCI Command: Write Simple Pairing Mode (0x03|0x0056) plen 1
>     mode 0x01
>> HCI Event: Command Complete (0x0e) plen 4
>     Write Simple Pairing Mode (0x03|0x0056) ncmd 1
>     status 0x00
> < HCI Command: Write LE Host Supported (0x03|0x006d) plen 2
>> HCI Event: Command Complete (0x0e) plen 4
>     Write LE Host Supported (0x03|0x006d) ncmd 1
> < HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
>> HCI Event: Command Complete (0x0e) plen 4
>     LE Set Advertising Data (0x08|0x0008) ncmd 1
>     status 0x00
> < HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
>     fec 0x00
>     TX power level: 15
>     Unknown type 0x10 with 8 bytes data
>     Complete service classes: 0x1800 0x1801
>> HCI Event: Command Complete (0x0e) plen 4
>     Write Extended Inquiry Response (0x03|0x0052) ncmd 1
>     status 0x00
> < HCI Command: Write Class of Device (0x03|0x0024) plen 3
>     class 0x000000
>> HCI Event: Command Complete (0x0e) plen 4
>     Write Class of Device (0x03|0x0024) ncmd 1
>     status 0x00
> < HCI Command: Write Local Name (0x03|0x0013) plen 248
>     name 'BlueZ 5.30'
>> HCI Event: Command Complete (0x0e) plen 4
>     Write Local Name (0x03|0x0013) ncmd 1
>     status 0x00
> < HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
>     fec 0x00
>     Complete local name: 'BlueZ 5.30'
>     TX power level: 15
>     Unknown type 0x10 with 8 bytes data
>     Complete service classes: 0x1800 0x1801
>> HCI Event: Command Complete (0x0e) plen 4
>     Write Extended Inquiry Response (0x03|0x0052) ncmd 1
>     status 0x00
> < HCI Command: LE Set Scan Response Data (0x08|0x0009) plen 32
>> HCI Event: Command Complete (0x0e) plen 4
>     LE Set Scan Response Data (0x08|0x0009) ncmd 1
>     status 0x00
> < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
>     enable 2
>> HCI Event: Command Complete (0x0e) plen 4
>     Write Scan Enable (0x03|0x001a) ncmd 1
>     status 0x00
>
> Any guesses as to what is going wrong?
>

That error message is logged by attrib/gatt-service.c, which is
internally used by bluetoothd in src/attrib-server.c, both of which
are deprecated. attrib-server.c has been replaced by
src/gatt-database.c. All plugins that make use of src/attrib-server
are now defunct, as it was decided that these experimental plugins
will no longer be supported in favor of the new GATT stack.

Hence these error messages are just noise. We should either silence
these or just simple go ahead and do away with all of the experimental
GATT plugins and src/attrib-server, now that we have a working GATT
D-Bus API (although it's still behind the experimental flag).


>
> --
> John Carter
> Phone : (64)(3) 358 6639
> Tait Electronics
> PO Box 1645 Christchurch
> New Zealand
>
> --
>
> ------------------------------
> This email, including any attachments, is only for the intended recipient.
> It is subject to copyright, is confidential and may be the subject of legal
> or other privilege, none of which is waived or lost by reason of this
> transmission.
> If you are not an intended recipient, you may not use, disseminate,
> distribute or reproduce such email, any attachments, or any part thereof.
> If you have received a message in error, please notify the sender
> immediately and erase all copies of the message and any attachments.
> Unfortunately, we cannot warrant that the email has not been altered or
> corrupted during transmission nor can we guarantee that any email or any
> attachments are free from computer viruses or other conditions which may
> damage or interfere with recipient data, hardware or software. The
> recipient relies upon its own procedures and assumes all risk of use and of
> opening any attachments.
> ------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
