Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Correct typo in tests listing for IOPT
Date: Mon, 03 Nov 2014 19:19:01 +0100
Message-ID: <2433442.rEbgIbNuSO@leonov>
In-Reply-To: <1415031889-10285-1-git-send-email-sebastian.chlad@tieto.com>
References: <1415031889-10285-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Monday 03 of November 2014 17:24:49 Sebastian Chlad wrote:
> ---
>  android/pts-iopt.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/pts-iopt.txt b/android/pts-iopt.txt
> index c13b6e5..aec40ed 100644
> --- a/android/pts-iopt.txt
> +++ b/android/pts-iopt.txt
> @@ -18,7 +18,7 @@ TC_COD_BV_02_I	N/A	Under PTS 5.1 test shall be disabled 
as
> there is matching test case in HFP test suit (test No. 15)
>  			PICS settings for HFP shall be disabled for IOPT
>  TC_SDSS_BV_02_I	PASS
> -TC_SDSA_BV_03_I	PASS
> +TC_SDAS_BV_03_I	PASS
>  TC_SDR_BV_04_I	PASS	for every PTS bt profile:
>  			haltest: bluetooth get_remote_service_record <addr>
>  							<requred 128 sdp uuid>

Applied as well, thanks.

-- 
BR
Szymon Janc
