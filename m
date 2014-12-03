Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS tests for HOGP on Android 5.0
Date: Wed, 03 Dec 2014 11:47:41 +0100
Message-ID: <1899958.7ehPOhEs7F@uw000953>
In-Reply-To: <1417448512-20973-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1417448512-20973-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 01 of December 2014 16:41:52 Grzegorz Kolodziejczyk wrote:
> ---
>  android/pts-hogp.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/android/pts-hogp.txt b/android/pts-hogp.txt
> index d86522d..98c14d8 100644
> --- a/android/pts-hogp.txt
> +++ b/android/pts-hogp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for HoG
>  
>  PTS version: 5.3
> -Tested: 21-October-2014
> -Android version: 4.4.4
> +Tested: 01-December-2014
> +Android version: 5.0
>  
>  Results:
>  PASS	test passed
> @@ -13,7 +13,8 @@ N/A	test is disabled due to PICS setup
>  -------------------------------------------------------------------------------
>  Test Name		Result	Notes
>  -------------------------------------------------------------------------------
> -TC_HGDS_HH_BV_01_I	PASS
> +TC_HGDS_HH_BV_01_I	PASS	PTS issue #12119
> +				This issue affects all PTS test cases
>  TC_HGDS_HH_BV_02_I	PASS
>  TC_HGDS_HH_BV_03_I	PASS
>  TC_HGDS_HD_BV_01_I	N/A
> @@ -83,11 +84,11 @@ TC_HGCF_RH_BV_02_I	PASS	haltest: hidhost connect <addr>
>  				gattc get_characteristic 1 {1812,2,1}
>  				gattc get_descriptor 1 {1812,2,1} {2a4d,5}
>  				gattc write_descriptor 1 {1812,2,1} {2a4d,5}
> -					{2902,0} 2 0x0000 0
> +					{2902,1} 2 0x0000 0
>  				gattc get_characteristic 1 {1812,5,1}
>  				gattc get_descriptor 1 {1812,5,1} {2a4d,4}
>  				gattc write_descriptor 1 {1812,5,1}
> -					{2a4d,4} {2902,0} 2 0x0000 0
> +					{2a4d,4} {2902,1} 2 0x0000 0
>  				hidhost disconnect <addr>
>  TC_HGCF_BH_BV_03_I	N/A
>  TC_HGCF_BH_BV_04_I	N/A

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
