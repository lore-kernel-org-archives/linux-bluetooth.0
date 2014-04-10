Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Bump PTS version for HFP
Date: Thu, 10 Apr 2014 11:24:32 +0200
Message-ID: <3222934.dH6RK5nzCX@uw000953>
In-Reply-To: <1397120832-23724-1-git-send-email-sebastian.chlad@tieto.com>
References: <1397120832-23724-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Thursday 10 of April 2014 11:07:12 Sebastian Chlad wrote:
> Re-checking PIXITs and PICS for HFP on PTS 5.1.
> ---
>  android/pics-hfp.txt  | 2 +-
>  android/pixit-hfp.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pics-hfp.txt b/android/pics-hfp.txt
> index 6c9808f..1a13edc 100644
> --- a/android/pics-hfp.txt
> +++ b/android/pics-hfp.txt
> @@ -1,6 +1,6 @@
>  HFP PICS for the PTS tool.
>  
> -PTS version: 5.0
> +PTS version: 5.1
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-hfp.txt b/android/pixit-hfp.txt
> index f539e07..ebf73c8 100644
> --- a/android/pixit-hfp.txt
> +++ b/android/pixit-hfp.txt
> @@ -1,6 +1,6 @@
>  HFP PIXIT for the PTS tool.
>  
> -PTS version: 5.0
> +PTS version: 5.1
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
