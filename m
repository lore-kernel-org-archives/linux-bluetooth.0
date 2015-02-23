Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <CAD0=r8wRwktX2EBmv2qg-NcbZfFGytjn3gRdjDYGXwrjG5ejDw@mail.gmail.com>
References: <1423528495-13173-1-git-send-email-jpawlowski@google.com>
	<CABBYNZLaFta8897Xr91UQ-sUy-COviXxRP84GKTyYSUQDfDjyg@mail.gmail.com>
	<20150223130923.GA28722@t440s.lan>
	<CAD0=r8zStMB6WVf0iGW59rS_x_+c-gmNUmG1OhhdXOatSj_amw@mail.gmail.com>
	<CAD0=r8wRwktX2EBmv2qg-NcbZfFGytjn3gRdjDYGXwrjG5ejDw@mail.gmail.com>
Date: Mon, 23 Feb 2015 13:43:28 -0800
Message-ID: <CAHrH25Q4-3EUs2m-XPpY7qpvkWcLmw0a6L938ab_XfRYKidAiQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5] doc/adapter-api.txt: StartFilteredDiscovery method.
From: Arman Uguray <armansito@chromium.org>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub, Johan,

> On Mon, Feb 23, 2015 at 10:43 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> On Mon, Feb 23, 2015 at 8:41 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> Hi Johan, Luiz
>>
>> On Mon, Feb 23, 2015 at 5:09 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>>> Hi Luiz,
>>>
>>> On Mon, Feb 16, 2015, Luiz Augusto von Dentz wrote:
>>>> > +               void StartFilteredDiscovery(dict filter)
>>>> > +
>>>> > +                       This method starts the device discovery session with
>>>> > +                       filtering by uuids, and rssi or pathloss value. Use
>>>> > +                       StopDiscovery to release the sessions acquired.
>>>> > +
>>>> > +                       Parameters that can be set in filter dictionary include
>>>> > +                       the following:
>>>> > +
>>>> > +                       array{string} UUIDs : filtered service UUIDs (required)
>>>> > +                       int16 RSSI      : RSSI threshold value (optional)
>>>> > +                       uint16 pathloss : Pathloss threshold value (optional)
>>>> > +                       string transport: type of scan to run
>>>> > +
>>>> > +                       When a device is found that advertise any UUID from
>>>> > +                       UUIDs, it will be reported if:
>>>> > +                       - pathloss and RSSI are both empty,
>>>> > +                       - only pathloss param is set, device advertise TX pwer,
>>>> > +                         and computed pathloss is less than pathloss param,
>>>> > +                       - only RSSI param is set, and received RSSI is higher
>>>> > +                         than RSSI param,
>>>> > +
>>>> > +                       transport parameter determines the type of scan:
>>>> > +                               "auto"  - interleaved scan
>>>> > +                               "bredr" - br/edr inquiry
>>>> > +                               "le"    - le only scan, default value
>>>> > +
>>>> > +                       This process will start creating Device objects as new
>>>> > +                       devices matching criteria are discovered. It will also
>>>> > +                       emit PropertiesChanged signal for already existing
>>>> > +                       Device objects, with updated RSSI value.
>>>> > +
>>>> > +                       StartDiscovery (SD) takes precedence over
>>>> > +                       StartFilteredDiscovery (SFD). That means that you should
>>>> > +                       check Discovering property before calling SFD, otherwise
>>>> > +                       it would fail when any SD session is in progress.
>>>> > +                       Calling SD when SFD is in progress pause all SFD
>>>> > +                       sessions, and start them back when all SD sessions are
>>>> > +                       finished. When filtered discovery state is changed,
>>>> > +                       FilteredDiscovery variable is updated accordingly.
>>>> > +
>>>> > +                       Possible errors: org.bluez.Error.NotReady
>>>> > +                                        org.bluez.Error.Failed
>>>> > +
>>>> >                 void StopDiscovery()
>>>> >
>>>> >                         This method will cancel any previous StartDiscovery
>>>> > @@ -144,6 +188,11 @@ Properties string Address [readonly]
>>>> >
>>>> >                         Indicates that a device discovery procedure is active.
>>>> >
>>>> > +               boolean FilteredDiscovery [readonly]
>>>> > +
>>>> > +                       Indicates that a filtered device discovery procedure is
>>>> > +                       active.
>>>> > +
>>>> >                 array{string} UUIDs [readonly]
>>>> >
>>>> >                         List of 128-bit UUIDs that represents the available
>>>> > --
>>>> > 2.2.0.rc0.207.ga3a616c
>>>>
>>>> @Marcel, Johan: Is this API okay for you? We should probably make them
>>>> experimental to begin with.
>>>
>>> For the most part I'm fine with this, especially if it's marked as
>>> experimental. As for the relationship to StartDiscovery, I'd take a
>>> similar approach as we have done with the mgmt API, i.e. StartDiscovery
>>> would be just a special kind of filtered discovery without any filters
>>> (i.e. reporting all devices).
>>
>> I want StartDiscovery to behave differently than
>> StartFilteredDiscovery without any filter:
>> 1. StartDiscovery is interleaved scan, StartFilteredDiscovery is by
>> default doing LE only scan (BR/EDR doesn't make no point here). If
>> StartFilteredDiscovery would do interleaved scan, it would waste half
>> of time not reporting anything.
>> 2. StartDiscovery is reporting RSSI changes with delta of 8dB or more,
>> StartFilteredDiscovery will report every RSSI change it gets, to allow
>> better proximity approximation. If StartDiscovery report every RSSI
>> change it would break some use cases (i.e. menus showing list of
>> devices would flicker), if StartFilteredDiscovery won't return every
>> RSSI change it would kill my use case.
>>
>>
>>>
>>> For the case of multiple applications requesting different discoveries
>>> at the same time we'd go with the common denominator approach, i.e.
>>> applications must be prepared to see devices outside of the range of
>>> filters that it has specified (the only way to avoid something like that
>>> support is to do unicast D-Bus signals which in turn would break
>>> "passive observer" applications). Calling StartDiscovery when there are
>>> one or more service discoveries in progress would simply clear out the
>>> filters and start reporting all devices.
>>
>> Yes, applications must be prepared to see devices outside of range.
>> When you call StartDiscovery when StartFilteredDiscovery is in
>> progress, filtered discoveries should be paused, and properties should
>> be changed accordingly ("FilteredDiscovery"=false,
>> "Discovering"=true).  This would make sure that we don't cause
>> regressions in apps already using StartDiscovery, and new apps that
>> use StartFilteredDiscovery might detect this change by looking at
>> properties, and try to handle it correctly (if they're fine with less
>> frequent RSSI updates, no proximity) or show some message and wait for
>> other apps to stop their discovery.
>>
>>>
>>> Considering the above style approach, the new property seems a bit
>>> pointless.
>>
>> As I mentioned it'll be needed for apps that do StartFilteredDiscovery
>> to check wether it's currently paused to allow other app to do it's
>> StartDiscovery (it takes precedence over StartFilteredDiscovery).
>>
>>>
>>> Since we can't any more track multiple different discoveries within the
>>> same application (D-Bus connection) the StopDiscovery behavior is now
>>> quite broken. The simplest way around that would be to add a discovery
>>> instance return parameter to StartServiceDiscovery and to have a new
>>> StopServiceDiscovery D-Bus method that'd take this as an input
>>> parameter.
>>
>> Right now each application can call StartDiscovery only once, I want
>> each application to be able to call StartDiscovery OR
>> StartFilteredDiscovery only once. This way we are completly fine with
>> one StopDiscovery method. If some application needs to change filter,
>> it can always stop and restart it's scan.
>
> It might be good idea to allow multpile StartFilteredDiscovery calls
> from one client, each replacing the old filter. It would still require
> only one StopDiscovery method.
>

The 8 dB RSSI argument isn't really valid since this is something that
we can change in the API definition. You're saying that interleaved
scan is wasteful but that's beside the point here, since the API does
allow passing "auto" and "bredr" as the argument and "le" just happens
to be the default option.

>From an API stand point, I like Johan's suggestion better. Basically
we treat all discovery APIs as "filtered" except StartDiscovery is
just a special case of StartFilteredDiscovery that has 8 dB as the
"RSSI" argument and "auto" for transport. If an app wants to use a
lower RSSI threshold then whether or not the UI will flicker should be
the responsibility of the UI code. Basically we should treat
StartDiscovery as a legacy API and perhaps mark it as deprecated while
maintaining support for it for backwards compatibility.

Within the new framework, many apps can call StartFilteredDiscovery
with differing filters so the daemon should just adapt the filter
based on the biggest common denominator. So if I called
StartFilteredDiscovery with no UUIDs and someone else calls it with a
UUID, the initial call should win. If the first app calls
StopDiscovery then we fallback to the second app's filter, etc.

>>
>>>
>>> Johan
>>
>> Jakub
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Arman
