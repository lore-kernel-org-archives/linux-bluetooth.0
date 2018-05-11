Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BlueZ 1/5] doc/advertising-api: Add Flags property
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLibRcGaSZRhA1yGdHO_=pH1DCBd45HYypBsv8cjKt1jg@mail.gmail.com>
Date: Fri, 11 May 2018 17:32:27 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <8396ED24-59D7-4910-B842-7B12F0E4122B@holtmann.org>
References: <20180507161403.14181-1-luiz.dentz@gmail.com>
 <EF92087E-6EF8-403F-803C-A912DCF50A07@holtmann.org>
 <CABBYNZJK9nHb1HQFEVgiC5roPRtcU59JWV+Q2gVgbZcfwUtfUw@mail.gmail.com>
 <3919BA38-D8EB-40EE-94F1-01B6E8E3EDC3@holtmann.org>
 <CABBYNZLibRcGaSZRhA1yGdHO_=pH1DCBd45HYypBsv8cjKt1jg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> 
>>>>> This adds Flags which the application can use in case it want to set
>>>>> it own flags.
>>>>> 
>>>>> Note: This would allow for example an application to advertise as
>>>>> discoverable even if the adapter is not discoverable which may be
>>>>> required by dual-mode as it may not require BR/EDR to be discoverable.
>>>>> ---
>>>>> doc/advertising-api.txt | 15 +++++++++++++++
>>>>> 1 file changed, 15 insertions(+)
>>>>> 
>>>>> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
>>>>> index eef98ad91..4e015f282 100644
>>>>> --- a/doc/advertising-api.txt
>>>>> +++ b/doc/advertising-api.txt
>>>>> @@ -78,6 +78,21 @@ Properties string Type
>>>>>                             <Transport Discovery> <Organization
>>> Flags...>
>>>>>                             0x26                   0x01
>>> 0x01...
>>>>> 
>>>>> +             array{byte} Flags [Experimental]
>>>>> +
>>>>> +                     Advertising Flags to include. When present this
>>> will
>>>>> +                     override existing flags such as Discoverable.
>>>>> +
>>>>> +                     Note: This property shall not be set when Type
> is
>>> set
>>>>> +                     to broadcast.
>>>>> +
>>>>> +                     Possible value:
>>>>> +                             bit 0 - LE Limited Discoverable Mode
>>>>> +                             bit 1 - LE General Discoverable Mode
>>>>> +                             bit 2 - BR/EDR Not Supported
>>>>> +                             bit 3 - Simultaneous LE and BR/EDR
>>> (Controller)
>>>>> +                             bit 4 - Simultaneous LE and BR/EDR
> (Host)
>>>>> +
>>> 
>>>> I think this is the wrong approach. Exposing this low-level part is
> just
>>> giving an API to circumvent and violate the Bluetooth spec. You are
>>> inviting apps to create bad advertising data. So NAK.
>>> 
>>> Then we should find some alternative, perhaps only allow certain flags
> to
>>> be set this way or change the property to just Discoverable.
> 
>> I would just add a single property Discoverable that maps to General
> Discoverable Mode. If you want to get extra credits, then adding
> DiscoverableTimeout (like we have in adapter-api.txt) would allow to switch
> it back from discoverable to connectable.
> 
> Alright, perhaps we could maintain it as Flags and only allow certain flags
> to be set by the application since I do intend to use the same interface to
> expose device advertisement so we can remove the AdvertisingData and
> AdvertisingFlags from the Device interface. Regarding the Timeout we
> already have something similar with Duration, or do you think that there
> are use cases that we cannot fulfill? For bit 3-4 I guess we never set
> those, but BR/EDR Not Supported could be useful for the application to
> control the bearer it wants the remote to connect to.

so I would do bool Discoverable and unit16 DiscoverableTimeout. The duration is for the advertising duration. Which means if the DiscoverableTimeout and duration is set then after DiscoverableTimeout it would switch back to being connectable only.

The BR/EDR Not Supported can not be in application control. You would need to ensure that a static address is used and the BR/EDR side is really separated from the LE side. As I said before, we do not want to turn this into something that leads to violating GAP and BlueZ would be the bad implemented device because of it.

It is also important to note that if we are LE only, then this is required to be always set. However that is main.conf master switch. So don’t go there. If we ever want to have a split-personality between BR/EDR and LE, then we do that with a total different and new interface. We don’t hack this into existing ones. Assume these are dual-mode most of the time.

Regards

Marcel

