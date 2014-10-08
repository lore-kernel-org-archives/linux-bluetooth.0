Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ruslan Mstoi <ruslan.mstoi@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Updated PBAP PICS and PIXITs for PTS 5.3
Date: Wed, 08 Oct 2014 15:20:21 +0200
Message-ID: <201828290.fjkmFgbEsp@uw000953>
In-Reply-To: <1412604792-28728-1-git-send-email-ruslan.mstoi@linux.intel.com>
References: <1412604792-28728-1-git-send-email-ruslan.mstoi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruslan,

On Monday 06 of October 2014 17:13:12 Ruslan Mstoi wrote:
> ---
>  android/pics-pbap.txt  | 2 +-
>  android/pixit-pbap.txt | 2 +-
>  android/pts-pbap.txt   | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pics-pbap.txt b/android/pics-pbap.txt
> index bcb71b6..cb4126c 100644
> --- a/android/pics-pbap.txt
> +++ b/android/pics-pbap.txt
> @@ -1,6 +1,6 @@
>  PBAP PICS for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-pbap.txt b/android/pixit-pbap.txt
> index 7bc374b..f7a93c6 100644
> --- a/android/pixit-pbap.txt
> +++ b/android/pixit-pbap.txt
> @@ -1,6 +1,6 @@
>  PBAP PIXIT for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
> index 6341f5c..67e366d 100644
> --- a/android/pts-pbap.txt
> +++ b/android/pts-pbap.txt
> @@ -1,7 +1,7 @@
>  PTS test results for PBAP
>  
> -PTS version: 5.2
> -Tested: 04-August-2014
> +PTS version: 5.3
> +Tested: 06-October-2014
>  Android version: 4.4.4
>  
>  Results:
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
