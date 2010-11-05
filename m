Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Nov 2010 15:49:35 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: "ext Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/7] Bluetooth: Hold the lock inside
 l2cap_get_sock_by_addr()
Message-ID: <20101105134935.GD19903@null>
References: <1288710198-6108-1-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288710198-6108-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Nov 02, 2010 at 04:03:12PM +0100, ext Gustavo F. Padovan wrote:
> It also have to change the name of the function to
> l2cap_get_sock_by_addr() because we do hold the lock inside it now.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/l2cap.c |   17 ++++++-----------
>  1 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 6f931cc..3d48867 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -728,15 +728,18 @@ static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, stru
>  }
>  
>  /* ---- Socket interface ---- */
> -static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
> +static struct sock *l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
>  {
>  	struct sock *sk;
>  	struct hlist_node *node;
> +
> +	write_lock_bh(&l2cap_sk_list.lock);

Code is only reading so read_lock_bh would be enough?

>
>  	sk_for_each(sk, node, &l2cap_sk_list.head)
>  		if (l2cap_pi(sk)->sport == psm && !bacmp(&bt_sk(sk)->src, src))
>  			goto found;
>  	sk = NULL;
>  found:
> +	write_unlock_bh(&l2cap_sk_list.lock);
>  	return sk;
>  }
>  
> @@ -1024,9 +1027,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
>  		}
>  	}
>  
> -	write_lock_bh(&l2cap_sk_list.lock);
> -
> -	if (la.l2_psm && __l2cap_get_sock_by_addr(la.l2_psm, &la.l2_bdaddr)) {
> +	if (la.l2_psm && l2cap_get_sock_by_addr(la.l2_psm, &la.l2_bdaddr)) {
>  		err = -EADDRINUSE;
>  	} else {
>  		/* Save source address */
> @@ -1040,8 +1041,6 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
>  			l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
>  	}
>  
> -	write_unlock_bh(&l2cap_sk_list.lock);
> -
>  done:
>  	release_sock(sk);
>  	return err;
> @@ -1257,18 +1256,14 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
>  
>  		err = -EINVAL;
>  
> -		write_lock_bh(&l2cap_sk_list.lock);
> -
>  		for (psm = 0x1001; psm < 0x1100; psm += 2)
> -			if (!__l2cap_get_sock_by_addr(cpu_to_le16(psm), src)) {
> +			if (!l2cap_get_sock_by_addr(cpu_to_le16(psm), src)) {
>  				l2cap_pi(sk)->psm   = cpu_to_le16(psm);
>  				l2cap_pi(sk)->sport = cpu_to_le16(psm);
>  				err = 0;
>  				break;
>  			}
>  
> -		write_unlock_bh(&l2cap_sk_list.lock);
> -
>  		if (err < 0)
>  			goto done;
>  	}
> -- 
> 1.7.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
