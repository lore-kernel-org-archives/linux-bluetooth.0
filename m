Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 1/4] android/hal-msg: Add defines of HAL_GATT_AUTHENTICATION values
Date: Wed, 18 Jun 2014 15:36:37 +0200
Message-ID: <2155679.I4XT9HXyCq@uw000953>
In-Reply-To: <1403082499-2349-1-git-send-email-marcin.kraglak@tieto.com>
References: <1403082499-2349-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wednesday 18 of June 2014 11:08:16 Marcin Kraglak wrote:
> These values are are used in read characteristic/write characteristic
> functions in gatt_client.
> ---
>  android/hal-msg.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 2c21a85..57872c6 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -1610,3 +1610,7 @@ struct hal_ev_gatt_server_rsp_confirmation {
>  #define HAL_GATT_PERMISSION_WRITE_ENCRYPTED_MITM	0x0040
>  #define HAL_GATT_PERMISSION_WRITE_SIGNED		0x0080
>  #define HAL_GATT_PERMISSION_WRITE_SIGNED_MITM		0x0100
> +
> +#define HAL_GATT_AUTHENTICATION_NONE		0
> +#define HAL_GATT_AUTHENTICATION_NO_MITM		1
> +#define HAL_GATT_AUTHENTICATION_MITM		2
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
