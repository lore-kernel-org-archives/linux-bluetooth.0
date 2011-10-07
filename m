Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Oct 2011 15:22:14 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: convert flushable variable to flag in
 l2cap chan
Message-ID: <20111007182214.GA2695@joana>
References: <1317995646-11174-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317995646-11174-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-10-07 16:54:03 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> flushable variable inside l2cap_chan is a logical one and can
> be easily converted to flag. Added flags in l2cap_chan structure.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    7 ++++++-
>  net/bluetooth/l2cap_core.c    |    3 ++-
>  net/bluetooth/l2cap_sock.c    |   15 ++++++++++-----
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 2933767..0fe5d59 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -326,7 +326,6 @@ struct l2cap_chan {
>  	__u8		sec_level;
>  	__u8		role_switch;
>  	__u8		force_reliable;
> -	__u8		flushable;
>  	__u8		force_active;
>  
>  	__u8		ident;
> @@ -346,6 +345,7 @@ struct l2cap_chan {
>  
>  	unsigned long	conf_state;
>  	unsigned long	conn_state;
> +	unsigned long	flags;
>  
>  	__u8		next_tx_seq;
>  	__u8		expected_ack_seq;
> @@ -463,6 +463,11 @@ enum {
>  	CONN_RNR_SENT,
>  };
>  
> +/* Definitions for flags in l2cap_chan */
> +enum {
> +	FLAG_FLUSHABLE,
> +};
> +
>  #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
>  #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
>  #define __set_retrans_timer(c) l2cap_set_timer(c, &c->retrans_timer, \
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 3158cec..b21ecff 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1253,7 +1253,8 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
>  
>  	BT_DBG("chan %p, skb %p len %d", chan, skb, skb->len);
>  
> -	if (!chan->flushable && lmp_no_flush_capable(hcon->hdev))
> +	if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
> +					lmp_no_flush_capable(hcon->hdev))
>  		flags = ACL_START_NO_FLUSH;
>  	else
>  		flags = ACL_START;
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 61f1f62..81fc8f0 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -446,14 +446,15 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
>  		break;
>  
>  	case BT_FLUSHABLE:
> -		if (put_user(chan->flushable, (u32 __user *) optval))
> +		if (put_user(test_bit(FLAG_FLUSHABLE, &chan->flags),
> +						(u32 __user *) optval))
>  			err = -EFAULT;
>  
>  		break;
>  
>  	case BT_POWER:
>  		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM
> -				&& sk->sk_type != SOCK_RAW) {
> +						&& sk->sk_type != SOCK_RAW) {

This change doesn't belong to this patch. Please fix this and resend.

	Gustavo
