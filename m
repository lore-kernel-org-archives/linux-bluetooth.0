Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PTS files for HOGP
Date: Wed, 22 Oct 2014 13:50:19 +0200
Message-ID: <1911601.S2zjcBIUEE@uw000953>
In-Reply-To: <1413885347-28938-1-git-send-email-sebastian.chlad@tieto.com>
References: <1413885347-28938-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 21 of October 2014 11:55:47 Sebastian Chlad wrote:
> PICS and PIXITs updated to PTS 5.3. Regression done for Android
> 4.4.4.
> ---
>  android/pics-hogp.txt  | 2 +-
>  android/pixit-hogp.txt | 2 +-
>  android/pts-hogp.txt   | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pics-hogp.txt b/android/pics-hogp.txt
> index d7192bf..61cf56a 100644
> --- a/android/pics-hogp.txt
> +++ b/android/pics-hogp.txt
> @@ -1,6 +1,6 @@
>  HOGP PICS for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-hogp.txt b/android/pixit-hogp.txt
> index 067c280..d32fe69 100644
> --- a/android/pixit-hogp.txt
> +++ b/android/pixit-hogp.txt
> @@ -1,6 +1,6 @@
>  HOGP PIXIT for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-hogp.txt b/android/pts-hogp.txt
> index 19292d1..d86522d 100644
> --- a/android/pts-hogp.txt
> +++ b/android/pts-hogp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for HoG
>  
> -PTS version: 5.2
> -Tested: 22-July-2014
> +PTS version: 5.3
> +Tested: 21-October-2014
>  Android version: 4.4.4
>  
>  Results:
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
