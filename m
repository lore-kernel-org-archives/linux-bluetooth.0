Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PTS files for HFP
Date: Fri, 18 Jul 2014 12:32:21 +0200
Message-ID: <18258891.GziDJS0peY@uw000953>
In-Reply-To: <1405594458-32267-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1405594458-32267-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 17 of July 2014 12:54:18 Grzegorz Kolodziejczyk wrote:
> PICS and PIXITs updated to PTS 5.2. Regression done for Android
> 4.4.4.
> ---
>  android/pics-hfp.txt  | 2 +-
>  android/pixit-hfp.txt | 2 +-
>  android/pts-hfp.txt   | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/android/pics-hfp.txt b/android/pics-hfp.txt
> index 1a13edc..acbd25c 100644
> --- a/android/pics-hfp.txt
> +++ b/android/pics-hfp.txt
> @@ -1,6 +1,6 @@
>  HFP PICS for the PTS tool.
>  
> -PTS version: 5.1
> +PTS version: 5.2
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-hfp.txt b/android/pixit-hfp.txt
> index ebf73c8..eaccc75 100644
> --- a/android/pixit-hfp.txt
> +++ b/android/pixit-hfp.txt
> @@ -1,6 +1,6 @@
>  HFP PIXIT for the PTS tool.
>  
> -PTS version: 5.1
> +PTS version: 5.2
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-hfp.txt b/android/pts-hfp.txt
> index 196fa14..a281d6b 100644
> --- a/android/pts-hfp.txt
> +++ b/android/pts-hfp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for HFP
>  
> -PTS version: 5.1
> -Tested: 25-Mar-2014
> -Android version: 4.4.2
> +PTS version: 5.2
> +Tested: 14-Jul-2014
> +Android version: 4.4.4
>  
>  Results:
>  PASS	test passed
> 

Patch applied. Thanks.

-- 
Best regards, 
Szymon Janc
