Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PTS files for DIS
Date: Mon, 20 Oct 2014 12:08:53 +0200
Message-ID: <2942690.Q9DBQ4VjRo@uw000953>
In-Reply-To: <1413551299-32329-1-git-send-email-sebastian.chlad@tieto.com>
References: <1413551299-32329-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 17 of October 2014 15:08:19 Sebastian Chlad wrote:
> PICS and PIXITs updated to PTS 5.3. Regression done for Android
> 4.4.4.
> ---
>  android/pics-dis.txt  | 2 +-
>  android/pixit-dis.txt | 4 ++--
>  android/pts-dis.txt   | 7 +++++--
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/android/pics-dis.txt b/android/pics-dis.txt
> index 0a1ab3f..169173d 100644
> --- a/android/pics-dis.txt
> +++ b/android/pics-dis.txt
> @@ -1,6 +1,6 @@
>  DIS PICS for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  
> diff --git a/android/pixit-dis.txt b/android/pixit-dis.txt
> index c29ec36..71729fe 100644
> --- a/android/pixit-dis.txt
> +++ b/android/pixit-dis.txt
> @@ -1,6 +1,6 @@
>  DIS PIXIT for the PTS tool.
>  
> -PTS version: 5.2
> +PTS version: 5.3
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> @@ -19,7 +19,7 @@ TSPX_delete_link_key					FALSE
>  TSPX_pin_code						0000
>  TSPX_use_dynamic_pin					FALSE
>  TSPX_delete_ltk						FALSE
> -TSPX_security_enabled					TRUE
> +TSPX_security_enabled					TRUE (*)
>  TSPX_iut_setup_att_over_br_edr				FALSE
>  TSPX_tester_appearance					0000
>  -------------------------------------------------------------------------------
> diff --git a/android/pts-dis.txt b/android/pts-dis.txt
> index 8489430..215baa2 100644
> --- a/android/pts-dis.txt
> +++ b/android/pts-dis.txt
> @@ -1,7 +1,7 @@
>  PTS test results for DIS
>  
> -PTS version: 5.2
> -Tested: 29-July-2014
> +PTS version: 5.3
> +Tested: 18-October-2014
>  Android version: 4.4.4
>  
>  Results:
> @@ -11,6 +11,9 @@ INC	test is inconclusive
>  N/A	test is disabled due to PICS setup
>  NONE	test result is none
>  
> +NOTE: DIS testing might require some extra properties to be set. Please refer
> +to the README file in android folder. Section: Customization.
> +
>  -------------------------------------------------------------------------------
>  Test Name		Result	Notes
>  -------------------------------------------------------------------------------
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
