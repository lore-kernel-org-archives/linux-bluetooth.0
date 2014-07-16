Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PTS files for HSP
Date: Wed, 16 Jul 2014 17:41:54 +0200
Message-ID: <3490966.soiaHUpBEg@uw000953>
In-Reply-To: <1405434056-17558-1-git-send-email-sebastian.chlad@tieto.com>
References: <1405434056-17558-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 15 of July 2014 16:20:56 Sebastian Chlad wrote:
> Re-run PTS tests for HSP on PTS 5.2 and Android 4.4.4
> ---
>  android/pics-hsp.txt  | 2 +-
>  android/pixit-hsp.txt | 2 +-
>  android/pts-hsp.txt   | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/android/pics-hsp.txt b/android/pics-hsp.txt
> index 3c4962c..330a197 100644
> --- a/android/pics-hsp.txt
> +++ b/android/pics-hsp.txt
> @@ -1,6 +1,6 @@
>  HSP PICS for the PTS tool.
>  
> -PTS version: 5.1
> +PTS version: 5.2
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-hsp.txt b/android/pixit-hsp.txt
> index 2d5b14b..a097277 100644
> --- a/android/pixit-hsp.txt
> +++ b/android/pixit-hsp.txt
> @@ -1,6 +1,6 @@
>  HSP PIXIT for the PTS tool.
>  
> -PTS version: 5.1
> +PTS version: 5.2
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-hsp.txt b/android/pts-hsp.txt
> index 7da71e8..0df9806 100644
> --- a/android/pts-hsp.txt
> +++ b/android/pts-hsp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for HSP
>  
> -PTS version: 5.1
> -Tested: 10-April-2014
> -Android version: 4.4.2
> +PTS version: 5.2
> +Tested: 15-July-2014
> +Android version: 4.4.4
>  
>  Results:
>  PASS    test passed
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
