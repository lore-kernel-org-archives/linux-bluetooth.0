Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pts: Update HFP PIXIT, PICS for PTS 6.0
Date: Fri, 20 Feb 2015 17:03:32 +0100
Message-ID: <1697147.pIi0Ureryl@uw000953>
In-Reply-To: <1424281547-4454-1-git-send-email-mariusz.skamra@tieto.com>
References: <1424281547-4454-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Wednesday 18 of February 2015 18:45:46 Mariusz Skamra wrote:
> ---
>  android/pics-hfp.txt  | 15 ++++++---------
>  android/pixit-hfp.txt |  2 +-
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/android/pics-hfp.txt b/android/pics-hfp.txt
> index da0eb23..ea81289 100644
> --- a/android/pics-hfp.txt
> +++ b/android/pics-hfp.txt
> @@ -90,7 +90,7 @@ TSPC_HFP_2_26	False		HF Indicators (C.11)
>  TSPC_HFP_2_27	False		Support CVSD eSCO s4 setting (C.12)
>  -------------------------------------------------------------------------------
>  C.1:  The AG must support one of item TSPC_HFP_2_4a or TSPC_HFP_2_4b
> -C.2:  Mandatory if TSPC_HFP_2_12is TRUE; otherwise excluded
> +C.2:  Mandatory if TSPC_HFP_2_12 is TRUE; otherwise excluded
>  C.3:  Optional if TSPC_HFP_2_12 is TRUE; otherwise excluded
>  C.4:  The AG must support one of item TSPC_HFP_2_21a or TSPC_HFP_2_21c
>  C.5:  Mandatory if TSPC_HFP_2_18a or TSPC_HFP_2_18b; otherwise optional
> @@ -98,7 +98,7 @@ C.6:  Optional if TSPC_HFP_2_15 is supported, otherwise excluded
>  C.7:  Mandatory if TSPC_HFP_2_24 otherwise excluded
>  C.8:  Excluded if TSPC_HFP_0_1 otherwise optional
>  C.9:  Excluded if TSPC_HFP_0_1 otherwise mandatory
> -C.10: Mandatory if TSPC_HFP_2_24 otherwise optional
> +C.10: Mandatory if TSPC_HFP_2_27 or TSPC_HFP_2_24 otherwise optional
>  C.11: Optional IF HFP v1.5 (TSPC_HFP_0_1) OR HFP v1.6 (TSPC_HFP_0_2) is NOT
>  	supported, otherwise Excluded.
>  C.12: Excluded IF HFP v1.5 (TSPC_HFP_0_1) OR HFP v1.6 (TSPC_HFP_0_2) is
> @@ -131,7 +131,6 @@ TSPC_HFP_3_4c	False		Accept an incoming voice call (in-band ring
>  					muting) (O)
>  TSPC_HFP_3_5	False (*)	Reject an incoming voice call (M)
>  TSPC_HFP_3_6	False (*)	Terminate a call (M)
> -
>  TSPC_HFP_3_7	False (*)	Audio connection transfer during an ongoing
>  					call (M)
>  TSPC_HFP_3_7a	False		HF-initiated Audio transfer to AG during
> @@ -166,7 +165,7 @@ TSPC_HFP_3_20	False		Subscriber Number Information (O)
>  TSPC_HFP_3_21a	False		Enhanced Call Status (O)
>  TSPC_HFP_3_21b	False		Enhanced Call Control (C.2)
>  TSPC_HFP_3_22	False		Support for automatic link loss recovery (O)
> -TSPC_HFP_3_23	False		Individual Indicator Activation (C.6)
> +TSPC_HFP_3_23	False (*)	Individual Indicator Activation (C.6)
>  TSPC_HFP_3_24	False		Wide Band Speech service (C.6)
>  TSPC_HFP_3_25	False		HF Indicators (C.8)
>  TSPC_HFP_3_26	False		Support CVSD eSCO S4 setting (C.9)
> @@ -174,10 +173,10 @@ TSPC_HFP_3_26	False		Support CVSD eSCO S4 setting (C.9)
>  C.1: Mandatory if TSPC_HFP_3_12; otherwise excluded
>  C.2: Optional if TSPC_HFP_3_12; otherwise excluded
>  C.3: Mandatory if TSPC_HFP_3_18a or TSPC_HFP_3_18b, otherwise optional
> -C.4: Mandatory if TSPC_HFP_3_18a, otherwise optional
> +C.4: Mandatory if TSPC_HFP_3_18b, otherwise optional
>  C.5: Mandatory if TSPC_HFP_3_24 otherwise excluded
>  C.6: Excluded if TSPC_HFP_0_1 otherwise optional
> -C.7: Mandatory if TSPC_HFP_3_24 otherwise optional
> +C.7: Mandatory if TSPC_HFP_3_26 or TSPC_HFP_3_24 otherwise optional
>  C.8: Optional IF HFP v1.5 (TSPC_HFP_0_1) OR HFP v1.6 (TSPC_HFP_0_2) is NOT
>  	supported, otherwise Excluded.
>  C.9: Excluded IF HFP v1.5 (TSPC_HFP_0_1) OR HFP v1.6 (TSPC_HFP_0_2) is
> @@ -196,9 +195,7 @@ TSPC_HFP_4_2	True (*)	CVSD audio coding over eSCO (Accepting) (C.2)
>  -------------------------------------------------------------------------------
>  C.1: Mandatory if Wide band speech service is supported TSPC_HFP_2_24 or
>  	TSPC_HFP_3_24, otherwise excluded
> -C.2: Mandatory IF TPSC_HFP_2_3b (eSCO support in Audio Connection - AG) OR
> -	TSPC_HFP_3_3b (eSCO support in Audio Connection - HF); otherwise
> -	Excluded.
> +C.2: Mandatory IF TPSC_HFP_2_3b OR TSPC_HFP_3_3b; otherwise	Excluded.
>  -------------------------------------------------------------------------------
>  
>  
> diff --git a/android/pixit-hfp.txt b/android/pixit-hfp.txt
> index bf1b7e5..dfae9bf 100644
> --- a/android/pixit-hfp.txt
> +++ b/android/pixit-hfp.txt
> @@ -1,6 +1,6 @@
>  HFP PIXIT for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address

Both patches applied, thanks. 

-- 
Best regards, 
Szymon Janc
