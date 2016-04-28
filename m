Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1652441.2JLkvHx8SP@leonov>
References: <CANOVzkvjtOHnF0ZLTU5w2ivH-nFDPdF47jcufo0Jh30UyF0P7g@mail.gmail.com>
	<CAArnnE5cwo504igThLOda9unUPktHvar+ePG+F7fseeHSr_4Zg@mail.gmail.com>
	<1652441.2JLkvHx8SP@leonov>
Date: Thu, 28 Apr 2016 13:38:12 +0900
Message-ID: <CAArnnE5HnDSF=08R9z7S7V0pHjS6u1iW56LLAAgAeOAYYzU84g@mail.gmail.com>
Subject: Re: Not shown registered gatt services on an android 5.1.1
From: Hyuntak Lee <pphdev12@gmail.com>
To: Szymon Janc <ext.szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Janc.

2016-04-15 19:25 GMT+09:00 Szymon Janc <ext.szymon.janc@tieto.com>:
> Hi,
>
> On Friday 15 of April 2016 16:36:32 Hyuntak Lee wrote:
>> 2016-04-15 15:48 GMT+09:00 King so <sok02074@gmail.com>:
>> > Hi Tak,
>> >
>> > I also have the same problem. (Central is iPhone, Peripheral is Raspberry
>> > pi)
>> >
>> > Did you resolve it?
>> >
>> > Thanks for your time
>>
>> Hi King,
>>
>> I didn`t find any solution or workaround yet.
>>
>> So I'm waiting for a reply from the bluez team.
>>
>
> This is due to Android connecting over BR/EDR for dualmode devices.
> (this is the reason you had to enable pscan to make it connect).
>
> To workaround this:
> tools/btmgmt power off
> tools/btmgmt bredr off
> tools/btmgmt power on
>
> Unpair device on Android phone and toggle BT off/on on the phone.
> After that it should work OK.
>
> Also please DONT'T use hcitool for enabling advertising.
> Use advertisement API  (just start ./test/example-advertisement)
>
> Not having registered GATT services over BR/EDR is something we need to work
> on (or disable GATT over BR/EDR).
>

Thanks very much for your reply,

I checked to get gatt services by a Android mobile device.

These are my step:
env - kernel 4.1, bluez-5.39

1. Set 'ControllerMode = le' to '/etc/bluetooth/main.conf'
2. restart bluetoothd
3. executes 'test/example-advertisement'
4. executes 'test/example-gatt-server'

Best regards,
Tak

>
>
>> Best Regards,
>> Tak
>>
>> > 2016-04-08 11:54 GMT+09:00 Hyuntak Lee <pphdev12@gmail.com>:
>> >> Hi Luiz,
>> >>
>> >> 2016-04-07 21:17 GMT+09:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>> >>> Hi Tak,
>> >>>
>> >>> On Thu, Apr 7, 2016 at 2:20 PM, Hyuntak Lee <pphdev12@gmail.com> wrote:
>> >>>> Dears,
>> >>>>
>> >>>> I am testing a gatt server with iphone and android.
>> >>>> iPhone is working nicely, but unfortunately andorid cannot retrive
>> >>>> registered GATT services.
>> >>>> I tested with a bluez-5.39/test/example-gatt-server file.
>> >>>> Can you advice me?
>> >>>>
>> >>>> My step is below:
>> >>>>
>> >>>> * Peripheral env
>> >>>> ** Bluez 5.39
>> >>>> ** Linux Kernel 3.18
>> >>>> ** BT Dongle: NEXT-204BT(CSR 4.0)
>> >>>>
>> >>>> * Central env
>> >>>> ** Android 5.1.1 and iOS 9.3.1
>> >>>> ** Test app: nRF MCP
>> >>>>
>> >>>> * Build configure
>> >>>> ./configure --prefix=/usr     \
>> >>>>
>> >>>>             --sysconfdir=/etc    \
>> >>>>             --localstatedir=/var \
>> >>>>             --enable-library      \
>> >>>>             --enable-experimental \
>> >>>>             --disable-systemd
>> >>>>
>> >>>> * STEP
>> >>>> 1. Executes a bluetooth daemon:
>> >>>> $ bluetoothd -ndE
>> >>>>
>> >>>> 2. Register gatt services
>> >>>> $ python bluez-5.39/test/example-gatt-server
>> >>>> For register service(Heart Rate, Battery Service)
>> >>>>
>> >>>> 3. To advertising and pairing:
>> >>>> $ hciconfig hci0 reset
>> >>>> $ hciconfig hci0 pscan;   # PSCAN need to pair with android
>> >>>> $ hcitool -i hci0 cmd 0x08 0x000a 00;
>> >>>> $ hcitool -i hci0 cmd 0x08 0x0008 03 02 0a 0a 00 00 00 00 00 00 00 00
>> >>>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00;
>> >>>> $ hcitool -i hci0 cmd 0x08 0x000a 01;
>> >>>>
>> >>>> 4. connect to gatt server
>> >>>> 4.1 with iOS 9.3.1
>> >>>> Retrieved list
>> >>>> - Heart Rate (UUID: 0x180D)
>> >>>> - Battery Service (UUID: 0x180F)
>> >>>>
>> >>>> 4.2 with android 5.1.1
>> >>>> Retrieved list
>> >>>> - Generic Attribute(UUID: 0x1801)
>> >>>> - Generic Access(UUID: 0x1800)
>> >>>>
>> >>>>
>> >>>>
>> >>>> Only android don't get registerted services.
>> >>>> I founded different part of bluetoothd log in the case of iphone and
>> >>>> android. I hope these are helpful to you.
>> >>>>
>> >>>> Logs of iOS case:
>> >>>>
>> >>>> bluetoothd[2976]: src/gatt-database.c:connect_cb() New incoming LE ATT
>> >>>> connection
>> >>>> bluetoothd[2976]: attrib/gattrib.c:g_attrib_ref() 0x1e53230:
>> >>>> g_attrib_ref=1
>> >>>> bluetoothd[2976]: src/gatt-client.c:btd_gatt_client_connected() Device
>> >>>> connected.
>> >>>> bluetoothd[2976]: src/device.c:load_gatt_db() Restoring
>> >>>> 57:92:97:B5:A8:C4 gatt database from file
>> >>>> bluetoothd[2976]: No cache for 57:92:97:B5:A8:C4
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() MTU exchange complete, with
>> >>>> MTU: 158 bluetoothd[2976]: src/device.c:gatt_debug() Read By Grp Type
>> >>>> - start: 0x0001 end: 0xffff
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() Read By Grp Type - start:
>> >>>> 0x0021 end: 0xffff
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() Read By Type - start:
>> >>>> 0x0006 end: 0x0009
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() Find Info - start: 0x0009
>> >>>> end: 0x0009
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() Write Req - handle: 0x0009
>> >>>> bluetoothd[2976]: src/gatt-database.c:gatt_ccc_write_cb() CCC write
>> >>>> called for handle: 0x0009
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() Primary services found: 8
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0001, end:
>> >>>> 0x0005, uuid: 00001800-0000-1000-8000-00805f9b34fb
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0006, end:
>> >>>> 0x0009, uuid: 00001801-0000-1000-8000-00805f9b34fb
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() start: 0x000a, end:
>> >>>> 0x000e, uuid: d0611e78-bbb4-4591-a5f8-487910ae4366
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() start: 0x000f, end:
>> >>>> 0x0012, uuid: 0000180f-0000-1000-8000-00805f9b34fb
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0013, end:
>> >>>> 0x0018, uuid: 00001805-0000-1000-8000-00805f9b34fb
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0019, end:
>> >>>> 0x001d, uuid: 0000180a-0000-1000-8000-00805f9b34fb
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() start: 0x001e, end:
>> >>>> 0x0027, uuid: 7905f431-b5ce-4e99-a40f-4b1e122d00d0
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0028, end:
>> >>>> 0x0033, uuid: 89d3502b-0f36-433a-8ef4-c502ad55f8dc
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() Secondary service
>> >>>> discovery failed. ATT ECODE: 0x0a
>> >>>>
>> >>>> Logs of android case:
>> >>>>
>> >>>> bluetoothd[2976]: src/gatt-database.c:connect_cb() New incoming LE ATT
>> >>>> connection
>> >>>> bluetoothd[2976]: attrib/gattrib.c:g_attrib_ref() 0x1e35fe8:
>> >>>> g_attrib_ref=1
>> >>>> bluetoothd[2976]: src/gatt-client.c:btd_gatt_client_connected() Device
>> >>>> connected.
>> >>>> bluetoothd[2976]: src/device.c:load_gatt_db() Restoring
>> >>>> 30:75:12:94:47:D5 gatt database from file
>> >>>> bluetoothd[2976]: No cache for 30:75:12:94:47:D5
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() MTU Exchange failed. ATT
>> >>>> ECODE: 0x06>>>
>> >>> We did have some problems with Android up to 4.4 when Android would
>> >>> stop sending any request when it gets a MTU Exchange but this has been
>> >>> working with 5.1 and later so Im not sure if this is related. You can
>> >>> check if that is the case with the following patch:
>> >>> http://www.spinics.net/lists/linux-bluetooth/msg66498.html (I end up
>> >>> abandoning it since it was supposed to work with more recent
>> >>> Androids).
>> >>
>> >> Thanks for your reply.
>> >>
>> >> As a result, Android still cannot find primary services.
>> >> I compared a bluez-5.39 source with
>> >> http://www.spinics.net/lists/linux-bluetooth/msg66498.html
>> >> It seemed not applied to 5.39. so, I edited a source and recompiled
>> >> and try again.
>> >>
>> >> Logs:
>> >> bluetoothd[18338]: src/gatt-client.c:btd_gatt_client_connected()
>> >> Device connected.
>> >> bluetoothd[18338]: src/device.c:load_gatt_db() Restoring
>> >> 30:75:12:94:47:D5 gatt database from file
>> >> bluetoothd[18338]: No cache for 30:75:12:94:47:D5
>> >> bluetoothd[18338]: src/device.c:gatt_debug() Primary services found: 2
>> >> bluetoothd[18338]: src/device.c:gatt_debug() start: 0x0001, end:
>> >> 0x0005, uuid: 00001801-0000-1000-8000-00805f9b34fb
>> >> bluetoothd[18338]: src/device.c:gatt_debug() start: 0x0014, end:
>> >> 0xffff, uuid: 00001800-0000-1000-8000-00805f9b34fb
>> >> bluetoothd[18338]: src/device.c:gatt_debug() Secondary service
>> >> discovery failed. ATT ECODE: 0x10
>> >>
>> >> Log is changed, do not show 'MTU Exchange failed. ATT ECODE: 0x06'
>> >> message.
>> >> But, still not discover all primary services. Not shown a log message
>> >> like this "Read By Grp Type - start: 0x0001 end: 0xffff"
>> >>
>> >> Can you advice me?
>> >>
>> >> Best Regards,
>> >> Tak
>> >>
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() Primary services found: 2
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0001, end:
>> >>>> 0x0005, uuid: 00001801-0000-1000-8000-00805f9b34fb
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() start: 0x0014, end:
>> >>>> 0xffff, uuid: 00001800-0000-1000-8000-00805f9b34fb
>> >>>> bluetoothd[2976]: src/device.c:gatt_debug() Secondary service
>> >>>> discovery failed. ATT ECODE: 0x10
>> >>>>
>> >>>>
>> >>>> It looks like if request is from an android, cannot find primary
>> >>>> services.
>> >>>> How can I use a GATT service with an android?
>> >>>> Pls advise me.
>> >>>>
>> >>>> Best Regards,
>> >>>> Tak
>> >>>> --
>> >>>> To unsubscribe from this list: send the line "unsubscribe
>> >>>> linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
>> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>>
>> >>> --
>> >>> Luiz Augusto von Dentz
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> BR
> Szymon Janc
