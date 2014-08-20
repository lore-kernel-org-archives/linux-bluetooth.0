Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/bluetooth: Fix bdaddr_type in pairing scenario
Date: Wed, 20 Aug 2014 12:02:58 +0200
Message-ID: <1458383.xlqSA2177C@leonov>
In-Reply-To: <1408522224-27670-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1408522224-27670-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Wednesday 20 of August 2014 10:10:23 Lukasz Rymanowski wrote:
> With this patch correct bdaddr type is used in ssp pairing scenario
> ---
>  android/bluetooth.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 64a7696..59dd047 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -4500,11 +4500,13 @@ static void handle_ssp_reply_cmd(const void *buf,
> uint16_t len) switch (cmd->ssp_variant) {
>  	case HAL_SSP_VARIANT_CONFIRM:
>  	case HAL_SSP_VARIANT_CONSENT:
> -		status = user_confirm_reply(&dev->bdaddr, dev->bdaddr_type,
> -								cmd->accept);
> +		status = user_confirm_reply(&dev->bdaddr,
> +						select_device_bearer(dev),
> +						cmd->accept);
>  		break;
>  	case HAL_SSP_VARIANT_ENTRY:
> -		status = user_passkey_reply(&dev->bdaddr, dev->bdaddr_type,
> +		status = user_passkey_reply(&dev->bdaddr,
> +						select_device_bearer(dev),
>  						cmd->accept, cmd->passkey);
>  		break;
>  	case HAL_SSP_VARIANT_NOTIF:

Both patches applied, thanks.

-- 
BR
Szymon Janc
