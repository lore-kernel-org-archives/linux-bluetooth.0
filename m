Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 10:52:46 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix socket not getting freed if l2cap channel
 create fails
Message-ID: <20120719075239.GC26057@aemeltch-MOBL1>
References: <1342682644-24964-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342682644-24964-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Jul 19, 2012 at 12:54:04PM +0530, Jaganath Kanakkassery wrote:
> If l2cap_chan_create() fails then it will return from l2cap_sock_kill
> since zapped flag of sk is reset.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
>  net/bluetooth/l2cap_sock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 79350d1..419857d 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1174,7 +1174,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int p
>  
>  	chan = l2cap_chan_create();
>  	if (!chan) {
> -		l2cap_sock_kill(sk);
> +		sk_free(sk);

Could you consider using sock_put which will call sk_free,
maybe we need to add also sock_orphan?

Best regards 
Andrei Emeltchenko 

>  		return NULL;
>  	}
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
