Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] android/tester: Add GATT server add service test cases
Date: Mon, 06 Oct 2014 16:19:17 +0200
Message-ID: <3730563.1d4n8nbRRd@uw000953>
In-Reply-To: <1412600046-9865-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412600046-9865-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 06 of October 2014 14:54:00 Grzegorz Kolodziejczyk wrote:
> This adds service add by server test cases.
> ---
>  android/tester-gatt.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/tester-main.c |  37 +++++++++++++++-
>  android/tester-main.h |  14 ++++++
>  3 files changed, 169 insertions(+), 1 deletion(-)
> 
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index 35cf7ed..209b556 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -118,6 +118,13 @@ struct notif_data {
>  	btgatt_gatt_id_t *charac;
>  };
>  
> +struct add_service_data {
> +	int app_id;
> +	btgatt_srvc_id_t *service;
> +	int num_handles;
> +};
> +
> +
>  static bt_bdaddr_t emu_remote_bdaddr_val = {
>  	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
>  };
> @@ -190,6 +197,33 @@ static btgatt_srvc_id_t service_2 = {
>  	}
>  };
>  
> +static btgatt_srvc_id_t service_add_1 = {
> +	.is_primary = true,
> +	.id = {
> +		.inst_id = 0,
> +		.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> +			0x00, 0x10, 0x00, 0x00, 0xFF, 0xEF, 0x00, 0x00},
> +	}
> +};
> +
> +static btgatt_srvc_id_t service_add_2 = {
> +	.is_primary = true,
> +	.id = {
> +		.inst_id = 1,
> +		.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> +			0x00, 0x10, 0x00, 0x00, 0xFF, 0xDF, 0x00, 0x00},
> +	}
> +};
> +
> +static btgatt_srvc_id_t service_add_3 = {
> +	.is_primary = true,
> +	.id = {
> +		.inst_id = 2,
> +		.uuid.uu = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> +			0x00, 0x10, 0x00, 0x00, 0xFF, 0xCF, 0x00, 0x00},
> +	}
> +};
> +
>  static btgatt_srvc_id_t included_1 = {
>  	.is_primary = false,
>  	.id = {
> @@ -313,6 +347,36 @@ static struct notif_data notif_data_1 = {
>  	.bdaddr = &emu_remote_bdaddr_val,
>  };
>  
> +static struct add_service_data add_service_data_1 = {
> +	.app_id = APP1_ID,
> +	.service = &service_add_1,
> +	.num_handles = 1
> +};
> +
> +static struct add_service_data add_service_data_2 = {
> +	.app_id = APP1_ID,
> +	.service = &service_add_2,
> +	.num_handles = 1
> +};
> +
> +static struct add_service_data add_service_data_3 = {
> +	.app_id = APP1_ID,
> +	.service = &service_add_3,
> +	.num_handles = 1
> +};
> +
> +static struct add_service_data add_bad_service_data_1 = {
> +	.app_id = APP1_ID,
> +	.service = &service_add_1,
> +	.num_handles = 0
> +};
> +
> +static struct add_service_data add_sec_service_data_1 = {
> +	.app_id = APP1_ID,
> +	.service = &included_1,
> +	.num_handles = 1
> +};
> +
>  struct set_read_params {
>  	btgatt_read_params_t *params;
>  	btgatt_srvc_id_t *srvc_id;
> @@ -1012,6 +1076,21 @@ static void gatt_server_disconnect_action(void)
>  	schedule_action_verification(step);
>  }
>  
> +static void gatt_server_add_service_action(void)
> +{
> +	struct test_data *data = tester_get_data();
> +	struct step *current_data_step = queue_peek_head(data->steps);
> +	struct add_service_data *add_srvc_data = current_data_step->set_data;
> +	struct step *step = g_new0(struct step, 1);
> +
> +	step->action_status = data->if_gatt->server->add_service(
> +						add_srvc_data->app_id,
> +						add_srvc_data->service,
> +						add_srvc_data->num_handles);
> +
> +	schedule_action_verification(step);
> +}
> +
>  static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>  {
>  	struct test_data *t_data = tester_get_data();
> @@ -2281,6 +2360,46 @@ static struct test_case test_cases[] = {
>  		ACTION_SUCCESS(bluetooth_disable_action, NULL),
>  		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
>  	),
> +	TEST_CASE_BREDRLE("Gatt Server - Add Single Service Successful",
> +		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
> +		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
> +		ACTION_SUCCESS(gatt_server_add_service_action,
> +							&add_service_data_1),
> +		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
> +						&service_add_1, NULL, NULL),
> +	),
> +	TEST_CASE_BREDRLE("Gatt Server - Add Multiple Services Successful",
> +		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
> +		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
> +		ACTION_SUCCESS(gatt_server_add_service_action,
> +							&add_service_data_1),
> +		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
> +						&service_add_1, NULL, NULL),
> +		ACTION_SUCCESS(gatt_server_add_service_action,
> +							&add_service_data_2),
> +		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
> +						&service_add_2, NULL, NULL),
> +		ACTION_SUCCESS(gatt_server_add_service_action,
> +							&add_service_data_3),
> +		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
> +						&service_add_3, NULL, NULL),
> +	),
> +	TEST_CASE_BREDRLE("Gatt Server - Add Service with 0 handles",
> +		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
> +		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
> +		ACTION_FAIL(gatt_server_add_service_action,
> +						&add_bad_service_data_1),
> +		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_FAILURE, APP1_ID,
> +						&service_add_1, NULL, NULL),
> +	),
> +	TEST_CASE_BREDRLE("Gatt Server - Add Secondary Service",
> +		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
> +		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
> +		ACTION_SUCCESS(gatt_server_add_service_action,
> +						&add_sec_service_data_1),
> +		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
> +						&included_1, NULL, NULL),
> +	),
>  };
>  
>  struct queue *get_gatt_tests(void)
> diff --git a/android/tester-main.c b/android/tester-main.c
> index bb064b7..141e4c6 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -773,6 +773,21 @@ static bool match_data(struct step *step)
>  		return false;
>  	}
>  
> +	if (exp->callback_result.srvc_handle &&
> +					step->callback_result.srvc_handle)
> +		if (*exp->callback_result.srvc_handle !=
> +					*step->callback_result.srvc_handle) {
> +			tester_debug("Gatt service handle mismatch: %d vs %d",
> +					*step->callback_result.srvc_handle,
> +					*exp->callback_result.srvc_handle);
> +			return false;
> +		}
> +
> +	if (exp->store_srvc_handle)
> +		memcpy(exp->store_srvc_handle,
> +					step->callback_result.srvc_handle,
> +					sizeof(*exp->store_srvc_handle));
> +
>  	return true;
>  }
>  
> @@ -876,6 +891,9 @@ static void destroy_callback_step(void *data)
>  	if (step->callback_result.notify_params)
>  		free(step->callback_result.notify_params);
>  
> +	if (step->callback_result.srvc_handle)
> +		free(step->callback_result.srvc_handle);
> +
>  	g_free(step);
>  	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
>  }
> @@ -1480,6 +1498,23 @@ static void gatts_connection_cb(int conn_id, int server_if, int connected,
>  	schedule_callback_verification(step);
>  }
>  
> +static void gatts_service_added_cb(int status, int server_if,
> +						btgatt_srvc_id_t *srvc_id,
> +						int srvc_handle)
> +{
> +	struct step *step = g_new0(struct step, 1);
> +
> +	step->callback = CB_GATTS_SERVICE_ADDED;
> +
> +	step->callback_result.status = status;
> +	step->callback_result.gatt_app_id = server_if;
> +	step->callback_result.service = g_memdup(srvc_id, sizeof(*srvc_id));
> +	step->callback_result.srvc_handle = g_memdup(&srvc_handle,
> +							sizeof(srvc_handle));
> +
> +	schedule_callback_verification(step);
> +}
> +
>  static void pan_control_state_cb(btpan_control_state_t state,
>  					bt_status_t error, int local_role,
>  							const char *ifname)
> @@ -1603,7 +1638,7 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
>  static const btgatt_server_callbacks_t btgatt_server_callbacks = {
>  	.register_server_cb = gatts_register_server_cb,
>  	.connection_cb = gatts_connection_cb,
> -	.service_added_cb = NULL,
> +	.service_added_cb = gatts_service_added_cb,
>  	.included_service_added_cb = NULL,
>  	.characteristic_added_cb = NULL,
>  	.descriptor_added_cb = NULL,
> diff --git a/android/tester-main.h b/android/tester-main.h
> index 922f1cf..79df8de 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -252,6 +252,17 @@ struct pdu_set {
>  		.callback_result.gatt_app_id = cb_server_id, \
>  	}
>  
> +#define CALLBACK_GATTS_SERVICE_ADDED(cb_res, cb_server_id, cb_service, \
> +						cb_srvc_handle, \
> +						cb_store_srvc_handle) { \
> +		.callback = CB_GATTS_SERVICE_ADDED, \
> +		.callback_result.status = cb_res, \
> +		.callback_result.gatt_app_id = cb_server_id, \
> +		.callback_result.service = cb_service, \
> +		.callback_result.srvc_handle = cb_srvc_handle, \
> +		.store_srvc_handle = cb_store_srvc_handle, \
> +	}
> +
>  #define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
>  		.callback = cb, \
>  		.callback_result.status = cb_res, \
> @@ -500,6 +511,7 @@ struct bt_callback_data {
>  	int gatt_app_id;
>  	int conn_id;
>  	int connected;
> +	int *srvc_handle;
>  	btgatt_srvc_id_t *service;
>  	btgatt_gatt_id_t *characteristic;
>  	btgatt_gatt_id_t *descriptor;
> @@ -535,6 +547,8 @@ struct step {
>  
>  	void *set_data;
>  	int set_data_len;
> +
> +	int *store_srvc_handle;
>  };
>  
>  struct test_case {
> 

Patches 1-4 are now applied. Rest need to be rebased. Thanks.

-- 
Best regards, 
Szymon Janc
