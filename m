Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: Re: [PATCH -v2 3/7] Bluetooth: Create l2cap_chan_send()
Date: Mon, 16 May 2011 11:07:25 +0200
References: <1305314450-25493-1-git-send-email-padovan@profusion.mobi> <1305314450-25493-3-git-send-email-padovan@profusion.mobi> <1305314450-25493-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305314450-25493-4-git-send-email-padovan@profusion.mobi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201105161107.25986.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> This move all the sending logic to l2cap_core.c, but we still have a
> socket dependence there, struct msghdr. It will be removed in some of the
> further commits.

> +int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
> +{
> +	struct sock *sk = chan->sk;
> +	struct sk_buff *skb;
> +	u16 control;
> +	int err;
> +
> +	/* Connectionless channel */
> +	if (sk->sk_type == SOCK_DGRAM) {
> +		skb = l2cap_create_connless_pdu(chan, msg, len);
> +		if (IS_ERR(skb))
> +			return PTR_ERR(skb);
> +
> +		l2cap_do_send(chan, skb);
> +		return len;
> +	}
> +
> +	switch (chan->mode) {
> +	case L2CAP_MODE_BASIC:
> +		/* Check outgoing MTU */
> +		if (len > chan->omtu)
> +			return -EMSGSIZE;
> +
> +		/* Create a basic PDU */
> +		skb = l2cap_create_basic_pdu(chan, msg, len);
> +		if (IS_ERR(skb))
> +			return PTR_ERR(skb);
> +
> +		l2cap_do_send(chan, skb);
> +		err = len;
> +		break;
> +
> +	case L2CAP_MODE_ERTM:
> +	case L2CAP_MODE_STREAMING:

How about moving common part (sdu if-else) to a function and separate those 2 cases?
Would be less confusing imho.

> +		/* Entire SDU fits into one PDU */
> +		if (len <= chan->remote_mps) {
> +			control = L2CAP_SDU_UNSEGMENTED;
> +			skb = l2cap_create_iframe_pdu(chan, msg, len, control,
> +									0);
> +			if (IS_ERR(skb))
> +				return PTR_ERR(skb);
> +
> +			__skb_queue_tail(&chan->tx_q, skb);
> +
> +			if (chan->tx_send_head == NULL)
> +				chan->tx_send_head = skb;
> +
> +		} else {
> +			/* Segment SDU into multiples PDUs */
> +			err = l2cap_sar_segment_sdu(chan, msg, len);
> +			if (err < 0)
> +				return err;
> +		}
> +
> +		if (chan->mode == L2CAP_MODE_STREAMING) {
> +			l2cap_streaming_send(chan);
> +			err = len;
> +			break;
> +		}
> +
> +		if ((chan->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
> +				(chan->conn_state & L2CAP_CONN_WAIT_F)) {
> +			err = len;
> +			break;
> +		}
> +
> +		err = l2cap_ertm_send(chan);
> +		if (err >= 0)
> +			err = len;
> +
> +		break;
> +
> +	default:
> +		BT_DBG("bad state %1.1x", chan->mode);
> +		err = -EBADFD;
> +	}
> +
> +	return err;
> +}

-- 
BR
Szymon Janc
