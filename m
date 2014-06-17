Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pts: PTS test results for HDP
Date: Tue, 17 Jun 2014 20:25:01 +0200
Message-ID: <1548518.dPhGMuKtEK@athlon>
In-Reply-To: <1403016808-18689-1-git-send-email-sebastianx.chlad@intel.com>
References: <1403016808-18689-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 17 June 2014 17:53:27 Sebastian Chlad wrote:
> ---
>  android/pts-hdp.txt | 110
> ++++++++++++++++++++++++++++++++++++++++------------ 1 file changed, 85
> insertions(+), 25 deletions(-)
> 
> diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
> index 1dec18c..bdf8eca 100644
> --- a/android/pts-hdp.txt
> +++ b/android/pts-hdp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for HDP
> 
>  PTS version: 5.1
> -Tested: not tested
> +Tested: 17-June-2014
>  Android version: 4.4.2
> 
>  Results:
> @@ -13,18 +13,51 @@ N/A	test is disabled due to PICS setup
>  ---------------------------------------------------------------------------
> ---- Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- -TC_SRC_CON_BV_01_I	INC
> -TC_SRC_CON_BV_02_I	INC
> -TC_SRC_CON_BV_03_I	INC
> -TC_SRC_CON_BV_04_I	INC
> -TC_SRC_CON_BV_05_I	INC
> -TC_SRC_CON_BV_06_I	INC
> -TC_SRC_CON_BV_07_I	INC
> -TC_SRC_CON_BV_08_I	INC
> -TC_SRC_CON_BV_09_I	INC
> -TC_SRC_CON_BV_10_I	INC
> -TC_SRC_CC_BV_01_C	INC
> -TC_SRC_CC_BV_02_C	INC
> +TC_SRC_CON_BV_01_I	PASS	haltest:
> +				bluetooth enable
> +
> +				bluetooth set_adapter_property
> +				BT_PROPERTY_ADAPTER_SCAN_MODE
> +				BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE
> +
> +				hl register_application <args>
> +				for instance:
> +				hl register_application health intel heartrate
> +				heartrate-monitor 1 BTHL_MDEP_ROLE_SOURCE 4100
> +				BTHL_CHANNEL_TYPE_RELIABLE testing
> +
> +				when prompted:
> +				bluetooth ssp_reply <args>
> +				for instance:
> +				bluetooth ssp_reply <bdaddr>
> +				BT_SSP_VARIANT_CONSENT 1
> +TC_SRC_CON_BV_02_I	PASS
> +TC_SRC_CON_BV_03_I	PASS	when prompted: bluetooth ssp_reply <args>
> +TC_SRC_CON_BV_04_I	PASS	haltest:
> +				hl connect_channel <app_id> <bd_addr>
> +				<mdep_cfg_index>
> +
> +				when prompted: bluetooth ssp_reply <args>
> +TC_SRC_CON_BV_05_I	PASS	when prompted: bluetooth ssp_reply <args>
> +TC_SRC_CON_BV_06_I	PASS	haltest:
> +				hl connect_channel <app_id> <bd_addr>
> +				<mdep_cfg_index>
> +
> +				when prompted: bluetooth ssp_reply <args>
> +TC_SRC_CON_BV_07_I	PASS	when prompted: bluetooth start_discovery
> +TC_SRC_CON_BV_08_I	PASS	when prompted: bluetooth ssp_reply <args>
> +TC_SRC_CON_BV_09_I	PASS	haltest:
> +				hl connect_channel <app_id> <bd_addr>
> +				<mdep_cfg_index>
> +
> +				when prompted: bluetooth ssp_reply <args>
> +TC_SRC_CON_BV_10_I	N/A
> +TC_SRC_CC_BV_01_C	PASS	haltest:
> +				hl connect_channel <app_id> <bd_addr>
> +				<mdep_cfg_index>
> +
> +				when prompted: bluetooth ssp_reply <args>
> +TC_SRC_CC_BV_02_C	PASS	when prompted: bluetooth ssp_reply <args>
>  TC_SRC_CC_BV_03_C	INC
>  TC_SRC_CC_BV_05_C	INC
>  TC_SRC_CC_BV_07_C	INC
> @@ -41,18 +74,45 @@ TC_SRC_DE_BV_01_I	INC
>  TC_SRC_DE_BV_02_I	INC
>  TC_SRC_DEP_BV_01_I	INC
>  TC_SRC_DEP_BV_02_I	N/A
> -TC_SNK_CON_BV_01_I	INC
> -TC_SNK_CON_BV_02_I	INC
> -TC_SNK_CON_BV_03_I	INC
> -TC_SNK_CON_BV_04_I	INC
> -TC_SNK_CON_BV_05_I	INC
> -TC_SNK_CON_BV_06_I	INC
> -TC_SNK_CON_BV_07_I	INC
> -TC_SNK_CON_BV_08_I	INC
> -TC_SNK_CON_BV_09_I	INC
> -TC_SNK_CON_BV_10_I	INC
> -TC_SNK_CC_BV_01_C	INC
> -TC_SNK_CC_BV_02_C	INC
> +TC_SNK_CON_BV_01_I	PASS	haltest:
> +				hl register_application <args>
> +				for instance:
> +				hl register_application health intel heartrate
> +				heartrate-monitor 1 BTHL_MDEP_ROLE_SINK 4100
> +				BTHL_CHANNEL_TYPE_RELIABLE testing
> +
> +				when prompted:
> +				bluetooth ssp_reply <args>
> +				for instance:
> +				bluetooth ssp_reply <bdaddr>
> +				BT_SSP_VARIANT_CONSENT 1
> +TC_SNK_CON_BV_02_I	PASS
> +TC_SNK_CON_BV_03_I	PASS	when prompted: bluetooth ssp_reply <args>
> +TC_SNK_CON_BV_04_I	PASS	haltest:
> +				hl connect_channel <app_id> <bd_addr>
> +				<mdep_cfg_index>
> +
> +				when prompted: bluetooth ssp_reply <args>
> +TC_SNK_CON_BV_05_I	PASS	when prompted: bluetooth ssp_reply <args>
> +TC_SNK_CON_BV_06_I	PASS	haltest:
> +				hl connect_channel <app_id> <bd_addr>
> +				<mdep_cfg_index>
> +
> +				when prompted: bluetooth ssp_reply <args>
> +TC_SNK_CON_BV_07_I	PASS	when prompted: bluetooth start_discovery
> +TC_SNK_CON_BV_08_I	PASS	when prompted: bluetooth ssp_reply <args>
> +TC_SNK_CON_BV_09_I	PASS	haltest:
> +				hl connect_channel <app_id> <bd_addr>
> +				<mdep_cfg_index>
> +
> +				when prompted: bluetooth ssp_reply <args>
> +TC_SNK_CON_BV_10_I	N/A
> +TC_SNK_CC_BV_01_C	PASS	haltest:
> +				hl connect_channel <app_id> <bd_addr>
> +				<mdep_cfg_index>
> +
> +				when prompted: bluetooth ssp_reply <args>
> +TC_SNK_CC_BV_02_C	PASS	when prompted: bluetooth ssp_reply <args>
>  TC_SNK_CC_BV_04_C	INC
>  TC_SNK_CC_BV_06_C	INC
>  TC_SNK_CC_BV_08_C	INC

Both patches (fixed version of 2/2) applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
