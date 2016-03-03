Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160302204223.GA18853@kurtmc.Eroad.local>
References: <CAHrp-j-pSj5kymb95W7dKPgqcq8eyvf_QzuwK2zaziDcOErTaA@mail.gmail.com>
	<CAHrp-j9Ovv1MoFiChU8EmKardboBo2G5QZQTKTRm+4yHfX-5gw@mail.gmail.com>
	<CABBYNZKb3h9d6FMGxewhS=WyZ25t9BcRDzrYaNVM=CcJzDkMEA@mail.gmail.com>
	<20160302204223.GA18853@kurtmc.Eroad.local>
Date: Thu, 3 Mar 2016 11:34:04 +0200
Message-ID: <CABBYNZLnvwa5Xa=cg1eNdppJHynPj+HZChrmVAS52HCk49zmTw@mail.gmail.com>
Subject: Re: GATT server example issues in BlueZ
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Kurt McAlpine <kurt@linux.com>
Cc: Ivan Deviatkin <devyatkin.ivan@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kurt, Ivan,

On Wed, Mar 2, 2016 at 10:42 PM, Kurt McAlpine <kurt@linux.com> wrote:
> Hi Luiz,
>
> I too am having some with BlueZ 5.37 from git (I pulled today).
>
> On Wed, Mar 02, 2016 at 03:50:50PM +0200, Luiz Augusto von Dentz wrote:
>> Hi Ivan,
>>
>> On Wed, Mar 2, 2016 at 1:16 PM, Ivan Deviatkin <devyatkin.ivan@gmail.com> wrote:
>> >     Additionally I have checked python example "example-gatt-server"
>> > from \tests - it reports that GATT server is running but in bluetoothd
>> > logs still the same issue.
>>
>> So you don't see something like this:
>>
>>
>> ./example-gatt-server
>> GetManagedObjects
>> GATT application registered
>>
>> bluetoothd[16205]: src/gatt-database.c:manager_register_app()
>> Registering application: :1.603:/
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service0, iface: org.bluez.GattService1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service0/char0, iface:
>> org.bluez.GattCharacteristic1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service0/char1, iface:
>> org.bluez.GattCharacteristic1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service0/char2, iface:
>> org.bluez.GattCharacteristic1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service1, iface: org.bluez.GattService1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service1/char0, iface:
>> org.bluez.GattCharacteristic1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service2, iface: org.bluez.GattService1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service2/char0, iface:
>> org.bluez.GattCharacteristic1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service2/char0/desc0, iface:
>> org.bluez.GattDescriptor1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service2/char0/desc1, iface:
>> org.bluez.GattDescriptor1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service2/char1, iface:
>> org.bluez.GattCharacteristic1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service2/char1/desc2, iface:
>> org.bluez.GattDescriptor1
>> bluetoothd[16205]: src/gatt-database.c:proxy_added_cb() Object added:
>> path: /org/bluez/example/service2/char1/desc3, iface:
>> org.bluez.GattDescriptor1
>> bluetoothd[16205]: src/gatt-database.c:database_add_ccc() Created CCC
>> entry for characteristic
>> bluetoothd[16205]: src/gatt-database.c:gatt_db_service_added() GATT
>> Service added to local database
>> bluetoothd[16205]: src/gatt-database.c:database_add_ccc() Created CCC
>> entry for characteristic
>> bluetoothd[16205]: src/gatt-database.c:gatt_db_service_added() GATT
>> Service added to local database
>> bluetoothd[16205]: src/gatt-database.c:cep_write_cb() Stored CEP value
>> in the database
>> bluetoothd[16205]: src/gatt-database.c:database_add_cep() Created CEP
>> entry for characteristic
>> bluetoothd[16205]: src/gatt-database.c:cep_write_cb() Stored CEP value
>> in the database
>> bluetoothd[16205]: src/gatt-database.c:database_add_cep() Created CEP
>> entry for characteristic
>> bluetoothd[16205]: src/gatt-database.c:gatt_db_service_added() GATT
>> Service added to local database
>> bluetoothd[16205]: src/gatt-database.c:client_ready_cb() GATT
>> application registered: :1.603:/
>
> I do see this but my android device cannot discover the GATT service within the
> app. It is possible to pair with it, but not discover the services or even the
> device within the app.
>
> I've tired "Bluetooth LE Scanner" and nRF Master Control Panel"
>
> Ivan if you have any success with this could you let me know how you did it?

Do you guys remember that you have to advertise to be able to connect:

< HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
            [hci0] 686245.066488
        Length: 30
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 2 entries
          Heart Rate (0x180d)
          Battery Service (0x180f)
        Company: internal use (65535)
          Data: 0001020304
        Service Data (UUID 0x9999): 0001020304
        TX power: 9 dBm
> HCI Event: Command Complete (0x0e) plen 4                                        [hci0] 686245.139564
      LE Set Advertising Data (0x08|0x0008) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Response Data (0x08|0x0009) plen 32
            [hci0] 686245.139585
        Length: 0
> HCI Event: Command Complete (0x0e) plen 4                                        [hci0] 686245.140582
      LE Set Scan Response Data (0x08|0x0009) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15
            [hci0] 686245.140628
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Type: Connectable undirected - ADV_IND (0x00)
        Own address type: Public (0x00)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect
Request from Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                        [hci0] 686245.141553
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
            [hci0] 686245.141563
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                        [hci0] 686245.142554
      LE Set Advertise Enable (0x08|0x000a) ncmd 2
        Status: Success (0x00)

Even with this I couldn't manage to connect using Android, even though
it can find it but there is nothing set as a name (possible a bug in
our end), if I do enable BR/EDR than it attempts to connect over it
(priceless!) instead of LE where it got the advertisement.

-- 
Luiz Augusto von Dentz
