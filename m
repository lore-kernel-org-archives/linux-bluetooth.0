Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update MAP test results
Date: Mon, 01 Jun 2015 14:57:45 +0200
Message-ID: <1687874.CdDCX0jCxB@leonov>
In-Reply-To: <1433155970-6476-1-git-send-email-mariusz.skamra@tieto.com>
References: <1433155970-6476-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Monday 01 of June 2015 12:52:50 Mariusz Skamra wrote:
> PTS 6.1 and Android 5.1
> ---
>  android/pics-map.txt  |  2 +-
>  android/pixit-map.txt |  2 +-
>  android/pts-map.txt   | 11 ++++++-----
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/android/pics-map.txt b/android/pics-map.txt
> index 093aae1..b1346b6 100644
> --- a/android/pics-map.txt
> +++ b/android/pics-map.txt
> @@ -1,6 +1,6 @@
>  MAP PICS for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-map.txt b/android/pixit-map.txt
> index a7626dd..90272cb 100644
> --- a/android/pixit-map.txt
> +++ b/android/pixit-map.txt
> @@ -1,6 +1,6 @@
>  MAP PIXIT for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-map.txt b/android/pts-map.txt
> index 6ca984e..2be8db2 100644
> --- a/android/pts-map.txt
> +++ b/android/pts-map.txt
> @@ -1,8 +1,8 @@
>  PTS test results for MAP
> 
> -PTS version: 6.0
> -Tested: 11-December-2014
> -Android version: 5.0
> +PTS version: 6.1
> +Tested: 29-May-2015
> +Android version: 5.1
> 
>  Results:
>  PASS	test passed
> @@ -71,9 +71,9 @@ TC_MSE_MMB_BV_14_I	PASS
>  TC_MSE_MMB_BV_15_I	PASS
>  TC_MSE_MMB_BV_16_I	PASS
>  TC_MSE_MMD_BV_02_I	PASS
> -TC_MSE_MMU_BV_02_I	PASS	At least one SMS must be present in inbox
> +TC_MSE_MMU_BV_02_I	PASS
>  TC_MSE_MMU_BV_03_I	PASS
> -TC_MSE_MMN_BV_02_I	PASS
> +TC_MSE_MMN_BV_02_I	INC	JIRA #BA-380
>  TC_MSE_MMN_BV_04_I	N/A
>  TC_MSE_MMI_BV_02_I	N/A
>  TC_MSE_MFB_BV_02_I	N/A
> @@ -83,6 +83,7 @@ TC_MSE_BC_BV_03_I	N/A
>  TC_MSE_CON_BV_01_I	N/A
>  TC_MSE_CON_BV_02_I	N/A
>  TC_MSE_ROB_BV_01_I	N/A
> +TC_MSE_ROB_BV_02_I	N/A
>  TC_MSE_SRM_BI_02_I	N/A
>  TC_MSE_SRM_BI_03_I	N/A
>  TC_MSE_SRM_BI_05_I	N/A

Patch applied. Thanks a lot for running all those tests!

-- 
BR
Szymon Janc
