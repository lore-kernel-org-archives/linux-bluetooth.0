Return-Path: <cyrus@holtmann.org>
Message-ID: <4DF9E9FA.7050403@tieto.com>
Date: Thu, 16 Jun 2011 13:33:14 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>, "ulrik.lauren@stericsson.com"
	<ulrik.lauren@stericsson.com>
Subject: Re: [PATCH 0/4] Add support for custom (e)SCO parameters
References: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>	 <1308136088.2518.3.camel@aeonflux> <4DF8B976.3060804@tieto.com> <1308147904.2196.5.camel@aeonflux>
In-Reply-To: <1308147904.2196.5.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 15.06.2011 16:25, Marcel Holtmann wrote:
> Hi Andrzej,
>
>>>> Following patches add possibility to specify custom parameters for
>>>> outgoing (e)SCO link. This is implemented as SCO socket options.
>>>>
>>>> This change allows to use reference parameters as defined in HFP 1.5
>>>> specification as well as support for future enchancements as wideband
>>>> speech as defined in HFP 1.6 draft (uses different air coding format).
>>>>
>>>> Additional socket option (patch 3) allows to disable automatic retry
>>>> in case of failure which fallbacks from eSCO to SCO connection in
>>>> current implementation. Such fallback should not happen when using
>>>> wideband speech which mandates using of eSCO transport.
>>>
>>> I am not a big fan of just stupidly exposing all possible HCI value to
>>> userspace and let userspace set them. Especially since in the end there
>>> are no real variation here anyway. There are just a 2-3 use cases for
>>> your SCO socket.
>>
>> There's L2CAP_OPTIONS sockopt which allows to do pretty much the same
>> for L2CAP sockets so I just followed it.
>>
>> What do you mean by just 2-3 use cases for SCO socket? You consider only
>> HFP as use case for SCO socket? I saw devices which use eSCO to stream
>> music to mono headsets which do not support A2DP, this may require
>> custom requirements which we cannot predict. This is only one example,
>> but user can "invent" something else.
>>
>>> I would rather have simple mode to hand to the kernel and let it do the
>>> right thing (including negotiation and downgrading to SCO) than having
>>> userspace opening sockets over sockets again.
>>
>> By making such change you actually incorporate part of profiles into
>> kernel. I don't think this is good idea. My understanding is that
>> profiles should be in user-space.
>>
>> And I don't recall any other profile than HFP that uses eSCO, so if
>> we're going to implement "modes" using this spec, user won't have many
>> options to choose from. See example above (music over eSCO).
>>
>>> So what are the actual modes for HFP that need to be supported and what
>>> is the range of possible SCO and eSCO options?
>>
>> At the moment only HFP 1.5 defines reference parameters for eSCO link.
>> In HFP 1.6 draft there are additional reference parameters for CVSD over
>> SCO and mSBC over eSCO. And in future profiles you never know what BT
>> SIG will invent :)
>
> personally I would just go for PCM, CVSD and mSBC modes here actually.

..and any other codec which can some soon? I'm simply not convinced that 
kernel should expose something defined in profiles which are 
application-level specs.

And what do you mean by PCM? Which spec uses eSCO to transport raw PCM data?

> And you can not compare L2CAP with SCO since they are different. And
> also L2CAP does not expose everything that the spec. would offer.

Sure, they are different. But this does not explain why L2CAP should 
expose low-level interface and SCO should not do the same but provide 
very high-level interface only.

In case of L2CAP was it decision not to expose some parameters for some 
reason other than "nobody uses them anyway"? For eSCO we could skip 
bandwidth parameter as I never seen anything other than 8000 rx/tx, but 
I can still imagine someone can use different value.

Actually, from what I see almost all L2CAP parameters supported by BlueZ 
are exposed.

> My real question is how you expose negotiation capabilities. Since
> re-creating the socket and its connection attempt is not going to work
> out. That concept will fail and will also break qualification testing.

Why do you think re-creating the socket is not going to work? How it is 
different than second attempt to connect SCO when eSCO failed, which is 
now handled inside kernel? The same could be done by user-space but in 
more sophisticated way which suits specific requirements. And this is 
how negotiation is solved.

And what qualification testing will it break?


Could you please elaborate a little bit more on the above questions so I 
can understand your point of view better.

BR,
Andrzej
