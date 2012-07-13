Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Jul 2012 11:49:01 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, s.syam@samsung.com
Subject: Re: [PATCH] Bluetooth: Free the l2cap channel list only when
 refcount is zero
Message-ID: <20120713084859.GC2729@aemeltch-MOBL1>
References: <1342165923-4901-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342165923-4901-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Fri, Jul 13, 2012 at 01:22:03PM +0530, Jaganath Kanakkassery wrote:
> Move the l2cap channel list chan->global_l under the refcnt
> protection and free it based on the refcnt.

The idea is good.

> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
>  include/net/bluetooth/l2cap.h |    5 +++--
>  net/bluetooth/a2mp.c          |    2 +-
>  net/bluetooth/l2cap_core.c    |    4 +++-
>  net/bluetooth/l2cap_sock.c    |    2 +-
>  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index e5164ff..4c0dcba 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -670,6 +670,8 @@ enum {
>  	L2CAP_EV_RECV_FRAME,
>  };
>  
> +void l2cap_chan_destroy(struct l2cap_chan *chan);
> +

What I think is that l2cap_chan_destroy shall be static if it is used only
inside l2cap_chan_put. Then l2cap_chan_hold/put shall be moved to
l2cap_core or l2cap_chan_destroy moved to header. First is better IMO.

>  static inline void l2cap_chan_hold(struct l2cap_chan *c)
>  {
>  	BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
> @@ -682,7 +684,7 @@ static inline void l2cap_chan_put(struct l2cap_chan *c)
>  	BT_DBG("chan %p orig refcnt %d", c, atomic_read(&c->refcnt));
>  
>  	if (atomic_dec_and_test(&c->refcnt))
> -		kfree(c);
> +		l2cap_chan_destroy(c);

It does make sense to use kref mechanism here.

Best regards 
Andrei Emeltchenko 

>  }
>  
>  static inline void l2cap_chan_lock(struct l2cap_chan *chan)
> @@ -770,7 +772,6 @@ int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
>  
>  struct l2cap_chan *l2cap_chan_create(void);
>  void l2cap_chan_close(struct l2cap_chan *chan, int reason);
> -void l2cap_chan_destroy(struct l2cap_chan *chan);
>  int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
>  		       bdaddr_t *dst, u8 dst_type);
>  int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index 4ff0bf3..cf16a7c 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -412,7 +412,7 @@ static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
>  
>  static void a2mp_chan_close_cb(struct l2cap_chan *chan)
>  {
> -	l2cap_chan_destroy(chan);
> +	l2cap_chan_put(chan);
>  }
>  
>  static void a2mp_chan_state_change_cb(struct l2cap_chan *chan, int state)
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 9fd0599..8718a22 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -418,11 +418,13 @@ struct l2cap_chan *l2cap_chan_create(void)
>  
>  void l2cap_chan_destroy(struct l2cap_chan *chan)
>  {
> +	BT_DBG("chan %p", chan);
> +
>  	write_lock(&chan_list_lock);
>  	list_del(&chan->global_l);
>  	write_unlock(&chan_list_lock);
>  
> -	l2cap_chan_put(chan);
> +	kfree(chan);
>  }
>  
>  void l2cap_chan_set_defaults(struct l2cap_chan *chan)
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index a4bb27e..79350d1 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -823,7 +823,7 @@ static void l2cap_sock_kill(struct sock *sk)
>  
>  	/* Kill poor orphan */
>  
> -	l2cap_chan_destroy(l2cap_pi(sk)->chan);
> +	l2cap_chan_put(l2cap_pi(sk)->chan);
>  	sock_set_flag(sk, SOCK_DEAD);
>  	sock_put(sk);
>  }
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
