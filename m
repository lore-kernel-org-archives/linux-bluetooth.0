Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update GATT PTS 6.1 results for android 5.1
Date: Fri, 08 May 2015 14:51:15 +0200
Message-ID: <2287892.zlDqAIPcKO@leonov>
In-Reply-To: <1429894958-26235-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1429894958-26235-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 24 of April 2015 19:02:38 Grzegorz Kolodziejczyk wrote:
> This patch updates test case list, result, pics and major part of
> client test case instructions for GATT profile against android 5.1.
> ---
>  android/pics-gatt.txt  |   15 +-
>  android/pixit-gatt.txt |    2 +-
>  android/pts-gatt.txt   | 1058
> +++++++++++++++++++++++++++++------------------- 3 files changed, 639
> insertions(+), 436 deletions(-)
> 
> diff --git a/android/pics-gatt.txt b/android/pics-gatt.txt
> index ec59853..90585f5 100644
> --- a/android/pics-gatt.txt
> +++ b/android/pics-gatt.txt
> @@ -1,6 +1,6 @@
>  GATT PICS for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
> 
> @@ -13,8 +13,8 @@ Parameter Name	Selected	Description
>  ---------------------------------------------------------------------------
> ---- TSPC_GATT_1_1	True		Generic Attribute Profile Client (C.1)
>  TSPC_GATT_1_2	True		Generic Attribute Profile Server (C.2)
> -TSPC_GATT_1_3	True		Complete GATT client (C.3)
> -TSPC_GATT_1_4	True		Complete GATT server (C.4)
> +TSPC_GATT_1A_1	True		Complete GATT client (C.3)
> +TSPC_GATT_1A_2	True		Complete GATT server (C.4)
>  ---------------------------------------------------------------------------
> ---- C.1: Optional to support IF TSPC_GATT_2_2; else IF TSPC_GATT_2_1 it is
> mandatory to support at least one of TSPC_GATT_1_1 OR TSPC_GATT_1_2
> @@ -248,15 +248,6 @@ C.2: Optional IF TSPC_GATT_2_2 is supported, otherwise
> Excluded
> ---------------------------------------------------------------------------
> ----
> 
> 
> -                Attribute Protocol Client Messages
> ----------------------------------------------------------------------------
> ---- -Parameter Name  Selected        Description
> ----------------------------------------------------------------------------
> ---- -TSPC_GATT_8_1    True            Support for Multiple ATT bearers from
> same -	device (O)
> ----------------------------------------------------------------------------
> ---- -
> -
>  		Attribute Protocol Client Messages
>  ---------------------------------------------------------------------------
> ---- Parameter Name	Selected	Description
> diff --git a/android/pixit-gatt.txt b/android/pixit-gatt.txt
> index 04a5d0b..c6cfaa7 100644
> --- a/android/pixit-gatt.txt
> +++ b/android/pixit-gatt.txt
> @@ -1,6 +1,6 @@
>  GATT PIXIT for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
> index cbb5cee..0f0b706 100644
> --- a/android/pts-gatt.txt
> +++ b/android/pts-gatt.txt
> @@ -1,8 +1,8 @@
>  PTS test results for GATT
> 
> -PTS version: 6.0
> -Tested: 02-February-2015
> -Android version: 5.0
> +PTS version: 6.1
> +Tested: 24-April-2015
> +Android version: 5.1
> 
>  Results:
>  PASS	test passed
> @@ -15,8 +15,8 @@ Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- TC_GAC_CL_BV_01_C	PASS	haltest:
>  				gattc scan
> -				gattc search_service
> -				gattc get_characteristic
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc_uuid>
>  				gattc write_characteristic: type 3
>  TC_GAC_SR_BV_01_C	PASS	PTS issue #13073
>  				TSE #6271
> @@ -32,66 +32,64 @@ TC_GAC_SR_BV_01_C	PASS	PTS issue #13073
>  					<data> value greater than MTU
>  					repeat with correct offset
>  TC_GAD_CL_BV_01_C	PASS	haltest:
> -				gattc register_client
> -				gattc scan
> -				gattc connect
> -				gattc search_service
> -				gattc disconnect
> -				gattc connect
> -				gattc refresh - NOTE: refresh should be called
> -				otherwise services are being read from the cache
> +				NOTE: Repeat following steps if asked
> +				gattc connect <client_id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc disconnect <client_if> <PTS bdaddr>
> +					<conn_id>
>  TC_GAD_CL_BV_02_C	PASS	haltest:
> -				gattc register_client
> -				gattc scan
> -				gattc connect
> -				gattc search_service with given uuid
> -				gattc disconnect
> -				gattc connect
> -				gattc refresh
> +				NOTE: Repeat following steps if asked
> +				gattc connect <client_id> <PTS addr>
> +				gattc search_service <conn_id> <uuid>
> +				gattc disconnect <client_if> <PTS bdaddr>
> +					<conn_id>
>  TC_GAD_CL_BV_03_C	PASS	haltest:
> -				gattc register_client
> -				gattc scan
> -				gattc connect
> -				gattc search_service
> -				gattc get_included_service
> -				gattc_disconnect
> -				gattc connect
> -				gattc refresh
> +				NOTE: Repeat following steps if asked
> +				gattc connect <client_id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> 0x2802 0x08
> +					0x0001 0xffff
> +				NOTE: Keep on mind MTU size
> +					(some att rsp could not fit)
> +				gattc_disconnect <client_if> <PTS bdaddr>
> +					<conn_id>
>  TC_GAD_CL_BV_04_C	PASS	haltest:
> -				when requested: gattc get_characteristic
> +				NOTE: Repeat following steps if asked
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
>  TC_GAD_CL_BV_05_C	PASS	haltest:
> -				when requested: gattc get_characteristic
> -				handle: check from btmon logs
> +				NOTE: Repeat following steps if asked
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> 0x2803 0x08
> +					<start hdl> <end hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAD_CL_BV_06_C	PASS	haltest:
> -				when requested: gattc get_descriptor
> -TC_GAD_CL_BV_07_C	PASS	bluetooth get_remote_services
> -TC_GAD_CL_BV_08_C	PASS	bluetooth get_remote_services
> +				NOTE: Repeat following steps if asked
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <conn_id> <svc_id>
> +					<char_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
> +TC_GAD_CL_BV_07_C	PASS	haltest:
> +				NOTE: Repeat following step if asked
> +				bluetooth get_remote_services
> +TC_GAD_CL_BV_08_C	PASS	haltest:
> +				NOTE: Repear following step if asked
> +				bluetooth get_remote_services
>  TC_GAD_SR_BV_01_C	PASS	haltest:
>  				gattc register_client
>  				gattc listen
> -				gatts register_server
> -				gatts add_service
> -				gatts add_characteristic
> -				gatts start_service
> -				gatts add_service
> -				gatts add_included_service
> -				gatts start_service
>  TC_GAD_SR_BV_02_C	PASS	haltest:
>  				gattc register_client
>  				gattc listen
> -				gatts register_server
> -				gatts add_service
> -				gatts add_characteristic
> -				gatts start_service
> -				gatts add_service
> -				gatts add_included_service
> -				gatts start_service
>  TC_GAD_SR_BV_03_C	PASS	haltest:
>  				gattc register_client
>  				gattc listen
>  				gatts register_server
>  				gatts add_service
> -				gatts add_characteristic
>  				gatts start_service
>  				gatts add_service
>  				gatts add_included_service
> @@ -99,33 +97,12 @@ TC_GAD_SR_BV_03_C	PASS	haltest:
>  TC_GAD_SR_BV_04_C	PASS	haltest:
>  				gattc register_client
>  				gattc listen
> -				gatts register_server
> -				gatts add_service
> -				gatts add_characteristic
> -				gatts start_service
> -				gatts add_service
> -				gatts add_included_service
> -				gatts start_service
>  TC_GAD_SR_BV_05_C	PASS	haltest:
>  				gattc register_client
>  				gattc listen
> -				gatts register_server
> -				gatts add_service
> -				gatts add_characteristic
> -				gatts start_service
> -				gatts add_service
> -				gatts add_included_service
> -				gatts start_service
>  TC_GAD_SR_BV_06_C	PASS	haltest:
>  				gattc register_client
>  				gattc listen
> -				gatts register_server
> -				gatts add_service
> -				gatts add_characteristic
> -				gatts start_service
> -				gatts add_service
> -				gatts add_included_service
> -				gatts start_service
>  TC_GAD_SR_BV_07_C	PASS	haltest:
>  				when requested:
>  				bluetooth get_remote_services
> @@ -135,66 +112,137 @@ TC_GAD_SR_BV_08_C	PASS	haltest:
>  				bluetooth get_remote_services
>  				NOTE: check if found requested service
>  TC_GAR_CL_BV_01_C	PASS	haltest:
> -				gattc read_characteristic
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc read_characteristic <client_id> <svc_id>
> +					<char_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_01_C	PASS	haltest:
> -				gattc read_characteristic
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> 0x0000
> +					0x0a <invalid char hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_02_C	PASS	haltest:
> -				gattc read_characteristic
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc read_characteristic <client_id> <svc_id>
> +					<char_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_03_C	PASS	haltest:
> -				gattc read_characteristic
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> 0x0000
> +					0x0a <inf. auth. att hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_04_C	PASS	haltest:
> -				gattc read_characteristic
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> 0x0000
> +					0x0a <inf. auth. att hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_05_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc read_characteristic
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc read_characteristic <client_id> <svc_id>
> +					<char_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BV_03_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 0x0001 0xffff
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_06_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_07_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_09_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_10_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_11_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BV_04_C	PASS	haltest:
> -				gattc read_characteristic
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				NOTE: Repeat following steps if asked
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc read_characteristic <client_id> <svc_id>
> +					<char_id>
> +				NOTE: After reading all characteristics
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_12_C	PASS	haltest:
> -				gattc read_characteristic
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc read_characteristic <client_id> <svc_id>
> +					<char_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_13_C	PASS	haltest:
> -				gattc test_command <u1> 0x0c
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> 0x0000
> +					0x0c <handle> <offset>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_14_C	PASS	haltest:
> -				gattc test_command <u1> 0x0a
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> 0x0000
> +					0x0a <char_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_15_C	PASS	haltest:
> -				gattc read_characteristic
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc read_characteristic <client_id> <svc_id>
> +					<char_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_16_C	PASS	haltest:
> -				gattc read_characteristic
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc read_characteristic <client_id> <svc_id>
> +					<char_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_17_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc read_characteristic
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc read_characteristic <client_id> <svc_id>
> +					<char_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BV_05_C	N/A
>  TC_GAR_CL_BI_18_C	N/A
>  TC_GAR_CL_BI_19_C	N/A
> @@ -202,52 +250,137 @@ TC_GAR_CL_BI_20_C	N/A
>  TC_GAR_CL_BI_21_C	N/A
>  TC_GAR_CL_BI_22_C	N/A
>  TC_GAR_CL_BV_06_C	PASS	haltest:
> -				gattc read_descriptor
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc read_descriptor <client_id> <svc_id>
> +					<char_id> <desc_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_23_C	PASS	haltest:
> -				gattc read_descriptor
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc read_descriptor <client_id> <svc_id>
> +					<char_id> <desc_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_24_C	PASS	haltest:
> -				gattc read_descriptor
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> 0x0000
> +					0x0a <desc_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_25_C	PASS	haltest:
> -				gattc read_descriptor
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc read_descriptor <client_id> <svc_id>
> +					<char_id> <desc_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_26_C	PASS	haltest:
> -				gattc read_descriptor
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc read_descriptor <client_id> <svc_id>
> +					<char_id> <desc_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_27_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor: srvc_id based on
> -								handle from logs
> -				gattc read_descriptor
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc read_descriptor <client_id> <svc_id>
> +					<char_id> <desc_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BV_07_C	PASS	haltest:
> -				gattc read_descriptor
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				NOTE: Repeat following step if asked
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc read_descriptor <client_id> <svc_id>
> +					<char_id> <desc_id>
> +				NOTE: After reading all characteristics
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_28_C	PASS	haltest:
> -				gattc read_descriptor
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc read_descriptor <client_id> <svc_id>
> +					<char_id> <desc_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_29_C	PASS	haltest:
> -				gattc test_command <u1> 0x0c
> -							<u2> handle <u3>offset
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> 0x0000
> +					0x0c <handle> <offset>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_30_C	PASS	haltest:
> -				gattc read_descriptor
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> 0x0000
> +					0x0a <desc_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_31_C	PASS	haltest:
> -				gattc read_descriptor
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc read_descriptor <client_id> <svc_id>
> +					<char_id> <desc_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_32_C	PASS	haltest:
> -				gattc read_descriptor
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc read_descriptor <client_id> <svc_id>
> +					<char_id> <desc_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_33_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor: srvc_id based on
> -								handle from logs
> -				gattc read_descriptor
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc read_descriptor <client_id> <svc_id>
> +					<char_id> <desc_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_CL_BI_34_C	PASS	haltest:
>  				gattc connect
>  				gattc test_command 224 <addr> 0 0x0a <handle>
>  				gattc disconnect
>  TC_GAR_CL_BI_35_C	PASS	haltest:
> -				gattc read_characteristic
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc read_characteristic <client_id> <svc_id>
> +					<char_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAR_SR_BV_01_C	PASS
>  TC_GAR_SR_BI_01_C	PASS
>  TC_GAR_SR_BI_02_C	PASS
> @@ -462,275 +595,328 @@ TC_GAR_SR_BI_35_C	PASS	haltest:
>  				gatts start_service
>  				gatts send_response <status> 0x80-0x9F
>  TC_GAW_CL_BV_01_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 1 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BV_02_C	PASS	haltest:
> -				gattc connect
> -				bluetooth create_bond
> -				gattc disconnect
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristics
> -				gattc write_characteristics: <type> 4
> -				gattc disconnect
> -
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 4 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BV_03_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 2 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_02_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 225 [u1] 18
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x12
> +					<char_hdl> <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_03_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 2 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_04_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 2 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_05_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 2 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_06_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 2 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BV_05_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 3 <value>
> +				gattc execute_write <conn_id> 1
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_07_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 225 [u1] 22
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x12
> +					<char_hdl> <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_08_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 3 <value>
> +				gattc execute_write <conn_id> 1
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_09_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc test_command <u1> 0x16 <u2> handle
> -							<u3> offset <u4> data
> -				gattc test_command <u1> 0x18 <u2> 1
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x16
> +					<char_hdl> <offset> <data>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x18 1
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_11_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 3 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_12_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 3 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_13_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 3 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BV_06_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 3
> -				gattc execute_write 1
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 3 <value>
> +				gattc execute_write <conn_id> 1
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_14_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 225 [u1] 22
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x16
> +					<char_hdl> <offset> <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_15_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 3 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_17_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 3 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_18_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 3 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_19_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 3 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BV_08_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor
> -				gattc write_descriptor 2 <short_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 2 <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_20_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 225 [u1] 18
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x12
> +					<char_hdl> <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_21_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor
> -				gattc write_descriptor 2 <short_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 2 <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_22_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor
> -				gattc write_descriptor 2 <short_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 2 <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_23_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor
> -				gattc write_descriptor 2 <short_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 2 <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_24_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor
> -				gattc write_descriptor 2 <short_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 2 <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BV_09_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor
> -				gattc write_descriptor 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 3 <data>
> +				gattc execute_write <conn_id> 1
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_25_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 225 [u1] 22
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x16
> +					<char_hdl> <offset> <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_26_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 3 <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_27_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x16
> +					<char_hdl> <offset> <data>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x18 1
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_29_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 3 <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_30_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 3 <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_31_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x16
> +					<desc_hdl> 0x0000 <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_32_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 3 <value>
> -				gattc execute_write
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x16
> +					<desc_hdl> <offset> <data>
> +				gattc test_command 0xe1 <PTS addr> 0x0000 0x18 0
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_33_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 2 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_34_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characteristic 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 2 <value>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_35_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor
> -				gattc write_descriptor 2
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 2 <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_CL_BI_36_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor
> -				gattc write_descriptor 2 <long_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 2 <data>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAW_SR_BV_01_C	PASS	haltest:
>  				gatts add_service
>  				gatts add_characteristic:
> @@ -1029,18 +1215,21 @@ TC_GAW_SR_BI_35_C	PASS	haltest:
>  						repeat with correct offset
>  				gatts send_response: <status> 13
>  TC_GAN_CL_BV_01_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor
> -				gattc write_descriptor 2 <hex_value> 0100
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 2 0x0100
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAN_SR_BV_01_C	PASS	haltest:
>  				gatts add_service
>  				gatts add_chaaracteristic:
>  						<properties> 26 <permissions> 17
>  				gatts add_descriptor: <uuid> 2902
> +					<permission> 11
>  				gatts start_service
>  				gatts send_response
>  				gatts send_response
> @@ -1048,13 +1237,15 @@ TC_GAN_SR_BV_01_C	PASS	haltest:
>  						<attr_handle> char value handle
>  						<confirm> 0
>  TC_GAI_CL_BV_01_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc get_descriptor
> -				gattc write_descriptor 2 <hex_value> 0200
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc get_descriptor <client_id> <svc_id>
> +					<char_id>
> +				gattc write_descriptor <client_id> <svc_id>
> +					<desc_id> 2 0x0200
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAI_SR_BV_01_C	PASS	haltest:
>  				gatts add_service
>  				gatts add_chaaracteristic:
> @@ -1064,8 +1255,9 @@ TC_GAI_SR_BV_01_C	PASS	haltest:
>  				gatts add_service
>  				gatts start_service
>  TC_GAS_CL_BV_01_C	PASS	haltest:
> -				gattc connect
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GAS_SR_BV_01_C	PASS	haltest:
>  				gatts add_service
>  				gatts add_chaaracteristic:
> @@ -1075,19 +1267,18 @@ TC_GAS_SR_BV_01_C	PASS	haltest:
>  				gatts add_service
>  				gatts start_service
>  TC_GAT_CL_BV_01_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc read_characcteristic
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc read_characteristic <conn_id> <svc_id>
> +					<char_id>
>  				wait for 30 sec timeout
>  TC_GAT_CL_BV_02_C	PASS	haltest:
> -				gattc connect
> -				gattc search_service
> -				gattc get_characteristic: srvc_id based on
> -								handle from logs
> -				gattc write_characcteristic 2 <short_value>
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc write_characteristic <client_id> <svc_id>
> +					<char_id> 2 <value>
>  				wait for 30 sec timeout
>  TC_GAT_SR_BV_01_C	PASS	haltest:
>  				gatts add_service
> @@ -1098,37 +1289,58 @@ TC_GAT_SR_BV_01_C	PASS	haltest:
>  				gatts add_service
>  				gatts start_service
>  TC_GPA_CL_BV_01_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GPA_CL_BV_02_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GPA_CL_BV_03_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GPA_CL_BV_04_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GPA_CL_BV_05_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GPA_CL_BV_06_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc connect <client id> <PTS addr>
> +				gattc search_service <conn_id>
> +				gattc get_characteristic <conn_id> <svc uuid>
> +				gattc read_descriptor <conn_id> <svc_id>
> +					<char_id> <desc_id>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GPA_CL_BV_07_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GPA_CL_BV_08_C	PASS	haltest:
> -				gattc connect
> -				test_command: <cmd> 224 [u1] 8
> -				gattc disconnect
> +				gattc connect <client id> <PTS addr>
> +				gattc test_command 0xe0 <PTS addr> <char_uuid>
> +					0x08 <start_hdl> <end_hdl>
> +				gattc disconnect <client_id> <PTS addr>
> +					<conn_id>
>  TC_GPA_CL_BV_11_C	PASS	haltest:
>  				gattc connect
>  				Repeat following steps 5 times:

Applied, thanks.

-- 
BR
Szymon Janc
