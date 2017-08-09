Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: SEGFAULT in bluetoothd after pairing
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <7fbe9774-18b2-ae82-38f8-0f75e4ee85ad@cisco.com>
 <CABBYNZLUEOz0i_VCEeym0HqyNpmfYhehwfhBQb6TJDLj8sDq-g@mail.gmail.com>
 <ffe831e5-49f6-b877-6bc4-d29b44dd3d3b@cisco.com>
 <476f6fa1-402f-3b87-b2dc-cd9e1c129b88@cisco.com>
 <CABBYNZK=q8cE-AOYU2okEkHvZtfM-802CnO+Zg2MTH_tNchfrA@mail.gmail.com>
From: =?UTF-8?Q?Per_Waag=c3=b8?= <pwaago@cisco.com>
Message-ID: <7ede5d57-8205-bebf-9b22-47ea16eb697c@cisco.com>
Date: Wed, 9 Aug 2017 12:14:35 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZK=q8cE-AOYU2okEkHvZtfM-802CnO+Zg2MTH_tNchfrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On 09. aug. 2017 11:47, Luiz Augusto von Dentz wrote:
> Hi Per,
>
> On Wed, Aug 9, 2017 at 12:18 PM, Per Waagø <pwaago@cisco.com> wrote:
>>
>> On 08. aug. 2017 12:55, Per Waagø wrote:
>>> Hi Luiz,
>>>
>>>
>>> On 08. aug. 2017 12:46, Luiz Augusto von Dentz wrote:
>>>> Hi Per,
>>>>
>>>> On Tue, Aug 8, 2017 at 1:19 PM, Per Waagø <pwaago@cisco.com> wrote:
>>>>> I am working on implementing bluetooth headset support on a system with
>>>>> a
>>>>> Marvell 88W8787 chip. Starting with bluez 5.44 bluetoothd is segfaulting
>>>>> every time I pair with some headset models. I have done a git bisect and
>>>>> found that the behavior was introduced with this commit: "f2483bbfd
>>>>> core:
>>>>> Fix passing correct local address type to ATT socket"
>>>>>
>>>>> This commit changes some initializations of BT_IO_OPT_SOURCE_TYPE that
>>>>> used
>>>>> to be hard coded to BDADDR_LE_PUBLIC to be read from the adapter struct
>>>>> instead, using the new btd_adapter_get_address_type function. The
>>>>> address_type of the adapter is set based on the MGMT_SETTING_LE flag.
>>>>> The
>>>>> 8787 doesn't support bluetooth LE, so address type is set to
>>>>> BDADDR_BREDR.
>>>>>
>>>>> Reverting this chunk eliminates the problem:
>>>>> --- a/src/gatt-database.c
>>>>> +++ b/src/gatt-database.c
>>>>> @@ -2603,7 +2603,8 @@ struct btd_gatt_database
>>>>> *btd_gatt_database_new(struct
>>>>> btd_adapter *adapter)
>>>>>           addr = btd_adapter_get_address(adapter);
>>>>>           database->le_io = bt_io_listen(connect_cb, NULL, NULL, NULL,
>>>>> &gerr,
>>>>> BT_IO_OPT_SOURCE_BDADDR, addr,
>>>>> -                                       BT_IO_OPT_SOURCE_TYPE,
>>>>> BDADDR_LE_PUBLIC,
>>>>> +                                       BT_IO_OPT_SOURCE_TYPE,
>>>>> + btd_adapter_get_address_type(adapter),
>>>>>                                           BT_IO_OPT_CID, ATT_CID,
>>>>>                                           BT_IO_OPT_SEC_LEVEL,
>>>>> BT_IO_SEC_LOW,
>>>>>                                           BT_IO_OPT_INVALID);
>>>>>
>>>>> The source type eventually end up as l2_bdaddr_type in the address
>>>>> assigned
>>>>> to the listening socket. From the debug logs I see the connect_cb in
>>>>> gatt-database.c is called. This does not happen when the source type is
>>>>> set
>>>>> to LE_PUBLIC.
>>>> The headset is most likely trying to connect ATT over BR/EDR which
>>>> perhaps has some unexpected behavior, though we did have some fixes in
>>>> this regard so please try with latest upstream.
>>> I did my testing on latest upstream as of Friday. I rebased now and
>>> retested just to be sure,
>>> with the same result.
>>>
>>>>> Unfortunately, I haven't been able to get a sensible stack trace. Debug
>>>>> logs
>>>>> from pairing is requested until segfault is pasted at the bottom of the
>>>>> email.
>>
>> By hard coding the address type to BDADDR_BREDDR I was able to trigger the
>> same crash on my ubuntu box. Then I could run with valgrind and get a stack
>> trace (latest commit in tree was 4364085). The segfault seems to happen when
>> dereferencing the device pointer in browse_cb.
>>
>> ==13178== Invalid read of size 8
>> ==13178==    at 0x1842EA: browse_cb (device.c:4595)
>> ==13178==    by 0x15EFA8: search_completed_cb (sdp-client.c:205)
>> ==13178==    by 0x194ADC: sdp_process (sdp.c:4354)
>> ==13178==    by 0x15F0F4: search_process_cb (sdp-client.c:230)
>> ==13178==    by 0x4E84229: g_main_context_dispatch (in
>> /lib/x86_64-linux-gnu/libglib-2.0.so.0.5200.0)
>> ==13178==    by 0x4E845DF: ??? (in
>> /lib/x86_64-linux-gnu/libglib-2.0.so.0.5200.0)
>> ==13178==    by 0x4E84901: g_main_loop_run (in
>> /lib/x86_64-linux-gnu/libglib-2.0.so.0.5200.0)
>> ==13178==    by 0x120AFF: main (main.c:781)
>>
>> I have verified by inserting log statements that it is crashing in the same
>> spot on the embedded system.
> Are you sure you have the following patch:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=006213cf4d231ce66de273e96619474bd516359b
>

Yes, I verified it now.

>>>>> Any guidance on how to resolve this issue is highly appreciated.
>>>>>
>>>>> Best regards,
>>>>>
>>>>> Per
>>>>>
>>>>> --
>>>>> src/device.c:btd_device_set_temporary() temporary 0
>>>>> src/agent.c:agent_ref() 0xda708: ref=2
>>>>> src/device.c:bonding_request_new() Requesting bonding for
>>>>> 50:1A:A5:D6:6C:7E
>>>>> src/agent.c:agent_ref() 0xda708: ref=3
>>>>> src/agent.c:agent_unref() 0xda708: ref=2
>>>>> src/adapter.c:suspend_discovery()
>>>>> src/adapter.c:adapter_bonding_attempt() hci0 bdaddr 50:1A:A5:D6:6C:7E
>>>>> type 0
>>>>> io_cap 0x03
>>>>> src/adapter.c:add_whitelist_complete() 50:1A:A5:D6:6C:7E added to kernel
>>>>> whitelist
>>>>> src/adapter.c:connected_callback() hci0 device 50:1A:A5:D6:6C:7E
>>>>> connected
>>>>> eir_len 22
>>>>> src/adapter.c:new_link_key_callback() hci0 new key for 50:1A:A5:D6:6C:7E
>>>>> type 4 pin_len 0 store_hint 1
>>>>> src/device.c:device_set_bonded()
>>>>> src/device.c:device_bonding_complete() bonding 0xd8490 status 0x00
>>>>> src/device.c:device_bonding_complete() Proceeding with service discovery
>>>>> src/agent.c:agent_unref() 0xda708: ref=1
>>>>> src/adapter.c:resume_discovery()
>>>>> src/adapter.c:pair_device_complete() Success (0x00)
>>>>> src/adapter.c:bonding_attempt_complete() hci0 bdaddr 50:1A:A5:D6:6C:7E
>>>>> type
>>>>> 0 status 0x0
>>>>> src/device.c:device_bonding_complete() bonding (nil) status 0x00
>>>>> src/adapter.c:resume_discovery()
>>>>> src/gatt-database.c:connect_cb() New incoming BR/EDR ATT connection
>>>>> attrib/gattrib.c:g_attrib_ref() 0xf7470: g_attrib_ref=1
>>>>> src/device.c:load_gatt_db() Restoring 50:1A:A5:D6:6C:7E gatt database
>>>>> from
>>>>> file
>>>>> No cache for 50:1A:A5:D6:6C:7E
>>>>> src/gatt-client.c:btd_gatt_client_connected() Device connected.
>>>>> src/device.c:gatt_debug() Primary service discovery failed. ATT ECODE:
>>>>> 0x0a
>>>>> src/device.c:gatt_client_ready_cb() status: success, error: 0
>>>>> src/gatt-client.c:btd_gatt_client_ready() GATT client ready
>>>>> src/gatt-client.c:create_services() Exporting objects for GATT services:
>>>>> 50:1A:A5:D6:6C:7E
>>>>> src/device.c:device_svc_resolved() /org/bluez/hci0/dev_50_1A_A5_D6_6C_7E
>>>>> err
>>>>> 0
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> linux-bluetooth"
>>>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

