Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A2B092BC-BE3C-4C0A-917D-0253EF23943A@signove.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com>
	<C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com>
	<BANLkTikNQac7UsMgKdnoVR7kVQSV6tVn6g@mail.gmail.com>
	<A2B092BC-BE3C-4C0A-917D-0253EF23943A@signove.com>
Date: Wed, 22 Jun 2011 12:20:34 +0200
Message-ID: <BANLkTik9muPgh_Xx3UTh7rEpzj-C7fVxuQ@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: Santiago Carot <sancane@gmail.com>
To: Elvis Pfutzenreuter <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/6/21 Elvis Pfutzenreuter <epx@signove.com>:
> On Jun 21, 2011, at 12:56 PM, Santiago Carot wrote:
>
> (cut)
>
>>>
>>> Another option would be to guarantee that MeasureReceived() is called
>>> right after agent registering, in order to give the client an
>>> initial value to show (having in mind that notification interval might
>>> be very long).
>>
>> I would prefer to use the Final and Intermediate properties too. The
>> problem that we should address occurs when an application wich hasn't
>> got a watcher registered sets Intermediate or Final measurement
>> property and the last watcher is removed. I think that the best option
>> may be turn off measurments for power safe due that no watcher will
>> get the measures.
>
> I'm not sure I follow. Enabling intermediate and/or final notifications
> is done per-agent basis; if any of active agents needs intermediate
> measurements, device is configured to send them. Disabling it on one
> agent should not hurt another.
>

I mean the case when a process (it is not neccesary it has to be an
agent) is enabling intermediate and/or final notifications through
setProperty method in D-Bus API. Please, note that any process can do
this in current API because no extra control is done for this
operation.

May be I'm misundertanding what you want to said with per-agent basis
but as far as I see the only way to manage enabling/disabling
properties in this way is by adding a new parameter in setProperty
method with the agent path and checkicng if it is already registered
before enabling or disabling intermediate and final notifications. IMO
If we do this we would break the BlueZ APIs where no extra parameters
are required in such methods. I'm not sure if this would be a problem
but I don't feel comfortable with this solution.

On the other hands, if we discard adding the agent parameter in that
method (which I think that it fits better in BlueZ API), we can ignore
the case when there aren't any agents registered for the thermometer
service and a process enables some of this properties. In this case it
wouldn't be necessary to activate these properties since no one will
receive notifications for the measures.

>>
>> We can change the API to do that. What do you think?
>>
>>
>>>
>>>> +
>>>> +
>>>> +Health Thermometer Watcher hierarchy
>>>> +====================================
>>>> +Service              unique name
>>>> +Interface    org.bluez.ThermometerWatcher
>>>> +Object path  freely definable
>>>> +
>>>> +Methods              void MeasureReceived(dict measure)
>>>> +
>>>> +                     This callback gets called when a measure has been
>>>> +                     scanned in the thermometer. The Value entry corresponds
>>>> +                     to IEEE-11073 32-bit FLOAT.The Time entry in the dict
>>>> +                     will be only present if the device supports storing of
>>>> +                     data. The time value is expressed in seconds since epoch.
>>>
>>> Using such a special type (FLOAT) looks funny. Not sure whether it is the best option
>>> for this API.
>>>
>>> At the very least, a description of FLOAT type should be added to the API, since
>>> IEEE 11073 specs are not public/free, and API users would have to resort to unofficial
>>> source to learn it.
>>>
>>> I understand why you used this type (keeps the thermometer transcodable through this
>>> API and there are the special values), so BTW the lack of device information service
>>> access through this API should at least be mentioned, so we ammend that later (either
>>> here or adding another API).
>>
>> ...or we can split the value in their exponent and mantissa
>> components. Any suggestion?
>
> I'd go for that, but we need to take a look on special values to see if it makes sense.
> It would be really ugly to say something like "if mantissa=5 and exponent=-3 then
> temperature is actually zero" :)

We could provide special values in the API so that end users can know
when they are treating with those special cases. As far as I remember
the only special cases are NaN, NRes, +INIFINITY, - INFINITY and RFU.
Do you see anything else?

Waiting for comments

Regards.
