Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PTS GATT results
Date: Wed, 11 Feb 2015 11:32:49 +0100
Message-ID: <9686632.LnFl16scLC@leonov>
In-Reply-To: <1423588718-8256-1-git-send-email-mariusz.skamra@tieto.com>
References: <1423588718-8256-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Tuesday 10 of February 2015 18:18:38 Mariusz Skamra wrote:
> ---
>  android/pics-gatt.txt  | 27 ++++++++++++++++++++-------
>  android/pixit-gatt.txt |  1 +
>  android/pts-gatt.txt   | 26 ++++++++++++++------------
>  3 files changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/android/pics-gatt.txt b/android/pics-gatt.txt
> index 6ff9c55..39c3bc2 100644
> --- a/android/pics-gatt.txt
> +++ b/android/pics-gatt.txt
> @@ -1,6 +1,6 @@
>  GATT PICS for the PTS tool.
> 
> -PTS version: 5.3
> +PTS version: 6.0.1
> 
>  * - different than PTS defaults
> 
> @@ -13,8 +13,8 @@ Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- TSPC_GATT_1_1	True		Generic Attribute Profile Client (C.1)
>  TSPC_GATT_1_2	True		Generic Attribute Profile Server (C.2)
> -TSPC_GATT_1A_1	True		Complete GATT client (C.3)
> -TSPC_GATT_1A_2	True		Complete GATT server (C.4)
> +TSPC_GATT_1_3	True		Complete GATT client (C.3)
> +TSPC_GATT_1_4	True		Complete GATT server (C.4)
>  ---------------------------------------------------------------------------
> ---- C.1: Optional to support IF TSPC_GATT_2_2; else IF TSPC_GATT_2_1 it is
> mandatory to support at least one of TSPC_GATT_1_1 OR TSPC_GATT_1_2
> @@ -45,7 +45,7 @@ C.2: Mandatory IF (SUM ICS 12/7 OR SUM ICS 12/9) is
> supported, otherwise
> ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- -TSPC_GATT_3_1	True		Client: Exchange MTU (C.1)
> +TSPC_GATT_3_1	True		Client: Exchange MTU (C.2)
>  TSPC_GATT_3_2	True		Client: Discover All Primary Services (C.1)
>  TSPC_GATT_3_3	True		Client: Discover Primary Services Service
>  					UUID (C.1)
> @@ -118,7 +118,9 @@ TSPC_GATT_3B_36	True		Client: Characteristic 
Format:
> utf8s (M) TSPC_GATT_3B_37	True		Client: Characteristic Format: utf16s 
(M)
>  TSPC_GATT_3B_38	True		Client: Characteristic Format: struct (M)
>  ---------------------------------------------------------------------------
> ---- -C.1: Mandatory IF TSPC_GATT_1A_1 is supported, otherwise Optional
> +C.1: Mandatory IF TSPC_GATT_1_3 is supported, otherwise Optional
> +C.2: Mandatory IF TSPC_GATT_1_3 AND TSPC_GATT_2_2 is supported, otherwise
> +	Excluded
>  ---------------------------------------------------------------------------
> ----
> 
> 
> @@ -162,7 +164,7 @@ C.1: Mandatory IF service definitions on the server can
> be added, changed, or removed, otherwise Optional
>  C.2: Mandatory IF GATT TSPC_GATT_4_13 is supported, otherwise Optional
>  C.3: Mandatory IF GATT TSPC_GATT_4_15 is supported, otherwise Optional
> -C.4: Mandatory IF GATT TSPC_GATT_1A_2 is supported, otherwise Optional
> +C.4: Mandatory IF GATT TSPC_GATT_1_4 is supported, otherwise Optional
>  ---------------------------------------------------------------------------
> ----
> 
> 
> @@ -246,6 +248,15 @@ C.2: Optional IF TSPC_GATT_2_2 is supported, otherwise
> Excluded
> ---------------------------------------------------------------------------
> ----
> 
> 
> +                Attribute Protocol Client Messages
> +---------------------------------------------------------------------------
> ---- +Parameter Name  Selected        Description
> +---------------------------------------------------------------------------
> ---- +TSPC_GATT_8_1    True            Support for Multiple ATT bearers from
> same +	device (O)
> +---------------------------------------------------------------------------
> ---- +
> +
>  		Attribute Protocol Client Messages
>  ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
> @@ -266,6 +277,7 @@ TSPC_ATT_3_21	True		Signed Write Command (O)
>  TSPC_ATT_3_22	True		Prepare Write Request (O)
>  TSPC_ATT_3_24	True		Execute Write Request (C.8)
>  TSPC_ATT_3_26	True		Handle Value Notification (M)
> +TSPC_ATT_3_28	True		Handle Value Confirmation (M)
>  ---------------------------------------------------------------------------
> ---- C.6: Mandatory IF TSPC_ATT_3_16 is supported, otherwise Excluded
>  C.8: Mandatory IF TSPC_ATT_3_22 is supported, otherwise Excluded
> @@ -288,8 +300,9 @@ TSPC_ATT_4_19	True		Write Response (C.3)
>  TSPC_ATT_4_20	True		Write Command (O)
>  TSPC_ATT_4_21	True		Signed Write Command (O)
>  TSPC_ATT_4_23	True		Prepare Write Response (C.4)
> -TSPC_ATT_4_25	True		Execute Write Response (C.5)
> +TSPC_ATT_4_25	True		Execute Write Response (C.4)
>  TSPC_ATT_4_26	True		Handle Value Notification (O)
> +TSPC_ATT_4_27	True		Handle Value Indication	(O)
>  ---------------------------------------------------------------------------
> ---- C.2: Mandatory IF TSPC_ATT_4_14 is supported, otherwise Excluded
>  C.3: Mandatory IF TSPC_ATT_4_18 is supported, otherwise Excluded
> diff --git a/android/pixit-gatt.txt b/android/pixit-gatt.txt
> index 191e2c9..5699999 100644
> --- a/android/pixit-gatt.txt
> +++ b/android/pixit-gatt.txt
> @@ -28,4 +28,5 @@ TSPX_use_dynamic_pin					FALSE
>  TSPX_delete_ltk						FALSE
>  TSPX_characteristic_readable				FALSE
>  TSPX_tester_appearance					0000
> +TSPX_iut_use_resolvable_random_access			FALSE
>  ---------------------------------------------------------------------------
> ---- diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
> index a452726..3ea3183 100644
> --- a/android/pts-gatt.txt
> +++ b/android/pts-gatt.txt
> @@ -1,7 +1,7 @@
>  PTS test results for GATT
> 
> -PTS version: 5.3
> -Tested: 05-December-2014
> +PTS version: 6.0.1
> +Tested: 02-February-2015
>  Android version: 5.0
> 
>  Results:
> @@ -18,8 +18,7 @@ TC_GAC_CL_BV_01_C	PASS	haltest:
>  				gattc search_service
>  				gattc get_characteristic
>  				gattc write_characteristic: type 3
> -TC_GAC_SR_BV_01_C	PASS	PTS issue #12357
> -				NOTE: tested with ETS attached to errata
> +TC_GAC_SR_BV_01_C	FAIL	JIRA #BA-333
>  				haltest:
>  				gatts add_service
>  				gatts add_chaaracteristic:
> @@ -49,12 +48,14 @@ TC_GAD_CL_BV_02_C	PASS	haltest:
>  				gattc connect
>  				gattc refresh
>  TC_GAD_CL_BV_03_C	PASS	haltest:
> -                                gattc register_client
> -                                gattc scan
> -                                gattc connect
> -                                gattc search_service
> +				gattc register_client
> +				gattc scan
> +				gattc connect
> +				gattc search_service
>  				gattc get_included_service
> -				gattc_disconnect
> +				gattc disconnect
> +				gattc connect
> +				gattc refresh
>  TC_GAD_CL_BV_04_C	PASS	haltest:
>  				when requested: gattc get_characteristic
>  TC_GAD_CL_BV_05_C	PASS	haltest:
> @@ -696,7 +697,7 @@ TC_GAW_CL_BI_32_C	PASS	haltest:
>  				gattc search_service
>  				gattc get_characteristic: srvc_id based on
>  								handle from logs
> -				gattc write_characteristic 2 <long_value>
> +				gattc write_characteristic 3 <value>
>  				gattc execute_write
>  				gattc disconnect
>  TC_GAW_CL_BI_33_C	PASS	haltest:
> @@ -991,7 +992,7 @@ TC_GAW_SR_BI_31_C	PASS	haltest:
>  				gatts add_descriptor: <permmisions> 17
>  				gatts start_service
>  				gatts send_response: <status> 12
> -TC_GAW_SR_BI_32_C	PASS	haltest:
> +TC_GAW_SR_BI_32_C	FAIL	PTS issue #12823 haltest:
>  				gatts add_service
>  				gatts add_characteristic:
>  						<properties> 10 <permissions> 17
> @@ -1077,7 +1078,7 @@ TC_GAT_CL_BV_01_C	PASS	haltest:
>  				gattc get_characteristic: srvc_id based on
>  								handle from logs
>  				gattc read_characcteristic
> -				gattc disconnect
> +				wait for 30 sec timeout
>  TC_GAT_CL_BV_02_C	PASS	haltest:
>  				gattc connect
>  				gattc search_service
> @@ -1085,6 +1086,7 @@ TC_GAT_CL_BV_02_C	PASS	haltest:
>  								handle from logs
>  				gattc write_characcteristic 2 <short_value>
>  				gattc disconnect
> +				wait for 30 sec timeout
>  TC_GAT_SR_BV_01_C	PASS	haltest:
>  				gatts add_service
>  				gatts add_characteristic:

Doesn't apply:
C.2: Mandatory IF TSPC_GATT_1_3 AND TSPC_GATT_2_2 is supported, otherwise 
fatal: 1 line adds whitespace errors.
Patch failed at 0001 android/pts: Update PTS GATT results


-- 
BR
Szymon Janc
