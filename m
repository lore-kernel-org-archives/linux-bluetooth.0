Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Sep 2010 08:41:12 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext haijun liu <liuhaijun.er@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"dantian.ip" <dantian.ip@gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Remove duplicate code.
Message-ID: <20100921054112.GC17820@null>
References: <AANLkTim_N7sA6NqmNqWsrW2dQmnwkm-NSGuFz191SQCT@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTim_N7sA6NqmNqWsrW2dQmnwkm-NSGuFz191SQCT@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 20, 2010 at 03:26:14AM +0200, ext haijun liu wrote:
> Remove duplicate code, it's already in l2cap_send_disconn_req().
> 
> 
> Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>

Acked-by: Ville Tervo <ville.tervo@nokia.com>

> ---
>  net/bluetooth/l2cap.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 725744b..076d1af 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -3222,7 +3222,6 @@ static inline int l2cap_config_rsp(struct
> l2cap_conn *conn, struct l2cap_cmd_hdr
>  		}
> 
>  	default:
> -		sk->sk_err = ECONNRESET;
>  		l2cap_sock_set_timer(sk, HZ * 5);
>  		l2cap_send_disconn_req(conn, sk, ECONNRESET);
>  		goto done;
> -- 
> 1.6.3.3
> 
> 
> -- 
> Haijun Liu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
