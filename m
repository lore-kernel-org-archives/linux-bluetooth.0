Return-Path: <jt@bougret.hpl.hp.com>
Date: Thu, 5 Feb 2004 15:43:17 -0800
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: L2CAP non-blocking socket nasty race conditions
Message-ID: <20040205234317.GA11427@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040205014030.GA23802@bougret.hpl.hp.com> <1075947705.2783.117.camel@pegasus> <20040205022635.GA24757@bougret.hpl.hp.com> <1075948602.2783.129.camel@pegasus> <20040205033019.GA25518@bougret.hpl.hp.com> <1075988978.2783.140.camel@pegasus> <20040205171919.GA5417@bougret.hpl.hp.com> <1076005057.2806.7.camel@pegasus> <20040205231325.GA10683@bougret.hpl.hp.com> <1076024244.2806.20.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1076024244.2806.20.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Fri, Feb 06, 2004 at 12:37:24AM +0100, Marcel Holtmann wrote:
> Hi Jean,
> 
> > 	There is one thing I don't like about your patch : you disable
> > error checking for listening socket. I don't think it's right,
> > especially for checking socket shutdown.
> > 	Let's take the following scenario. Multi-threaded program, one
> > listening l2cap socket. One thread poll/select on the socket. At some
> > point, the second thread close the socket. I would expect the first
> > thread to receive a POLLHUP. Note that you can do the same with a
> > single threaded program, closing the listening socket in the signal
> > handler.
> > 	The attached patch is a minor modification of your patch that
> > should fix this issue.
> 
> take a look at tcp_poll() in net/ipv4/tcp.c, because they do it the same
> and do we really have to care about it? How does TCP handles this case?
> 
> Regards
> 
> Marcel

	Well, it never hurts to be on the safe side. And if you look
at my patch, you would see that it's only a trivial change to your
patch. Anyway, up to you...

	Jean
