Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/8] Bluetooth:  Validate PSM values in calls to
 connect() and bind().
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1280776810-18213-4-git-send-email-mathewm@codeaurora.org>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
	 <1280776810-18213-4-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 12:39:51 -0700
Message-ID: <1280777991.12579.39.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index aed72f2..44bc6ee 100644
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

this was a nice feature of L2CAP in BlueZ actually ;)

I am fine with forbidding this. However, please send a patch that fixes
l2test's default PSM first. Otherwise you gonna break that one.

Regards

Marcel


