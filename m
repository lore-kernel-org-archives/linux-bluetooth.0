Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 2/2] Emit Adapter.PropertyChanged when UUIDs change
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20100329225643.GA5460@jh-x301>
References: <1269644076-10544-1-git-send-email-francisco.alecrim@openbossa.org>
	 <1269644076-10544-2-git-send-email-francisco.alecrim@openbossa.org>
	 <20100329074539.GA20839@jh-x301>
	 <1269851341.11714.203.camel@localhost.localdomain>
	 <2d5a2c101003291148u1836742w1222097fb865ef61@mail.gmail.com>
	 <20100329215239.GA3748@jh-x301> <4BB125E8.1090200@openbossa.org>
	 <20100329225643.GA5460@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Mar 2010 18:21:10 -0700
Message-ID: <1269912070.11714.222.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > >> IMO, it should be the same list as we export in extended inquiry
> > >> response, so perhaps we could use the data from
> > >> create_ext_inquiry_response which already filter those away. Perhaps
> > >> some refactoring could also be done since this code seems to be called
> > >> multiple times in case of new services because it also changes class
> > >> which then triggers create_ext_inquiry_response again.
> > 
> > I'm not so sure about it but create_ext_inquiry_response list all
> > services to any adapters. Shouldn't it list just services per
> > adapter(access_db)?
> 
> It should be per-adapter (or records registered to BDADDR_ANY) since EIR
> is also per-adapter, so looks like a possible bug in the current
> implementation.
> 
> Btw, another restriction to note with the current EIR UUID list
> implementation is that it only supports 16-bit UUIDs. The EIR format
> itself would support also 32 and 128 bit formats but probably for
> simplicity these have been left out. The Adapter UUIDs list should
> however contain all UUIDs (with the exceptions that we already
> discussed).

it should also contain the UUID-128 ones (the UUID-32 are pointless and
with LE they are gone for good). The reason why these were left out is
because it is pretty hard to fit them into the limited space of EIR. If
you are up for fixing this, then I am more than happy to have this. I
think we need to introduce some priority mapping here to decide which
UUID list to cut in favor of others. Same as how we can shortcut the
device name etc.

So in general the DID information and at least a short device name
should be present. For the short name, we might need another config file
option or some plugin way of retrieving the short name. Also I want to
have the TX power information available if the chip supports it.

The rest of the space can be used for UUIDs in whatever way fits. The
more UUIDs are in the list the better actually.

Regards

Marcel


