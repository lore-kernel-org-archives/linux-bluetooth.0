Return-Path: <cyrus@holtmann.org>
Subject: Re: Keeping ACL link around after DBUS CreateBonding()
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960810060918l5887aedya50893238ca3aee7@mail.gmail.com>
References: <35c90d960810021747j56d5bc2ie62c10ade0026694@mail.gmail.com>
	 <1223015762.11272.30.camel@violet.holtmann.net>
	 <35c90d960810022342p1fca607x4be774ae9e675fd9@mail.gmail.com>
	 <1223016985.11272.38.camel@violet.holtmann.net>
	 <35c90d960810060918l5887aedya50893238ca3aee7@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 06 Oct 2008 18:26:24 +0200
Message-Id: <1223310384.11272.209.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> >> >> I have memories of one of you talking about a custom change to bluez
> >> >> to not immediately drop the ACL link once DBUS CreateBonding() has
> >> >> finished (so that SDP can then be done on that link).
> >> >>
> >> >> Do you know the patch to do this? I am currently experimenting with
> >> >> changing the timer expiry in hci_conn_put() for disc_timer. Maybe
> >> >> there's a nicer way.
> >> >
> >> > do you have a trace in BTSnoop format for me. We are using L2CAP raw
> >> > sockets for bonding and thus the default 2 seconds disconnect timeout
> >> > applies. Enough time to get SDP started on the same link. If the remote
> >> > side however decides to disconnect us, we are out of luck.
> >>
> >> For this situation the ACL connection is not complete, so the 10ms
> >> timeout applies. I have a patch to use the 2 second timeout code path
> >> for both connecting and connected. I wonder if this would be useful in
> >> mainline, or if this is just a strange behavior of our BRF6300 (it
> >> completes pin code and link key before the ACL link is reported as
> >> connected). I'll send you some logs tomorrow if that would still help.
> >
> > that is not strange behavior. That is just a device in security mode 3.
> > The important question is who disconnects the link.
> 
> We (bluez kernel stack) disconnect the link due to the 10 ms timeout
> that applies when the ACL link is in CONNECT. Here is a patch to use
> the 2 second time out during CONNECT phase as well as CONNECTED. Does
> this patch seem reasonable? It looks like just CONNECT || CONNECTED is
> sufficient, but there are other modes like CONNECT2.

I really need to have a BTSnoop trace of this. I am not sure why you end
up in a situation where the timer is active anyway. What kernel version
are you running? Can you re-produce it with a 2.6.27-rc8 one?

The CONNECT2 is the re-try case for concurrent connection attempts where
link manager does not queue up the create connection.

Regards

Marcel


