Return-Path: <cyrus@holtmann.org>
Date: Sun, 25 Mar 2012 14:16:12 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv5 06/26] Bluetooth: A2MP: Add chan callbacks
Message-ID: <20120325171612.GH3106@joana>
References: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332519246-16656-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332519246-16656-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-23 18:13:46 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add state change, close and skb allocation callbacks.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/a2mp.c |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index 84275e8..894c6c96 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -65,8 +65,42 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
>  	kfree(cmd);
>  }
>  
> +static void a2mp_chan_state_change_cb(void *data, int state, int err)
> +{
> +	struct l2cap_chan *chan = data;
> +	struct amp_mgr *mgr;
> +
> +	BT_DBG("chan %p state %s", chan, state_to_string(state));
> +
> +	chan->state = state;
> +
> +	switch (state) {
> +	case BT_CLOSED:
> +		mgr = chan->data;
> +		if (mgr)
> +			amp_mgr_put(mgr);
> +		break;
> +	}
> +}
> +
> +static void a2mp_chan_close_cb(void *data)
> +{
> +	struct amp_mgr *mgr = data;
> +
> +	l2cap_chan_destroy(mgr->a2mp_chan);
> +}
> +
> +static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
> +					unsigned long len, int nb, int *err)

Wrong coding style here. As we just changed our coding style check the rest of
this patchset for errors like this

> +{
> +	return bt_skb_alloc(len, GFP_KERNEL);
> +}
> +
>  static struct l2cap_ops a2mp_chan_ops = {
>  	.name = "L2CAP A2MP channel",
> +	.state_change = a2mp_chan_state_change_cb,
> +	.close = a2mp_chan_close_cb,
> +	.alloc_skb = a2mp_chan_alloc_skb_cb,
>  };
>  
>  static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
> @@ -108,6 +142,8 @@ static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
>  	chan->remote_mps = chan->omtu;
>  	chan->mps = chan->omtu;
>  
> +	chan->ops->state_change(chan, BT_CONNECTED, 0);

This is the same of calling a2mp_chan_alloc_skb_cb() directly. ops is intended
to be used outside of this file, not inside it.

	Gustavo
