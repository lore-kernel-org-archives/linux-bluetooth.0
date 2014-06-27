Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/health: Fix NULL dereference
Date: Fri, 27 Jun 2014 16:12:48 +0200
Message-ID: <13247510.96PXbMmBKk@uw000953>
In-Reply-To: <1403878054-26178-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403878054-26178-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 27 of June 2014 17:07:34 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/health.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 5f86727..2dc35d4 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1878,7 +1878,7 @@ static void channel_delete_cb(GError *gerr, gpointer data)
>  
>  	DBG("");
>  
> -	if (!gerr) {
> +	if (gerr) {
>  		error("health: channel delete failed %s", gerr->message);
>  		return;
>  	}
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
