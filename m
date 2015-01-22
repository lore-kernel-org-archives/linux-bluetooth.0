Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update DID PTS 6.0 pixits, pics, results for android 5.0
Date: Thu, 22 Jan 2015 13:17:20 +0100
Message-ID: <5514909.Mvpn7x4X3h@uw000953>
In-Reply-To: <1421923225-25912-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1421923225-25912-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 22 of January 2015 11:40:25 Grzegorz Kolodziejczyk wrote:
> This patch updates test pixits, pics and case list and results for
> DID profile against android 5.0.
> ---
>  android/pics-did.txt  | 2 +-
>  android/pixit-did.txt | 2 +-
>  android/pts-did.txt   | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pics-did.txt b/android/pics-did.txt
> index b516aa8..da2e090 100644
> --- a/android/pics-did.txt
> +++ b/android/pics-did.txt
> @@ -1,6 +1,6 @@
>  DID PICS for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-did.txt b/android/pixit-did.txt
> index 99f411b..295febc 100644
> --- a/android/pixit-did.txt
> +++ b/android/pixit-did.txt
> @@ -1,6 +1,6 @@
>  DID PIXIT for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-did.txt b/android/pts-did.txt
> index fedf779..8fd434d 100644
> --- a/android/pts-did.txt
> +++ b/android/pts-did.txt
> @@ -1,7 +1,7 @@
>  PTS test results for DID
>  
> -PTS version: 5.3
> -Tested: 07-November-2014
> +PTS version: 6.0
> +Tested: 22-January-2015
>  Android version: 5.0
>  
>  Results:

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
