Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100915081047.GA15065@jh-x301>
References: <1284537527-22783-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<20100915081047.GA15065@jh-x301>
Date: Wed, 15 Sep 2010 10:30:35 -0300
Message-ID: <AANLkTimm++uSFQmkKHF+vHzp=Kc0tYpzb+xqq=eG6jnW@mail.gmail.com>
Subject: Re: [RFC] D-Bus API for out of band association model
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Sep 15, 2010 at 5:10 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andrzej,
>
> On Wed, Sep 15, 2010, Andrzej Kaczmarek wrote:
>> On behalf of ST-Ericsson SA, below is our proposal of API for out of band
>> association model. To give you a bit more overview how this will be integrated
>> into BlueZ:
>>
>> .RequestRemoteOobData should be called from hcid_dbus_request_io_cap to
>> check if any data was exchange/retrieved from remote device. Returned data
>> will be stored (if any) and used to reply with proper IO capabilities as well
>> as to to return retrieved data. This will involve some changes in flow from
>> io_capa_request onwards.
>>
>> Please let me know if you have any comments. Implementation will follow.
>
> I'd prefer to do this completely internally in bluetoothd through a
> plugin. Do you see any reasons why not to do it that way? We still need
> some UI to call CreatePairedDevice but a plugin that knows about local
> platform specific OOB mechanisms (e.g. NFC) could provide the core
> daemon with enough info to set the IO capabilities correctly and provide
> the necessary OOB values.
>
> Johan
> --

Hi Andrzej,

I did some testing with OOB last year.
See my branch git://git.infradead.org/users/cktakahasi/bluez.git
oob-displayyesno

About the API changes. MAYBE, Hash and Randomizer could be only
adapter properties.
For the remote Hash and Randomizer still not clear to me what is the
best way to allow external apps to set those values, but in my opinion
BlueZ should not know the OOB mechanism, only the capability is
enough.

Regards,
Claudio
