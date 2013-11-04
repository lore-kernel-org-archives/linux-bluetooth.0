Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 11:34:59 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] android/daemon: Implement get adapter name
Message-ID: <20131104093452.GA18874@aemeltch-MOBL1>
References: <1383556934-5481-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383556934-5481-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Nov 04, 2013 at 11:22:13AM +0200, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Sorry, there is similar function exist, I will reuse it.

Best regards 
Andrei Emeltchenko 

> 
> ---
>  android/adapter.c |   29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index cb92f2f..8210d1a 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -1016,13 +1016,32 @@ static void send_adapter_address(void)
>  	g_free(ev);
>  }
>  
> -static bool get_name(void)
> +static bool send_adapter_name(void)
>  {
> -	DBG("Not implemented");
> +	struct hal_ev_adapter_props_changed *ev;
> +	size_t len;
>  
> -	/* TODO: Add implementation */
> +	if (!adapter->name)
> +		return false;
>  
> -	return false;
> +	len = sizeof(*ev) + sizeof(struct hal_property) +
> +						strlen(adapter->name) + 1;
> +
> +	ev = g_malloc0(len);
> +
> +	ev->num_props = 1;
> +	ev->status = HAL_STATUS_SUCCESS;
> +
> +	ev->props[0].type = HAL_PROP_ADAPTER_NAME;
> +	ev->props[0].len = strlen(adapter->name) + 1;
> +	memcpy(&ev->props[0].val, adapter->name, strlen(adapter->name));
> +
> +	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
> +				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
> +
> +	g_free(ev);
> +
> +	return true;
>  }
>  
>  static bool get_uuids(void)
> @@ -1097,7 +1116,7 @@ static bool get_property(void *buf, uint16_t len)
>  		send_adapter_address();
>  		return true;
>  	case HAL_PROP_ADAPTER_NAME:
> -		return get_name();
> +		return send_adapter_name();
>  	case HAL_PROP_ADAPTER_UUIDS:
>  		return get_uuids();
>  	case HAL_PROP_ADAPTER_CLASS:
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
