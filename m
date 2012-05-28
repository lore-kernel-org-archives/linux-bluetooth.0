Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 May 2012 17:12:24 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v3 07/10] Bluetooth: Add chan->ops->defer()
Message-ID: <20120528141222.GC3537@aemeltch-MOBL1>
References: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
 <1338168480-9646-7-git-send-email-gustavo@padovan.org>
 <1338177260.15105.117.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338177260.15105.117.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel and Gustavo,

On Mon, May 28, 2012 at 05:54:20AM +0200, Marcel Holtmann wrote:
...

> > @@ -1052,6 +1063,7 @@ static struct l2cap_ops l2cap_chan_ops = {
> >  	.teardown	= l2cap_sock_teardown_cb,
> >  	.state_change	= l2cap_sock_state_change_cb,
> >  	.ready		= l2cap_sock_ready_cb,
> > +	.defer		= l2cap_sock_defer_cb,
> >  	.alloc_skb	= l2cap_sock_alloc_skb_cb,
> >  };
> 
> In addition can you explain to me how this is suppose to work if defer
> is not set. Then we never call ready.

For fixed channel we do not use ready so this would be OK.

> Also this is a pretty bad idea inside the code. We better do something
> like l2cap_sock_no_defer like the network subsystem does for general
> socket. Since otherwise you keep spreading if (defer) all over the
> places.

This look right, I will change my code following your proposal so Gustavo
can invoke those functions directly.

Best regards 
Andrei Emeltchenko 
