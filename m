Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/health: Fix incorrect check
Date: Fri, 29 Aug 2014 16:18:14 +0200
Message-ID: <1999641.LkTvfH9YUz@uw000953>
In-Reply-To: <1409311461-21935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1409311461-21935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 29 of August 2014 14:24:21 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> "!create_mdl(channel) < 0" is always false since it returns bool
> ---
>  android/health.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index abf01b4..fb2a1e3 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1949,7 +1949,7 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
>  			goto fail;
>  
>  		/* create mdl if it does not exists */
> -		if (!channel->mdl && !create_mdl(channel) < 0)
> +		if (!channel->mdl && !create_mdl(channel))
>  			goto fail;
>  
>  		/* reconnect mdl if it exists */

Applied. Thanks. 

-- 
Best regards, 
Szymon Janc
