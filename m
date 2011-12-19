Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Dec 2011 12:42:57 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 19/22] Bluetooth: Change l2cap chan_list to use RCU
Message-ID: <20111219104254.GC3982@aemeltch-MOBL1>
References: <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-16-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-17-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-18-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-19-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-20-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324157382-1815-20-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sat, Dec 17, 2011 at 07:29:39PM -0200, Gustavo F. Padovan wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> 
> This list has much more reads than writes, so RCU makes senses here, also
> it avoid deadlock against the socket lock.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/l2cap_core.c |  117 +++++++++++++++++++++----------------------
>  1 files changed, 57 insertions(+), 60 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d616519..a212295 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -89,24 +89,36 @@ static inline void chan_put(struct l2cap_chan *c)
>  
>  static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
>  {
> -	struct l2cap_chan *c;
> +	struct l2cap_chan *c, *r = NULL;
>  
> -	list_for_each_entry(c, &conn->chan_l, list) {
> -		if (c->dcid == cid)
> -			return c;
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(c, &conn->chan_l, list) {
> +		if (c->dcid == cid) {
> +			r = c;
> +			break;
> +		}
>  	}
> +
> +	rcu_read_unlock();
>  	return NULL;
>  }
>  
>  static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 cid)
>  {
> -	struct l2cap_chan *c;
> +	struct l2cap_chan *c, *r = NULL;
>  
> -	list_for_each_entry(c, &conn->chan_l, list) {
> -		if (c->scid == cid)
> -			return c;
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(c, &conn->chan_l, list) {
> +		if (c->scid == cid) {
> +			r = c;
> +			break;
> +		}
>  	}
> -	return NULL;
> +
> +	rcu_read_unlock();
> +	return r;
>  }
>  
>  /* Find channel with given SCID.
> @@ -115,34 +127,36 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
>  {
>  	struct l2cap_chan *c;
>  
> -	mutex_lock(&conn->chan_lock);
>  	c = __l2cap_get_chan_by_scid(conn, cid);
>  	if (c)
>  		lock_sock(c->sk);
> -	mutex_unlock(&conn->chan_lock);
>  	return c;
>  }
>  
>  static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
>  {
> -	struct l2cap_chan *c;
> +	struct l2cap_chan *c, *r = NULL;
>  
> -	list_for_each_entry(c, &conn->chan_l, list) {
> -		if (c->ident == ident)
> -			return c;
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(c, &conn->chan_l, list) {
> +		if (c->ident == ident) {
> +			r = c;
> +			break;
> +		}
>  	}
> -	return NULL;
> +
> +	rcu_read_unlock();
> +	return r;
>  }
>  
>  static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
>  {
>  	struct l2cap_chan *c;
>  
> -	mutex_lock(&conn->chan_lock);
>  	c = __l2cap_get_chan_by_ident(conn, ident);
>  	if (c)
>  		lock_sock(c->sk);
> -	mutex_unlock(&conn->chan_lock);
>  	return c;
>  }
>  
> @@ -323,7 +337,7 @@ void l2cap_chan_destroy(struct l2cap_chan *chan)
>  	chan_put(chan);
>  }
>  
> -static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> +static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>  {
>  	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
>  			chan->psm, chan->dcid);
> @@ -364,7 +378,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>  
>  	chan_hold(chan);
>  
> -	list_add(&chan->list, &conn->chan_l);
> +	list_add_rcu(&chan->list, &conn->chan_l);
>  }
>  
>  /* Delete channel.
> @@ -381,9 +395,9 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
>  
>  	if (conn) {
>  		/* Delete from channel list */
> -		mutex_lock(&conn->chan_lock);
> -		list_del(&chan->list);
> -		mutex_unlock(&conn->chan_lock);
> +		list_del_rcu(&chan->list);
> +		synchronize_rcu();
> +
>  		chan_put(chan);
>  
>  		chan->conn = NULL;
> @@ -750,13 +764,13 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
>  /* ---- L2CAP connections ---- */
>  static void l2cap_conn_start(struct l2cap_conn *conn)
>  {
> -	struct l2cap_chan *chan, *tmp;
> +	struct l2cap_chan *chan;
>  
>  	BT_DBG("conn %p", conn);
>  
> -	mutex_lock(&conn->chan_lock);
> +	rcu_read_lock();
>  
> -	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
> +	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
>  		struct sock *sk = chan->sk;
>  
>  		bh_lock_sock(sk);
> @@ -780,9 +794,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>  					&chan->conf_state)) {
>  				/* l2cap_chan_close() calls list_del(chan)
>  				 * so release the lock */
> -				mutex_unlock(&conn->chan_lock);
>  				l2cap_chan_close(chan, ECONNRESET);
> -				utex_lock(&conn->chan_lock);

OK, I see why this works. BTW: IMO the mutex and rcu patches shall be
amended, otherwise we do unneeded work of implementing mutexes and then
changing them to RCU.

Best regards 
Andrei Emeltchenko 

>  				bh_unlock_sock(sk);
>  				continue;
>  			}
> @@ -838,7 +850,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>  		bh_unlock_sock(sk);
>  	}
>  
> -	mutex_unlock(&conn->chan_lock);
> +	rcu_read_unlock();
>  }
>  
>  /* Find socket with cid and source bdaddr.
> @@ -903,8 +915,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
>  
>  	sk = chan->sk;
>  
> -	mutex_lock(&conn->chan_lock);
> -
>  	hci_conn_hold(conn->hcon);
>  
>  	bacpy(&bt_sk(sk)->src, conn->src);
> @@ -912,15 +922,13 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
>  
>  	bt_accept_enqueue(parent, sk);
>  
> -	__l2cap_chan_add(conn, chan);
> +	l2cap_chan_add(conn, chan);
>  
>  	__set_chan_timer(chan, sk->sk_sndtimeo);
>  
>  	l2cap_state_change(chan, BT_CONNECTED);
>  	parent->sk_data_ready(parent, 0);
>  
> -	mutex_unlock(&conn->chan_lock);
> -
>  clean:
>  	release_sock(parent);
>  }
> @@ -954,9 +962,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
>  	if (conn->hcon->out && conn->hcon->type == LE_LINK)
>  		smp_conn_security(conn, conn->hcon->pending_sec_level);
>  
> -	mutex_lock(&conn->chan_lock);
> +	rcu_read_lock();
>  
> -	list_for_each_entry(chan, &conn->chan_l, list) {
> +	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
>  		struct sock *sk = chan->sk;
>  
>  		bh_lock_sock(sk);
> @@ -976,7 +984,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
>  		bh_unlock_sock(sk);
>  	}
>  
> -	mutex_unlock(&conn->chan_lock);
> +	rcu_read_unlock();
>  }
>  
>  /* Notify sockets that we cannot guaranty reliability anymore */
> @@ -986,16 +994,16 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
>  
>  	BT_DBG("conn %p", conn);
>  
> -	mutex_lock(&conn->chan_lock);
> +	rcu_read_lock();
>  
> -	list_for_each_entry(chan, &conn->chan_l, list) {
> +	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
>  		struct sock *sk = chan->sk;
>  
>  		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
>  			sk->sk_err = err;
>  	}
>  
> -	mutex_unlock(&conn->chan_lock);
> +	rcu_read_unlock();
>  }
>  
>  static void l2cap_info_timeout(struct work_struct *work)
> @@ -1087,7 +1095,6 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
>  	conn->feat_mask = 0;
>  
>  	spin_lock_init(&conn->lock);
> -	mutex_init(&conn->chan_lock);
>  
>  	INIT_LIST_HEAD(&conn->chan_l);
>  
> @@ -1102,13 +1109,6 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
>  	return conn;
>  }
>  
> -static inline void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
> -{
> -	mutex_lock(&conn->chan_lock);
> -	__l2cap_chan_add(conn, chan);
> -	mutex_unlock(&conn->chan_lock);
> -}
> -
>  /* ---- Socket interface ---- */
>  
>  /* Find socket with psm and source bdaddr.
> @@ -1825,8 +1825,9 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
>  
>  	BT_DBG("conn %p", conn);
>  
> -	mutex_lock(&conn->chan_lock);
> -	list_for_each_entry(chan, &conn->chan_l, list) {
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
>  		struct sock *sk = chan->sk;
>  		if (chan->chan_type != L2CAP_CHAN_RAW)
>  			continue;
> @@ -1841,7 +1842,8 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
>  		if (chan->ops->recv(chan->data, nskb))
>  			kfree_skb(nskb);
>  	}
> -	mutex_unlock(&conn->chan_lock);
> +
> +	rcu_read_unlock();
>  }
>  
>  /* ---- L2CAP signalling commands ---- */
> @@ -2641,11 +2643,8 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
>  
>  	sk = chan->sk;
>  
> -	mutex_lock(&conn->chan_lock);
> -
>  	/* Check if we already have channel with that dcid */
>  	if (__l2cap_get_chan_by_dcid(conn, scid)) {
> -		mutex_unlock(&conn->chan_lock);
>  		sock_set_flag(sk, SOCK_ZAPPED);
>  		chan->ops->close(chan->data);
>  		goto response;
> @@ -2660,7 +2659,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
>  
>  	bt_accept_enqueue(parent, sk);
>  
> -	__l2cap_chan_add(conn, chan);
> +	l2cap_chan_add(conn, chan);
>  
>  	dcid = chan->scid;
>  
> @@ -2691,8 +2690,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
>  		status = L2CAP_CS_NO_INFO;
>  	}
>  
> -	mutex_unlock(&conn->chan_lock);
> -
>  response:
>  	release_sock(parent);
>  
> @@ -4528,9 +4525,9 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  		del_timer(&conn->security_timer);
>  	}
>  
> -	mutex_lock(&conn->chan_lock);
> +	rcu_read_lock();
>  
> -	list_for_each_entry(chan, &conn->chan_l, list) {
> +	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
>  		struct sock *sk = chan->sk;
>  
>  		bh_lock_sock(sk);
> @@ -4608,7 +4605,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
>  		bh_unlock_sock(sk);
>  	}
>  
> -	mutex_unlock(&conn->chan_lock);
> +	rcu_read_unlock();
>  
>  	return 0;
>  }
> -- 
> 1.7.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
