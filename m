Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hsp: PTS tests results for HSP
Date: Fri, 14 Mar 2014 14:48:56 +0100
Message-ID: <3752642.bfBUTCfghf@uw000953>
In-Reply-To: <1394791274-8216-1-git-send-email-sebastian.chlad@tieto.com>
References: <1394791274-8216-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 14 of March 2014 11:01:14 Sebastian Chlad wrote:
> ---
>  android/Makefile.am |  3 ++-
>  android/pts-hsp.txt | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100644 android/pts-hsp.txt
> 
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 330529f..5a97f4a 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -219,4 +219,5 @@ EXTRA_DIST += android/Android.mk android/README \
>  				android/pts-avrcp.txt \
>  				android/pts-avctp.txt \
>  				android/pts-pbap.txt \
> -				android/pts-hfp.txt
> +				android/pts-hfp.txt \
> +				android/pts-hsp.txt
> diff --git a/android/pts-hsp.txt b/android/pts-hsp.txt
> new file mode 100644
> index 0000000..167fdb5
> --- /dev/null
> +++ b/android/pts-hsp.txt
> @@ -0,0 +1,41 @@
> +PTS test results for HSP
> +
> +PTS version: 5.0
> +Tested: 14-Mar-2014
> +Android version: 4.4.2
> +
> +Results:
> +PASS    test passed
> +FAIL    test failed
> +INC     test is inconclusive
> +N/A     test is disabled due to PICS setup
> +
> +-------------------------------------------------------------------------------
> +Test Name               Result  Notes
> +-------------------------------------------------------------------------------
> +TC_AG_IAC_BV_01_I	PASS
> +TC_AG_IAC_BV_02_I	N/A
> +TC_AG_OAC_BV_01_I	PASS
> +HSP_TC_AG_ACR_BV_01_I	PASS
> +HSP_TC_AG_ACR_BV_02_I	PASS
> +TC_AG_ACT_BV_01_I	PASS
> +TC_AG_ACT_BV_02_I	PASS
> +TC_AG_RAV_BV_01_I	N/A
> +TC_AG_RAV_BV_02_I	N/A
> +TC_AG_RAV_BV_03_I	N/A
> +TC_AG_RAV_BV_04_I	N/A
> +TC_AG_RAV_BV_05_I	N/A
> +TC_AG_RAV_BV_06_I	N/A
> +TC_HS_IAC_BV_01_I	N/A
> +TC_HS_IAC_BV_02_I	N/A
> +TC_HS_OAC_BV_01_I	N/A
> +TC_HS_ACR_BV_01_I	N/A
> +TC_HS_ACR_BV_02_I	N/A
> +TC_HS_ACT_BV_01_I	N/A
> +TC_HS_ACT_BV_02_I	N/A
> +TC_HS_RAV_BV_01_I	N/A
> +TC_HS_RAV_BV_02_I	N/A
> +TC_HS_RAV_BV_03_I	N/A
> +TC_HS_RAV_BV_04_I	N/A
> +TC_HS_RAV_BV_05_I	N/A
> +TC_HS_RAV_BV_06_I	N/A
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
