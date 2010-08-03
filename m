Return-Path: <cyrus@holtmann.org>
Subject: RE: Enhancements to allow l2cap channel to use either AMP or BR/EDR
From: Marcel Holtmann <marcel@holtmann.org>
To: Kevin Hayes <kevin@Atheros.com>
Cc: "tmonahan@codeaurora.org" <tmonahan@codeaurora.org>,
	David Vrabel <david.vrabel@csr.com>,
	Inga Stotland <ingas@codeaurora.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"rshaffer@codeaurora.org" <rshaffer@codeaurora.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
In-Reply-To: <B7132A25476D334D9130FE7532F2A56310A0B08A61@SC1EXMB-MBCL.global.atheros.com>
References: <8bfb018fa669b6ace6840881379a1a01.squirrel@www.codeaurora.org>
	 <1280775200.12579.30.camel@localhost.localdomain>
	 <B7132A25476D334D9130FE7532F2A56310A0B0896E@SC1EXMB-MBCL.global.atheros.com>
	 <1280789882.12579.66.camel@localhost.localdomain>
	 <B7132A25476D334D9130FE7532F2A56310A0B08A61@SC1EXMB-MBCL.global.atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 18:59:04 -0700
Message-ID: <1280800744.12579.71.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kevin,

> > > Agree that it should be done "in background" and that a size
> > threshold would be useful.  But who evaluates that threshold?  The
> > bluez kernel components, which essentially implement a transport
> > driver, should not be examining objects (files, phonebooks, etc) size
> > to see if this threshold is met.  Therefore, it would seem Tim's
> > suggestion of having the profile send a 'prefer_amp' bit would be
> > useful, right?
> > 
> > I would do something like "prefer_amp when over 100kb" or something.
> > And
> > then the kernel needs to count. Meaning the L2CAP layer could easily
> > count this by itself.
> 
> What?  Let's say the effect we want is that if the object is greater than, say, 10 megabytes, then we want to use AMP for the transfer.  With your scheme, you want the kernel to count up to 10 megabytes, THEN switch over to AMP?
> No, you don't, he says rhetorically.  :)  

we will see what works out best. I am open for ideas. As I said before,
I know what I don't want for sure. The rest is open for testing and
figuring out if it works or not.

> > Also just starting with setsockopt(bredr_only) and then later on just
> > doing setsockopt(prefer_amp) the userspace application would have
> > control over switching manually.
> 
> How is this really different from your ioctl(switch_now_to_amp) below, which looks very wrong?

The difference is that you change a policy. setsockopt(prefer_amp)
doesn't mean you get switched. It just says that you prefer using an AMP
at this point.

Most application that expect a lot of data would always set the policy
to prefer AMP and if we have the PAL availability then it will switch
right away to AMP.

However with OBEX it might be that you wanna read the first package
first with BR/EDR only and only after knowing the file size make a
decision to prefer AMP or not.

We will see what works out best.

Regards

Marcel


