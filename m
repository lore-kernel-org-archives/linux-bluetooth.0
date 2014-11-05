Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Re-test HFP failing test cases
Date: Wed, 05 Nov 2014 21:55:37 +0100
Message-ID: <4481729.S7n7gxntoZ@leonov>
In-Reply-To: <1415183585-22406-1-git-send-email-sebastian.chlad@tieto.com>
References: <1415183585-22406-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Wednesday 05 of November 2014 11:33:05 Sebastian Chlad wrote:
> For PTS issue #12039 ETS and DLL was provided. Respective tests
> are passing.
> ---
>  android/pts-hfp.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/android/pts-hfp.txt b/android/pts-hfp.txt
> index 9de14cb..24a43e9 100644
> --- a/android/pts-hfp.txt
> +++ b/android/pts-hfp.txt
> @@ -101,10 +101,10 @@ TC_AG_SLC_BV_06_I	PASS
>  TC_AG_SLC_BV_07_I	PASS
>  TC_AG_SLC_BV_09_I	N/A
>  TC_AG_SLC_BV_10_I	N/A
> -TC_AG_ACC_BV_08_I	INC	Possible PTS issue #12039
> +TC_AG_ACC_BV_08_I	PASS	PTS issue #12039
>  TC_AG_ACC_BV_09_I	PASS
> -TC_AG_ACC_BV_10_I	INC	Possible PTS issue #12039
> -TC_AG_ACC_BV_11_I	INC	Possible PTS issue #12039
> +TC_AG_ACC_BV_10_I	PASS	PTS issue #12039
> +TC_AG_ACC_BV_11_I	PASS	PTS issue #12039
>  TC_AG_ACC_BI_12_I	PASS
>  TC_AG_ACC_BI_13_I	PASS
>  TC_AG_ACC_BI_14_I	PASS

Applied, thanks.

-- 
BR
Szymon Janc
