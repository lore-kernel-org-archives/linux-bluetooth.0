Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] doc: Add commands for Start Service Discovery and Stop Service Discovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAD0=r8wdzUi3_kRB8vOvbTagTR=MQDwQ+wvpLV+=uaML2TNWuw@mail.gmail.com>
Date: Sun, 23 Nov 2014 18:47:49 +0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <5AD84B87-F976-43D4-BC3A-A758FC5CC5C2@holtmann.org>
References: <1412938157-70760-1-git-send-email-marcel@holtmann.org> <CAD0=r8zAKR_iGcqyeRotDoshhAp=5U8SCcKJrr+GUsAsy-4TLQ@mail.gmail.com> <B3953F7E-C8F3-45A2-A0E5-A24848E299DF@holtmann.org> <CAD0=r8wEVPdgEZAUKxD7eS2r0XzitRaSYFe9J4FhE320YCMg6w@mail.gmail.com> <F3197FAF-D89E-4021-A1E8-C8D7DFC7ABD8@holtmann.org> <CAD0=r8xF7PWKFcUicqDX8c15TWB3EYPyit8wgmcZacrNwvfmmA@mail.gmail.com> <CAD0=r8wdzUi3_kRB8vOvbTagTR=MQDwQ+wvpLV+=uaML2TNWuw@mail.gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

>>>>>> I think that RSSI_Threshold should be per UUID:
>>>>>> 
>>>>>> +       Command Parameters:     Address_Type (1 Octet)
>>>>>> +                               Num_Filters (1 Octet)
>>>>>> +                               Filter1 {
>>>>>> +                                   RSSI_Threshold (1 Octet)
>>>>>> +                                   UUID[i] (16 Octets)
>>>>>> +                               }
>>>>>> +                               Filter2 {}
>>>>>> +                               ...
>>>>> 
>>>>> I need a bit more reason for this. Stating it does not convince me ;)
>>>>> 
>>>>> My take is that it is not needed for this one-shot discovering. Just select some good enough RSSI threshold and filter the rest later when you get TX power information. Like with Start Discovery it will stop once it is done with the search. So next time around you can select a different RSSI threshold.
>>>> 
>>>> Let's say I'm scanning for two kinds services:
>>>> - some security token, that needs to be very close to my machine
>>>> - temperature sensor, with no particular interest in range
>>>> - controller receives one packet from security token that advertise at
>>>> very high TX power and is very close, so I specify very high rssi
>>>> threshold
>>>> - then the temperature sensor, that advertises on low power will not be reported
>>>> 
>>>> If I had rssi specified per UUID that won't be the case.
>>> 
>>> I think having that is a good idea in general. Just not in the case of a one-shot discovery trigger. We should do that for adding these UUID filters to the background scanning.
>>> 
>>> The difference between discovery and background scanning is that during discovery we are using active scanning (meaning scan responses will be requested) and during background scanning we are using passive scanning.
>>> 
>>> So my thinking is that you use the service discovery to find your device/service now. You are actively looking for it at that point in time. In that case it really does not matter that you get a few false positives. You are actively using your radio to send scan requests anyway.
>> 
>> Ok, I'll modify my patches so that start service discovery would get
>> only one rssi value for all services.
>> 
> 
> I just fixed my patches work as you described in doc/mgmt-api.txt
> Writing it as you proposed made the code much simpler and cleaner. Thanks!
> Can you please 'git am' this doc/mgmt.txt patch, or is there something
> more to do ?

I pushed the doc/mgmt-api.txt updates now.

Regards

Marcel

