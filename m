Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update RFCOMM PTS 6.0 pixits, pics, results for android 5.0
Date: Mon, 02 Feb 2015 22:06:39 +0100
Message-ID: <1747264.TySv0AXX0R@athlon>
In-Reply-To: <1422881353-10749-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1422881353-10749-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 02 February 2015 13:49:13 Grzegorz Kolodziejczyk wrote:
> This patch updates test pixits, pics, test results for RFCOMM profile
> against android 5.0
> ---
>  android/pics-rfcomm.txt  |  2 +-
>  android/pixit-rfcomm.txt |  2 +-
>  android/pts-rfcomm.txt   | 17 +++++++----------
>  3 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/android/pics-rfcomm.txt b/android/pics-rfcomm.txt
> index c970363..384f81d 100644
> --- a/android/pics-rfcomm.txt
> +++ b/android/pics-rfcomm.txt
> @@ -1,6 +1,6 @@
>  RFCOMM PICS for the PTS tool.
> 
> -PTS version: 5.3
> +PTS version: 6.0
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-rfcomm.txt b/android/pixit-rfcomm.txt
> index 187f3b4..a3fbb27 100644
> --- a/android/pixit-rfcomm.txt
> +++ b/android/pixit-rfcomm.txt
> @@ -1,6 +1,6 @@
>  RFCOMM PIXIT for the PTS tool.
> 
> -PTS version: 5.3
> +PTS version: 6.0
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-rfcomm.txt b/android/pts-rfcomm.txt
> index cf9497d..653b53a 100644
> --- a/android/pts-rfcomm.txt
> +++ b/android/pts-rfcomm.txt
> @@ -1,7 +1,7 @@
>  PTS test results for RFCOMM
> 
> -PTS version: 5.3
> -Tested: 19-November-2014
> +PTS version: 6.0
> +Tested: 02-February-2015
>  Android version: 5.0
>  Kernel version: 3.19
> 
> @@ -18,24 +18,21 @@ Test Name		Result	Notes
>  TC_RFC_BV_01_C		PASS	rctest -n -P 1 <btaddr>
>  TC_RFC_BV_02_C		PASS	rctest -r -P 1
>  TC_RFC_BV_03_C		PASS	rctest -r -P 1
> -TC_RFC_BV_04_C		PASS	Note: use ETS provided in PTS issue #12414
> -				rctest -r -P 1
> +TC_RFC_BV_04_C		PASS	rctest -r -P 1
>  TC_RFC_BV_05_C		PASS	rctest -n -P 4 <btaddr>
>  				Note: test requires IUT to connect on the given
>  				channel. sdptool browse <btaddr> to check the
>  				channel.
>  TC_RFC_BV_06_C		PASS	rctest -r -P 1
>  TC_RFC_BV_07_C		PASS	rctest -r -P 1
> -TC_RFC_BV_08_C		PASS	Note: use ETS provided in PTS issue #12397
> -				rctest -r -P 1
> +TC_RFC_BV_08_C		PASS	rctest -r -P 1
>  TC_RFC_BV_11_C		PASS	rctest -r -P 1
> -TC_RFC_BV_13_C		PASS	Note: use ETS provided in PTS issue #12397
> -				rctest -r -P 1
> +TC_RFC_BV_13_C		PASS	rctest -r -P 1
>  TC_RFC_BV_14_C		N/A
>  TC_RFC_BV_15_C		PASS	rctest -r -P 1
>  TC_RFC_BV_17_C		PASS	rctest -d -P 1
>  TC_RFC_BV_19_C		PASS
> -TC_RFC_BV_21_C		INC	PTS issue #12421
> -TC_RFC_BV_22_C		INC	PTS issue #12421
> +TC_RFC_BV_21_C		INC	PTS issue #13011
> +TC_RFC_BV_22_C		INC	PTS issue #13011
>  TC_RFC_BV_25_C		PASS	rctest -r -P 1
>  ---------------------------------------------------------------------------
> ----

Patch applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
