Return-Path: <jt@bougret.hpl.hp.com>
Date: Wed, 12 Jan 2005 13:25:55 -0800
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: out of range
Message-ID: <20050112212555.GA5572@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20050112183806.GE31615@bougret.hpl.hp.com> <1105561978.7961.140.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1105561978.7961.140.camel@pegasus>
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Jan 12, 2005 at 09:32:58PM +0100, Marcel Holtmann wrote:
> Hi Jean,
> 
> > > I think there is no way to differ between it yet. Feel free to propose
> > > an idea how that should be done within the normal socket operation.
> > 
> > 	Marcel : I did propose to you a scheme to detect out of range
> > conditions ahead of the Supervision Timeout that would clearly also
> > work for this.
> 
> I had your patch in my -mh patches for some time, but then it got out of
> sync with the mainline development and I dropped it. However I want your
> patch inside the kernel, but I still don't like the way of notification.
> What do you think about setting sk->sk_err with an error code like we do
> for the reliable feature that detects ACL packet errors. Even if the HCI
> events itself are global I like to do the notification through the
> socket interfaces of L2CAP and RFCOMM. Comments?

	I'm afraid I'm not familiar with the sk->sk_err stuff. My
assumption is that a write/read would return the error. Yep, I think
that would be much simpler/smoother/straightforward for most
applications, as most applications don't open HCI sockets.
	However, I was personally using this feature with BNEP sockets
(i.e. monitoring PAN), and pand doesn't do any read/write on the L2CAP
socket once the BNEP connection is established. So, in this case, the
HCI event makes more sense.

> Regards
> 
> Marcel

	Have fun...

	Jean
