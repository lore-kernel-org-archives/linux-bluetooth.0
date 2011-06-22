Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Health Thermometer Profile API
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Elvis Pfutzenreuter <epx@signove.com>
In-Reply-To: <BANLkTik9muPgh_Xx3UTh7rEpzj-C7fVxuQ@mail.gmail.com>
Date: Wed, 22 Jun 2011 09:46:07 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <544C7016-5346-4C99-AEA9-C91AA84E3A42@signove.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com> <C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com> <BANLkTikNQac7UsMgKdnoVR7kVQSV6tVn6g@mail.gmail.com> <A2B092BC-BE3C-4C0A-917D-0253EF23943A@signove.com> <BANLkTik9muPgh_Xx3UTh7rEpzj-C7fVxuQ@mail.gmail.com>
To: Santiago Carot <sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Jun 22, 2011, at 7:20 AM, Santiago Carot wrote:

> Hi,
> 
> 2011/6/21 Elvis Pfutzenreuter <epx@signove.com>:
>> On Jun 21, 2011, at 12:56 PM, Santiago Carot wrote:
>> 
>> (cut)
>> 
>>>> 
>>>> Another option would be to guarantee that MeasureReceived() is called
>>>> right after agent registering, in order to give the client an
>>>> initial value to show (having in mind that notification interval might
>>>> be very long).
>>> 
>>> I would prefer to use the Final and Intermediate properties too. The
>>> problem that we should address occurs when an application wich hasn't
>>> got a watcher registered sets Intermediate or Final measurement
>>> property and the last watcher is removed. I think that the best option
>>> may be turn off measurments for power safe due that no watcher will
>>> get the measures.
>> 
>> I'm not sure I follow. Enabling intermediate and/or final notifications
>> is done per-agent basis; if any of active agents needs intermediate
>> measurements, device is configured to send them. Disabling it on one
>> agent should not hurt another.
>> 
> 
> I mean the case when a process (it is not neccesary it has to be an
> agent) is enabling intermediate and/or final notifications through
> setProperty method in D-Bus API. Please, note that any process can do
> this in current API because no extra control is done for this
> operation.
> 
> May be I'm misundertanding what you want to said with per-agent basis
> but as far as I see the only way to manage enabling/disabling
> properties in this way is by adding a new parameter in setProperty
> method with the agent path and checkicng if it is already registered
> before enabling or disabling intermediate and final notifications. IMO
> If we do this we would break the BlueZ APIs where no extra parameters
> are required in such methods. I'm not sure if this would be a problem
> but I don't feel comfortable with this solution.
> 
> On the other hands, if we discard adding the agent parameter in that
> method (which I think that it fits better in BlueZ API), we can ignore
> the case when there aren't any agents registered for the thermometer
> service and a process enables some of this properties. In this case it
> wouldn't be necessary to activate these properties since no one will
> receive notifications for the measures.

True, I did not remember that those were properties. They would have
to go, otherwise it is too easy for an app to "break" another, by
disabling notifications.

A pair of Enable/DisableIntermediate methods taking an agent as
parameter would be more adequate.

IMHO there would not be a need of such
methods for final measure, because the final measurement (which is
the only one guaranteed to be precise) is the final objective, there
is no point in registering an agent and not wanting a final measurement.

So, inside the driver, final measurement indications are enabled if there
is at least one agent; and intermediate notifications are enabled if at
least one agent has requested it.

> 
>>> 
>>> We can change the API to do that. What do you think?
>>> 
>>> 
>>>> 
>>>>> +
>>>>> +
>>>>> +Health Thermometer Watcher hierarchy
>>>>> +====================================
>>>>> +Service              unique name
>>>>> +Interface    org.bluez.ThermometerWatcher
>>>>> +Object path  freely definable
>>>>> +
>>>>> +Methods              void MeasureReceived(dict measure)
>>>>> +
>>>>> +                     This callback gets called when a measure has been
>>>>> +                     scanned in the thermometer. The Value entry corresponds
>>>>> +                     to IEEE-11073 32-bit FLOAT.The Time entry in the dict
>>>>> +                     will be only present if the device supports storing of
>>>>> +                     data. The time value is expressed in seconds since epoch.
>>>> 
>>>> Using such a special type (FLOAT) looks funny. Not sure whether it is the best option
>>>> for this API.
>>>> 
>>>> At the very least, a description of FLOAT type should be added to the API, since
>>>> IEEE 11073 specs are not public/free, and API users would have to resort to unofficial
>>>> source to learn it.
>>>> 
>>>> I understand why you used this type (keeps the thermometer transcodable through this
>>>> API and there are the special values), so BTW the lack of device information service
>>>> access through this API should at least be mentioned, so we ammend that later (either
>>>> here or adding another API).
>>> 
>>> ...or we can split the value in their exponent and mantissa
>>> components. Any suggestion?
>> 
>> I'd go for that, but we need to take a look on special values to see if it makes sense.
>> It would be really ugly to say something like "if mantissa=5 and exponent=-3 then
>> temperature is actually zero" :)
> 
> We could provide special values in the API so that end users can know
> when they are treating with those special cases. As far as I remember
> the only special cases are NaN, NRes, +INIFINITY, - INFINITY and RFU.
> Do you see anything else?

I think that these are all. Can't see a way to represent those special
values in a clean fashion. For the next RFC just include the mantissa/exponent
pairs related to them, and see if someone else complains.