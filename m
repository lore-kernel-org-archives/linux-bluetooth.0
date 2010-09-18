Return-Path: <cyrus@holtmann.org>
Subject: RE: [RFC] BlueZ D-Bus Sim Access Profile Server API description
From: Marcel Holtmann <marcel@holtmann.org>
To: Nicolas GUILBAUD <nicolas.guilbaud.wj@rdf.renesas.com>
Cc: Suraj Sumangala <suraj@Atheros.com>,
	Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	linux-bluetooth@vger.kernel.org,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <A9AC1023FCA4654D92AC24C2A8F6A09201AA816C@renesas4bis.renesas-rdf.local>
References: <1284374584-12282-1-git-send-email-suraj@atheros.com>
	 <1284442946.2405.50.camel@localhost.localdomain>
	 <4C8F160B.4010401@Atheros.com>
	 <1284522264.2405.89.camel@localhost.localdomain>
	 <4C906430.90900@Atheros.com>
	 <A9AC1023FCA4654D92AC24C2A8F6A09201A2B923@renesas4bis.renesas-rdf.local>
	 <1284678016.2405.145.camel@localhost.localdomain>
	 <A9AC1023FCA4654D92AC24C2A8F6A09201AA816C@renesas4bis.renesas-rdf.local>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 18 Sep 2010 09:16:16 +0900
Message-ID: <1284768976.2405.236.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nicolas,

> >>that is just because we haven't gotten there yet. Of course if SAP takes
> over we have to shutdown oFono's handling of the modem. This could be
> done similar to the support for Lockdown we have in the oFono TODO list.
> 
> Do you have information about the release date of this feature? And about the interface to lockdown, is it a D-BUS message? 

good one ;)

We know that we need such or similar feature for firmware updates where
we have to essentially shutdown oFono from driving the modem for a
period of time. The details are not 100% clear. For firmware updates
this has to be a D-Bus method, actually D-Bus property on the modem
interface.

In theory we can even extend this to do this internally as well. So that
an oFono plugin could lock down the modem. Things we clearly have to
figure out at some point.

> >There is a framework for card services in general, but I think that is
> just pure overhead for this.
> 
> >And to be honest, my current thinking is that even for pure SIM card
> readers with APDU mode, we might wanna support them via oFono anyway.
> Having to add SAP support in multiple levels is a bad idea.
> 
> Yes but an APDU interface is needed in the SIM driver of oFono, I don't see any interface of this kind in the source code.

Because we haven't had any hardware that does this so far. You will only
see code in oFono once we had hardware in our hands that is able of
doing this and we know how to drive it.

> Maybe it's not the good place to speak about that.

Essentially the oFono mailing list is a better place for such a
discussion.

> >However in the end this all depends on the hardware and right now I have
> not had access to SAP capable hardware. Or maybe I did and I didn't know
> it yet. Do we have any target hardware in mind?
> 
> Yes we have, it's Renesas Modem solution.

Any chance you guys could add Renesas Modem support to oFono and then us
some samples?

Regards

Marcel


