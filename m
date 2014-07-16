Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PTS files for AVRCP
Date: Wed, 16 Jul 2014 17:41:09 +0200
Message-ID: <3190443.Td121Wf1Zz@uw000953>
In-Reply-To: <1405428704-10324-1-git-send-email-sebastian.chlad@tieto.com>
References: <1405428704-10324-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 15 of July 2014 14:51:44 Sebastian Chlad wrote:
> Regression test round using PTS 5.2 and Android 4.4.4
> ---
>  android/pics-avrcp.txt  | 2 +-
>  android/pixit-avrcp.txt | 2 +-
>  android/pts-avrcp.txt   | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/android/pics-avrcp.txt b/android/pics-avrcp.txt
> index 969be6a..f339689 100644
> --- a/android/pics-avrcp.txt
> +++ b/android/pics-avrcp.txt
> @@ -1,6 +1,6 @@
>  AVRCP PICS for the PTS tool.
>  
> -PTS version: 5.1
> +PTS version: 5.2
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-avrcp.txt b/android/pixit-avrcp.txt
> index ceae884..7ab5f18 100644
> --- a/android/pixit-avrcp.txt
> +++ b/android/pixit-avrcp.txt
> @@ -1,6 +1,6 @@
>  AVRCP PIXIT for the PTS tool.
>  
> -PTS version: 5.1
> +PTS version: 5.2
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
> index b05bdbf..c8663be 100644
> --- a/android/pts-avrcp.txt
> +++ b/android/pts-avrcp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for AVRCP
>  
> -PTS version: 5.1
> -Tested: 07-April-2014
> -Android version: 4.4.2
> +PTS version: 5.2
> +Tested: 15-July-2014
> +Android version: 4.4.4
>  
>  Results:
>  PASS	test passed
> 

Applied. Thanks.

-- 
Best regards, 
Szymon Janc
