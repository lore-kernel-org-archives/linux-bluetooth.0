Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal-handsfree: trivial remove empty line
Date: Tue, 18 Nov 2014 23:19:24 +0100
Message-ID: <1616869.6m1HzqVL7Q@leonov>
In-Reply-To: <1416260166-15110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1416260166-15110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 17 of November 2014 23:36:06 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/hal-handsfree-client.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
> index a152cab..63a8f1d 100644
> --- a/android/hal-handsfree-client.c
> +++ b/android/hal-handsfree-client.c
> @@ -357,7 +357,6 @@ static bt_status_t init(bthf_client_callbacks_t
> *callbacks)
> 
>  	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
>  					sizeof(cmd), &cmd, NULL, NULL, NULL);
> -
>  	if (ret != BT_STATUS_SUCCESS) {
>  		cbs = NULL;
>  		hal_ipc_unregister(HAL_SERVICE_ID_HANDSFREE_CLIENT);

Applied, thanks.

-- 
BR
Szymon Janc
