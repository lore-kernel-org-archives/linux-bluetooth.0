Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 08/15] android/hal-health: Add HDP .init method
Date: Wed, 12 Mar 2014 20:56:28 +0100
Message-ID: <2140883.HtAK6ZQ936@athlon>
In-Reply-To: <1394637058-586-9-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1394637058-586-9-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Wednesday 12 March 2014 17:10:51 Ravi kumar Veeramally wrote:
> ---
>  android/hal-health.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/android/hal-health.c b/android/hal-health.c
> index 55db7f6..649661e 100644
> --- a/android/hal-health.c
> +++ b/android/hal-health.c
> @@ -26,9 +26,50 @@
>  #include "ipc-common.h"
>  #include "hal-ipc.h"
> 
> +static const bthl_callbacks_t *cbacks;

Please explicitly initialize it to NULL.

> +
> +static bool interface_ready(void)
> +{
> +	return cbacks != NULL;
> +}
> +
> +/* handlers will be called from notification thread context,
> + * index in table equals to 'opcode - HAL_MINIMUM_EVENT' */
> +static const struct hal_ipc_handler ev_handlers[] = {
> +};
> +
> +static bt_status_t init(bthl_callbacks_t *callbacks)
> +{
> +	struct hal_cmd_register_module cmd;
> +	int ret;
> +
> +	DBG("");
> +
> +	if (interface_ready())
> +		return BT_STATUS_DONE;
> +
> +	/* store reference to user callbacks */
> +	cbacks = callbacks;
> +
> +	hal_ipc_register(HAL_SERVICE_ID_HEALTH, ev_handlers,
> +				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
> +
> +	cmd.service_id = HAL_SERVICE_ID_HEALTH;
> +
> +	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
> +					sizeof(cmd), &cmd, 0, NULL, NULL);
> +
> +	if (ret != BT_STATUS_SUCCESS) {
> +		cbacks = NULL;
> +		hal_ipc_unregister(HAL_SERVICE_ID_HEALTH);
> +	}
> +
> +	return ret;
> +}
> +
>  static bthl_interface_t health_if = {
>  	.size = sizeof(health_if),
> -	.init = NULL,
> +	.init = init,
>  	.register_application = NULL,
>  	.unregister_application = NULL,
>  	.connect_channel = NULL,

-- 
Szymon K. Janc
szymon.janc@gmail.com
