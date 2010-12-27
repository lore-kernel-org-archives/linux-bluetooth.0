Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Dec 2010 23:48:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix leak of EIR data if RSSI does not change
Message-ID: <20101227214841.GA22777@jh-x301>
References: <1293456068-11615-4-git-send-email-anderson.lizardo@openbossa.org>
 <1293473827-26418-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293473827-26418-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Dec 27, 2010, Anderson Lizardo wrote:
> If RSSI value does not change, memory used by parsed EIR data would leak
> because it would not be assigned to the remote_dev_info structure.
> 
> Also simplify related code and replace a couple of g_free()'s with
> free() (simply because they were allocated with malloc()).

Beware of words like "also" and "and" in commit messages. Often they are
a good indication that the patch shold be split into multiple ones.
Though in this case I can't really make up my mind if it's fine since
the changes are so strongly related. I'll leave it up to you to think
about it and decide if you can cleanly split this into two patches or
not.

> @@ -529,6 +537,14 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
>  	else
>  		name_status = NAME_NOT_REQUIRED;
>  
> +	/* Update storage if EIR contains the complete device name */
> +	if (eir_data.name && eir_data.name_complete) {
> +		write_device_name(local, peer, eir_data.name);
> +		name_status = NAME_NOT_REQUIRED;
> +		g_free(eir_data.name);
> +		eir_data.name = NULL;
> +	}
> +
>  	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "aliases");
>  	alias = textfile_get(filename, peer_addr);
>  
> @@ -547,28 +563,13 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
>  	} else
>  		legacy = TRUE;
>  
> -	if (eir_data.name) {
> -		if (eir_data.name_complete) {
> -			write_device_name(local, peer, eir_data.name);
> -			name_status = NAME_NOT_REQUIRED;
> -
> -			if (name)
> -				g_free(name);
> -
> -			name = eir_data.name;
> -		} else {
> -			if (name)
> -				free(eir_data.name);
> -			else
> -				name = eir_data.name;
> -		}
> -	}
> -
> -	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
> -					legacy, eir_data.services, name_status);
> +	if (!adapter_update_found_devices(adapter, peer, rssi, class, name,
> +					alias, legacy, eir_data.services,
> +					name_status))
> +		free_eir_data(&eir_data);
>  
> -	g_free(name);
> -	g_free(alias);
> +	free(name);
> +	free(alias);
>  }
>  
>  void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,

It looks to me like shortened names are completely ignored after this
patch, even to the extent that if there's a shortened name the memory
will be leaked if adapter_update_found_devices returns TRUE.

If we don't have any name in storage and all we have is a shortened name
then I think it should be included in the DeviceFound signal (which is
what the existing code does).

Johan
