Return-Path: <davem@davemloft.net>
Date: Tue, 25 Jan 2005 21:56:39 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: nish.aravamudan@gmail.com, nacc@us.ibm.com, kernel-janitors@lists.osdl.org,
   bluez-devel@lists.sourceforge.net, maxk@qualcomm.com
Subject: Re: [UPDATE PATCH 18/39] net/core: use wait_event_timeout()
Message-Id: <20050125215639.15de5436.davem@davemloft.net>
In-Reply-To: <1106472068.10567.5.camel@pegasus>
References: <20050120235123.GG2600@us.ibm.com>
	<1106267534.7955.36.camel@pegasus>
	<20050121190909.GD3340@us.ibm.com>
	<1106416648.8118.3.camel@pegasus>
	<29495f1d05012210441655fa20@mail.gmail.com>
	<1106472068.10567.5.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Sun, 23 Jan 2005 10:21:08 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> we are using the wait queue from struct sock and sk_sleep is already a
> pointer. Converting from and to a pointer and later to the struct again
> to only match an API looks wrong to me and thus this API is wrong, but
> this is only my thought.
> 
> Dave, any comments from you about this?

Not really.  I think the API is ok, it's a tradeoff between one set
of call types putting in a deref compared to the other.  And as the
patch author stated, the bluetooth side is definitely in the
minority.

To be honest, I think the decision is arbitrary.
