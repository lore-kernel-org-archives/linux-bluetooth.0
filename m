Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS tests results for HFP on Android 5.0
Date: Wed, 03 Dec 2014 11:47:57 +0100
Message-ID: <45738970.t3EEU7bPHs@uw000953>
In-Reply-To: <1417519386-11085-1-git-send-email-sebastian.chlad@tieto.com>
References: <1417519386-11085-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 02 of December 2014 12:23:06 Sebastian Chlad wrote:
> ---
>  android/pts-hfp.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/android/pts-hfp.txt b/android/pts-hfp.txt
> index 24a43e9..3fcb645 100644
> --- a/android/pts-hfp.txt
> +++ b/android/pts-hfp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for HFP
>  
>  PTS version: 5.3
> -Tested: 16-October-2014
> -Android version: 4.4.4
> +Tested: 02-December-2014
> +Android version: 5.0
>  
>  Results:
>  PASS	test passed
> @@ -55,7 +55,7 @@ TC_AG_OCM_BV_01_I	PASS
>  TC_AG_OCM_BV_02_I	PASS
>  TC_AG_OCL_BV_01_I	PASS
>  TC_AG_OCL_BV_02_I	PASS
> -TC_AG_TWC_BV_01_I	PASS
> +TC_AG_TWC_BV_01_I	PASS	JIRA #BA-281
>  TC_AG_TWC_BV_02_I	PASS
>  TC_AG_TWC_BV_03_I	PASS
>  TC_AG_TWC_BV_04_I	PASS
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
