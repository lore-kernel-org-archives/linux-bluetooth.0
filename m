Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+JoqhDtH_ZN9bVafMnDYgyjsmwKnTssA8_QFJ1js9kQA@mail.gmail.com>
References: <CAD0=r8wfL1TYghMk2wHYrZFZ9D=sz49_1fNPVsPvgqOUVdbuCQ@mail.gmail.com>
	<CABBYNZ+JoqhDtH_ZN9bVafMnDYgyjsmwKnTssA8_QFJ1js9kQA@mail.gmail.com>
Date: Thu, 28 May 2015 15:25:54 -0700
Message-ID: <CAD0=r8wDGKw4DRnEAsZqNvMc05CGnjz7HVFc6MTQZi74L9xC1Q@mail.gmail.com>
Subject: Re: [RFC] Add new method to DBus API: DiscoverServiceByUUID
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, May 28, 2015 at 2:32 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jakub,
>
> On Thu, May 28, 2015 at 11:44 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> Currently, calling org.bluez.Device1.Connect() on a new, never
>> connected before device, would cause automatic discovery of all
>> services.
>>
>> This is bad in some cases, because discovering all available services
>> might take a long time. Additionally some devices, i.e. iPhone have
>> built-in 0.5s delay between each "Find Information Response" packet,
>> which make discovery even longer.
>>
>>
>> I would like to propose following change:
>>
>> 1. Calling org.bluez.Device1.Connect() would work just like now,
>> except no "Find Information Request" would be issued (that means no
>> call to "device_browse_gatt").
>>
>> 2. Add two new methods: org.bluez.Device1.DiscoverServices(), and
>> org.bluez.Device1.DiscoverServiceByUUID(uuid). First one would just
>> call device_browse_gatt and make "Find Information Request" , the
>> second one would issue "Find By Type Value Request" to find just one
>> service.
>
> You are just changing one problem to another, or actually many other problems:
>

Example use case to make things clearer:
there's device advertising it contains service with UUID "abcd", and
my app wants to use only this one. It connects to device, and asks
only for this service. If it's not there I disconnect. If it's there,
it read/writes and disconnect.
Everything took ~1.5 second.

If I can't do "Find By Type Value Request" I'm stuck discovering
services for 6, or 10, or more seconds, depending of number of
services on device.


> 1. Instead of just 1 method there is at least 2, but Connect depends
> on what has been discovered first so you are adding a D-Bus round
> trips.

Yes, I'm probably adding one round trip. It might hovewer be avoided.
To avoid additional roundtrip there should be two methods:
Connect() that just works right now, and ConnectToUUID(uuid) that
would connect, and then do "Find By Type Value Request". I think that
this solution wouldn't be that clean, and would be problematic to
discover rest of services.

One round trip per connection isn't that bad issue, is it ?

> 2. DiscoverServiceByUUID can only discover primary services if I
> remember correct, what about included? And if an application, or many,

It can discovery Primary or Secondary services, but it is used for
Primary only right now as far as I know.

> decide to discovery one by one every single UUID defined in the spec,
> how many more request that would be compared to Read by Group Type
> Request?

If application want to use only one service, and it cares about speed
it should use this new method (I think that's the reason Bluetooth
have "Find By Type Value Request").
If application doesn't know what it wants, it should find all services for sure.
If application want more than one service, or included service, it
should probably discover all at once.
If application wants to discover included service, it can do Read by
Group Type with handle range that's included in "included service"
attribute (would need new API method if we want that, or use discover
all service).


> 3. We can't take advance of Service Changed Characteristic if
> DiscoverServiceByUUID, so at that point one would have to start
> polling if the remote server has capability to change its database.
>
> I guess the problem number 3 is actually what you did not consider,
> the whole point is that we discover only once and then let the server
> tell us what has changed, so reconnection should happens very fast
> because we already have the device database in cache.

Right, I haven't conseidered number 3, but:
- app might decide to later discover rest of services, or
- just service I discovered might be still cached, or
- service I need might be re-discovered because it's only one  and
it's fast in comparison to discovering all
- maybe if device get paired, full service discovery will be required
? otherwise it'll change MAC in 15 minutes and be forgotten anyway.

I'll figure out how to deal nicely with cache.

I think that discovering one service should be a option in modern BLE
API (and I know few projects that need it).
Please note that i.e. MAC API have that. For other reasons why that's
good idea see "Explore a Peripheral’s Data Wisely" at
https://developer.apple.com/library/mac/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/BestPracticesForInteractingWithARemotePeripheralDevice/BestPracticesForInteractingWithARemotePeripheralDevice.html#//apple_ref/doc/uid/TP40013257-CH6-SW6

I think it's more "how to do it right" than "whether to do it".

Thanks,
Jakub.

>
>
> --
> Luiz Augusto von Dentz
