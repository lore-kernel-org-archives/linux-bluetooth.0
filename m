Return-Path: <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Qualification Testing
From: Max Krasnyansky <maxk@qualcomm.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1052584255.1133.13.camel@pegasus.local>
References: <000c01c313f5$b57ae030$1a01010a@baked>
	<000c01c313f5$b57ae030$1a01010a@baked>
	<5.1.0.14.2.20030508171149.01c082c0@unixmail.qualcomm.com>
	<1052442873.1069.35.camel@pegasus.local>
	<1052545687.10456.235.camel@localhost.localdomain>
	<1052584255.1133.13.camel@pegasus.local>
Content-Type: text/plain
Message-Id: <1052637555.24170.7.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 May 2003 00:19:15 -0700
List-ID: <bluez-devel.lists.sourceforge.net>

On Sat, 2003-05-10 at 09:30, Marcel Holtmann wrote:
> > Ok. I've fixed that (and pushed changes to BK). My idea about 
> > with TX_THROTTLED flag didn't work. Well, it worked but only in 
> > one direction :). Changing state machine would've been fairly big
> > change and could've affected compatibility.
> > So I added a simple logic to track MSC exchange state. Works beautifully
> 
> I like to see this logic in the state machine, but I agree with with you
> that it is not the right time for changing it. Your patch works also
> fine for me and I have a new 2.4.20 with all patches up and running.
> 
Actually MSC exchange is not part of the connect procedure. After UA is
received DLC is considered connected. Which means some implementations
might not send first MSC before they have data to send, that's what
meant that changing state machine could affect compatibility.
Besides MSC exchange, just like L2CAP config, doesn't have strict  
sequence which makes it hard to track with a single state. i.e they 
sent MSC first, we sent MSC first, etc. So I think we're ok.

> Max, please go ahead and forward them to Marcelo and Linus. If you have
> some extra time, please update my repositories with the new stuff.
Will do.

Max
