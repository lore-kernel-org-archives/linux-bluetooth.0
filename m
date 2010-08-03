Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Tue, 3 Aug 2010 05:07:19 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: Kevin Hayes <kevin@Atheros.com>, Marcel Holtmann <marcel@holtmann.org>,
	"tmonahan@codeaurora.org" <tmonahan@codeaurora.org>,
	David Vrabel <david.vrabel@csr.com>,
	Inga Stotland <ingas@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"rshaffer@codeaurora.org" <rshaffer@codeaurora.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: Enhancements to allow l2cap channel to use either AMP or BR/EDR
Message-ID: <20100803080719.GD20149@vigoh>
References: <8bfb018fa669b6ace6840881379a1a01.squirrel@www.codeaurora.org>
 <1280775200.12579.30.camel@localhost.localdomain>
 <B7132A25476D334D9130FE7532F2A56310A0B0896E@SC1EXMB-MBCL.global.atheros.com>
 <1280789882.12579.66.camel@localhost.localdomain>
 <B7132A25476D334D9130FE7532F2A56310A0B08A61@SC1EXMB-MBCL.global.atheros.com>
 <3e0b0d621e7c3dcee98b2a16c6e1f23b.squirrel@www.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3e0b0d621e7c3dcee98b2a16c6e1f23b.squirrel@www.codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

* Peter Krystad <pkrystad@codeaurora.org> [2010-08-02 18:30:34 -0700]:

> 
> Hi Marcel and Kevin,
> 
> >> >
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

In both cases we have to take in account the total size of the file, or
the estimated time of transfer, so we can avoid to move to AMP when the
transfer is about to end.

-- 
Gustavo F. Padovan
http://padovan.org
