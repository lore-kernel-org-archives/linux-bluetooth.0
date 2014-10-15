Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update MAP PTS tests
Date: Wed, 15 Oct 2014 15:57:37 +0200
Message-ID: <7997301.7cgSfxlVz6@leonov>
In-Reply-To: <1413378293-18074-1-git-send-email-sebastian.chlad@tieto.com>
References: <1413378293-18074-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Wednesday 15 of October 2014 15:04:53 Sebastian Chlad wrote:
> Checked and tested against PTS 5.3
> ---
>  android/pics-map.txt  | 2 +-
>  android/pixit-map.txt | 2 +-
>  android/pts-map.txt   | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pics-map.txt b/android/pics-map.txt
> index 461c6ce..3f783a9 100644
> --- a/android/pics-map.txt
> +++ b/android/pics-map.txt
> @@ -1,6 +1,6 @@
>  MAP PICS for the PTS tool.
> 
> -PTS version: 5.2
> +PTS version: 5.3
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-map.txt b/android/pixit-map.txt
> index 45a374a..c8c130c 100644
> --- a/android/pixit-map.txt
> +++ b/android/pixit-map.txt
> @@ -1,6 +1,6 @@
>  MAP PIXIT for the PTS tool.
> 
> -PTS version: 5.2
> +PTS version: 5.3
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-map.txt b/android/pts-map.txt
> index 5f5a4f3..57cb317 100644
> --- a/android/pts-map.txt
> +++ b/android/pts-map.txt
> @@ -1,7 +1,7 @@
>  PTS test results for MAP
> 
> -PTS version: 5.2
> -Tested: 16-July-2014
> +PTS version: 5.3
> +Tested: 15-October-2014
>  Android version: 4.4.4
> 
>  Results:

Applied. Thanks.

-- 
BR
Szymon Janc
