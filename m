Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Oct 2011 14:41:06 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, ulrik.lauren@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH] Bluetooth: Use miliseconds for L2CAP channel timeouts
Message-ID: <20111019164106.GA10366@joana>
References: <1319027936-24525-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319027936-24525-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

* Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com> [2011-10-19 14:38:56 +0200]:

> Timers set by __set_chan_timer() should use miliseconds instead of
> jiffies. Commit 942ecc9c4643db5ce071562e0a23f99464d6b461 updated
> l2cap_set_timer() so it expects timeout to be specified in msecs
> instead of jiffies. This makes timeouts unreliable when CONFIG_HZ
> is not set to 1000.
> 
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  include/net/bluetooth/l2cap.h |    8 ++++++--
>  net/bluetooth/l2cap_core.c    |   25 +++++++++++++------------
>  2 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index fddc82a..9576b0a 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -45,8 +45,12 @@
>  #define L2CAP_DEFAULT_SDU_ITIME		0xFFFFFFFF
>  #define L2CAP_DEFAULT_ACC_LAT		0xFFFFFFFF
>  
> -#define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
> -#define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
> +#define L2CAP_DISC_SEC_TIMEOUT		(100)
> +#define L2CAP_DISC_OWNED_TIMEOUT	(200)

make these two 100 miliseconds and merge them under L2CAP_DISC_TIMEOUT

> +#define L2CAP_DISC_REJ_TIMEOUT		(5000)  /*  5 seconds */
> +#define L2CAP_ENC_TIMEOUT		(5000)  /*  5 seconds */
> +#define L2CAP_CONN_TIMEOUT		(40000) /* 40 seconds */
> +#define L2CAP_INFO_TIMEOUT		(4000)  /*  4 seconds */
>  
>  /* L2CAP socket address */
>  struct sockaddr_l2 {
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index bda6da7..13aa738 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -252,7 +252,7 @@ static void l2cap_chan_timeout(unsigned long arg)
>  
>  	if (sock_owned_by_user(sk)) {
>  		/* sk is owned by user. Try again later */
> -		__set_chan_timer(chan, HZ / 5);
> +		__set_chan_timer(chan, L2CAP_DISC_OWNED_TIMEOUT);
>  		bh_unlock_sock(sk);
>  		chan_put(chan);
>  		return;
> @@ -444,7 +444,8 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
>  		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
>  					conn->hcon->type == ACL_LINK) {
>  			__clear_chan_timer(chan);
> -			__set_chan_timer(chan, sk->sk_sndtimeo);
> +			__set_chan_timer(chan,
> +					jiffies_to_msecs(sk->sk_sndtimeo));

sk->sk_sndtimeo is already in miliseconds.

	Gustavo
