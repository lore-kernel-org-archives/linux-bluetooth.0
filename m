Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 1/7] android/gatt: Add initial implementation of get_included_service
Date: Fri, 28 Mar 2014 13:28:48 +0100
Message-ID: <2901483.PT5U6ARn84@uw000953>
In-Reply-To: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Friday 28 of March 2014 11:49:16 Marcin Kraglak wrote:
> It will look for included service in range passed in command.
> It call gatt_find_included(), but without result callback now,
> as it is initial version.
> ---
>  android/gatt.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 92e16d4..cf0ad61 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -949,13 +949,67 @@ reply:
>  			HAL_OP_GATT_CLIENT_SEARCH_SERVICE, status);
>  }
>  
> +static bool match_service_by_uuid(const void *data, const void *user_data)
> +{
> +	const struct service *service = data;
> +	const bt_uuid_t *uuid = user_data;
> +	bt_uuid_t service_uuid;
> +
> +	if (bt_string_to_uuid(&service_uuid, service->primary.uuid) < 0)
> +		return false;
> +
> +	return !bt_uuid_cmp(uuid, &service_uuid);
> +}
> +
> +static struct service *find_service_by_uuid(struct gatt_device *device,
> +								bt_uuid_t *uuid)
> +{
> +	return queue_find(device->services, match_service_by_uuid, uuid);
> +}
> +
>  static void handle_client_get_included_service(const void *buf, uint16_t len)
>  {
> +	const struct hal_cmd_gatt_client_get_included_service *cmd = buf;
> +	struct gatt_device *device;
> +	struct service *service;
> +	uint8_t status;
> +
>  	DBG("");
>  
> +	device = find_device_by_conn_id(cmd->conn_id);
> +	if (!device) {
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	if (queue_isempty(device->services)) {
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	if (!cmd->number) {
> +		service = queue_peek_head(device->services);
> +	} else {
> +		bt_uuid_t uuid;
> +
> +		android2uuid(cmd->srvc_id->uuid, &uuid);
> +		service = find_service_by_uuid(device, &uuid);
> +	}
> +
> +	if (!service) {
> +		status = HAL_STATUS_FAILED;
> +		goto failed;
> +	}
> +
> +	gatt_find_included(device->attrib, service->primary.range.start,
> +					service->primary.range.end, NULL, NULL);
> +
> +	status = HAL_STATUS_SUCCESS;
> +
> +failed:
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
>  					HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE,
> -					HAL_STATUS_FAILED);
> +					status);
>  }
>  
>  static void send_client_char_notify(const struct characteristic *ch,
> 

All patches applied, thanks.

-- 
Best regards, 
Szymon Janc
