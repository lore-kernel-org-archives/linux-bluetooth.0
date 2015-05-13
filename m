Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BD5E516FF3711A41B93DC005170007BB010D943FDCC9@EMBSVR01.ember.local>
References: <BD5E516FF3711A41B93DC005170007BB010D943FDCC9@EMBSVR01.ember.local>
Date: Wed, 13 May 2015 16:04:57 +0300
Message-ID: <CABBYNZJSZ=2e-sAD2f=01z0jVR4ackd3xoNO1YpVXR9stv6xzQ@mail.gmail.com>
Subject: Re: Issue with registering GATT Services
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ankur Patel <ankur@embertec.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankur,

On Wed, May 13, 2015 at 12:39 PM, Ankur Patel <ankur@embertec.com> wrote:
> Hi Folks,
>
> I am having issues with registering GATT services successfully on the device.
> Using: Linux Kernel: 3.18.12 Bluez: 5.30
>
> Step1> Build Bluez5.30 with --enable-experimental and --enable-maintainer-mode.
> Step2> Ran Bluetoothd with -E option as below:
> root@imx28evk:~ # /usr/lib/bluez5/bluetooth/bluetoothd -d -n -E &
> Output:
>         http://pastebin.com/eALijggh
> Snippet:
> ...
> bluetoothd[462]: src/gatt-database.c:gatt_db_service_added() GATT Service added to local database
> bluetoothd[462]: src/advertising.c:btd_advertising_manager_new() LE Advertising Manager created for adapter: /org/bluez/hci0
> bluetoothd[462]: profiles/audio/a2dp.c:media_server_probe() path /org/bluez/hci0
> bluetoothd[462]: plugins/hostname.c:hostname_probe()
> bluetoothd[462]: Not enough free handles to register service
> bluetoothd[462]: plugins/gatt-example.c:gatt_example_adapter_probe() Battery service could not be registered
> bluetoothd[462]: gatt-example-adapter-driver: Input/output error (5)    // Not sure if this restricts GATT Service to be registered
> ...
> bluetoothd[462]: src/adapter.c:new_settings_callback() Settings: 0x000026f0
> bluetoothd[462]: src/adapter.c:settings_changed() Changed settings: 0x0000000a
>
> Step3> Ran gatt-service:
> root@imx28evk:~/tools# ./gatt-service
> gatt-service unique name: :1.4
> Registered service: /service1
> Get UUID: 00001802-0000-1000-8000-00805f9b34fb
> Exist Includes: 00001802-0000-1000-8000-00805f9b34fb
> Characteristic(00002a06-0000-1000-8000-00805f9b34fb): Get("Value")
> Descriptor(8260c653-1a54-426b-9e36-e84c238bc669): Get("Value")
> RegisterService: Method "RegisterService" with signature "oa{sv}" on interface "org.bluez.GattManager1" doesn't exist
>
> I am using the Dbus config from http://git.kernel.org/cgit/bluetooth/bluez.git/tree/src/bluetooth.conf.
>
> Any idea why it fails to register the service? Do I need to enable other features or if there is any missing steps?

It should work if you have -E, but perhaps something else is not the
correct, like the path, etc. Btw, we do have an example here:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test/example-gatt-server

-- 
Luiz Augusto von Dentz
