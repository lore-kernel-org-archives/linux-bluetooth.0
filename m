Return-Path: <jt@bougret.hpl.hp.com>
Date: Wed, 4 Feb 2004 18:42:30 -0800
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: L2CAP non-blocking socket nasty race conditions
Message-ID: <20040205024230.GA25001@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040204175832.GB16590@bougret.hpl.hp.com> <1075924727.2783.47.camel@pegasus> <20040204214541.GA20129@bougret.hpl.hp.com> <1075942818.2783.70.camel@pegasus> <20040205011102.GA23352@bougret.hpl.hp.com> <1075944624.2783.87.camel@pegasus> <20040205014030.GA23802@bougret.hpl.hp.com> <1075947705.2783.117.camel@pegasus> <20040205022635.GA24757@bougret.hpl.hp.com> <1075948602.2783.129.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1075948602.2783.129.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, Feb 05, 2004 at 03:36:43AM +0100, Marcel Holtmann wrote:
> Hi Jean,
> 
> > > What I am thinking is that
> > > if our socket is BT_LISTEN, we check for an not empty accept_q and than
> > > iterate through all sockets for BT_CONNECTED. If we found one, we return
> > > POLLIN else nothing.
> > 
> > 	This is a bit yucky, especially that poll is performance
> > critical (for scalability). That's why I was suggesting the socket
> > counter in the parent. Check what's sk_ack_backlog does, it's very
> > close to what we want.
> 
> yes I know, but worse performance only kicks in if it is a listen socket
> and if it has at minimum one child in its queue. A second counter sounds
> not really better to me and I think it will be very hackish.
> 
> Regards
> 
> Marcel

	Ok. I'll try my best along those lines.

	Jean
