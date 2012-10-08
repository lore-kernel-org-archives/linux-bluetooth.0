Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Oct 2012 10:56:05 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH 4/8] Bluetooth: Add chan->ops->defer()
Message-ID: <20121008075603.GC2456@aemeltch-MOBL1>
References: <1349651981-6251-1-git-send-email-gustavo@padovan.org>
 <1349651981-6251-4-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349651981-6251-4-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Oct 08, 2012 at 07:19:37AM +0800, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> When DEFER_SETUP is set defer() will trigger an authorization
> request to the userspace.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 10 +++-------
>  net/bluetooth/l2cap_sock.c    | 13 +++++++++++++
>  3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 7002f0d..eef7146 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -540,6 +540,7 @@ struct l2cap_ops {
>  	void			(*state_change) (struct l2cap_chan *chan,
>  						 int state);
>  	void			(*ready) (struct l2cap_chan *chan);
> +	void			(*defer) (struct l2cap_chan *chan);
>  	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
>  					       unsigned long len, int nb);
>  };
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 9e166ce..02a66fb 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1123,11 +1123,9 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>  				lock_sock(sk);
>  				if (test_bit(BT_SK_DEFER_SETUP,
>  					     &bt_sk(sk)->flags)) {
> -					struct sock *parent = bt_sk(sk)->parent;
>  					rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
>  					rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
> -					if (parent)
> -						parent->sk_data_ready(parent, 0);
> +					chan->ops->defer(chan);
>  
>  				} else {
>  					__l2cap_state_change(chan, BT_CONFIG);
> @@ -3459,7 +3457,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn,
>  				__l2cap_state_change(chan, BT_CONNECT2);
>  				result = L2CAP_CR_PEND;
>  				status = L2CAP_CS_AUTHOR_PEND;
> -				parent->sk_data_ready(parent, 0);
> +				chan->ops->defer(chan);
>  			} else {
>  				__l2cap_state_change(chan, BT_CONFIG);
>  				result = L2CAP_CR_SUCCESS;
> @@ -5520,11 +5518,9 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  			if (!status) {
>  				if (test_bit(BT_SK_DEFER_SETUP,
>  					     &bt_sk(sk)->flags)) {
> -					struct sock *parent = bt_sk(sk)->parent;
>  					res = L2CAP_CR_PEND;
>  					stat = L2CAP_CS_AUTHOR_PEND;
> -					if (parent)
> -						parent->sk_data_ready(parent, 0);
> +					chan->ops->defer(chan);
>  				} else {
>  					__l2cap_state_change(chan, BT_CONFIG);
>  					res = L2CAP_CR_SUCCESS;
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 0feb8f8..f0e4410 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -955,6 +955,7 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
>  
>  	bt_accept_enqueue(parent, sk);
>  
> +
>  	release_sock(parent);
>  
>  	return l2cap_pi(sk)->chan;
> @@ -1087,6 +1088,17 @@ static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
>  	release_sock(sk);
>  }
>  
> +static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
> +{
> +	struct sock *sk = chan->data;
> +	struct sock *parent;
> +
> +	parent = bt_sk(sk)->parent;
> +
> +	if (parent)
> +		parent->sk_data_ready(parent, 0);
> +}
> +
>  static struct l2cap_ops l2cap_chan_ops = {
>  	.name		= "L2CAP Socket Interface",
>  	.new_connection	= l2cap_sock_new_connection_cb,
> @@ -1095,6 +1107,7 @@ static struct l2cap_ops l2cap_chan_ops = {
>  	.teardown	= l2cap_sock_teardown_cb,
>  	.state_change	= l2cap_sock_state_change_cb,
>  	.ready		= l2cap_sock_ready_cb,
> +	.defer		= l2cap_sock_defer_cb,
>  	.alloc_skb	= l2cap_sock_alloc_skb_cb,
>  };

I think we might add just in case no_defer in  a2mp_chan_ops

Best regards 
Andrei Emeltchenko 

