Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 25 Jan 2017 17:20:14 +0000
From: Dario Teixeira <dario.teixeira@nleyten.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: LEAdvertisement interface on older kernels
In-Reply-To: <CAGXr9JE85t=__QUuxLO3fH_=9A=4kyN4KC2wXCALjFy8DOqerQ@mail.gmail.com>
References: <e40dc0a21f7080547028dfb7dad6eb65@nleyten.com>
 <b2bd7735f166b59b11369eb37d0b4d75@nleyten.com>
 <CAGXr9JE85t=__QUuxLO3fH_=9A=4kyN4KC2wXCALjFy8DOqerQ@mail.gmail.com>
Message-ID: <e8cc30e59a3e30aa399fa41cf2c76b92@nleyten.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> If you have access to Artik 5 kernel 3.10.93 source, you could:
> 1. recompile that kernel with all Bluetooth components disabled
> 2. use Linux backports to pick up the latest Bluetooth kernel core and
> drivers as a loadable module
>     http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/

Thanks for the suggestion! I have compiled Backports 4.4.2-1 against
the Artik 5 kernel 3.10.93, and tried to run my application using
Bluez 5.43.  It does advance further than before, but the Bluetooth
daemon dies when I try to register a BLE advertisement (see the log
below).  Moreover, on the phone side I am able to see the newly
registered service, though I am of course unable to connect to it.

Note that running lsmod confirms that the backported BT modules
are loaded instead of their 3.10.93 counterparts.

Anyway, do you reckon this issue is fixable, or should I instead
shift my efforts to BT Classic?

Thanks in advance for your attention!
Best regards,
Dario Teixeira


Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/gatt-database.c:manager_register_app() Registering application: 
:1.14:/com/company/app
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/gatt-database.c:proxy_added_cb() Object received: 
/com/company/app/svc0, iface: org.bluez.GattService1
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/gatt-database.c:proxy_added_cb() Object received: 
/com/company/app/svc0/chr0, iface: org.bluez.GattCharacteristic1
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/gatt-database.c:proxy_added_cb() Object received: 
/com/company/app/svc0/chr1, iface: org.bluez.GattCharacteristic1
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/gatt-database.c:gatt_db_service_added() GATT Service added to local 
database
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/gatt-database.c:client_ready_cb() GATT application registered: 
:1.14:/com/company/app
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:register_advertisement() RegisterAdvertisement
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:advertisement_create() Adding proxy for 
/com/company/app/adv0
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:register_advertisement() Registered advertisement at 
path /com/company/app/adv0
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:parse_advertising_service_uuids() Adding ServiceUUID: 
b228c495-11be-4f20-9b7b-a93e2f4cf380
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:refresh_advertisement() Refreshing advertisement: 
/com/company/app/adv0
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:parse_advertising_service_uuids() Adding ServiceUUID: 
b228c495-11be-4f20-9b7b-a93e2f4cf380
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:refresh_advertisement() Refreshing advertisement: 
/com/company/app/adv0
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:parse_advertising_service_uuids() Adding ServiceUUID: 
b228c495-11be-4f20-9b7b-a93e2f4cf380
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:refresh_advertisement() Refreshing advertisement: 
/com/company/app/adv0
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:parse_advertising_service_uuids() Adding ServiceUUID: 
b228c495-11be-4f20-9b7b-a93e2f4cf380
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:refresh_advertisement() Refreshing advertisement: 
/com/company/app/adv0
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:add_advertising_callback() Advertisement registered: 
/com/company/app/adv0
Jan 22 14:30:32 localhost bluetoothd[2249]: 
src/advertising.c:add_advertising_callback() Advertisement registered: 
/com/company/app/adv0
Jan 22 14:30:32 localhost bluetoothd[2249]: process 2249: arguments to 
dbus_message_new_method_return() were incorrect, assertion "method_call 
!= NULL" failed in file dbus-message.c line 1378.
Jan 22 14:30:32 localhost bluetoothd[2249]: This is normally a bug in 
some application using the D-Bus library.
Jan 22 14:30:32 localhost bluetoothd[2249]: D-Bus not built with 
-rdynamic so unable to print a backtrace
Jan 22 14:30:32 localhost systemd[1]: bluetooth.service: main process 
exited, code=dumped, status=6/ABRT
Jan 22 14:30:32 localhost systemd[1]: Unit bluetooth.service entered 
failed state.
Jan 22 14:30:32 localhost systemd[1]: bluetooth.service failed.
Jan 22 14:30:33 localhost systemd-coredump[2373]: Process 2249 
(bluetoothd) of user 0 dumped core.
                                                   Stack trace of thread 
2249:
                                                   #0  0x00000000b6c176f0 
raise (libc.so.6)

