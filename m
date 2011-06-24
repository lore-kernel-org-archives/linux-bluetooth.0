Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <544C7016-5346-4C99-AEA9-C91AA84E3A42@signove.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com>
	<C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com>
	<BANLkTikNQac7UsMgKdnoVR7kVQSV6tVn6g@mail.gmail.com>
	<A2B092BC-BE3C-4C0A-917D-0253EF23943A@signove.com>
	<BANLkTik9muPgh_Xx3UTh7rEpzj-C7fVxuQ@mail.gmail.com>
	<544C7016-5346-4C99-AEA9-C91AA84E3A42@signove.com>
Date: Fri, 24 Jun 2011 12:06:31 +0200
Message-ID: <BANLkTim60FHUp0B+2LkrsEG9vW4awFvvwQ@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: Santiago Carot <sancane@gmail.com>
To: Elvis Pfutzenreuter <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

(cut)

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

Coming back to this issue. I was just wondering that we may not need
worried about this issue because the same case may occurs at GATT
level. I mean, an application using GATT could disturb the behaviour
of other one when it enables/disables characteristics.

Because of any application can enable/disable characteristics we don't
need to worry about to manage this in the Thermometer API. Remember
that in other threads in the mailing list people were speaking about
making a D-Bus API for GATT. Those applications using GATT could
enable notification for measures and disable it. On account of this,
it will be inevitable collisions in the use cases.

For this reason I think that the Thermometer API should be the most
permissive possible. If any application disable intermediate or final
measures, the PropertyChanged signal will be triggered, well, there is
no problem, if there are agents interested in such measures they only
will have to enable the proterty in the API once again as usual.

To summarize, I think we should add the properties to enable and
disable intermediate and final measures and to leave to applications
to take deccisions about how they are going to behave when this stuff
happen.

Waiting for you comments before sending a new RFC.

Regards.
