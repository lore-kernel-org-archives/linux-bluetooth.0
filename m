Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_89eaf6877e97e1012613e971c29ed285"
Date: Fri, 21 Apr 2017 19:22:57 +0200
From: Olivier MARTIN <olivier@labapart.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: GATT Server: DBus GATT Services not advertised/exported
In-Reply-To: <CABBYNZK-2xr2n6B_JCD7uXkvHPLDsj5N-3Md=w6J_JUO7VXP7Q@mail.gmail.com>
References: <1b8c74ef5fafaca3c75fb87249d728f8@labapart.com>
 <CAAu3APaR4weHx=63JFbaQNK5kQmCEm3LHg6mPhFe7NQ9aW4Cvg@mail.gmail.com>
 <1c0a0d7a4270d7dcb457523e8fbbc244@labapart.com>
 <CAAu3APYtfEsmu4WREo=V=VtgxCd3tjj0+1J4HcqD0asN8boOxg@mail.gmail.com>
 <7e78e5e8a8340ee2b459d0cd2f645712@labapart.com>
 <CAAu3APbUAnKX_RD3R8TbXmhuUpz-G4fPj5tk=2HOUTVYXJ-Y5w@mail.gmail.com>
 <a43ea6310f8292d7d5c053a7ab027fec@labapart.com>
 <CAAu3APaxi82L56NNEnpZP4o+Z99qE_aGcAzGRJFOe+j0N_8irA@mail.gmail.com>
 <122bd75a159578eee407a7ff2497fe68@labapart.com>
 <CABBYNZK-2xr2n6B_JCD7uXkvHPLDsj5N-3Md=w6J_JUO7VXP7Q@mail.gmail.com>
Message-ID: <41224d662168869945fd6aa262ba23df@labapart.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=_89eaf6877e97e1012613e971c29ed285
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

Hi Luiz,
after doing more investigation, I think the slow down comes from some 
incompatibilities between Bluez v5.44 and the Linux kernel distributed 
with Ubuntu 16.04 (ie: 4.4.0-72).

Android can discover the GATT services of Bluez's v5.37 
'./tests/example-gatt-server' with bluez v5.37 distributed by Ubuntu 
16.04 under a second.

FYI, I attached 'btmon.log' that is the result of 'btmon' when I had the 
slowdown with Android 5.1.

Thanks,
Olivier

On 20.04.2017 13:31, Luiz Augusto von Dentz wrote:
> Hi Oliver,
> 
> On Thu, Apr 20, 2017 at 2:20 AM, Olivier MARTIN <olivier@labapart.com> 
> wrote:
>> I am back on the thread.
>> What I noticed last week when I tried on Android phone with both "BLE
>> Scanner" and "Nordic Connect", discovering GATT services is really 
>> really
>> slow (it takes 2 min to discover all `example-gatt-server` GATT 
>> services) on
>> Nexus 4 with Android 5.1.1 and Ubuntu 16.04 with Bluez v5.44 for the 
>> GATT
>> server. I am using the Asus USB-BT400 (Broadcom chipset).
>> 
>> I did more investigation this evening but I have not done any 
>> progress.
>> I tried with `example-gatt-server` started by the user and root and no
>> change in the poor performance.
>> 
>> I do not know what is taking so long but for instance it takes many 
>> seconds
>> to execute this part:
>> 
>> bluetoothd[12913]: src/device.c:gatt_debug() Read By Type - start: 
>> 0x005e
>> end: 0x0061
>> bluetoothd[12913]: src/device.c:gatt_debug() Read By Type - start: 
>> 0x0060
>> end: 0x0061
>> bluetoothd[12913]: src/device.c:gatt_debug() Find Info - start: 0x0061 
>> end:
>> 0x0061
>> bluetoothd[12913]: src/device.c:gatt_debug() Read By Type - start: 
>> 0x0062
>> end: 0x0071
>> bluetoothd[12913]: src/device.c:gatt_debug() Read By Type - start: 
>> 0x0062
>> end: 0x0071
>> bluetoothd[12913]: src/device.c:gatt_debug() Read By Type - start: 
>> 0x006e
>> end: 0x0071
>> bluetoothd[12913]: src/device.c:gatt_debug() Find Info - start: 0x0065 
>> end:
>> 0x0067
>> bluetoothd[12913]: src/device.c:gatt_debug() Find Info - start: 0x0066 
>> end:
>> 0x0067
>> bluetoothd[12913]: src/device.c:gatt_debug() Find Info - start: 0x0067 
>> end:
>> 0x0067
>> bluetoothd[12913]: src/device.c:gatt_debug() Find Info - start: 0x006a 
>> end:
>> 0x006c
>> bluetoothd[12913]: src/device.c:gatt_debug() Find Info - start: 0x006b 
>> end:
>> 0x006c
>> bluetoothd[12913]: src/device.c:gatt_debug() Find Info - start: 0x006c 
>> end:
>> 0x006c
>> bluetoothd[12913]: src/device.c:gatt_debug() Find Info - start: 0x006f 
>> end:
>> 0x0071
>> bluetoothd[12913]: src/device.c:gatt_debug() Find Info - start: 0x0070 
>> end:
>> 0x0071
>> bluetoothd[12913]: src/device.c:gatt_debug() Find Info - start: 0x0071 
>> end:
>> 0x0071
>> bluetoothd[12913]: src/device.c:gatt_debug() Read By Type - start: 
>> 0x0072
>> end: 0x0079
>> bluetoothd[12913]: src/device.c:gatt_debug() Read By Type - start: 
>> 0x0072
>> end: 0x0079
>> bluetoothd[12913]: src/device.c:gatt_debug() Read By Type - start: 
>> 0x0079
>> end: 0x0079
>> bluetoothd[12913]: src/device.c:gatt_debug() Find Info - start: 0x0077 
>> end:
>> 0x0077
> 
> You should be able to see their timings in HCI with btmon, or just use
> journalctl if are thinking there is a delay in processing the packets
> but I think that is not the case. These many Find Info does indeed
> looks odd, and there are even repeated range.
> 
>> 
>> 
>> 
>> On 14.04.2017 20:31, Barry Byford wrote:
>>> 
>>> Hello Olivier,
>>> 
>>> On 14 April 2017 at 19:14, Olivier MARTIN <olivier@labapart.com> 
>>> wrote:
>>>> 
>>>> Thanks Barry, setting 'ControllerMode = le' in 
>>>> /etc/bluetooth/main.conf
>>>> fixed my issue. I can now see the GATT services.
>>> 
>>> 
>>> Good news!
>>> 
>>>> But I guess my adapter now only works as BLE adapter and will ignore 
>>>> the
>>>> non-LE devices.
>>>> In the comment of /etc/bluetooth/main.conf it is written the adapter
>>>> should
>>>> be by default set as 'dual'.
>>>> 
>>>> Is it a bug in Bluez? Why GATT services are not exposed while using 
>>>> the
>>>> default value for 'ControllerMode'?
>>> 
>>> 
>>> This issue has come up before and was discuss here:
>>> http://marc.info/?l=linux-bluetooth&m=146071596012263&w=2
>>> 
>>> 
>>> 
>>> 
>>>> On 14.04.2017 14:30, Barry Byford wrote:
>>>>> 
>>>>> 
>>>>> Hello Olivier,
>>>>> 
>>>>> 
>>>>> On 14 April 2017 at 12:01, Olivier MARTIN <olivier@labapart.com> 
>>>>> wrote:
>>>>>> 
>>>>>> 
>>>>>> You are right Barry, `example-advertisement` seems to work well (I
>>>>>> installed
>>>>>> and tried Nordic nRF Connect and I can see the expected 
>>>>>> advertisemet
>>>>>> data).
>>>>> 
>>>>> 
>>>>> 
>>>>> Excellent!
>>>>> 
>>>>> 
>>>>>> But I cannot still manage to get `example-gatt-server` :-(
>>>>>> I am sure I got it working last year with an older version of 
>>>>>> Bluez.
>>>>>> But
>>>>>> I
>>>>>> cannot make it work with Bluez v5.44.
>>>>> 
>>>>> 
>>>>> 
>>>>> OK, I've taken a look at "example-gatt-server" and have it 
>>>>> working...
>>>>> 
>>>>>> 
>>>>>> My testing procedure:
>>>>>> 
>>>>>> 1. [Laptop] First terminal: Start `sudo ./src/bluetoothd -E -n -d`
>>>>>> 2. [Laptop] Second terminal: Start unmodified Bluez
>>>>>> ./test/example-gatt-server
>>>>>> 3. [Laptop] Third terminal: Ensure the adapter is "Powered: yes" 
>>>>>> and
>>>>>> "Discoverable: yes"
>>>>> 
>>>>> 
>>>>> 
>>>>> OK, I've done this slightly different (details below). However, the
>>>>> first thing I did was edit "/etc/bluetooth/main.conf"
>>>>> I added the following line to the end of the file:
>>>>> 
>>>>> ControllerMode = le
>>>>> 
>>>>> Then I did the following:
>>>>> 1. [SBC1:T1] sudo ./src/bluetoothd -E -n -d
>>>>> 2. [SBC1:T2] ./example-gatt-server
>>>>> 3. [SBC1:T3] ./example-advertisement
>>>>> 
>>>>> 
>>>>>> 
>>>>>> 4. [Android] Connect using Nordic nRF Connect (I also tried with 
>>>>>> "BLE
>>>>>> Scanner") and check I see the exposed GATT services by
>>>>>> `example-gatt-server`
>>>>>> Unfortunately, I can only see:
>>>>>> - Generic Access Service (0x1800)
>>>>>> - Generic Attribute Service (0x1801)
>>>>>> 
>>>>> 
>>>>> I've used bluetoothctl on SBC2 to connect and read the battery 
>>>>> values
>>>>> that the GATT server is counting down.
>>>>> 
>>>>> $ bluetoothctl
>>>>> [NEW] Controller 00:00:00:00:5A:AD linaro-alip [default]
>>>>> [bluetooth]# scan on
>>>>> Discovery started
>>>>> [CHG] Controller 00:00:00:00:5A:AD Discovering: yes
>>>>> [NEW] Device B8:27:EB:22:57:E0 BluezeroLight
>>>>> [bluetooth]# scan off
>>>>> Discovery stopped
>>>>> [CHG] Controller 00:00:00:00:5A:AD Discovering: no
>>>>> [bluetooth]# connect B8:27:EB:22:57:E0
>>>>> Attempting to connect to B8:27:EB:22:57:E0
>>>>> [CHG] Device B8:27:EB:22:57:E0 Connected: yes
>>>>> Connection successful
>>>>> [...snip...]
>>>>> [NEW] Primary Service
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a
>>>>> 0000180f-0000-1000-8000-00805f9b34fb
>>>>> Battery Service
>>>>> [NEW] Characteristic
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a/char000b
>>>>> 00002a19-0000-1000-8000-00805f9b34fb
>>>>> Battery Level
>>>>> [...snip...]
>>>>> [CHG] Device B8:27:EB:22:57:E0 ServicesResolved: yes
>>>>> [BluezeroLight]# select-attribute
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a/char000b
>>>>> [BluezeroLight:/service000a/char000b]# read
>>>>> Attempting to read
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a/char000b
>>>>> [CHG] Attribute
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a/char000b Value: 
>>>>> 0x46
>>>>>   46                                               F
>>>>> [BluezeroLight:/service000a/char000b]# notify on
>>>>> [CHG] Attribute
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a/char000b 
>>>>> Notifying:
>>>>> yes
>>>>> Notify started
>>>>> [CHG] Attribute
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a/char000b Value: 
>>>>> 0x46
>>>>> [CHG] Attribute
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a/char000b Value: 
>>>>> 0x44
>>>>> [CHG] Attribute
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a/char000b Value: 
>>>>> 0x42
>>>>> [CHG] Attribute
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a/char000b Value: 
>>>>> 0x40
>>>>> [CHG] Attribute
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a/char000b Value: 
>>>>> 0x3e
>>>>> [BluezeroLight:/service000a/char000b]# notify off
>>>>> [CHG] Attribute
>>>>> /org/bluez/hci0/dev_B8_27_EB_22_57_E0/service000a/char000b 
>>>>> Notifying:
>>>>> no
>>>>> Notify stopped
>>>>> 
>>>>> 
>>>>> That seems to be working then. When I didn't have "ControllerMode =
>>>>> le" set then I did see it be unpredictable if it successfully
>>>>> connected or not.
>>>>> This also worked connecting with the nRF app.
>>>>> 
>>>>> 
>>>>> Does that work for you?
>>>>> 
>>>>> 
>>>>> 
>>>>> 
>>>>>> If I had to suspect Bluez code, I will guess there is something 
>>>>>> missing
>>>>>> around here:
>>>>>> 
>>>>>> bluetoothd[20429]: src/device.c:gatt_server_init() # 
>>>>>> gatt_server_init
>>>>>> bluetoothd[20429]: src/device.c:gatt_debug() Primary services 
>>>>>> found: 2
>>>>>> bluetoothd[20429]: src/device.c:gatt_debug() start: 0x0001, end:
>>>>>> 0x0005,
>>>>>> uuid: 00001801-0000-1000-8000-00805f9b34fb
>>>>>> bluetoothd[20429]: src/device.c:gatt_debug() start: 0x0014, end:
>>>>>> 0xffff,
>>>>>> uuid: 00001800-0000-1000-8000-00805f9b34fb
>>>>>> bluetoothd[20429]: src/device.c:gatt_debug() Registered handler 
>>>>>> for
>>>>>> "Service
>>>>>> Changed": 0
>>>>>> bluetoothd[20429]: src/device.c:gatt_client_ready_cb() status: 
>>>>>> success,
>>>>>> error: 0
>>>>>> 
>>>>>> As Bluez daemon does not get the GATT services from Buez GATT 
>>>>>> Database.
>>>>>> But
>>>>>> it might be me who miss a step...
>>>>>> 
>>>>>> 
>>>>>> On 14.04.2017 12:37, Barry Byford wrote:
>>>>>>> 
>>>>>>> 
>>>>>>> 
>>>>>>> example-advertisementHello Oliver,
>>>>>>> 
>>>>>>> 
>>>>>>> On 14 April 2017 at 11:03, Olivier MARTIN <olivier@labapart.com>
>>>>>>> wrote:
>>>>>>>> 
>>>>>>>> 
>>>>>>>> 
>>>>>>>> Thanks for replying my message Barry,
>>>>>>>> 
>>>>>>>> Sorry, I forgot to mention but I start Bluez daemon with `sudo
>>>>>>>> ./src/bluetoothd -E -n -d` (after stopping the bluetooth 
>>>>>>>> service). So
>>>>>>>> I
>>>>>>>> already run it with sudo and experimental option.
>>>>>>>> 
>>>>>>>> I am not sure to understand what you mean by "this kind of error
>>>>>>>> message".
>>>>>>>> Because I do not see any error message in the log I provided.
>>>>>>> 
>>>>>>> 
>>>>>>> 
>>>>>>> 
>>>>>>> OK, that was bad on my part. I read it as complaining that there 
>>>>>>> were
>>>>>>> too many advertisements. Looking again that wasn't what it was 
>>>>>>> say.
>>>>>>> Apologies.
>>>>>>> 
>>>>>>>> 
>>>>>>>> Any other idea?
>>>>>>> 
>>>>>>> 
>>>>>>> 
>>>>>>> 
>>>>>>> I am by Linux Single Board Computers (SBC) today so I'm able to 
>>>>>>> run
>>>>>>> what you are running and can show you what I'm seeing. I'll focus 
>>>>>>> on
>>>>>>> example-advertisement first as example-gatt-server doesn't change 
>>>>>>> the
>>>>>>> advertisements.
>>>>>>> 
>>>>>>> I've started the BlueZ daemon with "./src/bluetoothd -E -n -d"
>>>>>>> 
>>>>>>> In another shell when I start "./example-advertisement" I see the
>>>>>>> following in the output:
>>>>>>> 
>>>>>>> bluetoothd[2325]: src/adapter.c:property_set_mode() sending Set
>>>>>>> Powered command for index 0
>>>>>>> bluetoothd[2325]: src/adapter.c:property_set_mode_complete() 
>>>>>>> Success
>>>>>>> (0x00)
>>>>>>> bluetoothd[2325]: src/adapter.c:new_settings_callback() Settings:
>>>>>>> 0x00000ad1
>>>>>>> bluetoothd[2325]: src/adapter.c:settings_changed() Changed 
>>>>>>> settings:
>>>>>>> 0x00000001
>>>>>>> bluetoothd[2325]: src/adapter.c:adapter_start() adapter
>>>>>>> /org/bluez/hci0 has been enabled
>>>>>>> bluetoothd[2325]: src/adapter.c:trigger_passive_scanning()
>>>>>>> bluetoothd[2325]: src/advertising.c:register_advertisement()
>>>>>>> RegisterAdvertisement
>>>>>>> bluetoothd[2325]: src/advertising.c:client_create() Adding proxy 
>>>>>>> for
>>>>>>> /org/bluez/example/advertisement0
>>>>>>> bluetoothd[2325]: src/advertising.c:register_advertisement()
>>>>>>> Registered advertisement at path 
>>>>>>> /org/bluez/example/advertisement0
>>>>>>> bluetoothd[2325]: src/advertising.c:parse_service_uuids() Adding
>>>>>>> ServiceUUID: 180D
>>>>>>> bluetoothd[2325]: src/advertising.c:parse_service_uuids() Adding
>>>>>>> ServiceUUID: 180F
>>>>>>> bluetoothd[2325]: src/advertising.c:parse_manufacturer_data() 
>>>>>>> Adding
>>>>>>> ManufacturerData for ffff
>>>>>>> bluetoothd[2325]: src/advertising.c:parse_service_data() Adding
>>>>>>> ServiceData for 9999
>>>>>>> bluetoothd[2325]: src/advertising.c:refresh_advertisement() 
>>>>>>> Refreshing
>>>>>>> advertisement: /org/bluez/example/advertisement0
>>>>>>> bluetoothd[2325]: src/advertising.c:add_adv_callback() 
>>>>>>> Advertisement
>>>>>>> registered: /org/bluez/example/advertisement0
>>>>>>> 
>>>>>>> 
>>>>>>> On a second SBC, at the command line I run "bluetoothctl" and do 
>>>>>>> "scan
>>>>>>> on". Once my first SBC is found I do "scan off". I then do "info
>>>>>>> B8:27:EB:22:57:E0" (this is the address of the first SBC) which 
>>>>>>> gives
>>>>>>> the following output:
>>>>>>> 
>>>>>>> [bluetooth]# info B8:27:EB:22:57:E0
>>>>>>> Device B8:27:EB:22:57:E0
>>>>>>> Alias: B8-27-EB-22-57-E0
>>>>>>> Paired: no
>>>>>>> Trusted: no
>>>>>>> Blocked: no
>>>>>>> Connected: no
>>>>>>> LegacyPairing: no
>>>>>>> UUID: Heart Rate                
>>>>>>> (0000180d-0000-1000-8000-00805f9b34fb)
>>>>>>> UUID: Battery Service           
>>>>>>> (0000180f-0000-1000-8000-00805f9b34fb)
>>>>>>> ManufacturerData Key: 0xffff
>>>>>>> ManufacturerData Value: 0x00
>>>>>>> ManufacturerData Value: 0x01
>>>>>>> ManufacturerData Value: 0x02
>>>>>>> ManufacturerData Value: 0x03
>>>>>>> ManufacturerData Value: 0x04
>>>>>>> ServiceData Key: 00009999-0000-1000-8000-00805f9b34fb
>>>>>>> ServiceData Value: 0x00
>>>>>>> ServiceData Value: 0x01
>>>>>>> ServiceData Value: 0x02
>>>>>>> ServiceData Value: 0x03
>>>>>>> ServiceData Value: 0x04
>>>>>>> 
>>>>>>> 
>>>>>>> I've also done a scan from my Android phone (using the Nordic nRF
>>>>>>> Connect app) and can see the advertisements also (just hard to 
>>>>>>> share
>>>>>>> that information on here).
>>>>>>> 
>>>>>>> Does that help?
>>>>>>> 
>>>>>>> 
>>>>>>>> 
>>>>>>>> 
>>>>>>>> On 13.04.2017 19:59, Barry Byford wrote:
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> Hello Olivier,
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> On 13 April 2017 at 12:14, Olivier MARTIN 
>>>>>>>>> <olivier@labapart.com>
>>>>>>>>> wrote:
>>>>>>>>>> 
>>>>>>>>>> 
>>>>>>>>>> 
>>>>>>>>>> 
>>>>>>>>>> Hi all,
>>>>>>>>>> I am having issue to advertise/export GATT services exposed 
>>>>>>>>>> through
>>>>>>>>>> DBus
>>>>>>>>>> API. I tried `./test/example-gatt-server`. And I also tried to
>>>>>>>>>> merge
>>>>>>>>>> `./test/example-advertisement` into 
>>>>>>>>>> `./test/example-gatt-server`.
>>>>>>>>>> But
>>>>>>>>>> in
>>>>>>>>>> both cases I only see the two compulsory GATT services:
>>>>>>>>>> - Generic Access Service (0x1800)
>>>>>>>>>> - Generic Attribute Service (0x1801)
>>>>>>>>>> 
>>>>>>>>>> I am using Bluez v5.44. And I also tried Bluez v5.37.
>>>>>>>>>> 
>>>>>>>>>> GATT Services seem to be discovered by Bluez (note: I added
>>>>>>>>>> additional
>>>>>>>>>> debug
>>>>>>>>>> statement all prefixed with '#'):
>>>>>>>>>> 
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:manager_register_app() 
>>>>>>>>>> #
>>>>>>>>>> manager_register_app
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:create_app() # 
>>>>>>>>>> create_app
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:manager_register_app()
>>>>>>>>>> Registering
>>>>>>>>>> application: :1.404:/
>>>>>>>>>> bluetoothd[16877]: src/advertising.c:register_advertisement()
>>>>>>>>>> RegisterAdvertisement
>>>>>>>>>> bluetoothd[16877]: src/advertising.c:client_create() Adding 
>>>>>>>>>> proxy
>>>>>>>>>> for
>>>>>>>>>> /org/bluez/example/advertisement0
>>>>>>>>>> bluetoothd[16877]: src/advertising.c:register_advertisement()
>>>>>>>>>> Registered
>>>>>>>>>> advertisement at path /org/bluez/example/advertisement0
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service0/char2, iface:
>>>>>>>>>> org.bluez.GattCharacteristic1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service2/char0/desc0, iface:
>>>>>>>>>> org.bluez.GattDescriptor1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service2/char2/desc3, iface:
>>>>>>>>>> org.bluez.GattDescriptor1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service2/char2, iface:
>>>>>>>>>> org.bluez.GattCharacteristic1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service1/char0, iface:
>>>>>>>>>> org.bluez.GattCharacteristic1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service2/char1, iface:
>>>>>>>>>> org.bluez.GattCharacteristic1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service0/char1, iface:
>>>>>>>>>> org.bluez.GattCharacteristic1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service2/char1/desc3, iface:
>>>>>>>>>> org.bluez.GattDescriptor1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service2/char1/desc2, iface:
>>>>>>>>>> org.bluez.GattDescriptor1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service0/char0, iface:
>>>>>>>>>> org.bluez.GattCharacteristic1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service2, iface: org.bluez.GattService1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service1, iface: org.bluez.GattService1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service0, iface: org.bluez.GattService1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service2/char0/desc1, iface:
>>>>>>>>>> org.bluez.GattDescriptor1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service2/char2/desc2, iface:
>>>>>>>>>> org.bluez.GattDescriptor1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:proxy_added_cb() Object
>>>>>>>>>> received:
>>>>>>>>>> /org/bluez/example/service2/char0, iface:
>>>>>>>>>> org.bluez.GattCharacteristic1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:client_ready_cb() #
>>>>>>>>>> client_ready_cb
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:create_service() #
>>>>>>>>>> create_service
>>>>>>>>>> from /org/bluez/example/service2
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:create_service() #
>>>>>>>>>> create_service
>>>>>>>>>> from /org/bluez/example/service1
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:create_service() #
>>>>>>>>>> create_service
>>>>>>>>>> from /org/bluez/example/service0
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:database_add_app() #
>>>>>>>>>> database_add_app
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:database_add_service() 
>>>>>>>>>> #
>>>>>>>>>> database_add_service
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:cep_write_cb() Stored 
>>>>>>>>>> CEP
>>>>>>>>>> value
>>>>>>>>>> in
>>>>>>>>>> the database
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:database_add_cep() 
>>>>>>>>>> Created
>>>>>>>>>> CEP
>>>>>>>>>> entry
>>>>>>>>>> for characteristic
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:cep_write_cb() Stored 
>>>>>>>>>> CEP
>>>>>>>>>> value
>>>>>>>>>> in
>>>>>>>>>> the database
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:database_add_cep() 
>>>>>>>>>> Created
>>>>>>>>>> CEP
>>>>>>>>>> entry
>>>>>>>>>> for characteristic
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:cep_write_cb() Stored 
>>>>>>>>>> CEP
>>>>>>>>>> value
>>>>>>>>>> in
>>>>>>>>>> the database
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:database_add_cep() 
>>>>>>>>>> Created
>>>>>>>>>> CEP
>>>>>>>>>> entry
>>>>>>>>>> for characteristic
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:gatt_db_service_added() 
>>>>>>>>>> #
>>>>>>>>>> gatt_db_service_added: GATT Service added to local database
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:database_add_service() 
>>>>>>>>>> #
>>>>>>>>>> database_add_service
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:database_add_ccc() 
>>>>>>>>>> Created
>>>>>>>>>> CCC
>>>>>>>>>> entry
>>>>>>>>>> for characteristic
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:gatt_db_service_added() 
>>>>>>>>>> #
>>>>>>>>>> gatt_db_service_added: GATT Service added to local database
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:database_add_service() 
>>>>>>>>>> #
>>>>>>>>>> database_add_service
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:database_add_ccc() 
>>>>>>>>>> Created
>>>>>>>>>> CCC
>>>>>>>>>> entry
>>>>>>>>>> for characteristic
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:gatt_db_service_added() 
>>>>>>>>>> #
>>>>>>>>>> gatt_db_service_added: GATT Service added to local database
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:client_ready_cb() GATT
>>>>>>>>>> application
>>>>>>>>>> registered: :1.404:/
>>>>>>>>>> bluetoothd[16877]: src/advertising.c:parse_service_uuids() 
>>>>>>>>>> Adding
>>>>>>>>>> ServiceUUID: 180D
>>>>>>>>>> bluetoothd[16877]: src/advertising.c:parse_service_uuids() 
>>>>>>>>>> Adding
>>>>>>>>>> ServiceUUID: 180F
>>>>>>>>>> bluetoothd[16877]: src/advertising.c:parse_manufacturer_data()
>>>>>>>>>> Adding
>>>>>>>>>> ManufacturerData for ffff
>>>>>>>>>> bluetoothd[16877]: src/advertising.c:parse_service_data() 
>>>>>>>>>> Adding
>>>>>>>>>> ServiceData
>>>>>>>>>> for 9999
>>>>>>>>>> bluetoothd[16877]: src/advertising.c:refresh_advertisement()
>>>>>>>>>> Refreshing
>>>>>>>>>> advertisement: /org/bluez/example/advertisement0
>>>>>>>>>> bluetoothd[16877]: src/advertising.c:add_adv_callback()
>>>>>>>>>> Advertisement
>>>>>>>>>> registered: /org/bluez/example/advertisement0
>>>>>>>>>> 
>>>>>>>>>> I start `./test/example-gatt-server` as a normal user. But 
>>>>>>>>>> Bluez
>>>>>>>>>> does
>>>>>>>>>> not
>>>>>>>>>> seem to have any permission issue with it.
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> Building from source I've seen something similar if I've used 
>>>>>>>>> sudo
>>>>>>>>> for
>>>>>>>>> the
>>>>>>>>> make.
>>>>>>>>> 
>>>>>>>>> To compile and install I use sudo for the install only:
>>>>>>>>> 
>>>>>>>>> make -j 4 && sudo make install
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>>> 
>>>>>>>>>> I am using 'BLE scanner' on Android to discover the GATT 
>>>>>>>>>> services.
>>>>>>>>>> But
>>>>>>>>>> I
>>>>>>>>>> think the problem is coming from Bluez. When I connect the 
>>>>>>>>>> Android
>>>>>>>>>> device
>>>>>>>>>> to
>>>>>>>>>> Bluez, I can see this log:
>>>>>>>>>> 
>>>>>>>>>> bluetoothd[16877]: src/adapter.c:connected_callback() hci0 
>>>>>>>>>> device
>>>>>>>>>> 98:D6:F7:31:7B:0D connected eir_len 14
>>>>>>>>>> bluetoothd[16877]: src/gatt-database.c:connect_cb() New 
>>>>>>>>>> incoming
>>>>>>>>>> BR/EDR
>>>>>>>>>> ATT
>>>>>>>>>> connection
>>>>>>>>>> bluetoothd[16877]: attrib/gattrib.c:g_attrib_ref() 0x98cd908:
>>>>>>>>>> g_attrib_ref=1
>>>>>>>>>> bluetoothd[16877]: src/device.c:load_gatt_db() # load_gatt_db:
>>>>>>>>>> Restoring
>>>>>>>>>> 98:D6:F7:31:7B:0D gatt database from file
>>>>>>>>>> '/var/lib/bluetooth/5C:F3:70:6A:D9:3C/cache/98:D6:F7:31:7B:0D'
>>>>>>>>>> bluetoothd[16877]: src/device.c:load_gatt_db_impl() #
>>>>>>>>>> load_gatt_db_impl
>>>>>>>>>> bluetoothd[16877]: src/device.c:load_service() # load_service:
>>>>>>>>>> loading
>>>>>>>>>> service: 0x0001, end: 0x0005, uuid:
>>>>>>>>>> 00001801-0000-1000-8000-00805f9b34fb
>>>>>>>>>> bluetoothd[16877]: src/device.c:load_service() # load_service:
>>>>>>>>>> loading
>>>>>>>>>> service: 0x0014, end: 0xffff, uuid:
>>>>>>>>>> 00001800-0000-1000-8000-00805f9b34fb
>>>>>>>>>> bluetoothd[16877]: src/device.c:load_chrc() loading 
>>>>>>>>>> characteristic
>>>>>>>>>> handle:
>>>>>>>>>> 0x0002, value handle: 0x0003, properties 0x0020 uuid:
>>>>>>>>>> 00002a05-0000-1000-8000-00805f9b34fb
>>>>>>>>>> bluetoothd[16877]: src/device.c:load_chrc() loading 
>>>>>>>>>> characteristic
>>>>>>>>>> handle:
>>>>>>>>>> 0x0015, value handle: 0x0016, properties 0x0002 uuid:
>>>>>>>>>> 00002a00-0000-1000-8000-00805f9b34fb
>>>>>>>>>> bluetoothd[16877]: src/device.c:load_chrc() loading 
>>>>>>>>>> characteristic
>>>>>>>>>> handle:
>>>>>>>>>> 0x0017, value handle: 0x0018, properties 0x0002 uuid:
>>>>>>>>>> 00002a01-0000-1000-8000-00805f9b34fb
>>>>>>>>>> bluetoothd[16877]: src/device.c:load_gatt_db() List GATT 
>>>>>>>>>> Primaries
>>>>>>>>>> before
>>>>>>>>>> being free:
>>>>>>>>>> bluetoothd[16877]: src/device.c:print_primary() - Primary 
>>>>>>>>>> UUID:
>>>>>>>>>> 00001801-0000-1000-8000-00805f9b34fb
>>>>>>>>>> bluetoothd[16877]: src/device.c:print_primary() - Primary 
>>>>>>>>>> UUID:
>>>>>>>>>> 00001800-0000-1000-8000-00805f9b34fb
>>>>>>>>>> bluetoothd[16877]: src/device.c:add_primary() # add_primary
>>>>>>>>>> bluetoothd[16877]: src/device.c:add_primary() # add_primary
>>>>>>>>>> bluetoothd[16877]: profiles/gap/gas.c:gap_accept() GAP profile
>>>>>>>>>> accept
>>>>>>>>>> (98:D6:F7:31:7B:0D)
>>>>>>>>>> bluetoothd[16877]: src/service.c:change_state() 0x98c98e0: 
>>>>>>>>>> device
>>>>>>>>>> 98:D6:F7:31:7B:0D profile gap-profile state changed: 
>>>>>>>>>> disconnected
>>>>>>>>>> ->
>>>>>>>>>> connected (0)
>>>>>>>>>> bluetoothd[16877]: 
>>>>>>>>>> src/gatt-client.c:btd_gatt_client_connected()
>>>>>>>>>> Device
>>>>>>>>>> connected.
>>>>>>>>>> bluetoothd[16877]: src/device.c:gatt_server_init() #
>>>>>>>>>> gatt_server_init
>>>>>>>>>> bluetoothd[16877]: src/device.c:gatt_debug() Primary services
>>>>>>>>>> found:
>>>>>>>>>> 2
>>>>>>>>>> bluetoothd[16877]: src/device.c:gatt_debug() start: 0x0001, 
>>>>>>>>>> end:
>>>>>>>>>> 0x0005,
>>>>>>>>>> uuid: 00001801-0000-1000-8000-00805f9b34fb
>>>>>>>>>> bluetoothd[16877]: src/device.c:gatt_debug() start: 0x0014, 
>>>>>>>>>> end:
>>>>>>>>>> 0xffff,
>>>>>>>>>> uuid: 00001800-0000-1000-8000-00805f9b34fb
>>>>>>>>>> bluetoothd[16877]: src/device.c:gatt_debug() Registered 
>>>>>>>>>> handler for
>>>>>>>>>> "Service
>>>>>>>>>> Changed": 0
>>>>>>>>>> bluetoothd[16877]: src/device.c:gatt_client_ready_cb() status:
>>>>>>>>>> success,
>>>>>>>>>> error: 0
>>>>>>>>>> bluetoothd[16877]: src/device.c:register_gatt_services() #
>>>>>>>>>> register_gatt_services
>>>>>>>>>> bluetoothd[16877]: src/device.c:add_primary() # add_primary
>>>>>>>>>> bluetoothd[16877]: src/device.c:add_primary() # add_primary
>>>>>>>>>> bluetoothd[16877]: src/device.c:add_gatt_service() #
>>>>>>>>>> add_gatt_service:
>>>>>>>>>> UUID:00001801-0000-1000-8000-00805f9b34fb
>>>>>>>>>> bluetoothd[16877]: src/gatt-client.c:btd_gatt_client_ready() 
>>>>>>>>>> GATT
>>>>>>>>>> client
>>>>>>>>>> ready
>>>>>>>>>> bluetoothd[16877]: src/gatt-client.c:create_services() 
>>>>>>>>>> Exporting
>>>>>>>>>> objects
>>>>>>>>>> for
>>>>>>>>>> GATT services: 98:D6:F7:31:7B:0D
>>>>>>>>>> bluetoothd[16877]: src/gatt-client.c:service_create() Exported 
>>>>>>>>>> GATT
>>>>>>>>>> service:
>>>>>>>>>> /org/bluez/hci0/dev_98_D6_F7_31_7B_0D/service0001
>>>>>>>>>> bluetoothd[16877]: src/gatt-client.c:characteristic_create()
>>>>>>>>>> Exported
>>>>>>>>>> GATT
>>>>>>>>>> characteristic:
>>>>>>>>>> /org/bluez/hci0/dev_98_D6_F7_31_7B_0D/service0001/char0002
>>>>>>>>>> bluetoothd[16877]: src/device.c:device_svc_resolved()
>>>>>>>>>> /org/bluez/hci0/dev_98_D6_F7_31_7B_0D err 0
>>>>>>>>>> bluetoothd[16877]: src/device.c:store_gatt_db() # 
>>>>>>>>>> store_gatt_db
>>>>>>>>>> bluetoothd[16877]: src/device.c:store_service() # 
>>>>>>>>>> store_service
>>>>>>>>>> bluetoothd[16877]: src/device.c:store_service() # 
>>>>>>>>>> store_service
>>>>>>>>>> bluetoothd[16877]: profiles/gap/gas.c:read_device_name_cb() 
>>>>>>>>>> GAP
>>>>>>>>>> Device
>>>>>>>>>> Name:
>>>>>>>>>> Nexus 4
>>>>>>>>>> bluetoothd[16877]: profiles/gap/gas.c:read_appearance_cb() GAP
>>>>>>>>>> Appearance:
>>>>>>>>>> 0x0000
>>>>>>>>>> 
>>>>>>>>>> I also reduced DBus 'TestAdvertisement' interface to only 
>>>>>>>>>> expose
>>>>>>>>>> one
>>>>>>>>>> GATT
>>>>>>>>>> Service as many BLE adapter got a limitation in the size of 
>>>>>>>>>> the
>>>>>>>>>> advertisement packet:
>>>>>>>>>> class TestAdvertisement(Advertisement):
>>>>>>>>>> 
>>>>>>>>>>     def __init__(self, bus, index):
>>>>>>>>>>         Advertisement.__init__(self, bus, index, 'peripheral')
>>>>>>>>>>         #self.add_service_uuid('180D') # HeartRate
>>>>>>>>>>         self.add_service_uuid('180F') # Battery
>>>>>>>>>>         #self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02,
>>>>>>>>>> 0x03,
>>>>>>>>>> 0x04])
>>>>>>>>>>         #self.add_service_data('9999', [0x00, 0x01, 0x02, 
>>>>>>>>>> 0x03,
>>>>>>>>>> 0x04])
>>>>>>>>>>         self.include_tx_power = True
>>>>>>>>>> 
>>>>>>>>>> My concern is mainly these lines:
>>>>>>>>>> 
>>>>>>>>>> bluetoothd[16877]: src/device.c:gatt_debug() Primary services
>>>>>>>>>> found:
>>>>>>>>>> 2
>>>>>>>>>> bluetoothd[16877]: src/device.c:gatt_debug() start: 0x0001, 
>>>>>>>>>> end:
>>>>>>>>>> 0x0005,
>>>>>>>>>> uuid: 00001801-0000-1000-8000-00805f9b34fb
>>>>>>>>>> bluetoothd[16877]: src/device.c:gatt_debug() start: 0x0014, 
>>>>>>>>>> end:
>>>>>>>>>> 0xffff,
>>>>>>>>>> uuid: 00001800-0000-1000-8000-00805f9b34fb
>>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> I've seen this kind of error message when I've had a failure of 
>>>>>>>>> a
>>>>>>>>> previous script and the Bluetooth daemon is in some unknown 
>>>>>>>>> state.
>>>>>>>>> At
>>>>>>>>> this point it is worth restarting the bluetooth service with:
>>>>>>>>>   sudo service bluetooth restart
>>>>>>>>> 
>>>>>>>>> You will see in the advertising DBus API documentation that it 
>>>>>>>>> is
>>>>>>>>> still in experimental mode in 5.44.
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-api.txt#n78
>>>>>>>>> 
>>>>>>>>> This means that you need to make sure bluetoothd is started in
>>>>>>>>> experimental mode. Have you done this?
>>>>>>>>>  You can check with "sudo service bluetooth status"
>>>>>>>>> 
>>>>>>>>> Experimental can be switched on by default in the 
>>>>>>>>> bluetooth.service
>>>>>>>>> file
>>>>>>>>> 
>>>>>>>>> Edit /lib/systemd/system/bluetooth.service file to add
>>>>>>>>> --experimental
>>>>>>>>> flag
>>>>>>>>> e.g:
>>>>>>>>> 
>>>>>>>>> sudo sed -i '/^ExecStart.*bluetoothd\s*$/ s/$/ --experimental/'
>>>>>>>>> /lib/systemd/system/bluetooth.service
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>>> I have not found the code that export GATT Services from GATT
>>>>>>>>>> Database
>>>>>>>>>> to
>>>>>>>>>> the BLE central.
>>>>>>>>>> 
>>>>>>>>>> From my search on Internet, it looks I am not the only one who 
>>>>>>>>>> is
>>>>>>>>>> having
>>>>>>>>>> this issue
>>>>>>>>>> I am happy to share/test anything that could help to make some
>>>>>>>>>> progress.
>>>>>>>>>> 
>>>>>>>>>> Thanks,
>>>>>>>>>> Olivier
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>>> linux-bluetooth"
>>>>>>>>>> in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at  
>>>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>>> 
>>>>>>>> 
>>>>>>>> 
>>>>>>>> 
>>>>>>>> 
>>>>>> 
>>>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=_89eaf6877e97e1012613e971c29ed285
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=btmon.log
Content-Disposition: attachment;
 filename=btmon.log;
 size=36147

PSBOZXcgSW5kZXg6IDVDOkYzOjcwOjZBOkQ5OjNDIChQcmltYXJ5LFVTQixoY2kwKSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMC4yNjQ0MTUKPSBPcGVuIEluZGV4OiA1QzpGMzo3
MDo2QTpEOTozQyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBb
aGNpMF0gMC4yNjQ0MTcKPSBJbmRleCBJbmZvOiA1QzpGMzo3MDo2QTpEOTozQyAoQnJvYWRjb20g
Q29ycG9yYXRpb24pICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMC4yNjQ0MTgKPiBIQ0kg
RXZlbnQ6IExFIE1ldGEgRXZlbnQgKDB4M2UpIHBsZW4gMTkgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBbaGNpMF0gNS4zMzE0MDQKICAgICAgTEUgQ29ubmVjdGlvbiBDb21wbGV0
ZSAoMHgwMSkKICAgICAgICBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApCiAgICAgICAgSGFuZGxlOiA2
NAogICAgICAgIFJvbGU6IFNsYXZlICgweDAxKQogICAgICAgIFBlZXIgYWRkcmVzcyB0eXBlOiBS
YW5kb20gKDB4MDEpCiAgICAgICAgUGVlciBhZGRyZXNzOiA1RTozQTo5OTpFMzoyMzpDRCAoUmVz
b2x2YWJsZSkKICAgICAgICBDb25uZWN0aW9uIGludGVydmFsOiA0OC43NSBtc2VjICgweDAwMjcp
CiAgICAgICAgQ29ubmVjdGlvbiBsYXRlbmN5OiAwLjAwIG1zZWMgKDB4MDAwMCkKICAgICAgICBT
dXBlcnZpc2lvbiB0aW1lb3V0OiAyMDAwMCBtc2VjICgweDA3ZDApCiAgICAgICAgTWFzdGVyIGNs
b2NrIGFjY3VyYWN5OiAweDA1CjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRs
ZW4gMTYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDUuMzMxNjExCiAg
ICAgIExFIEwyQ0FQOiBDb25uZWN0aW9uIFBhcmFtZXRlciBVcGRhdGUgUmVxdWVzdCAoMHgxMikg
aWRlbnQgMSBsZW4gOAogICAgICAgIE1pbiBpbnRlcnZhbDogNDAKICAgICAgICBNYXggaW50ZXJ2
YWw6IDU2CiAgICAgICAgU2xhdmUgbGF0ZW5jeTogMAogICAgICAgIFRpbWVvdXQgbXVsdGlwbGll
cjogMjAwMApAIERldmljZSBDb25uZWN0ZWQ6IDVFOjNBOjk5OkUzOjIzOkNEICgyKSBmbGFncyAw
eDAwMDAKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY0IGZsYWdzIDB4MDAgZGxlbiA3ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gNS4zMzIxMzYKICAgICAgQVRUOiBFeGNo
YW5nZSBNVFUgUmVxdWVzdCAoMHgwMikgbGVuIDIKICAgICAgICBDbGllbnQgUlggTVRVOiA1MTcK
PiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBbaGNpMF0gNS4zOTYzOTYKICAgICAgICBOdW0gaGFuZGxlczog
MQogICAgICAgIEhhbmRsZTogNjQKICAgICAgICBDb3VudDogMgo+IEFDTCBEYXRhIFJYOiBIYW5k
bGUgNjQgZmxhZ3MgMHgwMiBkbGVuIDEwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFtoY2kwXSA1LjQ0NDIyNAogICAgICBMRSBMMkNBUDogQ29ubmVjdGlvbiBQYXJhbWV0ZXIgVXBk
YXRlIFJlc3BvbnNlICgweDEzKSBpZGVudCAxIGxlbiAyCiAgICAgICAgUmVzdWx0OiBDb25uZWN0
aW9uIFBhcmFtZXRlcnMgYWNjZXB0ZWQgKDB4MDAwMCkKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY0
IGZsYWdzIDB4MDIgZGxlbiA3ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNp
MF0gNS41NDIwMDUKICAgICAgQVRUOiBFeGNoYW5nZSBNVFUgUmVzcG9uc2UgKDB4MDMpIGxlbiAy
CiAgICAgICAgU2VydmVyIFJYIE1UVTogNTE3CjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFn
cyAweDAwIGRsZW4gMTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDUu
NTQyMzQzCiAgICAgIEFUVDogUmVhZCBCeSBHcm91cCBUeXBlIFJlcXVlc3QgKDB4MTApIGxlbiA2
CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMDEtMHhmZmZmCiAgICAgICAgQXR0cmlidXRlIGdy
b3VwIHR5cGU6IFByaW1hcnkgU2VydmljZSAoMHgyODAwKQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUg
NjQgZmxhZ3MgMHgwMiBkbGVuIDExICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFto
Y2kwXSA1LjU5MDY0NwogICAgICBBVFQ6IFJlYWQgQnkgR3JvdXAgVHlwZSBSZXF1ZXN0ICgweDEw
KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDAxLTB4ZmZmZgogICAgICAgIEF0dHJp
YnV0ZSBncm91cCB0eXBlOiBQcmltYXJ5IFNlcnZpY2UgKDB4MjgwMCkKPCBBQ0wgRGF0YSBUWDog
SGFuZGxlIDY0IGZsYWdzIDB4MDAgZGxlbiAyNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBbaGNpMF0gNS41OTA4OTgKICAgICAgQVRUOiBSZWFkIEJ5IEdyb3VwIFR5cGUgUmVzcG9u
c2UgKDB4MTEpIGxlbiAxOQogICAgICAgIEF0dHJpYnV0ZSBkYXRhIGxlbmd0aDogNgogICAgICAg
IEF0dHJpYnV0ZSBncm91cCBsaXN0OiAzIGVudHJpZXMKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4
MDAwMS0weDAwMDUKICAgICAgICBVVUlEOiBHZW5lcmljIEFjY2VzcyBQcm9maWxlICgweDE4MDAp
CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMDYtMHgwMDA5CiAgICAgICAgVVVJRDogR2VuZXJp
YyBBdHRyaWJ1dGUgUHJvZmlsZSAoMHgxODAxKQogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDBh
LTB4MDAwZAogICAgICAgIFVVSUQ6IEJhdHRlcnkgU2VydmljZSAoMHgxODBmKQo+IEFDTCBEYXRh
IFJYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMiBkbGVuIDE4ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFtoY2kwXSA1LjYzOTUyNwogICAgICBBVFQ6IFJlYWQgQnkgR3JvdXAgVHlwZSBS
ZXNwb25zZSAoMHgxMSkgbGVuIDEzCiAgICAgICAgQXR0cmlidXRlIGRhdGEgbGVuZ3RoOiA2CiAg
ICAgICAgQXR0cmlidXRlIGdyb3VwIGxpc3Q6IDIgZW50cmllcwogICAgICAgIEhhbmRsZSByYW5n
ZTogMHgwMDAxLTB4MDAwNQogICAgICAgIFVVSUQ6IEdlbmVyaWMgQXR0cmlidXRlIFByb2ZpbGUg
KDB4MTgwMSkKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAxNC0weGZmZmYKICAgICAgICBVVUlE
OiBHZW5lcmljIEFjY2VzcyBQcm9maWxlICgweDE4MDApCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2
NCBmbGFncyAweDAwIGRsZW4gMTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hj
aTBdIDUuNjM5OTMyCiAgICAgIEFUVDogUmVhZCBCeSBHcm91cCBUeXBlIFJlcXVlc3QgKDB4MTAp
IGxlbiA2CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMDEtMHhmZmZmCiAgICAgICAgQXR0cmli
dXRlIGdyb3VwIHR5cGU6IFNlY29uZGFyeSBTZXJ2aWNlICgweDI4MDEpCj4gQUNMIERhdGEgUlg6
IEhhbmRsZSA2NCBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgW2hjaTBdIDUuNjg4MTU2CiAgICAgIEFUVDogUmVhZCBCeSBHcm91cCBUeXBlIFJlcXVl
c3QgKDB4MTApIGxlbiA2CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMGUtMHhmZmZmCiAgICAg
ICAgQXR0cmlidXRlIGdyb3VwIHR5cGU6IFByaW1hcnkgU2VydmljZSAoMHgyODAwKQo8IEFDTCBE
YXRhIFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVuIDI2ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFtoY2kwXSA1LjY4ODQxMwogICAgICBBVFQ6IFJlYWQgQnkgR3JvdXAgVHlw
ZSBSZXNwb25zZSAoMHgxMSkgbGVuIDIxCiAgICAgICAgQXR0cmlidXRlIGRhdGEgbGVuZ3RoOiAy
MAogICAgICAgIEF0dHJpYnV0ZSBncm91cCBsaXN0OiAxIGVudHJ5CiAgICAgICAgSGFuZGxlIHJh
bmdlOiAweDAwMGUtMHgwMDFkCiAgICAgICAgVVVJRDogVmVuZG9yIHNwZWNpZmljICgxMjM0NTY3
OC0xMjM0LTU2NzgtMTIzNC01Njc4OWFiY2RlZjApCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29t
cGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBd
IDUuNjg5MzU3CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAg
ICAgQ291bnQ6IDIKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY0IGZsYWdzIDB4MDIgZGxlbiA5ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gNS43MzY3NzUKICAgICAgQVRU
OiBFcnJvciBSZXNwb25zZSAoMHgwMSkgbGVuIDQKICAgICAgICBSZWFkIEJ5IEdyb3VwIFR5cGUg
UmVxdWVzdCAoMHgxMCkKICAgICAgICBIYW5kbGU6IDB4MDAwMQogICAgICAgIEVycm9yOiBVbnN1
cHBvcnRlZCBHcm91cCBUeXBlICgweDEwKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjQgZmxhZ3Mg
MHgwMCBkbGVuIDExICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSA1Ljcz
NzA0NwogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4KSBsZW4gNgogICAgICAg
IEhhbmRsZSByYW5nZTogMHgwMDAxLTB4MDAwNQogICAgICAgIEF0dHJpYnV0ZSB0eXBlOiBJbmNs
dWRlICgweDI4MDIpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4
MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDUuODE2NDIwCiAgICAgICAg
TnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAgQ291bnQ6IDIKPiBBQ0wg
RGF0YSBSWDogSGFuZGxlIDY0IGZsYWdzIDB4MDIgZGxlbiAxMSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBbaGNpMF0gNS44MTY0MzIKICAgICAgQVRUOiBSZWFkIEJ5IEdyb3VwIFR5
cGUgUmVxdWVzdCAoMHgxMCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAxZS0weGZm
ZmYKICAgICAgICBBdHRyaWJ1dGUgZ3JvdXAgdHlwZTogUHJpbWFyeSBTZXJ2aWNlICgweDI4MDAp
CjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRsZW4gMTIgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDUuODE2Njk1CiAgICAgIEFUVDogUmVhZCBCeSBH
cm91cCBUeXBlIFJlc3BvbnNlICgweDExKSBsZW4gNwogICAgICAgIEF0dHJpYnV0ZSBkYXRhIGxl
bmd0aDogNgogICAgICAgIEF0dHJpYnV0ZSBncm91cCBsaXN0OiAxIGVudHJ5CiAgICAgICAgSGFu
ZGxlIHJhbmdlOiAweDAwMWUtMHgwMDI1CiAgICAgICAgVVVJRDogSGVhcnQgUmF0ZSAoMHgxODBk
KQo+IEhDSSBFdmVudDogTEUgTWV0YSBFdmVudCAoMHgzZSkgcGxlbiAxMCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSA1LjgxNzQyMwogICAgICBMRSBDb25uZWN0aW9u
IFVwZGF0ZSBDb21wbGV0ZSAoMHgwMykKICAgICAgICBTdGF0dXM6IFN1Y2Nlc3MgKDB4MDApCiAg
ICAgICAgSGFuZGxlOiA2NAogICAgICAgIENvbm5lY3Rpb24gaW50ZXJ2YWw6IDY3LjUwIG1zZWMg
KDB4MDAzNikKICAgICAgICBDb25uZWN0aW9uIGxhdGVuY3k6IDAuMDAgbXNlYyAoMHgwMDAwKQog
ICAgICAgIFN1cGVydmlzaW9uIHRpbWVvdXQ6IDIwMDAwIG1zZWMgKDB4MDdkMCkKPiBBQ0wgRGF0
YSBSWDogSGFuZGxlIDY0IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBbaGNpMF0gNS44ODMwMjkKICAgICAgQVRUOiBFcnJvciBSZXNwb25zZSAoMHgw
MSkgbGVuIDQKICAgICAgICBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkKICAgICAgICBIYW5k
bGU6IDB4MDAwMQogICAgICAgIEVycm9yOiBBdHRyaWJ1dGUgTm90IEZvdW5kICgweDBhKQo8IEFD
TCBEYXRhIFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVuIDExICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFtoY2kwXSA1Ljg4MzIzMwogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBS
ZXF1ZXN0ICgweDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDE0LTB4ZmZmZgog
ICAgICAgIEF0dHJpYnV0ZSB0eXBlOiBJbmNsdWRlICgweDI4MDIpCj4gQUNMIERhdGEgUlg6IEhh
bmRsZSA2NCBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgW2hjaTBdIDUuOTUwNjg1CiAgICAgIEFUVDogUmVhZCBCeSBHcm91cCBUeXBlIFJlcXVlc3Qg
KDB4MTApIGxlbiA2CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMjYtMHhmZmZmCiAgICAgICAg
QXR0cmlidXRlIGdyb3VwIHR5cGU6IFByaW1hcnkgU2VydmljZSAoMHgyODAwKQo8IEFDTCBEYXRh
IFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVuIDkgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFtoY2kwXSA1Ljk1MDk2NQogICAgICBBVFQ6IEVycm9yIFJlc3BvbnNlICgweDAx
KSBsZW4gNAogICAgICAgIFJlYWQgQnkgR3JvdXAgVHlwZSBSZXF1ZXN0ICgweDEwKQogICAgICAg
IEhhbmRsZTogMHgwMDI2CiAgICAgICAgRXJyb3I6IEF0dHJpYnV0ZSBOb3QgRm91bmQgKDB4MGEp
Cj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDUuOTUxMzYwCiAgICAgICAgTnVtIGhhbmRsZXM6
IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAgQ291bnQ6IDIKPiBBQ0wgRGF0YSBSWDogSGFu
ZGxlIDY0IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBbaGNpMF0gNi4wODU4MDcKICAgICAgQVRUOiBFcnJvciBSZXNwb25zZSAoMHgwMSkgbGVuIDQK
ICAgICAgICBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkKICAgICAgICBIYW5kbGU6IDB4MDAx
NAogICAgICAgIEVycm9yOiBBdHRyaWJ1dGUgTm90IEZvdW5kICgweDBhKQo8IEFDTCBEYXRhIFRY
OiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVuIDExICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFtoY2kwXSA2LjA4NjAxNwogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgw
eDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDAxLTB4MDAwNQogICAgICAgIEF0
dHJpYnV0ZSB0eXBlOiBDaGFyYWN0ZXJpc3RpYyAoMHgyODAzKQo+IEhDSSBFdmVudDogTnVtYmVy
IG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFtoY2kwXSA2LjA4NjIzNAogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2
NAogICAgICAgIENvdW50OiAyCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NCBmbGFncyAweDAyIGRs
ZW4gMTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDYuMTUzMDQ2CiAg
ICAgIEFUVDogUmVhZCBCeSBUeXBlIFJlcXVlc3QgKDB4MDgpIGxlbiA2CiAgICAgICAgSGFuZGxl
IHJhbmdlOiAweDAwMDEtMHgwMDA1CiAgICAgICAgQXR0cmlidXRlIHR5cGU6IEluY2x1ZGUgKDB4
MjgwMikKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY0IGZsYWdzIDB4MDAgZGxlbiA5ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gNi4xNTMzMzkKICAgICAgQVRUOiBFcnJv
ciBSZXNwb25zZSAoMHgwMSkgbGVuIDQKICAgICAgICBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgw
OCkKICAgICAgICBIYW5kbGU6IDB4MDAwMQogICAgICAgIEVycm9yOiBBdHRyaWJ1dGUgTm90IEZv
dW5kICgweDBhKQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMiBkbGVuIDEzICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSA3LjE2NTY4NAogICAgICBBVFQ6
IFJlYWQgQnkgVHlwZSBSZXNwb25zZSAoMHgwOSkgbGVuIDgKICAgICAgICBBdHRyaWJ1dGUgZGF0
YSBsZW5ndGg6IDcKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsaXN0OiAxIGVudHJ5CiAgICAgICAg
SGFuZGxlOiAweDAwMDIKICAgICAgICBWYWx1ZTogMjAwMzAwMDUyYQo8IEFDTCBEYXRhIFRYOiBI
YW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVuIDExICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFtoY2kwXSA3LjE2NTg3NQogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4
KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDAzLTB4MDAwNQogICAgICAgIEF0dHJp
YnV0ZSB0eXBlOiBDaGFyYWN0ZXJpc3RpYyAoMHgyODAzKQo+IEhDSSBFdmVudDogTnVtYmVyIG9m
IENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFto
Y2kwXSA3LjM0NTQzMgogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2NAog
ICAgICAgIENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NCBmbGFncyAweDAyIGRsZW4g
MTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDkuNjYzMzIwCiAgICAg
IEFUVDogUmVhZCBCeSBUeXBlIFJlcXVlc3QgKDB4MDgpIGxlbiA2CiAgICAgICAgSGFuZGxlIHJh
bmdlOiAweDAwMDEtMHgwMDA1CiAgICAgICAgQXR0cmlidXRlIHR5cGU6IENoYXJhY3RlcmlzdGlj
ICgweDI4MDMpCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRsZW4gMjAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDkuNjYzNTc3CiAgICAgIEFUVDog
UmVhZCBCeSBUeXBlIFJlc3BvbnNlICgweDA5KSBsZW4gMTUKICAgICAgICBBdHRyaWJ1dGUgZGF0
YSBsZW5ndGg6IDcKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsaXN0OiAyIGVudHJpZXMKICAgICAg
ICBIYW5kbGU6IDB4MDAwMgogICAgICAgIFZhbHVlOiAwMjAzMDAwMDJhCiAgICAgICAgSGFuZGxl
OiAweDAwMDQKICAgICAgICBWYWx1ZTogMDIwNTAwMDEyYQo+IEhDSSBFdmVudDogTnVtYmVyIG9m
IENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFto
Y2kwXSA5Ljg0NTQ2MAogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2NAog
ICAgICAgIENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NCBmbGFncyAweDAyIGRsZW4g
OSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMTIuMTYwNzQyCiAgICAg
IEFUVDogRXJyb3IgUmVzcG9uc2UgKDB4MDEpIGxlbiA0CiAgICAgICAgUmVhZCBCeSBUeXBlIFJl
cXVlc3QgKDB4MDgpCiAgICAgICAgSGFuZGxlOiAweDAwMDMKICAgICAgICBFcnJvcjogQXR0cmli
dXRlIE5vdCBGb3VuZCAoMHgwYSkKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY0IGZsYWdzIDB4MDAg
ZGxlbiA5ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAxMi4xNjEwNzMK
ICAgICAgQVRUOiBGaW5kIEluZm9ybWF0aW9uIFJlcXVlc3QgKDB4MDQpIGxlbiA0CiAgICAgICAg
SGFuZGxlIHJhbmdlOiAweDAwMDQtMHgwMDA1Cj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxl
dGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMTIu
MzQ1NDgzCiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAg
Q291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY0IGZsYWdzIDB4MDIgZGxlbiAxMSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAxNC42NTgzNjcKICAgICAgQVRUOiBS
ZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4
MDAwNS0weDAwMDUKICAgICAgICBBdHRyaWJ1dGUgdHlwZTogQ2hhcmFjdGVyaXN0aWMgKDB4Mjgw
MykKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY0IGZsYWdzIDB4MDAgZGxlbiA5ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAxNC42NTg2MTYKICAgICAgQVRUOiBFcnJvciBS
ZXNwb25zZSAoMHgwMSkgbGVuIDQKICAgICAgICBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkK
ICAgICAgICBIYW5kbGU6IDB4MDAwNQogICAgICAgIEVycm9yOiBBdHRyaWJ1dGUgTm90IEZvdW5k
ICgweDBhKQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBw
bGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDE0Ljg0NTUxNgogICAgICAgIE51bSBo
YW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2NAogICAgICAgIENvdW50OiAxCj4gQUNMIERhdGEg
Ulg6IEhhbmRsZSA2NCBmbGFncyAweDAyIGRsZW4gOSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBbaGNpMF0gMTcuMTU1NzY1CiAgICAgIEFUVDogRXJyb3IgUmVzcG9uc2UgKDB4MDEp
IGxlbiA0CiAgICAgICAgRmluZCBJbmZvcm1hdGlvbiBSZXF1ZXN0ICgweDA0KQogICAgICAgIEhh
bmRsZTogMHgwMDA0CiAgICAgICAgRXJyb3I6IEF0dHJpYnV0ZSBOb3QgRm91bmQgKDB4MGEpCjwg
QUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRsZW4gMTEgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBbaGNpMF0gMTcuMTU1OTIwCiAgICAgIEFUVDogUmVhZCBCeSBUeXBl
IFJlcXVlc3QgKDB4MDgpIGxlbiA2CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMTQtMHhmZmZm
CiAgICAgICAgQXR0cmlidXRlIHR5cGU6IENoYXJhY3RlcmlzdGljICgweDI4MDMpCj4gSENJIEV2
ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBbaGNpMF0gMTcuMzQ2NTMyCiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAg
ICBIYW5kbGU6IDY0CiAgICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY0IGZs
YWdzIDB4MDIgZGxlbiAxMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAx
OS42NTM0MjUKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVuIDYKICAg
ICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAwNi0weDAwMDkKICAgICAgICBBdHRyaWJ1dGUgdHlwZTog
SW5jbHVkZSAoMHgyODAyKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVu
IDkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDE5LjY1MzYzNwogICAg
ICBBVFQ6IEVycm9yIFJlc3BvbnNlICgweDAxKSBsZW4gNAogICAgICAgIFJlYWQgQnkgVHlwZSBS
ZXF1ZXN0ICgweDA4KQogICAgICAgIEhhbmRsZTogMHgwMDA2CiAgICAgICAgRXJyb3I6IEF0dHJp
YnV0ZSBOb3QgRm91bmQgKDB4MGEpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBh
Y2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMTkuODQ2NTYy
CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAgQ291bnQ6
IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY0IGZsYWdzIDB4MDIgZGxlbiAyMCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAyMi4xNTEwNDYKICAgICAgQVRUOiBSZWFkIEJ5
IFR5cGUgUmVzcG9uc2UgKDB4MDkpIGxlbiAxNQogICAgICAgIEF0dHJpYnV0ZSBkYXRhIGxlbmd0
aDogNwogICAgICAgIEF0dHJpYnV0ZSBkYXRhIGxpc3Q6IDIgZW50cmllcwogICAgICAgIEhhbmRs
ZTogMHgwMDE1CiAgICAgICAgVmFsdWU6IDAyMTYwMDAwMmEKICAgICAgICBIYW5kbGU6IDB4MDAx
NwogICAgICAgIFZhbHVlOiAwMjE4MDAwMTJhCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFn
cyAweDAwIGRsZW4gMTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMjIu
MTUxMjU4CiAgICAgIEFUVDogUmVhZCBCeSBUeXBlIFJlcXVlc3QgKDB4MDgpIGxlbiA2CiAgICAg
ICAgSGFuZGxlIHJhbmdlOiAweDAwMTgtMHhmZmZmCiAgICAgICAgQXR0cmlidXRlIHR5cGU6IENo
YXJhY3RlcmlzdGljICgweDI4MDMpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBh
Y2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMjIuMzQ2NjA5
CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAgQ291bnQ6
IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY0IGZsYWdzIDB4MDIgZGxlbiAxMSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAyNC42NDg0NjYKICAgICAgQVRUOiBSZWFkIEJ5
IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAwNi0w
eDAwMDkKICAgICAgICBBdHRyaWJ1dGUgdHlwZTogQ2hhcmFjdGVyaXN0aWMgKDB4MjgwMykKPCBB
Q0wgRGF0YSBUWDogSGFuZGxlIDY0IGZsYWdzIDB4MDAgZGxlbiAxMyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFtoY2kwXSAyNC42NDg2OTIKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUg
UmVzcG9uc2UgKDB4MDkpIGxlbiA4CiAgICAgICAgQXR0cmlidXRlIGRhdGEgbGVuZ3RoOiA3CiAg
ICAgICAgQXR0cmlidXRlIGRhdGEgbGlzdDogMSBlbnRyeQogICAgICAgIEhhbmRsZTogMHgwMDA3
CiAgICAgICAgVmFsdWU6IDIwMDgwMDA1MmEKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0
ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAyNC44
NDY2MjIKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogNjQKICAgICAgICBD
b3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDI3LjE0NTk5MAogICAgICBBVFQ6IEVy
cm9yIFJlc3BvbnNlICgweDAxKSBsZW4gNAogICAgICAgIFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgw
eDA4KQogICAgICAgIEhhbmRsZTogMHgwMDE4CiAgICAgICAgRXJyb3I6IEF0dHJpYnV0ZSBOb3Qg
Rm91bmQgKDB4MGEpCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRsZW4gOSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMjcuMTQ2Mjg1CiAgICAgIEFU
VDogRmluZCBJbmZvcm1hdGlvbiBSZXF1ZXN0ICgweDA0KSBsZW4gNAogICAgICAgIEhhbmRsZSBy
YW5nZTogMHgwMDE5LTB4ZmZmZgo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNr
ZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDI3LjM0NjY1Ngog
ICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2NAogICAgICAgIENvdW50OiAx
Cj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NCBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMjkuNjQzNTQwCiAgICAgIEFUVDogUmVhZCBCeSBU
eXBlIFJlcXVlc3QgKDB4MDgpIGxlbiA2CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMDgtMHgw
MDA5CiAgICAgICAgQXR0cmlidXRlIHR5cGU6IENoYXJhY3RlcmlzdGljICgweDI4MDMpCjwgQUNM
IERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRsZW4gOSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBbaGNpMF0gMjkuNjQzODIxCiAgICAgIEFUVDogRXJyb3IgUmVzcG9uc2Ug
KDB4MDEpIGxlbiA0CiAgICAgICAgUmVhZCBCeSBUeXBlIFJlcXVlc3QgKDB4MDgpCiAgICAgICAg
SGFuZGxlOiAweDAwMDgKICAgICAgICBFcnJvcjogQXR0cmlidXRlIE5vdCBGb3VuZCAoMHgwYSkK
PiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFtoY2kwXSAyOS44NDc2NzQKICAgICAgICBOdW0gaGFuZGxlczog
MQogICAgICAgIEhhbmRsZTogNjQKICAgICAgICBDb3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5k
bGUgNjQgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
W2hjaTBdIDMyLjE0MTA1NAogICAgICBBVFQ6IEVycm9yIFJlc3BvbnNlICgweDAxKSBsZW4gNAog
ICAgICAgIEZpbmQgSW5mb3JtYXRpb24gUmVxdWVzdCAoMHgwNCkKICAgICAgICBIYW5kbGU6IDB4
MDAxOQogICAgICAgIEVycm9yOiBBdHRyaWJ1dGUgTm90IEZvdW5kICgweDBhKQo8IEFDTCBEYXRh
IFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVuIDcgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgW2hjaTBdIDMyLjE0MjU5NAogICAgICBBVFQ6IFJlYWQgUmVxdWVzdCAoMHgwYSkg
bGVuIDIKICAgICAgICBIYW5kbGU6IDB4MDAxNgo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBs
ZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDMy
LjM0NzY5NwogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2NAogICAgICAg
IENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NCBmbGFncyAweDAyIGRsZW4gOSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMzQuNjM4NTYxCiAgICAgIEFUVDog
RmluZCBJbmZvcm1hdGlvbiBSZXF1ZXN0ICgweDA0KSBsZW4gNAogICAgICAgIEhhbmRsZSByYW5n
ZTogMHgwMDA5LTB4MDAwOQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVu
IDEwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDM0LjYzODgxMAogICAg
ICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVzcG9uc2UgKDB4MDUpIGxlbiA1CiAgICAgICAgRm9y
bWF0OiBVVUlELTE2ICgweDAxKQogICAgICAgIEhhbmRsZTogMHgwMDA5CiAgICAgICAgVVVJRDog
Q2xpZW50IENoYXJhY3RlcmlzdGljIENvbmZpZ3VyYXRpb24gKDB4MjkwMikKPiBIQ0kgRXZlbnQ6
IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFtoY2kwXSAzNC44NDc3MzIKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhh
bmRsZTogNjQKICAgICAgICBDb3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjQgZmxhZ3Mg
MHgwMiBkbGVuIDEyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDM3LjEz
NjIxMgogICAgICBBVFQ6IFJlYWQgUmVzcG9uc2UgKDB4MGIpIGxlbiA3CiAgICAgICAgVmFsdWU6
IDRlNjU3ODc1NzMyMDM0CjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRsZW4g
NyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMzcuMTM2NTk1CiAgICAg
IEFUVDogUmVhZCBSZXF1ZXN0ICgweDBhKSBsZW4gMgogICAgICAgIEhhbmRsZTogMHgwMDE4Cj4g
SENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBbaGNpMF0gMzcuMzQ3NzQwCiAgICAgICAgTnVtIGhhbmRsZXM6IDEK
ICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxl
IDY0IGZsYWdzIDB4MDIgZGxlbiAxMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFto
Y2kwXSAzOS42MzM3NDIKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVu
IDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAwYS0weDAwMGQKICAgICAgICBBdHRyaWJ1dGUg
dHlwZTogSW5jbHVkZSAoMHgyODAyKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgw
MCBkbGVuIDkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDM5LjYzMzk5
NgogICAgICBBVFQ6IEVycm9yIFJlc3BvbnNlICgweDAxKSBsZW4gNAogICAgICAgIFJlYWQgQnkg
VHlwZSBSZXF1ZXN0ICgweDA4KQogICAgICAgIEhhbmRsZTogMHgwMDBhCiAgICAgICAgRXJyb3I6
IEF0dHJpYnV0ZSBOb3QgRm91bmQgKDB4MGEpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxl
dGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMzku
ODQ3NzU3CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAg
Q291bnQ6IDEKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykg
cGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSA0Mi4zNDc3OTYKICAgICAgICBOdW0g
aGFuZGxlczogMQogICAgICAgIEhhbmRsZTogNjQKICAgICAgICBDb3VudDogMQo+IEFDTCBEYXRh
IFJYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMiBkbGVuIDcgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgW2hjaTBdIDQ0LjYyODY3NAogICAgICBBVFQ6IFJlYWQgUmVzcG9uc2UgKDB4MGIp
IGxlbiAyCiAgICAgICAgVmFsdWU6IDAwMDAKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0
ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSA0NC44
NDg4MTMKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogNjQKICAgICAgICBD
b3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMiBkbGVuIDExICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDQ3LjEyNjQ1NAogICAgICBBVFQ6IFJl
YWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSByYW5nZTogMHgw
MDBhLTB4MDAwZAogICAgICAgIEF0dHJpYnV0ZSB0eXBlOiBDaGFyYWN0ZXJpc3RpYyAoMHgyODAz
KQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVuIDEzICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDQ3LjEyNjY1NwogICAgICBBVFQ6IFJlYWQgQnkg
VHlwZSBSZXNwb25zZSAoMHgwOSkgbGVuIDgKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsZW5ndGg6
IDcKICAgICAgICBBdHRyaWJ1dGUgZGF0YSBsaXN0OiAxIGVudHJ5CiAgICAgICAgSGFuZGxlOiAw
eDAwMGIKICAgICAgICBWYWx1ZTogMTIwYzAwMTkyYQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjQg
ZmxhZ3MgMHgwMiBkbGVuIDExICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBd
IDUyLjEyMTQ5MQogICAgICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4KSBsZW4gNgog
ICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDBjLTB4MDAwZAogICAgICAgIEF0dHJpYnV0ZSB0eXBl
OiBDaGFyYWN0ZXJpc3RpYyAoMHgyODAzKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjQgZmxhZ3Mg
MHgwMCBkbGVuIDkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDUyLjEy
MTczNwogICAgICBBVFQ6IEVycm9yIFJlc3BvbnNlICgweDAxKSBsZW4gNAogICAgICAgIFJlYWQg
QnkgVHlwZSBSZXF1ZXN0ICgweDA4KQogICAgICAgIEhhbmRsZTogMHgwMDBjCiAgICAgICAgRXJy
b3I6IEF0dHJpYnV0ZSBOb3QgRm91bmQgKDB4MGEpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29t
cGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0g
NTIuMzQ4OTA5CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAg
ICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY0IGZsYWdzIDB4MDIgZGxlbiA5ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSA1Ny4xMTY0NDIKICAgICAgQVRU
OiBGaW5kIEluZm9ybWF0aW9uIFJlcXVlc3QgKDB4MDQpIGxlbiA0CiAgICAgICAgSGFuZGxlIHJh
bmdlOiAweDAwMGQtMHgwMDBkCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRs
ZW4gMTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gNTcuMTE2NzE1CiAg
ICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25zZSAoMHgwNSkgbGVuIDUKICAgICAgICBG
b3JtYXQ6IFVVSUQtMTYgKDB4MDEpCiAgICAgICAgSGFuZGxlOiAweDAwMGQKICAgICAgICBVVUlE
OiBDbGllbnQgQ2hhcmFjdGVyaXN0aWMgQ29uZmlndXJhdGlvbiAoMHgyOTAyKQo+IEhDSSBFdmVu
dDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgW2hjaTBdIDU3LjM0OTk2MgogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAg
SGFuZGxlOiA2NAogICAgICAgIENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NCBmbGFn
cyAweDAyIGRsZW4gMTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gNjIu
MTExNzIwCiAgICAgIEFUVDogUmVhZCBCeSBUeXBlIFJlcXVlc3QgKDB4MDgpIGxlbiA2CiAgICAg
ICAgSGFuZGxlIHJhbmdlOiAweDAwMGUtMHgwMDFkCiAgICAgICAgQXR0cmlidXRlIHR5cGU6IElu
Y2x1ZGUgKDB4MjgwMikKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY0IGZsYWdzIDB4MDAgZGxlbiA5
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSA2Mi4xMTE5MzUKICAgICAg
QVRUOiBFcnJvciBSZXNwb25zZSAoMHgwMSkgbGVuIDQKICAgICAgICBSZWFkIEJ5IFR5cGUgUmVx
dWVzdCAoMHgwOCkKICAgICAgICBIYW5kbGU6IDB4MDAwZQogICAgICAgIEVycm9yOiBBdHRyaWJ1
dGUgTm90IEZvdW5kICgweDBhKQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNr
ZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDYyLjM0OTk4NAog
ICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2NAogICAgICAgIENvdW50OiAx
Cj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NCBmbGFncyAweDAyIGRsZW4gMTEgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBbaGNpMF0gNjcuMTA2NzczCiAgICAgIEFUVDogUmVhZCBCeSBU
eXBlIFJlcXVlc3QgKDB4MDgpIGxlbiA2CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMGUtMHgw
MDFkCiAgICAgICAgQXR0cmlidXRlIHR5cGU6IENoYXJhY3RlcmlzdGljICgweDI4MDMpCjwgQUNM
IERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRsZW4gMjcgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBbaGNpMF0gNjcuMTA3MDc1CjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBm
bGFncyAweDAxIGRsZW4gMjcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0g
NjcuMTA3MDg4CjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAxIGRsZW4gMTUgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gNjcuMTA3MDkxCiAgICAgIEFUVDog
UmVhZCBCeSBUeXBlIFJlc3BvbnNlICgweDA5KSBsZW4gNjQKICAgICAgICBBdHRyaWJ1dGUgZGF0
YSBsZW5ndGg6IDIxCiAgICAgICAgQXR0cmlidXRlIGRhdGEgbGlzdDogMyBlbnRyaWVzCiAgICAg
ICAgSGFuZGxlOiAweDAwMGYKICAgICAgICBWYWx1ZTogOGExMDAwZjVkZWJjOWE3ODU2MzQxMjc4
NTYzNDEyNzg1NjM0MTIKICAgICAgICBIYW5kbGU6IDB4MDAxNAogICAgICAgIFZhbHVlOiA4YTE1
MDBmMWRlYmM5YTc4NTYzNDEyNzg1NjM0MTI3ODU2MzQxMgogICAgICAgIEhhbmRsZTogMHgwMDE5
CiAgICAgICAgVmFsdWU6IDhhMWEwMGYzZGViYzlhNzg1NjM0MTI3ODU2MzQxMjc4NTYzNDEyCj4g
SENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBbaGNpMF0gNjcuMzUwMDM3CiAgICAgICAgTnVtIGhhbmRsZXM6IDEK
ICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAgQ291bnQ6IDEKPiBIQ0kgRXZlbnQ6IE51bWJlciBv
ZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFto
Y2kwXSA2OS42MDYwNzAKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogNjQK
ICAgICAgICBDb3VudDogMgo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMiBkbGVu
IDExICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDcyLjEwMTk0NQogICAg
ICBBVFQ6IFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4KSBsZW4gNgogICAgICAgIEhhbmRsZSBy
YW5nZTogMHgwMDFhLTB4MDAxZAogICAgICAgIEF0dHJpYnV0ZSB0eXBlOiBDaGFyYWN0ZXJpc3Rp
YyAoMHgyODAzKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVuIDkgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDcyLjEwMjI0NAogICAgICBBVFQ6
IEVycm9yIFJlc3BvbnNlICgweDAxKSBsZW4gNAogICAgICAgIFJlYWQgQnkgVHlwZSBSZXF1ZXN0
ICgweDA4KQogICAgICAgIEhhbmRsZTogMHgwMDFhCiAgICAgICAgRXJyb3I6IEF0dHJpYnV0ZSBO
b3QgRm91bmQgKDB4MGEpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMg
KDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gNzIuMzUxMTA2CiAgICAg
ICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAgQ291bnQ6IDEKPiBB
Q0wgRGF0YSBSWDogSGFuZGxlIDY0IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFtoY2kwXSA3Ny4wOTY3NDYKICAgICAgQVRUOiBGaW5kIEluZm9ybWF0
aW9uIFJlcXVlc3QgKDB4MDQpIGxlbiA0CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMTEtMHgw
MDEzCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRsZW4gMTAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gNzcuMDk3MDQwCiAgICAgIEFUVDogRmluZCBJ
bmZvcm1hdGlvbiBSZXNwb25zZSAoMHgwNSkgbGVuIDUKICAgICAgICBGb3JtYXQ6IFVVSUQtMTYg
KDB4MDEpCiAgICAgICAgSGFuZGxlOiAweDAwMTEKICAgICAgICBVVUlEOiBDaGFyYWN0ZXJpc3Rp
YyBFeHRlbmRlZCBQcm9wZXJ0aWVzICgweDI5MDApCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29t
cGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0g
NzcuMjI2MTM1CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAg
ICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY0IGZsYWdzIDB4MDIgZGxlbiA5ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSA4Mi4wOTE3OTMKICAgICAgQVRU
OiBGaW5kIEluZm9ybWF0aW9uIFJlcXVlc3QgKDB4MDQpIGxlbiA0CiAgICAgICAgSGFuZGxlIHJh
bmdlOiAweDAwMTItMHgwMDEzCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRs
ZW4gMjQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gODIuMDkyMDQ5CiAg
ICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25zZSAoMHgwNSkgbGVuIDE5CiAgICAgICAg
Rm9ybWF0OiBVVUlELTEyOCAoMHgwMikKICAgICAgICBIYW5kbGU6IDB4MDAxMgogICAgICAgIFVV
SUQ6IFZlbmRvciBzcGVjaWZpYyAoMTIzNDU2NzgtMTIzNC01Njc4LTEyMzQtNTY3ODlhYmNkZWY2
KQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDgyLjIyNzE5NAogICAgICAgIE51bSBoYW5kbGVz
OiAxCiAgICAgICAgSGFuZGxlOiA2NAogICAgICAgIENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhh
bmRsZSA2NCBmbGFncyAweDAyIGRsZW4gOSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBbaGNpMF0gODcuMDg2ODQ2CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXF1ZXN0ICgw
eDA0KSBsZW4gNAogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDEzLTB4MDAxMwo8IEFDTCBEYXRh
IFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVuIDEwICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgW2hjaTBdIDg3LjA4NzE3OAogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVz
cG9uc2UgKDB4MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0OiBVVUlELTE2ICgweDAxKQogICAgICAg
IEhhbmRsZTogMHgwMDEzCiAgICAgICAgVVVJRDogQ2hhcmFjdGVyaXN0aWMgVXNlciBEZXNjcmlw
dGlvbiAoMHgyOTAxKQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBsZXRlZCBQYWNrZXRzICgw
eDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDg3LjIyNzIzMQogICAgICAg
IE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2NAogICAgICAgIENvdW50OiAxCj4gQUNM
IERhdGEgUlg6IEhhbmRsZSA2NCBmbGFncyAweDAyIGRsZW4gOSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBbaGNpMF0gOTIuMDgxODk2CiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlv
biBSZXF1ZXN0ICgweDA0KSBsZW4gNAogICAgICAgIEhhbmRsZSByYW5nZTogMHgwMDE2LTB4MDAx
OAo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVuIDEwICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDkyLjA4MjE5NwogICAgICBBVFQ6IEZpbmQgSW5m
b3JtYXRpb24gUmVzcG9uc2UgKDB4MDUpIGxlbiA1CiAgICAgICAgRm9ybWF0OiBVVUlELTE2ICgw
eDAxKQogICAgICAgIEhhbmRsZTogMHgwMDE2CiAgICAgICAgVVVJRDogQ2hhcmFjdGVyaXN0aWMg
RXh0ZW5kZWQgUHJvcGVydGllcyAoMHgyOTAwKQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENvbXBs
ZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDky
LjIyNzI5MgogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2NAogICAgICAg
IENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NCBmbGFncyAweDAyIGRsZW4gOSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gOTcuMDc3MDcwCiAgICAgIEFUVDog
RmluZCBJbmZvcm1hdGlvbiBSZXF1ZXN0ICgweDA0KSBsZW4gNAogICAgICAgIEhhbmRsZSByYW5n
ZTogMHgwMDE3LTB4MDAxOAo8IEFDTCBEYXRhIFRYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMCBkbGVu
IDI0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDk3LjA3NzMxOAogICAg
ICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVzcG9uc2UgKDB4MDUpIGxlbiAxOQogICAgICAgIEZv
cm1hdDogVVVJRC0xMjggKDB4MDIpCiAgICAgICAgSGFuZGxlOiAweDAwMTcKICAgICAgICBVVUlE
OiBWZW5kb3Igc3BlY2lmaWMgKDEyMzQ1Njc4LTEyMzQtNTY3OC0xMjM0LTU2Nzg5YWJjZGVmMikK
PiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFtoY2kwXSA5Ny4yMjgzMzIKICAgICAgICBOdW0gaGFuZGxlczog
MQogICAgICAgIEhhbmRsZTogNjQKICAgICAgICBDb3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5k
bGUgNjQgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBb
aGNpMF0gMTAyLjA3MjExNwogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24gUmVxdWVzdCAoMHgw
NCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAxOC0weDAwMTgKPCBBQ0wgRGF0YSBU
WDogSGFuZGxlIDY0IGZsYWdzIDB4MDAgZGxlbiAxMCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgW2hjaTBdIDEwMi4wNzIzMjgKICAgICAgQVRUOiBGaW5kIEluZm9ybWF0aW9uIFJlc3Bv
bnNlICgweDA1KSBsZW4gNQogICAgICAgIEZvcm1hdDogVVVJRC0xNiAoMHgwMSkKICAgICAgICBI
YW5kbGU6IDB4MDAxOAogICAgICAgIFVVSUQ6IENoYXJhY3RlcmlzdGljIFVzZXIgRGVzY3JpcHRp
b24gKDB4MjkwMSkKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgx
MykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDEwMi4yMjgzODIKICAgICAgICBO
dW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogNjQKICAgICAgICBDb3VudDogMQo+IEFDTCBE
YXRhIFJYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBbaGNpMF0gMTA3LjA2NzE3MQogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24g
UmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAxYi0weDAwMWQK
PCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY0IGZsYWdzIDB4MDAgZGxlbiAxMCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgW2hjaTBdIDEwNy4wNjc0NzAKICAgICAgQVRUOiBGaW5kIEluZm9y
bWF0aW9uIFJlc3BvbnNlICgweDA1KSBsZW4gNQogICAgICAgIEZvcm1hdDogVVVJRC0xNiAoMHgw
MSkKICAgICAgICBIYW5kbGU6IDB4MDAxYgogICAgICAgIFVVSUQ6IENoYXJhY3RlcmlzdGljIEV4
dGVuZGVkIFByb3BlcnRpZXMgKDB4MjkwMCkKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0
ZWQgUGFja2V0cyAoMHgxMykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDEwNy4y
Mjk0MzMKICAgICAgICBOdW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogNjQKICAgICAgICBD
b3VudDogMQo+IEFDTCBEYXRhIFJYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0gMTEyLjA2MjM0NQogICAgICBBVFQ6IEZp
bmQgSW5mb3JtYXRpb24gUmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFuZ2U6
IDB4MDAxYy0weDAwMWQKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY0IGZsYWdzIDB4MDAgZGxlbiAy
NCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDExMi4wNjI1ODQKICAgICAg
QVRUOiBGaW5kIEluZm9ybWF0aW9uIFJlc3BvbnNlICgweDA1KSBsZW4gMTkKICAgICAgICBGb3Jt
YXQ6IFVVSUQtMTI4ICgweDAyKQogICAgICAgIEhhbmRsZTogMHgwMDFjCiAgICAgICAgVVVJRDog
VmVuZG9yIHNwZWNpZmljICgxMjM0NTY3OC0xMjM0LTU2NzgtMTIzNC01Njc4OWFiY2RlZjQpCj4g
SENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFtoY2kwXSAxMTIuMjI5NTA4CiAgICAgICAgTnVtIGhhbmRsZXM6IDEK
ICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxl
IDY0IGZsYWdzIDB4MDIgZGxlbiA5ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hj
aTBdIDExNy4wNTczOTYKICAgICAgQVRUOiBGaW5kIEluZm9ybWF0aW9uIFJlcXVlc3QgKDB4MDQp
IGxlbiA0CiAgICAgICAgSGFuZGxlIHJhbmdlOiAweDAwMWQtMHgwMDFkCjwgQUNMIERhdGEgVFg6
IEhhbmRsZSA2NCBmbGFncyAweDAwIGRsZW4gMTAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFtoY2kwXSAxMTcuMDU3NzAxCiAgICAgIEFUVDogRmluZCBJbmZvcm1hdGlvbiBSZXNwb25z
ZSAoMHgwNSkgbGVuIDUKICAgICAgICBGb3JtYXQ6IFVVSUQtMTYgKDB4MDEpCiAgICAgICAgSGFu
ZGxlOiAweDAwMWQKICAgICAgICBVVUlEOiBDaGFyYWN0ZXJpc3RpYyBVc2VyIERlc2NyaXB0aW9u
ICgweDI5MDEpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMp
IHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAxMTcuMjI5NTM0CiAgICAgICAgTnVt
IGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0
YSBSWDogSGFuZGxlIDY0IGZsYWdzIDB4MDIgZGxlbiAxMSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgW2hjaTBdIDEyMi4wNTI3MDEKICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVxdWVz
dCAoMHgwOCkgbGVuIDYKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAxZS0weDAwMjUKICAgICAg
ICBBdHRyaWJ1dGUgdHlwZTogSW5jbHVkZSAoMHgyODAyKQo8IEFDTCBEYXRhIFRYOiBIYW5kbGUg
NjQgZmxhZ3MgMHgwMCBkbGVuIDkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNp
MF0gMTIyLjA1MzAwNgogICAgICBBVFQ6IEVycm9yIFJlc3BvbnNlICgweDAxKSBsZW4gNAogICAg
ICAgIFJlYWQgQnkgVHlwZSBSZXF1ZXN0ICgweDA4KQogICAgICAgIEhhbmRsZTogMHgwMDFlCiAg
ICAgICAgRXJyb3I6IEF0dHJpYnV0ZSBOb3QgRm91bmQgKDB4MGEpCj4gSENJIEV2ZW50OiBOdW1i
ZXIgb2YgQ29tcGxldGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFtoY2kwXSAxMjIuMjMwNTc2CiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6
IDY0CiAgICAgICAgQ291bnQ6IDEKPiBBQ0wgRGF0YSBSWDogSGFuZGxlIDY0IGZsYWdzIDB4MDIg
ZGxlbiAxMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDEyNy4wNDc3ODMK
ICAgICAgQVRUOiBSZWFkIEJ5IFR5cGUgUmVxdWVzdCAoMHgwOCkgbGVuIDYKICAgICAgICBIYW5k
bGUgcmFuZ2U6IDB4MDAxZS0weDAwMjUKICAgICAgICBBdHRyaWJ1dGUgdHlwZTogQ2hhcmFjdGVy
aXN0aWMgKDB4MjgwMykKPCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY0IGZsYWdzIDB4MDAgZGxlbiAy
NyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDEyNy4wNDgwNzIKICAgICAg
QVRUOiBSZWFkIEJ5IFR5cGUgUmVzcG9uc2UgKDB4MDkpIGxlbiAyMgogICAgICAgIEF0dHJpYnV0
ZSBkYXRhIGxlbmd0aDogNwogICAgICAgIEF0dHJpYnV0ZSBkYXRhIGxpc3Q6IDMgZW50cmllcwog
ICAgICAgIEhhbmRsZTogMHgwMDFmCiAgICAgICAgVmFsdWU6IDAyMjAwMDM4MmEKICAgICAgICBI
YW5kbGU6IDB4MDAyMQogICAgICAgIFZhbHVlOiAxMDIyMDAzNzJhCiAgICAgICAgSGFuZGxlOiAw
eDAwMjQKICAgICAgICBWYWx1ZTogMDgyNTAwMzkyYQo+IEhDSSBFdmVudDogTnVtYmVyIG9mIENv
bXBsZXRlZCBQYWNrZXRzICgweDEzKSBwbGVuIDUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbaGNpMF0g
MTI3LjIzMDY2NAogICAgICAgIE51bSBoYW5kbGVzOiAxCiAgICAgICAgSGFuZGxlOiA2NAogICAg
ICAgIENvdW50OiAxCj4gQUNMIERhdGEgUlg6IEhhbmRsZSA2NCBmbGFncyAweDAyIGRsZW4gMTEg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAxMzIuMDQyNjY1CiAgICAgIEFU
VDogUmVhZCBCeSBUeXBlIFJlcXVlc3QgKDB4MDgpIGxlbiA2CiAgICAgICAgSGFuZGxlIHJhbmdl
OiAweDAwMjUtMHgwMDI1CiAgICAgICAgQXR0cmlidXRlIHR5cGU6IENoYXJhY3RlcmlzdGljICgw
eDI4MDMpCjwgQUNMIERhdGEgVFg6IEhhbmRsZSA2NCBmbGFncyAweDAwIGRsZW4gOSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAxMzIuMDQyOTM2CiAgICAgIEFUVDogRXJy
b3IgUmVzcG9uc2UgKDB4MDEpIGxlbiA0CiAgICAgICAgUmVhZCBCeSBUeXBlIFJlcXVlc3QgKDB4
MDgpCiAgICAgICAgSGFuZGxlOiAweDAwMjUKICAgICAgICBFcnJvcjogQXR0cmlidXRlIE5vdCBG
b3VuZCAoMHgwYSkKPiBIQ0kgRXZlbnQ6IE51bWJlciBvZiBDb21wbGV0ZWQgUGFja2V0cyAoMHgx
MykgcGxlbiA1ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2hjaTBdIDEzMi4yMzE2NTIKICAgICAgICBO
dW0gaGFuZGxlczogMQogICAgICAgIEhhbmRsZTogNjQKICAgICAgICBDb3VudDogMQo+IEFDTCBE
YXRhIFJYOiBIYW5kbGUgNjQgZmxhZ3MgMHgwMiBkbGVuIDkgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBbaGNpMF0gMTM3LjAzNzU5OAogICAgICBBVFQ6IEZpbmQgSW5mb3JtYXRpb24g
UmVxdWVzdCAoMHgwNCkgbGVuIDQKICAgICAgICBIYW5kbGUgcmFuZ2U6IDB4MDAyMy0weDAwMjMK
PCBBQ0wgRGF0YSBUWDogSGFuZGxlIDY0IGZsYWdzIDB4MDAgZGxlbiAxMCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgW2hjaTBdIDEzNy4wMzc3OTkKICAgICAgQVRUOiBGaW5kIEluZm9y
bWF0aW9uIFJlc3BvbnNlICgweDA1KSBsZW4gNQogICAgICAgIEZvcm1hdDogVVVJRC0xNiAoMHgw
MSkKICAgICAgICBIYW5kbGU6IDB4MDAyMwogICAgICAgIFVVSUQ6IENsaWVudCBDaGFyYWN0ZXJp
c3RpYyBDb25maWd1cmF0aW9uICgweDI5MDIpCj4gSENJIEV2ZW50OiBOdW1iZXIgb2YgQ29tcGxl
dGVkIFBhY2tldHMgKDB4MTMpIHBsZW4gNSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtoY2kwXSAxMzcu
MjMxNzMxCiAgICAgICAgTnVtIGhhbmRsZXM6IDEKICAgICAgICBIYW5kbGU6IDY0CiAgICAgICAg
Q291bnQ6IDEK
--=_89eaf6877e97e1012613e971c29ed285--
