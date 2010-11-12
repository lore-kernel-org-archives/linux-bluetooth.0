Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101112182921.GA15584@jh-x301>
References: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
 <1288865461-3760-4-git-send-email-szymon.janc@tieto.com> <AANLkTikZrbVTCDB2HRtqRJjUjYP3Z5PBieOovZZgP9id@mail.gmail.com>
 <20101112182921.GA15584@jh-x301>
From: jaikumar Ganesh <jaikumarg@gmail.com>
Date: Fri, 12 Nov 2010 11:07:06 -0800
Message-ID: <AANLkTikFAc43uU-976tRSFrntFHYApe9h9zzVHto22_6@mail.gmail.com>
Subject: Re: [PATCH 3/4] Add DBus OOB API documentation.
To: jaikumar Ganesh <jaikumarg@gmail.com>,
	Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon:

On Fri, Nov 12, 2010 at 10:29 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jaikumar,
>
> On Fri, Nov 12, 2010, jaikumar Ganesh wrote:
>> > +               void Deactivate()
>>
>> Would it better to make this a signal ? Deactivate by itself as the
>> only method doesn't seem to be right.
>
> I guess this is analogous to the Release() method which we have for
> agents, so in that sense a method call would be consistent with the rest
> of the BlueZ D-Bus API (but you'd really need to rename this to Release
> then).
>
> Johan
>

So the only APIs added are these provider ones and one API in Agent
code for approval.

So how does bluetoothd decide whether OOB is present for a particular
remote device for an outgoing pairing case ? Just on the basis of
whether a provider is registered or am I missing something here.

RequestRemoteOobData is called before initiating pairing or when the
remote end asks for the OOB data ?
Its unclear from the API description.

Thanks
Jaikumar
