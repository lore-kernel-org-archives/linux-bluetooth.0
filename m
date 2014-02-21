Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS test results for A2DP
Date: Fri, 21 Feb 2014 17:58:46 +0100
Message-ID: <1431899.NCoeilKW6F@uw000953>
In-Reply-To: <1392987204-13621-1-git-send-email-sebastian.chlad@tieto.com>
References: <1392987204-13621-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 21 of February 2014 13:53:24 Sebastian Chlad wrote:
> ---
>  android/pts-a2dp.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
> index 301b1e7..c407130 100644
> --- a/android/pts-a2dp.txt
> +++ b/android/pts-a2dp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for A2DP
>  
>  PTS version: 5.0
> -Tested: 28.01.2014
> +Tested: 21.02.2014
>  Android version: 4.4.2
>  
>  Results:
> @@ -14,7 +14,7 @@ N/A	test is disabled due to PICS setup
>  -------------------------------------------------------------------------------
>  Test Name		Result	Notes
>  -------------------------------------------------------------------------------
> -TC_SRC_CC_BV_09_I	INC
> +TC_SRC_CC_BV_09_I	PASS	Start streaming
>  TC_SRC_CC_BV_10_I	N/A
>  TC_SRC_REL_BV_01_I	PASS	Connect to PTS from IUT. When requested
>  				disconnect from IUT
> @@ -22,11 +22,11 @@ TC_SRC_REL_BV_02_I	PASS
>  TC_SRC_SET_BV_01_I	PASS	Connect to PTS (open a2dp)
>  TC_SRC_SET_BV_02_I	PASS
>  TC_SRC_SET_BV_03_I	PASS	Start streaming
> -TC_SRC_SET_BV_04_I	INC	Start streaming
> -TC_SRC_SET_BV_05_I	INC	IUT must be moved out of range
> -TC_SRC_SET_BV_06_I	INC	IUT must be moved out of range
> +TC_SRC_SET_BV_04_I	PASS	Start streaming
> +TC_SRC_SET_BV_05_I	PASS	IUT must be moved out of range
> +TC_SRC_SET_BV_06_I	PASS	IUT must be moved out of range
>  TC_SRC_SUS_BV_01_I	PASS	Stop streaming
> -TC_SRC_SUS_BV_02_I	INC
> +TC_SRC_SUS_BV_02_I	PASS
>  TC_SRC_SDP_BV_01_I	PASS
>  TC_SRC_AS_BV_01_I	PASS	Requires checking if the output on the IUT is
>  				correct
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
