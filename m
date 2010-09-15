Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimm++uSFQmkKHF+vHzp=Kc0tYpzb+xqq=eG6jnW@mail.gmail.com>
References: <1284537527-22783-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <20100915081047.GA15065@jh-x301> <AANLkTimm++uSFQmkKHF+vHzp=Kc0tYpzb+xqq=eG6jnW@mail.gmail.com>
From: jaikumar Ganesh <jaikumarg@gmail.com>
Date: Wed, 15 Sep 2010 10:13:06 -0700
Message-ID: <AANLkTikryj2AeaCWpVKQhkMznfAF-d15QpJF6=BgyGsY@mail.gmail.com>
Subject: Re: [RFC] D-Bus API for out of band association model
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 15, 2010 at 6:30 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> On Wed, Sep 15, 2010 at 5:10 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Andrzej,
>>
>> On Wed, Sep 15, 2010, Andrzej Kaczmarek wrote:
>>> On behalf of ST-Ericsson SA, below is our proposal of API for out of band
>>> association model. To give you a bit more overview how this will be integrated
>>> into BlueZ:
>>>
>>> .RequestRemoteOobData should be called from hcid_dbus_request_io_cap to
>>> check if any data was exchange/retrieved from remote device. Returned data
>>> will be stored (if any) and used to reply with proper IO capabilities as well
>>> as to to return retrieved data. This will involve some changes in flow from
>>> io_capa_request onwards.
>>>
>>> Please let me know if you have any comments. Implementation will follow.
>>
>> I'd prefer to do this completely internally in bluetoothd through a
>> plugin. Do you see any reasons why not to do it that way? We still need
>> some UI to call CreatePairedDevice but a plugin that knows about local
>> platform specific OOB mechanisms (e.g. NFC) could provide the core
>> daemon with enough info to set the IO capabilities correctly and provide
>> the necessary OOB values.
>>
>> Johan
>> --
>
> Hi Andrzej,
>
> I did some testing with OOB last year.
> See my branch git://git.infradead.org/users/cktakahasi/bluez.git
> oob-displayyesno
>
> About the API changes. MAYBE, Hash and Randomizer could be only
> adapter properties.
> For the remote Hash and Randomizer still not clear to me what is the
> best way to allow external apps to set those values, but in my opinion
> BlueZ should not know the OOB mechanism, only the capability is
> enough.


[Resending, because the mail to linux-bluetooth bounced. Sorry if some
folks got it twice]

We started to work on this API too last week. Not complete yet to post
to the mailing list.
The approach we took was this:

 a) Since OOB authentication is just another means of authentication
compared to Passkey, Pin entry,
      we added an agent API (similar to the lines of other
authentication mechanisms) that will ask for the Out Of Band data.
b) We added an API to the adapter to get the local Out of Band Data
c) Currently, RegisterAgent is called to register with the
capabilities. Since OOB is part of the capabilities data structure, we
added OOB to agent structure which already has the capabilities.
d) We added an API variant of createPairedDevice which will be used
for OutOfBand Pairing. When the device agent is created, the OOB field
    in agent is updated.
e) When a capability request comes from the remote side the agent OOB
field is checked. It will be set if the pairing is initiated locally
through d).
    For incoming pairing requests if the Agent has OOB field set but
there is no device specific agent, we need to make an Agent API call
asking if
    there is OOB data for this remote device.

We left it to the users of the API - regarding the OOB channel to use.
It can be NFC or any other trusted channel.

Comments ?

Regards,
Jaikumar
>
> Regards,
> Claudio
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
