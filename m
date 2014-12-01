Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS tests for MPS on Android 5.0
Date: Mon, 01 Dec 2014 14:11:51 +0100
Message-ID: <1751146.7Rz8IZ3x10@uw000953>
In-Reply-To: <1417104358-17992-1-git-send-email-sebastian.chlad@tieto.com>
References: <1417104358-17992-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Thursday 27 of November 2014 17:05:58 Sebastian Chlad wrote:
> ---
>  android/pixit-mps.txt |  3 ++-
>  android/pts-mps.txt   | 11 +++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/android/pixit-mps.txt b/android/pixit-mps.txt
> index 56f5122..462f683 100644
> --- a/android/pixit-mps.txt
> +++ b/android/pixit-mps.txt
> @@ -5,6 +5,7 @@ PTS version: 5.3
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
>  ^ - should be set accordingly
> +# - should be set according to the reported phone number's type
>  
>  		Required PIXIT settings
>  -------------------------------------------------------------------------------
> @@ -34,7 +35,7 @@ TSPX_packet_type_sco					00A0
>  TSPX_phone_number					1234567 (^)
>  TSPX_phone_number_memory				1
>  TSPX_phone_number_memory_invalid_index			9999
> -TSPX_phone_number_type					129
> +TSPX_phone_number_type					145 (*#)
>  TSPX_scan_all_memory_dial_locations			FALSE
>  TSPX_second_phone_number				1234567 (^)
>  TSPX_second_phone_type					129
> diff --git a/android/pts-mps.txt b/android/pts-mps.txt
> index 46d2510..4236a56 100644
> --- a/android/pts-mps.txt
> +++ b/android/pts-mps.txt
> @@ -1,8 +1,8 @@
>  PTS test results for MPS
>  
>  PTS version: 5.3
> -Tested: 20.10.2014
> -Android version: 4.4.4
> +Tested: 27-November-2014
> +Android version: 5.0
>  
>  Results:
>  PASS	test passed
> @@ -11,6 +11,10 @@ INC	test is inconclusive
>  N/A	test is disabled due to PICS setup
>  NONE	test result is none
>  
> +Note: Do not use AOSP Music player. Use e.g. MortPlayer or Poweramp.
> +For full tests conformance, "Touch sounds" on IUT should be disbaled
> +(Settings > Sound&notification > Other sounds)
> +
>  -------------------------------------------------------------------------------
>  Test Name				Result	Notes
>  -------------------------------------------------------------------------------
> @@ -46,8 +50,7 @@ TC_SRC_TG_HFAV_ACT_MD_BV_01_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_01_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_02_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_03_I		PASS
> -TC_SRC_TG_HFAV_CLH_MD_BV_04_I		PASS	Do not use AOSP Music player.
> -						Use e.g. MortPlayer or Poweramp
> +TC_SRC_TG_HFAV_CLH_MD_BV_04_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_05_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_06_I		PASS
>  TC_PAIRING_HF_SNK_CT			N/A	Pairing helper for MD tests
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
