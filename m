Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Handle Register gatt client command
Date: Sat, 08 Mar 2014 21:03:46 +0100
Message-ID: <1878703.V8asBRyydQ@leonov>
In-Reply-To: <1394197499-2207-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1394197499-2207-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 07 of March 2014 14:04:58 Grzegorz Kolodziejczyk wrote:
> This adds register gatt client app command handling.
> ---
>  android/gatt.c | 63
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed,
> 62 insertions(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index ce85af4..f8f7208 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -31,6 +31,7 @@
>  #include <glib.h>
> 
>  #include "ipc.h"
> +#include "ipc-common.h"
>  #include "lib/bluetooth.h"
>  #include "gatt.h"
>  #include "src/log.h"
> @@ -38,13 +39,73 @@
> 
>  static struct ipc *hal_ipc = NULL;
>  static bdaddr_t adapter_addr;
> +static int32_t client_if_counter;

Just use local static variable in function that use this counter.

> +
> +struct gatt_client {
> +	int32_t client_if;
> +	uint8_t uuid[16];
> +};
> +
> +GList *gatt_client_list = NULL;

This should be static. Also don't mix statics and type definitions.
And name it gatt_clients or just clients.

> +
> +static int find_client_uuid(gconstpointer data, gconstpointer user_data)
> +{
> +	const uint8_t *exp_uuid = user_data;
> +	const uint8_t *cur_uuid = ((struct gatt_client *)data)->uuid;
> +	struct gatt_client *client;
> +
> +	if (memcmp(exp_uuid, cur_uuid, sizeof(client->uuid)))
> +		return 1;
> +
> +	return 0;
> +}

Just return memcmp(); should be enough.

> +

This extra empty line is not needed.

> 
>  static void handle_client_register(const void *buf, uint16_t len)
>  {
> +	const struct hal_cmd_gatt_client_register *cmd = buf;
> +	struct hal_ev_gatt_client_register_client ev;
> +	struct gatt_client *client;
> +	GList *found_client_uuid;
> +
>  	DBG("");
> 
> +	if (!cmd->uuid) {
> +		error("no uuid received");

Lets prefix all info and error messages with "gatt: "

> +		goto failed;
> +	}
> +
> +	found_client_uuid = g_list_find_custom(gatt_client_list,
> +					&cmd->uuid, find_client_uuid);
> +
> +	if (found_client_uuid) {

if (g_list_find_custom(..)) {
}

> +		error("client uuid is already on list");
> +		goto failed;
> +	}
> +
> +	client = g_new0(struct gatt_client, 1);
> +	g_memmove(client->uuid, cmd->uuid, sizeof(client->uuid));

Why g_memmove? Just use memcpy() here.

> +
> +	client->client_if = ++client_if_counter;
> +
> +	gatt_client_list = g_list_append(gatt_client_list, client);
> +
>  	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_REGISTER,
> -							HAL_STATUS_FAILED);
> +							HAL_STATUS_SUCCESS);

I would add status variable and pass it to ipc_send_rsp() at the end of 
function.

> +
> +	ev.status = HAL_STATUS_SUCCESS;
> +	ev.client_if = client->client_if;
> +	g_memmove(ev.app_uuid, client->uuid, sizeof(client->uuid));

memcpy();

> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
> +			HAL_EV_GATT_CLIENT_REGISTER_CLIENT, sizeof(ev), &ev);
> +
> +	return;
> +
> +failed:
> +	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
> +				HAL_OP_GATT_CLIENT_REGISTER, HAL_STATUS_FAILED);
> +
>  }
> 
>  static void handle_client_unregister(const void *buf, uint16_t len)

-- 
BR
Szymon Janc
