Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8xF7PWKFcUicqDX8c15TWB3EYPyit8wgmcZacrNwvfmmA@mail.gmail.com>
References: <1412938157-70760-1-git-send-email-marcel@holtmann.org>
	<CAD0=r8zAKR_iGcqyeRotDoshhAp=5U8SCcKJrr+GUsAsy-4TLQ@mail.gmail.com>
	<B3953F7E-C8F3-45A2-A0E5-A24848E299DF@holtmann.org>
	<CAD0=r8wEVPdgEZAUKxD7eS2r0XzitRaSYFe9J4FhE320YCMg6w@mail.gmail.com>
	<F3197FAF-D89E-4021-A1E8-C8D7DFC7ABD8@holtmann.org>
	<CAD0=r8xF7PWKFcUicqDX8c15TWB3EYPyit8wgmcZacrNwvfmmA@mail.gmail.com>
Date: Sun, 23 Nov 2014 00:04:07 -0800
Message-ID: <CAD0=r8wdzUi3_kRB8vOvbTagTR=MQDwQ+wvpLV+=uaML2TNWuw@mail.gmail.com>
Subject: Re: [PATCH] doc: Add commands for Start Service Discovery and Stop
 Service Discovery
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 21, 2014 at 7:19 PM, Jakub Pawlowski <jpawlowski@google.com> wr=
ote:
> On Fri, Nov 21, 2014 at 6:16 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
>> Hi Jakub,
>>
>>>>> I think that RSSI_Threshold should be per UUID:
>>>>>
>>>>> +       Command Parameters:     Address_Type (1 Octet)
>>>>> +                               Num_Filters (1 Octet)
>>>>> +                               Filter1 {
>>>>> +                                   RSSI_Threshold (1 Octet)
>>>>> +                                   UUID[i] (16 Octets)
>>>>> +                               }
>>>>> +                               Filter2 {}
>>>>> +                               ...
>>>>
>>>> I need a bit more reason for this. Stating it does not convince me ;)
>>>>
>>>> My take is that it is not needed for this one-shot discovering. Just s=
elect some good enough RSSI threshold and filter the rest later when you ge=
t TX power information. Like with Start Discovery it will stop once it is d=
one with the search. So next time around you can select a different RSSI th=
reshold.
>>>
>>> Let's say I'm scanning for two kinds services:
>>> - some security token, that needs to be very close to my machine
>>> - temperature sensor, with no particular interest in range
>>> - controller receives one packet from security token that advertise at
>>> very high TX power and is very close, so I specify very high rssi
>>> threshold
>>> - then the temperature sensor, that advertises on low power will not be=
 reported
>>>
>>> If I had rssi specified per UUID that won't be the case.
>>
>> I think having that is a good idea in general. Just not in the case of a=
 one-shot discovery trigger. We should do that for adding these UUID filter=
s to the background scanning.
>>
>> The difference between discovery and background scanning is that during =
discovery we are using active scanning (meaning scan responses will be requ=
ested) and during background scanning we are using passive scanning.
>>
>> So my thinking is that you use the service discovery to find your device=
/service now. You are actively looking for it at that point in time. In tha=
t case it really does not matter that you get a few false positives. You ar=
e actively using your radio to send scan requests anyway.
>
> Ok, I'll modify my patches so that start service discovery would get
> only one rssi value for all services.
>

I just fixed my patches work as you described in doc/mgmt-api.txt
Writing it as you proposed made the code much simpler and cleaner. Thanks!
Can you please 'git am' this doc/mgmt.txt patch, or is there something
more to do ?
I recently asked Johan and he said that it must happen before we can
apply my patches (after my patches are ok, of course).

>>
>>>
>>> I can also set the RSSI threshold at very low value to get notified
>>> about temperature sensor, but the I'll get a lot of  device found
>>> events about security token that will wake my application unnecessary.
>>> We want to avoid that, and that's why we're doing scan in kernel, and
>>> plan to move it to controller.
>>>
>>> So my patches right now define rssi threshold per UUID this like that:
>>>
>>> struct mgmt_uuid_filter {
>>> __s8 rssi;
>>> __u8 uuid[16];
>>> } __packed;
>>>
>>> struct mgmt_cp_start_service_discovery {
>>> __u8 type;
>>> __le16 filter_count;
>>> struct mgmt_uuid_filter filter[0];
>>> } __packed;
>>
>> Add Start Service Discovery and Stop Service Discover is just the first =
step to support your needs. That is for actively finding devices at a speci=
fic point in time. For long time running background scanning we need to add=
 these UUID to the background scanning list. And there we add/remove them o=
ne by one and with that can make it depending on the RSSI.
>
> Ok, but let's first get this short term scan in.
>>
>> Regards
>>
>> Marcel
>>
