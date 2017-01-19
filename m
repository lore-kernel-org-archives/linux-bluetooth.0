Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJfx1d5bfF6qceS028Y6OrC_0SrJF+MPuMh78OO9EMT4Q@mail.gmail.com>
References: <1470835502-30698-1-git-send-email-luiz.dentz@gmail.com>
 <CABBYNZKHsanSRUD1MMHE4xp_5ykkpxNA3p5zfJOLWMcFdkzTSw@mail.gmail.com>
 <CA+ZaN3_M58rv0veLpL=C2A7JJz_YvcOCv31WFxqJraS7DOgF2g@mail.gmail.com> <CABBYNZJfx1d5bfF6qceS028Y6OrC_0SrJF+MPuMh78OO9EMT4Q@mail.gmail.com>
From: Seulki Shin <sskcorea@gmail.com>
Date: Fri, 20 Jan 2017 06:34:11 +0900
Message-ID: <CA+ZaN3_ihRmQH7sihb2w9dEeFXcbf67Zw2XnVjB-iK8k_i=zhg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Prefer BR/EDR over LE if it set in
 advertisement flag
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz,

Thanks for your valuable information.

On Thu, Jan 19, 2017 at 10:30 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Thu, Jan 19, 2017 at 3:24 PM, Seulki Shin <sskcorea@gmail.com> wrote:
>> Hi Luiz,
>>
>> I found that this patch stops me to test connect GDBus API, especially
>> connecting to BLE device.
>>
>> After calling scan dbus api, bredr_last and le_last are updated at the
>> same time  when update_found_devices() got called.
>> Then connecting to ble device is failed because bredr_last and le_last
>> has no differences and this leads changing bdaddr type to bredr which
>> is wrong in this case.
>>
>> Please consider my analysis.
>
> Actually this is valid only if the device is advertising as a dual
> mode device, so perhaps you want to check why does it advertise as
> BR/EDR capable device. In the other if it is indeed a dual mode device
> a second connect attempt will then trigger the LE connection, this in
> on purpose since we don't yet have bearer specific Connect methods so
> we have to prefer BR/EDR over LE as the first bearer to connect.

Yes, the device was advertising as a dual mode.
But the problem is that I got "Host is down" error message from first trial
so I don't think I can try to connect again.

>
>> Thanks in advance,
>> SLKI
>>
>> On Fri, Aug 12, 2016 at 5:00 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi,
>>>
>>> On Wed, Aug 10, 2016 at 4:25 PM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>
>>>> This makes the code prefer BR/EDR if the last advertisement has it set
>>>> in the flags.
>>>> ---
>>>>  src/adapter.c | 5 ++++-
>>>>  src/device.c  | 6 +++++-
>>>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/src/adapter.c b/src/adapter.c
>>>> index 3742398..ddabf2d 100644
>>>> --- a/src/adapter.c
>>>> +++ b/src/adapter.c
>>>> @@ -5488,8 +5488,11 @@ static void update_found_devices(struct btd_adapter *adapter,
>>>>          * supports this we can make the non-zero check conditional.
>>>>          */
>>>>         if (bdaddr_type != BDADDR_BREDR && eir_data.flags &&
>>>> -                                       !(eir_data.flags & EIR_BREDR_UNSUP))
>>>> +                                       !(eir_data.flags & EIR_BREDR_UNSUP)) {
>>>>                 device_set_bredr_support(dev);
>>>> +               /* Update last seen for BR/EDR in case its flag is set */
>>>> +               device_update_last_seen(dev, BDADDR_BREDR);
>>>> +       }
>>>>
>>>>         if (eir_data.name != NULL && eir_data.name_complete)
>>>>                 device_store_cached_name(dev, eir_data.name);
>>>> diff --git a/src/device.c b/src/device.c
>>>> index 264d599..6c6be92 100644
>>>> --- a/src/device.c
>>>> +++ b/src/device.c
>>>> @@ -1763,7 +1763,11 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
>>>>         if (dev->le && (!dev->bredr || bredr_last == NVAL_TIME))
>>>>                 return dev->bdaddr_type;
>>>>
>>>> -       if (bredr_last < le_last)
>>>> +       /*
>>>> +        * Prefer BR/EDR if time is the same since it might be from an
>>>> +        * advertisement with BR/EDR flag set.
>>>> +        */
>>>> +       if (bredr_last <= le_last)
>>>>                 return BDADDR_BREDR;
>>>>
>>>>         return dev->bdaddr_type;
>>>> --
>>>> 2.7.4
>>>
>>> Applied.
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz

SLKI
