Return-Path: <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Qualification Testing
From: Max Krasnyansky <maxk@qualcomm.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Daryl Van Vorst <daryl@wideray.com>, BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1052442873.1069.35.camel@pegasus.local>
References: <000c01c313f5$b57ae030$1a01010a@baked>
	<000c01c313f5$b57ae030$1a01010a@baked>
	<5.1.0.14.2.20030508171149.01c082c0@unixmail.qualcomm.com>
	<1052442873.1069.35.camel@pegasus.local>
Content-Type: text/plain
Message-Id: <1052545687.10456.235.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 09 May 2003 23:16:53 -0700
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2003-05-08 at 18:14, Marcel Holtmann wrote:
> > >>         2.) TP/RFC/BV-07: Closing rfcomm doesn't appear to close l2cap. Is
> > >> this true? This isn't actually required to pass this test, but it did
> > >> confuse the tester. This may have been a mistake on my part. I just hit
> > >> ctrl-c when rctest was connected and assumed that everything would get
> > >> closed. Would calling close() have a different effect?
> > >
> > >This is working fine for me. After closing the channel, we close dlci 0
> > >and this also closes the L2CAP connection.
> > Yes. I'm 100% sure it works. rfcomm_session_del() kills L2CAP socket.
> 
> Can you remember if we had a problem with this in bluez-kernel-2.3 ?
It should work even in 2.3. But I wouldn't bet on it :)

> > >>         5.) Once an RFCOMM channel is established, the IUT must exchange
> > >> MSC's (modem status commands) before sending data. That is, it must send an
> > >> MSC, wait for a response, wait for the sender's MSC, and respond to it
> > >> before sending data. Our device sent an MSC and then immediately started
> > >> sending data when we used rctest. This applies to many test cases.
> > >
> > >We send the MSC after the UA. But we also go into BT_CONNECTED state and
> > >in this state you can also start sending data. We should maybe go from
> > >BT_CONNECT -> BT_CONFIG and only switch to BT_CONNECTED after the
> > >successful exchange of MSC.
> > I remember thinking about that. But they way I interpreted spec was that we
> > don't have to wait for MSC response. 
> > This should be easy to fix.
> 
> I leave this up to you to fix.
> 
> > btw When CFC is not enabled we will have to wait for MSC from the other side. Notice that we set
> > THROTTLED flag in that case. Which is cleared by the MSC or more credits.
> > So I guess we can just always set that flag and clear it when we get MSC which will fix the MSC 
> > test case without messing with the state machine.
> 
> Sounds reasonable to me.

Ok. I've fixed that (and pushed changes to BK). My idea about 
with TX_THROTTLED flag didn't work. Well, it worked but only in 
one direction :). Changing state machine would've been fairly big
change and could've affected compatibility.
So I added a simple logic to track MSC exchange state. Works beautifully
:) 

Max
