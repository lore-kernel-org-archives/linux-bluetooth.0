Return-Path: <cyrus@holtmann.org>
Message-ID: <1337625261.15105.7.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Remove dead int returns
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Mon, 21 May 2012 20:34:21 +0200
In-Reply-To: <alpine.DEB.2.02.1205211104570.2239@mathewm-linux>
References: <1337619502-4565-1-git-send-email-gustavo@padovan.org>
	 <1337619502-4565-2-git-send-email-gustavo@padovan.org>
	 <alpine.DEB.2.02.1205211104570.2239@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> 
> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> >
> > These functions were returning always 0, we just make then void.
> >
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > ---
> > net/bluetooth/l2cap_core.c |   48 +++++++++++++++-----------------------------
> > 1 file changed, 16 insertions(+), 32 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 5bf8287..b644f40 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -73,7 +73,7 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data);
> > static void l2cap_send_disconn_req(struct l2cap_conn *conn,
> > 				   struct l2cap_chan *chan, int err);
> >
> > -static int l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
> > +static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
> > 		    struct sk_buff_head *skbs, u8 event);
> >
> > /* ---- L2CAP channels ---- */
> > @@ -1685,8 +1685,8 @@ static void l2cap_retrans_timeout(struct work_struct *work)
> > 	l2cap_chan_put(chan);
> > }
> >
> > -static int l2cap_streaming_send(struct l2cap_chan *chan,
> > -				struct sk_buff_head *skbs)
> > +static void l2cap_streaming_send(struct l2cap_chan *chan,
> > +				 struct sk_buff_head *skbs)
> > {
> > 	struct sk_buff *skb;
> > 	struct l2cap_ctrl *control;
> > @@ -1719,8 +1719,6 @@ static int l2cap_streaming_send(struct l2cap_chan *chan,
> > 		chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
> > 		chan->frames_sent++;
> > 	}
> > -
> > -	return 0;
> > }
> >
> > static int l2cap_ertm_send(struct l2cap_chan *chan)
> > @@ -2254,13 +2252,11 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> > 			break;
> >
> > 		if (chan->mode == L2CAP_MODE_ERTM)
> > -			err = l2cap_tx(chan, NULL, &seg_queue,
> > -				       L2CAP_EV_DATA_REQUEST);
> > +			l2cap_tx(chan, NULL, &seg_queue, L2CAP_EV_DATA_REQUEST);
> > 		else
> > -			err = l2cap_streaming_send(chan, &seg_queue);
> > +			l2cap_streaming_send(chan, &seg_queue);
> >
> > -		if (!err)
> > -			err = len;
> > +		err = len;
> >
> > 		/* If the skbs were not queued for sending, they'll still be in
> > 		 * seg_queue and need to be purged.
> > @@ -2383,12 +2379,10 @@ static void l2cap_abort_rx_srej_sent(struct l2cap_chan *chan)
> > 	chan->rx_state = L2CAP_RX_STATE_RECV;
> > }
> >
> > -static int l2cap_tx_state_xmit(struct l2cap_chan *chan,
> > -			       struct l2cap_ctrl *control,
> > -			       struct sk_buff_head *skbs, u8 event)
> > +static void l2cap_tx_state_xmit(struct l2cap_chan *chan,
> > +				struct l2cap_ctrl *control,
> > +				struct sk_buff_head *skbs, u8 event)
> > {
> > -	int err = 0;
> > -
> > 	BT_DBG("chan %p, control %p, skbs %p, event %d", chan, control, skbs,
> > 	       event);
> >
> > @@ -2455,16 +2449,12 @@ static int l2cap_tx_state_xmit(struct l2cap_chan *chan,
> > 	default:
> > 		break;
> > 	}
> > -
> > -	return err;
> > }
> >
> > -static int l2cap_tx_state_wait_f(struct l2cap_chan *chan,
> > -				 struct l2cap_ctrl *control,
> > -				 struct sk_buff_head *skbs, u8 event)
> > +static void l2cap_tx_state_wait_f(struct l2cap_chan *chan,
> > +				  struct l2cap_ctrl *control,
> > +				  struct sk_buff_head *skbs, u8 event)
> > {
> > -	int err = 0;
> > -
> > 	BT_DBG("chan %p, control %p, skbs %p, event %d", chan, control, skbs,
> > 	       event);
> >
> > @@ -2537,31 +2527,25 @@ static int l2cap_tx_state_wait_f(struct l2cap_chan *chan,
> > 	default:
> > 		break;
> > 	}
> > -
> > -	return err;
> > }
> >
> > -static int l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
> > -		    struct sk_buff_head *skbs, u8 event)
> > +static void l2cap_tx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
> > +		     struct sk_buff_head *skbs, u8 event)
> > {
> > -	int err = 0;
> > -
> > 	BT_DBG("chan %p, control %p, skbs %p, event %d, state %d",
> > 	       chan, control, skbs, event, chan->tx_state);
> >
> > 	switch (chan->tx_state) {
> > 	case L2CAP_TX_STATE_XMIT:
> > -		err = l2cap_tx_state_xmit(chan, control, skbs, event);
> > +		l2cap_tx_state_xmit(chan, control, skbs, event);
> > 		break;
> > 	case L2CAP_TX_STATE_WAIT_F:
> > -		err = l2cap_tx_state_wait_f(chan, control, skbs, event);
> > +		l2cap_tx_state_wait_f(chan, control, skbs, event);
> > 		break;
> > 	default:
> > 		/* Ignore event */
> > 		break;
> > 	}
> > -
> > -	return err;
> > }
> >
> > static void l2cap_pass_to_tx(struct l2cap_chan *chan,
> > -- 
> > 1.7.10.1
> 
> Both patches look fine to me.

I applied both patches with your Reviewed-by to bluetooth-next.

Regards

Marcel


