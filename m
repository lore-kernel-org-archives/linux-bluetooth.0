Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] android/pts: Update IOPT test results
Date: Fri, 22 May 2015 15:05:10 +0200
Message-ID: <2907080.FQs3Lvyq6e@leonov>
In-Reply-To: <1432276590-15331-1-git-send-email-mariusz.skamra@tieto.com>
References: <1432224625-20977-1-git-send-email-mariusz.skamra@tieto.com> <1432276590-15331-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Friday 22 of May 2015 08:36:30 Mariusz Skamra wrote:
> PTS 6.1 and Android 5.1
> ---
>  android/pics-iopt.txt  | 2 +-
>  android/pixit-iopt.txt | 2 +-
>  android/pts-iopt.txt   | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/android/pics-iopt.txt b/android/pics-iopt.txt
> index 4d07d70..7277c4c 100644
> --- a/android/pics-iopt.txt
> +++ b/android/pics-iopt.txt
> @@ -1,6 +1,6 @@
>  IOPT PICS for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-iopt.txt b/android/pixit-iopt.txt
> index 4cc6fd4..181a91d 100644
> --- a/android/pixit-iopt.txt
> +++ b/android/pixit-iopt.txt
> @@ -1,6 +1,6 @@
>  IOPT PIXIT for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-iopt.txt b/android/pts-iopt.txt
> index 7b776a9..cd7ad32 100644
> --- a/android/pts-iopt.txt
> +++ b/android/pts-iopt.txt
> @@ -1,8 +1,8 @@
>  PTS test results for IOPT
> 
> -PTS version: 6.0
> -Tested: 03-February-2015
> -Android version: 5.0
> +PTS version: 6.1
> +Tested: 21-May-2015
> +Android version: 5.1
> 
>  Results:
>  PASS	test passed
> @@ -14,7 +14,7 @@ N/A	test is disabled due to PICS setup
>  Test Name	Result	Notes
>  ---------------------------------------------------------------------------
> ---- TC_COD_BV_01_I	PASS	IUT must be discoverable
> -TC_COD_BV_02_I	N/A
> +TC_COD_BV_02_I	N/A	PTS issue#13473
>  TC_SDSS_BV_02_I	PASS	Note: HDP sink record should be registered before 
test
> run, e.g. register health app via HDPSample.apk
>  TC_SDAS_BV_03_I	PASS	Note: HDP sink record should be registered before 
test

Applied, thanks.

-- 
BR
Szymon Janc
