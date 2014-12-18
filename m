Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Re-test of MPS on PTS 6.0
Date: Thu, 18 Dec 2014 09:49:54 +0100
Message-ID: <1425106.ODNSSV1gp9@uw000953>
In-Reply-To: <1418385503-2268-1-git-send-email-sebastian.chlad@tieto.com>
References: <1418385503-2268-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 12 of December 2014 12:58:23 Sebastian Chlad wrote:
> ---
>  android/pics-mps.txt  |  2 +-
>  android/pixit-mps.txt |  2 +-
>  android/pts-mps.txt   | 13 ++++++++-----
>  3 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/android/pics-mps.txt b/android/pics-mps.txt
> index ab937a6..29b82a9 100644
> --- a/android/pics-mps.txt
> +++ b/android/pics-mps.txt
> @@ -1,6 +1,6 @@
>  MPS PICS for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-mps.txt b/android/pixit-mps.txt
> index 462f683..86511bd 100644
> --- a/android/pixit-mps.txt
> +++ b/android/pixit-mps.txt
> @@ -1,6 +1,6 @@
>  MPS PIXIT for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-mps.txt b/android/pts-mps.txt
> index 4236a56..46efd3c 100644
> --- a/android/pts-mps.txt
> +++ b/android/pts-mps.txt
> @@ -1,7 +1,7 @@
>  PTS test results for MPS
>  
> -PTS version: 5.3
> -Tested: 27-November-2014
> +PTS version: 6.0
> +Tested: 11-December-2014
>  Android version: 5.0
>  
>  Results:
> @@ -18,7 +18,8 @@ For full tests conformance, "Touch sounds" on IUT should be disbaled
>  -------------------------------------------------------------------------------
>  Test Name				Result	Notes
>  -------------------------------------------------------------------------------
> -TC_AG_SRC_HFAV_ACT_SD_BV_01_I		PASS
> +TC_AG_PSE_HFPB_CTH_SD_BV_01_I		PASS
> +TC_AG_SRC_HFAV_ACT_SD_BV_01_I		INC	JIRA issue #BA-295
>  TC_AG_SRC_HFAV_ACT_SD_BV_02_I		PASS
>  TC_AG_SRC_HFAV_ACT_SD_BV_03_I		PASS
>  TC_AG_SRC_HFAV_CLH_SD_BV_01_I		PASS
> @@ -26,7 +27,7 @@ TC_AG_SRC_HFAV_CLH_SD_BV_02_I		N/A
>  TC_AG_SRC_HFAV_CLH_SD_BV_03_I		PASS
>  TC_AG_SRC_HFAV_CLH_SD_BV_04_I		PASS
>  TC_AG_SRC_HFAV_CLH_SD_BV_05_I		PASS
> -TC_AG_SRC_HFAV_CLH_SD_BV_06_I		PASS
> +TC_AG_SRC_HFAV_CLH_SD_BV_06_I		INC	JIRA issue #BA-296
>  TC_AVP_CTH_SD_BI_01_I			PASS
>  TC_AVP_CTH_SD_BI_02_I			PASS
>  TC_HF_SNK_HFAV_ACT_SD_BV_01_I		N/A
> @@ -46,11 +47,13 @@ TC_HF_SNK_CT_HFAV_CLH_MD_BV_04_I	N/A
>  TC_HF_SNK_CT_HFAV_CLH_MD_BV_05_I	N/A
>  TC_HF_SNK_CT_HFAV_CLH_MD_BV_06_I	N/A
>  TC_SDP_CTH_SD_BV_01_I			PASS
> +TC_SNK_PCE_AVO_ACT_SD_BV_01_I		N/A
> +TC_SRC_PSE_AVO_ACT_SD_BV_01_I		PASS
>  TC_SRC_TG_HFAV_ACT_MD_BV_01_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_01_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_02_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_03_I		PASS
> -TC_SRC_TG_HFAV_CLH_MD_BV_04_I		PASS
> +TC_SRC_TG_HFAV_CLH_MD_BV_04_I		FAIL	JIRA issue #BA-294
>  TC_SRC_TG_HFAV_CLH_MD_BV_05_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_06_I		PASS
>  TC_PAIRING_HF_SNK_CT			N/A	Pairing helper for MD tests
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
