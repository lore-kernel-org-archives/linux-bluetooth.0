Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/tester: Add case for error passing in GATT server responses
Date: Thu, 19 Feb 2015 11:05:39 +0100
Message-ID: <1661529.2t5NUDH8R5@uw000953>
In-Reply-To: <1423833460-19400-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423833460-19400-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 13 of February 2015 14:17:39 Jakub Tyszkowski wrote:
> This is to verify proper error passing from user apps.
> ---
>  android/tester-gatt.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  android/tester-main.c |  8 +++++++
>  android/tester-main.h |  7 ++++++
>  3 files changed, 80 insertions(+)
> 
> diff --git a/android/tester-gatt.c b/android/tester-gatt.c
> index 15a54fa..38dfe42 100644
> --- a/android/tester-gatt.c
> +++ b/android/tester-gatt.c
> @@ -26,6 +26,7 @@
>  
>  #define ATT_HANDLE_SIZE	2
>  
> +#define L2CAP_ATT_ERROR			0x01
>  #define L2CAP_ATT_EXCHANGE_MTU_REQ	0x02
>  #define L2CAP_ATT_EXCHANGE_MTU_RSP	0x03
>  #define L2CAP_ATT_READ_REQ		0x0a
> @@ -39,6 +40,8 @@
>  #define GATT_STATUS_FAILURE	0x00000101
>  #define GATT_STATUS_INS_AUTH	0x08
>  
> +#define GATT_ERR_INVAL_ATTR_VALUE_LEN	0x0D
> +
>  #define GATT_SERVER_DISCONNECTED	0
>  #define GATT_SERVER_CONNECTED		1
>  
> @@ -851,6 +854,13 @@ static struct send_resp_data send_resp_data_2 = {
>  	.response = &response_2,
>  };
>  
> +static struct send_resp_data send_resp_data_2_error = {
> +	.conn_id = CONN1_ID,
> +	.trans_id = TRANS1_ID,
> +	.status = GATT_ERR_INVAL_ATTR_VALUE_LEN,
> +	.response = &response_2,
> +};
> +
>  #define SEARCH_SERVICE_SINGLE_SUCCESS_PDUS				\
>  	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),		\
>  	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),	\
> @@ -1575,6 +1585,14 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
>  	tester_debug("Received att pdu with opcode 0x%02x", pdu[0]);
>  
>  	switch (pdu[0]) {
> +	case L2CAP_ATT_ERROR:
> +		step = g_new0(struct step, 1);
> +
> +		step->callback = CB_EMU_ATT_ERROR;
> +		step->callback_result.error = pdu[4];
> +
> +		schedule_callback_verification(step);
> +		break;
>  	case L2CAP_ATT_EXCHANGE_MTU_REQ:
>  		tester_print("Exchange MTU request received.");
>  
> @@ -3412,6 +3430,53 @@ static struct test_case test_cases[] = {
>  		ACTION_SUCCESS(bluetooth_disable_action, NULL),
>  		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
>  	),
> +	TEST_CASE_BREDRLE("Gatt Server - Send error resp to write char request",
> +		ACTION_SUCCESS(bluetooth_enable_action, NULL),
> +		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
> +		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
> +		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
> +		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
> +		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
> +		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
> +		ACTION_SUCCESS(gatt_server_add_service_action,
> +							&add_service_data_5),
> +		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
> +							&service_add_1, NULL,
> +							&srvc1_handle),
> +		ACTION_SUCCESS(gatt_server_add_char_action, &add_char_data_2),
> +		CALLBACK_GATTS_CHARACTERISTIC_ADDED(GATT_STATUS_SUCCESS,
> +							APP1_ID, &app1_uuid,
> +							&srvc1_handle, NULL,
> +							&char1_handle),
> +		ACTION_SUCCESS(gatt_server_start_srvc_action,
> +							&start_srvc_data_2),
> +		CALLBACK_GATTS_SERVICE_STARTED(GATT_STATUS_SUCCESS, APP1_ID,
> +								&srvc1_handle),
> +		ACTION_SUCCESS(bt_start_discovery_action, NULL),
> +		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
> +							BT_DISCOVERY_STARTED),
> +		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_le_set, 2),
> +		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
> +		ACTION_SUCCESS(gatt_server_connect_action, &app1_conn_req),
> +		CALLBACK_GATTS_CONNECTION(GATT_SERVER_CONNECTED,
> +						prop_emu_remotes_default_set,
> +						CONN1_ID, APP1_ID),
> +		PROCESS_DATA(GATT_STATUS_SUCCESS,
> +					gatt_remote_send_raw_pdu_action,
> +					&att_write_req_op_v, &char1_handle_v,
> +					&att_write_req_value_1_v),
> +		CALLBACK_GATTS_REQUEST_WRITE(CONN1_ID, TRANS1_ID,
> +						prop_emu_remotes_default_set,
> +						&char1_handle, 0,
> +						sizeof(att_write_req_value_1),
> +						true, false,
> +						att_write_req_value_1),
> +		ACTION_SUCCESS(gatt_server_send_response_action,
> +						&send_resp_data_2_error),
> +		CALLBACK_ERROR(CB_EMU_ATT_ERROR, GATT_ERR_INVAL_ATTR_VALUE_LEN),
> +		ACTION_SUCCESS(bluetooth_disable_action, NULL),
> +		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
> +		),
>  };
>  
>  struct queue *get_gatt_tests(void)
> diff --git a/android/tester-main.c b/android/tester-main.c
> index 336a9a8..c13f056 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -134,6 +134,7 @@ static struct {
>  	DBG_CB(CB_EMU_VALUE_NOTIFICATION),
>  	DBG_CB(CB_EMU_READ_RESPONSE),
>  	DBG_CB(CB_EMU_WRITE_RESPONSE),
> +	DBG_CB(CB_EMU_ATT_ERROR),
>  };
>  
>  static gboolean check_callbacks_called(gpointer user_data)
> @@ -1036,6 +1037,13 @@ static bool match_data(struct step *step)
>  		return false;
>  	}
>  
> +	if (exp->callback_result.error != step->callback_result.error) {
> +		tester_debug("Err mismatch: %d vs %d",
> +				exp->callback_result.error,
> +				step->callback_result.error);
> +		return false;
> +	}
> +
>  	if (exp->store_srvc_handle)
>  		memcpy(exp->store_srvc_handle,
>  					step->callback_result.srvc_handle,
> diff --git a/android/tester-main.h b/android/tester-main.h
> index e35feec..3d97b72 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -106,6 +106,11 @@ struct pdu_set {
>  		.callback_result.status = cb_res, \
>  	}
>  
> +#define CALLBACK_ERROR(cb, cb_err) { \
> +		.callback = cb, \
> +		.callback_result.error = cb_err, \
> +	}
> +
>  #define CALLBACK_ADAPTER_PROPS(props, prop_cnt) { \
>  		.callback = CB_BT_ADAPTER_PROPERTIES, \
>  		.callback_result.properties = props, \
> @@ -548,6 +553,7 @@ typedef enum {
>  	CB_EMU_VALUE_NOTIFICATION,
>  	CB_EMU_READ_RESPONSE,
>  	CB_EMU_WRITE_RESPONSE,
> +	CB_EMU_ATT_ERROR,
>  } expected_bt_callback_t;
>  
>  struct test_data {
> @@ -677,6 +683,7 @@ struct bt_callback_data {
>  	uint8_t *value;
>  	bool need_rsp;
>  	bool is_prep;
> +	uint8_t error;
>  
>  	btpan_control_state_t ctrl_state;
>  	btpan_connection_state_t conn_state;
> 

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
