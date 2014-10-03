Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] android/hal-mce: Add event handler
Date: Fri, 03 Oct 2014 13:34:55 +0200
Message-ID: <2130454.YRCQC94hdb@uw000953>
In-Reply-To: <1411383708-28621-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1411383708-28621-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1411383708-28621-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 22 of September 2014 13:01:47 Grzegorz Kolodziejczyk wrote:
> ---
>  android/hal-map-client.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/android/hal-map-client.c b/android/hal-map-client.c
> index 7fb3011..7538958 100644
> --- a/android/hal-map-client.c
> +++ b/android/hal-map-client.c
> @@ -15,6 +15,7 @@
>   *
>   */
>  
> +#include <stdlib.h>
>  #include <stdbool.h>
>  
>  #include "hal-log.h"
> @@ -31,9 +32,55 @@ static bool interface_ready(void)
>  
>  /* Event Handlers */
>  
> +static void remote_mas_instances_to_hal(btmce_mas_instance_t *send_instance,
> +				struct hal_map_client_mas_instance *instance,
> +				uint8_t num_instances, uint16_t len)
> +{
> +	void *buf = instance;
> +	uint8_t i;
> +
> +	DBG("");
> +
> +	for (i = 0; i < num_instances; i++) {
> +		if (sizeof(*instance) + instance->name_len > len) {
> +			error("invalid remote mas instances (%zu > %u),"
> +				"aborting",

Try not to break strings ie. make this shorter by removing 'remote'.

> +				sizeof(*instance) + instance->name_len, len);
> +			exit(EXIT_FAILURE);
> +		}
> +
> +		send_instance[i].id = instance->id;
> +		send_instance[i].msg_types = instance->msg_types;
> +		send_instance[i].scn = instance->scn;
> +		send_instance[i].p_name = (char *) instance->name;

You should check if name is NULL terminated and abort if not.
Check handle_dial() in hal-handsfree for reference.

> +
> +		len -= sizeof(*instance) + instance->name_len;
> +		buf += sizeof(*instance) + instance->name_len;
> +		instance = buf;
> +	}
> +
> +	if (!len)
> +		return;
> +
> +	error("invalid remote mas instances (%u bytes left), aborting", len);
> +	exit(EXIT_FAILURE);
> +}
> +
>  static void handle_remote_mas_instances(void *buf, uint16_t len, int fd)
>  {
> +	struct hal_ev_map_client_remote_mas_instances *ev = buf;
> +	btmce_mas_instance_t instances[ev->num_instances];
> +
> +	DBG("");
> +
> +	len -= sizeof(*ev);
> +	remote_mas_instances_to_hal(instances, ev->instances, ev->num_instances,
> +									len);
>  
> +	if (cbs->remote_mas_instances_cb)
> +		cbs->remote_mas_instances_cb(ev->status,
> +						(bt_bdaddr_t *) ev->bdaddr,
> +						ev->num_instances, instances);
>  }
>  
>  /* handlers will be called from notification thread context,
> 

-- 
Best regards, 
Szymon Janc
