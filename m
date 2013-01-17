Return-Path: <cyrus@holtmann.org>
Message-ID: <1358431930.3059.16.camel@aeonflux>
Subject: Re: [PATCH 2/5] Bluetooth: Add setsockopt for SCO socket mode
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 17 Jan 2013 06:12:10 -0800
In-Reply-To: <1358426389-25903-3-git-send-email-frederic.dalleau@linux.intel.com>
References: <1358426389-25903-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1358426389-25903-3-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> This patch implements setsockopt().

not acceptable commit message.

> ---
>  net/bluetooth/sco.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index bdb21b2..22ad5fa 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -678,6 +678,47 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
>  	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
>  }
>  
> +static int sco_sock_setsockopt_old(struct socket *sock, int optname,
> +				   char __user *optval, unsigned int optlen)
> +{
> +	struct sock *sk = sock->sk;
> +	struct sco_options opts;
> +	int len, err = 0;
> +
> +	BT_DBG("sk %p", sk);
> +
> +	lock_sock(sk);
> +
> +	switch (optname) {
> +	case SCO_OPTIONS:
> +		if (sk->sk_state != BT_OPEN &&
> +		    sk->sk_state != BT_BOUND &&
> +		    sk->sk_state != BT_CONNECT2) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
> +		opts.mode = SCO_MODE_CVSD;

Don't we need to set a opts.mtu here as well? This is user input. So we
need to be 100% sure to verify it.

Regards

Marcel


