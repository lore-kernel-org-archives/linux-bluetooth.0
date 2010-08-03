Return-Path: <cyrus@holtmann.org>
Subject: RE: Enhancements to allow l2cap channel to use either AMP or BR/EDR
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: Kevin Hayes <kevin@Atheros.com>,
	"tmonahan@codeaurora.org" <tmonahan@codeaurora.org>,
	David Vrabel <david.vrabel@csr.com>,
	Inga Stotland <ingas@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"rshaffer@codeaurora.org" <rshaffer@codeaurora.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
In-Reply-To: <3e0b0d621e7c3dcee98b2a16c6e1f23b.squirrel@www.codeaurora.org>
References: <8bfb018fa669b6ace6840881379a1a01.squirrel@www.codeaurora.org>
	 <1280775200.12579.30.camel@localhost.localdomain>
	 <B7132A25476D334D9130FE7532F2A56310A0B0896E@SC1EXMB-MBCL.global.atheros.com>
	 <1280789882.12579.66.camel@localhost.localdomain>
	 <B7132A25476D334D9130FE7532F2A56310A0B08A61@SC1EXMB-MBCL.global.atheros.com>
	 <3e0b0d621e7c3dcee98b2a16c6e1f23b.squirrel@www.codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 18:59:54 -0700
Message-ID: <1280800794.12579.72.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> >> > Agree that it should be done "in background" and that a size
> >> threshold would be useful.  But who evaluates that threshold?  The
> >> bluez kernel components, which essentially implement a transport
> >> driver, should not be examining objects (files, phonebooks, etc) size
> >> to see if this threshold is met.  Therefore, it would seem Tim's
> >> suggestion of having the profile send a 'prefer_amp' bit would be
> >> useful, right?
> >>
> >> I would do something like "prefer_amp when over 100kb" or something.
> >> And
> >> then the kernel needs to count. Meaning the L2CAP layer could easily
> >> count this by itself.
> >
> > What?  Let's say the effect we want is that if the object is greater than,
> > say, 10 megabytes, then we want to use AMP for the transfer.  With your
> > scheme, you want the kernel to count up to 10 megabytes, THEN switch over
> > to AMP?
> > No, you don't, he says rhetorically.  :)
> 
> If the policy was defined as "prefer_amp after n seconds" we would get the
> desired effect without having to do any counting in the kernel.

that would work as well. We will see what works out best by giving
application the least amount of hassle :)

Regards

Marcel


