Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 10:36:54 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Gustavo Padovan <gustavo@padovan.org>
cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 2/3] Bluetooth: Move bt_accept_enqueue() call to
 l2cap_sock.c
In-Reply-To: <1337839374-20443-2-git-send-email-gustavo@padovan.org>
Message-ID: <alpine.DEB.2.02.1205241028300.18142@mathewm-linux>
References: <1337821964-4618-9-git-send-email-gustavo@padovan.org> <1337839374-20443-1-git-send-email-gustavo@padovan.org> <1337839374-20443-2-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



On Thu, 24 May 2012, Gustavo Padovan wrote:

> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> bt_accept_enqueue() can be easily placed at the end of
> l2cap_sock_new_connection_cb().
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
> net/bluetooth/l2cap_core.c |    4 ----
> net/bluetooth/l2cap_sock.c |    2 ++
> 2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c9de4f5..5ff294f9 100644
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

Can you explain in the commit message why it is ok to move 
bt_accept_enqueue before the other initialization code in 
l2cap_connect_req?  It looks like some important setup happens there, 
but maybe the parent socket lock keeps things serialized.

> 	__l2cap_chan_add(conn, chan);
>
> 	dcid = chan->scid;
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index d2a81f1..f4c3e2c 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -915,6 +915,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
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



--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
