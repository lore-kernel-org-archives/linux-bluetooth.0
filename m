Return-Path: <jt@bougret.hpl.hp.com>
Date: Tue, 10 Aug 2004 16:37:01 -0700
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Michal Semler <cijoml@volny.cz>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2.6] link trigger for AODV and +
Message-ID: <20040810233701.GB16435@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040805013335.GA13608@bougret.hpl.hp.com> <1091976547.2773.29.camel@pegasus> <20040809185159.GA21899@bougret.hpl.hp.com> <1092078516.4564.40.camel@pegasus> <20040809195448.GA24140@bougret.hpl.hp.com> <1092125599.4564.76.camel@pegasus> <20040810163203.GA1963@bougret.hpl.hp.com> <1092178402.4564.204.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092178402.4564.204.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Aug 11, 2004 at 12:53:23AM +0200, Marcel Holtmann wrote:
> Hi Jean,
> 
> you are right, but there are pros and cons on both sides and I like to
> find the best solution. However I never looked at RtNetlink before. I
> think that I should educate myself a little bit more.

	Netlink is a generic socket between the kernel and user space,
RtNetlink is a API using Netlink to manipulate IP routes and a few
other stuff.
	Start with the iproute package, which is an user interface to
RtNetlink (the command part). Then, look at iwevent, that make use of
various RtNetlink events.
	Note that you can't migrate the HCI events to RtNetlink,
because RtNetlink expect a real netdev. You could migrate to Netlink,
defining you own API over Netlink, but I don't see what would be the
gain.

> > 	The bug is obvious, you forgot that in 2.4.X the list doesn't
> > point to struct sock but to struct bluez_pinfo. Compare your patch to
> > the version below.
> 
> What a stupid mistake. I must been blind at that time :(

	It happens to all of us ;-) I'm glad I started with my own
backport and had my own separate patch, because otherwise I would not
have find this bug...

> Regards
> 
> Marcel

	Have fun...

	Jean
