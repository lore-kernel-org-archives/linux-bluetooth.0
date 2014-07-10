Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PTS files for DID
Date: Thu, 10 Jul 2014 21:28:22 +0200
Message-ID: <2991013.4ZWlTSaJO5@athlon>
In-Reply-To: <1404909493-22799-1-git-send-email-sebastian.chlad@tieto.com>
References: <1404909493-22799-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Wednesday 09 July 2014 14:38:13 Sebastian Chlad wrote:
> Updated PICS, PIXITs and PTS tests results for DID.
> PTS version 5.2. Android version 4.4.4
> ---
>  android/pics-did.txt  | 2 +-
>  android/pixit-did.txt | 2 +-
>  android/pts-did.txt   | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/android/pics-did.txt b/android/pics-did.txt
> index fe1c03a..f1441c8 100644
> --- a/android/pics-did.txt
> +++ b/android/pics-did.txt
> @@ -1,6 +1,6 @@
>  DID PICS for the PTS tool.
> 
> -PTS version: 5.1
> +PTS version: 5.2
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-did.txt b/android/pixit-did.txt
> index c40f938..60961da 100644
> --- a/android/pixit-did.txt
> +++ b/android/pixit-did.txt
> @@ -1,6 +1,6 @@
>  DID PIXIT for the PTS tool.
> 
> -PTS version: 5.1
> +PTS version: 5.2
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-did.txt b/android/pts-did.txt
> index 2a18d3e..99e0bc0 100644
> --- a/android/pts-did.txt
> +++ b/android/pts-did.txt
> @@ -1,8 +1,8 @@
>  PTS test results for DID
> 
> -PTS version: 5.1
> -Tested: 07-April-2014
> -Android version: 4.4.2
> +PTS version: 5.2
> +Tested: 09-July-2014
> +Android version: 4.4.4
> 
>  Results:
>  PASS	test passed

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
