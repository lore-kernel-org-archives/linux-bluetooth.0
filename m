Return-Path: <cyrus@holtmann.org>
Message-ID: <4E0B2B84.1010905@tieto.com>
Date: Wed, 29 Jun 2011 15:41:24 +0200
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>, "ulrik.lauren@stericsson.com"
	<ulrik.lauren@stericsson.com>
Subject: Re: [PATCH 0/4] Add support for custom (e)SCO parameters
References: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>		 <1308136088.2518.3.camel@aeonflux> <4DF8B976.3060804@tieto.com>	 <1308147904.2196.5.camel@aeonflux> <4DF9E9FA.7050403@tieto.com> <1308235296.2196.17.camel@aeonflux>
In-Reply-To: <1308235296.2196.17.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 16.06.2011 16:41, Marcel Holtmann wrote:
>>>>> So what are the actual modes for HFP that need to be supported and what
>>>>> is the range of possible SCO and eSCO options?
>>>>
>>>> At the moment only HFP 1.5 defines reference parameters for eSCO link.
>>>> In HFP 1.6 draft there are additional reference parameters for CVSD over
>>>> SCO and mSBC over eSCO. And in future profiles you never know what BT
>>>> SIG will invent :)
>>>
>>> personally I would just go for PCM, CVSD and mSBC modes here actually.
>>
>> ..and any other codec which can some soon? I'm simply not convinced that
>> kernel should expose something defined in profiles which are
>> application-level specs.
>>
>> And what do you mean by PCM? Which spec uses eSCO to transport raw PCM data?
>
> the encoded data you are actually sending over the SCO socket. Or are
> you telling me that for mSBC we have PCM input to the chip, and the chip
> does mSBC then.

Yes, there are chips which have codecs embedded and can fill payload 
using data supplied over e.g. PCM input (and this applies not only to 
mSBC but also to CVSD). But what difference does it make here?

As I understand what you send over SCO socket depends (mostly) on what 
air coding format is used on link. For CVSD you send PCM data as I know 
(but PCM is input here so not sure why it should be included as mode). 
For transparent data it depends on application, in particular for HFP 
1.6 it depends on which codec was negotiated.

Looking through profiles you can actually have CVSD mode (let's say for 
"any" eSCO) and mSBC mode (for mSCB negotiated as per HFP 1.6).
But the question remains: what if application wants to send voice data 
(or just data) outside HFP spec? It's limited only to what BT SIG 
"invented"...

>>> My real question is how you expose negotiation capabilities. Since
>>> re-creating the socket and its connection attempt is not going to work
>>> out. That concept will fail and will also break qualification testing.
>>
>> Why do you think re-creating the socket is not going to work? How it is
>> different than second attempt to connect SCO when eSCO failed, which is
>> now handled inside kernel? The same could be done by user-space but in
>> more sophisticated way which suits specific requirements. And this is
>> how negotiation is solved.
>
> Because it actually is a timing issue and once a SCO socket gets closed,
> the kernel will trigger various timers. I do not really like such an
> approach.

Ok, so does it mean it's incorrect to connect one SCO after closing 
another one because there's issue in kernel? If yes then perhaps it 
should be fixed. If not then I don't understand your argument.

And eSCO negotiation implemented in user-space works just fine for me.

> If we wanna expose minimum required settings, then I am actually fine
> with an SCO_OPTIONS socket option, but it needs to be better defined in
> how that is suppose to work. Since clearly for HFP 1.5, we do not care
> if it is a SCO or eSCO link in the end. So the kernel must be able to
> negotiate this.

That's the problem. BT core does not define how this should work, 
because there's no eSCO negotiation on HCI level. Link with given 
parameters can be either established or not. If not, you can try another 
one. And such rules for negotiation are in best case defined on 
application level in profiles.

So that's why I think it's reasonable that application can define 
parameters it requires. Otherwise you will need to integrate new modes 
into SCO socket in case new profile have new requirements (for me it's 
strange that new profile would require new kernel as long as nothing new 
was introduced in core spec) or in worst case hack kernel so your 
application can use new custom mode.

> I do not want to implement heavy negotiation logic into every single
> piece of code that wants a SCO/eSCO socket. In addition you have to
> figure out on how the acceptor side should work. BlueZ can play both
> roles of HFP. How do you deal with accepting SCO connections in either
> SCO/eSCO or mSBC mode?

You don't need to implement any logic at all, nothing changes if you 
just want to connect any (e)SCO. This is only for those who want to have 
more control of link that is going to be established.

Socket options affect outgoing connections only at the moment, 
connections are accepted using default parameters. Problem with incoming 
connection is that on kernel level you don't know what kind of 
connection remote side requires (connection request event can only tell 
type of link). For HFP 1.6 headset should be ready to accept specified 
connection after codec was selected and this seems to be the only way to 
determine whether we should accept using CVSD or transparent data. I 
think this can be implemented in a way similar to BT_DEFER_SETUP so 
application can accept link, determine remote device address and setup 
accordingly before continuing. But patches I sent do not include this, 
they are only for outgoing connection.

BR,
Andrzej
