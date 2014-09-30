Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pts: Update PTS files for DID
Date: Tue, 30 Sep 2014 11:25:57 +0200
Message-ID: <3690442.PSTa20x6R0@uw000953>
In-Reply-To: <1411978037-4561-1-git-send-email-sebastian.chlad@tieto.com>
References: <1411978037-4561-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Monday 29 of September 2014 10:07:16 Sebastian Chlad wrote:
> Updated PICS, PIXITs and PTS tests results for DID.
> PTS version 5.3. Android version 4.4.4
> ---
>  android/pics-did.txt  | 2 +-
>  android/pixit-did.txt | 2 +-
>  android/pts-did.txt   | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pics-did.txt b/android/pics-did.txt
> index f1441c8..b516aa8 100644
> --- a/android/pics-did.txt
> +++ b/android/pics-did.txt
> @@ -1,6 +1,6 @@
>  DID PICS for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-did.txt b/android/pixit-did.txt
> index 60961da..99f411b 100644
> --- a/android/pixit-did.txt
> +++ b/android/pixit-did.txt
> @@ -1,6 +1,6 @@
>  DID PIXIT for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-did.txt b/android/pts-did.txt
> index 99e0bc0..facfa5c 100644
> --- a/android/pts-did.txt
> +++ b/android/pts-did.txt
> @@ -1,7 +1,7 @@
>  PTS test results for DID
>  
> -PTS version: 5.2
> -Tested: 09-July-2014
> +PTS version: 5.3
> +Tested: 26-September-2014
>  Android version: 4.4.4
>  
>  Results:
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
