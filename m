Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 3 Mar 2016 09:42:23 +1300
From: Kurt McAlpine <kurt@linux.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: devyatkin.ivan@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: GATT server example issues in BlueZ
Message-ID: <20160302204223.GA18853@kurtmc.Eroad.local>
References: <CAHrp-j-pSj5kymb95W7dKPgqcq8eyvf_QzuwK2zaziDcOErTaA@mail.gmail.com>
 <CAHrp-j9Ovv1MoFiChU8EmKardboBo2G5QZQTKTRm+4yHfX-5gw@mail.gmail.com>
 <CABBYNZKb3h9d6FMGxewhS=WyZ25t9BcRDzrYaNVM=CcJzDkMEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZKb3h9d6FMGxewhS=WyZ25t9BcRDzrYaNVM=CcJzDkMEA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I too am having some with BlueZ 5.37 from git (I pulled today).

On Wed, Mar 02, 2016 at 03:50:50PM +0200, Luiz Augusto von Dentz wrote:
> Hi Ivan,
> 
> On Wed, Mar 2, 2016 at 1:16 PM, Ivan Deviatkin <devyatkin.ivan@gmail.com> wrote:
> >     Additionally I have checked python example "example-gatt-server"
> > from \tests - it reports that GATT server is running but in bluetoothd
> > logs still the same issue.
> 
> So you don't see something like this:
> 
> 
> ./example-gatt-server
> GetManagedObjects
> GATT application registered
> 
> bluetoothd[16205]: src/gatt-database.c:manager_register_app()
> Registering application: :1.603:/
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service0, iface: org.bluez.GattService1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service0/char0, iface:
> org.bluez.GattCharacteristic1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service0/char1, iface:
> org.bluez.GattCharacteristic1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service0/char2, iface:
> org.bluez.GattCharacteristic1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service1, iface: org.bluez.GattService1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service1/char0, iface:
> org.bluez.GattCharacteristic1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service2, iface: org.bluez.GattService1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service2/char0, iface:
> org.bluez.GattCharacteristic1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service2/char0/desc0, iface:
> org.bluez.GattDescriptor1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service2/char0/desc1, iface:
> org.bluez.GattDescriptor1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service2/char1, iface:
> org.bluez.GattCharacteristic1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service2/char1/desc2, iface:
> org.bluez.GattDescriptor1
> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
> path: /org/bluez/example/service2/char1/desc3, iface:
> org.bluez.GattDescriptor1
> bluetoothd[16205]: src/gatt-database.c:database_add_ccc() Created CCC
> entry for characteristic
> bluetoothd[16205]: src/gatt-database.c:gatt_db_service_added() GATT
> Service added to local database
> bluetoothd[16205]: src/gatt-database.c:database_add_ccc() Created CCC
> entry for characteristic
> bluetoothd[16205]: src/gatt-database.c:gatt_db_service_added() GATT
> Service added to local database
> bluetoothd[16205]: src/gatt-database.c:cep_write_cb() Stored CEP value
> in the database
> bluetoothd[16205]: src/gatt-database.c:database_add_cep() Created CEP
> entry for characteristic
> bluetoothd[16205]: src/gatt-database.c:cep_write_cb() Stored CEP value
> in the database
> bluetoothd[16205]: src/gatt-database.c:database_add_cep() Created CEP
> entry for characteristic
> bluetoothd[16205]: src/gatt-database.c:gatt_db_service_added() GATT
> Service added to local database
> bluetoothd[16205]: src/gatt-database.c:client_ready_cb() GATT
> application registered: :1.603:/

I do see this but my android device cannot discover the GATT service within the
app. It is possible to pair with it, but not discover the services or even the
device within the app.

I've tired "Bluetooth LE Scanner" and nRF Master Control Panel"

Ivan if you have any success with this could you let me know how you did it?

Thanks,
Kurt
