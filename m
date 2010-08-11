Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Aug 2010 09:27:57 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix not unmarking temporary flag when a new key is
 created
Message-ID: <20100811132757.GC13302@jh-x301>
References: <1281530667-25379-1-git-send-email-luiz.dentz@gmail.com>
 <1281530667-25379-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281530667-25379-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Aug 11, 2010, Luiz Augusto von Dentz wrote:
> --- a/src/dbus-hci.c
> +++ b/src/dbus-hci.c
> @@ -746,8 +746,8 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
>  	else if (!bonding && old_key_type == 0xff)
>  		hcid_dbus_bonding_process_complete(local, peer, 0);
>  
> -	if (temporary)
> -		device_set_temporary(device, TRUE);
> +	if (device_is_temporary(device) != temporary)
> +		device_set_temporary(device, temporary);
>  
>  	return 0;

I'd prefer if you just call device_set_temporary(device, temporary)
directly. That'd save you the if-check and a call to device_is_temporary.

Johan
