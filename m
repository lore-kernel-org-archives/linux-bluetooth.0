Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS tests for AVRCP on Android 5.0
Date: Fri, 21 Nov 2014 12:39:34 +0100
Message-ID: <8052095.TUoBNg1WS5@uw000953>
In-Reply-To: <1416493149-28242-1-git-send-email-sebastian.chlad@tieto.com>
References: <1416493149-28242-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Thursday 20 of November 2014 15:19:09 Sebastian Chlad wrote:
> ---
>  android/pts-avrcp.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
> index c8aeeca..e6711ed 100644
> --- a/android/pts-avrcp.txt
> +++ b/android/pts-avrcp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for AVRCP
>  
>  PTS version: 5.3
> -Tested: 08-October-2014
> -Android version: 4.4.4
> +Tested: 20-November-2014
> +Android version: 5.0
>  
>  Results:
>  PASS	test passed
> @@ -188,7 +188,7 @@ TC_TG_PTT_BV_02_I	PASS
>  TC_TG_PTT_BV_03_I	N/A
>  TC_TG_PTT_BV_04_I	N/A
>  TC_TG_PTT_BV_05_I	N/A
> -TC_TG_RCR_BV_02_C	PASS
> +TC_TG_RCR_BV_02_C	PASS	One can use: lame --ta/tl for creating metadata
>  TC_TG_RCR_BV_04_C	PASS
>  TC_TG_VLH_BI_01_C	N/A
>  TC_TG_VLH_BI_02_C	N/A
> 

Applied. Thanks.

-- 
Best regards, 
Szymon Janc
