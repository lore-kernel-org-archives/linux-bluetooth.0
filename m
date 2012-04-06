Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Apr 2012 20:20:25 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv6 06/26] Bluetooth: A2MP: Add chan callbacks
Message-ID: <20120406232025.GF2915@joana>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332941509-21345-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-28 16:31:29 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add state change, close and skb allocation callbacks.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/a2mp.c |   37 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 37 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index b572f9f..980382b 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -65,8 +65,43 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
>  	kfree(cmd);
>  }
>  
> +static void a2mp_chan_state_change_cb(void *data, int state)
> +{
> +	struct l2cap_chan *chan = data;
> +	struct amp_mgr *mgr;

data is already chan->data. So it is mgr here actually.

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
> +					      unsigned long len, int nb,
> +					      int *err)

See the patch I sent to the mailing list removing the err param.

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
>  static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
> @@ -104,6 +139,8 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
>  	chan->remote_mps = chan->omtu;
>  	chan->mps = chan->omtu;
>  
> +	a2mp_chan_state_change_cb(chan, BT_CONNECTED);

I would just replace this with

	chan->state = BT_CONNECTED;


	Gustavo
