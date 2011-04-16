Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110416070006.GA10860@jh-x301>
References: <1302892422-32206-1-git-send-email-claudio.takahasi@openbossa.org>
	<20110415184728.GA2359@joana>
	<1302915790.2503.31.camel@aeonflux>
	<20110416070006.GA10860@jh-x301>
Date: Sat, 16 Apr 2011 17:04:50 +0000
Message-ID: <BANLkTi=QNU7MS80fKfsAvRRKAX+80hmQtA@mail.gmail.com>
Subject: Re: [RFC] Proposal to distinguish address device types
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 16, 2011 at 7:00 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Marcel,
>
> On Fri, Apr 15, 2011, Marcel Holtmann wrote:
>> > > + BDADDR_TYPE_LE_PUBLIC,
>> > > + BRADDR_TYPE_LE_RANDOM
>> > > +};
>>
>> I am also not sure the we should have this BR/EDR differentiation since
>> the specification only talks about public and random addresses. And we
>> should follow the specification type value here. I am against
>> introducing our enum here.
>
> The HCI specification only has values for public and random because
> everywhere they are used it is already clear from the context (the HCI
> command or event in question) if we're talking about LE or BR/EDR. We on
> the other hand don't have this contextual information with the
> mgmt_pair_device command. Saying "public" there could mean both BR/EDR
> public or LE public, i.e. an enum with just two possible values is not
> going to be of much use to us. Because of this difference between our
> API and that of HCI I don't think it's fair to apply the HCI
> convention/restriction to us.
>
> Johan
>

I added 3 values because it gives more flexibility. Possible use cases:
- Whitelist needs the address type
- SMP
- As input to decide to store or not information about the device
since private address can change every 15minutes

 At the moment we only need to know if the address is basic rate or LE
to select the discovery type: SDP or LE Discovery primary. For
pairing, Vinicius is using the kernel advertising cache to discover
the address type, passing the address type could avoid wrong fallback
to basic rate if the entry is not found in the cache.

Claudio
