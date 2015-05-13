Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update ScPP test results
Date: Wed, 13 May 2015 16:47:09 +0200
Message-ID: <12783310.n6rIY1nY5j@leonov>
In-Reply-To: <1431430676-4119-1-git-send-email-mariusz.skamra@tieto.com>
References: <1431430676-4119-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Tuesday 12 of May 2015 13:37:56 Mariusz Skamra wrote:
> PTS 6.1 and Android 5.1
> ---
>  android/pics-scpp.txt  | 4 ++--
>  android/pixit-scpp.txt | 2 +-
>  android/pts-scpp.txt   | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/android/pics-scpp.txt b/android/pics-scpp.txt
> index 6e4f599..601ac32 100644
> --- a/android/pics-scpp.txt
> +++ b/android/pics-scpp.txt
> @@ -1,6 +1,6 @@
>  ScPP PICS for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
> 
> @@ -14,7 +14,7 @@ Parameter Name	Selected	Description
>  TSPC_ScPP_1_1	False (*)	Scan Server (C.1)
>  TSPC_ScPP_1_2	True		Scan Client (C.1)
>  ---------------------------------------------------------------------------
> ---- -Note: C.1 is not explained in the spec for ScPP.
> +Note: Mandatory to support at least one of TSPC_ScPP_1_1 or TSPC_ScPP_1_2.
>  ---------------------------------------------------------------------------
> ----
> 
> 
> diff --git a/android/pixit-scpp.txt b/android/pixit-scpp.txt
> index 105c46a..c8d9f37 100644
> --- a/android/pixit-scpp.txt
> +++ b/android/pixit-scpp.txt
> @@ -1,6 +1,6 @@
>  ScPP PIXIT for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-scpp.txt b/android/pts-scpp.txt
> index d747c49..3fab984 100644
> --- a/android/pts-scpp.txt
> +++ b/android/pts-scpp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for ScPP
> 
> -PTS version: 6.0
> -Tested: 02-February-2015
> -Android version: 5.0
> +PTS version: 6.1
> +Tested: 12-May-2015
> +Android version: 5.1
> 
>  Results:
>  PASS	test passed

Patch applied, thanks.

-- 
BR
Szymon Janc
