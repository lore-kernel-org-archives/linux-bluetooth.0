Return-Path: <jt@bougret.hpl.hp.com>
Date: Mon, 9 Aug 2004 11:51:59 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2.6] link trigger for AODV and +
Message-ID: <20040809185159.GA21899@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040805013335.GA13608@bougret.hpl.hp.com> <1091976547.2773.29.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091976547.2773.29.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Sun, Aug 08, 2004 at 04:49:08PM +0200, Marcel Holtmann wrote:
> Hi Jean,
> 
> no problem, I got the point. However I am not sure about applying your
> patch. I don't like the way the event is propagated. It is a connection
> related event and so I like to send it to the sockets that are using
> that ACL connection. Or at least I should introduce the per device stack
> internal events.

	The typical application is to monitor a BNEP connection (AODV
deals with TCP/IP traffic). The L2CAP socket for the BNEP traffic is
owned by the PAN deamon. However, you may want to feed the event
directly to AODV without having to modify the PAN daemon and having to
relay events.

> Another question is, do we need a compile option for it? Is there any
> disadvantage to compile it always and disable by default?

	For a (still) experimental feature, it make sense to keep it
encapsualted. It's easier to remove #define than to add it. Your call.

> > 	Patch has been tested in kernel from 2.6.1 to 2.6.8. I also
> > have a patch for 2.4.X. Please apply...
> 
> I would include it into my next -mh patch for testing, but the 2.4
> series should be closed for new features.

	I know, that's why I kept it for myself.
	Note that the patch for the poll/listen bug was only partially
applied to 2.4.X, I have a patch for it, I still need to test it.

> Regards
> 
> Marcel

	Have fun...

	Jean
