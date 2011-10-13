Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/9] Bluetooth: Get/set AMP policy socket option
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, andrei.emeltchenko@intel.com
Date: Thu, 13 Oct 2011 15:35:53 -0700
In-Reply-To: <1318543247-27130-4-git-send-email-mathewm@codeaurora.org>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
	 <1318543247-27130-4-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318545356.15441.39.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Checks for valid policy value and L2CAP mode.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_sock.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 836d12e..9431e38 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -467,6 +467,11 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
>  
>  		break;
>  
> +	case BT_AMP_POLICY:
> +		if (put_user(chan->amp_policy, (u32 __user *) optval))
> +			err = -EFAULT;

I prefer to not just add such an option just yet. We only want to add
socket option once they are functional. Otherwise we have problems to
detect if such an option is working or not. So enabling this option
should be the last patch after we have AMP implemented.

Regards

Marcel


