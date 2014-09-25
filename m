Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] android/client: Add skeleton for handsfree client interface
Date: Thu, 25 Sep 2014 20:54:26 +0200
Message-ID: <50418154.clI02vujnm@athlon>
In-Reply-To: <1411454980-27225-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411454980-27225-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 23 September 2014 08:49:36 Jakub Tyszkowski wrote:
> ---
>  android/Android.mk            |   4 +
>  android/Makefile.am           |   4 +-
>  android/client/haltest.c      |   8 +-
>  android/client/if-bt.c        |   7 +
>  android/client/if-hf-client.c | 342
> ++++++++++++++++++++++++++++++++++++++++++ android/client/if-main.h      | 
> 10 ++
>  6 files changed, 373 insertions(+), 2 deletions(-)
>  create mode 100644 android/client/if-hf-client.c
> 

Doesn't apply anymore (due to changes in Makefile.am) so this needs to be 
rebased (I think V2 of just 1st patch should be enough).


> diff --git a/android/Android.mk b/android/Android.mk
> index 8887a97..ead552c 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -179,6 +179,10 @@ LOCAL_SRC_FILES := \
>  	bluez/android/client/if-gatt.c \
>  	bluez/android/hal-utils.c \
> 
> +ifeq ($(BLUEZ_EXTENSIONS), true)
> +LOCAL_SRC_FILES += bluez/android/client/if-hf-client.c
> +endif
> +
>  LOCAL_C_INCLUDES += \
>  	$(call include-path-for, system-core) \
>  	$(call include-path-for, libhardware) \
> diff --git a/android/Makefile.am b/android/Makefile.am
> index b576fda..5d36ec8 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -139,6 +139,7 @@ android_haltest_SOURCES = android/client/haltest.c \
>  				android/client/if-bt.c \
>  				android/client/if-gatt.c \
>  				android/client/if-hf.c \
> +				android/client/if-hf-client.c \
>  				android/client/if-hh.c \
>  				android/client/if-pan.c \
>  				android/client/if-hl.c \
> @@ -149,7 +150,8 @@ android_haltest_SOURCES = android/client/haltest.c \
>  				android/hal-utils.h android/hal-utils.c
> 
>  android_haltest_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
> -				-DPLUGINDIR=\""$(android_plugindir)"\"
> +				-DPLUGINDIR=\""$(android_plugindir)"\" \
> +				-DBLUEZ_EXTENSIONS

BLUEZ_EXTENSIONS is now added to AM_CFLAGS so this is not needed anymore.

> 
>  android_haltest_LDFLAGS = -pthread -ldl -lm
> 
> diff --git a/android/client/haltest.c b/android/client/haltest.c
> index d86fe49..540694d 100644
> --- a/android/client/haltest.c
> +++ b/android/client/haltest.c
> @@ -44,6 +44,9 @@ const struct interface *interfaces[] = {
>  	&pan_if,
>  	&hl_if,
>  	&sock_if,
> +#ifdef BLUEZ_EXTENSIONS
> +	&hf_client_if,
> +#endif
>  	NULL
>  };
> 
> @@ -390,7 +393,10 @@ static void init(void)
>  		BT_PROFILE_HIDHOST_ID,
>  		BT_PROFILE_PAN_ID,
>  		BT_PROFILE_GATT_ID,
> -		BT_PROFILE_SOCKETS_ID
> +		BT_PROFILE_SOCKETS_ID,
> +#ifdef BLUEZ_EXTENSIONS
> +		BT_PROFILE_HANDSFREE_CLIENT_ID,
> +#endif
>  	};
>  	const struct method *m;
>  	const char *argv[4];
> diff --git a/android/client/if-bt.c b/android/client/if-bt.c
> index 218e254..4e491a5 100644
> --- a/android/client/if-bt.c
> +++ b/android/client/if-bt.c
> @@ -732,6 +732,9 @@ static void get_profile_interface_c(int argc, const char
> **argv, BT_PROFILE_PAN_ID,
>  		BT_PROFILE_GATT_ID,
>  		BT_PROFILE_AV_RC_ID,
> +#ifdef BLUEZ_EXTENSIONS
> +		BT_PROFILE_HANDSFREE_CLIENT_ID,
> +#endif
>  		NULL
>  	};
> 
> @@ -770,6 +773,10 @@ static void get_profile_interface_p(int argc, const
> char **argv) pif = (const void **) &if_rc;
>  	else if (strcmp(BT_PROFILE_GATT_ID, id) == 0)
>  		pif = (const void **) &if_gatt;
> +#ifdef BLUEZ_EXTENSIONS
> +	else if (strcmp(BT_PROFILE_HANDSFREE_CLIENT_ID, id) == 0)
> +		pif = (const void **) &if_hf_client;
> +#endif
>  	else
>  		haltest_error("%s is not correct for get_profile_interface\n",
>  									id);
> diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
> new file mode 100644
> index 0000000..38ae42a
> --- /dev/null
> +++ b/android/client/if-hf-client.c
> @@ -0,0 +1,342 @@
> +/*
> + * Copyright (C) 2014 Intel Corporation
> + *
> + * Licensed under the Apache License, Version 2.0 (the "License");
> + * you may not use this file except in compliance with the License.
> + * You may obtain a copy of the License at
> + *
> + *      http://www.apache.org/licenses/LICENSE-2.0
> + *
> + * Unless required by applicable law or agreed to in writing, software
> + * distributed under the License is distributed on an "AS IS" BASIS,
> + * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
> + * See the License for the specific language governing permissions and + *
> limitations under the License.
> + *
> + */
> +
> +#include "if-main.h"
> +#include "../hal-utils.h"
> +
> +const bthf_client_interface_t *if_hf_client = NULL;
> +
> +static char last_addr[MAX_ADDR_STR_LEN];
> +
> +/* Callback for connection state change. */
> +static void hf_client_connection_state_callback(
> +					bthf_client_connection_state_t state,
> +					unsigned int peer_feat,
> +					unsigned int chld_feat,
> +					bt_bdaddr_t *bd_addr)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for audio connection state change. */
> +static void hf_client_audio_state_callback(bthf_client_audio_state_t state,
> +							bt_bdaddr_t *bd_addr)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for VR connection state change. */
> +static void hf_client_vr_cmd_callback(bthf_client_vr_state_t state)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for network state change */
> +static void hf_client_network_state_callback(bthf_client_network_state_t
> state) +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for network roaming status change */
> +static void hf_client_network_roaming_callback(bthf_client_service_type_t
> type) +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for signal strength indication */
> +static void hf_client_network_signal_callback(int signal_strength)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for battery level indication */
> +static void hf_client_battery_level_callback(int battery_level)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for current operator name */
> +static void hf_client_current_operator_callback(const char *name)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for call indicator */
> +static void hf_client_call_callback(bthf_client_call_t call)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for callsetup indicator */
> +static void hf_client_callsetup_callback(bthf_client_callsetup_t callsetup)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for callheld indicator */
> +static void hf_client_callheld_callback(bthf_client_callheld_t callheld)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for response and hold */
> +static void hf_client_resp_and_hold_callback(
> +				bthf_client_resp_and_hold_t resp_and_hold)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for Calling Line Identification notification */
> +static void hf_client_clip_callback(const char *number)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for Call Waiting notification */
> +static void hf_client_call_waiting_callback(const char *number)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for listing current calls. Can be called multiple time. */
> +static void hf_client_current_calls_callback(int index,
> +					bthf_client_call_direction_t dir,
> +					bthf_client_call_state_t state,
> +					bthf_client_call_mpty_type_t mpty,
> +					const char *number)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for audio volume change */
> +static void hf_client_volume_change_callback(bthf_client_volume_type_t
> type, +								int volume)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for command complete event */
> +static void hf_client_cmd_complete_callback(bthf_client_cmd_complete_t
> type, +									int cme)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for subscriber information */
> +static void hf_client_subscriber_info_callback(const char *name,
> +				bthf_client_subscriber_service_type_t type)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for in-band ring tone settings */
> +static void hf_client_in_band_ring_tone_callback(
> +				bthf_client_in_band_ring_state_t state)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for requested number from AG */
> +static void hf_client_last_voice_tag_number_callback(const char *number)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +/* Callback for sending ring indication to app */
> +static void hf_client_ring_indication_callback(void)
> +{
> +	haltest_info("%s\n", __func__);
> +}
> +
> +static bthf_client_callbacks_t hf_client_cbacks = {
> +	.size = sizeof(hf_client_cbacks),
> +	.connection_state_cb = hf_client_connection_state_callback,
> +	.audio_state_cb = hf_client_audio_state_callback,
> +	.vr_cmd_cb = hf_client_vr_cmd_callback,
> +	.network_state_cb = hf_client_network_state_callback,
> +	.network_roaming_cb = hf_client_network_roaming_callback,
> +	.network_signal_cb = hf_client_network_signal_callback,
> +	.battery_level_cb = hf_client_battery_level_callback,
> +	.current_operator_cb = hf_client_current_operator_callback,
> +	.call_cb = hf_client_call_callback,
> +	.callsetup_cb = hf_client_callsetup_callback,
> +	.callheld_cb = hf_client_callheld_callback,
> +	.resp_and_hold_cb = hf_client_resp_and_hold_callback,
> +	.clip_cb = hf_client_clip_callback,
> +	.call_waiting_cb = hf_client_call_waiting_callback,
> +	.current_calls_cb = hf_client_current_calls_callback,
> +	.volume_change_cb = hf_client_volume_change_callback,
> +	.cmd_complete_cb = hf_client_cmd_complete_callback,
> +	.subscriber_info_cb = hf_client_subscriber_info_callback,
> +	.in_band_ring_tone_cb = hf_client_in_band_ring_tone_callback,
> +	.last_voice_tag_number_callback =
> +				hf_client_last_voice_tag_number_callback,
> +	.ring_indication_cb = hf_client_ring_indication_callback,
> +};
> +
> +/* init */
> +static void init_p(int argc, const char **argv)
> +{
> +	RETURN_IF_NULL(if_hf_client);
> +
> +	EXEC(if_hf_client->init, &hf_client_cbacks);
> +}
> +
> +static void connect_c(int argc, const char **argv, enum_func *enum_func,
> +								void **user)
> +{
> +}
> +
> +/* connect to audio gateway */
> +static void connect_p(int argc, const char **argv)
> +{
> +}
> +
> +/*
> + * This completion function will be used for several methods
> + * returning recently connected address
> + */
> +static void connected_addr_c(int argc, const char **argv, enum_func
> *enum_func, +								void **user)
> +{
> +	if (argc == 3) {
> +		*user = last_addr;
> +		*enum_func = enum_one_string;
> +	}
> +}
> +
> +/* Map completion to connected_addr_c */
> +#define disconnect_c connected_addr_c
> +
> +/* disconnect from audio gateway */
> +static void disconnect_p(int argc, const char **argv)
> +{
> +}
> +
> +static void connect_audio_c(int argc, const char **argv, enum_func
> *enum_func, +								void **user)
> +{
> +}
> +
> +/* create an audio connection */
> +static void connect_audio_p(int argc, const char **argv)
> +{
> +}
> +
> +/* Map completion to connected_addr_c */
> +#define disconnect_audio_c connected_addr_c
> +
> +/* close the audio connection */
> +static void disconnect_audio_p(int argc, const char **argv)
> +{
> +}
> +
> +/* start voice recognition */
> +static void start_voice_recognition_p(int argc, const char **argv)
> +{
> +}
> +
> +/* stop voice recognition */
> +static void stop_voice_recognition_p(int argc, const char **argv)
> +{
> +}
> +
> +static void volume_control_c(int argc, const char **argv, enum_func
> *enum_func, +								void **user)
> +{
> +}
> +
> +/* volume control */
> +static void volume_control_p(int argc, const char **argv)
> +{
> +}
> +
> +/* place a call with number a number */
> +static void dial_p(int argc, const char **argv)
> +{
> +}
> +
> +/* place a call with number specified by location (speed dial) */
> +static void dial_memory_p(int argc, const char **argv)
> +{
> +}
> +
> +static void handle_call_action_c(int argc, const char **argv,
> +					enum_func *enum_func, void **user)
> +{
> +}
> +
> +/* perform specified call related action */
> +static void handle_call_action_p(int argc, const char **argv)
> +{
> +}
> +
> +/* query list of current calls */
> +static void query_current_calls_p(int argc, const char **argv)
> +{
> +}
> +
> +/* query name of current selected operator */
> +static void query_current_operator_name_p(int argc, const char **argv)
> +{
> +}
> +
> +/* Retrieve subscriber information */
> +static void retrieve_subscriber_info_p(int argc, const char **argv)
> +{
> +}
> +
> +/* Send DTMF code*/
> +static void send_dtmf_p(int argc, const char **argv)
> +{
> +}
> +
> +/* Request a phone number from AG corresponding to last voice tag recorded
> */ +static void request_last_voice_tag_number_p(int argc, const char
> **argv) +{
> +}
> +
> +/* Closes the interface. */
> +static void cleanup_p(int argc, const char **argv)
> +{
> +}
> +
> +static struct method methods[] = {
> +	STD_METHOD(init),
> +	STD_METHODCH(connect, "<addr>"),
> +	STD_METHODCH(disconnect, "<addr>"),
> +	STD_METHODCH(connect_audio, "<addr>"),
> +	STD_METHODCH(disconnect_audio, "<addr>"),
> +	STD_METHOD(start_voice_recognition),
> +	STD_METHOD(stop_voice_recognition),
> +	STD_METHODCH(volume_control, "<volume_type> <value>"),
> +	STD_METHODH(dial, "<destination_number>"),
> +	STD_METHODH(dial_memory, "<memory_location>"),
> +	STD_METHODCH(handle_call_action, "<call_action> <call_index>"),
> +	STD_METHOD(query_current_calls),
> +	STD_METHOD(query_current_operator_name),
> +	STD_METHOD(retrieve_subscriber_info),
> +	STD_METHODH(send_dtmf, "<code>"),
> +	STD_METHOD(request_last_voice_tag_number),
> +	STD_METHOD(cleanup),
> +	END_METHOD
> +};
> +
> +const struct interface hf_client_if = {
> +	.name = "handsfree_client",
> +	.methods = methods
> +};
> diff --git a/android/client/if-main.h b/android/client/if-main.h
> index 88da0c7..8aac3e3 100644
> --- a/android/client/if-main.h
> +++ b/android/client/if-main.h
> @@ -37,6 +37,10 @@
>  #include <hardware/bt_hf.h>
>  #include <hardware/bt_hl.h>
> 
> +#ifdef BLUEZ_EXTENSIONS
> +#include <hardware/bt_hf_client.h>
> +#endif
> +
>  #include <hardware/bt_rc.h>
>  #include <hardware/bt_gatt.h>
>  #include <hardware/bt_gatt_types.h>
> @@ -57,6 +61,9 @@ extern const btsock_interface_t *if_sock;
>  extern const btgatt_interface_t *if_gatt;
>  extern const btgatt_server_interface_t *if_gatt_server;
>  extern const btgatt_client_interface_t *if_gatt_client;
> +#ifdef BLUEZ_EXTENSIONS
> +extern const bthf_client_interface_t *if_hf_client;
> +#endif
> 
>  /*
>   * Structure defines top level interfaces that can be used in test tool
> @@ -80,6 +87,9 @@ extern const struct interface sock_if;
>  extern const struct interface hf_if;
>  extern const struct interface hh_if;
>  extern const struct interface hl_if;
> +#ifdef BLUEZ_EXTENSIONS
> +extern const struct interface hf_client_if;
> +#endif
> 
>  /* Interfaces that will show up in tool (first part of command line) */
>  extern const struct interface *interfaces[];

-- 
Szymon K. Janc
szymon.janc@gmail.com
