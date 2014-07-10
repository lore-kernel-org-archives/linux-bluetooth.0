Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS updates for A2DP
Date: Thu, 10 Jul 2014 21:27:19 +0200
Message-ID: <1580282.HW08voJNQr@athlon>
In-Reply-To: <1404816970-27996-1-git-send-email-sebastian.chlad@tieto.com>
References: <1404816970-27996-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 08 July 2014 12:56:10 Sebastian Chlad wrote:
> PICS and PIXITs files checked against PTS 5.2.
> ---
>  android/pics-a2dp.txt  | 2 +-
>  android/pixit-a2dp.txt | 2 +-
>  android/pts-a2dp.txt   | 9 +++++----
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/android/pics-a2dp.txt b/android/pics-a2dp.txt
> index 53b3c1c..782132c 100644
> --- a/android/pics-a2dp.txt
> +++ b/android/pics-a2dp.txt
> @@ -1,6 +1,6 @@
>  A2DP PICS for the PTS tool.
> 
> -PTS version: 5.1
> +PTS version: 5.2
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-a2dp.txt b/android/pixit-a2dp.txt
> index 807ce3b..b9984d3 100644
> --- a/android/pixit-a2dp.txt
> +++ b/android/pixit-a2dp.txt
> @@ -1,6 +1,6 @@
>  A2DP PIXIT for the PTS tool.
> 
> -PTS version: 5.1
> +PTS version: 5.2
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
> index 5780db1..7b9119c 100644
> --- a/android/pts-a2dp.txt
> +++ b/android/pts-a2dp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for A2DP
> 
> -PTS version: 5.1
> -Tested: 06-June-2014
> -Android version: 4.4.2
> +PTS version: 5.2
> +Tested: 08-July-2014
> +Android version: 4.4.4
> 
>  Results:
>  PASS	test passed
> @@ -16,7 +16,8 @@ Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- TC_SRC_CC_BV_09_I	PASS	Start streaming
>  TC_SRC_CC_BV_10_I	N/A
> -TC_SRC_REL_BV_01_I	PASS	Connect to PTS from IUT. When requested
> +TC_SRC_REL_BV_01_I	INC	JIRA: BA-2
> +				Connect to PTS from IUT. When requested
>  				disconnect from IUT
>  TC_SRC_REL_BV_02_I	PASS
>  TC_SRC_SET_BV_01_I	PASS	Connect to PTS (open a2dp)

Patch applied. Thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
