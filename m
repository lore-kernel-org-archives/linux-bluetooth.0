Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android: Add WBS mode to handsfree HAL
Date: Wed, 19 Mar 2014 13:01:11 +0100
Message-ID: <10573341.Jl1hoRprdJ@leonov>
In-Reply-To: <1395060022-478-1-git-send-email-szymon.janc@tieto.com>
References: <1395060022-478-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 17 of March 2014 13:40:21 Szymon Janc wrote:
> This adds additional modes for Handsfree HAL:
>   0x00 = Headset Profile only mode (default)
>   0x01 = Handsfree Profile (narrowband speech)
>   0x02 = Handsfree Profile (narrowband and wideband speech)
> 
> Currently wideband mode requires chip to assume that eSCO transparent
> data is mSBC.
> ---
>  android/hal-ipc-api.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
> index e4a4e9c..5613e85 100644
> --- a/android/hal-ipc-api.txt
> +++ b/android/hal-ipc-api.txt
> @@ -756,7 +756,9 @@ Bluetooth Handsfree HAL (ID 5)
> 
>  Android HAL name: "handsfree" (BT_PROFILE_HANDSFREE_ID)
> 
> -	Service modes:               0x01 = Headset Profile only mode
> +	Service modes: 0x00 = Headset Profile only mode (default)
> +	               0x01 = Handsfree Profile (narrowband speech)
> +	               0x02 = Handsfree Profile (narrowband and wideband speech)
> 
>  Commands and responses:

Both patches are now upstream.

Our reference Nexus4 build was also updated to this change so make sure to 
repo sync or after updating bleutoothd do:

adb shell setprop persist.sys.bluetooth.handsfree hfp_wbs

-- 
BR
Szymon Janc
