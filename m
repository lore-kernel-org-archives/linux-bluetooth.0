Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Dec 2010 17:11:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Fix leak of EIR data if RSSI does not change
Message-ID: <20101227151122.GD17203@jh-x301>
References: <1293456068-11615-1-git-send-email-anderson.lizardo@openbossa.org>
 <1293456068-11615-4-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293456068-11615-4-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Dec 27, 2010, Anderson Lizardo wrote:
> --- a/src/event.c
> +++ b/src/event.c
> @@ -452,9 +452,13 @@ void btd_event_advertising_report(bdaddr_t *local, le_advertising_info *info)
>  
>  	rssi = *(info->data + info->length);
>  
> -	adapter_update_device_from_info(adapter, info->bdaddr, rssi,
> +	if (!adapter_update_device_from_info(adapter, info->bdaddr, rssi,
>  					info->evt_type, eir_data.name,
> -					eir_data.services, eir_data.flags);
> +					eir_data.services, eir_data.flags)) {
> +		g_slist_foreach(eir_data.services, (GFunc) g_free, NULL);
> +		g_slist_free(eir_data.services);
> +		g_free(eir_data.name);
> +	}
>  }
>  
>  static void update_lastseen(bdaddr_t *sba, bdaddr_t *dba)
> @@ -556,8 +560,12 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
>  	} else if (eir_data.name != NULL)
>  		g_free(eir_data.name);
>  
> -	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
> -					legacy, eir_data.services, name_status);
> +	if (!adapter_update_found_devices(adapter, peer, rssi, class, name,
> +					alias, legacy, eir_data.services,
> +					name_status)) {
> +		g_slist_foreach(eir_data.services, (GFunc) g_free, NULL);
> +		g_slist_free(eir_data.services);
> +	}
>  
>  	g_free(name);
>  	g_free(alias);

In general this seems fine, but to avoid future memory leaks in case you
go ahead and change the eir_data struct wouldn't it be better to have a
separate free_eir_data() function which does the g_slist_foreach,
g_slist_free and g_free?

Johan
