Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Run MPS PTS tests
Date: Tue, 20 May 2014 20:27:26 +0200
Message-ID: <1917751.ufacKUZ6i8@athlon>
In-Reply-To: <1400592707-26287-1-git-send-email-sebastian.chlad@tieto.com>
References: <1400592707-26287-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 20 May 2014 15:31:47 Sebastian Chlad wrote:
> ---
>  android/pixit-mps.txt |  2 +-
>  android/pts-mps.txt   | 40 ++++++++++++++++++++--------------------
>  2 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/android/pixit-mps.txt b/android/pixit-mps.txt
> index c59c913..317a391 100644
> --- a/android/pixit-mps.txt
> +++ b/android/pixit-mps.txt
> @@ -10,7 +10,7 @@ PTS version: 5.1
>  ---------------------------------------------------------------------------
> ---- Parameter Name						Value
>  ---------------------------------------------------------------------------
> ---- -TSPX_avrcp_revision
> +TSPX_avrcp_revision					1.5 (^)
>  TSPX_class_of_device					20050C
>  TSPX_establish_avdtp_stream				TRUE
>  TSPX_iut_establishes_initial_condition			FALSE
> diff --git a/android/pts-mps.txt b/android/pts-mps.txt
> index 005318d..4930818 100644
> --- a/android/pts-mps.txt
> +++ b/android/pts-mps.txt
> @@ -1,7 +1,7 @@
>  PTS test results for MPS
> 
>  PTS version: 5.1
> -Tested: not tested
> +Tested: 20.05.2014
>  Android version: 4.4.2
> 
>  Results:
> @@ -14,17 +14,17 @@ NONE	test result is none
>  ---------------------------------------------------------------------------
> ---- Test Name				Result	Notes
>  ---------------------------------------------------------------------------
> ---- -TC_AG_SRC_HFAV_ACT_SD_BV_01_I		INC
> -TC_AG_SRC_HFAV_ACT_SD_BV_02_I		INC
> -TC_AG_SRC_HFAV_ACT_SD_BV_03_I		INC
> -TC_AG_SRC_HFAV_CLH_SD_BV_01_I		INC
> +TC_AG_SRC_HFAV_ACT_SD_BV_01_I		FAIL	JIRA: BZ-33
> +TC_AG_SRC_HFAV_ACT_SD_BV_02_I		PASS
> +TC_AG_SRC_HFAV_ACT_SD_BV_03_I		PASS
> +TC_AG_SRC_HFAV_CLH_SD_BV_01_I		INC	JIRA: BZ-33
>  TC_AG_SRC_HFAV_CLH_SD_BV_02_I		N/A
> -TC_AG_SRC_HFAV_CLH_SD_BV_03_I		INC
> -TC_AG_SRC_HFAV_CLH_SD_BV_04_I		INC
> -TC_AG_SRC_HFAV_CLH_SD_BV_05_I		INC
> -TC_AG_SRC_HFAV_CLH_SD_BV_06_I		INC
> -TC_AVP_CTH_SD_BI_01_I			INC
> -TC_AVP_CTH_SD_BI_02_I			INC
> +TC_AG_SRC_HFAV_CLH_SD_BV_03_I		INC	JIRA: BZ-33
> +TC_AG_SRC_HFAV_CLH_SD_BV_04_I		INC	JIRA: BZ-33
> +TC_AG_SRC_HFAV_CLH_SD_BV_05_I		INC	JIRA: BZ-33
> +TC_AG_SRC_HFAV_CLH_SD_BV_06_I		INC	JIRA: BZ-33
> +TC_AVP_CTH_SD_BI_01_I			INC	JIRA: BZ-33
> +TC_AVP_CTH_SD_BI_02_I			PASS
>  TC_HF_SNK_HFAV_ACT_SD_BV_01_I		N/A
>  TC_HF_SNK_HFAV_ACT_SD_BV_02_I		N/A
>  TC_HF_SNK_HFAV_ACT_SD_BV_03_I		N/A
> @@ -41,13 +41,13 @@ TC_HF_SNK_CT_HFAV_CLH_MD_BV_03_I	N/A
>  TC_HF_SNK_CT_HFAV_CLH_MD_BV_04_I	N/A
>  TC_HF_SNK_CT_HFAV_CLH_MD_BV_05_I	N/A
>  TC_HF_SNK_CT_HFAV_CLH_MD_BV_06_I	N/A
> -TC_SDP_CTH_SD_BV_01_I			INC
> -TC_SRC_TG_HFAV_ACT_MD_BV_01_I		INC
> -TC_SRC_TG_HFAV_CLH_MD_BV_01_I		INC
> -TC_SRC_TG_HFAV_CLH_MD_BV_02_I		INC
> -TC_SRC_TG_HFAV_CLH_MD_BV_03_I		INC
> -TC_SRC_TG_HFAV_CLH_MD_BV_04_I		INC
> -TC_SRC_TG_HFAV_CLH_MD_BV_05_I		INC
> -TC_SRC_TG_HFAV_CLH_MD_BV_06_I		INC
> -TC_PAIRING_HF_SNK_CT			INC
> +TC_SDP_CTH_SD_BV_01_I			INC	JIRA: BZ-34
> +TC_SRC_TG_HFAV_ACT_MD_BV_01_I		PASS
> +TC_SRC_TG_HFAV_CLH_MD_BV_01_I		PASS
> +TC_SRC_TG_HFAV_CLH_MD_BV_02_I		PASS
> +TC_SRC_TG_HFAV_CLH_MD_BV_03_I		PASS
> +TC_SRC_TG_HFAV_CLH_MD_BV_04_I		PASS
> +TC_SRC_TG_HFAV_CLH_MD_BV_05_I		PASS
> +TC_SRC_TG_HFAV_CLH_MD_BV_06_I		PASS
> +TC_PAIRING_HF_SNK_CT			PASS
>  ---------------------------------------------------------------------------
> ----

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
