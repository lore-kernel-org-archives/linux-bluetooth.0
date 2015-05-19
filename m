Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update MCAP test results
Date: Tue, 19 May 2015 20:46:09 +0200
Message-ID: <1512420.RSjjPSexyf@leonov>
In-Reply-To: <1432049798-29008-1-git-send-email-mariusz.skamra@tieto.com>
References: <1432049798-29008-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Tuesday 19 of May 2015 17:36:38 Mariusz Skamra wrote:
> PTS 6.1 and Android 5.1
> ---
>  android/pics-mcap.txt  | 4 ++--
>  android/pixit-mcap.txt | 2 +-
>  android/pts-mcap.txt   | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/android/pics-mcap.txt b/android/pics-mcap.txt
> index 70e0b66..218ee80 100644
> --- a/android/pics-mcap.txt
> +++ b/android/pics-mcap.txt
> @@ -1,6 +1,6 @@
>  MCAP PICS for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> @@ -52,7 +52,7 @@ TSPC_MCAP_2_4	False		Can support multiple 
simultaneous
> MCLs with
> ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- -TSPC_MCAP_3_1			This row inentionally left blank
> +TSPC_MCAP_3_1			This row intentionally left blank
>  TSPC_MCAP_3_2	True (*)	Initiate creation of Control and Data Channels
>  				(C.1)
>  TSPC_MCAP_3_3	True (*)	Accept creation of Control and Data Channels
> diff --git a/android/pixit-mcap.txt b/android/pixit-mcap.txt
> index f3d33a1..a8bbe52 100644
> --- a/android/pixit-mcap.txt
> +++ b/android/pixit-mcap.txt
> @@ -1,6 +1,6 @@
>  MCAP PIXIT for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-mcap.txt b/android/pts-mcap.txt
> index 2ad2858..8e224a1 100644
> --- a/android/pts-mcap.txt
> +++ b/android/pts-mcap.txt
> @@ -1,8 +1,8 @@
>  PTS test results for MCAP
> 
> -PTS version: 6.0
> -Tested: 10-February-2015
> -Android version: 5.0
> +PTS version: 6.1
> +Tested: 19-May-2015
> +Android version: 5.1
> 
>  Results:
>  PASS	test passed

Patch applied, thanks.

-- 
BR
Szymon Janc
