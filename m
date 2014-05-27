Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Eva Kolanska <eva.kolanska@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update GATT PTS tests results
Date: Tue, 27 May 2014 11:08:15 +0200
Message-ID: <1735407.E08ZEXaT4j@uw000953>
In-Reply-To: <1401180039-29269-1-git-send-email-eva.kolanska@tieto.com>
References: <1401180039-29269-1-git-send-email-eva.kolanska@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eva,

On Tuesday 27 of May 2014 10:40:39 Eva Kolanska wrote:
> ---
>  android/pts-gatt.txt |   38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
> index 92cbefa..d025064 100644
> --- a/android/pts-gatt.txt
> +++ b/android/pts-gatt.txt
> @@ -458,7 +458,7 @@ TC_GAW_SR_BI_32_C	INC
>  TC_GAW_SR_BI_33_C	INC
>  TC_GAW_SR_BI_34_C	INC
>  TC_GAW_SR_BI_35_C	INC
> -TC_GAN_CL_BV_01_C	INC	Possible PTS issue
> +TC_GAN_CL_BV_01_C	INC	PTS issue #12249
>  TC_GAN_SR_BV_01_C	INC
>  TC_GAI_CL_BV_01_C	INC  	PTS issue #12211
>  TC_GAI_SR_BV_01_C	INC
> @@ -466,19 +466,31 @@ TC_GAS_CL_BV_01_C	PASS	haltest:
>  				gattc connect
>  				gattc disconnect
>  TC_GAS_SR_BV_01_C	INC
> -TC_GAT_CL_BV_01_C	INC
> -TC_GAT_CL_BV_02_C	INC
> +TC_GAT_CL_BV_01_C	PASS	haltest:
> +				gattc connect
> +				gattc search_service
> +				gattc get_characteristic: srvc_id based on
> +								handle from logs
> +				gattc read_characcteristic
> +				gattc disconnect
> +TC_GAT_CL_BV_02_C	PASS	haltest:
> +				gattc connect
> +				gattc search_service
> +				gattc get_characteristic: srvc_id based on
> +								handle from logs
> +				gattc write_characcteristic 2 <short_value>
> +				gattc disconnect
>  TC_GAT_SR_BV_01_C	INC
> -TC_GPA_CL_BV_01_C	INC
> -TC_GPA_CL_BV_02_C	INC
> -TC_GPA_CL_BV_03_C	INC
> -TC_GPA_CL_BV_04_C	INC
> -TC_GPA_CL_BV_05_C	INC
> -TC_GPA_CL_BV_06_C	INC
> -TC_GPA_CL_BV_07_C	INC
> -TC_GPA_CL_BV_08_C	INC
> -TC_GPA_CL_BV_11_C	INC
> -TC_GPA_CL_BV_12_C	INC
> +TC_GPA_CL_BV_01_C	INC	gatttool required
> +TC_GPA_CL_BV_02_C	INC	gatttool required
> +TC_GPA_CL_BV_03_C	INC	gatttool required
> +TC_GPA_CL_BV_04_C	INC	gatttool required
> +TC_GPA_CL_BV_05_C	INC	gatttool required
> +TC_GPA_CL_BV_06_C	INC	gatttool required
> +TC_GPA_CL_BV_07_C	INC	gatttool required
> +TC_GPA_CL_BV_08_C	INC	gatttool required
> +TC_GPA_CL_BV_11_C	INC	gatttool required
> +TC_GPA_CL_BV_12_C	INC	gatttool required
>  TC_GPA_SR_BV_01_C	INC
>  TC_GPA_SR_BV_02_C	INC
>  TC_GPA_SR_BV_03_C	INC
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
