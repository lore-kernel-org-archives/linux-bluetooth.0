Return-Path: <cyrus@holtmann.org>
From: Chethan T N <chethan.tn@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1416391248-22656-1-git-send-email-chethan.tn@samsung.com>
 <CABBYNZ+Em=viaSvukUzp3h0SwGWrxN9nVKTW0u2HdaGc8QU8Qg@mail.gmail.com>
In-reply-to: <CABBYNZ+Em=viaSvukUzp3h0SwGWrxN9nVKTW0u2HdaGc8QU8Qg@mail.gmail.com>
Subject: RE: [PATCH] audio/sink: Fix a2dp XCASE connection with BOSE headset
Date: Thu, 20 Nov 2014 10:49:01 +0530
Message-id: <005401d00481$8caf5ee0$a60e1ca0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


>Hi,

>On Wed, Nov 19, 2014 at 12:00 PM, Chethan T N <chethan.tn@samsung.com> wrote:
>> Some bluetooth headset (BOSE) initates the avdtp connection 
>> immideately after HFP connection is completed, so if application 
>> initates a2dp connection and since already avdtp connection is ongiong 
>> should return error EALREADY
>>
>> bluetoothd[1215]: src/service.c:change_state() 0xb6f428a8: device 
> XX:XX:XX:XX:XX:XX profile Hands-Free Audio Gateway state changed: 
>> disconnected -> connecting (0)
>> bluetoothd[1215]: src/profile.c:record_cb() profile uuid 
>> 0000111e-0000-1000-8000-00805f9b34fb port uuid 
>> 0000111e-0000-1000-8000-00805f9b34fb
>> bluetoothd[1215]: src/profile.c:ext_connect() Hands-Free Audio Gateway 
>> connected to XX:XX:XX:XX:XX:XX
>> bluetoothd[1215]: src/service.c:change_state() 0xb6f428a8: device 
>> XX:XX:XX:XX:XX:XX profile Hands-Free Audio Gateway state changed: 
>> connecting -> connected (0)
>> bluetoothd[1215]: src/device.c:device_profile_connected() Hands-Free 
>> Audio Gateway Success (0)
>> bluetoothd[1215]: src/device.c:device_profile_connected() returning 
>> response to :1.113
>> bluetoothd[1215]: /: 
>> org.freedesktop.DBus.ObjectManager.GetManagedObjects()
>> bluetoothd[1215]: src/device.c:search_cb() XX:XX:XX:XX:XX:XX: No 
>> service update
>> bluetoothd[1215]: src/device.c:device_svc_resolved() 
>> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX err 0
>> bluetoothd[1215]: profiles/audio/avdtp.c:avdtp_confirm_cb() AVDTP: 
>> incoming connect from XX:XX:XX:XX:XX:XX
>> bluetoothd[1215]: profiles/audio/sink.c:sink_set_state() State changed 
>> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX: SINK_STATE_DISCONNECTED -> 
>> SINK_STATE_CONNECTING
>> bluetoothd[1215]: src/adapter.c:device_is_auto_accept() uuid 
>> 0000110d-0000-1000-8000-00805f9b34fb
>> bluetoothd[1215]: src/adapter.c:device_is_auto_accept() Auto 
>> Authorization accepting for uuid 0000110d-0000-1000-8000-00805f9b34fb
>> bluetoothd[1215]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP: 
>> connected signaling channel to XX:XX:XX:XX:XX:XX
>> bluetoothd[1215]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP 
>> imtu=672, omtu=895
>> bluetoothd[1215]: profiles/audio/avdtp.c:set_disconnect_timer() name : 
>> Bose
>> bluetoothd[1215]: /: 
>> org.freedesktop.DBus.ObjectManager.GetManagedObjects()
>> bluetoothd[1215]: /: 
>> org.freedesktop.DBus.ObjectManager.GetManagedObjects()
>> bluetoothd[1215]: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX: 
>> org.freedesktop.DBus.Properties.GetAll()
>> bluetoothd[1215]: profiles/audio/avdtp.c:session_cb()
>> bluetoothd[1215]: profiles/audio/avdtp.c:avdtp_parse_cmd() Received 
>> DISCOVER_CMD
>> bluetoothd[1215]: /: 
>> org.freedesktop.DBus.ObjectManager.GetManagedObjects()
>> bluetoothd[1215]: profiles/audio/avdtp.c:session_cb()
>> bluetoothd[1215]: profiles/audio/avdtp.c:avdtp_parse_cmd() Received  
>> GET_CAPABILITIES_CMD
>> bluetoothd[1215]: profiles/audio/a2dp.c:endpoint_getcap_ind() Source 
>> 0xb6f46030: Get_Capability_Ind
>> bluetoothd[1215]: profiles/audio/avdtp.c:session_cb()
>> bluetoothd[1215]: profiles/audio/avdtp.c:avdtp_parse_cmd() Received 
>> SET_CONFIGURATION_CMD
>> bluetoothd[1215]: profiles/audio/a2dp.c:endpoint_setconf_ind() Source 
>> 0xb6f46030: Set_Configuration_Ind
>> bluetoothd[1215]: profiles/audio/avdtp.c:avdtp_ref() 0xb6f61c60: ref=1
>> bluetoothd[1215]: profiles/audio/a2dp.c:setup_ref() 0xb6f622d8: ref=1
>> bluetoothd[1215]: profiles/audio/media.c:media_adapter_get_player()
>> bluetoothd[1215]: profiles/audio/media.c:media_set_sink_callback()
>> bluetoothd[1215]: profiles/audio/media.c:media_endpoint_async_call() 
>> Calling SetConfiguration: name = :1.14 path = 
>> /MediaEndpoint/A2DPSource
>> bluetoothd[1215]: /org/bluez/hci0: 
>> org.freedesktop.DBus.Properties.GetAll()
>> bluetoothd[1215]: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX: 
>> org.bluez.Device1.ConnectProfile()
>> bluetoothd[1215]: src/device.c:connect_profiles() 
>> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX 
>> 0000110b-0000-1000-8000-00805f9b34fb, client :1.113
>> bluetoothd[1215]: profiles/audio/a2dp.c:a2dp_sink_connect() path 
>> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
>> bluetoothd[1215]: profiles/audio/avdtp.c:avdtp_ref() 0xb6f61c60: ref=2
>> bluetoothd[1215]: profiles/audio/sink.c:sink_connect() stream creation 
>> in progress
>> bluetoothd[1215]: src/service.c:change_state() 0xb6f4ece0: device 
>> XX:XX:XX:XX:XX:XX profile a2dp-sink state changed: disconnected -> 
>> connecting (0)
>> bluetoothd[1215]: profiles/audio/avdtp.c:session_cb()
>> ---
>>  profiles/audio/sink.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c index 
>> da8992e..d512938 100644
>> --- a/profiles/audio/sink.c
>> +++ b/profiles/audio/sink.c
>> @@ -292,6 +292,9 @@ int sink_connect(struct btd_service *service)
>>         if (sink->connect_id > 0 || sink->disconnect_id > 0)
>>                 return -EBUSY;
>>
>> +       if (sink->state == SINK_STATE_CONNECTING)
>> +               return -EALREADY;
>
>We are not connected already so perhaps we should return -EBUSY so it behave like connect_id is set.

I will  post the new patch with suggested changes.

>
>>         if (sink->stream_state >= AVDTP_STATE_OPEN)
>>                 return -EALREADY;
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-bluetooth" in the body of a message to majordomo@vger.kernel.org 
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>--
>Luiz Augusto von Dentz

