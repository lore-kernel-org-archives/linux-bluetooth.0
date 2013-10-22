Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Oct 2013 10:03:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Add missing HAL IPC error status definitions
Message-ID: <20131022070314.GA9473@x220.p-661hnu-f1>
References: <1382424852-8049-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382424852-8049-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Oct 22, 2013, Szymon Janc wrote:
> ---
>  android/hal-msg.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/android/hal-msg.h b/android/hal-msg.h
> index 1f77586..7d91ed1 100644
> --- a/android/hal-msg.h
> +++ b/android/hal-msg.h
> @@ -47,6 +47,15 @@ struct hal_msg_hdr {
>  /* Core Service */
>  
>  #define HAL_ERROR_FAILED		0x01
> +#define HAL_ERROR_NOT_READY		0x02
> +#define HAL_ERROR_NOMEM			0x03
> +#define HAL_ERROR_BUSY			0x04
> +#define HAL_ERROR_DONE			0x05
> +#define HAL_ERROR_UNSUPPORTED		0x06
> +#define HAL_ERROR_INVALID		0x07
> +#define HAL_ERROR_UNHANDLED		0x08
> +#define HAL_ERROR_AUTH_FAILURE		0x09
> +#define HAL_ERROR_REMOTE_DEVICE_DOWN	0x0A

Applied after a minor s/0A/0a/ change to make this consistent with the
rest of the header file.

Johan
