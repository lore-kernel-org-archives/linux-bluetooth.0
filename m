Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Fix adding missing BT_PROFILE_AV_RC_CTRL_ID
Date: Thu, 13 Nov 2014 14:29:45 +0100
Message-ID: <13235957.KNoZl3S8SJ@uw000953>
In-Reply-To: <1415783151-9920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415783151-9920-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 12 of November 2014 11:05:51 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add BT_PROFILE_AV_RC_CTRL_ID to profile_ids[].
> ---
>  android/client/if-bt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/client/if-bt.c b/android/client/if-bt.c
> index b0a0f71..f83e148 100644
> --- a/android/client/if-bt.c
> +++ b/android/client/if-bt.c
> @@ -760,6 +760,7 @@ static void get_profile_interface_c(int argc, const char **argv,
>  #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
>  		BT_PROFILE_HANDSFREE_CLIENT_ID,
>  		BT_PROFILE_MAP_CLIENT_ID,
> +		BT_PROFILE_AV_RC_CTRL_ID,
>  #endif
>  		NULL
>  	};

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
