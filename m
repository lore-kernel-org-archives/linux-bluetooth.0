Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Jun 2011 12:31:43 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix unpair device when disconnected for No Bonding
Message-ID: <20110620093143.GA8079@dell.ger.corp.intel.com>
References: <1308561837-11530-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308561837-11530-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Mon, Jun 20, 2011, Dmitriy Paliy wrote:
> Fix Paired property of device to be false if 'No Bonding' authentication
> is used. This property is set to false when device is disconnected and
> no link key is stored. Otherwise, there can be cases when device is still
> valid and being claimed as paired without available bonding information.
> 
> For instanse, use of CreateDevice method call and obex client file
> transfer is such use case.
> ---
>  src/device.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/src/device.c b/src/device.c
> index ae6a0d5..e886448 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -830,6 +830,14 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn)
>  		device->disconnects = g_slist_remove(device->disconnects, msg);
>  	}
>  
> +	if (device_is_paired(device)) {
> +		bdaddr_t src;
> +
> +		adapter_get_address(device->adapter, &src);
> +		if (read_link_key(&src, &device->bdaddr, NULL, NULL))
> +			device_set_paired(device, FALSE);
> +	}

Coding-style wise your read_link_key call should be checking for < 0 or
specifically for -ENOENT (you're calling the function as if it returned
a boolean value). However, I'm thinking we might just store the
no-bonding info in the device struct itself so you don't need to consult
the storage in this case. I.e. in addition to device_is_paired there'd
also be a device_is_bonded function which'd make the logic like:

	if (device_is_paired(device) && !device_is_bonded(device))
		device_set_paired(device, FALSE);

Thoughts? Have you checked that this works both with hciops and mgmtops?

Johan
