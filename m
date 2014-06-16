Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BB33EA45-5B83-4D3F-830F-310D4298CC8D@holtmann.org>
References: <1402927795-14834-1-git-send-email-szymon.janc@tieto.com>
	<DC8DF41D-0449-41E5-B8D6-7D8D866BC9B1@holtmann.org>
	<1900079.HqpV8RXPni@athlon>
	<BB33EA45-5B83-4D3F-830F-310D4298CC8D@holtmann.org>
Date: Mon, 16 Jun 2014 23:38:37 +0200
Message-ID: <CAN_7+YYd9CP3reuqgequWdwe8owAVZx-NWn=-fTk5iAO8YHJ_g@mail.gmail.com>
Subject: Re: [PATCH] android: Build btiotest tool
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@gmail.com>,
	Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Szymon,

On Mon, Jun 16, 2014 at 10:40 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Szymon,
>
>>>> This is useful for testing.
>>>> ---
>>>> android/Android.mk | 32 ++++++++++++++++++++++++++++++++
>>>> 1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/android/Android.mk b/android/Android.mk
>>>> index fc7b59d..ecff9c8 100644
>>>> --- a/android/Android.mk
>>>> +++ b/android/Android.mk
>>>> @@ -620,3 +620,35 @@ LOCAL_MODULE := avinfo
>>>> LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
>>>>
>>>> include $(BUILD_EXECUTABLE)
>>>> +
>>>> +#
>>>> +# btiotest
>>>> +#
>>>> +
>>>> +include $(CLEAR_VARS)
>>>> +
>>>> +LOCAL_SRC_FILES := \
>>>> +   bluez/tools/btiotest.c \
>>>> +   bluez/btio/btio.c \
>>>> +   bluez/lib/bluetooth.c \
>>>
>>> I would actually prefer that we get rid of btio and integrated this in
>>> struct io properly. However what can be tested with btiotest that can not
>>> be tested with l2test and other tools.
>>
>> This is mostly for tests related to (updating) connection security level.
>>
>> We should be able to craft custom GATT HAL test command for that, although
>> this is not really related to GATT...
>
> if it helps right now, then include the tool. However keep in mind that long term all the GLib based stuff has to go away. And especially the Android part of BlueZ should be GLib free first. This means if you are missing test functionality, lets get it into the existing test tools.
>

For now we need it for couple tests. I think we can already try to
cover it with l2test if btiotest is on the black list ;)

> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

\Lukasz
