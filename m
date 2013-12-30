Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1532451.hxPrzbXmr3@athlon>
References: <1388406855-8809-1-git-send-email-luiz.dentz@gmail.com>
	<1388406855-8809-3-git-send-email-luiz.dentz@gmail.com>
	<1532451.hxPrzbXmr3@athlon>
Date: Mon, 30 Dec 2013 15:36:37 +0200
Message-ID: <CABBYNZ+SN7xxo=k2qTYcSvBmYPXx-pJN4gvEDdE0eAqp1CNzzw@mail.gmail.com>
Subject: Re: [RFC BlueZ 3/9] android: Add audio open command/response struct
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 30, 2013 at 3:27 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> Hi Luiz,
>
> On Monday 30 December 2013 14:34:09 Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This adds the definitions to audio open command and response.
>> ---
>>  android/a2dp.c            |  9 +++++++++
>>  android/audio-ipc-api.txt |  2 +-
>>  android/hal-msg.h         | 18 ++++++++++++++++++
>>  android/ipc.c             |  5 ++++-
>>  4 files changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/android/a2dp.c b/android/a2dp.c
>> index 63f1f58..5cb01f7 100644
>> --- a/android/a2dp.c
>> +++ b/android/a2dp.c
>> @@ -352,7 +352,16 @@ static sdp_record_t *a2dp_record(void)
>>       return record;
>>  }
>>
>> +static void bt_audio_open(const void *buf, uint16_t len)
>> +{
>> +     DBG("Not Implemented");
>> +
>> +     ipc_send_rsp(HAL_SERVICE_ID_AUDIO, AUDIO_OP_OPEN, HAL_STATUS_FAILED);
>> +}
>> +
>>  static const struct ipc_handler audio_handlers[] = {
>> +     /* AUDIO_OP_OPEN */
>> +     { bt_audio_open, true, sizeof(struct audio_cmd_open) },
>>  };
>>
>>  bool bt_a2dp_register(const bdaddr_t *addr)
>> diff --git a/android/audio-ipc-api.txt b/android/audio-ipc-api.txt
>> index 1c42800..37a1569 100644
>> --- a/android/audio-ipc-api.txt
>> +++ b/android/audio-ipc-api.txt
>> @@ -49,9 +49,9 @@ Identifier: "audio" (BT_AUDIO_ID)
>>
>>               Command parameters: Service UUID (16 octets)
>>                                   Codec ID (1 octet)
>> +                                 Number of codec presets (1 octet)
>>                                   Codec capabilities length (1 octet)
>>                                   Codec capabilities (variable)
>> -                                 Number of codec presets (1 octet)
>>                                   Codec preset # length (1 octet)
>>                                   Codec preset # configuration (variable)
>>                                   ...
>> diff --git a/android/hal-msg.h b/android/hal-msg.h
>> index 1afb1bc..4b52e5e 100644
>> --- a/android/hal-msg.h
>> +++ b/android/hal-msg.h
>> @@ -567,3 +567,21 @@ struct hal_ev_a2dp_audio_state {
>>       uint8_t state;
>>       uint8_t bdaddr[6];
>>  } __attribute__((packed));
>> +
>> +#define AUDIO_OP_OPEN                                0x01
>> +struct audio_cmd_open {
>> +     uint16_t uuid;
>> +     uint8_t codec;
>> +     uint8_t presets;
>> +     uint8_t len;
>> +     uint8_t data[0];
>
> Maybe this could be
> struct audio_preset[0];
> ? (if that would make code cleaner)

Indeed, will fix it.

Luiz Augusto von Dentz
