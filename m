Return-Path: <cyrus@holtmann.org>
Subject: Re: Sony BD Remote pairing problems with new distributions
From: Bastien Nocera <hadess@hadess.net>
To: Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <alpine.GSO.2.00.0901151411450.9769@denali.ccs.neu.edu>
References: <alpine.GSO.2.00.0901131907350.14823@denali.ccs.neu.edu>
	 <alpine.GSO.2.00.0901151411450.9769@denali.ccs.neu.edu>
Content-Type: text/plain
Date: Thu, 15 Jan 2009 20:28:03 +0000
Message-Id: <1232051283.16333.1.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2009-01-15 at 14:23 -0500, Jim Faulkner wrote:
> On Tue, 13 Jan 2009, Jim Faulkner wrote:
> 
> > My sony BD remote (aka PS3 remote) requires a convoluted process to get it 
> > working each and every time my computer boots.
> 
> I just wanted to follow up on this.  I have managed to get my BD remote 
> permanently paired with my computer.  I no longer need to to go through 
> the process of pairing it each time the computer boots.

It doesn't need actual pairing, because there's no PIN code exchange.
Also, hidd doesn't know how to drive the device whatsoever.

Using bluez-gnome to pair the device using the wizard should just work.
See the archives for more discussion about that.

Cheers

