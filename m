Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/7] android/hal-audio: Make code readable
Date: Thu, 17 Apr 2014 15:02:57 +0200
Message-ID: <2208396.qWWSl57k4f@uw000953>
In-Reply-To: <1397737431-6101-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1397737431-6101-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1397737431-6101-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 17 of April 2014 15:23:47 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/hal-audio.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/android/hal-audio.c b/android/hal-audio.c
> index c4bd4fe..76d1efb 100644
> --- a/android/hal-audio.c
> +++ b/android/hal-audio.c
> @@ -1876,12 +1876,12 @@ static struct hw_module_methods_t hal_module_methods = {
>  
>  struct audio_module HAL_MODULE_INFO_SYM = {
>  	.common = {
> -	.tag = HARDWARE_MODULE_TAG,
> -	.version_major = 1,
> -	.version_minor = 0,
> -	.id = AUDIO_HARDWARE_MODULE_ID,
> -	.name = "A2DP Bluez HW HAL",
> -	.author = "Intel Corporation",
> -	.methods = &hal_module_methods,
> +		.tag = HARDWARE_MODULE_TAG,
> +		.version_major = 1,
> +		.version_minor = 0,
> +		.id = AUDIO_HARDWARE_MODULE_ID,
> +		.name = "A2DP Bluez HW HAL",
> +		.author = "Intel Corporation",
> +		.methods = &hal_module_methods,
>  	},
>  };
> 

This patch is now applied, thanks.

-- 
Best regards, 
Szymon Janc
