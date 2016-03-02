Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHrp-j9Ovv1MoFiChU8EmKardboBo2G5QZQTKTRm+4yHfX-5gw@mail.gmail.com>
References: <CAHrp-j-pSj5kymb95W7dKPgqcq8eyvf_QzuwK2zaziDcOErTaA@mail.gmail.com>
	<CAHrp-j9Ovv1MoFiChU8EmKardboBo2G5QZQTKTRm+4yHfX-5gw@mail.gmail.com>
Date: Wed, 2 Mar 2016 15:50:50 +0200
Message-ID: <CABBYNZKb3h9d6FMGxewhS=WyZ25t9BcRDzrYaNVM=CcJzDkMEA@mail.gmail.com>
Subject: Re: GATT server example issues in BlueZ
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ivan Deviatkin <devyatkin.ivan@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ivan,

On Wed, Mar 2, 2016 at 1:16 PM, Ivan Deviatkin <devyatkin.ivan@gmail.com> wrote:
>     Additionally I have checked python example "example-gatt-server"
> from \tests - it reports that GATT server is running but in bluetoothd
> logs still the same issue.

So you don't see something like this:


./example-gatt-server
GetManagedObjects
GATT application registered

bluetoothd[16205]: src/gatt-database.c:manager_register_app()
Registering application: :1.603:/
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service0, iface: org.bluez.GattService1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service0/char0, iface:
org.bluez.GattCharacteristic1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service0/char1, iface:
org.bluez.GattCharacteristic1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service0/char2, iface:
org.bluez.GattCharacteristic1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service1, iface: org.bluez.GattService1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service1/char0, iface:
org.bluez.GattCharacteristic1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service2, iface: org.bluez.GattService1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service2/char0, iface:
org.bluez.GattCharacteristic1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service2/char0/desc0, iface:
org.bluez.GattDescriptor1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service2/char0/desc1, iface:
org.bluez.GattDescriptor1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service2/char1, iface:
org.bluez.GattCharacteristic1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service2/char1/desc2, iface:
org.bluez.GattDescriptor1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /org/bluez/example/service2/char1/desc3, iface:
org.bluez.GattDescriptor1
bluetoothd[16205]: src/gatt-database.c:database_add_ccc() Created CCC
entry for characteristic
bluetoothd[16205]: src/gatt-database.c:gatt_db_service_added() GATT
Service added to local database
bluetoothd[16205]: src/gatt-database.c:database_add_ccc() Created CCC
entry for characteristic
bluetoothd[16205]: src/gatt-database.c:gatt_db_service_added() GATT
Service added to local database
bluetoothd[16205]: src/gatt-database.c:cep_write_cb() Stored CEP value
in the database
bluetoothd[16205]: src/gatt-database.c:database_add_cep() Created CEP
entry for characteristic
bluetoothd[16205]: src/gatt-database.c:cep_write_cb() Stored CEP value
in the database
bluetoothd[16205]: src/gatt-database.c:database_add_cep() Created CEP
entry for characteristic
bluetoothd[16205]: src/gatt-database.c:gatt_db_service_added() GATT
Service added to local database
bluetoothd[16205]: src/gatt-database.c:client_ready_cb() GATT
application registered: :1.603:/


>     Also I have tried to work with BlueZ D-Bus interface
> (experimental) but I can see that some methods used during registering
> of external service via D-Bus are not fully implemented yet, see
> example (bluez 5.37/tools/gatt_service, line 414):
> “          dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> "{sv}", &dict);
>             /* TODO: Add options dictionary */   <-- it means what it
> is not finished, right?
> ”
>     It seems to me, that without passing dictionary it is impossible
> to register external service. Because dictionary includes information
> about characteristics of service.

Also works just fine:

./gatt-service
gatt-service unique name: :1.604
Registered service: /service1
Get Primary: True
Get UUID: 00001802-0000-1000-8000-00805f9b34fb
Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
Get Primary: True
Get UUID: 00001802-0000-1000-8000-00805f9b34fb
Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
RegisterApplication: OK

bluetoothd[16205]: src/gatt-database.c:manager_register_app()
Registering application: :1.604:/
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /service1, iface: org.bluez.GattService1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /service1/characteristic1, iface: org.bluez.GattCharacteristic1
bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
path: /service1/characteristic1/descriptor2, iface:
org.bluez.GattDescriptor1
bluetoothd[16205]: src/gatt-database.c:gatt_db_service_added() GATT
Service added to local database
bluetoothd[16205]: src/gatt-database.c:client_ready_cb() GATT
application registered: :1.604:/

>     May I kindly ask you to clarify to me next:
>     - Should I apply manual fix (call of
> btd_adapter_gatt_server_start() method or some other way of adding
> server to list) for that in Bluez 5.37 source? If "yes" what is the
> proper place to do that from design point of view?

Nope, just use the D-Bus API, perhaps you are missing some fixes
upstream if so just use the latest git version.

>     - What is recommended (and working) example in BlueZ package to
> run GATT server?

Both python and C example should actually work, the tricky part is
making Android not to attempt to connect over BR/EDR once it realize
you are running in dual mode which is usually the case, if you connect
using another BlueZ it should work just fine.

>     - What is recommended code to follow as example/sample for my own
> GATT server application?

That will probably depend on the D-Bus library and language you intend
to use, we actually still have some problems with bindings that don't
maintain the order of objects, but I believe I should have a fix for
that pretty soon/

>     - If I would like to participate in development of BlueZ
> (http://git.kernel.org/cgit/bluetooth/bluez.git) who is the right
> person to get latest GATT serevr status and ask design questions, to
> apply fixes in proper place?

I probably should be that person, but other individuals in the mailing
list should be able to help as well,  btw you could just figure this
by looking at the git history but it seems you don't even have cloned
the git tree.
