Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/2 v3] sixaxis: Ask user whether cable configuration should be allowed
Date: Fri, 24 Jul 2015 00:33:06 +0200
Message-ID: <359424171.AW1qIKcMiD@athlon>
In-Reply-To: <1436278465.26954.32.camel@hadess.net>
References: <1436278465.26954.32.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tuesday 07 July 2015 16:14:25 Bastien Nocera wrote:
> Previously, users doing cable configuration of Sixaxis PS3 controllers
> would only get asked whether a device was allowed to connect to the
> computer when switching it to Bluetooth mode: unplugging it, and
> pressing the PS button.
> 
> Instead, we should ask the user straight away, through the agent,
> whether the pad should be allowed to connect.
> 
> This makes it easier to setup those devices, while keeping security.

Wouldn't this confuse user so that he may think device is already connected 
over BT? Also what would happen if user remove this from usb before 
confirming? And if PS button is pressed then, second authorization request for 
same UUID would be send?

Since this change plugin behavior in end user visible way this needs to be 
carefully thought out. It looks like people have different requirements for 
sixaxis security... so maybe it should have a sort of policy settings in 
config file? Opinions?

> ---
>  plugins/sixaxis.c | 80
> +++++++++++++++++++++++++++++++++++++++++++------------ 1 file changed, 63
> insertions(+), 17 deletions(-)
> 
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index fcc93bc..032ff62 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -44,6 +44,7 @@
> 
>  #include "src/adapter.h"
>  #include "src/device.h"
> +#include "src/agent.h"
>  #include "src/plugin.h"
>  #include "src/log.h"
>  #include "src/shared/util.h"
> @@ -71,6 +72,13 @@ static const struct {
>  	},
>  };
> 
> +struct authentication_closure {
> +	struct btd_adapter *adapter;
> +	struct btd_device *device;

You can get adapter from device, no need to store both.

> +	int fd;
> +	char device_addr[18];

Why is device_addr needed for? If only for logs then I'd just convert bdaddr 
to string where needed.

> +};
> +
>  struct leds_data {
>  	char *syspath_prefix;
>  	uint8_t bitmap;
> @@ -255,19 +263,55 @@ out:
>  	return FALSE;
>  }
> 
> +static void agent_auth_cb(DBusError *derr,
> +				void *user_data)
> +{
> +	struct authentication_closure *closure = user_data;
> +	char master_addr[18], adapter_addr[18];
> +	bdaddr_t master_bdaddr;
> +	const bdaddr_t *adapter_bdaddr;
> +
> +	if (derr != NULL) {
> +		DBG("Agent replied negatively, removing temporary device");
> +		goto error;
> +	}
> +
> +	btd_device_set_temporary(closure->device, false);
> +
> +	if (get_master_bdaddr(closure->fd, &master_bdaddr) < 0)
> +		goto error;
> +
> +	adapter_bdaddr = btd_adapter_get_address(closure->adapter);
> +	if (bacmp(adapter_bdaddr, &master_bdaddr)) {
> +		if (set_master_bdaddr(closure->fd, adapter_bdaddr) < 0)
> +			goto error;
> +	}
> +
> +	ba2str(&master_bdaddr, master_addr);
> +	ba2str(adapter_bdaddr, adapter_addr);
> +	DBG("remote %s old_master %s new_master %s",
> +				closure->device_addr, master_addr, adapter_addr);
> +
> +	g_free(closure);
> +
> +	return;
> +
> +error:
> +	btd_adapter_remove_device(closure->adapter, closure->device);
> +	g_free(closure);
> +}
> +
>  static bool setup_device(int fd, int index, struct btd_adapter *adapter)
>  {
> -	char device_addr[18], master_addr[18], adapter_addr[18];
> -	bdaddr_t device_bdaddr, master_bdaddr;
> +	char device_addr[18];
> +	bdaddr_t device_bdaddr;
>  	const bdaddr_t *adapter_bdaddr;
>  	struct btd_device *device;
> +	struct authentication_closure *closure;
> 
>  	if (get_device_bdaddr(fd, &device_bdaddr) < 0)
>  		return false;
> 
> -	if (get_master_bdaddr(fd, &master_bdaddr) < 0)
> -		return false;
> -
>  	/* This can happen if controller was plugged while already connected
>  	 * eg. to charge up battery.
>  	 * Don't set LEDs in that case, hence return false */
> @@ -276,18 +320,7 @@ static bool setup_device(int fd, int index, struct
> btd_adapter *adapter) if (device && btd_device_is_connected(device))
>  		return false;
> 
> -	adapter_bdaddr = btd_adapter_get_address(adapter);
> -
> -	if (bacmp(adapter_bdaddr, &master_bdaddr)) {
> -		if (set_master_bdaddr(fd, adapter_bdaddr) < 0)
> -			return false;
> -	}
> -
>  	ba2str(&device_bdaddr, device_addr);
> -	ba2str(&master_bdaddr, master_addr);
> -	ba2str(adapter_bdaddr, adapter_addr);
> -	DBG("remote %s old_master %s new_master %s",
> -				device_addr, master_addr, adapter_addr);
> 
>  	device = btd_adapter_get_device(adapter, &device_bdaddr, BDADDR_BREDR);
> 
> @@ -302,7 +335,20 @@ static bool setup_device(int fd, int index, struct
> btd_adapter *adapter) btd_device_device_set_name(device,
> devices[index].name);
>  	btd_device_set_pnpid(device, devices[index].source, devices[index].vid,
>  				devices[index].pid, devices[index].version);
> -	btd_device_set_temporary(device, false);
> +	btd_device_set_temporary(device, true);
> +
> +	closure = g_try_new0(struct authentication_closure, 1);
> +	if (!closure) {
> +		btd_adapter_remove_device(adapter, device);
> +		return false;
> +	}
> +	closure->adapter = adapter;
> +	closure->device = device;
> +	closure->fd = fd;
> +	memcpy(&closure->device_addr, device_addr, sizeof(device_addr));
> +	adapter_bdaddr = btd_adapter_get_address(adapter);
> +	btd_request_authorization_cable_configured(adapter_bdaddr, &device_bdaddr,
> +				HID_UUID, agent_auth_cb, closure);
> 
>  	return true;
>  }



-- 
Szymon K. Janc
szymon.janc@gmail.com
