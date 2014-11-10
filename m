Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/tester: initialize unused callback to NULL
Date: Mon, 10 Nov 2014 20:49:52 +0100
Message-ID: <4809434.9ubG9A4Jj5@leonov>
In-Reply-To: <1415610288-2035-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415610288-2035-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 10 of November 2014 11:04:47 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/tester-main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/android/tester-main.c b/android/tester-main.c
> index 44a2726..33ef3ce 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -1394,7 +1394,8 @@ static bthh_callbacks_t bthh_callbacks = {
>  	.protocol_mode_cb = hidhost_protocol_mode_cb,
>  	.idle_time_cb = NULL,
>  	.get_report_cb = hidhost_get_report_cb,
> -	.virtual_unplug_cb = hidhost_virtual_unplug_cb
> +	.virtual_unplug_cb = hidhost_virtual_unplug_cb,
> +	.handshake_cb = NULL,
>  };
> 
>  static void gattc_register_client_cb(int status, int client_if,

Both patches applied, thanks.

-- 
BR
Szymon Janc
