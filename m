Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update of RFCOMM test results
Date: Wed, 25 Feb 2015 11:34:08 +0100
Message-ID: <10964079.J9fnrc9LJt@uw000953>
In-Reply-To: <1424859564-15834-1-git-send-email-mariusz.skamra@tieto.com>
References: <1424859564-15834-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Wednesday 25 of February 2015 11:19:24 Mariusz Skamra wrote:
> TC_RFC_BV_21_C and TC_RFC_BV_22_C tested with fixed Ets provided
> in #13011
> ---
>  android/pts-rfcomm.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pts-rfcomm.txt b/android/pts-rfcomm.txt
> index 653b53a..e9b3f26 100644
> --- a/android/pts-rfcomm.txt
> +++ b/android/pts-rfcomm.txt
> @@ -32,7 +32,9 @@ TC_RFC_BV_14_C		N/A
>  TC_RFC_BV_15_C		PASS	rctest -r -P 1
>  TC_RFC_BV_17_C		PASS	rctest -d -P 1
>  TC_RFC_BV_19_C		PASS
> -TC_RFC_BV_21_C		INC	PTS issue #13011
> -TC_RFC_BV_22_C		INC	PTS issue #13011
> +TC_RFC_BV_21_C		PASS	PTS issue #13011
> +				rctest -w -N 10 -P 1
> +TC_RFC_BV_22_C		PASS	PTS issue #13011
> +				rctest -w -N 10 -P 1
>  TC_RFC_BV_25_C		PASS	rctest -r -P 1
>  -------------------------------------------------------------------------------
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
