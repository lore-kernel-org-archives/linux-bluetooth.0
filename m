Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BlueZ 1/5] doc/advertising-api: Add Flags property
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <da75820d-6ecf-0b2a-004f-1ef947dd66bf@flypig.co.uk>
Date: Fri, 11 May 2018 17:34:38 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E84C6FEF-EED3-4A94-8915-BE97FF80DA6B@holtmann.org>
References: <20180507161403.14181-1-luiz.dentz@gmail.com>
 <EF92087E-6EF8-403F-803C-A912DCF50A07@holtmann.org>
 <CABBYNZJK9nHb1HQFEVgiC5roPRtcU59JWV+Q2gVgbZcfwUtfUw@mail.gmail.com>
 <3919BA38-D8EB-40EE-94F1-01B6E8E3EDC3@holtmann.org>
 <CABBYNZLibRcGaSZRhA1yGdHO_=pH1DCBd45HYypBsv8cjKt1jg@mail.gmail.com>
 <da75820d-6ecf-0b2a-004f-1ef947dd66bf@flypig.co.uk>
To: David Llewellyn-Jones <david@flypig.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

>> 
>>>>>> This adds Flags which the application can use in case it want to set
>>>>>> it own flags.
>>>>>> 
>>>>>> Note: This would allow for example an application to advertise as
>>>>>> discoverable even if the adapter is not discoverable which may be
>>>>>> required by dual-mode as it may not require BR/EDR to be discoverable.
>>>>>> ---
>>>>>> doc/advertising-api.txt | 15 +++++++++++++++
>>>>>> 1 file changed, 15 insertions(+)
>>>>>> 
>>>>>> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
>>>>>> index eef98ad91..4e015f282 100644
>>>>>> --- a/doc/advertising-api.txt
>>>>>> +++ b/doc/advertising-api.txt
>>>>>> @@ -78,6 +78,21 @@ Properties string Type
>>>>>>                             <Transport Discovery> <Organization
>>>> Flags...>
>>>>>>                             0x26                   0x01
>>>> 0x01...
>>>>>> 
>>>>>> +             array{byte} Flags [Experimental]
>>>>>> +
>>>>>> +                     Advertising Flags to include. When present this
>>>> will
>>>>>> +                     override existing flags such as Discoverable.
>>>>>> +
>>>>>> +                     Note: This property shall not be set when Type
>> is
>>>> set
>>>>>> +                     to broadcast.
>>>>>> +
>>>>>> +                     Possible value:
>>>>>> +                             bit 0 - LE Limited Discoverable Mode
>>>>>> +                             bit 1 - LE General Discoverable Mode
>>>>>> +                             bit 2 - BR/EDR Not Supported
>>>>>> +                             bit 3 - Simultaneous LE and BR/EDR
>>>> (Controller)
>>>>>> +                             bit 4 - Simultaneous LE and BR/EDR
>> (Host)
>>>>>> +
>>>> 
>>>>> I think this is the wrong approach. Exposing this low-level part is
>> just
>>>> giving an API to circumvent and violate the Bluetooth spec. You are
>>>> inviting apps to create bad advertising data. So NAK.
>>>> 
>>>> Then we should find some alternative, perhaps only allow certain flags
>> to
>>>> be set this way or change the property to just Discoverable.
>> 
>>> I would just add a single property Discoverable that maps to General
>> Discoverable Mode. If you want to get extra credits, then adding
>> DiscoverableTimeout (like we have in adapter-api.txt) would allow to switch
>> it back from discoverable to connectable.
>> 
>> Alright, perhaps we could maintain it as Flags and only allow certain flags
>> to be set by the application since I do intend to use the same interface to
>> expose device advertisement so we can remove the AdvertisingData and
>> AdvertisingFlags from the Device interface. Regarding the Timeout we
>> already have something similar with Duration, or do you think that there
>> are use cases that we cannot fulfill? For bit 3-4 I guess we never set
>> those, but BR/EDR Not Supported could be useful for the application to
>> control the bearer it wants the remote to connect to.
> 
> As an end-user of this interface, I think I'd value it left as flags,
> matching the format of the flags in the spec itself. Even if some of the
> flags are read-only, having it match with the spec helps greatly in
> understanding what's going on.

that part I disagree. These flags are GAP details and not really application specific.

> Although I fully appreciate the need to avoid allowing violations of the
> spec, I'm afraid my understanding of it isn't good enough to contribute.
> For my own use, I only need control over bit 0, but I can also
> anticipate other situations in which controlling bits 1 and 2 would be
> useful too. So I'd support Luiz's suggestion.

See my response to Luiz since that is really not the case. If you operate as dual-mode device you have to do things correctly. Split-personality situations need a different interface. It can not be bolted onto this one.

Regards

Marcel

