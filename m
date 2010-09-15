Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100915185340.GA2804@jh-x301>
References: <1284537527-22783-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <20100915081047.GA15065@jh-x301> <AANLkTimm++uSFQmkKHF+vHzp=Kc0tYpzb+xqq=eG6jnW@mail.gmail.com>
 <AANLkTikryj2AeaCWpVKQhkMznfAF-d15QpJF6=BgyGsY@mail.gmail.com> <20100915185340.GA2804@jh-x301>
From: jaikumar Ganesh <jaikumarg@gmail.com>
Date: Wed, 15 Sep 2010 12:13:01 -0700
Message-ID: <AANLkTik7mTPK4DurfowHEggyrxEzGKuip203m3NqYdCN@mail.gmail.com>
Subject: Re: [RFC] D-Bus API for out of band association model
To: jaikumar Ganesh <jaikumarg@gmail.com>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Wed, Sep 15, 2010 at 11:53 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jaikumar,
>
> On Wed, Sep 15, 2010, jaikumar Ganesh wrote:
>> We started to work on this API too last week. Not complete yet to post
>> to the mailing list.
>> The approach we took was this:
>>
>>  a) Since OOB authentication is just another means of authentication
>> compared to Passkey, Pin entry,
>>       we added an agent API (similar to the lines of other
>> authentication mechanisms) that will ask for the Out Of Band data.
>> b) We added an API to the adapter to get the local Out of Band Data
>> c) Currently, RegisterAgent is called to register with the
>> capabilities. Since OOB is part of the capabilities data structure, we
>> added OOB to agent structure which already has the capabilities.
>> d) We added an API variant of createPairedDevice which will be used
>> for OutOfBand Pairing. When the device agent is created, the OOB field
>>     in agent is updated.
>> e) When a capability request comes from the remote side the agent OOB
>> field is checked. It will be set if the pairing is initiated locally
>> through d).
>>     For incoming pairing requests if the Agent has OOB field set but
>> there is no device specific agent, we need to make an Agent API call
>> asking if
>>     there is OOB data for this remote device.
>>
>> We left it to the users of the API - regarding the OOB channel to use.
>> It can be NFC or any other trusted channel.
>>
>> Comments ?
>
> I'm still not convinced that the Agent is the right place for this. The
> agent is typically representing the UI whereas in most cases (like NFC)
> the OOB data will be coming from below bluetoothd in the software stack
> and not from above it (which is where the agent resides). Also, the
> presence of OOB data isn't really agent specific. It's something that
> can come and go during the lifetime of an agent.

Consider a case where there is a third party app residing on the device.
This wants to initiate pairing and has OOB data. (here OOB data comes
from above bluetoothd)

When the remote request OOB data comes, bluetoothd asks the app for
the OOB data.

Depending on the implementation either the app can show a UI to the user
asking permission to pair when the OOB data Agent API is called. This is again
similar to what we have for the passkey mechanism.

This need of the UI and the fact that OOB data can come from above
bluetoothd (similar to pin entry)
is what made us go with the agent approach.

The device agent is removed when the device is unpaired. So next time
when pairing
happens depending upon the API used we can again have OOB pairing or
non OOB pairing.

Yes OOB data can come and go during the life of an agent. Hence we put
this burden on the users
of bluetoothd to supply bluetoothd if the OOB data. We not storing any
OOB data of the remote device
in bluetoothd


> My idea has been to add a a plugin interface through which a hardware
> specific plugin could notify the core daemon about the existence of OOB
> data. bluetoothd would then take care of setting the right flag when it
> gets a IO capability request. This doesn't of course rule out the
> possibility of having part of the work done in another process since the
> plugin could simply export a service over D-Bus or talk to another D-Bus
> service.

If I understand correctly, hardware specific plugin works well for
things like NFC.

What about cases where the trusted channel is say something like an
app running on
both the computer and the device. That channel is trusted using some
other authentication mechanism
The apps communicate to exchange OOB data.

For example, you can use the browser to device messaging mechanism
(Cloud to device messaging using Chrome).

>
> Johan
>
