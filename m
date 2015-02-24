Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Feb 2015 12:51:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: Arman Uguray <armansito@chromium.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH BlueZ v5] doc/adapter-api.txt: StartFilteredDiscovery
 method.
Message-ID: <20150224105157.GA7112@t440s.lan>
References: <1423528495-13173-1-git-send-email-jpawlowski@google.com>
 <CABBYNZLaFta8897Xr91UQ-sUy-COviXxRP84GKTyYSUQDfDjyg@mail.gmail.com>
 <20150223130923.GA28722@t440s.lan>
 <CAD0=r8zStMB6WVf0iGW59rS_x_+c-gmNUmG1OhhdXOatSj_amw@mail.gmail.com>
 <CAD0=r8wRwktX2EBmv2qg-NcbZfFGytjn3gRdjDYGXwrjG5ejDw@mail.gmail.com>
 <CAHrH25Q4-3EUs2m-XPpY7qpvkWcLmw0a6L938ab_XfRYKidAiQ@mail.gmail.com>
 <CAD0=r8zamcBm1RqAEpp2Y1VfWuOCY=TrmtQwJ-kF5reZe-c9DQ@mail.gmail.com>
 <CAHrH25Q96P8-9DqF0m34BZxWNGucb1Q0iX7X06RSsXeFrF4eyQ@mail.gmail.com>
 <CAD0=r8xD7wSxNpOFv5hiE+oNF40RPdywOdm9j2ZaXpQ=m+FY0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD0=r8xD7wSxNpOFv5hiE+oNF40RPdywOdm9j2ZaXpQ=m+FY0Q@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Feb 23, 2015, Jakub Pawlowski wrote:
>>>> From an API stand point, I like Johan's suggestion better. Basically
>>>> we treat all discovery APIs as "filtered" except StartDiscovery is
>>>> just a special case of StartFilteredDiscovery that has 8 dB as the
>>>> "RSSI" argument and "auto" for transport. If an app wants to use a
>>>> lower RSSI threshold then whether or not the UI will flicker should be
>>>> the responsibility of the UI code. Basically we should treat
>>>> StartDiscovery as a legacy API and perhaps mark it as deprecated while
>>>> maintaining support for it for backwards compatibility.
>>>
>>> I think you get the meaning of RSSI parameter wrong. It's not delta,
>>> chow much rssi must change to report device again (I think chromeos
>>> change that internally to something smaller). It's for proximity - if
>>> device reported RSSI is bigger than this RSSI parameter then report
>>> it, and there's no delta - we report every RSSI change we get (around
>>> 3 times/sec).
>>
>> You're right, it's just delta so I was wrong there. Still, the 8 dBm
>> thing shouldn't dictate how the discovery API should work since it
>> only affects what delta threshold to use when updating the
>> Device1.RSSI property. So, perhaps we can add a global D-Bus property
>> for RSSI delta-threshold or perhaps make that a filter parameter of
>> StartFilteredDiscovery.
>
> If we add global property for changing RSSI delta-threshold we would
> have to define api to change and probably also negotiate RSSI when
> multiple apps require different values.
> Putting it into StartFilteredDiscovery parameter seems more
> reasonable, but do we really need that ?
> Can't we just have no RSSI delta for filtered scan, and let apps
> decide on their own in their logic ?

If something like this was exposed through D-Bus then a parameter to
StartFilteredDiscovery would be the way to go, I think. However, until
we have a clear need for it we can simply keep track of this internally.
I.e. StartDiscovery keeps imposing the delta-threshold but as soon as
there's one or more StartFilteredDiscovery active this type of filtering
is removed.

Johan
