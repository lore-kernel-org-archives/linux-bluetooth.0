Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update HDP pixits, pics and test results for PTS 6.0
Date: Thu, 19 Feb 2015 10:58:39 +0100
Message-ID: <2018017.xqRjNL9QUC@uw000953>
In-Reply-To: <1424096096-21740-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424096096-21740-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 16 of February 2015 15:14:56 Grzegorz Kolodziejczyk wrote:
> This patch updates test pixits, pics and results for HDP profile against
> android 5.0
> ---
>  android/pics-hdp.txt  |  2 +-
>  android/pixit-hdp.txt |  6 +++---
>  android/pts-hdp.txt   | 51 ++++++++++++++++++++++++++++++++++-----------------
>  3 files changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/android/pics-hdp.txt b/android/pics-hdp.txt
> index 48f7ce1..2f29320 100644
> --- a/android/pics-hdp.txt
> +++ b/android/pics-hdp.txt
> @@ -1,6 +1,6 @@
>  HDP PICS for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-hdp.txt b/android/pixit-hdp.txt
> index e19b1e4..ccf0cf3 100644
> --- a/android/pixit-hdp.txt
> +++ b/android/pixit-hdp.txt
> @@ -1,6 +1,6 @@
>  HDP PIXIT for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> @@ -12,8 +12,8 @@ Parameter Name						Value
>  TSPX_security_enabled					TRUE
>  TSPX_delete_link_key					FALSE
>  TSPX_bd_addr_iut					112233445566 (*&)
> -TSPX_sink_device_class_of_device			00900
> -TSPX_source_device_class_of_device			00900
> +TSPX_sink_device_class_of_device			000900
> +TSPX_source_device_class_of_device			000900
>  TSPX_pin_code						0000
>  TSPX_use_dynamic_pin					FALSE
>  TSPX_use_implicit_send					TRUE
> diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
> index 1d25848..f6bf5cc 100644
> --- a/android/pts-hdp.txt
> +++ b/android/pts-hdp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for HDP
>  
> -PTS version: 5.3
> -Tested: 07-November-2014
> +PTS version: 6.0
> +Tested: 16-February-2015
>  Android version: 5.0
>  
>  Results:
> @@ -14,12 +14,6 @@ N/A	test is disabled due to PICS setup
>  Test Name		Result	Notes
>  -------------------------------------------------------------------------------
>  TC_SRC_CON_BV_01_I	PASS	haltest:
> -				bluetooth enable
> -
> -				bluetooth set_adapter_property
> -				BT_PROPERTY_ADAPTER_SCAN_MODE
> -				BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
> -
>  				hl register_application <args>
>  				for instance:
>  				hl register_application health intel heartrate
> @@ -31,7 +25,8 @@ TC_SRC_CON_BV_01_I	PASS	haltest:
>  				for instance:
>  				bluetooth ssp_reply <bdaddr>
>  				BT_SSP_VARIANT_CONSENT 1
> -TC_SRC_CON_BV_02_I	PASS
> +				Note: IUT must be discoverable, connectable
> +TC_SRC_CON_BV_02_I	PASS	Note: IUT must be in discoverable mode
>  TC_SRC_CON_BV_03_I	PASS	when prompted: bluetooth ssp_reply <args>
>  TC_SRC_CON_BV_04_I	PASS	haltest:
>  				hl connect_channel <app_id> <bd_addr>
> @@ -39,13 +34,16 @@ TC_SRC_CON_BV_04_I	PASS	haltest:
>  
>  				when prompted: bluetooth ssp_reply <args>
>  TC_SRC_CON_BV_05_I	PASS	when prompted: bluetooth ssp_reply <args>
> +				Note: IUT must be in connectable mode
>  TC_SRC_CON_BV_06_I	PASS	haltest:
>  				hl connect_channel <app_id> <bd_addr>
>  				<mdep_cfg_index>
>  
>  				when prompted: bluetooth ssp_reply <args>
> -TC_SRC_CON_BV_07_I	PASS	when prompted: bluetooth start_discovery
> -TC_SRC_CON_BV_08_I	PASS	when prompted: bluetooth ssp_reply <args>
> +TC_SRC_CON_BV_07_I	PASS	bluetooth start_discovery
> +				Note: PTS HDP device must be discovered
> +TC_SRC_CON_BV_08_I	PASS	bluetooth remove_bond <PTS addr>
> +				when prompted: bluetooth ssp_reply <args>
>  TC_SRC_CON_BV_09_I	PASS	haltest:
>  				hl connect_channel <app_id> <bd_addr>
>  				<mdep_cfg_index>
> @@ -58,6 +56,7 @@ TC_SRC_CC_BV_01_C	PASS	haltest:
>  
>  				when prompted: bluetooth ssp_reply <args>
>  TC_SRC_CC_BV_02_C	PASS	when prompted: bluetooth ssp_reply <args>
> +				Note: IUT must be discoverable, connectable
>  TC_SRC_CC_BV_03_C	PASS    haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
> @@ -68,12 +67,12 @@ TC_SRC_CC_BV_03_C	PASS    haltest:
>  				<mdep_cfg_index>
>  
>  				when prompted: bluetooth ssp_reply <args>
> -
>  TC_SRC_CC_BV_05_C	PASS	haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
>  				BTHL_MDEP_ROLE_SOURCE 4100
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
> +				Note: IUT must be discoverable, connectable
>  TC_SRC_CC_BV_07_C	PASS    haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 2
> @@ -99,11 +98,13 @@ TC_SRC_CC_BV_09_C	PASS    haltest:
>  				BTHL_CHANNEL_TYPE_STREAMING pulse-oximeter
>  
>  				when prompted: bluetooth ssp_reply <args>
> +				Note: IUT must be discoverable, connectable
>  TC_SRC_CC_BI_12_C	PASS	haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
>  				BTHL_MDEP_ROLE_SOURCE 4100
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
> +				Note: IUT must be discoverable, connectable
>  TC_SRC_HCT_BV_01_I	PASS    haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
> @@ -119,6 +120,7 @@ TC_SRC_HCT_BV_02_I	PASS	haltest:
>  				bluez-hdp health-device-profile 1
>  				BTHL_MDEP_ROLE_SOURCE 4100
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
> +				Note: IUT must be discoverable, connectable
>  TC_SRC_HCT_BV_03_I	N/A
>  TC_SRC_HCT_BV_04_I	PASS    haltest:
>  				hl register_application bluez-android Bluez
> @@ -127,6 +129,7 @@ TC_SRC_HCT_BV_04_I	PASS    haltest:
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
>  
>  				when prompted: bluetooth ssp_reply <args>
> +				Note: IUT must be discoverable, connectable
>  TC_SRC_HCT_BV_05_C	N/A
>  TC_SRC_HCT_BV_06_C	PASS    haltest:
>  				hl register_application bluez-android Bluez
> @@ -135,6 +138,7 @@ TC_SRC_HCT_BV_06_C	PASS    haltest:
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
>  
>  				when prompted: bluetooth ssp_reply <args>
> +				Note: IUT must be discoverable, connectable
>  TC_SRC_HCT_BV_07_C	PASS	haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
> @@ -146,6 +150,7 @@ TC_SRC_DE_BV_02_I	PASS	haltest:
>  				bluez-hdp health-device-profile 1
>  				BTHL_MDEP_ROLE_SOURCE 4100
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
> +				Note: IUT must be discoverable, connectable
>  TC_SRC_DEP_BV_01_I	N/A
>  TC_SRC_DEP_BV_02_I	N/A
>  TC_SNK_CON_BV_01_I	PASS	haltest:
> @@ -160,21 +165,27 @@ TC_SNK_CON_BV_01_I	PASS	haltest:
>  				for instance:
>  				bluetooth ssp_reply <bdaddr>
>  				BT_SSP_VARIANT_CONSENT 1
> -TC_SNK_CON_BV_02_I	PASS
> +				Note: IUT must be discoverable, connectable
> +TC_SNK_CON_BV_02_I	PASS	Note: IUT must be discoverable, connectable
>  TC_SNK_CON_BV_03_I	PASS	when prompted: bluetooth ssp_reply <args>
> +				Note: IUT must be discoverable, connectable
>  TC_SNK_CON_BV_04_I	PASS	haltest:
>  				hl connect_channel <app_id> <bd_addr>
>  				<mdep_cfg_index>
>  
>  				when prompted: bluetooth ssp_reply <args>
> +				Note: IUT must be discoverable, connectable
>  TC_SNK_CON_BV_05_I	PASS	when prompted: bluetooth ssp_reply <args>
>  TC_SNK_CON_BV_06_I	PASS	haltest:
>  				hl connect_channel <app_id> <bd_addr>
>  				<mdep_cfg_index>
>  
>  				when prompted: bluetooth ssp_reply <args>
> -TC_SNK_CON_BV_07_I	PASS	when prompted: bluetooth start_discovery
> -TC_SNK_CON_BV_08_I	PASS	when prompted: bluetooth ssp_reply <args>
> +TC_SNK_CON_BV_07_I	PASS	bluetooth start_discovery
> +TC_SNK_CON_BV_08_I	PASS	bluetooth remove_bond <PTS addr>
> +
> +				when prompted: bluetooth ssp_reply <args>
> +				Note: IUT must be discoverable, connectable
>  TC_SNK_CON_BV_09_I	PASS	haltest:
>  				hl connect_channel <app_id> <bd_addr>
>  				<mdep_cfg_index>
> @@ -187,6 +198,7 @@ TC_SNK_CC_BV_01_C	PASS	haltest:
>  
>  				when prompted: bluetooth ssp_reply <args>
>  TC_SNK_CC_BV_02_C	PASS	when prompted: bluetooth ssp_reply <args>
> +				Note: IUT must be discoverable, connectable
>  TC_SNK_CC_BV_04_C	PASS    haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
> @@ -197,7 +209,6 @@ TC_SNK_CC_BV_04_C	PASS    haltest:
>  				<mdep_cfg_index>
>  
>  				when prompted: bluetooth ssp_reply <args>
> -
>  TC_SNK_CC_BV_06_C	PASS	haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 2
> @@ -221,7 +232,6 @@ TC_SNK_CC_BV_08_C	PASS    haltest:
>  				when prompted:
>  				hl connect_channel <app_id> <bd_addr>
>  				<mdep_cfg_index>
> -
>  TC_SNK_CC_BV_10_C	PASS	haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 2
> @@ -229,11 +239,13 @@ TC_SNK_CC_BV_10_C	PASS	haltest:
>  				pulse-oximeter
>  				BTHL_MDEP_ROLE_SINK 4100 BTHL_CHANNEL_TYPE_STREAMING
>  				pulse-oximeter
> +				Note: IUT must be discoverable, connectable
>  TC_SNK_CC_BI_11_C	PASS	haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
>  				BTHL_MDEP_ROLE_SINK 4100
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
> +				Note: IUT must be discoverable, connectable
>  TC_SNK_HCT_BV_01_I	PASS    haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
> @@ -249,6 +261,7 @@ TC_SNK_HCT_BV_02_I	PASS	haltest:
>  				bluez-hdp health-device-profile 1
>  				BTHL_MDEP_ROLE_SINK 4100
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
> +				Note: IUT must be discoverable, connectable
>  TC_SNK_HCT_BV_03_I	N/A
>  TC_SNK_HCT_BV_04_I	PASS    haltest:
>  				hl register_application bluez-android Bluez
> @@ -257,23 +270,27 @@ TC_SNK_HCT_BV_04_I	PASS    haltest:
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
>  
>  				when prompted: bluetooth ssp_reply <args>
> +				Note: IUT must be discoverable, connectable
>  TC_SNK_HCT_BV_05_C	N/A
>  TC_SNK_HCT_BV_06_C	PASS	haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
>  				BTHL_MDEP_ROLE_SINK 4100
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
> +				Note: IUT must be discoverable, connectable
>  TC_SNK_HCT_BV_07_C	PASS	haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
>  				BTHL_MDEP_ROLE_SINK 4100
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
> +				Note: IUT must be discoverable, connectable
>  TC_SNK_DE_BV_01_I	N/A
>  TC_SNK_DE_BV_02_I	PASS	haltest:
>  				hl register_application bluez-android Bluez
>  				bluez-hdp health-device-profile 1
>  				BTHL_MDEP_ROLE_SINK 4100
>  				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
> +				Note: IUT must be discoverable, connectable
>  TC_SNK_DEP_BV_03_I	N/A
>  TC_SNK_DEP_BV_04_I	N/A
>  -------------------------------------------------------------------------------
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
