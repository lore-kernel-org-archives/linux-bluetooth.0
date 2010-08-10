Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/5] Bluetooth: Validate PSM values in calls to
 connect() and bind().
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281466850-5297-3-git-send-email-mathewm@codeaurora.org>
References: <1281466850-5297-1-git-send-email-mathewm@codeaurora.org>
	 <1281466850-5297-3-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 17:21:10 -0400
Message-ID: <1281475270.12579.223.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Valid L2CAP PSMs are odd numbers, and the least significant bit of the
> most significant byte must be 0.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   23 +++++++++++++++++++----
>  1 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index c784703..61aa961 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1008,10 +1008,19 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
>  		goto done;
>  	}
>  
> -	if (la.l2_psm && __le16_to_cpu(la.l2_psm) < 0x1001 &&
> -				!capable(CAP_NET_BIND_SERVICE)) {
> -		err = -EACCES;
> -		goto done;
> +	/* If specified, PSM must be odd and lsb of upper byte must be 0 */
> +	if (la.l2_psm) {
> +		__u16 psm = __le16_to_cpu(la.l2_psm);
> +

I would just put the comment here:

                  /* PSM must be odd and lsb of upper byte must be 0 */
> +		if ((psm & 0x0101) != 0x0001) {
> +			err = -EINVAL;
> +			goto done;
> +		}

And then while you at it:

                  /* Restrict usage of well known PSMs */
> +		if (psm < 0x1001 && !capable(CAP_NET_BIND_SERVICE)) {
> +			err = -EACCES;
> +			goto done;
> +		}
>  	}

Maybe there is actually a second place for adding that comment.

Otherwise I am fine with this, but since it is not a regression, this
will be only taking in the next tree.

Regards

Marcel


