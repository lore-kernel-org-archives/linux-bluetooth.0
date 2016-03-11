Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+QuDj4sSxTMLqXkTRju+Yb7_9+3iL+M+nC2K2BvcO+-Q@mail.gmail.com>
References: <1457626604-5656-1-git-send-email-luiz.dentz@gmail.com>
 <CADAkoF5psaM7eAgjMZGbq4Q-Kx_SDEbEn9MtQM8Mj9+g+ow0Aw@mail.gmail.com>
 <CABBYNZ+Wx+dWGJ8PJGBXbsXt5U9PT_EVfLJkv8EOJNCj7AgK5g@mail.gmail.com>
 <CADAkoF5TF8SvxP3sQpbQ2Pwo7fKYQDvvN2jPgfD3538Vt-Bf_g@mail.gmail.com>
 <CABBYNZLDRMzUM8_XkiORdxLe-8jkzn=tLQD_z+SDWZi8-8iwtw@mail.gmail.com>
 <CADAkoF6+pSukDopfpnQ+BdDPqhPn6sHKjutRA-K_L6ewfQgrcg@mail.gmail.com> <CABBYNZ+QuDj4sSxTMLqXkTRju+Yb7_9+3iL+M+nC2K2BvcO+-Q@mail.gmail.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Date: Fri, 11 Mar 2016 17:13:08 +0100
Message-ID: <CADAkoF6Qe+u+oLk95CasmDsb-Fkqiirsz7G5PEW9WRtkVxxPbg@mail.gmail.com>
Subject: Re: [RFC BlueZ] doc/device-api: Replace GattServices with Discovering property
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


On Fri, Mar 11, 2016 at 3:39 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Andrzej,
>
> On Fri, Mar 11, 2016 at 3:41 PM, Andrzej Kaczmarek
> <andrzej.kaczmarek@codecoup.pl> wrote:
>> Hi Luiz,
>>
>>
>> On Fri, Mar 11, 2016 at 2:08 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Andrzej,
>>>
>>> On Fri, Mar 11, 2016 at 2:24 PM, Andrzej Kaczmarek
>>> <andrzej.kaczmarek@codecoup.pl> wrote:
>>>> Hi Luiz,
>>>>
>>>>
>>>> On Fri, Mar 11, 2016 at 12:23 PM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> Hi Andrzej,
>>>>>
>>>>> On Fri, Mar 11, 2016 at 1:05 PM, Andrzej Kaczmarek
>>>>> <andrzej.kaczmarek@codecoup.pl> wrote:
>>>>>> Hi Luiz,
>>>>>>
>>>>>> On Thu, Mar 10, 2016 at 5:16 PM, Luiz Augusto von Dentz
>>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>>>>
>>>>>>> GattServices is not really doing was it was meant to do which was to
>>>>>>> track progress of service discovery since it only worked for the very
>>>>>>> first time a device is connected but since we no longer remove the
>>>>>>> attributes an application would have the false impression the service are
>>>>>>> all resolved by the time it reconnects when in fact the service may have
>>>>>>> changed.
>>>>>>>
>>>>>>> Futhermore object tracking like it is doing has been obsolete by
>>>>>>> ObjectManager so this propose to replace the service discovery tracking
>>>>>>> with a boolean property which works both with SDP as well as GATT
>>>>>>> discovery.
>>>>>>> ---
>>>>>>>  doc/device-api.txt |  9 +++------
>>>>>>>  src/device.c       | 58 +++++++++++-------------------------------------------
>>>>>>>  2 files changed, 14 insertions(+), 53 deletions(-)
>>>>>>>
>>>>>>> diff --git a/doc/device-api.txt b/doc/device-api.txt
>>>>>>> index a8076a2..9e58664 100644
>>>>>>> --- a/doc/device-api.txt
>>>>>>> +++ b/doc/device-api.txt
>>>>>>> @@ -212,10 +212,7 @@ Properties string Address [readonly]
>>>>>>>                         Service advertisement data. Keys are the UUIDs in
>>>>>>>                         string format followed by its byte array value.
>>>>>>>
>>>>>>> -               array{object} GattServices [readonly, optional]
>>>>>>> +               bool Discovering [readonly, optional, experimental]
>>>>>>
>>>>>> It's not optional - there's no exists method (which is fine).
>>>>>
>>>>> Indeed, I will fix it.
>>>>>
>>>>>> I think a better name for this would be "Discovered" which has initial
>>>>>> value of false (once device is connected) and then changes to true
>>>>>> (once services are ready, either from cache or an actual discovery).
>>>>>> It could also change back to false once re-discovery due to Service
>>>>>> Changed is in progress which I think is also fine.
>>>>>>
>>>>>> With "Discovering" the problem is still that once "Connected" changes
>>>>>> to true, reading "Discovering" will return false so you don't quite
>>>>>> know whether discovery already finished or has not yet started.
>>>>>> Application would need to wait for complete sequence to be sure:
>>>>>> Connected=false, Discovering=false
>>>>>> Connected=true, Discovering=false
>>>>>> Connected=false, Discovering=true
>>>>>> Connected=false, Discovering=false
>>>>>>
>>>>>> With "Discovered" this is not a problem since sequence is as follows:
>>>>>> Connected=false, Discovered=false
>>>>>> Connected=true, Discovered=false
>>>>>> Connected=true, Discovered=true
>>>>>
>>>>> I was actually thinking in using the same terminology we used in the
>>>>> source code such as ResolvingServices, but changing to Discovered
>>>>> don't actually fix the problem since you may still end up with
>>>>> Connected=true, Discovered=true but the flag can still change to
>>>>> Discovered=false. Anyway Im currently discussing about this changes
>>>>> makes sense in Web Bluetooth, because Service Changed may come in
>>>>> later on and there is no API to push the services added/removed to the
>>>>> application.
>>>>
>>>> When Service Changed is received, BlueZ removes old objects and then
>>>> adds new ones. And once there's change to Discovered=false it means
>>>> device in its current state is not fully discovered, e.g. there's
>>>> re-discovery due to Service Changed in this case which makes sense to
>>>> me. So what's the problem here?
>>>
>>> If that was the case, again this is for Web Bluetooth, we wouldn't
>>> need to notify this at all because the application would receive the
>>> updates directly, but since the Web Bluetooth is not designed in this
>>> way you just get the current services if anything is updated later it
>>> causes this problem where the services get updated but the application
>>> don't realize it has happened. So it is all about when the application
>>> actually list the objects, again Im talking about Web Bluetooth
>>> applications, if by the time it calls getPrimaryServices the discovery
>>> is active there is a chance it will return outdated services.
>>> Essentially it is a polling API.
>>>
>>> You can read more about this issue here:
>>>
>>> https://github.com/thegecko/web-bluetooth-dfu/issues/12#issuecomment-194973956
>>
>> In case discovery is in progress, API such as getPrimaryServices()
>> could queue response until discovery is done. This is possible with
>> both "Discovering" and "Discovered", but the latter has significant
>> advantage here: just after connected, you know exactly when initial
>> discovery finished, because there will be single transition
>> Discovered=false->true. In case of "Discovering" there's problem I
>> mentioned before when you start with Discovering=false so there's
>> chance application gets services even before initial discovery - we've
>> seen such races when application is trying to read/write
>> characteristic using existing D-Bus object just after connection, but
>> before fixed ATT channel was established in BlueZ.
>
> I think this problem with ATT has been solved actually, so the object
> have access to bt_gatt_client immediately after connection so
> read/write can be processed.

I've just checked on latest master, e.g. try to call
org.bluez.GattCharacteristic1.ReadValue on known object path when
received Connected=true and it fails.

Connected: yes
ERROR:dbus.connection:Exception in handler for D-Bus signal:
Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/dbus/connection.py", line 230,
in maybe_handle_message
    self._handler(*args, **kwargs)
  File "./andk-test", line 34, in idev_changed_cb
    ichar.ReadValue()
  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 70, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 145, in __call__
    **keywords)
  File "/usr/lib/python3/dist-packages/dbus/connection.py", line 651,
in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.bluez.Error.Failed: Not connected

> Btw, may latest patch actually contain
> some changes so the signal order looks like this:
>
> [CHG] Device ... Connected: yes
> [CHG] Device ..  ServicesResolved: yes
> [CHG] Device ... ServicesResolved: no
> [CHG] Device ... Connected: no
>
> It basically follows svc_refreshed flag.

Ok, I'll check new patch and comment there.

>> As for Service Changed, as you mentioned in comment linked above, this
>> cannot be really solved without some kind of notification to
>> application. Other possibility (without notifications) is that object
>> created by "outdated" getPrimaryServices() call with simply return an
>> error forcing application to call getPrimaryServices() again. But this
>> has to be solved in Web Bluetooth somehow anyway...
>
> Yep, but I guess this is some unlikely to happen during a connection
> that nobody care to add an API for it.

Android does it when application (un)registers service, iOS does the
same... And for example, Apple's notification service (ANCS)
specification states explicitly that this service may appear and
disappear during connection so implementations are required to use
Service Changed. I guess it's something to be fixed in Web Bluetooth
for sure.

BR,
Andrzej
