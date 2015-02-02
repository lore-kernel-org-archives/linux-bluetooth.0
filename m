Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update ScPP PTS 6.0 pixits, pics, results for android 5.0
Date: Mon, 02 Feb 2015 22:06:18 +0100
Message-ID: <4211157.MgnH3CsIrX@athlon>
In-Reply-To: <1422870741-23423-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1422870741-23423-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 02 February 2015 10:52:21 Grzegorz Kolodziejczyk wrote:
> This patch updates test pixits, pics, test results for ScPP profile
> against android 5.0
> ---
>  android/pics-scpp.txt  |  2 +-
>  android/pixit-scpp.txt |  3 ++-
>  android/pts-scpp.txt   | 18 +++++++++---------
>  3 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/android/pics-scpp.txt b/android/pics-scpp.txt
> index db97c3a..6e4f599 100644
> --- a/android/pics-scpp.txt
> +++ b/android/pics-scpp.txt
> @@ -1,6 +1,6 @@
>  ScPP PICS for the PTS tool.
> 
> -PTS version: 5.3
> +PTS version: 6.0
> 
>  * - different than PTS defaults
> 
> diff --git a/android/pixit-scpp.txt b/android/pixit-scpp.txt
> index cdf0b01..105c46a 100644
> --- a/android/pixit-scpp.txt
> +++ b/android/pixit-scpp.txt
> @@ -1,6 +1,6 @@
>  ScPP PIXIT for the PTS tool.
> 
> -PTS version: 5.3
> +PTS version: 6.0
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> @@ -21,4 +21,5 @@ TSPX_use_dynamic_pin					FALSE
>  TSPX_delete_ltk						FALSE
>  TSPX_security_enabled					FALSE
>  TSPX_tester_appearance					0000
> +TSPX_iut_use_resolvable_random_address			FALSE
>  ---------------------------------------------------------------------------
> ---- diff --git a/android/pts-scpp.txt b/android/pts-scpp.txt
> index a7c65a2..d747c49 100644
> --- a/android/pts-scpp.txt
> +++ b/android/pts-scpp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for ScPP
> 
> -PTS version: 5.3
> -Tested: 25-November-2014
> +PTS version: 6.0
> +Tested: 02-February-2015
>  Android version: 5.0
> 
>  Results:
> @@ -14,11 +14,11 @@ NONE	test result is none
>  ---------------------------------------------------------------------------
> ---- Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- -TC_SPDS_SC_BV_01_I	PASS	PTS issue #12119
> -TC_SPDC_SC_BV_01_I	PASS	PTS issue #12119
> -TC_SPDC_SC_BV_02_I	PASS	PTS issue #12119
> -TC_SPDC_SC_BV_03_I	PASS	PTS issue #12119
> -TC_SPWF_SC_BV_01_I	PASS	PTS issue #12119
> -TC_SPCF_SC_BV_01_I	PASS	PTS issue #12119
> -TC_SPNF_SC_BV_01_I	PASS	PTS issue #12119
> +TC_SPDS_SC_BV_01_I	PASS
> +TC_SPDC_SC_BV_01_I	PASS
> +TC_SPDC_SC_BV_02_I	PASS
> +TC_SPDC_SC_BV_03_I	PASS
> +TC_SPWF_SC_BV_01_I	PASS
> +TC_SPCF_SC_BV_01_I	PASS
> +TC_SPNF_SC_BV_01_I	PASS
>  ---------------------------------------------------------------------------
> ----

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
