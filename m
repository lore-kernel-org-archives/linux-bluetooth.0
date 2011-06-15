Return-Path: <cyrus@holtmann.org>
Message-ID: <4DF8B976.3060804@tieto.com>
Date: Wed, 15 Jun 2011 15:53:58 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>, <ulrik.lauren@stericsson.com>
Subject: Re: [PATCH 0/4] Add support for custom (e)SCO parameters
References: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com> <1308136088.2518.3.camel@aeonflux>
In-Reply-To: <1308136088.2518.3.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 15.06.2011 13:08, Marcel Holtmann wrote:
> Hi Andrzej,
>
>> Following patches add possibility to specify custom parameters for
>> outgoing (e)SCO link. This is implemented as SCO socket options.
>>
>> This change allows to use reference parameters as defined in HFP 1.5
>> specification as well as support for future enchancements as wideband
>> speech as defined in HFP 1.6 draft (uses different air coding format).
>>
>> Additional socket option (patch 3) allows to disable automatic retry
>> in case of failure which fallbacks from eSCO to SCO connection in
>> current implementation. Such fallback should not happen when using
>> wideband speech which mandates using of eSCO transport.
>
> I am not a big fan of just stupidly exposing all possible HCI value to
> userspace and let userspace set them. Especially since in the end there
> are no real variation here anyway. There are just a 2-3 use cases for
> your SCO socket.

There's L2CAP_OPTIONS sockopt which allows to do pretty much the same 
for L2CAP sockets so I just followed it.

What do you mean by just 2-3 use cases for SCO socket? You consider only 
HFP as use case for SCO socket? I saw devices which use eSCO to stream 
music to mono headsets which do not support A2DP, this may require 
custom requirements which we cannot predict. This is only one example, 
but user can "invent" something else.

> I would rather have simple mode to hand to the kernel and let it do the
> right thing (including negotiation and downgrading to SCO) than having
> userspace opening sockets over sockets again.

By making such change you actually incorporate part of profiles into 
kernel. I don't think this is good idea. My understanding is that 
profiles should be in user-space.

And I don't recall any other profile than HFP that uses eSCO, so if 
we're going to implement "modes" using this spec, user won't have many 
options to choose from. See example above (music over eSCO).

> So what are the actual modes for HFP that need to be supported and what
> is the range of possible SCO and eSCO options?

At the moment only HFP 1.5 defines reference parameters for eSCO link.
In HFP 1.6 draft there are additional reference parameters for CVSD over 
SCO and mSBC over eSCO. And in future profiles you never know what BT 
SIG will invent :)

BR,
Andrzej
