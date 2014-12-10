Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/5] android/tester: add initial support for map-client tester
Date: Wed, 10 Dec 2014 13:56:22 +0100
Message-ID: <3866089.eAUD4BA8Zt@leonov>
In-Reply-To: <1418034908-1742-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1418034908-1742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1418034908-1742-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

Start commit message with capital letter.

On Monday 08 of December 2014 11:35:08 Grzegorz Kolodziejczyk wrote:
> This adds callback, callback verification, step verification, mas
> instance verification, map client profile setup handling and basic
> files.
> ---
>  android/Makefile.am         |   1 +
>  android/tester-main.c       | 160
> ++++++++++++++++++++++++++++++++++++++++++++ android/tester-main.h       | 
> 18 +++++
>  android/tester-map-client.c |  43 ++++++++++++
>  4 files changed, 222 insertions(+)
>  create mode 100644 android/tester-map-client.c
> 
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 6d74c05..deea6c3 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -154,6 +154,7 @@ android_android_tester_SOURCES = emulator/hciemu.h
> emulator/hciemu.c \ android/tester-a2dp.c \
>  				android/tester-avrcp.c \
>  				android/tester-gatt.c \
> +				android/tester-map-client.c \
>  				android/tester-main.h android/tester-main.c
>  android_android_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
>  				-DPLUGINDIR=\""$(android_plugindir)"\"
> diff --git a/android/tester-main.c b/android/tester-main.c
> index 06730d2..19d25fc 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -111,6 +111,9 @@ static struct {
>  	DBG_CB(CB_GATTS_REQUEST_EXEC_WRITE),
>  	DBG_CB(CB_GATTS_RESPONSE_CONFIRMATION),
> 
> +	/* Map client */
> +	DBG_CB(CB_MAP_CLIENT_GET_REMOTE_MAS_INSTANCES),
> +
>  	/* Emulator callbacks */
>  	DBG_CB(CB_EMU_CONFIRM_SEND_DATA),
>  	DBG_CB(CB_EMU_ENCRYPTION_ENABLED),
> @@ -484,6 +487,40 @@ static bool match_property(bt_property_t *exp_prop,
> bt_property_t *rec_prop, return 1;
>  }
> 
> +static bool match_mas_inst(btmce_mas_instance_t *exp_inst,
> +				btmce_mas_instance_t *rec_inst, int inst_num)
> +{
> +	if (exp_inst->id && (exp_inst->id != rec_inst->id)) {
> +		tester_debug("Mas instance [%d] id don't match! received=%d, "
> +					"expected=%d", inst_num, rec_inst->id,
> +					exp_inst->id);

Something is wrong with this indentation. Also I'd prefer if you could try not 
breaking formatting strings.

> +		return 0;
> +	}
> +
> +	if (exp_inst->scn && (exp_inst->scn != exp_inst->scn)) {
> +		tester_debug("Mas instance [%d] scn don't match! received=%d, "
> +					"expected=%d", inst_num, rec_inst->scn,
> +					exp_inst->scn);
> +		return 0;
> +	}
> +
> +	if (exp_inst->msg_types && (exp_inst->msg_types !=
> +							exp_inst->msg_types)) {
> +		tester_debug("Mas instance [%d] message type don't match! "
> +					"received=%d, expected=%d", inst_num,
> +					rec_inst->scn, exp_inst->scn);
> +		return 0;
> +	}
> +
> +	if (exp_inst->p_name && memcmp(exp_inst->p_name, rec_inst->p_name,
> +						strlen(exp_inst->p_name))) {
> +		tester_debug("Mas instance [%d] name don't match!", inst_num);
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
>  static int verify_property(bt_property_t *exp_props, int exp_num_props,
>  				bt_property_t *rec_props, int rec_num_props)
>  {
> @@ -511,6 +548,33 @@ static int verify_property(bt_property_t *exp_props,
> int exp_num_props, return exp_prop_to_find;
>  }
> 
> +static int verify_mas_inst(btmce_mas_instance_t *exp_inst, int
> exp_num_inst, +						btmce_mas_instance_t  *rec_inst,
> +						int rec_num_inst)
> +{

Some coding style violation here.

> +	int i, j;
> +	int exp_inst_to_find = exp_num_inst;
> +
> +	for (i = 0; i < exp_num_inst; i++) {
> +		for (j = 0; j < rec_num_inst; j++) {
> +			if (match_mas_inst(&exp_inst[i], &rec_inst[i], i)) {
> +				exp_inst_to_find--;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if ((i == 0) && exp_num_inst) {
> +		tester_warn("No mas instance was verified: %s", exp_num_inst ?
> +				"unknown error!" :
> +				"wrong \'.callback_result.num_properties\'?");
> +

This is ugly. Make those messages shorter.

> +		return 1;
> +	}
> +
> +	return exp_inst_to_find;
> +}
> +
>  /*
>   * Check each test case step if test case expected
>   * data is set and match it with expected result.
> @@ -945,6 +1009,15 @@ static bool match_data(struct step *step)
>  		return false;
>  	}
> 
> +	if (exp->callback_result.mas_instances &&
> +		verify_mas_inst(exp->callback_result.mas_instances,
> +				exp->callback_result.num_mas_instances,
> +				step->callback_result.mas_instances,
> +				step->callback_result.num_mas_instances)) {
> +		tester_debug("Mas instances don't match");
> +		return false;
> +	}
> +
>  	if (exp->store_srvc_handle)
>  		memcpy(exp->store_srvc_handle,
>  					step->callback_result.srvc_handle,
> @@ -2032,6 +2105,47 @@ static btrc_callbacks_t btavrcp_callbacks = {
>  	.get_element_attr_cb = avrcp_get_element_attr_cb,
>  };
> 
> +static btmce_mas_instance_t *copy_map_instances(int num_instances,
> +						btmce_mas_instance_t *instances)
> +{
> +	int i;
> +	btmce_mas_instance_t *inst = g_new0(btmce_mas_instance_t,
> +								num_instances);

Just put this into new line.

> +
> +	for (i = 0; i < num_instances; i++) {
> +		inst[i].id = instances[i].id;
> +		inst[i].scn = instances[i].scn;
> +		inst[i].msg_types = instances[i].msg_types;
> +		inst[i].p_name = g_memdup(instances[i].p_name,
> +						strlen(instances[i].p_name));
> +	}
> +
> +	return inst;
> +}
> +
> +static void map_client_get_remote_mas_instances_cb(bt_status_t status,
> +							bt_bdaddr_t *bd_addr,
> +							int num_instances,
> +							btmce_mas_instance_t
> +							*instances)
> +{
> +	struct step *step = g_new0(struct step, 1);
> +
> +	step->callback_result.status = status;
> +	step->callback_result.num_mas_instances = num_instances;
> +	step->callback_result.mas_instances = copy_map_instances(num_instances,
> +								instances);
> +
> +	step->callback = CB_MAP_CLIENT_GET_REMOTE_MAS_INSTANCES;
> +
> +	schedule_callback_verification(step);
> +}
> +
> +static btmce_callbacks_t btmap_client_callbacks = {
> +	.size = sizeof(btmap_client_callbacks),
> +	.remote_mas_instances_cb = map_client_get_remote_mas_instances_cb,
> +};
> +
>  static bool setup_base(struct test_data *data)
>  {
>  	const hw_module_t *module;
> @@ -2396,6 +2510,44 @@ static void setup_gatt(const void *test_data)
>  	tester_setup_complete();
>  }
> 
> +static void setup_map_client(const void *test_data)
> +{
> +	struct test_data *data = tester_get_data();
> +	bt_status_t status;
> +	const void *map_client;
> +
> +	if (!setup_base(data)) {
> +		tester_setup_failed();
> +		return;
> +	}
> +
> +	status = data->if_bluetooth->init(&bt_callbacks);
> +	if (status != BT_STATUS_SUCCESS) {
> +		data->if_bluetooth = NULL;
> +		tester_setup_failed();
> +		return;
> +	}
> +
> +	map_client = data->if_bluetooth->get_profile_interface(
> +						BT_PROFILE_MAP_CLIENT_ID);
> +	if (!map_client) {
> +		tester_setup_failed();
> +		return;
> +	}
> +
> +	data->if_map_client = map_client;
> +
> +	status = data->if_map_client->init(&btmap_client_callbacks);
> +	if (status != BT_STATUS_SUCCESS) {
> +		data->if_map_client = NULL;
> +
> +		tester_setup_failed();
> +		return;
> +	}
> +
> +	tester_setup_complete();
> +}
> +
>  static void teardown(const void *test_data)
>  {
>  	struct test_data *data = tester_get_data();
> @@ -3101,6 +3253,13 @@ static void add_gatt_tests(void *data, void
> *user_data) test(tc, setup_gatt, generic_test_function, teardown);
>  }
> 
> +static void add_map_client_tests(void *data, void *user_data)
> +{
> +	struct test_case *tc = data;
> +
> +	test(tc, setup_map_client, generic_test_function, teardown);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
> @@ -3115,6 +3274,7 @@ int main(int argc, char *argv[])
>  	queue_foreach(get_a2dp_tests(), add_a2dp_tests, NULL);
>  	queue_foreach(get_avrcp_tests(), add_avrcp_tests, NULL);
>  	queue_foreach(get_gatt_tests(), add_gatt_tests, NULL);
> +	queue_foreach(get_map_client_tests(), add_map_client_tests, NULL);
> 
>  	if (tester_run())
>  		return 1;
> diff --git a/android/tester-main.h b/android/tester-main.h
> index ae65d72..55f5f5d 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -55,6 +55,7 @@
>  #include <hardware/bt_gatt.h>
>  #include <hardware/bt_gatt_client.h>
>  #include <hardware/bt_gatt_server.h>
> +#include <hardware/bt_mce.h>
> 
>  struct pdu_set {
>  	struct iovec req;
> @@ -539,6 +540,9 @@ typedef enum {
>  	CB_GATTS_REQUEST_EXEC_WRITE,
>  	CB_GATTS_RESPONSE_CONFIRMATION,
> 
> +	/* Map client */
> +	CB_MAP_CLIENT_GET_REMOTE_MAS_INSTANCES,
> +
>  	/* Emulator callbacks */
>  	CB_EMU_CONFIRM_SEND_DATA,
>  	CB_EMU_ENCRYPTION_ENABLED,
> @@ -566,6 +570,7 @@ struct test_data {
>  	struct audio_stream_out *if_stream;
>  	const btrc_interface_t *if_avrcp;
>  	const btgatt_interface_t *if_gatt;
> +	const btmce_interface_t *if_map_client;
> 
>  	const void *test_data;
>  	struct queue *steps;
> @@ -625,6 +630,14 @@ struct emu_l2cap_cid_data {
>  	bool is_sdp;
>  };
> 
> +struct map_inst_data {
> +	int32_t id;
> +	int32_t scn;
> +	int32_t msg_types;
> +	int32_t name_len;
> +	uint8_t *name;
> +};
> +
>  /*
>   * Callback data structure should be enhanced with data
>   * returned by callbacks. It's used for test case step
> @@ -688,6 +701,9 @@ struct bt_callback_data {
>  	uint64_t rc_index;
>  	uint8_t num_of_attrs;
>  	btrc_element_attr_val_t *attrs;
> +
> +	int num_mas_instances;
> +	btmce_mas_instance_t *mas_instances;
>  };
> 
>  /*
> @@ -737,6 +753,8 @@ struct queue *get_avrcp_tests(void);
>  void remove_avrcp_tests(void);
>  struct queue *get_gatt_tests(void);
>  void remove_gatt_tests(void);
> +struct queue *get_map_client_tests(void);
> +void remove_map_client_tests(void);
> 
>  /* Generic tester API */
>  void schedule_action_verification(struct step *step);
> diff --git a/android/tester-map-client.c b/android/tester-map-client.c
> new file mode 100644
> index 0000000..a2bb08f
> --- /dev/null
> +++ b/android/tester-map-client.c
> @@ -0,0 +1,43 @@
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
> +#include "tester-main.h"
> +
> +static struct queue *list; /* List of map client test cases */
> +
> +static struct test_case test_cases[] = {
> +	TEST_CASE_BREDRLE("MAP Client Init", ACTION_SUCCESS(dummy_action, NULL),
> +	),
> +};
> +
> +struct queue *get_map_client_tests(void)
> +{
> +	uint16_t i = 0;
> +
> +	list = queue_new();
> +
> +	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
> +		if (!queue_push_tail(list, &test_cases[i]))
> +			return NULL;
> +

This probably makes static checkers unhappy. I'd prefer you explicitly check 
if queue_new() succeed and clean it up if push failed.

(you may also want to fix that in other testers)

> +	return list;
> +}
> +
> +void remove_map_client_tests(void)
> +{
> +	queue_destroy(list, NULL);
> +}

-- 
BR
Szymon Janc
