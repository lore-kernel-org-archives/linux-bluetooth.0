Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 06/11] android/gatt: Add implementation of get_included_cb
Date: Thu, 27 Mar 2014 23:04:22 +0100
Message-ID: <3474351.iO5yJEi74a@athlon>
In-Reply-To: <1395954789-32459-6-git-send-email-marcin.kraglak@tieto.com>
References: <1395954789-32459-1-git-send-email-marcin.kraglak@tieto.com> <1395954789-32459-6-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thursday 27 March 2014 22:13:04 Marcin Kraglak wrote:
> It will pass found services to upper layer with notification.
> Caching included services should be done later.
> ---
>  android/gatt.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 7eb867b..e35b099 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -980,10 +980,53 @@ struct get_included_data {
> 
>  static void get_included_cb(uint8_t status, GSList *included, void
> *user_data) {
> +	struct hal_ev_gatt_client_get_inc_service ev;
>  	struct get_included_data *data = user_data;
> +	struct gatt_device *device = data->device;
> +	struct service *service = data->service;
> +	GSList *list = included;

This is not needed, just use included (it is already a copy).

> +	bt_uuid_t uuid;
> +
> +	DBG("");
> 
> -	/* TODO pass included services to notification */
>  	free(data);
> +
> +	if (status) {
> +		error("gatt: no included services found");
> +		return;
> +	}
> +
> +	bt_string_to_uuid(&uuid, service->primary.uuid);
> +
> +	/* TODO store included services in device->services list */
> +	for (; list; list = list->next) {
> +		struct gatt_included *included = list->data;

You are shadowing variable here, please don't do that.

> +		bt_uuid_t inc_uuid;
> +
> +		ev.conn_id = device->conn_id;
> +		ev.status = HAL_STATUS_SUCCESS;
> +
> +		ev.srvc_id.inst_id = 0;
> +		uuid2android(&uuid, ev.srvc_id.uuid);
> +
> +		ev.incl_srvc_id.inst_id = 0;
> +		bt_string_to_uuid(&inc_uuid, included->uuid);
> +		uuid2android(&uuid, ev.incl_srvc_id.uuid);
> +
> +		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
> +					HAL_EV_GATT_CLIENT_GET_INC_SERVICE,
> +					sizeof(ev), &ev);
> +	}
> +
> +	/* Android expects notification with error status in the end */
> +	ev.conn_id = device->conn_id;
> +	ev.status = HAL_STATUS_FAILED;
> +	ev.srvc_id.inst_id = 0;
> +	uuid2android(&uuid, ev.srvc_id.uuid);
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
> +					HAL_EV_GATT_CLIENT_GET_INC_SERVICE,
> +					sizeof(ev), &ev);
>  }
> 
>  static void handle_client_get_included_service(const void *buf, uint16_t
> len)

-- 
Szymon K. Janc
szymon.janc@gmail.com
