Return-Path: <cyrus@holtmann.org>
Subject: Re: Enhancements to allow l2cap channel to use either AMP or BR/EDR
From: Marcel Holtmann <marcel@holtmann.org>
To: David Vrabel <david.vrabel@csr.com>
Cc: tmonahan@codeaurora.org, Inga Stotland <ingas@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	johan.hedberg@gmail.com
In-Reply-To: <4C58129E.3080306@csr.com>
References: <8bfb018fa669b6ace6840881379a1a01.squirrel@www.codeaurora.org>
	 <1280775200.12579.30.camel@localhost.localdomain>
	 <4C58129E.3080306@csr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 Aug 2010 09:14:17 -0700
Message-ID: <1280852057.12579.86.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> > That said, nothing stops us from allowing to make our AMP polices
> > dynamic and allow the application to change it threshold during
> > lifetime. For example it starts out as BR/EDR only and then during the
> > usage of the link it decides that now AMP preferred would make sense. In
> > that sense you would have manual switching to some level.
> 
> If the policy is dynamic throughout the lifetime of the connection then
> that's okay for best effort links.
> 
> I think applications (especially those that stream real-time data at
> high rates) will need to know the currently available bandwidth.  This
> will be useful for even simple file transfer profiles -- if that file
> transfer is going to take 100x as long the user probably want to know
> about this so they can (for example) turn HS mode on the other device.
> 
> This information could be conveyed in some sort of "channel move
> complete" event or a more generic "available bandwidth changed" event.

so here you have the following problem, the only interface you get from
an application point of view is a L2CAP socket. So you have to work with
these constraints. Potentially we can provide something additional via
the OOB msg structs (like we do for timestamps), but I am really careful
in adding to much into these ones.

Regards

Marcel


