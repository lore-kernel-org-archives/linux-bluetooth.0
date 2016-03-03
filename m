Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKb3h9d6FMGxewhS=WyZ25t9BcRDzrYaNVM=CcJzDkMEA@mail.gmail.com>
References: <CAHrp-j-pSj5kymb95W7dKPgqcq8eyvf_QzuwK2zaziDcOErTaA@mail.gmail.com>
	<CAHrp-j9Ovv1MoFiChU8EmKardboBo2G5QZQTKTRm+4yHfX-5gw@mail.gmail.com>
	<CABBYNZKb3h9d6FMGxewhS=WyZ25t9BcRDzrYaNVM=CcJzDkMEA@mail.gmail.com>
Date: Thu, 3 Mar 2016 12:11:26 +0100
Message-ID: <CAHrp-j_iY+qNhhHV-epcMbJ68EL+VnxdzywJy8DsKBdHnpsRsA@mail.gmail.com>
Subject: Re: GATT server example issues in BlueZ
From: Ivan Deviatkin <devyatkin.ivan@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

    Thanks for fast reply and interesting details from your side.
Please find my explanations and questions  below.

On 2 March 2016 at 14:50, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Ivan,
>
> On Wed, Mar 2, 2016 at 1:16 PM, Ivan Deviatkin <devyatkin.ivan@gmail.com> wrote:
>>     Additionally I have checked python example "example-gatt-server"
>> from \tests - it reports that GATT server is running but in bluetoothd
>> logs still the same issue.
>
> So you don't see something like this:
>
>
> ./example-gatt-server
> GetManagedObjects
> GATT application registered
> ...
> Service added to local database
> bluetoothd[16205]: src/gatt-database.c:client_ready_cb() GATT
> application registered: :1.603:/

    I have seen "GATT server registered" in console for
"example-gatt-server" in BlueZ 5.37 - but that fact does not mean that
service is visible and available on my Android Phone (Motorola Nexus
6, Android 5.1, LMY47I) via BLE Scanner, Bluetooth LE Scanner or BLE
Reader. I have seen a little bit different logs for bluetoothd, but I
think it is mainly because of using releases, not git upstream code.

>
>
>>     Also I have tried to work with BlueZ D-Bus interface
>> (experimental) but I can see that some methods used during registering
>> of external service via D-Bus are not fully implemented yet, see
>> example (bluez 5.37/tools/gatt_service, line 414):
>> “          dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
>> "{sv}", &dict);
>>             /* TODO: Add options dictionary */   <-- it means what it
>> is not finished, right?
>> ”
>>     It seems to me, that without passing dictionary it is impossible
>> to register external service. Because dictionary includes information
>> about characteristics of service.
>
> Also works just fine:
>
> ./gatt-service
> gatt-service unique name: :1.604
> Registered service: /service1
> Get Primary: True
> Get UUID: 00001802-0000-1000-8000-00805f9b34fb
> Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
> Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
> Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
> Get Primary: True
> Get UUID: 00001802-0000-1000-8000-00805f9b34fb
> Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
> Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
> Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
> RegisterApplication: OK
>
> bluetoothd[16205]: src/gatt-database.c:manager_register_app()
> Registering application: :1.604:/
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /service1, iface: org.bluez.GattService1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /service1/characteristic1, iface: org.bluez.GattCharacteristic1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /service1/characteristic1/descriptor2, iface:
> org.bluez.GattDescriptor1
> bluetoothd[16205]: src/gatt-database.c:gatt_db_service_added() GATT
> Service added to local database
> bluetoothd[16205]: src/gatt-database.c:client_ready_cb() GATT
> application registered: :1.604:/
>

As I noticed above - I am afraid that logs from BlueZ by itself does
not mean that it works as it should. I have checked DBus interfaces
via d-feet and dbus-monitor. And as it was mentioned before - it was
empty to me. I have checked that on "example-gatt-server" - because it
uses DBus to register services.

>>     May I kindly ask you to clarify to me next:
>>     - Should I apply manual fix (call of
>> btd_adapter_gatt_server_start() method or some other way of adding
>> server to list) for that in Bluez 5.37 source? If "yes" what is the
>> proper place to do that from design point of view?
>
> Nope, just use the D-Bus API, perhaps you are missing some fixes
> upstream if so just use the latest git version.
>

   I think it makes sense to check this issue, because check of server
list to NULL is done through a code in Bluez, but adding to that list
only in one place - method "btd_adapter_gatt_server_start()". And this
method is not called anywhere in BlueZ 5.37.

>>     - What is recommended (and working) example in BlueZ package to
>> run GATT server?
>
> Both python and C example should actually work, the tricky part is
> making Android not to attempt to connect over BR/EDR once it realize
> you are running in dual mode which is usually the case, if you connect
> using another BlueZ it should work just fine.
>

    Thanks for explanation. However, not clear - that do you mean by
"over BR/EDR"  in retrospective to my Android phone - I can't find any
option to setup differently bluetooth.
Actually my goal is to use usual Android phone to connect to Linux
with Bluez using Bluetooth LE. I see that all examples BlueZ have
right now not working to me and other users as they should - that is
the problem to investigate and fix. Does BlueZ releases tested with
devices on market with Android or iOS? Because to me using Linux BlueZ
to connect another Linux Bluez seriously limitates it's usage.

>>     - If I would like to participate in development of BlueZ
>> (http://git.kernel.org/cgit/bluetooth/bluez.git) who is the right
>> person to get latest GATT serevr status and ask design questions, to
>> apply fixes in proper place?
>
> I probably should be that person, but other individuals in the mailing
> list should be able to help as well,  btw you could just figure this
> by looking at the git history but it seems you don't even have cloned
> the git tree.

   Thank you for an explanation. A small remark - I have cloned the
git tree and have seen your name. However in BlueZ guidelines strictly
recommended to avoid direct contacts first ("Contact" section on BlueZ
site). So for me it is only gentle way of communication - to avoid
messy bothering of developers.

BR,
Ivan
