Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] android/tester: Add support for GATT Notification in tester
Date: Tue, 30 Sep 2014 12:35:07 +0200
Message-ID: <21395563.XuXFCF85mq@leonov>
In-Reply-To: <1411718763-10015-1-git-send-email-marcin.kraglak@tieto.com>
References: <1411718763-10015-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Friday 26 of September 2014 10:05:59 Marcin Kraglak wrote:
> Service register_for_notification and notification callbacks.
> ---
>  android/tester-main.c | 51
> +++++++++++++++++++++++++++++++++++++++++++++++++-- android/tester-main.h |
> 18 ++++++++++++++++++
>  2 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/android/tester-main.c b/android/tester-main.c
> index b65029a..919343e 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -613,6 +613,21 @@ static bool match_data(struct step *step)
>  				return false;
>  			}
>  		}
> +
> +		if (exp->callback_result.notification_registered !=
> +				step->callback_result.notification_registered) {
> +			tester_debug("Gatt registered flag mismatch");
> +			return false;
> +		}
> +
> +		if (exp->callback_result.notify_params) {
> +			if (memcmp(step->callback_result.notify_params,
> +					exp->callback_result.notify_params,
> +					sizeof(btgatt_notify_params_t))) {
> +				tester_debug("Gatt notify_param doesn't match");
> +				return false;
> +			}
> +		}
>  	}
> 
>  	return true;
> @@ -715,6 +730,9 @@ static void destroy_callback_step(void *data)
>  	if (step->callback_result.write_params)
>  		free(step->callback_result.write_params);
> 
> +	if (step->callback_result.notify_params)
> +		free(step->callback_result.notify_params);
> +
>  	g_free(step);
>  	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
>  }
> @@ -1255,6 +1273,35 @@ static void gattc_write_descriptor_cb(int conn_id,
> int status, schedule_callback_call(step);
>  }
> 
> +static void gattc_register_for_notification_cb(int conn_id, int registered,
> +						int status,
> +						btgatt_srvc_id_t *srvc_id,
> +						btgatt_gatt_id_t *char_id)
> +{
> +	struct step *step = g_new0(struct step, 1);
> +
> +	step->callback = CB_GATTC_REGISTER_FOR_NOTIFICATION;
> +	step->callback_result.status = status;
> +	step->callback_result.conn_id = conn_id;
> +	step->callback_result.service = g_memdup(srvc_id, sizeof(*srvc_id));
> +	step->callback_result.characteristic = g_memdup(char_id,
> +							sizeof(*char_id));
> +	step->callback_result.notification_registered = registered;
> +
> +	schedule_callback_call(step);
> +}
> +
> +static void gattc_notif_cb(int conn_id, btgatt_notify_params_t *p_data)
> +{
> +	struct step *step = g_new0(struct step, 1);
> +
> +	step->callback = CB_GATTC_NOTIFY;
> +	step->callback_result.conn_id = conn_id;
> +	step->callback_result.notify_params = g_memdup(p_data, sizeof(*p_data));
> +
> +	schedule_callback_call(step);
> +}
> +
>  static void pan_control_state_cb(btpan_control_state_t state,
>  					bt_status_t error, int local_role,
>  							const char *ifname)
> @@ -1364,8 +1411,8 @@ static const btgatt_client_callbacks_t
> btgatt_client_callbacks = { .get_characteristic_cb =
> gattc_get_characteristic_cb,
>  	.get_descriptor_cb = gattc_get_descriptor_cb,
>  	.get_included_service_cb = gattc_get_included_service_cb,
> -	.register_for_notification_cb = NULL,
> -	.notify_cb = NULL,
> +	.register_for_notification_cb = gattc_register_for_notification_cb,
> +	.notify_cb = gattc_notif_cb,
>  	.read_characteristic_cb = gattc_read_characteristic_cb,
>  	.write_characteristic_cb = gattc_write_characteristic_cb,
>  	.read_descriptor_cb = gattc_read_descriptor_cb,
> diff --git a/android/tester-main.h b/android/tester-main.h
> index 6afc553..2b8c281 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -203,6 +203,22 @@
>  		.callback_result.write_params = cb_write_data, \
>  	}
> 
> +#define CALLBACK_GATTC_REGISTER_FOR_NOTIF(cb_res, cb_conn_id, cb_char,\
> +						cb_service, cb_registered) { \
> +		.callback = CB_GATTC_REGISTER_FOR_NOTIFICATION, \
> +		.callback_result.conn_id = cb_conn_id, \
> +		.callback_result.status = cb_res, \
> +		.callback_result.service = cb_service, \
> +		.callback_result.characteristic = cb_char, \
> +		.callback_result.notification_registered = cb_registered \
> +	}
> +
> +#define CALLBACK_GATTC_NOTIFY(cb_conn_id, cb_notify) { \
> +		.callback = CB_GATTC_NOTIFY, \
> +		.callback_result.conn_id = cb_conn_id, \
> +		.callback_result.notify_params = cb_notify \
> +	}
> +
>  #define CALLBACK_GATTC_DISCONNECT(cb_res, cb_prop, cb_conn_id,
> cb_client_id) { \ .callback = CB_GATTC_CLOSE, \
>  		.callback_result.status = cb_res, \
> @@ -448,6 +464,8 @@ struct bt_callback_data {
>  	btgatt_srvc_id_t *included;
>  	btgatt_read_params_t *read_params;
>  	btgatt_write_params_t *write_params;
> +	btgatt_notify_params_t *notify_params;
> +	int notification_registered;
>  	int char_prop;
> 
>  	btpan_control_state_t ctrl_state;

This set needs to be rebased.

-- 
BR
Szymon Janc
