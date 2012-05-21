Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 May 2012 15:28:57 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCHv1 16/17] Bluetooth: A2MP: Handling fixed channels
In-Reply-To: <1337351150-20526-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Message-ID: <alpine.DEB.2.02.1205211438590.2239@mathewm-linux>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1337351150-20526-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei -

On Fri, 18 May 2012, Andrei Emeltchenko wrote:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> A2MP fixed channel do not have sk
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
> include/net/bluetooth/l2cap.h |    1 +
> net/bluetooth/a2mp.c          |    3 +--
> net/bluetooth/l2cap_core.c    |   25 +++++++++++++++++++++++--
> 3 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 8cc739f..db47103 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -582,6 +582,7 @@ struct l2cap_conn {
> #define L2CAP_CHAN_RAW			1
> #define L2CAP_CHAN_CONN_LESS		2
> #define L2CAP_CHAN_CONN_ORIENTED	3
> +#define L2CAP_CHAN_CONN_FIX_A2MP	4
>
> /* ----- L2CAP socket info ----- */
> #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index 4616da1..86b2078 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -465,8 +465,7 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
>
> 	hci_conn_hold(conn->hcon);
>
> -	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
> -	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
> +	chan->chan_type = L2CAP_CHAN_CONN_FIX_A2MP;
> 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
>
> 	chan->ops = &a2mp_chan_ops;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ee333f0..b5c4229 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -450,6 +450,13 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> 		chan->omtu = L2CAP_DEFAULT_MTU;
> 		break;
>
> +	case L2CAP_CHAN_CONN_FIX_A2MP:
> +		chan->scid = L2CAP_CID_A2MP;
> +		chan->dcid = L2CAP_CID_A2MP;
> +		chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
> +		chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
> +		break;
> +
> 	default:
> 		/* Raw socket can send/recv signalling messages only */
> 		chan->scid = L2CAP_CID_SIGNALING;
> @@ -480,7 +487,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> {
> 	struct sock *sk = chan->sk;
> 	struct l2cap_conn *conn = chan->conn;
> -	struct sock *parent = bt_sk(sk)->parent;
> +	struct sock *parent;
>
> 	__clear_chan_timer(chan);
>
> @@ -496,6 +503,9 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> 		hci_conn_put(conn->hcon);
> 	}
>
> +	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP)
> +		goto clean;
> +

Since this has more to do with socketless channels than A2MP, it might 
be better to do something more generic here like add a callback to 
l2cap_ops so this socket code can be removed from l2cap_core rather 
than worked around.

> 	lock_sock(sk);
>
> 	__l2cap_state_change(chan, BT_CLOSED);
> @@ -504,6 +514,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> 	if (err)
> 		__l2cap_chan_set_err(chan, err);
>
> +	parent = bt_sk(sk)->parent;
> 	if (parent) {
> 		bt_accept_unlink(sk);
> 		parent->sk_data_ready(parent, 0);
> @@ -515,6 +526,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
> 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
> 		return;
>
> +clean:
> 	skb_queue_purge(&chan->tx_q);
>
> 	if (chan->mode == L2CAP_MODE_ERTM) {
> @@ -992,6 +1004,9 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
> 	if (!conn)
> 		return;
>
> +	if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP)
> +		return;
> +

There are places in the ERTM state machine that call 
l2cap_send_disconn_req() to tear down an unrecoverable ERTM 
connection.  If the connection remained up, I'm not sure how ERTM will 
behave.

I don't know that the spec is very clear about what to do 
when ERTM must disconnect the channel, but the channel is fixed.

I think it would be best to tell the owner of the channel (A2MP in 
this case) that the channel has been disconnected using the 
state_change l2cap op, even if no disconnect request is sent to the 
remote device.  This way a new A2MP fixed channel can be started up so 
there is some chance that the two sides of the A2MP ERTM connection 
can sync up again.


> 	if (chan->mode == L2CAP_MODE_ERTM) {
> 		__clear_retrans_timer(chan);
> 		__clear_monitor_timer(chan);
> @@ -1201,6 +1216,11 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
>
> 		l2cap_chan_lock(chan);
>
> +		if (chan->chan_type == L2CAP_CHAN_CONN_FIX_A2MP) {
> +			l2cap_chan_unlock(chan);
> +			continue;
> +		}
> +

This bypasses the socket code in that loop, but also means the state 
change is not sent to the AMP manager.  Is there a way to fix up the 
state change code in l2cap_ops so the socket code can be removed from 
l2cap_conn_ready and other socketless L2CAP channels will also work 
without special case code?

> 		if (conn->hcon->type == LE_LINK) {
> 			if (smp_conn_security(conn, chan->sec_level))
> 				l2cap_chan_ready(chan);
> @@ -1581,7 +1601,8 @@ static void l2cap_monitor_timeout(struct work_struct *work)
> 	l2cap_chan_lock(chan);
>
> 	if (chan->retry_count >= chan->remote_max_tx) {
> -		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
> +		if (chan->chan_type != L2CAP_CHAN_CONN_FIX_A2MP)
> +			l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);

The spec defines the MaxTransmit value as 0xff for the A2MP channel, 
not 0x00 (for infinite retries).  There is therefore an expectation 
that the ERTM connection will reset after too many retries - and I 
don't think it is ok to skip the disconnect here.

> 		l2cap_chan_unlock(chan);
> 		l2cap_chan_put(chan);
> 		return;
> -- 
> 1.7.9.5

Regards,

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

