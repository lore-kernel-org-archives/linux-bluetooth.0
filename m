Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/hal-health: Fix not setting offsets for empty strings
Date: Mon, 16 Jun 2014 16:05:14 +0200
Message-ID: <5973276.61DRCaSDdV@uw000953>
In-Reply-To: <1402925256-9096-1-git-send-email-szymon.janc@tieto.com>
References: <1402925256-9096-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 16 of June 2014 15:27:35 Szymon Janc wrote:
> In register_app command all strings except app name are optional.
> Those are passed over IPC concatenated and offsets are used to
> determine string presence and length.
> ---
>  android/hal-health.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/android/hal-health.c b/android/hal-health.c
> index 012b6b7..ab06658 100644
> --- a/android/hal-health.c
> +++ b/android/hal-health.c
> @@ -93,23 +93,23 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
>  	memcpy(cmd->data, reg->application_name, len);
>  	off += len;
>  
> +	cmd->provider_name_off = off;
>  	if (reg->provider_name) {
>  		len = strlen(reg->provider_name) + 1;
> -		cmd->provider_name_off = off;
>  		memcpy(cmd->data + off, reg->provider_name, len);
>  		off += len;
>  	}
>  
> +	cmd->service_name_off = off;
>  	if (reg->srv_name) {
>  		len = strlen(reg->srv_name) + 1;
> -		cmd->service_name_off = off;
>  		memcpy(cmd->data + off, reg->srv_name, len);
>  		off += len;
>  	}
>  
> +	cmd->service_descr_off = off;
>  	if (reg->srv_desp) {
>  		len = strlen(reg->srv_desp) + 1;
> -		cmd->service_descr_off = off;
>  		memcpy(cmd->data + off, reg->srv_desp, len);
>  		off += len;
>  	}
> 

Applied.

-- 
Best regards, 
Szymon Janc
