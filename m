Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: RFCOMM PTS update.
Date: Wed, 30 Jul 2014 11:26:24 +0200
Message-ID: <13529513.ev1i7PCfTT@uw000953>
In-Reply-To: <1406643138-16988-1-git-send-email-sebastian.chlad@tieto.com>
References: <1406643138-16988-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 29 of July 2014 16:12:18 Sebastian Chlad wrote:
> Number of issues on PTS 5.2 for RFCOMM found. Problems with Credits
> (PTS issue #12421), Channel disconnect (PTS issue #12414), accepting
> UIH and UA frames (PTS issue #12397).
> ---
>  android/pts-rfcomm.txt | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/android/pts-rfcomm.txt b/android/pts-rfcomm.txt
> index b96caab..9bfc7a2 100644
> --- a/android/pts-rfcomm.txt
> +++ b/android/pts-rfcomm.txt
> @@ -17,17 +17,21 @@ Test Name		Result	Notes
>  TC_RFC_BV_01_C		PASS	rctest -n -P 1 <btaddr>
>  TC_RFC_BV_02_C		PASS	rctest -r -P 1
>  TC_RFC_BV_03_C		PASS	rctest -r -P 1
> -TC_RFC_BV_04_C		FAIL
> +TC_RFC_BV_04_C		FAIL	PTS issue #12421
> +				PTS issue #12414
>  				NOTE: DISC on DLC is expected; IUT disconnects
>  					rfcomm session (close)
> -TC_RFC_BV_05_C		INC
> +TC_RFC_BV_05_C		PASS	rctest -n -P 4 <btaddr>
> +				Note: test requires IUT to connect on the given
> +				channel. sdptool browse <btaddr> to check the
> +				channel.
>  TC_RFC_BV_06_C		PASS	rctest -r -P 1
>  TC_RFC_BV_07_C		PASS	rctest -r -P 1
> -TC_RFC_BV_08_C		INC
> +TC_RFC_BV_08_C		INC	PTS issue #12397
>  				NOTE: Incorrect frame type sent in response to
>  					the DISC command
>  TC_RFC_BV_11_C		PASS	rctest -r -P 1
> -TC_RFC_BV_13_C		FAIL
> +TC_RFC_BV_13_C		FAIL	PTS issue #12397
>  				NOTE: IUT sent the correct frame type (UIH)
>  				but the parameters did not match the
>  				requirements
> @@ -35,7 +39,7 @@ TC_RFC_BV_14_C		N/A
>  TC_RFC_BV_15_C		PASS	rctest -r -P 1
>  TC_RFC_BV_17_C		PASS	rctest -d -P 1
>  TC_RFC_BV_19_C		PASS
> -TC_RFC_BV_21_C		INC
> -TC_RFC_BV_22_C		INC
> -TC_RFC_BV_25_C		INC
> +TC_RFC_BV_21_C		INC	PTS issue #12421
> +TC_RFC_BV_22_C		INC	PTS issue #12421
> +TC_RFC_BV_25_C		INC	PTS issue #12421
>  -------------------------------------------------------------------------------
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
