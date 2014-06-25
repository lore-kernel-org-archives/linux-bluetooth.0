Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 01/11] android/hal-health: trivial: Correct coding style
Date: Wed, 25 Jun 2014 17:30:56 +0200
Message-ID: <3157780.Dksz8ALCxx@uw000953>
In-Reply-To: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 24 of June 2014 15:11:52 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/hal-health.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/android/hal-health.c b/android/hal-health.c
> index ac6e87f..0d9136d 100644
> --- a/android/hal-health.c
> +++ b/android/hal-health.c
> @@ -116,8 +116,7 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
>  	cmd->len = off;
>  	status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
>  						sizeof(*cmd) + cmd->len, buf,
> -							&rsp_len, &rsp, NULL);
> -
> +						&rsp_len, &rsp, NULL);
>  	if (status != BT_STATUS_SUCCESS)
>  		return status;
>  
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
