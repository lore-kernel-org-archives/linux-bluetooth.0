Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/tester: Add GATT server start service test cases
Date: Fri, 10 Oct 2014 11:08:03 +0200
Message-ID: <1603188.yahQThKxYI@uw000953>
In-Reply-To: <1412605665-13527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412605665-13527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 06 of October 2014 16:27:43 Grzegorz Kolodziejczyk wrote:
> This adds start service by server test cases.
> ---
>  android/tester-gatt.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/tester-main.c |  16 +++++++-
>  android/tester-main.h |   7 ++++
>  3 files changed, 122 insertions(+), 1 deletion(-)
> 
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index e86e929..19ba703 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -37,6 +37,10 @@
>  #define CONN1_ID	1
>  #define CONN2_ID	2
>  
> +#define GATT_SERVER_TRANSPORT_LE		0x00
> +#define GATT_SERVER_TRANSPORT_BREDR		0x01
> +#define GATT_SERVER_TRANSPORT_LE_BREDR		0x02
> +
>  static struct queue *list; /* List of gatt test cases */
>  
>  static int srvc1_handle;
> @@ -138,6 +142,12 @@ struct add_desc_data {
>  	int permissions;
>  };
>  
> +struct start_srvc_data {
> +	int app_id;
> +	int *srvc_handle;
> +	int transport;
> +};
> +
>  static bt_bdaddr_t emu_remote_bdaddr_val = {
>  	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
>  };
> @@ -459,6 +469,30 @@ static struct add_desc_data add_desc_data_1 = {
>  	.permissions = 0
>  };
>  
> +static struct start_srvc_data start_srvc_data_1 = {
> +	.app_id = APP1_ID,
> +	.srvc_handle = &srvc1_handle,
> +	.transport = GATT_SERVER_TRANSPORT_LE_BREDR
> +};
> +
> +static struct start_srvc_data start_srvc_data_2 = {
> +	.app_id = APP1_ID,
> +	.srvc_handle = &srvc1_handle,
> +	.transport = GATT_SERVER_TRANSPORT_LE
> +};
> +
> +static struct start_srvc_data start_bad_srvc_data_1 = {
> +	.app_id = APP1_ID,
> +	.srvc_handle = &srvc_bad_handle,
> +	.transport = GATT_SERVER_TRANSPORT_LE
> +};
> +
> +static struct start_srvc_data start_bad_srvc_data_2 = {
> +	.app_id = APP1_ID,
> +	.srvc_handle = &srvc1_handle,
> +	.transport = -1
> +};
> +
>  struct set_read_params {
>  	btgatt_read_params_t *params;
>  	btgatt_srvc_id_t *srvc_id;
> @@ -1222,6 +1256,21 @@ static void gatt_server_add_desc_action(void)
>  	schedule_action_verification(step);
>  }
>  
> +static void gatt_server_start_srvc_action(void)
> +{
> +	struct test_data *data = tester_get_data();
> +	struct step *current_data_step = queue_peek_head(data->steps);
> +	struct start_srvc_data *start_srvc_data = current_data_step->set_data;
> +	struct step *step = g_new0(struct step, 1);
> +
> +	step->action_status = data->if_gatt->server->start_service(
> +						start_srvc_data->app_id,
> +						*start_srvc_data->srvc_handle,
> +						start_srvc_data->transport);
> +
> +	schedule_action_verification(step);
> +}
> +
>  static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>  {
>  	struct test_data *t_data = tester_get_data();
> @@ -2645,6 +2694,57 @@ static struct test_case test_cases[] = {
>  		CALLBACK_GATTS_DESCRIPTOR_ADDED(GATT_STATUS_FAILURE, APP2_ID,
>  						&app2_uuid, NULL, NULL, NULL),
>  	),
> +	TEST_CASE_BREDRLE("Gatt Server - Start Service Successful BREDRLE",
> +		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
> +		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
> +		ACTION_SUCCESS(gatt_server_add_service_action,
> +							&add_service_data_1),
> +		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
> +							&service_add_1, NULL,
> +							&srvc1_handle),
> +		ACTION_SUCCESS(gatt_server_start_srvc_action,
> +							&start_srvc_data_1),
> +		CALLBACK_GATTS_SERVICE_STARTED(GATT_STATUS_SUCCESS, APP1_ID,
> +								&srvc1_handle),
> +	),
> +	TEST_CASE_BREDRLE("Gatt Server - Start Service Successful LE",
> +		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
> +		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
> +		ACTION_SUCCESS(gatt_server_add_service_action,
> +							&add_service_data_1),
> +		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
> +							&service_add_1, NULL,
> +							&srvc1_handle),
> +		ACTION_SUCCESS(gatt_server_start_srvc_action,
> +							&start_srvc_data_2),
> +		CALLBACK_GATTS_SERVICE_STARTED(GATT_STATUS_SUCCESS, APP1_ID,
> +								&srvc1_handle),
> +	),
> +	TEST_CASE_BREDRLE("Gatt Server - Start Service wrong service handle",
> +		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
> +		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
> +		ACTION_SUCCESS(gatt_server_add_service_action,
> +							&add_service_data_1),
> +		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
> +						&service_add_1, NULL, NULL),
> +		ACTION_FAIL(gatt_server_start_srvc_action,
> +							&start_bad_srvc_data_1),
> +		CALLBACK_GATTS_SERVICE_STARTED(GATT_STATUS_FAILURE, APP1_ID,
> +									NULL),
> +	),
> +	TEST_CASE_BREDRLE("Gatt Server - Start Service wrong server transport",
> +		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
> +		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
> +		ACTION_SUCCESS(gatt_server_add_service_action,
> +							&add_service_data_1),
> +		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
> +							&service_add_1, NULL,
> +							&srvc1_handle),
> +		ACTION_FAIL(gatt_server_start_srvc_action,
> +							&start_bad_srvc_data_2),
> +		CALLBACK_GATTS_SERVICE_STARTED(GATT_STATUS_FAILURE, APP1_ID,
> +								&srvc1_handle),
> +	),
>  };
>  
>  struct queue *get_gatt_tests(void)
> diff --git a/android/tester-main.c b/android/tester-main.c
> index 30e1c59..4ffa3c1 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -1608,6 +1608,20 @@ static void gatts_descriptor_added_cb(int status, int server_if,
>  	schedule_callback_verification(step);
>  }
>  
> +static void gatts_service_started_cb(int status, int server_if, int srvc_handle)
> +{
> +	struct step *step = g_new0(struct step, 1);
> +
> +	step->callback = CB_GATTS_SERVICE_STARTED;
> +
> +	step->callback_result.status = status;
> +	step->callback_result.gatt_app_id = server_if;
> +	step->callback_result.srvc_handle = g_memdup(&srvc_handle,
> +							sizeof(srvc_handle));
> +
> +	schedule_callback_verification(step);
> +}
> +
>  static void pan_control_state_cb(btpan_control_state_t state,
>  					bt_status_t error, int local_role,
>  							const char *ifname)
> @@ -1735,7 +1749,7 @@ static const btgatt_server_callbacks_t btgatt_server_callbacks = {
>  	.included_service_added_cb = gatts_included_service_added_cb,
>  	.characteristic_added_cb = gatts_characteristic_added_cb,
>  	.descriptor_added_cb = gatts_descriptor_added_cb,
> -	.service_started_cb = NULL,
> +	.service_started_cb = gatts_service_started_cb,
>  	.service_stopped_cb = NULL,
>  	.service_deleted_cb = NULL,
>  	.request_read_cb = NULL,
> diff --git a/android/tester-main.h b/android/tester-main.h
> index 17a6eb3..1906a8d 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -297,6 +297,13 @@ struct pdu_set {
>  		.store_desc_handle = cb_store_desc_handle, \
>  	}
>  
> +#define CALLBACK_GATTS_SERVICE_STARTED(cb_res, cb_server_id, cb_srvc_handle) { \
> +		.callback = CB_GATTS_SERVICE_STARTED, \
> +		.callback_result.status = cb_res, \
> +		.callback_result.gatt_app_id = cb_server_id, \
> +		.callback_result.srvc_handle = cb_srvc_handle, \
> +	}
> +
>  #define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
>  		.callback = cb, \
>  		.callback_result.status = cb_res, \
> 

All patches applied. Thanks.

-- 
Best regards, 
Szymon Janc
