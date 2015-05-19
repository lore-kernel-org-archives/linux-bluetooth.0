Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update HFP test results
Date: Tue, 19 May 2015 16:15:39 +0200
Message-ID: <7271070.Sr6a4IcHuD@leonov>
In-Reply-To: <1431622804-31740-1-git-send-email-mariusz.skamra@tieto.com>
References: <1431622804-31740-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Thursday 14 of May 2015 19:00:04 Mariusz Skamra wrote:
> PTS 6.1 and Android 5.1
> ---
>  android/pics-hfp.txt  | 4 ++--
>  android/pixit-hfp.txt | 2 +-
>  android/pts-hfp.txt   | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/android/pics-hfp.txt b/android/pics-hfp.txt
> index ea81289..c658a25 100644
> --- a/android/pics-hfp.txt
> +++ b/android/pics-hfp.txt
> @@ -1,6 +1,6 @@
>  HFP PICS for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> @@ -195,7 +195,7 @@ TSPC_HFP_4_2	True (*)	CVSD audio coding over eSCO
> (Accepting) (C.2)
> ---------------------------------------------------------------------------
> ---- C.1: Mandatory if Wide band speech service is supported TSPC_HFP_2_24
> or TSPC_HFP_3_24, otherwise excluded
> -C.2: Mandatory IF TPSC_HFP_2_3b OR TSPC_HFP_3_3b; otherwise	Excluded.
> +C.2: Mandatory IF TPSC_HFP_2_3b OR TSPC_HFP_3_3b; otherwise Excluded.
>  ---------------------------------------------------------------------------
> ----
> 
> 
> diff --git a/android/pixit-hfp.txt b/android/pixit-hfp.txt
> index dfae9bf..896744e 100644
> --- a/android/pixit-hfp.txt
> +++ b/android/pixit-hfp.txt
> @@ -1,6 +1,6 @@
>  HFP PIXIT for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-hfp.txt b/android/pts-hfp.txt
> index ed17afe..05fccd8 100644
> --- a/android/pts-hfp.txt
> +++ b/android/pts-hfp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for HFP
> 
> -PTS version: 6.0
> -Tested: 16-February-2015
> -Android version: 5.0
> +PTS version: 6.1
> +Tested: 14-May-2015
> +Android version: 5.1
> 
>  Results:
>  PASS	test passed

Applied, thanks.

-- 
BR
Szymon Janc
