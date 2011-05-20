Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 May 2011 23:43:20 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: David Miller <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: Kill set but unused variable 'cmd' in
 cmtp_recv_capimsg()
Message-ID: <20110520024320.GE4888@joana>
References: <20110519.175005.999414875849956708.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110519.175005.999414875849956708.davem@davemloft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* David Miller <davem@davemloft.net> [2011-05-19 17:50:05 -0400]:

> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
> index 744233c..040f67b 100644
> --- a/net/bluetooth/cmtp/capi.c
> +++ b/net/bluetooth/cmtp/capi.c
> @@ -326,7 +326,7 @@ void cmtp_recv_capimsg(struct cmtp_session *session, struct sk_buff *skb)
>  {
>  	struct capi_ctr *ctrl = &session->ctrl;
>  	struct cmtp_application *application;
> -	__u16 cmd, appl;
> +	__u16 appl;
>  	__u32 contr;
>  
>  	BT_DBG("session %p skb %p len %d", session, skb, skb->len);
> @@ -344,7 +344,6 @@ void cmtp_recv_capimsg(struct cmtp_session *session, struct sk_buff *skb)
>  		return;
>  	}
>  
> -	cmd = CAPICMD(CAPIMSG_COMMAND(skb->data), CAPIMSG_SUBCOMMAND(skb->data));
>  	appl = CAPIMSG_APPID(skb->data);
>  	contr = CAPIMSG_CONTROL(skb->data);

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
