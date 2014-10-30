Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pts: Update GAP PICS and PIXIT
Date: Thu, 30 Oct 2014 09:50:43 +0100
Message-ID: <2222577.K9ku7yrkiX@leonov>
In-Reply-To: <1414502910-17279-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1414502910-17279-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 28 of October 2014 14:28:29 Jakub Tyszkowski wrote:
> This updates PICS and PIXIT setup for PTS 5.3.0.4
> ---
>  android/pics-gap.txt  | 14 +++++++-------
>  android/pixit-gap.txt |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/android/pics-gap.txt b/android/pics-gap.txt
> index bea0329..735eca2 100644
> --- a/android/pics-gap.txt
> +++ b/android/pics-gap.txt
> @@ -1,6 +1,6 @@
>  GAP PICS for the PTS tool.
> 
> -PTS version: 5.2
> +PTS version: 5.3
> 
>  * - different than PTS defaults
> 
> @@ -224,7 +224,7 @@ TSPC_GAP_9_1	False (*)	Broadcaster: Non-Connectable 
Mode
> Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- TSPC_GAP_10_1	False (*)	Broadcaster: Broadcast Mode
> -TSPC_GAP_11_1	False (*)	Broadcaster: Privacy Feature
> +TSPC_GAP_11_1	False (*)	Broadcaster: Privacy Feature v.1.0
>  TSPC_GAP_11_1A	False (*)	Broadcaster: Privacy Feature v1.1 (O)
>  TSPC_GAP_11_2	False (*)	Broadcaster: Resolvable Private Address
>  					Generation Procedure
> @@ -280,7 +280,7 @@ TSPC_GAP_16_1	False (*)	Observer: Observation 
Procedure
>  ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- -TSPC_GAP_17_1	False (*)	Observer: Privacy Feature (O)
> +TSPC_GAP_17_1	False (*)	Observer: Privacy Feature v1.0 (O)
>  TSPC_GAP_17_1A	False (*)	Observer: Privacy Feature v1.1 (O)
>  TSPC_GAP_17_2	False (*)	Observer: Non-Resolvable Private Address
>  					Generation Procedure (C.1)
> @@ -460,7 +460,7 @@ C.2: Mandatory if TSPC_GAP_0A_1 and TSPC_GAP_27_4 are
> supported,
> ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- -TSPC_GAP_26_1	False (*)	Peripheral: Privacy Feature (O)
> +TSPC_GAP_26_1	False (*)	Peripheral: Privacy Feature v1.0 (O)
>  TSPC_GAP_26_1A	True		Peripheral: Privacy Feature v1.1 (O)
>  TSPC_GAP_26_2	True		Peripheral: Non-Resolvable Private Address
>  					Generation Procedure (C.1)
> @@ -624,13 +624,13 @@ C.1: Optional if TSPC_GAP_35_1 is supported, otherwise
> Excluded.
> ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- -TSPC_GAP_36_1	True		Central: Privacy Feature (C.3)
> +TSPC_GAP_36_1	False (*)	Central: Privacy Feature v1.0 (C.2)
>  TSPC_GAP_36_1A	True		Central: Privacy Feature v1.1 (C.4)
>  TSPC_GAP_36_2	True		Central: Non-Resolvable Private Address
>  					Generation Procedure (C.1)
>  TSPC_GAP_36_3	True		Central: Resolvable Private Address Resolution
>  					Procedure (C.2)
> -TSPC_GAP_36_4	True		Central: Write to Privacy Characteristic
> +TSPC_GAP_36_4	False (*)	Central: Write to Privacy Characteristic
>  					(Enable/Disable Privacy) (O)
>  TSPC_GAP_36_5	True		Central: Resolvable Private Address Generation
>  					Procedure (C.6)
> @@ -721,7 +721,7 @@ TSPC_GAP_42_1	True		Peripheral BR/EDR/LE:
> Non-Discoverable Mode (See Spec)
>  TSPC_GAP_42_2	True		Peripheral BR/EDR/LE: Discoverable Mode
>  				(See Spec)
> -TSPC_GAP_42_3	False (*)	Peripheral BR/EDR/LE: Non-Connectable Mode
> +TSPC_GAP_42_3	True		Peripheral BR/EDR/LE: Non-Connectable Mode
>  				(See Spec)
>  TSPC_GAP_42_4	True		Peripheral BR/EDR/LE: Connectable Mode (M)
>  TSPC_GAP_42_5	True		Peripheral BR/EDR/LE: Non-Bondable Mode
> diff --git a/android/pixit-gap.txt b/android/pixit-gap.txt
> index 921f10a..6bde304 100644
> --- a/android/pixit-gap.txt
> +++ b/android/pixit-gap.txt
> @@ -1,6 +1,6 @@
>  GAP PIXIT for the PTS tool.
> 
> -PTS version: 5.2
> +PTS version: 5.3
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> @@ -31,7 +31,7 @@ TSPX_gen_disc_scan_min					10240
>  TSPX_database_file					Database-GAP.sig
>  TSPX_iut_rx_mtu						23
>  TSPX_iut_private_address_interval			10000
> -TSPX_iut_privacy_enabled				False
> +TSPX_iut_privacy_enabled				True (*)
>  TSPX_psm						1001
>  TSPX_iut_valid_connection_interval_min			00C8
>  TSPX_iut_valid_conneciton_interval_max			0960

Both patches applied, thanks.

-- 
BR
Szymon Janc
