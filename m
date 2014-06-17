Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/health: trivial: Remove unneeded NULL assignment
Date: Tue, 17 Jun 2014 21:26:30 +0200
Message-ID: <7839802.91PWVIdem2@athlon>
In-Reply-To: <1403013367-8911-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403013367-8911-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 17 June 2014 16:56:07 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/health.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/android/health.c b/android/health.c
> index 4a709ef..54da771 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -465,7 +465,6 @@ static void free_hdp_list(void *list)
>  	sdp_list_t *hdp_list = list;
> 
>  	sdp_list_free(hdp_list, (sdp_free_func_t)sdp_data_free);
> -	hdp_list = NULL;
>  }
> 
>  static void register_features(void *data, void *user_data)

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
