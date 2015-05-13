Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pts: Update GAVDP pixits, pics and test results for PTS 6.1
Date: Wed, 13 May 2015 17:10:05 +0200
Message-ID: <2713037.f6t1vJjQY7@leonov>
In-Reply-To: <1431091913-21208-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1431091913-21208-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 08 of May 2015 15:31:52 Grzegorz Kolodziejczyk wrote:
> This patch updates test pixits, pics and results for GAVDP profile
> against android 5.1.
> ---
>  android/pics-gavdp.txt  | 15 ++++++++-------
>  android/pixit-gavdp.txt |  2 +-
>  android/pts-gavdp.txt   |  6 +++---
>  3 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/android/pics-gavdp.txt b/android/pics-gavdp.txt
> index 1cf12a9..8fa5ac1 100644
> --- a/android/pics-gavdp.txt
> +++ b/android/pics-gavdp.txt
> @@ -1,6 +1,6 @@
>  GAVDP PICS for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> @@ -12,10 +12,11 @@ O - optional
>  ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- -TSPC_GAVDP_1_1	True (*)	Initiator (O.1)
> -TSPC_GAVDP_1_2	True (*)	Initiator (O.1)
> +TSPC_GAVDP_1_1	True (*)	Initiator (C.1)
> +TSPC_GAVDP_1_2	True (*)	Initiator (C.1)
> +---------------------------------------------------------------------------
> ---- +C.1: Mandatory if Acceptor/Initiator is not supported
>  ---------------------------------------------------------------------------
> ---- -
> 
>  		GAVDP Procedures (Initiator)
>  ---------------------------------------------------------------------------
> ---- @@ -31,7 +32,7 @@ TSPC_GAVDP_2_3	False		Transfer Control – Change
> Parameters (O)
> ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- -TSPC_GAVDP_2_1	True		Connection Establishment (M)
> -TSPC_GAVDP_2_2	True (*)	Transfer Control -Suspend (O)
> -TSPC_GAVDP_2_3	False		Transfer Control – Change Parameters (O)
> +TSPC_GAVDP_3_1	True		Connection Establishment (M)
> +TSPC_GAVDP_3_2	True (*)	Transfer Control -Suspend (O)
> +TSPC_GAVDP_3_3	False		Transfer Control – Change Parameters (O)
>  ---------------------------------------------------------------------------
> ---- diff --git a/android/pixit-gavdp.txt b/android/pixit-gavdp.txt
> index 98e7790..0ee9eca 100644
> --- a/android/pixit-gavdp.txt
> +++ b/android/pixit-gavdp.txt
> @@ -1,6 +1,6 @@
>  GAVDP PIXIT for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-gavdp.txt b/android/pts-gavdp.txt
> index 4f6253d..30b59ea 100644
> --- a/android/pts-gavdp.txt
> +++ b/android/pts-gavdp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for GAVDP
> 
> -PTS version: 6.0
> -Tested: 20-February-2015
> -Android version: 5.0
> +PTS version: 6.1
> +Tested: 08-May-2015
> +Android version: 5.1
> 
>  Results:
>  PASS	test passed

Both patches applied, thanks.

-- 
BR
Szymon Janc
