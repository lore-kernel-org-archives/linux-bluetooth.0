Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 01/12] android/health: Add error check when creating app
Date: Fri, 27 Jun 2014 15:38:46 +0200
Message-ID: <1496860.huqqFjPjZI@uw000953>
In-Reply-To: <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403855994-29262-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 27 of June 2014 14:24:52 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/health.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 42c9a6e..de67475 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -820,6 +820,8 @@ static void bt_health_register_app(const void *buf, uint16_t len)
>  
>  	app = create_health_app(app_name, provider, srv_name, srv_descr,
>  							cmd->num_of_mdep);
> +	if (!app)
> +		goto fail;
>  
>  	if (!queue_push_tail(apps, app))
>  		goto fail;
> @@ -830,7 +832,9 @@ static void bt_health_register_app(const void *buf, uint16_t len)
>  	return;
>  
>  fail:
> -	free_health_app(app);
> +	if (app)
> +		free_health_app(app);
> +

This is not needed. free_health_app() already checks for NULL.

>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_MDEP,
>  							HAL_STATUS_FAILED);
>  }
> 

-- 
Best regards, 
Szymon Janc
