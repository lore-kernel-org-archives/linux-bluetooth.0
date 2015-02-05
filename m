Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update IOPT test results for PTS 6.0
Date: Thu, 05 Feb 2015 16:10:04 +0100
Message-ID: <4355784.iatdboF0B2@uw000953>
In-Reply-To: <1422976078-21606-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1422976078-21606-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 03 of February 2015 16:07:58 Grzegorz Kolodziejczyk wrote:
> This patch updates test pixits, pics, results for IOPT profile against
> android 5.0
> ---
>  android/pics-iopt.txt  |  4 ++--
>  android/pixit-iopt.txt |  2 +-
>  android/pts-iopt.txt   | 21 +++++++++++----------
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/android/pics-iopt.txt b/android/pics-iopt.txt
> index 1276224..a0c9b95 100644
> --- a/android/pics-iopt.txt
> +++ b/android/pics-iopt.txt
> @@ -78,7 +78,7 @@ ExtendedServiceDiscoveryProfile_IP_PAN			SDP. Version: IP-PAN
>  TSPC_support_				False		Support for: Extended
>  ExtendedServiceDiscoveryProfile_L2CAP			SDP. Version: L2CAP
>  
> -TSPC_support_FAXProfile_DE		False		Support for: FAX Profile
> +TSPC_support_FAXProfile_DT		False		Support for: FAX Profile
>  							Role: Data Terminal
>  
>  TSPC_support_FAXProfile_GW		False		Support for: FAX Profile
> @@ -96,7 +96,7 @@ TSPC_support_HealthDeviceProfile_Sink	True (*)	Support for: HDP
>  TSPC_support_HealthDeviceProfile_Source	False		Support for: HDP
>  							Role: Source
>  
> -TSPC_support_NewHandsFreeProfile_AG	True		Support for: HFP
> +TSPC_support_NewHandsFreeProfile_AG	True (*)	Support for: HFP
>  							Role: Audio gateway
>  
>  TSPC_support_NewHandsFreeProfile_HF	False		Support for: HFP
> diff --git a/android/pixit-iopt.txt b/android/pixit-iopt.txt
> index 53837de..4cc6fd4 100644
> --- a/android/pixit-iopt.txt
> +++ b/android/pixit-iopt.txt
> @@ -1,6 +1,6 @@
>  IOPT PIXIT for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-iopt.txt b/android/pts-iopt.txt
> index f746b1c..7b776a9 100644
> --- a/android/pts-iopt.txt
> +++ b/android/pts-iopt.txt
> @@ -1,7 +1,7 @@
>  PTS test results for IOPT
>  
> -PTS version: 5.3
> -Tested: 18-November-2014
> +PTS version: 6.0
> +Tested: 03-February-2015
>  Android version: 5.0
>  
>  Results:
> @@ -14,12 +14,13 @@ N/A	test is disabled due to PICS setup
>  Test Name	Result	Notes
>  -------------------------------------------------------------------------------
>  TC_COD_BV_01_I	PASS	IUT must be discoverable
> -TC_COD_BV_02_I	N/A	Under PTS 5.1 test shall be disabled as there is
> -			matching test case in HFP test suit (test No. 15)
> -			PICS settings for HFP shall be disabled for IOPT
> -TC_SDSS_BV_02_I	PASS
> -TC_SDAS_BV_03_I	PASS
> -TC_SDR_BV_04_I	PASS	for every PTS bt profile:
> -			haltest: bluetooth get_remote_service_record <addr>
> -							<requred 128 sdp uuid>
> +TC_COD_BV_02_I	N/A
> +TC_SDSS_BV_02_I	PASS	Note: HDP sink record should be registered before test
> +				run, e.g. register health app via HDPSample.apk
> +TC_SDAS_BV_03_I	PASS	Note: HDP sink record should be registered before test
> +				run, e.g. register health app via HDPSample.apk
> +TC_SDR_BV_04_I	PASS	For every asked to check PTS bt profile:
> +			haltest: bluetooth get_remote_service_record <PTS addr>
> +				<profile uuid>
> +			Note: 0000xxxx - acceptable 16bit uuid format
>  -------------------------------------------------------------------------------
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
