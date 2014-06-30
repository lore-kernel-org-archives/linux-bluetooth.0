Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PTS test results for HDP
Date: Mon, 30 Jun 2014 22:31:21 +0200
Message-ID: <3923867.z6J2mFTHCZ@athlon>
In-Reply-To: <1404134504-12641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404134504-12641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 30 June 2014 16:21:44 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/pts-hdp.txt | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
> index a629937..0e634e6 100644
> --- a/android/pts-hdp.txt
> +++ b/android/pts-hdp.txt
> @@ -91,7 +91,11 @@ TC_SRC_CC_BV_07_C	PASS    haltest:
>  				hl connect_channel <app_id> <bd_addr>
>  				<mdep_cfg_index>
>  TC_SRC_CC_BV_09_C	INC
> -TC_SRC_CC_BI_12_C	INC
> +TC_SRC_CC_BI_12_C	PASS	haltest:
> +				hl register_application bluez-android Bluez
> +				bluez-hdp health-device-profile 1
> +				BTHL_MDEP_ROLE_SOURCE 4100
> +				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
>  TC_SRC_HCT_BV_01_I	PASS    haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
> @@ -111,7 +115,11 @@ TC_SRC_HCT_BV_03_I	N/A
>  TC_SRC_HCT_BV_04_I	INC
>  TC_SRC_HCT_BV_05_C	N/A
>  TC_SRC_HCT_BV_06_C	INC
> -TC_SRC_HCT_BV_07_C	INC
> +TC_SRC_HCT_BV_07_C	PASS	haltest:
> +				hl register_application bluez-android Bluez
> +				bluez-hdp health-device-profile 1
> +				BTHL_MDEP_ROLE_SOURCE 4100
> +				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
>  TC_SRC_DE_BV_01_I	INC
>  TC_SRC_DE_BV_02_I	PASS	haltest:
>  				hl register_application bluez-android Bluez

Patch applied. Thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
