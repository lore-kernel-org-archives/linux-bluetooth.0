Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Health Thermometer Profile API
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Elvis Pfutzenreuter <epx@signove.com>
In-Reply-To: <BANLkTikyqm9ysgT47XQvr_vYQL1vdGPBuA@mail.gmail.com>
Date: Wed, 22 Jun 2011 10:50:25 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7B7AE0E9-F6A0-4EBD-9FEA-44DD9C7996D0@signove.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com> <C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com> <BANLkTikNQac7UsMgKdnoVR7kVQSV6tVn6g@mail.gmail.com> <A2B092BC-BE3C-4C0A-917D-0253EF23943A@signove.com> <BANLkTik9muPgh_Xx3UTh7rEpzj-C7fVxuQ@mail.gmail.com> <544C7016-5346-4C99-AEA9-C91AA84E3A42@signove.com> <BANLkTikyqm9ysgT47XQvr_vYQL1vdGPBuA@mail.gmail.com>
To: Santiago Carot <sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>>> (cut)
>> 
>> True, I did not remember that those were properties. They would have
>> to go, otherwise it is too easy for an app to "break" another, by
>> disabling notifications.
>> 
>> A pair of Enable/DisableIntermediate methods taking an agent as
>> parameter would be more adequate.
>> 
>> IMHO there would not be a need of such
>> methods for final measure, because the final measurement (which is
>> the only one guaranteed to be precise) is the final objective, there
>> is no point in registering an agent and not wanting a final measurement.
>> 
> 
> They werent in this RFC. I only see a problem now, for example if an
> agent wants to get only a single *final* measure without setting an
> interval and after a while the same agents decides that it wants to
> get a new single measure without setting an interval for periodic
> measurements. I don't see how it could do this with current API (where
> get final measure methods are not present).

For that, having temperature as one of the properties would be great
(allowing apps unable/unwilling to set up an agent to read it).

Or setting a convention that, if you register an agent, a GATT read is
fired and you get a measurement right after. (It seems that you said
something in that direction below.) Disvantage is that registering
and unregistering agents just to get 1 measurement would cycle 
GATT indications needlessly.

> We could think that an agent is only registered during the time it is
> interested in being notified about final measures, after that, it
> should unregister itself from the service. In that scenario we can set
> notify property for final measures each time an agent is registered
> (if not periodic interval is already set).

In terms of minimizing energy consumption and API methods, the 'best'
would be:

a) intermediate and final temperatures being properties (intermediate
   property is there only if thermometer supports it).

b) There are GATT reads on them when some app reads the property;

c) those properties generate PropertyChanged signals only when
notifications are enabled for one or another, or there was a GATT read;

d) applications signal interest in notifications by registering
an agent (or by some other way). Registering an agent automatically
means interest in final temp notifications, an additional method
enables/disables interest in intermediate temp notifications.

Main problem would be having a "toothless" agent. Looks funny.
