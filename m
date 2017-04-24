Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 24 Apr 2017 23:23:01 +0200
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
Message-ID: <dbb6f10fa866034e564c9e0fcc194705@labapart.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again,

forget about what I said in my previous email. I thought was an 
incompatibility between Bluez and the Ubuntu 16.04 Linux kernel. But 
after coming back on Bluez v5.37 + additional patchset to add DBus GATT 
Application support - these following patches:

d41a7bf shared/att: Fix not notifying the callback
8d3e9ca core/gatt-database: Don't always wait for response
98bf7ec gdbus/client: Use g_dbus_send_message if callback is not set
b960430 test/example-gatt-server: Don't order objects
9175f5e gatt-database: Fix GATT object ordering
2ba5a6c shared/gatt-client: Fix not detecting BT_ATT_SECURITY_AUTO
24dc645 core/gatt-client: Fix printing errors if experimental is 
disabled
75c0728 shared/gatt-client: Fix not clearing database after discovery
6b86c86 tools/btgatt-client: Fix write-value byte parsing
bdd8b3e tools/avinfo: Fix big endian build
cb1bccf test: Fix scripts to run with python 3
7124468 shared/gatt-client: Fix regression
e4acec5 core/device: Fix not clearing Attributes before storing
0001c4c core/device: Fix not reseting database if attributes cannot be 
loaded
118633b core/device: Fix log when loading characteristic fails
166d698 shared/gatt-client: Rename tmp_queue to svcs
6f211c6 shared/gatt-client: Add debug log if characteristic cannot be 
added
757eef5 client: Fix removing all devices
ad68605 obexd: client: Fix memory leaks
63774ba adapter: Fix memory leak
29e2531 tools/gatt-service: Add missing methods
06ed769 tools/gatt-service: Add missing properties
e76fad8 tools/gatt-service: Fix using RegisterService
f0e5192 client: Fix not detecting connections when starting
6a1f8e6 shared/gatt-client: Fix crash unregistering notification
1561910 shared/gatt-client: Fix bogus asserts
fee0020 core/gatt-client: Fix not being able to cancel notifications
0d9b55c shared/gatt-client: Fix not resetting request id
3213d1a shared/gatt-client: Make read_long_value more robust
54ecf66 monitor/avctp: Print <empty> if folder lenght is 0
28a582b audio/avrcp: Fix not always requesting capabilities
ca5a188 tools/btmgmt: Fix canceling pairing
6304273 client: Update remove command to support removing all devices
4c3c78b test: Add device discovery filter
cdc9435 core/gatt-database: Fix possible memory leaks
cd94d49 gdbus/client: Always call ready callback
758d2b4 test/example-gatt-server: Make use of RegisterApplication
60ebf90 core/gatt-database: Implement Application API
ae78365 doc/gatt-api: Make proper use of ObjectManager
218969a doc: fix typos in mgmt-api.txt
56776af Release 5.37

I still see the long duration during "Discovering Services" while 
connecting with Android.

I added the various log (Bluez + btmon) with the steps I used in this 
Github gist: 
https://gist.github.com/oliviermartin/bef59f3bb9a6e5e2bf2dea5178c429e4

I do not have any suspicious message in 'dmesg'. I have not changed any 
kernel settings to increase bluetooth debug messaging - can I?
I also noticed many time with Android "BLE Scanner", it fails to read 
the Bluez GATT server characteristics when I request reading readable 
characteristics.

What I find suspicious (but I am not a Bluetooth expert) is that there 
are many error messages of this type in btmon log during the Discovering 
Services done by the Android phone:

< ACL Data TX: Handle 64 flags 0x00 dlen 9                               
                                                            [hci0]
       ATT: Error Response (0x01) len 4
         Read By Type Request (0x08)
         Handle: 0x000a
         Error: Attribute Not Found (0x0a)

My bluetooth adapter Asus BT400 in 'dmesg':

[   19.153383] Bluetooth: hci0: BCM20702A1 (001.002.014) build 1467
[   19.169343] Bluetooth: hci0: Broadcom Bluetooth Device

Any idea?


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
