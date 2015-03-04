Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54F40908.1090501@freescale.com>
References: <54D96429.8000304@freescale.com>
	<CAN_7+Yai0m39=crfcqJdJZfoTOOuh4zxPi_46wn6EXbewHGf8g@mail.gmail.com>
	<54DB22D8.1020700@freescale.com>
	<CAN_7+YZu0v0zekp0LrQM3dbtkYL=cY_ALT5+exHDeyUmO_0uCQ@mail.gmail.com>
	<54DC0E4A.2070709@freescale.com>
	<CAN_7+YaXZd4VPwk0VnSW8dP21PpmQMphf7T+UrkC9f4V7HcELg@mail.gmail.com>
	<54F40908.1090501@freescale.com>
Date: Wed, 4 Mar 2015 12:43:35 +0100
Message-ID: <CAN_7+YYoD6CsEMr_KqUEvSG+eqMcZpbdgn1_7oG8m_5k_8Q-kw@mail.gmail.com>
Subject: Re: BlueZ for Android 4.4.3
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Zheng Tao-B46827 <b46827@freescale.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	max.tsai@freescale.com, xiao-lizhang@freescale.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tony,

On Mon, Mar 2, 2015 at 7:54 AM, Zheng Tao-B46827 <b46827@freescale.com> wrote:
>
> On 2/14/2015 12:02 AM, Lukasz Rymanowski wrote:
>>
>> Hi Tony,
>>
>> On Thu, Feb 12, 2015 at 3:22 AM, Zheng Tao-B46827 <b46827@freescale.com>
>> wrote:
>>>
>>> Hi, Lukasz
>>>
>>>
>>> On 2/11/2015 7:41 PM, Lukasz Rymanowski wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Wed, Feb 11, 2015 at 10:37 AM, Zheng Tao-B46827
>>>> <b46827@freescale.com>
>>>> wrote:
>>>>>
>>>>> Hi, Lukasz
>>>>> Thanks for your reply. Following you steps, the previous problem has
>>>>> been
>>>>> resolved, but it seems that the connection is not stable. When I
>>>>> execute
>>>>> av
>>>>> connect, I can hear "Connected" from my Bluetooth headset, but it will
>>>>> be
>>>>> disconnected immediately which i can hear "disconnected".  And it will
>>>>> prompt "I/bluetoothd( 1061): bluetoothd[1062]: Unable to find matching
>>>>> endpoint". Is this a bug? can you give some advise?
>>>>>
>>>>>> av connect 24:fd:52:b6:a0:99
>>>>>
>>>>> connection_state: connection_state=BTAV_CONNECTION_STATE_CONNECTING
>>>>> remote_bd_addr=24:fd:52:b6:a0:99
>>>>> if_av->connect: BT_STATUS_SUCCESS
>>>>>>
>>>>>> D/BlueZ   ( 1060):
>>>>>> external/bluetooth/bluez/android/hal-a2dp.c:a2dp_connect()
>>>>>
>>>>> acl_state_changed_cb: status=BT_STATUS_SUCCESS
>>>>> remote_bd_addr=24:fd:52:b6:a0:99 state=BT_ACL_STATE_CONNECTED
>>>>>>
>>>>>> D/BlueZ   ( 1060):
>>>>>>
>>>>>>
>>>>>> external/bluetooth/bluez/android/hal-bluetooth.c:handle_acl_state_changed()
>>>>>> state 0
>>>>>
>>>>> connection_state: connection_state=BTAV_CONNECTION_STATE_DISCONNECTED
>>>>> remote_bd_addr=24:fd:52:b6:a0:99
>>>>>>
>>>>>> I/bluetoothd( 1061): bluetoothd[1062]: Unable to find matching
>>>>>> endpoint
>>>>
>>>> Here is the clue.
>>>>
>>>> Can you provide btmon logs?
>>>
>>> I found this log when execute av connect command:
>>> < HCI Command: Disconnect (0x01|0x0006) plen 3 [hci0] 215.582054
>>>          Handle: 71
>>>          Reason: Remote User Terminated Connection (0x13)
>>> I doubt that why "Remote User Terminated Connection", because when I
>>> heard
>>> "connected" from Bluetooth headset and I have done nothing with it.  The
>>> full log when execute av connect command is attached. Thanks.
>>>
>>  From your logs I see that we did discover SEPs on your Jabra device
>> and got capabilities of SBC SNK endpoint.
>> Then we want to connect that SEP to our SRC endpoint but it is
>> actually not there.
>>
>> After that I realized that I told you to do "av connect" before
>> actually "audio init" and that is wrong.
>> "Audio init" does register your SRC endpoints. So you should do that
>> and after that try "av connect"
>>
>>
>> BR
>> Lukasz
>
> Sorry to reply to you so late for Chinese New Year. Do you mean to follow
> steps like this:
>
> 1. bluetooth init
> 2. bluetooth enable
> 3. bluetooth get_profile_interface a2dp
> 4. bluetooth start_discovery
> 5. bluetooth create_bond xxxxxxxx
> 6. audio init
> 7. av connect xxxxxxxx
> 8. audio open_output_stream
>

You got BT_STATUS_NOT_READY because a2dp was not initialized

Actually you should have smth like this:

1. bluetooth init
2. bluetooth enable
3. bluetooth get_profile_interface a2dp
4. bluetooth start_discovery
5. bluetooth create_bond xxxxxxxx

6. av init  <--- this will initiate a2dp profile

7. audio init   <--- this will setup endpoinds
8. av connect xxxxxxxx
9. audio open_output_stream

After that you can try:

10. audio play

If still there is some issue please send full logs

\Lukasz

> But in this way, when I execute "audio init", I will return back the initial
> problems:
>  "D/BlueZ   ( 1033):
> external/bluetooth/bluez/android/hal-audio.c:ipc_handler() Waiting for
> connection ..."
> and when execute "av connect xxxxxxxx", it will prompt "if_av->connect:
> BT_STATUS_NOT_READY".
>>>>>
>>>>> acl_state_changed_cb: status=BT_STATUS_SUCCESS
>>>>>
>>>>> remote_bd_addr=24:fd:52:b6:a0:99 state=BT_ACL_STATE_DISCONNECTED
>>>>>>
>>>>>> D/BlueZ   ( 1060):
>>>>>>
>>>>>>
>>>>>> external/bluetooth/bluez/android/hal-bluetooth.c:handle_acl_state_changed()
>>>>>> state 1
>>>>>
>>>>>
>>>> \Łukasz
>>>>
>>>>> On 2/11/2015 4:16 PM, Lukasz Rymanowski wrote:
>>>>>>
>>>>>> Hi Tony,
>>>>>>
>>>>>> On Tue, Feb 10, 2015 at 2:51 AM, Zheng Tao-B46827
>>>>>> <b46827@freescale.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> Hi, Peers
>>>>>>>
>>>>>>> Thanks for your hard work that let us can experience BlueZ for
>>>>>>> Android.
>>>>>>> But
>>>>>>> I am faced with a audio/a2dp problems that stick me many weeks.
>>>>>>>
>>>>>>> I’m try to port Bluez to kitkat 4.4.3, and many common profiles, such
>>>>>>> as
>>>>>>> HIDP/FTP/GATT can function successfully. But the A2DP profile failed.
>>>>>>>
>>>>>>> So, I try to debug it using haltest tool as follows(with USB
>>>>>>> Bluetooth
>>>>>>> Dongle):
>>>>>>>
>>>>>>> 1.bluetooth init
>>>>>>>
>>>>>>> 2.bluetooth enable
>>>>>>>
>>>>>>> 3.bluetooth get_profile_interface a2dp
>>>>>>>
>>>>>>> 4.bluetooth start_discovery
>>>>>>>
>>>>>>> 5.bluetooth create_bond xxxxxxxx
>>>>>>>
>>>>>> Here you should setup A2DP using "av connect <bdaddr>." (don't forget
>>>>>> to do av init before.)  Once you are connected you can open stream.
>>>>>>
>>>>>>
>>>>>>> 6.audio init
>>>>>>>
>>>>>>> 7.audio open_output_stream
>>>>>>>
>>>>>>> Then it will prompts:
>>>>>>>
>>>>>>> D/BlueZ   ( 1106):
>>>>>>>
>>>>>>> external/bluetooth/bluez/android/hal-audio.c:audio_open_output_stream()
>>>>>>>
>>>>>>> D/BlueZ   ( 1106):
>>>>>>> external/bluetooth/bluez/android/hal-audio.c:ipc_open_stream_cmd()
>>>>>>>
>>>>>>> E/BlueZ   ( 1106): audio: Invalid cmd socket passed to audio_ipc_cmd
>>>>>>>
>>>>>>> E/BlueZ   ( 1106): audio: cannot open output stream
>>>>>>>
>>>>>>> when I debug it , I found that
>>>>>>>
>>>>>>> BlueZ   ( 1106):
>>>>>>> external/bluetooth/bluez/android/hal-audio.c:ipc_handler()
>>>>>>> Waiting for connection ...
>>>>>>>
>>>>>>> And it seems that there is no audio socket to connect it.
>>>>>>>
>>>>>>> I’m not familiar with Bluez stack details, can you give some advice?
>>>>>>> What
>>>>>>> should I do to enable audio/a2dp functionality and execute audio play
>>>>>>> command? Thanks.
>>>>>>
>>>>>>
>>>>>> \Lukasz
>>>>>>
>>>>>>> ----------------------------------------------
>>>>>>>
>>>>>>> *Best Regards!*
>>>>>>>
>>>>>>> Tony Zheng
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>> linux-bluetooth"
>>>>>>> in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>
