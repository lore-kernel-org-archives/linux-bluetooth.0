Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 01/10] android/health: Add error check when creating app
Date: Sun, 29 Jun 2014 14:18:27 +0200
Message-ID: <2667021.la3TcvWGTc@leonov>
In-Reply-To: <1403882171-16308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403882171-16308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 27 of June 2014 18:16:02 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/health.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/android/health.c b/android/health.c
> index 7d64a63..0eeb0bd 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -820,6 +820,8 @@ static void bt_health_register_app(const void *buf,
> uint16_t len)
> 
>  	app = create_health_app(app_name, provider, srv_name, srv_descr,
>  							cmd->num_of_mdep);
> +	if (!app)
> +		goto fail;
> 
>  	if (!queue_push_tail(apps, app))
>  		goto fail;

All patches applied, thanks.

-- 
BR
Szymon Janc
