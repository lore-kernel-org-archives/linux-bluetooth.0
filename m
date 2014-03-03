Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Mar 2014 12:10:27 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 10/16] android/avrcp: Add handler for
 GetCapabilities command
Message-ID: <20140303101025.GC4999@aemeltch-MOBL1>
References: <1393786109-6554-1-git-send-email-luiz.dentz@gmail.com>
 <1393786109-6554-10-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393786109-6554-10-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Mar 02, 2014 at 08:48:25PM +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  android/avrcp-lib.h |  1 +
>  android/avrcp.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
> index 8625425..dda1d28 100644
> --- a/android/avrcp-lib.h
> +++ b/android/avrcp-lib.h
> @@ -51,6 +51,7 @@
>  #define AVRCP_EVENT_TRACK_CHANGED		0x02
>  #define AVRCP_EVENT_TRACK_REACHED_END		0x03
>  #define AVRCP_EVENT_TRACK_REACHED_START		0x04
> +#define AVRCP_EVENT_PLAYBACK_POS_CHANGED	0x05
>  #define AVRCP_EVENT_SETTINGS_CHANGED		0x08
>  #define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED	0x0a
>  #define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED	0x0b
> diff --git a/android/avrcp.c b/android/avrcp.c
> index 9d86803..bcaa66c 100644
> --- a/android/avrcp.c
> +++ b/android/avrcp.c
> @@ -26,6 +26,7 @@
>  #endif
>  
>  #include <stdbool.h>
> +#include <errno.h>
>  #include <glib.h>
>  
>  #include "btio/btio.h"
> @@ -339,6 +340,46 @@ static const struct avrcp_passthrough_handler passthrough_handlers[] = {
>  		{ },
>  };
>  
> +static ssize_t handle_get_capabilities(struct avrcp *session,
> +						uint8_t transaction,
> +						uint16_t params_len,
> +						uint8_t *params,
> +						void *user_data)
> +{
> +	uint32_t id = 0x001958;

Don't we have it defined?

Best regards 
Andrei Emeltchenko 

> +
> +	if (params_len != 1)
> +		return -EINVAL;
> +
> +	switch (params[0]) {
> +	case CAP_COMPANY_ID:
> +		params[params_len++] = 1;
> +		hton24(&params[params_len], id);
> +		return params_len + 3;
> +	case CAP_EVENTS_SUPPORTED:
> +		/* Android do not provide this info via HAL so the list most
> +		 * be hardcoded according to what RegisterNotification can
> +		 * actually handle */
> +		params[params_len++] = 6;
> +		params[params_len++] = AVRCP_EVENT_STATUS_CHANGED;
> +		params[params_len++] = AVRCP_EVENT_TRACK_CHANGED;
> +		params[params_len++] = AVRCP_EVENT_TRACK_REACHED_END;
> +		params[params_len++] = AVRCP_EVENT_TRACK_REACHED_START;
> +		params[params_len++] = AVRCP_EVENT_PLAYBACK_POS_CHANGED;
> +		params[params_len++] = AVRCP_EVENT_SETTINGS_CHANGED;
> +		return params_len;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct avrcp_control_handler control_handlers[] = {
> +		{ AVRCP_GET_CAPABILITIES,
> +					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> +					handle_get_capabilities },
> +		{ },
> +};
> +
>  static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  {
>  	struct avrcp_device *dev;
> @@ -390,6 +431,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  	avrcp_set_destroy_cb(dev->session, disconnect_cb, dev);
>  	avrcp_set_passthrough_handlers(dev->session, passthrough_handlers,
>  									dev);
> +	avrcp_set_control_handlers(dev->session, control_handlers, dev);
>  
>  	/* FIXME: get the real name of the device */
>  	avrcp_init_uinput(dev->session, "bluetooth", address);
> -- 
> 1.8.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
