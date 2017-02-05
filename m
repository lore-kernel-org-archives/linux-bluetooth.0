Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK+PDJewy=FhY6ff_L+=7CPw1VNV_ytzFKZS_6nW1CxGA@mail.gmail.com>
References: <CAK-EfX=FkO9JSiQhE4WXeTTr3sw9WHDPVNr6pJmOXP1PgE0L5Q@mail.gmail.com>
 <CABBYNZK+jBHP959i-P+mQ2fX3p0fdFBYAxP8967BwEHnj=m-vQ@mail.gmail.com>
 <CAK-EfXn-ZB9erfz=MTB7dT2S86TNykPtgKOY-CuUr=KJTy87aA@mail.gmail.com>
 <CABBYNZKwZ7iUZoh9PeNsNstNUW30DKBm1VD_fSNoRXzFaPSesg@mail.gmail.com>
 <CAO1O6se-S7ARAW_gJDB9iEPu3mce0pKrNNmBCy_XSvwHLngAvQ@mail.gmail.com> <CABBYNZK+PDJewy=FhY6ff_L+=7CPw1VNV_ytzFKZS_6nW1CxGA@mail.gmail.com>
From: =?UTF-8?Q?Giovanni_Ortu=C3=B1o?= <ortuno@google.com>
Date: Mon, 6 Feb 2017 08:16:19 +1100
Message-ID: <CAMDKGBW1jUXcUuuDm4WpLot4B=eqMzKc-Ur58FE9tUtgFOq3Fw@mail.gmail.com>
Subject: Re: GATT service blacklist
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Emil Lenngren <emil.lenngren@gmail.com>,
        Vincent Scheib <scheib@google.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[Sending again in plain text mode]

I don't think it makes sense to block this functionality. This will
only cause developers to introduce non-standard characteristics to
achieve what they want. For example Playbulb already does this:
Characteristic with UUID 0xffff[1] can be used to change the device's
name. I can imagine the number of peripherals that do this will only
grow as this is clearly a desired feature.

[1] https://github.com/Phhere/Playbulb/blob/master/protocols/characteristics.md

On Mon, Jan 23, 2017 at 8:41 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Emil,
>
> On Thu, Jan 19, 2017 at 11:11 PM, Emil Lenngren <emil.lenngren@gmail.com> wrote:
>> Hi,
>>
>> 2017-01-19 21:17 GMT+01:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>>> Hi Vincent,
>>>
>>> On Thu, Jan 19, 2017 at 9:52 PM, Vincent Scheib <scheib@google.com> wrote:
>>>> On Mon, Jan 16, 2017 at 5:46 AM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> On Sat, Jan 14, 2017 at 6:38 AM, Vincent Scheib <scheib@google.com> wrote:
>>>>>> I just ran into this issue again (being blocked from accessing a standard
>>>>>> GATT service) when using bluez. I had an application accessing GATT
>>>>>> objects, and also the generic_access service. ...
>>>>>
>>>>> Well the general idea was to block access if there is a plugin already
>>>>> handling a certain service. Now you seem to be claiming this shouldn't
>>>>> be the case and any service can be accessed simultaneously by a plugin
>>>>> running in daemon process and an application, but I don't think this
>>>>> is always true and in some cases they may conflict, or just generate
>>>>> duplicated traffic.
>>>>
>>>> Correct. Bluetooth devices are all required to have a generic_access
>>>> service, and I believe applications should be able to use the GATT
>>>> protocol to interact with that service. I think that the current
>>>> approach bluez has taken of trying to abstract this is a mistake.
>>>> There doesn't seem to be value added by doing so, but there is harm in
>>>> creating additional ways to interact, harming portability and
>>>> requiring more attention and custom code by application developers.
>>>
>>> Well you seem to forget that there are various ways to get the name,
>>> not only GATT. In fact the GAP Service over GATT is just the tip of
>>> the iceberg, since GAP define the connection procedures which has very
>>> little to do with this service, and when it comes to GAP procedures we
>>> do need to know the Name of the devices to display to the user and
>>> that may come from advertisements, inquiry results or from Read Name
>>> command so we can cache the name so we can display it even when not
>>> connected. So if you arguing that the stack should not deal with this
>>> service I would have to disagree.
>>>
>>
>> In my opinion, it's nice that the system tries to maintain a cache
>> using various methods to be able to show the name to the user even
>> when the device is disconnected. However that should not imply that it
>> shouldn't be possible to read the name characteristic directly from an
>> application. There are many reasons why one thinks the name is old and
>> needs to be refreshed; for example if you use a smartphone as GATT
>> server where you easily can change both GATT server and name, or if
>> you do a firmware update and reboot the device the name may change as
>> well. If there is no way to force the system to reload the name then
>> it should definitely be possible to read it directly. This is how
>> Android's implementation works and I guess no one has complained about
>> it.
>
> Reading is alright, writing is the one Im more concerned since we
> might not be able to detect the change until it gets reconnected. Also
> there is no mention on how this affects the name in the advertisement,
> if that gets truncated, etc. Flashing a new firmware is actually no
> problem, we do read the name every time it gets connected. Im not sure
> I follow regarding the GATT server and name, do you want applications
> to register a GAP service as a server? How would we handle different
> applications trying to register themselves as GAP service since I
> don't think we can have multiple instances of that service, if Android
> allow to do that its probably not even complaint.
>
>> Also when you want to build a Bluetooth library on top on another
>> Bluetooth library it's never fun when each platform has its own
>> restrictions that probably was intended to simplify for the users but
>> in practice often misses special cases leading to incompatibility
>> problems.
>
> Well the same can be said if the Bluetooth stack allow doing things
> forbidden by the spec.
>
>>
>>>>> Perhaps for GAP service itself it is fine to allow applications to
>>>>> access it, the problem is if we allow the application to set the name
>>>>> like you want does it notifies that do the daemon as well?
>>>>
>>>> Yes. The same way multiple applications should be able to receive
>>>> notifications for one device.
>>>
>>> Except that org.bluetooth.characteristic.gap.device_name excludes
>>> notification support:
>>>
>>> https://www.bluetooth.com/specifications/gatt/viewer?attributeXmlFile=org.bluetooth.service.generic_access.xml
>>
>> I would guess the spec writers didn't really think about what should
>> happen when the name gets updated. iOS actually "takes up/waste" one
>> round trip in each start of connection to read the name characteristic
>> in order to always try to have the latest.
>
> BlueZ does the same and we do emit a signal if we the detect the name
> has changed.
>
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
