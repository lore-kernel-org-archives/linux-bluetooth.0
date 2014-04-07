Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pts: Bump PICS and PIXIT for AVRCP
Date: Mon, 07 Apr 2014 12:48:30 +0200
Message-ID: <11361846.4GKroNFgS3@uw000953>
In-Reply-To: <1396865727-27607-1-git-send-email-sebastian.chlad@tieto.com>
References: <1396865727-27607-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Monday 07 of April 2014 12:15:26 Sebastian Chlad wrote:
> Bumping version of PTS for AVRCP profile.
> ---
>  android/pics-avrcp.txt  | 2 +-
>  android/pixit-avrcp.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
> index bee22c8..969be6a 100644
> --- a/android/pics-avrcp.txt
> +++ b/android/pics-avrcp.txt
> @@ -1,6 +1,6 @@
>  AVRCP PICS for the PTS tool.
>  
> -PTS version: 5.0
> +PTS version: 5.1
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-avrcp.txt b/android/pixit-avrcp.txt
> index 9b278ad..ceae884 100644
> --- a/android/pixit-avrcp.txt
> +++ b/android/pixit-avrcp.txt
> @@ -1,6 +1,6 @@
>  AVRCP PIXIT for the PTS tool.
>  
> -PTS version: 5.0
> +PTS version: 5.1
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
