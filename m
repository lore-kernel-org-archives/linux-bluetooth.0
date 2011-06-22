Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <544C7016-5346-4C99-AEA9-C91AA84E3A42@signove.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com>
	<C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com>
	<BANLkTikNQac7UsMgKdnoVR7kVQSV6tVn6g@mail.gmail.com>
	<A2B092BC-BE3C-4C0A-917D-0253EF23943A@signove.com>
	<BANLkTik9muPgh_Xx3UTh7rEpzj-C7fVxuQ@mail.gmail.com>
	<544C7016-5346-4C99-AEA9-C91AA84E3A42@signove.com>
Date: Wed, 22 Jun 2011 15:24:47 +0200
Message-ID: <BANLkTikyqm9ysgT47XQvr_vYQL1vdGPBuA@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: Santiago Carot <sancane@gmail.com>
To: Elvis Pfutzenreuter <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/6/22 Elvis Pfutzenreuter <epx@signove.com>:
> On Jun 22, 2011, at 7:20 AM, Santiago Carot wrote:
>
>> Hi,
>>
>> 2011/6/21 Elvis Pfutzenreuter <epx@signove.com>:
>>> On Jun 21, 2011, at 12:56 PM, Santiago Carot wrote:
>>>
>>> (cut)
>>>
>>>>>
>>>>> Another option would be to guarantee that MeasureReceived() is called
>>>>> right after agent registering, in order to give the client an
>>>>> initial value to show (having in mind that notification interval might
>>>>> be very long).
>>>>
>>>> I would prefer to use the Final and Intermediate properties too. The
>>>> problem that we should address occurs when an application wich hasn't
>>>> got a watcher registered sets Intermediate or Final measurement
>>>> property and the last watcher is removed. I think that the best option
>>>> may be turn off measurments for power safe due that no watcher will
>>>> get the measures.
>>>
>>> I'm not sure I follow. Enabling intermediate and/or final notifications
>>> is done per-agent basis; if any of active agents needs intermediate
>>> measurements, device is configured to send them. Disabling it on one
>>> agent should not hurt another.
>>>
>>
>> I mean the case when a process (it is not neccesary it has to be an
>> agent) is enabling intermediate and/or final notifications through
>> setProperty method in D-Bus API. Please, note that any process can do
>> this in current API because no extra control is done for this
>> operation.
>>
>> May be I'm misundertanding what you want to said with per-agent basis
>> but as far as I see the only way to manage enabling/disabling
>> properties in this way is by adding a new parameter in setProperty
>> method with the agent path and checkicng if it is already registered
>> before enabling or disabling intermediate and final notifications. IMO
>> If we do this we would break the BlueZ APIs where no extra parameters
>> are required in such methods. I'm not sure if this would be a problem
>> but I don't feel comfortable with this solution.
>>
>> On the other hands, if we discard adding the agent parameter in that
>> method (which I think that it fits better in BlueZ API), we can ignore
>> the case when there aren't any agents registered for the thermometer
>> service and a process enables some of this properties. In this case it
>> wouldn't be necessary to activate these properties since no one will
>> receive notifications for the measures.
>
> True, I did not remember that those were properties. They would have
> to go, otherwise it is too easy for an app to "break" another, by
> disabling notifications.
>
> A pair of Enable/DisableIntermediate methods taking an agent as
> parameter would be more adequate.
>
> IMHO there would not be a need of such
> methods for final measure, because the final measurement (which is
> the only one guaranteed to be precise) is the final objective, there
> is no point in registering an agent and not wanting a final measurement.
>

They werent in this RFC. I only see a problem now, for example if an
agent wants to get only a single *final* measure without setting an
interval and after a while the same agents decides that it wants to
get a new single measure without setting an interval for periodic
measurements. I don't see how it could do this with current API (where
get final measure methods are not present).

We could think that an agent is only registered during the time it is
interested in being notified about final measures, after that, it
should unregister itself from the service. In that scenario we can set
notify property for final measures each time an agent is registered
(if not periodic interval is already set).

Any suggestion?

Regards.
