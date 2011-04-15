Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Apr 2011 15:58:45 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: fix shutdown on SCO sockets
Message-ID: <20110415185845.GB2359@joana>
References: <1302271841-12127-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302271841-12127-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-04-08 17:10:41 +0300]:

> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> shutdown should wait for SCO link to be properly disconnected before
> detroying the socket, otherwise an application using the socket may
> assume link is properly disconnected before it really happens which
> can be a problem when e.g synchronizing profile switch.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

I applied it, but in bluetooth-next. Let's see its behaviour there and if no
problems show up we can move it to bluetooth-2.6

> ---
>  net/bluetooth/sco.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 42fdffd..94954c7 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -369,6 +369,15 @@ static void __sco_sock_close(struct sock *sk)
>  
>  	case BT_CONNECTED:
>  	case BT_CONFIG:
> +		if (sco_pi(sk)->conn) {
> +			sk->sk_state = BT_DISCONN;
> +			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
> +			hci_conn_put(sco_pi(sk)->conn->hcon);
> +			sco_pi(sk)->conn = NULL;
> +		} else
> +			sco_chan_del(sk, ECONNRESET);
> +		break;
> +
>  	case BT_CONNECT:
>  	case BT_DISCONN:
>  		sco_chan_del(sk, ECONNRESET);
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://profusion.mobi
