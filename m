Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pics: Update PICS to PTS 5.0 for GAP
Date: Wed, 08 Jan 2014 14:19:29 +0100
Message-ID: <4744243.WviYpXJz18@uw000953>
In-Reply-To: <1389174407-28486-1-git-send-email-sebastianx.chlad@intel.com>
References: <1389174407-28486-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

> Add new PICS settings for the GAP profile in accordance with PTS 5.0
> ---
>  android/pics-gap.txt | 44 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/android/pics-gap.txt b/android/pics-gap.txt
> index e8ab2ab..56a33d5 100644
> --- a/android/pics-gap.txt
> +++ b/android/pics-gap.txt
> @@ -1,5 +1,7 @@
>  GAP PICS for the PTS tool.
>  
> +PTS version: 5.0
> +
>  * - different than PTS defaults
>  # - not yet implemented/supported
>  
> @@ -668,19 +670,33 @@ TSPC_GAP_41_1	True (#)	Central BR/EDR/LE: Security Aspects (M)
>  -------------------------------------------------------------------------------
>  
>  
> +		Central Simultaneous BR/EDR and LE Transports
> +-------------------------------------------------------------------------------
> +Parameter Name	Selected	Description
> +-------------------------------------------------------------------------------
> +TSPC_GAP_42_1	False		Simultaneous BR/EDR and LE Transports –	BR/EDR
> +					Slave to the same device (C.1)
> +TSPC_GAP_42_2	False		Simultaneous BR/EDR and LE Transports – BR/EDR
> +					Master to the same device (C.1)
> +-------------------------------------------------------------------------------
> +C.1: Optional if ((SUM ICS 31/14 (Core Spec Version 4.1) or SUM ICS 31/15
> +	(Core Spec Version 4.1+HS)) is supported, otherwise Excluded.
> +-------------------------------------------------------------------------------
> +
> +
>  		Peripheral BR/EDR/LE Modes
>  -------------------------------------------------------------------------------
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_GAP_42_1	False		Peripheral BR/EDR/LE: Non-Discoverable Mode
> +TSPC_GAP_43_1	False		Peripheral BR/EDR/LE: Non-Discoverable Mode
>  				(C.1)
> -TSPC_GAP_42_2	False		Peripheral BR/EDR/LE: Discoverable Mode
> +TSPC_GAP_43_2	False		Peripheral BR/EDR/LE: Discoverable Mode
>  				(C.2)
> -TSPC_GAP_42_3	False		Peripheral BR/EDR/LE: Non-Connectable Mode
> +TSPC_GAP_43_3	False		Peripheral BR/EDR/LE: Non-Connectable Mode
>  				(C.3)
> -TSPC_GAP_42_4	False (*)	Peripheral BR/EDR/LE: Connectable Mode  (M)
> -TSPC_GAP_42_5	False		Peripheral BR/EDR/LE: Non-Bondable Mode (C.4)
> -TSPC_GAP_42_6	False		Peripheral BR/EDR/LE: Bondable Mode (C.5)
> +TSPC_GAP_43_4	False (*)	Peripheral BR/EDR/LE: Connectable Mode  (M)
> +TSPC_GAP_43_5	False		Peripheral BR/EDR/LE: Non-Bondable Mode (C.4)
> +TSPC_GAP_43_6	False		Peripheral BR/EDR/LE: Bondable Mode (C.5)
>  -------------------------------------------------------------------------------
>  C.1: Mandatory if TSPC_GAP_1_1 is supported over BR/EDR, otherwise Excluded.
>  C.2: Mandatory if (TSPC_GAP_1_2 or TSPC_GAP_1_3) is supported over BR/EDR,
> @@ -695,7 +711,21 @@ C.5: Mandatory if TSPC_GAP_1_7 is supported over BR/EDR, otherwise Excluded.
>  -------------------------------------------------------------------------------
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_GAP_43_1	False (*)	Peripheral BR/EDR/LE: Security Aspects (M)
> +TSPC_GAP_44_1	False (*)	Peripheral BR/EDR/LE: Security Aspects (M)
> +-------------------------------------------------------------------------------
> +
> +
> +		Peripheral Simultaneous BR/EDR and LE Transports
> +-------------------------------------------------------------------------------
> +Parameter Name	Selected	Description
> +-------------------------------------------------------------------------------
> +TSPC_GAP_45_1	False		Simultaneous BR/EDR and LE Transports – BR/EDR
> +					Slave to the same device (C.1)
> +TSPC_GAP_45_2	False		Simultaneous BR/EDR and LE Transports – BR/EDR
> +					Master to the same device (C.1)
> +-------------------------------------------------------------------------------
> +C.1: Optional if ((SUM ICS 31/14 (Core Spec Version 4.1) or SUM ICS 31/15
> +(Core Spec Version 4.1+HS)) is supported, otherwise Excluded.
>  -------------------------------------------------------------------------------
>  
>  
> 

Applied, thanks.

-- 
BR
Szymon Janc

