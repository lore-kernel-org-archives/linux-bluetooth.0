Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 09:18:15 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v2 10/12] Bluetooth: Move bt_accept_enqueue() call to
 l2cap_sock.c
In-Reply-To: <1337949064-26187-11-git-send-email-gustavo@padovan.org>
Message-ID: <alpine.DEB.2.02.1205250841550.2070@mathewm-linux>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org> <1337949064-26187-11-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Fri, 25 May 2012, Gustavo Padovan wrote:

> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> bt_accept_enqueue() can be easily placed at the end of
> l2cap_sock_new_connection_cb().
> There is no problem in moving to bt_accept_enqueue() to an earlier point
> in the code, bt_accept_enqueue() only the sk to the it parents queue
> basically.

"only adds the sk to its parent's queue"?

> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
> net/bluetooth/l2cap_core.c |    4 ----
> net/bluetooth/l2cap_sock.c |    2 ++
> 2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index e53a8f9..d34d662 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1165,8 +1165,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
> 	bacpy(&bt_sk(sk)->src, conn->src);
> 	bacpy(&bt_sk(sk)->dst, conn->dst);
>
> -	bt_accept_enqueue(parent, sk);
> -
> 	l2cap_chan_add(conn, chan);
>
> 	l2cap_chan_ready(chan);
> @@ -3357,8 +3355,6 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
> 	chan->psm  = psm;
> 	chan->dcid = scid;
>
> -	bt_accept_enqueue(parent, sk);
> -
> 	__l2cap_chan_add(conn, chan);
>
> 	dcid = chan->scid;
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index b19366c..27158f2 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -914,6 +914,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
>
> 	l2cap_sock_init(sk, parent);
>
> +	bt_accept_enqueue(parent, sk);
> +
> 	return l2cap_pi(sk)->chan;
> }
>
> -- 
> 1.7.10.1

Other than that, looks good!


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

