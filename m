Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS tests for HSP on Android 5.0 and PTS 5.3
Date: Mon, 24 Nov 2014 15:56:45 +0100
Message-ID: <1616343.D6feY3O0jy@leonov>
In-Reply-To: <1416840241-22060-1-git-send-email-sebastian.chlad@tieto.com>
References: <1416840241-22060-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Monday 24 of November 2014 15:44:01 Sebastian Chlad wrote:
> ---
>  android/pts-hsp.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pts-hsp.txt b/android/pts-hsp.txt
> index 9031b82..9f03ead 100644
> --- a/android/pts-hsp.txt
> +++ b/android/pts-hsp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for HSP
> 
>  PTS version: 5.3
> -Tested: 10-October-2014
> -Android version: 4.4.4
> +Tested: 24-November-2014
> +Android version: 5.0
> 
>  Results:
>  PASS    test passed
> @@ -16,8 +16,8 @@ Test Name               Result  Notes
>  TC_AG_IAC_BV_01_I	PASS
>  TC_AG_IAC_BV_02_I	N/A
>  TC_AG_OAC_BV_01_I	PASS
> -HSP_TC_AG_ACR_BV_01_I	PASS
> -HSP_TC_AG_ACR_BV_02_I	PASS
> +TC_AG_ACR_BV_01_I	PASS
> +TC_AG_ACR_BV_02_I	PASS
>  TC_AG_ACT_BV_01_I	PASS
>  TC_AG_ACT_BV_02_I	PASS
>  TC_AG_RAV_BV_01_I	PASS

Patch applied, thanks.

-- 
BR
Szymon Janc
