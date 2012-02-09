Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 16:37:59 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv3 02/16] Bluetooth: Revert to mutexes from RCU list
Message-ID: <20120209183759.GC3174@joana>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1328797057-26331-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328797057-26331-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2012-02-09 16:17:23 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Usage of RCU list looks not reasonalbe for a number of reasons:
> our code sleep and we have to use socket spinlocks, some parts
> of code are updaters thus we need to use mutexes anyway.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |  108 ++++++++++++++++++++++----------------------
>  1 files changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 8dfccb3..ae08944 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -77,36 +77,24 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn,
>  
>  static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
>  {
> -	struct l2cap_chan *c, *r = NULL;
> -
> -	rcu_read_lock();
> +	struct l2cap_chan *c;
>  
> -	list_for_each_entry_rcu(c, &conn->chan_l, list) {
> -		if (c->dcid == cid) {
> -			r = c;
> -			break;
> -		}
> +	list_for_each_entry(c, &conn->chan_l, list) {
> +		if (c->dcid == cid)
> +			return c;
>  	}
> -
> -	rcu_read_unlock();
> -	return r;
> +	return NULL;
>  }
>  
>  static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 cid)
>  {
> -	struct l2cap_chan *c, *r = NULL;
> -
> -	rcu_read_lock();
> +	struct l2cap_chan *c;
>  
> -	list_for_each_entry_rcu(c, &conn->chan_l, list) {
> -		if (c->scid == cid) {
> -			r = c;
> -			break;
> -		}
> +	list_for_each_entry(c, &conn->chan_l, list) {
> +		if (c->scid == cid)
> +			return c;
>  	}
> -
> -	rcu_read_unlock();
> -	return r;
> +	return NULL;
>  }
>  
>  /* Find channel with given SCID.
> @@ -115,36 +103,34 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
>  {
>  	struct l2cap_chan *c;
>  
> +	mutex_lock(&conn->chan_lock);
>  	c = __l2cap_get_chan_by_scid(conn, cid);
>  	if (c)
>  		lock_sock(c->sk);
> +	mutex_unlock(&conn->chan_lock);
>  	return c;
>  }
>  
>  static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
>  {
> -	struct l2cap_chan *c, *r = NULL;
> -
> -	rcu_read_lock();
> +	struct l2cap_chan *c;
>  
> -	list_for_each_entry_rcu(c, &conn->chan_l, list) {
> -		if (c->ident == ident) {
> -			r = c;
> -			break;
> -		}
> +	list_for_each_entry(c, &conn->chan_l, list) {
> +		if (c->ident == ident)
> +			return c;
>  	}
> -
> -	rcu_read_unlock();
> -	return r;
> +	return NULL;
>  }
>  
>  static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
>  {
>  	struct l2cap_chan *c;
>  
> +	mutex_lock(&conn->chan_lock);
>  	c = __l2cap_get_chan_by_ident(conn, ident);
>  	if (c)
>  		lock_sock(c->sk);
> +	mutex_unlock(&conn->chan_lock);
>  	return c;
>  }
>  
> @@ -259,6 +245,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
>  
>  	BT_DBG("chan %p state %d", chan, chan->state);
>  
> +	mutex_lock(&chan->conn->chan_lock);
>  	lock_sock(sk);
>  
>  	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
> @@ -272,6 +259,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
>  	l2cap_chan_close(chan, reason);
>  
>  	release_sock(sk);
> +	mutex_unlock(&chan->conn->chan_lock);
>  
>  	chan->ops->close(chan->data);
>  	l2cap_chan_put(chan);
> @@ -357,7 +345,9 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>  
>  	l2cap_chan_hold(chan);
>  
> -	list_add_rcu(&chan->list, &conn->chan_l);
> +	mutex_lock(&conn->chan_lock);
> +	list_add(&chan->list, &conn->chan_l);
> +	mutex_unlock(&conn->chan_lock);

Check the commit that added RCU to our list, I think you are missing to revert
some parts of it.

	Gustavo
