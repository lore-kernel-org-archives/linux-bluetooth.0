Return-Path: <cyrus@holtmann.org>
Message-ID: <5506E715.3000709@ubnt.com>
Date: Mon, 16 Mar 2015 16:22:13 +0200
From: Andrejs Hanins <andrejs.hanins@ubnt.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>,
	Arman Uguray <armansito@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcin Kraglak <marcin.kraglak@tieto.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: Re: Non-consecutive handle values in GATT
References: <54F752D8.1000605@ubnt.com>	<CAHrH25RVKCL9RQCeFBJAsUsNV1umOR92VWV1JQgkwy-RNh-GAg@mail.gmail.com>	<CAN_7+Yagp-R+H+nhCtmdqWyAJm4jO_VsB5c343A=39zurwqpPw@mail.gmail.com>	<007858C7-D538-407D-8212-D3B0CB880165@ubnt.com>	<CABBYNZLKfh7xPufAMfjG6P--Q-NkOVq4oYUdXEpqc5WsvQpu2g@mail.gmail.com>	<CABBYNZLHtCJCoUp_4miapZJOReh=FP4_sJVFkyh5uE+NHV2x=A@mail.gmail.com>	<5506D8AB.1040903@ubnt.com>	<5506E0A6.1080709@ubnt.com> <CABBYNZKg1gMsoZyD4mHiZDiGkvFuzAcTPGauFTaLRr0V7ntkbg@mail.gmail.com>
In-Reply-To: <CABBYNZKg1gMsoZyD4mHiZDiGkvFuzAcTPGauFTaLRr0V7ntkbg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------090409040109080303000703"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090409040109080303000703
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Luiz,

On 2015.03.16. 16:13, Luiz Augusto von Dentz wrote:
> Hi Andrejs,
> 
> On Mon, Mar 16, 2015 at 3:54 PM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
>> Luiz,
>>
>> On 2015.03.16. 15:20, Andrejs Hanins wrote:
>>> Hi Luiz,
>>>
>>> On 2015.03.16. 13:05, Luiz Augusto von Dentz wrote:
>>>> Hi Andrejs,
>>>>
>>>> On Thu, Mar 5, 2015 at 10:39 AM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> Hi Andrejs,
>>>>>
>>>>> On Thu, Mar 5, 2015 at 12:34 AM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
>>>>>>
>>>>>>
>>>>>>> On 05 Mar 2015, at 00:21, Lukasz Rymanowski <lukasz.rymanowski@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi Andrejs,
>>>>>>>
>>>>>>>> On Wed, Mar 4, 2015 at 10:39 PM, Arman Uguray <armansito@chromium.org> wrote:
>>>>>>>> Hi Andrejs,
>>>>>>>>
>>>>>>>>> On Wed, Mar 4, 2015 at 10:45 AM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>>    I'm experimenting with an LE peripheral device which provides GATT
>>>>>>>>> services described by attributes with non-consecutive handle values, i.e.
>>>>>>>>> there are "gaps" between handle values. According to the Bluetooth Core
>>>>>>>>> specification 4.0 (Volume 3, Part G, "2.5.1 Overview") it is allowed:
>>>>>>>>>
>>>>>>>>>     Although the Attribute Handle values are in increasing order, following
>>>>>>>>> Attribute Handle values may differ by more than one.
>>>>>>>>>
>>>>>>>>>    Based on my experiments, BlueZ 5.28 and also git-master as of today does
>>>>>>>>> not support non-consecutive handle values GATT table. As a result, I can't
>>>>>>>>> connect to my device because gatt-client fails to initialize properly. The
>>>>>>>>> failing place is in discover_descs():
>>>>>>>>>
>>>>>>>>>      if (gatt_db_attribute_get_handle(attr) !=
>>>>>>>>>                            chrc_data->value_handle)
>>>>>>>>>            goto failed;
>>>>>>>>>
>>>>>>>>>    The value of chrc_data->value_handle is correct and matches GATT table
>>>>>>>>> one the device, but the attr->handle has the value of previous attribute
>>>>>>>>> (Primary Service UUID in my case) +2. This handle value calculation happens
>>>>>>>>> in gatt_db_service_add_characteristic() which has strange code:
>>>>>>>>>
>>>>>>>>>    /* We set handle of characteristic value, which will be added next */
>>>>>>>>>    put_le16(get_handle_at_index(service, i - 1) + 2, &value[1]);
>>>>>>>>>
>>>>>>>>>    Before trying to fix the problem by myself it would be great to hear
>>>>>>>>> some comments about this issue. Does it seem like a bug or I missed
>>>>>>>>> something?
>>>>>>>>>
>>>>>>>>>    As a note, I can successfully connect to my LE peripheral from an iPhone
>>>>>>>>> LightBlue app, which does not posses any issues during GATT discovery and
>>>>>>>>> can read/write the characteristic on the device.
>>>>>>>
>>>>>>> Can you share what device are you using? Is it on the market already?
>>>>>>> I'm just curious as I haven't seen any device doing it on last couple UPFs
>>>>>>>
>>>>>>> But indeed, it looks like this is something we need to fix.
>>>>>> It's a Broadcom dev kit for LE development. I'm running one of Broadcom examples which has non-consecutive handle values within single service. Of course, there is a full control over GATT and we can change handle values to be on +1 basis, no big deal, but in general BT core specs do not require it, so fix is nice to have to be on a safe side in case there will be such device in a wild. I spent a day to understand it digging the code :)
>>>>>>
>>>>>
>>>>> I guess because it is a low level API you can basically use whatever
>>>>> handles you want, probably OS API would not allow that but as you said
>>>>> we may encounter devices out in the market that do that already.
>>>>>
>>>>>>> \Lukasz
>>>>>>>>
>>>>>>>> This is interesting. The gatt-db was initially designed for the
>>>>>>>> server-role, with the assumption being that the handles of a service
>>>>>>>> will be contiguous. So, it allows gaps between separate service ranges
>>>>>>>> but not between individual attributes between the handles of a
>>>>>>>> service. This assumption is OK for server-role but now that we also
>>>>>>>> use gatt-db for the client role, then maybe this assumption is
>>>>>>>> incorrect in some cases.
>>>>>>>>
>>>>>>>> So I guess we need a way to enter individual attributes with arbitrary
>>>>>>>> handles directly into the database, since it currently creates a
>>>>>>>> contiguous array to store the attributes of a service. I remember Luiz
>>>>>>>> was talking about changing the way the gatt-db addition/removal works
>>>>>>>> on IRC so maybe he can provide more input here. Fwiw, we never
>>>>>>>> encountered this issue because in practice I've never seen a database
>>>>>>>> implementation that skips attribute handles within a service.
>>>>>
>>>>> Well that was not exactly the problem I was discussing, but anyway it
>>>>> is a problem that we need to fix. Id probably start by adding a unit
>>>>> test where a service skips handles and then fix the gatt_db
>>>>> implementation to handle that, speaking about implementation we could
>>>>> either go with list but the entries would then need to store the
>>>>> handles separately or we keep the current array and leave the gaps
>>>>> with NULL pointers, I guess the later is still more efficient since we
>>>>> are talking about a special case and storing the handles per list
>>>>> entry might increase our memory consumption.
>>>>
>>>> I just posted a patch-set that attempts to fix this, at least with
>>>> unit test Ive created it seems to work but I would appreciate if you
>>>> could try with your setup as well.
>>> Tried on 0d468ec37cf42915f5873a40185b5f3a588c28ba and it still fails for my device. FYI - iOS and Android can successfully connect to this device and discover characteristics. Here is some analysis I made which might help you:
>>>
>>> < HCI Command: LE Create Connection (0x08|0x000d) plen 25
>>>     bdaddr 20:73:6A:17:69:31 type 0
>>>     interval 96 window 48 initiator_filter 0
>>>     own_bdaddr_type 0 min_interval 40 max_interval 56
>>>     latency 0 supervision_to 42 min_ce 0 max_ce 0
>>>> HCI Event: Command Status (0x0f) plen 4
>>>     LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
>>>> HCI Event: LE Meta Event (0x3e) plen 19
>>>     LE Connection Complete
>>>       status 0x00 handle 64, role master
>>>       bdaddr 20:73:6A:17:69:31 (Public)
>>> < ACL data: handle 64 flags 0x00 dlen 7
>>>     ATT: MTU req (0x02)
>>>       client rx mtu 517
>>>> ACL data: handle 64 flags 0x02 dlen 7
>>>     ATT: MTU resp (0x03)
>>>       server rx mtu 23
>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>     ATT: Read By Group req (0x10)
>>>       start 0x0001, end 0xffff
>>>       type-uuid 0x2800
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>     handle 64 packets 1
>>>> ACL data: handle 64 flags 0x02 dlen 18
>>>     ATT: Read By Group resp (0x11)
>>>       attr handle 0x0100, end group handle 0x0121
>>>       value 0x00 0x18
>>>       attr handle 0x0200, end group handle 0x0200
>>>       value 0x01 0x18
>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>     ATT: Read By Group req (0x10)
>>>       start 0x0201, end 0xffff
>>>       type-uuid 0x2800
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>     handle 64 packets 2
>>>> ACL data: handle 64 flags 0x02 dlen 26
>>>     ATT: Read By Group resp (0x11)
>>>       attr handle 0x0300, end group handle 0x0320
>>>       value 0xbf 0x90 0x21 0x8e 0xc0 0x68 0x4c 0x00 0x84 0x01 0x2d 0xba 0x08 0xab 0x32 0x88
>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>     ATT: Read By Group req (0x10)
>>>       start 0x0321, end 0xffff
>>>       type-uuid 0x2800
>>>> ACL data: handle 64 flags 0x02 dlen 9
>>>     ATT: Error (0x01)
>>>       Error: Attribute not found (10)
>>>       Read By Group req (0x10) on handle 0x0321
>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>     ATT: Read By Group req (0x10)
>>>       start 0x0001, end 0xffff
>>>       type-uuid 0x2801
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>     handle 64 packets 2
>>>> ACL data: handle 64 flags 0x02 dlen 9
>>>     ATT: Error (0x01)
>>>       Error: Attribute not found (10)
>>>       Read By Group req (0x10) on handle 0x0001
>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>     ATT: Read By Type req (0x08)
>>>       start 0x0100, end 0x0121
>>>       type-uuid 0x2802
>>>> ACL data: handle 64 flags 0x02 dlen 9
>>>     ATT: Error (0x01)
>>>       Error: Attribute not found (10)
>>>       Read By Type req (0x08) on handle 0x0100
>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>     ATT: Read By Type req (0x08)
>>>       start 0x0300, end 0x0320
>>>       type-uuid 0x2802
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>     handle 64 packets 2
>>>> ACL data: handle 64 flags 0x02 dlen 9
>>>     ATT: Error (0x01)
>>>       Error: Attribute not found (10)
>>>       Read By Type req (0x08) on handle 0x0300
>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>     ATT: Read By Type req (0x08)
>>>       start 0x0100, end 0x0121
>>>       type-uuid 0x2803                    <---- Characteristics in range 0x0100-0x0121 are requested.
>>>
>>>
>>>> ACL data: handle 64 flags 0x02 dlen 20
>>>     ATT: Read By Type resp (0x09)
>>>       length: 7
>>>         handle 0x0110, value 0x02 0x11 0x01 0x00 0x2a
>>>         handle 0x0120, value 0x02 0x21 0x01 0x01 0x2a  <---- Rsp: Chrc with descriptor handle 0x0120, value handle 0x0121 and standard 16bit UUID=0x2a01 ("Characteristic appearance")
>>>
>>>
>>> < ACL data: handle 64 flags 0x00 dlen 11
>>>     ATT: Read By Type req (0x08)
>>>       start 0x0121, end 0x0121
>>>       type-uuid 0x2803     <--- Here request is made for a single attribute with handle 0x0121 which is supposed to have UUID 0x2a01, as per previous response, but the request suggests that type should be UUID 0x2803 (Characteristic descriptor), which is wrong.
>>>
>>>
>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>     handle 64 packets 2
>>>> ACL data: handle 64 flags 0x02 dlen 9
>>>     ATT: Error (0x01)
>>>       Error: Attribute not found (10)
>>>       Read By Type req (0x08) on handle 0x0121  <---- As expected, there is no such attribute with handle 0x0121 and UUID 0x2803. A valid att request is for handle 0x0121 and UUID 0x2a01.
>>>
>>>
>>>
>>> < HCI Command: Disconnect (0x01|0x0006) plen 3
>>>     handle 64 reason 0x13
>>>     Reason: Remote User Terminated Connection
>>>> HCI Event: Command Status (0x0f) plen 4
>>>     Disconnect (0x01|0x0006) status 0x00 ncmd 1
>>>> HCI Event: Disconn Complete (0x05) plen 4
>>>     status 0x00 handle 64 reason 0x16
>>>     Reason: Connection Terminated by Local Host
>>>
>> Sorry, the test above was made with latest master *without* your patches. I re-run the test with a patch from e-mail, but discovery still fails, however the dump output is slightly different:
>>
>> < HCI Command: LE Create Connection (0x08|0x000d) plen 25
>>     bdaddr 20:73:6A:17:69:31 type 0
>>     interval 96 window 48 initiator_filter 0
>>     own_bdaddr_type 0 min_interval 40 max_interval 56
>>     latency 0 supervision_to 42 min_ce 0 max_ce 0
>>> HCI Event: Command Status (0x0f) plen 4
>>     LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
>>> HCI Event: LE Meta Event (0x3e) plen 19
>>     LE Connection Complete
>>       status 0x00 handle 64, role master
>>       bdaddr 20:73:6A:17:69:31 (Public)
>> < ACL data: handle 64 flags 0x00 dlen 7
>>     ATT: MTU req (0x02)
>>       client rx mtu 517
>>> ACL data: handle 64 flags 0x02 dlen 7
>>     ATT: MTU resp (0x03)
>>       server rx mtu 23
>> < ACL data: handle 64 flags 0x00 dlen 11
>>     ATT: Read By Group req (0x10)
>>       start 0x0001, end 0xffff
>>       type-uuid 0x2800
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 64 packets 1
>>> ACL data: handle 64 flags 0x02 dlen 18
>>     ATT: Read By Group resp (0x11)
>>       attr handle 0x0100, end group handle 0x0121
>>       value 0x00 0x18
>>       attr handle 0x0200, end group handle 0x0200
>>       value 0x01 0x18
>> < ACL data: handle 64 flags 0x00 dlen 11
>>     ATT: Read By Group req (0x10)
>>       start 0x0201, end 0xffff
>>       type-uuid 0x2800
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 64 packets 2
>>> ACL data: handle 64 flags 0x02 dlen 26
>>     ATT: Read By Group resp (0x11)
>>       attr handle 0x0300, end group handle 0x0320
>>       value 0xbf 0x90 0x21 0x8e 0xc0 0x68 0x4c 0x00 0x84 0x01 0x2d 0xba 0x08 0xab 0x32 0x88
>> < ACL data: handle 64 flags 0x00 dlen 11
>>     ATT: Read By Group req (0x10)
>>       start 0x0321, end 0xffff
>>       type-uuid 0x2800
>>> ACL data: handle 64 flags 0x02 dlen 9
>>     ATT: Error (0x01)
>>       Error: Attribute not found (10)
>>       Read By Group req (0x10) on handle 0x0321
>> < ACL data: handle 64 flags 0x00 dlen 11
>>     ATT: Read By Group req (0x10)
>>       start 0x0001, end 0xffff
>>       type-uuid 0x2801
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 64 packets 2
>>> ACL data: handle 64 flags 0x02 dlen 9
>>     ATT: Error (0x01)
>>       Error: Attribute not found (10)
>>       Read By Group req (0x10) on handle 0x0001
>> < ACL data: handle 64 flags 0x00 dlen 11
>>     ATT: Read By Type req (0x08)
>>       start 0x0100, end 0x0121
>>       type-uuid 0x2802
>>> ACL data: handle 64 flags 0x02 dlen 9
>>     ATT: Error (0x01)
>>       Error: Attribute not found (10)
>>       Read By Type req (0x08) on handle 0x0100
>> < ACL data: handle 64 flags 0x00 dlen 11
>>     ATT: Read By Type req (0x08)
>>       start 0x0300, end 0x0320
>>       type-uuid 0x2802
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 64 packets 2
>>> ACL data: handle 64 flags 0x02 dlen 9
>>     ATT: Error (0x01)
>>       Error: Attribute not found (10)
>>       Read By Type req (0x08) on handle 0x0300
>> < ACL data: handle 64 flags 0x00 dlen 11
>>     ATT: Read By Type req (0x08)
>>       start 0x0100, end 0x0121
>>       type-uuid 0x2803
>>> ACL data: handle 64 flags 0x02 dlen 20
>>     ATT: Read By Type resp (0x09)
>>       length: 7
>>         handle 0x0110, value 0x02 0x11 0x01 0x00 0x2a
>>         handle 0x0120, value 0x02 0x21 0x01 0x01 0x2a
>> < ACL data: handle 64 flags 0x00 dlen 11
>>     ATT: Read By Type req (0x08)
>>       start 0x0121, end 0x0121
>>       type-uuid 0x2803      <--- as without patch, this seems to be suspicious. Single att read request with wrong UUID.
> 
> Maybe this is off by 1 error except if start 0x0100, end 0x0121 range
> actually exclude the last, but it would be still wrong the start
> 0x0121, end 0x0121, anyway this seems to be some other problem.
> 
>>
>>
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 64 packets 2
>>> ACL data: handle 64 flags 0x02 dlen 9
>>     ATT: Error (0x01)
>>       Error: Attribute not found (10)
>>       Read By Type req (0x08) on handle 0x0121
>> < ACL data: handle 64 flags 0x00 dlen 9
>>     ATT: Find Information req (0x04)
>>       start 0x0112, end 0x011f
>>> ACL data: handle 64 flags 0x02 dlen 9
>>     ATT: Error (0x01)
>>       Error: Attribute not found (10)
>>       Find Information req (0x04) on handle 0x0112
>> < ACL data: handle 64 flags 0x00 dlen 11
>>     ATT: Read By Type req (0x08)
>>       start 0x0300, end 0x0320
>>       type-uuid 0x2803
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 64 packets 1
>>> ACL data: handle 64 flags 0x02 dlen 27
>>     ATT: Read By Type resp (0x09)
>>       length: 21
>>         handle 0x0310, value 0x3e 0x11 0x03 0x34 0x5b 0xe2 0x12 0x5e 0xb1 0x45 0x03 0xb6 0x29 0x24 0x55 0x8a 0x11 0x1e 0x36
>> < ACL data: handle 64 flags 0x00 dlen 11
>>     ATT: Read By Type req (0x08)
>>       start 0x0311, end 0x0320
>>       type-uuid 0x2803
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 64 packets 2
>>> ACL data: handle 64 flags 0x02 dlen 9
>>     ATT: Error (0x01)
>>       Error: Attribute not found (10)
>>       Read By Type req (0x08) on handle 0x0311
> 
> Can you collect the trace in binary format, e.g. btmon -w <file>, I
> can perhaps try to create the very same database for unit tests, also
> it would be good to have bluetoothd traces.
Traces attached.

> 
> 

--------------090409040109080303000703
Content-Type: text/x-log;
 name="bluez.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bluez.log"

bluetoothd[30716]: Bluetooth daemon 5.29
bluetoothd[30716]: src/main.c:parse_config() parsing main.conf
bluetoothd[30716]: src/main.c:parse_config() Key file does not have key 'DiscoverableTimeout'
bluetoothd[30716]: src/main.c:parse_config() Key file does not have key 'PairableTimeout'
bluetoothd[30716]: src/main.c:parse_config() Key file does not have key 'AutoConnectTimeout'
bluetoothd[30716]: src/main.c:parse_config() Key file does not have key 'Name'
bluetoothd[30716]: src/main.c:parse_config() Key file does not have key 'Class'
bluetoothd[30716]: src/main.c:parse_config() Key file does not have key 'DeviceID'
bluetoothd[30716]: src/main.c:parse_config() Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[30716]: src/main.c:parse_config() ControllerMode=le
bluetoothd[30716]: src/adapter.c:adapter_init() sending read version command
bluetoothd[30716]: Starting SDP server
bluetoothd[30716]: src/sdpd-service.c:register_device_id() Adding device id record for 0002:1d6b:0246:051d
bluetoothd[30716]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[30716]: src/plugin.c:add_plugin() Loading hostname plugin
bluetoothd[30716]: Ignoring (cli) wiimote
bluetoothd[30716]: Ignoring (cli) autopair
bluetoothd[30716]: Ignoring (cli) policy
bluetoothd[30716]: Ignoring (cli) gatt_example
bluetoothd[30716]: Ignoring (cli) neard
bluetoothd[30716]: Ignoring (cli) sap
bluetoothd[30716]: Ignoring (cli) a2dp
bluetoothd[30716]: Ignoring (cli) avrcp
bluetoothd[30716]: Ignoring (cli) network
bluetoothd[30716]: Ignoring (cli) input
bluetoothd[30716]: Ignoring (cli) hog
bluetoothd[30716]: Ignoring (cli) health
bluetoothd[30716]: Ignoring (cli) gap
bluetoothd[30716]: Ignoring (cli) scanparam
bluetoothd[30716]: Ignoring (cli) deviceinfo
bluetoothd[30716]: Ignoring (cli) alert
bluetoothd[30716]: Ignoring (cli) time
bluetoothd[30716]: Ignoring (cli) proximity
bluetoothd[30716]: Ignoring (cli) thermometer
bluetoothd[30716]: Ignoring (cli) heartrate
bluetoothd[30716]: Ignoring (cli) cyclingspeed
bluetoothd[30716]: src/plugin.c:plugin_init() Loading plugins /home/andrey/git/bluez/plugins/.libs
bluetoothd[30716]: Ignoring (cli) external_dummy
bluetoothd[30716]: src/main.c:main() Entering main loop
bluetoothd[30716]: src/rfkill.c:rfkill_event() RFKILL event idx 1 type 2 op 0 soft 0 hard 0
bluetoothd[30716]: Bluetooth management interface 1.8 initialized
bluetoothd[30716]: src/adapter.c:read_version_complete() sending read supported commands command
bluetoothd[30716]: src/adapter.c:read_version_complete() sending read index list command
bluetoothd[30716]: src/adapter.c:read_commands_complete() Number of commands: 56
bluetoothd[30716]: src/adapter.c:read_commands_complete() Number of events: 29
bluetoothd[30716]: src/adapter.c:read_commands_complete() enabling kernel-side connection control
bluetoothd[30716]: src/adapter.c:read_index_list_complete() Number of controllers: 1
bluetoothd[30716]: src/adapter.c:read_index_list_complete() Found index 0
bluetoothd[30716]: src/adapter.c:index_added() index 0
bluetoothd[30716]: src/adapter.c:btd_adapter_new() System name: BlueZ 5.29
bluetoothd[30716]: src/adapter.c:btd_adapter_new() Major class: 0
bluetoothd[30716]: src/adapter.c:btd_adapter_new() Minor class: 0
bluetoothd[30716]: src/adapter.c:btd_adapter_new() Modalias: usb:v1D6Bp0246d051D
bluetoothd[30716]: src/adapter.c:btd_adapter_new() Discoverable timeout: 180 seconds
bluetoothd[30716]: src/adapter.c:btd_adapter_new() Pairable timeout: 0 seconds
bluetoothd[30716]: src/adapter.c:index_added() sending read info command for index 0
bluetoothd[30716]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[30716]: src/adapter.c:clear_uuids() sending clear uuids command for index 0
bluetoothd[30716]: src/adapter.c:clear_devices() sending clear devices command for index 0
bluetoothd[30716]: src/gatt-database.c:btd_gatt_database_new() GATT Manager registered for adapter: /org/bluez/hci0
bluetoothd[30716]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[30716]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
bluetoothd[30716]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[30716]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[30716]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[30716]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001800-0000-1000-8000-00805f9
bluetoothd[30716]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[30716]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[30716]: src/gatt-database.c:gatt_db_service_added() GATT Service added to local database
bluetoothd[30716]: Failed to obtain handles for "Service Changed" characteristic
bluetoothd[30716]: src/adapter.c:adapter_service_add() /org/bluez/hci0
bluetoothd[30716]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
bluetoothd[30716]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000007-0000-1000-8000-00805f9
bluetoothd[30716]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[30716]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[30716]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001801-0000-1000-8000-00805f9
bluetoothd[30716]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[30716]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[30716]: src/gatt-database.c:gatt_db_service_added() GATT Service added to local database
bluetoothd[30716]: plugins/hostname.c:hostname_probe() 
bluetoothd[30716]: src/adapter.c:btd_adapter_unblock_address() hci0 00:00:00:00:00:00
bluetoothd[30716]: src/adapter.c:load_link_keys() hci0 keys 0 debug_keys 0
bluetoothd[30716]: src/adapter.c:load_ltks() hci0 keys 0
bluetoothd[30716]: src/adapter.c:load_irks() hci0 irks 0
bluetoothd[30716]: src/adapter.c:load_conn_params() hci0 conn params 0
bluetoothd[30716]: src/adapter.c:adapter_service_insert() /org/bluez/hci0
bluetoothd[30716]: src/adapter.c:add_uuid() sending add uuid command for index 0
bluetoothd[30716]: src/adapter.c:set_did() hci0 source 2 vendor 1d6b product 246 version 51d
bluetoothd[30716]: src/adapter.c:adapter_register() Adapter /org/bluez/hci0 registered
bluetoothd[30716]: src/adapter.c:set_dev_class() sending set device class command for index 0
bluetoothd[30716]: src/adapter.c:set_name() sending set local name command for index 0
bluetoothd[30716]: src/adapter.c:load_link_keys_complete() link keys loaded for hci0
bluetoothd[30716]: src/adapter.c:load_ltks_complete() LTKs loaded for hci0
bluetoothd[30716]: src/adapter.c:load_irks_complete() IRKs loaded for hci0
bluetoothd[30716]: src/adapter.c:load_conn_params_complete() Connection Parameters loaded for hci0
bluetoothd[30716]: src/adapter.c:local_name_changed_callback() Name: BlueZ 5.29
bluetoothd[30716]: src/adapter.c:local_name_changed_callback() Short name: 
bluetoothd[30716]: src/adapter.c:local_name_changed_callback() Current alias: BlueZ 5.29
bluetoothd[30716]: plugins/hostname.c:property_changed() static hostname: UFHR
bluetoothd[30716]: plugins/hostname.c:property_changed() pretty hostname: 
bluetoothd[30716]: plugins/hostname.c:update_name() name: UFHR
bluetoothd[30716]: src/adapter.c:adapter_set_name() name: UFHR
bluetoothd[30716]: src/adapter.c:adapter_set_name() alias: UFHR
bluetoothd[30716]: src/adapter.c:set_name() sending set local name command for index 0
bluetoothd[30716]: plugins/hostname.c:property_changed() chassis: vm
bluetoothd[30716]: src/adapter.c:local_name_changed_callback() Name: UFHR
bluetoothd[30716]: src/adapter.c:local_name_changed_callback() Short name: 
bluetoothd[30716]: src/adapter.c:local_name_changed_callback() Current alias: UFHR
bluetoothd[30716]: src/adapter.c:new_settings_callback() Settings: 0x00000a11
bluetoothd[30716]: src/adapter.c:settings_changed() Changed settings: 0x00000001
bluetoothd[30716]: src/adapter.c:adapter_start() adapter /org/bluez/hci0 has been enabled
bluetoothd[30716]: src/adapter.c:trigger_passive_scanning() 
bluetoothd[30716]: src/adapter.c:start_discovery() sender :1.207
bluetoothd[30716]: src/adapter.c:trigger_start_discovery() 
bluetoothd[30716]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[30716]: src/adapter.c:start_discovery_timeout() 
bluetoothd[30716]: src/adapter.c:start_discovery_complete() status 0x00
bluetoothd[30716]: src/adapter.c:discovering_callback() hci0 type 6 discovering 1
bluetoothd[30716]: src/adapter.c:device_found_callback() hci0 addr 20:73:6A:17:69:31, rssi -59 flags 0x0000 eir_len 35
bluetoothd[30716]: src/device.c:device_create() dst 20:73:6A:17:69:31
bluetoothd[30716]: src/device.c:device_new() address 20:73:6A:17:69:31
bluetoothd[30716]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_20_73_6A_17_69_31
bluetoothd[30716]: src/device.c:device_set_legacy() legacy 0
bluetoothd[30716]: src/device.c:device_set_rssi() rssi -59
bluetoothd[30716]: src/adapter.c:device_found_callback() hci0 addr 60:03:08:D2:5B:20, rssi -69 flags 0x0000 eir_len 15
bluetoothd[30716]: src/device.c:device_create() dst 60:03:08:D2:5B:20
bluetoothd[30716]: src/device.c:device_new() address 60:03:08:D2:5B:20
bluetoothd[30716]: src/device.c:device_new() Creating device /org/bluez/hci0/dev_60_03_08_D2_5B_20
bluetoothd[30716]: src/device.c:device_set_legacy() legacy 0
bluetoothd[30716]: src/device.c:device_set_rssi() rssi -69
bluetoothd[30716]: src/adapter.c:stop_discovery() sender :1.207
bluetoothd[30716]: src/adapter.c:discovery_destroy() owner :1.207
bluetoothd[30716]: src/device.c:device_set_rssi() rssi 0
bluetoothd[30716]: src/device.c:device_set_rssi() rssi 0
bluetoothd[30716]: src/adapter.c:stop_discovery_complete() status 0x00
bluetoothd[30716]: src/adapter.c:trigger_passive_scanning() 
bluetoothd[30716]: src/adapter.c:discovering_callback() hci0 type 6 discovering 0
bluetoothd[30716]: src/device.c:btd_device_set_temporary() temporary 0
bluetoothd[30716]: src/device.c:device_connect_le() Connection attempt to: 20:73:6A:17:69:31
bluetoothd[30716]: src/adapter.c:connected_callback() hci0 device 20:73:6A:17:69:31 connected eir_len 0
bluetoothd[30716]: attrib/gattrib.c:g_attrib_ref() 0xefed60: g_attrib_ref=1 
bluetoothd[30716]: src/device.c:gatt_client_ready_cb() status: failed, error: 10
bluetoothd[30716]: src/device.c:gatt_service_removed() start: 0x0100, end: 0x0121
^Cbluetoothd[30716]: Terminating
bluetoothd[30716]: src/adapter.c:adapter_shutdown() 
bluetoothd[30716]: src/adapter.c:set_mode() sending set mode command for index 0
bluetoothd[30716]: src/adapter.c:dev_disconnected() Device 20:73:6A:17:69:31 disconnected, reason 2
bluetoothd[30716]: src/adapter.c:adapter_remove_connection() 
bluetoothd[30716]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 20:73:6A:17:69:31 type 1 status 0xe
bluetoothd[30716]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
bluetoothd[30716]: src/device.c:device_bonding_failed() status 14
bluetoothd[30716]: src/adapter.c:resume_discovery() 
bluetoothd[30716]: src/device.c:att_disconnected_cb() 
bluetoothd[30716]: src/device.c:att_disconnected_cb() Software caused connection abort (103)
bluetoothd[30716]: src/device.c:att_disconnected_cb() Automatic connection disabled
bluetoothd[30716]: attrib/gattrib.c:g_attrib_unref() 0xefed60: g_attrib_unref=0 
bluetoothd[30716]: src/adapter.c:new_settings_callback() Settings: 0x00000a10
bluetoothd[30716]: src/adapter.c:settings_changed() Changed settings: 0x00000001
bluetoothd[30716]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[30716]: src/adapter.c:adapter_stop() adapter /org/bluez/hci0 has been disabled
bluetoothd[30716]: src/plugin.c:plugin_cleanup() Cleanup plugins
bluetoothd[30716]: plugins/hostname.c:hostname_remove() 
bluetoothd[30716]: src/adapter.c:adapter_remove() Removing adapter /org/bluez/hci0
bluetoothd[30716]: src/device.c:device_remove() Removing device /org/bluez/hci0/dev_20_73_6A_17_69_31
bluetoothd[30716]: src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_20_73_6A_17_69_31
bluetoothd[30716]: src/device.c:device_free() 0xefb420
bluetoothd[30716]: src/device.c:device_remove() Removing device /org/bluez/hci0/dev_60_03_08_D2_5B_20
bluetoothd[30716]: src/device.c:btd_device_unref() Freeing device /org/bluez/hci0/dev_60_03_08_D2_5B_20
bluetoothd[30716]: src/device.c:device_free() 0xf02060
bluetoothd[30716]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
bluetoothd[30716]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
bluetoothd[30716]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10002
bluetoothd[30716]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
bluetoothd[30716]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
bluetoothd[30716]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10001
bluetoothd[30716]: src/adapter.c:btd_adapter_unref() Freeing adapter /org/bluez/hci0
bluetoothd[30716]: src/adapter.c:adapter_free() 0xeffc90
bluetoothd[30716]: Stopping SDP server
bluetoothd[30716]: Exit
--------------090409040109080303000703
Content-Type: application/octet-stream;
 name="noncons_handles.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="noncons_handles.dump"

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

--------------090409040109080303000703--
