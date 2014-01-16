Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jan 2014 10:53:02 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Queue incoming ACL data until BT_CONNECTED
 state is reached
Message-ID: <20140116085302.GB12252@x220.p-661hnu-f1>
References: <1389778231-20307-1-git-send-email-johan.hedberg@gmail.com>
 <BB667CD7-90B1-4D87-8647-F59CB35A258B@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BB667CD7-90B1-4D87-8647-F59CB35A258B@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 15, 2014, Marcel Holtmann wrote:
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -63,6 +63,8 @@ static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err);
> > static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
> > 		     struct sk_buff_head *skbs, u8 event);
> > 
> > +static void process_pending_rx(struct work_struct *work);
> > +
> 
> do we really need this forward declaration?

Believe me I hate forward declarations just as much as you do. Either
this function or then l2cap_recv_frame must be forward declared unless
you want to move the following functions further down in l2cap_core.c:

l2cap_conn_add()
l2cap_chan_connect()
l2cap_connect_cfm()

The last two depend on l2cap_conn_add() which in turn depends on
process_pending_rx(). It's a fairly simple patch looking like this (two
more lines removed because the stat includes removing the forward
declatiation - I'd of course order the patches the other way around when
I send them):

 net/bluetooth/l2cap_core.c | 430 ++++++++++++++++++++--------------------
 1 file changed, 214 insertions(+), 216 deletions(-)

Doing this however means e.g. that l2cap_connect_cfm() isn't any more
grouped in the same place as connect_ind() and the other callbacks. So
I'm not sure if you wanna move those also downwards (making the patch
bigger), not worry about it, or just stick to the forward declaration.

Johan

> > +static void process_pending_rx(struct work_struct *work)
> > +{
> > +	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
> > +					       pending_rx_work);
> > +
> > +	BT_DBG("");
> > +
> > +	while (!skb_queue_empty(&conn->pending_rx)) {
> > +		struct sk_buff *skb;
> > +
> > +		skb = skb_dequeue(&conn->pending_rx);
> > +
> > +		l2cap_recv_frame(conn, skb);
> > +	}
> > +}
> > +
> 
> I realize we have done this skb_queue_empty check and then skb_dequeue
> a bit, but that seems a little bit pointless.
> 
> skb_dequeue is taking a spinlock, but even then checking for empty
> first and then dequeuing it seems more complicated that needed here.
> We could just dequeue it check if skb == NULL.
> 
> 	while (1) {
> 		struct sk_buff *skb;
> 
> 		skb = sbk_dequeue(&conn->pending_rx);
> 		if (!skb)
> 			break;
> 
> 		l2cap_recv_frame(conn, skb);
> 	}

I've fixed this in my v2.

> And we have similar things in l2cap_streaming_send, l2cap_chan_send
> and l2cap_le_credits. I get the feeling we should change all of these.

Sure, I'll send patches for those at some point.

Johan
