Return-Path: <cyrus@holtmann.org>
Message-ID: <502203CF.8070504@ti.com>
Date: Wed, 8 Aug 2012 09:14:39 +0300
From: Chen Ganir <chen.ganir@ti.com>
MIME-Version: 1.0
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] Battery: Add Battery list to btd_device
References: <1343194947-13659-1-git-send-email-chen.ganir@ti.com> <1343194947-13659-6-git-send-email-chen.ganir@ti.com> <CAAngNManvC8Q1Rt9qtni7txOPx24++wQqVPO+c3qmZu1oc7EMQ@mail.gmail.com>
In-Reply-To: <CAAngNManvC8Q1Rt9qtni7txOPx24++wQqVPO+c3qmZu1oc7EMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Joao,

On 08/07/2012 07:29 PM, Joao Paulo Rechi Vita wrote:
> On Wed, Jul 25, 2012 at 2:42 AM, Chen Ganir <chen.ganir@ti.com> wrote:
>> Add peer battery list to the btd_device. New property added to Device
>> called Batteries.
>> ---
>>   doc/device-api.txt                   |    5 +++
>>   profiles/batterystate/batterystate.c |    6 ++++
>>   src/device.c                         |   66 ++++++++++++++++++++++++++++++++++
>>   src/device.h                         |    3 ++
>>   4 files changed, 80 insertions(+)
>>
>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>> index 3b84033..3d19a53 100644
>> --- a/doc/device-api.txt
>> +++ b/doc/device-api.txt
>> @@ -175,3 +175,8 @@ Properties  string Address [readonly]
>>                          Note that this property can exhibit false-positives
>>                          in the case of Bluetooth 2.1 (or newer) devices that
>>                          have disabled Extended Inquiry Response support.
>> +
>> +               array{string} Batteries [readonly]
>> +
>> +                       List of device battery object paths that represents the available
>> +                       batteries on the remote device.
>
> This property should be deprecated by the introduction of the D-Bus
> object manager (scheduled for the 5.0 release).
>
Can you please explain ? What do you mean deprecated ? What is the 
proposed mechanism to replace this property ?

Thanks,
Chen Ganir.
