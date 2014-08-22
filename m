Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update MPS test result
Date: Fri, 22 Aug 2014 10:21:27 +0200
Message-ID: <2087304.0L25GXmhXV@uw000953>
In-Reply-To: <1408626619-8690-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1408626619-8690-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Thursday 21 of August 2014 15:10:19 Lukasz Rymanowski wrote:
> Test TC_SRC_TG_HFAV_CLH_MD_BV_04_I pass when Music application triggers
> music play/pause after it gets both: Button Pushed and Button
> Released events.
> 
> Note that AOSP Music player triggers play/pause just after it gets
> Button Pushed
> ---
>  android/pts-mps.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/android/pts-mps.txt b/android/pts-mps.txt
> index 7bef15f..2f661bb 100644
> --- a/android/pts-mps.txt
> +++ b/android/pts-mps.txt
> @@ -46,7 +46,8 @@ TC_SRC_TG_HFAV_ACT_MD_BV_01_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_01_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_02_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_03_I		PASS
> -TC_SRC_TG_HFAV_CLH_MD_BV_04_I		FAIL
> +TC_SRC_TG_HFAV_CLH_MD_BV_04_I		PASS	Do not use AOSP Music player.
> +						Use e.g. MortPlayer or Poweramp
>  TC_SRC_TG_HFAV_CLH_MD_BV_05_I		PASS
>  TC_SRC_TG_HFAV_CLH_MD_BV_06_I		PASS
>  TC_PAIRING_HF_SNK_CT			PASS
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
