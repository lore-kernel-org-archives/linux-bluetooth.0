Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 03/17] android/HDP: Change scope of mdep
Date: Wed, 18 Jun 2014 00:15:38 +0200
Message-ID: <56123361.3jftbd13PL@athlon>
In-Reply-To: <1402905472-17643-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1402905472-17643-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 16 June 2014 10:57:38 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Make code cleaner lowering scope for mdep to the place it is actually
> used.
> ---
>  android/hal-health.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/android/hal-health.c b/android/hal-health.c
> index 012b6b7..b8df5a7 100644
> --- a/android/hal-health.c
> +++ b/android/hal-health.c
> @@ -68,7 +68,6 @@ static bt_status_t register_application(bthl_reg_param_t
> *reg, int *app_id) {
>  	uint8_t buf[IPC_MTU];
>  	struct hal_cmd_health_reg_app *cmd = (void *) buf;
> -	struct hal_cmd_health_mdep *mdep = (void *) buf;
>  	struct hal_rsp_health_reg_app rsp;
>  	size_t rsp_len = sizeof(rsp);
>  	bt_status_t status;
> @@ -123,6 +122,8 @@ static bt_status_t register_application(bthl_reg_param_t
> *reg, int *app_id) return status;
> 
>  	for (i = 0; i < reg->number_of_mdeps; i++) {
> +		struct hal_cmd_health_mdep *mdep = (void *) buf;
> +
>  		memset(buf, 0, IPC_MTU);
>  		mdep->app_id = rsp.app_id;
>  		mdep->role = reg->mdep_cfg[i].mdep_role;

Patches 3,6,7,8,11,12,14 and 17 are now applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
