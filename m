Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update HSP test results
Date: Wed, 13 May 2015 16:47:48 +0200
Message-ID: <4680004.bDOlITmzau@leonov>
In-Reply-To: <1431526169-16919-1-git-send-email-mariusz.skamra@tieto.com>
References: <1431526169-16919-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Wednesday 13 of May 2015 16:09:29 Mariusz Skamra wrote:
> PTS 6.1 and Android 5.1
> ---
>  android/pics-hsp.txt  | 2 +-
>  android/pixit-hsp.txt | 2 +-
>  android/pts-hsp.txt   | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/android/pics-hsp.txt b/android/pics-hsp.txt
> index 3818e74..e55b986 100644
> --- a/android/pics-hsp.txt
> +++ b/android/pics-hsp.txt
> @@ -1,6 +1,6 @@
>  HSP PICS for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-hsp.txt b/android/pixit-hsp.txt
> index d7a8e3c..9ba74d2 100644
> --- a/android/pixit-hsp.txt
> +++ b/android/pixit-hsp.txt
> @@ -1,6 +1,6 @@
>  HSP PIXIT for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-hsp.txt b/android/pts-hsp.txt
> index 04a6413..8a48dd8 100644
> --- a/android/pts-hsp.txt
> +++ b/android/pts-hsp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for HSP
> 
> -PTS version: 6.0
> -Tested: 12-February-2015
> -Android version: 5.0
> +PTS version: 6.1
> +Tested: 13-May-2015
> +Android version: 5.1
> 
>  Results:
>  PASS    test passed

Patch applied, thanks.

-- 
BR
Szymon Janc
