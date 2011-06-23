Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTin-gXA7fWCA98j8U1Vv=L39OC-nOw@mail.gmail.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com>
	<C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com>
	<BANLkTikNQac7UsMgKdnoVR7kVQSV6tVn6g@mail.gmail.com>
	<A2B092BC-BE3C-4C0A-917D-0253EF23943A@signove.com>
	<BANLkTik9muPgh_Xx3UTh7rEpzj-C7fVxuQ@mail.gmail.com>
	<544C7016-5346-4C99-AEA9-C91AA84E3A42@signove.com>
	<BANLkTikyqm9ysgT47XQvr_vYQL1vdGPBuA@mail.gmail.com>
	<7B7AE0E9-F6A0-4EBD-9FEA-44DD9C7996D0@signove.com>
	<BANLkTin-gXA7fWCA98j8U1Vv=L39OC-nOw@mail.gmail.com>
Date: Thu, 23 Jun 2011 11:51:32 +0200
Message-ID: <BANLkTikgeU2aUF0srbgCuG6MVf4UtVJdmw@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: Santiago Carot <sancane@gmail.com>
To: mike tsai <mikeyhtsai@gmail.com>
Cc: Elvis Pfutzenreuter <epx@signove.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

2011/6/22 mike tsai <mikeyhtsai@gmail.com>:
> Hi,
>
> On Wed, Jun 22, 2011 at 6:50 AM, Elvis Pfutzenreuter <epx@signove.com> wrote:
>>>>> (cut)
>>>>
>>>> True, I did not remember that those were properties. They would have
>>>> to go, otherwise it is too easy for an app to "break" another, by
>>>> disabling notifications.
>>>>
>>>> A pair of Enable/DisableIntermediate methods taking an agent as
>>>> parameter would be more adequate.
>>>>
>>>> IMHO there would not be a need of such
>>>> methods for final measure, because the final measurement (which is
>>>> the only one guaranteed to be precise) is the final objective, there
>>>> is no point in registering an agent and not wanting a final measurement.
>>>>
>>>
>>> They werent in this RFC. I only see a problem now, for example if an
>>> agent wants to get only a single *final* measure without setting an
>>> interval and after a while the same agents decides that it wants to
>>> get a new single measure without setting an interval for periodic
>>> measurements. I don't see how it could do this with current API (where
>>> get final measure methods are not present).
>>
>> For that, having temperature as one of the properties would be great
>> (allowing apps unable/unwilling to set up an agent to read it).
>>
>> Or setting a convention that, if you register an agent, a GATT read is
>> fired and you get a measurement right after. (It seems that you said
>> something in that direction below.) Disvantage is that registering
>> and unregistering agents just to get 1 measurement would cycle
>> GATT indications needlessly.
>>
>>> We could think that an agent is only registered during the time it is
>>> interested in being notified about final measures, after that, it
>>> should unregister itself from the service. In that scenario we can set
>>> notify property for final measures each time an agent is registered
>>> (if not periodic interval is already set).
>>
>> In terms of minimizing energy consumption and API methods, the 'best'
>> would be:
>>
>> a) intermediate and final temperatures being properties (intermediate
>>   property is there only if thermometer supports it).
>>
>> b) There are GATT reads on them when some app reads the property;
>>
> [MT] Final temperature can only be indicated and intermediate
> temperature can only be notified. Client can't read them from server,
> according to the Thermometer profile spec.

With reference to final measurement, I think that the best solution
may be a mix between previous RFC and this one. We could have a
feature "Final" that applications can enable through SetProperty
method. If some process change its value the proper signal is emmited
as usual. When the final measure arrived, the callack and
propertychange signal is emmited too indicating that its value has
changed from true to False and no more final measures will be scanned.
In this way, everybody could get final measures without have to set
periodic intervals.

Of course, we can ignore this action if some process set this property
and no watchers are registered. In this way we can save GATT traffic
and power consumption because in this case there are'nt agents
interested in getting measures.

>> c) those properties generate PropertyChanged signals only when
>> notifications are enabled for one or another, or there was a GATT read;
>>
>> d) applications signal interest in notifications by registering
>> an agent (or by some other way). Registering an agent automatically
>> means interest in final temp notifications, an additional method
>> enables/disables interest in intermediate temp notifications.

It seems a mix between both RFCs. What do you think if I prepare a new
API to send it to the mailing list during the day?

Regards
