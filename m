Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Add PTS test results for A2DP
Date: Fri, 24 Jan 2014 23:04:27 +0100
Message-ID: <2171302.eeLXRujXhI@athlon>
In-Reply-To: <1390595089-5314-1-git-send-email-sebastianchlad@gmail.com>
References: <1390595089-5314-1-git-send-email-sebastianchlad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 24 January 2014 15:24:49 Sebastian Chlad wrote:
> ---
>  android/pts-a2dp.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
> index a269ec1..c6eee62 100644
> --- a/android/pts-a2dp.txt
> +++ b/android/pts-a2dp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for A2DP
> 
>  PTS version: 5.0
> -Tested: --not yet tested--
> +Tested: 24.01.2014
> 
>  Results:
>  PASS	test passed
> @@ -15,17 +15,17 @@ Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- TC_SRC_CC_BV_09_I	INC
>  TC_SRC_CC_BV_10_I	N/A
> -TC_SRC_REL_BV_01_I	INC
> -TC_SRC_REL_BV_02_I	INC
> -TC_SRC_SET_BV_01_I	INC
> -TC_SRC_SET_BV_02_I	INC
> -TC_SRC_SET_BV_03_I	INC
> +TC_SRC_REL_BV_01_I	PASS
> +TC_SRC_REL_BV_02_I	PASS
> +TC_SRC_SET_BV_01_I	PASS
> +TC_SRC_SET_BV_02_I	PASS
> +TC_SRC_SET_BV_03_I	PASS
>  TC_SRC_SET_BV_04_I	INC
>  TC_SRC_SET_BV_05_I	INC
>  TC_SRC_SET_BV_06_I	INC
>  TC_SRC_SUS_BV_01_I	INC
>  TC_SRC_SUS_BV_02_I	INC
> -TC_SRC_SDP_BV_01_I	INC
> +TC_SRC_SDP_BV_01_I	PASS
>  TC_SRC_AS_BV_01_I	INC
>  ---------------------------------------------------------------------------
> ----

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
