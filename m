Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/9] Bluetooth: Validate PSM values in calls to
 connect() and bind().
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281048867-32630-4-git-send-email-mathewm@codeaurora.org>
References: <1281048867-32630-1-git-send-email-mathewm@codeaurora.org>
	 <1281048867-32630-4-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 08 Aug 2010 22:46:46 -0400
Message-ID: <1281322006.12579.187.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Valid L2CAP PSMs are odd numbers, and the least significant bit of the
> most significant byte must be 0.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index bc10be8..77ba106 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1008,6 +1008,12 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
>  		goto done;
>  	}
>  
> +	/* If specified, PSM must be odd and lsb of upper byte must be 0 */
> +	if (la.l2_psm && (__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001) {
> +		err = -EINVAL;
> +		goto done;
> +	}
> +
>  	if (la.l2_psm && __le16_to_cpu(la.l2_psm) < 0x1001 &&
>  				!capable(CAP_NET_BIND_SERVICE)) {
>  		err = -EACCES;

we might wanna do this a bit nicer here:

	if (la.l2_psm) {
		__u16 psm = __le16_to_cpu(la.l2_psm);

		if ((psm & 0x0101) != 0x0001) {
			err = -EINVAL;
			goto done;
		}

		if (psm < 0x1001 && ...) {
			...
		}
	}

Regards

Marcel


