Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <D360EBE5-466B-41F7-9837-786786B153B9@signove.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com>
	<C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com>
	<BANLkTikNQac7UsMgKdnoVR7kVQSV6tVn6g@mail.gmail.com>
	<A2B092BC-BE3C-4C0A-917D-0253EF23943A@signove.com>
	<BANLkTik9muPgh_Xx3UTh7rEpzj-C7fVxuQ@mail.gmail.com>
	<544C7016-5346-4C99-AEA9-C91AA84E3A42@signove.com>
	<BANLkTikyqm9ysgT47XQvr_vYQL1vdGPBuA@mail.gmail.com>
	<7B7AE0E9-F6A0-4EBD-9FEA-44DD9C7996D0@signove.com>
	<BANLkTin-gXA7fWCA98j8U1Vv=L39OC-nOw@mail.gmail.com>
	<D360EBE5-466B-41F7-9837-786786B153B9@signove.com>
Date: Thu, 23 Jun 2011 17:35:50 +0200
Message-ID: <BANLkTimerKtd7FypbQ7MzC9CXAzM5c5rvA@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: Santiago Carot <sancane@gmail.com>
To: Elvis Pfutzenreuter <epx@signove.com>
Cc: mike tsai <mikeyhtsai@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/6/23 Elvis Pfutzenreuter <epx@signove.com>:
> On 22 Jun 2011, at 18:44 , mike tsai wrote:
>
>> Hi,
>>
>> On Wed, Jun 22, 2011 at 6:50 AM, Elvis Pfutzenreuter <epx@signove.com> wrote:
>>>>>> (cut)
>>>>>
>>>>> True, I did not remember that those were properties. They would have
>>>>> to go, otherwise it is too easy for an app to "break" another, by
>>>>> disabling notifications.
>>>>>
>>>>> A pair of Enable/DisableIntermediate methods taking an agent as
>>>>> parameter would be more adequate.
>>>>>
>>>>> IMHO there would not be a need of such
>>>>> methods for final measure, because the final measurement (which is
>>>>> the only one guaranteed to be precise) is the final objective, there
>>>>> is no point in registering an agent and not wanting a final measurement.
>>>>>
>>>>
>>>> They werent in this RFC. I only see a problem now, for example if an
>>>> agent wants to get only a single *final* measure without setting an
>>>> interval and after a while the same agents decides that it wants to
>>>> get a new single measure without setting an interval for periodic
>>>> measurements. I don't see how it could do this with current API (where
>>>> get final measure methods are not present).
>>>
>>> For that, having temperature as one of the properties would be great
>>> (allowing apps unable/unwilling to set up an agent to read it).
>>>
>>> Or setting a convention that, if you register an agent, a GATT read is
>>> fired and you get a measurement right after. (It seems that you said
>>> something in that direction below.) Disvantage is that registering
>>> and unregistering agents just to get 1 measurement would cycle
>>> GATT indications needlessly.
>>>
>>>> We could think that an agent is only registered during the time it is
>>>> interested in being notified about final measures, after that, it
>>>> should unregister itself from the service. In that scenario we can set
>>>> notify property for final measures each time an agent is registered
>>>> (if not periodic interval is already set).
>>>
>>> In terms of minimizing energy consumption and API methods, the 'best'
>>> would be:
>>>
>>> a) intermediate and final temperatures being properties (intermediate
>>>   property is there only if thermometer supports it).
>>>
>>> b) There are GATT reads on them when some app reads the property;
>>>
>> [MT] Final temperature can only be indicated and intermediate
>> temperature can only be notified. Client can't read them from server,
>> according to the Thermometer profile spec.
>
> Glup, that is true :\
>
> In other profiles people are taking care of making notifiable
> characteristics readable as well, but it slipped for thermometer.
>
> In this case, the only reason one could argue using properties for
> temperatures would be to reuse the PropertyChanged for notifications
> and indications. BlueZ could store the last temperature locally,
> should some app wants it immediately. (The special IEEE FLOAT values
> take care of the case where a measurement hasn't been taken yet.)

I would prefer not to use properties for the measures for several
reasons. First of them is because of we should  have to store the last
temperature locally, Sometimes the device does not include time stamp
in the measure because is not mandatory. if the device does not
support storing of data we should to include a timestamp because after
a while an application may want to read the last measure. That is not
severe but we are adding extra information to the data that it isn't
provided by the thermometer, IMO it seems a little ugly. The same case
for intermediate temperature.

On the other hands, a new PropertyChange signal would be triggered on
the bus each time a measure arrives, I think that it may be too heavy
specially in the case of intermediate measures where the rate of
updates is higher.

For above reasons I think that we should use a callback in the agent
side whenever it is possible.
>
>>
>>> c) those properties generate PropertyChanged signals only when
>>> notifications are enabled for one or another, or there was a GATT read;
>>>
>>> d) applications signal interest in notifications by registering
>>> an agent (or by some other way). Registering an agent automatically
>>> means interest in final temp notifications, an additional method
>>> enables/disables interest in intermediate temp notifications.
>>>
>> [MT] Once indication or notification is enabled, client has to be
>> ready to receive notification or indication as soon as the physical
>> link is established with the temperature sensor.
>
> Ok, but we can disable it when no agent is active, right?
