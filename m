Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Re-test HDP profile on PTS 5.3
Date: Tue, 04 Nov 2014 13:49:55 +0100
Message-ID: <1966077.TmoJviThV2@uw000953>
In-Reply-To: <1415101277-20038-1-git-send-email-sebastian.chlad@tieto.com>
References: <1415101277-20038-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 04 of November 2014 12:41:17 Sebastian Chlad wrote:
> PTS issue 12340 which incorrectly enabled TC_SRC_DE_BV_01_I
> is solved in PTS 5.3.
> ---
>  android/pts-hdp.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
> index ee8b5c8..0a3ff08 100644
> --- a/android/pts-hdp.txt
> +++ b/android/pts-hdp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for HDP
>  
>  PTS version: 5.3
> -Tested: 30-September-2014
> +Tested: 04-November-2014
>  Android version: 4.4.4
>  
>  Results:
> @@ -140,7 +140,7 @@ TC_SRC_HCT_BV_07_C	PASS	haltest:
>  				bluez-hdp health-device-profile 1
>  				BTHL_MDEP_ROLE_SOURCE 4100
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
> -TC_SRC_DE_BV_01_I	INC	PTS issue #12340
> +TC_SRC_DE_BV_01_I	N/A
>  TC_SRC_DE_BV_02_I	PASS	haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
