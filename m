Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ruslan Mstoi <ruslan.mstoi@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Updated OPP PICS and PIXITs for PTS 5.3
Date: Tue, 30 Sep 2014 11:26:18 +0200
Message-ID: <3389835.QBqthXGpki@uw000953>
In-Reply-To: <1411739422-25163-1-git-send-email-ruslan.mstoi@intel.com>
References: <1411739422-25163-1-git-send-email-ruslan.mstoi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruslan,

On Friday 26 of September 2014 16:50:22 Ruslan Mstoi wrote:
> ---
>  android/pics-opp.txt  | 6 +++---
>  android/pixit-opp.txt | 2 +-
>  android/pts-opp.txt   | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/android/pics-opp.txt b/android/pics-opp.txt
> index d01865b..b2cf16f 100644
> --- a/android/pics-opp.txt
> +++ b/android/pics-opp.txt
> @@ -1,6 +1,6 @@
>  OPP PICS for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> @@ -23,7 +23,7 @@ C.1: Mandatory to support at least one of the defined roles.
>  -------------------------------------------------------------------------------
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_OPP_1b_1	True		Client supports OPP version 1.1. (C.1)
> +TSPC_OPP_1b_1	True (*)	Client supports OPP version 1.1. (C.1)
>  TSPC_OPP_1b_2	False		Client supports OPP version 1.2. (C.1)
>  -------------------------------------------------------------------------------
>  C.1: It is mandatory to support at least one of the profile versions.
> @@ -107,7 +107,7 @@ C.11: Mandatory if TSPC_OPP_17 and TSPC_OPP_21 supported else excluded.
>  -------------------------------------------------------------------------------
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_OPP_2b_1	True		Server supports OPP version 1.1.
> +TSPC_OPP_2b_1	True (*)	Server supports OPP version 1.1.
>  TSPC_OPP_2b_2	False		Server supports OPP version 1.2.
>  -------------------------------------------------------------------------------
>  C.1: It is mandatory to support at least one of the profile versions.
> diff --git a/android/pixit-opp.txt b/android/pixit-opp.txt
> index 6d7a76b..9cd4bb1 100644
> --- a/android/pixit-opp.txt
> +++ b/android/pixit-opp.txt
> @@ -1,6 +1,6 @@
>  OPP PIXIT for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-opp.txt b/android/pts-opp.txt
> index 8bf89e2..c820885 100644
> --- a/android/pts-opp.txt
> +++ b/android/pts-opp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for OPP
>  
> -PTS version: 5.2
> -Tested: 05-August-2014
> +PTS version: 5.3
> +Tested: 26-September-2014
>  Android version: 4.4.4
>  
>  Results:
> 

Applied. Thanks.

-- 
Best regards, 
Szymon Janc
