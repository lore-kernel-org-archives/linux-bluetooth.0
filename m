Return-Path: <jt@bougret.hpl.hp.com>
Date: Mon, 9 Aug 2004 12:54:48 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2.6] link trigger for AODV and +
Message-ID: <20040809195448.GA24140@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040805013335.GA13608@bougret.hpl.hp.com> <1091976547.2773.29.camel@pegasus> <20040809185159.GA21899@bougret.hpl.hp.com> <1092078516.4564.40.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092078516.4564.40.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, Aug 09, 2004 at 09:08:36PM +0200, Marcel Holtmann wrote:
> Hi Jean,
> 
> > > no problem, I got the point. However I am not sure about applying your
> > > patch. I don't like the way the event is propagated. It is a connection
> > > related event and so I like to send it to the sockets that are using
> > > that ACL connection. Or at least I should introduce the per device stack
> > > internal events.
> > 
> > 	The typical application is to monitor a BNEP connection (AODV
> > deals with TCP/IP traffic). The L2CAP socket for the BNEP traffic is
> > owned by the PAN deamon. However, you may want to feed the event
> > directly to AODV without having to modify the PAN daemon and having to
> > relay events.
> 
> this is a good point and I do think that this patch is a nice additional
> feature for BlueZ, but I am not fully comfortable with it in its current
> shape. Actually some time ago I thought about removing the support for
> stack internal events.

	In my stuff, I use internal events to know when hci interfaces
go up and down and when they appear and disappear. As far as I know,
those events are not available by any other means. They are not
available through RtNetlink because hci interfaces are not real netdev
interfaces.
	I personally prefer event driver APIs rather than blocking
APIs, I find it much more flexible. And it fits with the raw HCI API.

> > 	Note that the patch for the poll/listen bug was only partially
> > applied to 2.4.X, I have a patch for it, I still need to test it.
> 
> I sent the full patch for inclusion, but it came out that one part
> causes troubles and so I removed this part. I didn't found the time for
> a further investigation.

	That's what I said : I'm going to test it properly. If you
could remember the issue, that would help.

> Regards
> 
> Marcel

	Jean
