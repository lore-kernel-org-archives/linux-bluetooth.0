Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jun 2012 10:12:21 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix checking the wrong flag when accepting a
 socket
Message-ID: <20120601071220.GC3009@aemeltch-MOBL1>
References: <1338515619-7448-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338515619-7448-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius

On Thu, May 31, 2012 at 10:53:39PM -0300, Vinicius Costa Gomes wrote:
> Most probably a typo, the check should have been for BT_SK_DEFER_SETUP
> instead of BT_DEFER_SETUP (which right now only represents a socket
> option).
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Good catch, this was recently introduced by commit c5daa683

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

> ---
>  net/bluetooth/af_bluetooth.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 2517472..f7db579 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -199,7 +199,7 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
>  		}
>  
>  		if (sk->sk_state == BT_CONNECTED || !newsock ||
> -		    test_bit(BT_DEFER_SETUP, &bt_sk(parent)->flags)) {
> +		    test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags)) {
>  			bt_accept_unlink(sk);
>  			if (newsock)
>  				sock_graft(sk, newsock);
> -- 
> 1.7.10.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
