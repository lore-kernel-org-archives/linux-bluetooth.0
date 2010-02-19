Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4B7E46FC.5030408@nokia.com>
References: <1265918068-14721-1-git-send-email-npelly@google.com>
	<35c90d961002111159h6727bc2cw28b55ce6e919fb4f@mail.gmail.com>
	<35c90d961002151315i5fc0f5b9y36aaba4415987a2f@mail.gmail.com>
	<4B7BB746.1040806@nokia.com> <35c90d961002170849m1d13743fg725a87594d63b80c@mail.gmail.com>
	<1266427894.8849.66.camel@localhost.localdomain> <35c90d961002181547x1ea26ba7je4eee29ef29e6fd2@mail.gmail.com>
	<4B7E46FC.5030408@nokia.com>
From: Nick Pelly <npelly@google.com>
Date: Fri, 19 Feb 2010 13:23:29 -0800
Message-ID: <35c90d961002191323x50203ca1x8ed709b3f128e41d@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Allow SCO/eSCO packet type selection for
	outgoing SCO connections.
To: Ville Tervo <ville.tervo@nokia.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Feb 19, 2010 at 12:08 AM, Ville Tervo <ville.tervo@nokia.com> wrote:
> Hi Nick
>
>>> And even if we would be going for a setsockopt(), that would be blocking
>>> and then again pretty much pointless API. The sockaddr is most logical
>>> thing that fits into what we wanna achieve. Disallow/allow certain
>>> packet types and essentially force SCO over eSCO.
>>
>> Ok seems like there is agreement on using struct sockaddr_sco for
>> sco_pkt_type.
>>
>> A more controversial question is whether to follow the SIG convention
>> of reversing the logic on the EDR bits in the packet type mask (1
>> means do *not* use this packet for the EDR bits), or to use consistent
>> logic for each bit (1 always means *allow* this packet type) for
>> packet selection in scokaddr_sco.sco_pkt_type.
>>
>> The original patch I posted followed the SIG convention. However after
>> more thinking I am leaning towards using consistent logic for each
>> bit. 1 will always mean 'allow this packet'. My rationale is that the
>> most common use for sco_pkt_type will be to request only SCO packet
>> types allowed. If however the SIG adds more reverse logic packet
>> types, and we follow the SIG convention, then old userspace code that
>> just requested the SCO packet types will now end up with the new
>> packet types as well. So I think it is best to avoid this situation
>> and for 1 to always mean 'allow this packet' in
>> sockaddr_sco.sco_pkt_type.
>>
>> Attached is a new patch with the consistent bit logic.
>>
>> Comments?
>
> In order to keep backwards compatibility 1 should mean "don't allow this
> packet type" for all packets. Other wise old application with new kernel
> would not allow any packet types.

The current patch achieves this backwards compatibility by assuming
that all packet types are allowed if the old sockaddr_sco struct is
used (it checks the size), or if sco_pkt_type is 0.

Nick
