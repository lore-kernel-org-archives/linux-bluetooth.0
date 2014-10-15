Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS tests update for RFCOMM
Date: Wed, 15 Oct 2014 16:43:08 +0200
Message-ID: <8683164.RoZK7BKA0g@leonov>
In-Reply-To: <1413199783-19452-1-git-send-email-sebastian.chlad@tieto.com>
References: <1413199783-19452-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Monday 13 of October 2014 13:29:43 Sebastian Chlad wrote:
> Test TC_RFC_BV_25_C depends on kernel patches for Non-Supported Command,
> "Bluetooth: Fix RFCOMM NSC response" and "Bluetooth: Improve
> RFCOMM__test_pf macro robustness"
> ---
>  android/pts-rfcomm.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pts-rfcomm.txt b/android/pts-rfcomm.txt
> index 5d51905..98a691b 100644
> --- a/android/pts-rfcomm.txt
> +++ b/android/pts-rfcomm.txt
> @@ -1,8 +1,9 @@
>  PTS test results for RFCOMM
> 
>  PTS version: 5.3
> -Tested: 08-October-2014
> +Tested: 13-October-2014
>  Android version: 4.4.4
> +Kernel version: 3.18
> 
>  Results:
>  PASS	test passed
> @@ -18,6 +19,7 @@ TC_RFC_BV_01_C		PASS	rctest -n -P 1 <btaddr>
>  TC_RFC_BV_02_C		PASS	rctest -r -P 1
>  TC_RFC_BV_03_C		PASS	rctest -r -P 1
>  TC_RFC_BV_04_C		PASS	Note: use ETS provided in PTS issue #12414
> +				rctest -r -P 1
>  TC_RFC_BV_05_C		PASS	rctest -n -P 4 <btaddr>
>  				Note: test requires IUT to connect on the given
>  				channel. sdptool browse <btaddr> to check the
> @@ -35,5 +37,5 @@ TC_RFC_BV_17_C		PASS	rctest -d -P 1
>  TC_RFC_BV_19_C		PASS
>  TC_RFC_BV_21_C		INC	PTS issue #12421
>  TC_RFC_BV_22_C		INC	PTS issue #12421
> -TC_RFC_BV_25_C		INC	PTS issue #12621
> +TC_RFC_BV_25_C		PASS	rctest -r -P 1
>  ---------------------------------------------------------------------------
> ----


I've change kernel version to 3.19 since fix mentioned was applied to 
bluetooth-next.git tree.

Applied. Thanks.
-- 
BR
Szymon Janc
