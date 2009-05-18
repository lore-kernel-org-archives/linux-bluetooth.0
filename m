Return-Path: <cyrus@holtmann.org>
Message-ID: <4A10C797.4080803@aircable.net>
Date: Sun, 17 May 2009 23:27:35 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Jaikumar Ganesh <jaikumar@google.com>
Subject: Re: [PATCH] Emit device_found when RSSI changes.
References: <1241505159-12795-1-git-send-email-jaikumar@google.com>
In-Reply-To: <1241505159-12795-1-git-send-email-jaikumar@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Guys,
> When the RSSI of the remote device changes, emit
> device found. Currently, we were not sending
> emit_device_found signal, when the RSSI of already
> found devices gets updated.
>   
Is there any reason why this patch hasn't been applied? I've been using 
it for a while and it seems to work pretty well.

I wouldn't mind keep my packages patched, but if it can be merged it's 
even better.

Thanks,
Manuel
> Signed-off-by: Jaikumar Ganesh <jaikumar@google.com>
> ---
>  src/adapter.c  |   24 +++++++++---------------
>  src/dbus-hci.c |   10 ++++++++--
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index d9914e2..1ec076d 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2639,6 +2639,15 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
>  	g_free(alias);
>  }
>  
> +void adapter_update_found_devices_for_rssi(struct btd_adapter *adapter,
> +				struct remote_dev_info *dev, int8_t rssi)
> +{
> +	dev->rssi = rssi;
> +	adapter->found_devices = g_slist_sort(adapter->found_devices,
> +						(GCompareFunc) dev_rssi_cmp);
> +	adapter_emit_device_found(adapter, dev);
> +}
> +
>  void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
>  				int8_t rssi, uint32_t class, const char *name,
>  				const char *alias, gboolean legacy,
> @@ -2650,13 +2659,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
>  	bacpy(&match.bdaddr, bdaddr);
>  	match.name_status = NAME_ANY;
>  
> -	dev = adapter_search_found_devices(adapter, &match);
> -	if (dev) {
> -		if (rssi == dev->rssi)
> -			return;
> -		goto done;
> -	}
> -
>  	dev = g_new0(struct remote_dev_info, 1);
>  
>  	bacpy(&dev->bdaddr, bdaddr);
> @@ -2669,14 +2671,6 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
>  	dev->name_status = name_status;
>  
>  	adapter->found_devices = g_slist_prepend(adapter->found_devices, dev);
> -
> -done:
> -	dev->rssi = rssi;
> -
> -	adapter->found_devices = g_slist_sort(adapter->found_devices,
> -						(GCompareFunc) dev_rssi_cmp);
> -
> -	adapter_emit_device_found(adapter, dev);
>  }
>  
>  int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr)
> diff --git a/src/dbus-hci.c b/src/dbus-hci.c
> index 932682a..d7df415 100644
> --- a/src/dbus-hci.c
> +++ b/src/dbus-hci.c
> @@ -668,9 +668,15 @@ void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
>  	memset(&match, 0, sizeof(struct remote_dev_info));
>  	bacpy(&match.bdaddr, peer);
>  	match.name_status = NAME_SENT;
> -	/* if found: don't send the name again */
> +	/* 
> +	 * if found and rssi has changed, emit device_found
> +	 * if found: don't send the name again.
> +	 */
>  	dev = adapter_search_found_devices(adapter, &match);
> -	if (dev)
> +	if (dev && dev->rssi != rssi) {
> +		adapter_update_found_devices_for_rssi(adapter, dev, rssi);
> +		return;
> +	} else if (dev)
>  		return;
>  
>  	/* the inquiry result can be triggered by NON D-Bus client */
>   

