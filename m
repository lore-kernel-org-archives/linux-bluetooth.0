Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Sep 2013 13:01:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH bluez] bnep: don't error() if kernel lacks bnep module
Message-ID: <20130913100142.GB10346@x220.p-661hnu-f1>
References: <1378477387-13186-1-git-send-email-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378477387-13186-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Fri, Sep 06, 2013, David Herrmann wrote:
> If a user disables bnep kernel support, they normally do that on purpose.
> It's misleading to print an error during module-startup in this situation.
> Therefore, only print a hint that bnep-support is missing if
> EPROTONOSUPPORT is returned by the kernel.
> 
> Furthermore, allow modules to forward ENOSYS as error to bluetoothd core
> to handle it as "module is not compatible with system setup" instead of an
> error. ENOSYS is commonly used to signal "missing kernel infrastructure"
> so it seems appropriate here.
> ---
>  profiles/network/common.c  |  7 ++++++-
>  profiles/network/manager.c | 17 ++++++++++++++---
>  src/plugin.c               | 11 +++++++++--
>  3 files changed, 29 insertions(+), 6 deletions(-)

First of all, sorry for the delay with reviewing this. I forgot about it
and only bumped into it now when checking what I'd missed from the last
month in my linux-bluetooth folder.

> diff --git a/profiles/network/common.c b/profiles/network/common.c
> index e069892..17bff30 100644
> --- a/profiles/network/common.c
> +++ b/profiles/network/common.c
> @@ -110,8 +110,13 @@ int bnep_init(void)
>  
>  	if (ctl < 0) {
>  		int err = -errno;
> -		error("Failed to open control socket: %s (%d)",
> +
> +		if (err == -EPROTONOSUPPORT)
> +			info("kernel lacks bnep-protocol support");

I think warn() might be more appropriate here.

> diff --git a/profiles/network/manager.c b/profiles/network/manager.c
> index 03b1b3d..7697766 100644
> --- a/profiles/network/manager.c
> +++ b/profiles/network/manager.c
> @@ -25,6 +25,7 @@
>  #include <config.h>
>  #endif
>  
> +#include <errno.h>
>  #include <stdbool.h>
>  
>  #include <bluetooth/bluetooth.h>
> @@ -169,11 +170,21 @@ static struct btd_profile nap_profile = {
>  
>  static int network_init(void)
>  {
> +	int r;

Please use "err". That's the convention for integer error variables.

> +	r = bnep_init();
> +	if (r) {
> +		if (r == -EPROTONOSUPPORT) {
> +			info("bnep module not available, disabling plugin");
> +			r = -ENOSYS;
> +		} else {
> +			error("Can't init bnep module");
> +			r = -1;

I think it'd make sense to just pass forward whatever error bnep_init()
returned instead of mapping to -1 (which isn't even a valid error code -
we should fix this in several places of the existing code base).

> diff --git a/src/plugin.c b/src/plugin.c
> index 51c98bc..396c8af 100644
> --- a/src/plugin.c
> +++ b/src/plugin.c
> @@ -119,6 +119,7 @@ gboolean plugin_init(const char *enable, const char *disable)
>  	const char *file;
>  	char **cli_disabled, **cli_enabled;
>  	unsigned int i;
> +	int r;

Again, please use "err".

>  	/* Make a call to BtIO API so its symbols got resolved before the
>  	 * plugins are loaded. */
> @@ -196,8 +197,14 @@ start:
>  	for (list = plugins; list; list = list->next) {
>  		struct bluetooth_plugin *plugin = list->data;
>  
> -		if (plugin->desc->init() < 0) {
> -			error("Failed to init %s plugin", plugin->desc->name);
> +		r = plugin->desc->init();
> +		if (r < 0) {
> +			if (r == -ENOSYS)
> +				info("System does not support %s plugin",
> +							plugin->desc->name);

warn() might be more appropriate here.

> +			else
> +				error("Failed to init %s plugin",
> +							plugin->desc->name);
>  			continue;
>  		}

In general this plugin.c update should probably go into its own patch
that precedes the network plugin patch.

Johan
