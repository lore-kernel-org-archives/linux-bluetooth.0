Return-Path: <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
From: Max Krasnyansky <maxk@qualcomm.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: Daryl Van Vorst <daryl@wideray.com>, "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1052526375.1214.130.camel@pegasus.local>
References: <000801c31684$627d9f80$1a01010a@baked>
	<1052526375.1214.130.camel@pegasus.local>
Content-Type: text/plain
Message-Id: <1052547309.10456.259.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 09 May 2003 23:17:08 -0700
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, 2003-05-09 at 17:26, Marcel Holtmann wrote:
> > Here's Cetecom's response to your comment:
> > 
> > "Good point ! I agree, in a messed up remote L2CAP stack, CID could be wrong
> > as well if length is wrong. But I think it is a good approach to check
> > first, if that CID exists and if yes, notify the app about that channel."
> > 
> > So how about we do this:  As above, if it exists then we close it. If not,
> > we log an error.
> 
> the proposal from Cetecom makes no sense.
> 
> If you have one channel with correct data and you get a wrong packet
> which was for another channel, but the CID is corrupt and show now the
> value of the correct channel. You will infect a correct working channel
> with a false packet.
Yep. We could do that but it simply makes no sense. I'm glad our IP 
stack doesn't kill random sockets when it receives corrupted IP packets,
just because it wants to indicate an error to an application and port
number happened to exist :-).

> The main problem is that wrong packets should not arrive at the L2CAP
> layer. If they do and we decect them (like a length mismatch), we have
> to close down all channels and remove the infected ACL link.
The key words is 'should not' here. I've seen it happen because of USB problems
or UART H4 problems. Not the wrong length but missing fragments and
stuff.  

> Max, what do you think? This way is a little bit radical, but I think it
> is an acceptable way of handling these errors. And with this method we
> will pass this test.
Yeah, I think it's a bit to aggressive. BNEP connection, for example,
survives missing frags and pretty much anything else just fine. 

I'd rather keep the current code. Which I fixed btw to correctly drop
frame if first fragment is too long. It was a real bug which could cause
kernel oops in certain conditions.

Max
