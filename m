Return-Path: <cyrus@holtmann.org>
Message-ID: <1323901060.1965.68.camel@aeonflux>
Subject: Re: [PATCH 7/7] Bluetooth: Use correct struct for
 user_confirm_neg_reply
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Dec 2011 23:17:40 +0100
In-Reply-To: <1323899524-13653-8-git-send-email-johan.hedberg@gmail.com>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
	 <1323899524-13653-8-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes user_confirm_neg_reply to use the appropriate struct
> for accessing the call parameters.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 4d531b9..054229f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1690,7 +1690,7 @@ static int user_confirm_reply(struct sock *sk, u16 index, void *data, u16 len)
>  static int user_confirm_neg_reply(struct sock *sk, u16 index, void *data,
>  									u16 len)
>  {
> -	struct mgmt_cp_user_confirm_reply *cp = (void *) data;
> +	struct mgmt_cp_user_confirm_neg_reply *cp = (void *) data;

the cast here seems pointless. Just remove that altogether. Otherwise
fine with me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


