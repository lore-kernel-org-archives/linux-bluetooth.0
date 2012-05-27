Return-Path: <cyrus@holtmann.org>
Message-ID: <1338095494.15105.106.camel@aeonflux>
Subject: Re: [PATCH -v2 12/12] Bluetooth: Used void * as parameter in
 alloc_skb()
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Sun, 27 May 2012 07:11:34 +0200
In-Reply-To: <20120525124139.GD31623@joana>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
	 <1337949064-26187-13-git-send-email-gustavo@padovan.org>
	 <20120525123932.GH3089@aemeltch-MOBL1> <20120525124139.GD31623@joana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > On Fri, May 25, 2012 at 09:31:04AM -0300, Gustavo Padovan wrote:
> > > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > > 
> > > This keep l2cap chan ops functions parameters in sync.
> > > 
> > > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > 
> > ...
> > 
> > > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > > index 25a85ab..0f8886b 100644
> > > --- a/include/net/bluetooth/l2cap.h
> > > +++ b/include/net/bluetooth/l2cap.h
> > > @@ -532,8 +532,8 @@ struct l2cap_ops {
> > >  	void			(*close) (void *data);
> > >  	void			(*teardown) (void *data, int err);
> > >  	void			(*state_change) (void *data, int state);
> > > -	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
> > > -					       unsigned long len, int nb);
> > > +	struct sk_buff		*(*alloc_skb) (void *data, unsigned long len,
> > > +					       int nb);
> > 
> > ...
> > 
> > > @@ -1893,7 +1893,7 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan,
> > >  
> > >  		count = min_t(unsigned int, conn->mtu, len);
> > >  
> > > -		tmp = chan->ops->alloc_skb(chan, count,
> > > +		tmp = chan->ops->alloc_skb(chan->data, count,
> > 
> > Why do we need to pass chan->data instead of chan?
> 
> We are changing this to make this call have the same parameter as the other
> ops calls, i.e., a void *, so we just pass chan->data here which is the user
> data (struct sock *sk in the l2cap_sock.c case).

so what is the problem to just pass l2cap_chan in here for all calls and
then have the it do chan->data inside the callback. This void *data
thing is dead ugly.

Regards

Marcel


