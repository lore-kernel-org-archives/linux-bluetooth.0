Return-Path: <cyrus@holtmann.org>
Message-ID: <1336320833.5970.84.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: report the right security level in
 getsockopt
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 06 May 2012 09:13:53 -0700
In-Reply-To: <1336096794-16993-2-git-send-email-gustavo@padovan.org>
References: <1336096794-16993-1-git-send-email-gustavo@padovan.org>
	 <1336096794-16993-2-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> During a security level elevation we need to keep track of the current
> security level of a connection until the new one is not confirmed.
> 
> Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_sock.c    |    6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 92c0423..ff34be7 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -446,6 +446,7 @@ struct l2cap_chan {
>  	__le16		sport;
>  
>  	__u8		sec_level;
> +	__u8		current_sl;

this name is not good. Call it active_sec_level or cur_sec_level.

>  
>  	__u8		ident;
>  
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 7e3386f..8f59fa6 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -379,7 +379,10 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
>  		}
>  
>  		memset(&sec, 0, sizeof(sec));
> -		sec.level = chan->sec_level;
> +		if (bt_sk(sk)->suspended)
> +			sec.level = chan->current_sl;
> +		else
> +			sec.level = chan->sec_level;

I think getsockopt should just return the actual current active security
level.

And why are we not accessing this via chan->conn->hcon->sec_level and
its pending_sec_level variables.

>  
>  		if (sk->sk_state == BT_CONNECTED)
>  			sec.key_size = chan->conn->hcon->enc_key_size;
> @@ -577,6 +580,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
>  			break;
>  		}
>  
> +		chan->current_sl = chan->sec_level;
>  		chan->sec_level = sec.level;
>  
>  		if (!chan->conn)

Regards

Marcel


