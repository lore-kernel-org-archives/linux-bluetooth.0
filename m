Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PAN PTS tests
Date: Mon, 20 Oct 2014 12:08:24 +0200
Message-ID: <1480722.C3kGBOkF5m@uw000953>
In-Reply-To: <1413560573-3261-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413560573-3261-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 17 of October 2014 17:42:53 Grzegorz Kolodziejczyk wrote:
> Checked and tested against PTS 5.3
> ---
>  android/pics-pan.txt  | 2 +-
>  android/pixit-pan.txt | 2 +-
>  android/pts-pan.txt   | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pics-pan.txt b/android/pics-pan.txt
> index 20b91c7..7c4939a 100644
> --- a/android/pics-pan.txt
> +++ b/android/pics-pan.txt
> @@ -1,6 +1,6 @@
>  PAN PICS for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-pan.txt b/android/pixit-pan.txt
> index a4233c6..680abb2 100644
> --- a/android/pixit-pan.txt
> +++ b/android/pixit-pan.txt
> @@ -1,6 +1,6 @@
>  PAN PIXIT for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  & - should be set to IUT or PTS Bluetooth address respectively
> diff --git a/android/pts-pan.txt b/android/pts-pan.txt
> index 0af186c..dac1dec 100644
> --- a/android/pts-pan.txt
> +++ b/android/pts-pan.txt
> @@ -1,7 +1,7 @@
>  PTS test results for PAN
>  
> -PTS version: 5.2
> -Tested: 05-August-2014
> +PTS version: 5.3
> +Tested: 17-October-2014
>  Android version: 4.4.4
>  
>  Results:
> 

Applied. Thanks.

-- 
Best regards, 
Szymon Janc
