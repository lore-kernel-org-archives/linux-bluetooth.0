Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABKPALoH6oOFEzHpA4DMtsZSqGUdg88ODQWdJ_1uLEOkQc5u=Q@mail.gmail.com>
References: <CABKPALpbGG8vXj+10MuG97wZaHoDJBhj5MtrKjfJQhQ_xbpp1Q@mail.gmail.com>
	<CAD0=r8wkU8NZ6zfQ=Aq0aSvPAnPN=nwmz6NHLygd1UiV3ScyPQ@mail.gmail.com>
	<CABKPALoH6oOFEzHpA4DMtsZSqGUdg88ODQWdJ_1uLEOkQc5u=Q@mail.gmail.com>
Date: Sat, 27 Jun 2015 08:44:17 -0500
Message-ID: <CABKPALpNgv90zkCpAu+GDfzJy95m71p1spD-0qMfDJ-9TOOGXw@mail.gmail.com>
Subject: Re: Another PropertiesChanged observation
From: Neil Martin <neil@vnp.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now I've had a chance to try this, I'm not sure I'm able to do what I
want, if I'm reading the docs correctly.  The docs seem to imply that
RSSI filtering only works when UUIDs are set.  In my case, the devices
aren't advertising services.  I did try setting RSSI by itself, but
the result was that I got no PropertiesChanged signals at all.  Am I
missing something?

As a general comment, I'd say that the hardcoded 8db delta is a bad
idea.  Firstly, 8 is an arbitrary choice.  Also, it seems to me that
it would be desirable to have two values settable through the filter
for RSSI - 1) the delta and 2) the absolute threshold.  That would
make this feature a lot more flexible.  It also seems desirable to be
able to filter independent of UUIDs, but maybe I'm misinterpreting the
docs.

Neil

On Fri, Jun 26, 2015 at 7:34 AM, Neil Martin <neil@vnp.com> wrote:
> Hi Jakub,
>
> Thanks for the response.  That makes sense - I'll give that a try.
>
> I'm running this on a Raspberry Pi with a Medialink USB adapter which
> (I believe) has a Broadcom chipset.
>
> Neil
>
> On Thu, Jun 25, 2015 at 9:30 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> Hi Neil,
>>
>> On Thu, Jun 25, 2015 at 2:53 PM, Neil Martin <neil@vnp.com> wrote:
>>> Hi,
>>>
>>> I've noticed that the bluetoothd console output shows a steady stream
>>> of RSSI updates, yet only a fraction of these seem to translate into a
>>> DBus PropertiesChanged signal.
>>>
>>> I've just seen 50 or so messages from bluetoothd of the form:
>>>
>>> bluetoothd[3867]: src/adapter.c:device_found_callback() hci0 addr
>>> D0:4F:7E:2B:74:31, rssi -91 flags 0x0000 eir_len 15
>>>
>>> while only seeing a single PropertiesChanged signal from dbus-monitor
>>> with an RSSI update.
>>
>> That's because by default there is a threshold of 8db:
>>
>> #define RSSI_THRESHOLD 8
>>
>> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/src/device.c#n88
>>
>> So if RSSI is changed less than 8dB you don't get any updates through D-Bus.
>>
>> If you want to get updates through D-Bus, you should call
>> SetDiscoveryFilter first, see doc:
>> "If one or more discovery filters have been set, the RSSI
>> delta-threshold, that is imposed by StartDiscovery by default, will
>> not be applied."
>> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/adapter-api.txt#n48
>>
>>
>> Can I ask what kind of controller do you use ? Some just don't do
>> packet deduplication during scan, and would report all  packets
>> received, that would explain flow of events from kernel.
>>
>> Jakub
>>
>>>
>>> Neil
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
