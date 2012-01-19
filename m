Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jan 2012 15:18:36 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv3 05/34] Bluetooth: Allocate skb depending on sk
Message-ID: <20120119131835.GD20598@aemeltch-MOBL1>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1326964823-26747-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1326966966.1955.3.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326966966.1955.3.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 19, 2012 at 10:56:06AM +0100, Marcel Holtmann wrote:
> > Some channels might not have sk so we allocate skbuff directly.
> > The idea is to use l2cap_chan_send for sending packets not through
> > sockets.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c |   34 +++++++++++++++++++++++++++-------
> >  1 files changed, 27 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 598805b..bc42ee8 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1531,7 +1531,12 @@ static inline int l2cap_skbuff_fromiovec(struct l2cap_chan *chan, struct msghdr
> >  	while (len) {
> >  		count = min_t(unsigned int, conn->mtu, len);
> >  
> > -		*frag = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err);
> > +		if (sk)
> > +			*frag = bt_skb_send_alloc(sk, count,
> > +					msg->msg_flags & MSG_DONTWAIT, &err);
> > +		else
> > +			*frag = bt_skb_alloc(count, GFP_KERNEL);
> > +
> >  		if (!*frag)
> >  			return err;
> >  		if (memcpy_fromiovec(skb_put(*frag, count), msg->msg_iov, count))
> > @@ -1561,8 +1566,13 @@ static struct sk_buff *l2cap_create_connless_pdu(struct l2cap_chan *chan,
> >  	BT_DBG("sk %p len %d priority %u", sk, (int)len, priority);
> >  
> >  	count = min_t(unsigned int, (conn->mtu - hlen), len);
> > -	skb = bt_skb_send_alloc(sk, count + hlen,
> > -			msg->msg_flags & MSG_DONTWAIT, &err);
> > +
> > +	if (sk)
> > +		skb = bt_skb_send_alloc(sk, count + hlen,
> > +					msg->msg_flags & MSG_DONTWAIT, &err);
> > +	else
> > +		skb = bt_skb_alloc(count, GFP_KERNEL);
> > +
> >  	if (!skb)
> >  		return ERR_PTR(err);
> >  
> > @@ -1595,8 +1605,13 @@ static struct sk_buff *l2cap_create_basic_pdu(struct l2cap_chan *chan,
> >  	BT_DBG("sk %p len %d", sk, (int)len);
> >  
> >  	count = min_t(unsigned int, (conn->mtu - hlen), len);
> > -	skb = bt_skb_send_alloc(sk, count + hlen,
> > -			msg->msg_flags & MSG_DONTWAIT, &err);
> > +
> > +	if (sk)
> > +		skb = bt_skb_send_alloc(sk, count + hlen,
> > +					msg->msg_flags & MSG_DONTWAIT, &err);
> > +	else
> > +		skb = bt_skb_alloc(count, GFP_KERNEL);
> > +
> >  	if (!skb)
> >  		return ERR_PTR(err);
> >  
> > @@ -1642,8 +1657,13 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct l2cap_chan *chan,
> >  		hlen += L2CAP_FCS_SIZE;
> >  
> >  	count = min_t(unsigned int, (conn->mtu - hlen), len);
> > -	skb = bt_skb_send_alloc(sk, count + hlen,
> > -			msg->msg_flags & MSG_DONTWAIT, &err);
> > +
> > +	if (sk)
> > +		skb = bt_skb_send_alloc(sk, count + hlen,
> > +					msg->msg_flags & MSG_DONTWAIT, &err);
> > +	else
> > +		skb = bt_skb_alloc(count, GFP_KERNEL);
> > +
> >  	if (!skb)
> >  		return ERR_PTR(err);
> >  
> 
> so I am not sure that I wanna change all these functions this way. It
> might be a good way of handling this, but I am right now convinced.

I have sent new patch concerning skb allocation.

> Care to explain first on how you are using them.

I use the same function to send packet which is used by socket operations
but I do not have sk. I can create my own function but I would need to
duplicate ERTM code.

Each channel shall have own allocation function now, old allocation
function did not change.

But sometimes we still need to check sk or duplicate similar
functionality.

Best regards 
Andrei Emeltchenko 
