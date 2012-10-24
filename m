Return-Path: <cyrus@holtmann.org>
Message-ID: <1351091696.1785.67.camel@aeonflux>
Subject: Re: [PATCH 2/7] Bluetooth: mgmt: Restrict BR/EDR settings to
 BR/EDR-only adapters
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Wed, 24 Oct 2012 08:14:56 -0700
In-Reply-To: <CAJdJm_PgxH19t6b0XxmKCa=he8n9gsDro0eRPTV10x+RM9tHNA@mail.gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	 <1351011241-32515-3-git-send-email-johan.hedberg@gmail.com>
	 <1351018956.1785.45.camel@aeonflux>
	 <CAJdJm_OLBgRVBFLD4sEp+OK-qkF_-CXXzuZOCAyiaD+TVMOYKQ@mail.gmail.com>
	 <20121023204809.GB12042@x220.ger.corp.intel.com>
	 <1351028768.1785.57.camel@aeonflux>
	 <CAJdJm_PgxH19t6b0XxmKCa=he8n9gsDro0eRPTV10x+RM9tHNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> > That is why I like the explanation above, if we set ourselves as
> > peripheral, then we are peripheral and everything else is out of the
> > question. So either LE is enabled and we act as central or we are acting
> > as peripheral.
> >
> > So broadcaster and observer are extra features on top of central. For me
> > that means we have treat them independent. How much you can be
> > broadcaster and observer and central at the same time is then again a
> > different question that we need to answer.
> 
> So do you suggest we keep Broadcaster/Observer as separate settings
> (which actually we prefer, given that we have been working on
> supporting those modes for BR/EDR only adapters, by using EIR for
> broadcasting data allowed on EIR, such as Manufacturer Specific Data,
> and parsing them from Device Found mgmt event when on Observer mode),
> and keep "Set Low Energy" setting just for Central/Peripheral modes?

if we can stay in central role and do broadcaster/observer as an
additional feature, then yes. If they are mutually exclusive, we have to
find something else.

But with all of this, I do not have the final answer until we tried it
and had a couple of review rounds.

Regards

Marcel


