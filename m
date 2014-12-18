Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: MAP testing against PTS 6.0
Date: Thu, 18 Dec 2014 09:50:12 +0100
Message-ID: <56759074.4Nqdhg0IsY@uw000953>
In-Reply-To: <1418726729-25030-1-git-send-email-sebastian.chlad@tieto.com>
References: <1418726729-25030-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 16 of December 2014 11:45:29 Sebastian Chlad wrote:
> ---
>  android/pics-map.txt  | 6 +++---
>  android/pixit-map.txt | 2 +-
>  android/pts-map.txt   | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/android/pics-map.txt b/android/pics-map.txt
> index 3f783a9..093aae1 100644
> --- a/android/pics-map.txt
> +++ b/android/pics-map.txt
> @@ -1,6 +1,6 @@
>  MAP PICS for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> @@ -111,8 +111,8 @@ TSPC_MAP_3_5a	True		MSE: SetNotificationRegistration (M)
>  TSPC_MAP_3_6	False		MSE: Supported Message Types
>  TSPC_MAP_3_6a	False		MSE: EMAIL (C1)
>  TSPC_MAP_3_6b	True		MSE: SMS_GSM (C1)
> -TSPC_MAP_3_6c	False		MSE: SMS_CDMA (C1)
> -TSPC_MAP_3_6d	False (*)	MSE: MMS (C1)
> +TSPC_MAP_3_6c	True (*)	MSE: SMS_CDMA (C1)
> +TSPC_MAP_3_6d	True		MSE: MMS (C1)
>  TSPC_MAP_3_7	False		MSE: Instance Information (Not Supported)
>  TSPC_MAP_3_7a	False (*)	MSE: GetMASInstanceInformation (Not Supported)
>  TSPC_MAP_3_8	False		MSE: Extended MAP-Event-Report (Not Supported)
> diff --git a/android/pixit-map.txt b/android/pixit-map.txt
> index c8c130c..a7626dd 100644
> --- a/android/pixit-map.txt
> +++ b/android/pixit-map.txt
> @@ -1,6 +1,6 @@
>  MAP PIXIT for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-map.txt b/android/pts-map.txt
> index e8092e2..6ca984e 100644
> --- a/android/pts-map.txt
> +++ b/android/pts-map.txt
> @@ -1,7 +1,7 @@
>  PTS test results for MAP
>  
> -PTS version: 5.3
> -Tested: 18-November-2014
> +PTS version: 6.0
> +Tested: 11-December-2014
>  Android version: 5.0
>  
>  Results:
> @@ -65,7 +65,7 @@ TC_MSE_MMB_BV_10_I	PASS
>  TC_MSE_MMB_BV_11_I	PASS
>  TC_MSE_MMB_BV_20_I	PASS
>  TC_MSE_MMB_BV_12_I	N/A
> -TC_MSE_MMB_BV_18_I	N/A
> +TC_MSE_MMB_BV_18_I	PASS
>  TC_MSE_MMB_BV_13_I	PASS
>  TC_MSE_MMB_BV_14_I	PASS
>  TC_MSE_MMB_BV_15_I	PASS
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
