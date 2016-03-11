Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+Wx+dWGJ8PJGBXbsXt5U9PT_EVfLJkv8EOJNCj7AgK5g@mail.gmail.com>
References: <1457626604-5656-1-git-send-email-luiz.dentz@gmail.com>
 <CADAkoF5psaM7eAgjMZGbq4Q-Kx_SDEbEn9MtQM8Mj9+g+ow0Aw@mail.gmail.com> <CABBYNZ+Wx+dWGJ8PJGBXbsXt5U9PT_EVfLJkv8EOJNCj7AgK5g@mail.gmail.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Date: Fri, 11 Mar 2016 13:24:50 +0100
Message-ID: <CADAkoF5TF8SvxP3sQpbQ2Pwo7fKYQDvvN2jPgfD3538Vt-Bf_g@mail.gmail.com>
Subject: Re: [RFC BlueZ] doc/device-api: Replace GattServices with Discovering property
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


On Fri, Mar 11, 2016 at 12:23 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Andrzej,
>
> On Fri, Mar 11, 2016 at 1:05 PM, Andrzej Kaczmarek
> <andrzej.kaczmarek@codecoup.pl> wrote:
>> Hi Luiz,
>>
>> On Thu, Mar 10, 2016 at 5:16 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> GattServices is not really doing was it was meant to do which was to
>>> track progress of service discovery since it only worked for the very
>>> first time a device is connected but since we no longer remove the
>>> attributes an application would have the false impression the service are
>>> all resolved by the time it reconnects when in fact the service may have
>>> changed.
>>>
>>> Futhermore object tracking like it is doing has been obsolete by
>>> ObjectManager so this propose to replace the service discovery tracking
>>> with a boolean property which works both with SDP as well as GATT
>>> discovery.
>>> ---
>>>  doc/device-api.txt |  9 +++------
>>>  src/device.c       | 58 +++++++++++-------------------------------------------
>>>  2 files changed, 14 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>>> index a8076a2..9e58664 100644
>>> --- a/doc/device-api.txt
>>> +++ b/doc/device-api.txt
>>> @@ -212,10 +212,7 @@ Properties string Address [readonly]
>>>                         Service advertisement data. Keys are the UUIDs in
>>>                         string format followed by its byte array value.
>>>
>>> -               array{object} GattServices [readonly, optional]
>>> +               bool Discovering [readonly, optional, experimental]
>>
>> It's not optional - there's no exists method (which is fine).
>
> Indeed, I will fix it.
>
>> I think a better name for this would be "Discovered" which has initial
>> value of false (once device is connected) and then changes to true
>> (once services are ready, either from cache or an actual discovery).
>> It could also change back to false once re-discovery due to Service
>> Changed is in progress which I think is also fine.
>>
>> With "Discovering" the problem is still that once "Connected" changes
>> to true, reading "Discovering" will return false so you don't quite
>> know whether discovery already finished or has not yet started.
>> Application would need to wait for complete sequence to be sure:
>> Connected=false, Discovering=false
>> Connected=true, Discovering=false
>> Connected=false, Discovering=true
>> Connected=false, Discovering=false
>>
>> With "Discovered" this is not a problem since sequence is as follows:
>> Connected=false, Discovered=false
>> Connected=true, Discovered=false
>> Connected=true, Discovered=true
>
> I was actually thinking in using the same terminology we used in the
> source code such as ResolvingServices, but changing to Discovered
> don't actually fix the problem since you may still end up with
> Connected=true, Discovered=true but the flag can still change to
> Discovered=false. Anyway Im currently discussing about this changes
> makes sense in Web Bluetooth, because Service Changed may come in
> later on and there is no API to push the services added/removed to the
> application.

When Service Changed is received, BlueZ removes old objects and then
adds new ones. And once there's change to Discovered=false it means
device in its current state is not fully discovered, e.g. there's
re-discovery due to Service Changed in this case which makes sense to
me. So what's the problem here?

BR,
Andrzej
