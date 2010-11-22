Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTin5t-=bMeBmAJ2A+hV4h=dXQeu5dNFbMby43ssS@mail.gmail.com>
References: <1290423382-5493-1-git-send-email-bulislaw@linux.com>
	<20101122143345.GA2303@jh-x301>
	<AANLkTin5t-=bMeBmAJ2A+hV4h=dXQeu5dNFbMby43ssS@mail.gmail.com>
Date: Mon, 22 Nov 2010 23:17:42 +0000
Message-ID: <AANLkTi=TUWxsJtU6qvY46+MmRstT8N_1=-poHSsEuyYH@mail.gmail.com>
Subject: Re: [PATCH] Fix managing dbus filters depending on BT state
From: Bartosz Szatkowski <bulislaw@linux.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Nov 22, 2010 at 8:12 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Mon, Nov 22, 2010 at 4:33 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Bartosz,
>>
>> On Mon, Nov 22, 2010, Bartosz Szatkowski wrote:
>>> Previously even if BT was disabled, bluetoothd would handle some dbus
>>> singals (mostly connected with HFP). Now filters are added when
>>> BT is enabled and removed when BT is disabled.
>>> ---
>>>  audio/manager.c          |    4 ++--
>>>  audio/telephony-dummy.c  |   10 ++++++++++
>>>  audio/telephony-maemo5.c |   10 ++++++++++
>>>  audio/telephony-maemo6.c |   10 ++++++++++
>>>  audio/telephony-ofono.c  |   10 ++++++++++
>>>  audio/telephony.h        |    1 +
>>>  src/adapter.c            |    5 +++++
>>>  7 files changed, 48 insertions(+), 2 deletions(-)
>>
>> Nack on this one. I understand the issue you're trying to fix but it
>> needs to be done differently.
>>
>>> diff --git a/audio/manager.c b/audio/manager.c
>>> index 816c807..2fc7bf1 100644
>>> --- a/audio/manager.c
>>> +++ b/audio/manager.c
>>> @@ -1178,7 +1178,7 @@ proceed:
>>>               btd_register_adapter_driver(&media_server_driver);
>>>
>>>       if (enabled.headset) {
>>> -             telephony_init();
>>> +             telephony_set_state(1);
>>>               btd_register_adapter_driver(&headset_server_driver);
>>>       }
>>
>> If you're gonna call this "state" you should have proper defines or
>> enums for the values, however in this case it's essentially a boolean so
>> that's not necessary. In fact since it's a boolean you don't even need
>> to have any new function or variable at all for it: just use
>> telephony_init and telephony_exit.
>>
>>> --- a/src/adapter.c
>>> +++ b/src/adapter.c
>>> @@ -57,6 +57,7 @@
>>>  #include "glib-helper.h"
>>>  #include "agent.h"
>>>  #include "storage.h"
>>> +#include "../audio/telephony.h"
>>>
>>>  #define IO_CAPABILITY_DISPLAYONLY    0x00
>>>  #define IO_CAPABILITY_DISPLAYYESNO   0x01
>>> @@ -2404,6 +2405,8 @@ int adapter_start(struct btd_adapter *adapter)
>>>
>>>       err = adapter_up(adapter, mode);
>>>
>>> +     telephony_init();
>>> +
>>
>> This is just wrong. The core daemon should never have direct access to
>> the telephony driver. Instead, you should have the audio plugin
>> (probably audio/manager.c or audio/headset.c) register a adapter powered
>> callback and then call telehony_init/exit from that callback.
>
> I have an almost working version of this using adapter drivers and
> powered changes via callback registration, the tricky part here is how
> to detect when to do headset_init/headset_exit since those should be
> called only once. I didn't know there somebody working on this but
> anyway I gonna try to finish this asap.
>
> --
> Luiz Augusto von Dentz
> Computer Engineer
>

Hi Luiz,
please fell free to send it (no hard fillings :) ) Ive just getting to
know bluez so probably it would take me a while to get through whole
plugin/callback subsystem.

-- 
Pozdrowienia,
Bartosz Szatkowski
