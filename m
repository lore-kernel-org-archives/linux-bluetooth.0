Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/pts: Add PIXITs for MCAP and HDP
Date: Mon, 31 Mar 2014 15:34:40 +0200
Message-ID: <9838105.eY70F1DMWa@uw000953>
In-Reply-To: <1396089282-5325-1-git-send-email-sebastian.chlad@tieto.com>
References: <1396089282-5325-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Saturday 29 of March 2014 11:34:39 Sebastian Chlad wrote:
> ---
>  android/pixit-hdp.txt  | 32 ++++++++++++++++++++++++++++++++
>  android/pixit-mcap.txt | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 android/pixit-hdp.txt
>  create mode 100644 android/pixit-mcap.txt
> 
> diff --git a/android/pixit-hdp.txt b/android/pixit-hdp.txt
> new file mode 100644
> index 0000000..24cdcec
> --- /dev/null
> +++ b/android/pixit-hdp.txt
> @@ -0,0 +1,32 @@
> +HDP PIXIT for the PTS tool.
> +
> +PTS version: 5.1
> +
> +* - different than PTS defaults
> +& - should be set to IUT Bluetooth address
> +
> +               Required PIXIT settings
> +-------------------------------------------------------------------------------
> +Parameter Name						Value
> +-------------------------------------------------------------------------------
> +TSPX_security_enabled					TRUE (*)
> +TSPX_delete_link_key					FALSE
> +TSPX_bd_addr_iut					112233445566 (*&)
> +TSPX_sink_device_class_of_device			00900
> +TSPX_source_device_class_of_device			00900
> +TSPX_pin_code						0000
> +TSPX_use_dynamic_pin					FALSE
> +TSPX_use_implicit_send					TRUE
> +TSPX_MCAP_l2cap_psm_control				1001
> +TSPX_MCAP_l2cap_psm_data				1003
> +TSPX_MCAP_sync_lead_time				0BB8
> +TSPX_MCAP_timestamp_native_resolution			2233
> +TSPX_MCAP_timestamp_native_accuracy			1400
> +TSPX_MCAP_timestamp_required_accuracy			6400
> +TSPX_DC_max					1
> +TSPX_secure_simple_pairing_pass_key_confirmation	FALSE
> +TSPX_time_guard						6000000
> +TSPX_ieee_device_specialization				10417
> +TSPX_ieee_standard_configuration			TRUE
> +TSPX_MCAP_bluetooth_clock_access_resolution		55
> +-------------------------------------------------------------------------------
> diff --git a/android/pixit-mcap.txt b/android/pixit-mcap.txt
> new file mode 100644
> index 0000000..ee67a1a
> --- /dev/null
> +++ b/android/pixit-mcap.txt
> @@ -0,0 +1,37 @@
> +MCAP PIXIT for the PTS tool.
> +
> +PTS version: 5.1
> +
> +* - different than PTS defaults
> +& - should be set to IUT Bluetooth address
> +
> +               Required PIXIT settings
> +-------------------------------------------------------------------------------
> +Parameter Name						Value
> +-------------------------------------------------------------------------------
> +TSPX_bd_addr_iut					112233445566 (*&)
> +TSPX_delete_link_key					FALSE
> +TSPX_MCAP_DC_max					2
> +TSPX_MCAP_l2cap_psm_control				1003
> +TSPX_MCAP_l2cap_psm_control_B
> +TSPX_MCAP_l2cap_psm_data				1005
> +TSPX_MCAP_l2cap_psm_data_B
> +TSPX_MCAP_bluetooth_clock_access_resolution		55
> +TSPX_MCAP_create_mdl_configuration
> +TSPX_MCAP_data_channel_setup_mode
> +TSPX_MCAP_iut_initiate_connection			TRUE (*)
> +TSPX_MCAP_mdep_id					12
> +TSPX_MCAP_profile_name
> +TSPX_MCAP_sync_lead_time				0BB8
> +TSPX_tester_role
> +TSPX_MCAP_timestamp_native_accuracy			1400
> +TSPX_MCAP_timestamp_native_resolution			2233
> +TSPX_MCAP_timestamp_required_accuracy			6400
> +TSPX_host_class_of_device				100108
> +TSPX_pin_code						0000
> +TSPX_security_enabled					TRUE (*)
> +TSPX_time_guard						6000000
> +TSPX_use_dynamic_pin					FALSE
> +TSPX_use_implicit_send					TRUE
> +TSPX_verbose_implicit_send				TRUE
> +-------------------------------------------------------------------------------
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
