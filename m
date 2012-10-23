Return-Path: <cyrus@holtmann.org>
Message-ID: <1351028768.1785.57.camel@aeonflux>
Subject: Re: [PATCH 2/7] Bluetooth: mgmt: Restrict BR/EDR settings to
 BR/EDR-only adapters
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 23 Oct 2012 14:46:08 -0700
In-Reply-To: <20121023204809.GB12042@x220.ger.corp.intel.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	 <1351011241-32515-3-git-send-email-johan.hedberg@gmail.com>
	 <1351018956.1785.45.camel@aeonflux>
	 <CAJdJm_OLBgRVBFLD4sEp+OK-qkF_-CXXzuZOCAyiaD+TVMOYKQ@mail.gmail.com>
	 <20121023204809.GB12042@x220.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > Johan: do you have further plans on improving LE peripheral support
> > after these patches? If yes, please keep in mind that we still have
> > ongoing plans to push broadcaster/observer roles upstream, which also
> > requires hability to enable/disable advertising and set advertising
> > data/parameters.
> 
> Looking through the various "shall" and "shall not" clauses in the core
> spec it seems to me that only Central, Observer and Broadcaster roles
> are compatible with each other, and Peripheral is mutually exclusive
> with anything else. E.g. section 9.2.4.2 (page 1700):
> 
> "While a device is in the Broadcaster, Observer or Central role the
> device shall not support the general discoverable mode."
> 
> and section 9.3.4.2 (page 1709):
> 
> "While a device is in the Broadcaster, Observer, or the Central role
> the device shall not support the undirected connectable mode."
> 
> Both general discoverable and undirected connectable are needed by
> Peripheral role, i.e. essentially excluding the other roles.
> 
> Extending the other roles could indeed be a matter of interpreting the
> mgmt_set_le parameter as a bit mask and then returning an error if an
> incompatible combination of roles is attempted. Also, once support for
> new roles is added it should be easy to extend the current state checks
> to make a distinction on exactly what kind of scanning/advertising is
> done instead of just looking at "advertising or not" on a general level.

the way I see this now (which might change), we are doing LE on/off. And
by default this means actually central. For us it is a good assumption
that we are central if LE is enabled. And this means if the LE flag is
set, then we are a central. As it has been so far. In case we want to
switch this to peripheral, then we have to set PERIPHERAL flag. The LE
flag stays on to indicate LE is enabled. !PERIPHERAL flag here means we
are central.

That is why I like the explanation above, if we set ourselves as
peripheral, then we are peripheral and everything else is out of the
question. So either LE is enabled and we act as central or we are acting
as peripheral.

So broadcaster and observer are extra features on top of central. For me
that means we have treat them independent. How much you can be
broadcaster and observer and central at the same time is then again a
different question that we need to answer.

Regards

Marcel


