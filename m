Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Correct typo in MCAP tests listing
Date: Mon, 03 Nov 2014 19:15:36 +0100
Message-ID: <2060031.HHvN5f2bde@leonov>
In-Reply-To: <1415029839-7065-1-git-send-email-sebastian.chlad@tieto.com>
References: <1415029839-7065-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Monday 03 of November 2014 16:50:39 Sebastian Chlad wrote:
> ---
>  android/pts-mcap.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/pts-mcap.txt b/android/pts-mcap.txt
> index 9d1fdcd..3b4766f 100644
> --- a/android/pts-mcap.txt
> +++ b/android/pts-mcap.txt
> @@ -31,7 +31,7 @@ TC_MCAP_CM_ABT_BV_03_C	N/A
>  TC_MCAP_CM_DEL_BV_01_C	N/A
>  TC_MCAP_CM_DEL_BV_02_C	INC	PTS Issue #12693
>  				mcaptest -C 4099 -D 4101
> -TC_MCAP_CM_DEL_BV_02_C	N/A
> +TC_MCAP_CM_DEL_BV_03_C	N/A
>  TC_MCAP_CM_DEL_BV_04_C	INC	PTS Issue #12693
>  				mcaptest -C 4099 -D 4101
>  TC_MCAP_CM_DIS_BV_01_C	PASS	mcaptest -C 4099 -D 4101 -e 2 -f 2

Pushed, thanks.

-- 
BR
Szymon Janc
