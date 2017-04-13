Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1b8c74ef5fafaca3c75fb87249d728f8@labapart.com>
References: <1b8c74ef5fafaca3c75fb87249d728f8@labapart.com>
From: Barry Byford <31baz66@gmail.com>
Date: Thu, 13 Apr 2017 18:59:06 +0100
Message-ID: <CAAu3APaR4weHx=63JFbaQNK5kQmCEm3LHg6mPhFe7NQ9aW4Cvg@mail.gmail.com>
Subject: Re: GATT Server: DBus GATT Services not advertised/exported
To: Olivier MARTIN <olivier@labapart.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Olivier,


On 13 April 2017 at 12:14, Olivier MARTIN <olivier@labapart.com> wrote:
> Hi all,
> I am having issue to advertise/export GATT services exposed through DBus
> API. I tried `./test/example-gatt-server`. And I also tried to merge
> `./test/example-advertisement` into `./test/example-gatt-server`. But in
> both cases I only see the two compulsory GATT services:
> - Generic Access Service (0x1800)
> - Generic Attribute Service (0x1801)
>
> I am using Bluez v5.44. And I also tried Bluez v5.37.
>
> GATT Services seem to be discovered by Bluez (note: I added additional debug
> statement all prefixed with '#'):
>
> bluetoothd[16877]: src/gatt-database.c:manager_register_app() #
> manager_register_app
> bluetoothd[16877]: src/gatt-database.c:create_app() # create_app
> bluetoothd[16877]: src/gatt-database.c:manager_register_app() Registering
> application: :1.404:/
> bluetoothd[16877]: src/advertising.c:register_advertisement()
> RegisterAdvertisement
> bluetoothd[16877]: src/advertising.c:client_create() Adding proxy for
> /org/bluez/example/advertisement0
> bluetoothd[16877]: src/advertising.c:register_advertisement() Registered
> advertisement at path /org/bluez/example/advertisement0
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service0/char2, iface: org.bluez.GattCharacteristic1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service2/char0/desc0, iface: org.bluez.GattDescriptor1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service2/char2/desc3, iface: org.bluez.GattDescriptor1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service2/char2, iface: org.bluez.GattCharacteristic1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service1/char0, iface: org.bluez.GattCharacteristic1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service2/char1, iface: org.bluez.GattCharacteristic1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service0/char1, iface: org.bluez.GattCharacteristic1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service2/char1/desc3, iface: org.bluez.GattDescriptor1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service2/char1/desc2, iface: org.bluez.GattDescriptor1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service0/char0, iface: org.bluez.GattCharacteristic1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service2, iface: org.bluez.GattService1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service1, iface: org.bluez.GattService1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service0, iface: org.bluez.GattService1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service2/char0/desc1, iface: org.bluez.GattDescriptor1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service2/char2/desc2, iface: org.bluez.GattDescriptor1
> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object received:
> /org/bluez/example/service2/char0, iface: org.bluez.GattCharacteristic1
> bluetoothd[16877]: src/gatt-database.c:client_ready_cb() # client_ready_cb
> bluetoothd[16877]: src/gatt-database.c:create_service() # create_service
> from /org/bluez/example/service2
> bluetoothd[16877]: src/gatt-database.c:create_service() # create_service
> from /org/bluez/example/service1
> bluetoothd[16877]: src/gatt-database.c:create_service() # create_service
> from /org/bluez/example/service0
> bluetoothd[16877]: src/gatt-database.c:database_add_app() # database_add_app
> bluetoothd[16877]: src/gatt-database.c:database_add_service() #
> database_add_service
> bluetoothd[16877]: src/gatt-database.c:cep_write_cb() Stored CEP value in
> the database
> bluetoothd[16877]: src/gatt-database.c:database_add_cep() Created CEP entry
> for characteristic
> bluetoothd[16877]: src/gatt-database.c:cep_write_cb() Stored CEP value in
> the database
> bluetoothd[16877]: src/gatt-database.c:database_add_cep() Created CEP entry
> for characteristic
> bluetoothd[16877]: src/gatt-database.c:cep_write_cb() Stored CEP value in
> the database
> bluetoothd[16877]: src/gatt-database.c:database_add_cep() Created CEP entry
> for characteristic
> bluetoothd[16877]: src/gatt-database.c:gatt_db_service_added() #
> gatt_db_service_added: GATT Service added to local database
> bluetoothd[16877]: src/gatt-database.c:database_add_service() #
> database_add_service
> bluetoothd[16877]: src/gatt-database.c:database_add_ccc() Created CCC entry
> for characteristic
> bluetoothd[16877]: src/gatt-database.c:gatt_db_service_added() #
> gatt_db_service_added: GATT Service added to local database
> bluetoothd[16877]: src/gatt-database.c:database_add_service() #
> database_add_service
> bluetoothd[16877]: src/gatt-database.c:database_add_ccc() Created CCC entry
> for characteristic
> bluetoothd[16877]: src/gatt-database.c:gatt_db_service_added() #
> gatt_db_service_added: GATT Service added to local database
> bluetoothd[16877]: src/gatt-database.c:client_ready_cb() GATT application
> registered: :1.404:/
> bluetoothd[16877]: src/advertising.c:parse_service_uuids() Adding
> ServiceUUID: 180D
> bluetoothd[16877]: src/advertising.c:parse_service_uuids() Adding
> ServiceUUID: 180F
> bluetoothd[16877]: src/advertising.c:parse_manufacturer_data() Adding
> ManufacturerData for ffff
> bluetoothd[16877]: src/advertising.c:parse_service_data() Adding ServiceData
> for 9999
> bluetoothd[16877]: src/advertising.c:refresh_advertisement() Refreshing
> advertisement: /org/bluez/example/advertisement0
> bluetoothd[16877]: src/advertising.c:add_adv_callback() Advertisement
> registered: /org/bluez/example/advertisement0
>
> I start `./test/example-gatt-server` as a normal user. But Bluez does not
> seem to have any permission issue with it.

Building from source I've seen something similar if I've used sudo for the make.

To compile and install I use sudo for the install only:

make -j 4 && sudo make install



>
> I am using 'BLE scanner' on Android to discover the GATT services. But I
> think the problem is coming from Bluez. When I connect the Android device to
> Bluez, I can see this log:
>
> bluetoothd[16877]: src/adapter.c:connected_callback() hci0 device
> 98:D6:F7:31:7B:0D connected eir_len 14
> bluetoothd[16877]: src/gatt-database.c:connect_cb() New incoming BR/EDR ATT
> connection
> bluetoothd[16877]: attrib/gattrib.c:g_attrib_ref() 0x98cd908: g_attrib_ref=1
> bluetoothd[16877]: src/device.c:load_gatt_db() # load_gatt_db: Restoring
> 98:D6:F7:31:7B:0D gatt database from file
> '/var/lib/bluetooth/5C:F3:70:6A:D9:3C/cache/98:D6:F7:31:7B:0D'
> bluetoothd[16877]: src/device.c:load_gatt_db_impl() # load_gatt_db_impl
> bluetoothd[16877]: src/device.c:load_service() # load_service: loading
> service: 0x0001, end: 0x0005, uuid: 00001801-0000-1000-8000-00805f9b34fb
> bluetoothd[16877]: src/device.c:load_service() # load_service: loading
> service: 0x0014, end: 0xffff, uuid: 00001800-0000-1000-8000-00805f9b34fb
> bluetoothd[16877]: src/device.c:load_chrc() loading characteristic handle:
> 0x0002, value handle: 0x0003, properties 0x0020 uuid:
> 00002a05-0000-1000-8000-00805f9b34fb
> bluetoothd[16877]: src/device.c:load_chrc() loading characteristic handle:
> 0x0015, value handle: 0x0016, properties 0x0002 uuid:
> 00002a00-0000-1000-8000-00805f9b34fb
> bluetoothd[16877]: src/device.c:load_chrc() loading characteristic handle:
> 0x0017, value handle: 0x0018, properties 0x0002 uuid:
> 00002a01-0000-1000-8000-00805f9b34fb
> bluetoothd[16877]: src/device.c:load_gatt_db() List GATT Primaries before
> being free:
> bluetoothd[16877]: src/device.c:print_primary() - Primary UUID:
> 00001801-0000-1000-8000-00805f9b34fb
> bluetoothd[16877]: src/device.c:print_primary() - Primary UUID:
> 00001800-0000-1000-8000-00805f9b34fb
> bluetoothd[16877]: src/device.c:add_primary() # add_primary
> bluetoothd[16877]: src/device.c:add_primary() # add_primary
> bluetoothd[16877]: profiles/gap/gas.c:gap_accept() GAP profile accept
> (98:D6:F7:31:7B:0D)
> bluetoothd[16877]: src/service.c:change_state() 0x98c98e0: device
> 98:D6:F7:31:7B:0D profile gap-profile state changed: disconnected ->
> connected (0)
> bluetoothd[16877]: src/gatt-client.c:btd_gatt_client_connected() Device
> connected.
> bluetoothd[16877]: src/device.c:gatt_server_init() # gatt_server_init
> bluetoothd[16877]: src/device.c:gatt_debug() Primary services found: 2
> bluetoothd[16877]: src/device.c:gatt_debug() start: 0x0001, end: 0x0005,
> uuid: 00001801-0000-1000-8000-00805f9b34fb
> bluetoothd[16877]: src/device.c:gatt_debug() start: 0x0014, end: 0xffff,
> uuid: 00001800-0000-1000-8000-00805f9b34fb
> bluetoothd[16877]: src/device.c:gatt_debug() Registered handler for "Service
> Changed": 0
> bluetoothd[16877]: src/device.c:gatt_client_ready_cb() status: success,
> error: 0
> bluetoothd[16877]: src/device.c:register_gatt_services() #
> register_gatt_services
> bluetoothd[16877]: src/device.c:add_primary() # add_primary
> bluetoothd[16877]: src/device.c:add_primary() # add_primary
> bluetoothd[16877]: src/device.c:add_gatt_service() # add_gatt_service:
> UUID:00001801-0000-1000-8000-00805f9b34fb
> bluetoothd[16877]: src/gatt-client.c:btd_gatt_client_ready() GATT client
> ready
> bluetoothd[16877]: src/gatt-client.c:create_services() Exporting objects for
> GATT services: 98:D6:F7:31:7B:0D
> bluetoothd[16877]: src/gatt-client.c:service_create() Exported GATT service:
> /org/bluez/hci0/dev_98_D6_F7_31_7B_0D/service0001
> bluetoothd[16877]: src/gatt-client.c:characteristic_create() Exported GATT
> characteristic: /org/bluez/hci0/dev_98_D6_F7_31_7B_0D/service0001/char0002
> bluetoothd[16877]: src/device.c:device_svc_resolved()
> /org/bluez/hci0/dev_98_D6_F7_31_7B_0D err 0
> bluetoothd[16877]: src/device.c:store_gatt_db() # store_gatt_db
> bluetoothd[16877]: src/device.c:store_service() # store_service
> bluetoothd[16877]: src/device.c:store_service() # store_service
> bluetoothd[16877]: profiles/gap/gas.c:read_device_name_cb() GAP Device Name:
> Nexus 4
> bluetoothd[16877]: profiles/gap/gas.c:read_appearance_cb() GAP Appearance:
> 0x0000
>
> I also reduced DBus 'TestAdvertisement' interface to only expose one GATT
> Service as many BLE adapter got a limitation in the size of the
> advertisement packet:
> class TestAdvertisement(Advertisement):
>
>     def __init__(self, bus, index):
>         Advertisement.__init__(self, bus, index, 'peripheral')
>         #self.add_service_uuid('180D') # HeartRate
>         self.add_service_uuid('180F') # Battery
>         #self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03, 0x04])
>         #self.add_service_data('9999', [0x00, 0x01, 0x02, 0x03, 0x04])
>         self.include_tx_power = True
>
> My concern is mainly these lines:
>
> bluetoothd[16877]: src/device.c:gatt_debug() Primary services found: 2
> bluetoothd[16877]: src/device.c:gatt_debug() start: 0x0001, end: 0x0005,
> uuid: 00001801-0000-1000-8000-00805f9b34fb
> bluetoothd[16877]: src/device.c:gatt_debug() start: 0x0014, end: 0xffff,
> uuid: 00001800-0000-1000-8000-00805f9b34fb
>

I've seen this kind of error message when I've had a failure of a
previous script and the Bluetooth daemon is in some unknown state. At
this point it is worth restarting the bluetooth service with:
  sudo service bluetooth restart

You will see in the advertising DBus API documentation that it is
still in experimental mode in 5.44.
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-api.txt#n78

This means that you need to make sure bluetoothd is started in
experimental mode. Have you done this?
 You can check with "sudo service bluetooth status"

Experimental can be switched on by default in the bluetooth.service file

Edit /lib/systemd/system/bluetooth.service file to add --experimental flag e.g:

sudo sed -i '/^ExecStart.*bluetoothd\s*$/ s/$/ --experimental/'
/lib/systemd/system/bluetooth.service




> I have not found the code that export GATT Services from GATT Database to
> the BLE central.
>
> From my search on Internet, it looks I am not the only one who is having
> this issue
> I am happy to share/test anything that could help to make some progress.
>
> Thanks,
> Olivier
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
