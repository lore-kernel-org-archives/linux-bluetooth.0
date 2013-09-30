Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Sep 2013 12:18:58 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Provide high speed configuration option
Message-ID: <20130930091820.GH10262@aemeltch-MOBL1>
References: <1380514261-21742-3-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380514261-21742-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Sep 29, 2013 at 09:11:01PM -0700, Marcel Holtmann wrote:
> Hiding the Bluetooth high speed support behind a module parameter is
> not really useful. This can be enabled and disabled at runtime via
> the management interface. This also has the advantage that his can

typo here.

...

> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index c85537c..9119898 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -445,11 +445,6 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
>  		break;
>  
>  	case BT_CHANNEL_POLICY:
> -		if (!enable_hs) {
> -			err = -ENOPROTOOPT;
> -			break;
> -		}
> -

Do you think we don't need to check that HS is enabled here and below?

>  		if (put_user(chan->chan_policy, (u32 __user *) optval))
>  			err = -EFAULT;
>  		break;
> @@ -720,11 +715,6 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
>  		break;
>  
>  	case BT_CHANNEL_POLICY:
> -		if (!enable_hs) {
> -			err = -ENOPROTOOPT;
> -			break;
> -		}
> -
>  		if (get_user(opt, (u32 __user *) optval)) {
>  			err = -EFAULT;
>  			break;

...

Best regards 
Andrei Emeltchenko 

