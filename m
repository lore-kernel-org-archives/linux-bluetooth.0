Return-Path: <cyrus@holtmann.org>
Date: Sat, 16 Apr 2011 10:00:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Proposal to distinguish address device types
Message-ID: <20110416070006.GA10860@jh-x301>
References: <1302892422-32206-1-git-send-email-claudio.takahasi@openbossa.org>
 <20110415184728.GA2359@joana>
 <1302915790.2503.31.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302915790.2503.31.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Apr 15, 2011, Marcel Holtmann wrote:
> > > +	BDADDR_TYPE_LE_PUBLIC,
> > > +	BRADDR_TYPE_LE_RANDOM
> > > +};
> 
> I am also not sure the we should have this BR/EDR differentiation since
> the specification only talks about public and random addresses. And we
> should follow the specification type value here. I am against
> introducing our enum here.

The HCI specification only has values for public and random because
everywhere they are used it is already clear from the context (the HCI
command or event in question) if we're talking about LE or BR/EDR. We on
the other hand don't have this contextual information with the
mgmt_pair_device command. Saying "public" there could mean both BR/EDR
public or LE public, i.e. an enum with just two possible values is not
going to be of much use to us. Because of this difference between our
API and that of HCI I don't think it's fair to apply the HCI
convention/restriction to us.

Johan
