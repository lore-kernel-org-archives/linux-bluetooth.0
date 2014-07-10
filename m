Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PTS files for AVCTP
Date: Thu, 10 Jul 2014 21:29:16 +0200
Message-ID: <3323169.INiAY2o3re@athlon>
In-Reply-To: <1404997065-23966-1-git-send-email-sebastian.chlad@tieto.com>
References: <1404997065-23966-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Thursday 10 July 2014 14:57:45 Sebastian Chlad wrote:
> PICS and PIXITs updated to PTS 5.2. Regression done for Android
> 4.4.4.
> ---
>  android/pics-avctp.txt  | 2 +-
>  android/pixit-avctp.txt | 4 ++--
>  android/pts-avctp.txt   | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/android/pics-avctp.txt b/android/pics-avctp.txt
> index 3490db5..5900d00 100644
> --- a/android/pics-avctp.txt
> +++ b/android/pics-avctp.txt
> @@ -1,6 +1,6 @@
>  AVCTP PICS for the PTS tool.
> 
> -PTS version: 5.1
> +PTS version: 5.2
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-avctp.txt b/android/pixit-avctp.txt
> index a9b3f4f..3c6a864 100644
> --- a/android/pixit-avctp.txt
> +++ b/android/pixit-avctp.txt
> @@ -1,6 +1,6 @@
>  AVCTP PIXIT for the PTS tool.
> 
> -PTS version: 5.1
> +PTS version: 5.2
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> @@ -12,7 +12,7 @@ Parameter Name			Value
>  ---------------------------------------------------------------------------
> ---- TSPX_avctp_psm			0017
>  TSPX_avctp_profile_id		110E
> -TSPX_connect_avdtp		TRUE
> +TSPX_connect_avdtp		FALSE (*)
>  TSPX_avctp_tester_command_data
>  TSPX_avctp_tester_response_data
>  TSPX_avctp_iut_command_data
> diff --git a/android/pts-avctp.txt b/android/pts-avctp.txt
> index d8e7230..a461ee9 100644
> --- a/android/pts-avctp.txt
> +++ b/android/pts-avctp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for AVCTP
> 
> -PTS version: 5.1
> -Tested: 07-April-2014
> -Android version: 4.4.2
> +PTS version: 5.2
> +Tested: 10-July-2014
> +Android version: 4.4.4
> 
>  Results:
>  PASS	test passed

Applied. Thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
