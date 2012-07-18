Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jul 2012 14:51:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v13 02/14] audio: Move telephony drivers to D-Bus
 interface
Message-ID: <20120718115101.GA15775@x220.ger.corp.intel.com>
References: <1342532440-730-1-git-send-email-frederic.danis@linux.intel.com>
 <1342532440-730-3-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1342532440-730-3-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, Jul 17, 2012, Frédéric Danis wrote:
> @@ -1397,42 +817,26 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  	else
>  		hs->auto_dc = FALSE;
>  
> -	g_io_add_watch(chan, G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
> -			(GIOFunc) rfcomm_io_cb, dev);
> +	agent = telephony_agent_by_uuid(device_get_adapter(dev->btd_dev),
> +						hs->connecting_uuid);
> +	slc = telephony_device_connecting(chan, dev->btd_dev, dev, agent);

> +		if (dev->headset->slc)  {
> +			telephony_device_disconnect(dev->headset->slc->slc);
> +			dev->headset->slc->slc = NULL;

headset->slc->slc?

You better rethink the naming of some of these variables.

> +#include "btio.h"
> +#include "log.h"
> +#include "device.h"
> +#include "error.h"
> +#include "glib-helper.h"
> +#include "sdp-client.h"
> +#include "headset.h"
> +#include "telephony.h"
> +#include "dbus-common.h"
> +#include "../src/adapter.h"
> +#include "../src/device.h"

Please sort the includes so that high-level ones come first (i.e.
btio/*.h src/*.h etc). It'll save you from some trouble later and it's
also consistent with how we've tried to keep the rest of the source
tree.

> +struct tel_device {
> +	void			*au_dev;

Just use the right type here, i.e. struct audio_device. You're already
including device.h where it's defined so that should not cause you
trouble.

> +void *telephony_device_connecting(GIOChannel *io, struct btd_device *btd_dev,
> +					void *telephony_device, void *agent)

Please use proper types for the return value, telephony_device and
agent. Don't hide these types where not necessary as it will make it
impossible for the compiler to catch type errors. It's particularly
confusing in this case since the variable you're calling
telephony_device is actually of type struct audio_device (and not struct
tel_device).

If some struct (like struct tel_device) is missing just add a forward
declaration for it (without the full definition) to the relevant .h file
(telephony.h in this case) if you want to keep it opaque.

> +	dev = g_new0(struct tel_device, 1);
> +	dev->btd_dev = btd_dev;

Looks like missing reference counting here, i.e. btd_device_ref(). Also
add an unref to the appropriate place.

> +void telephony_device_connected(void *telephony_device)

No need to use void * here, just use struct tel_device (which wont be a
problem if you add the necessary forward declaration to telephony.h).

> +void telephony_device_disconnect(void *slc)

Same here. Why do you call the variable slc if it doesn't represent an
SLC (it represents a device object).

> +void telephony_device_disconnected(void *telephony_device)

Same here.

> +gboolean telephony_get_ready_state(void *adapter)

And here.

> +static int register_interface(void *adapter)

And here.

> +static void unregister_interface(void *adapter)

And here.

> +int telephony_adapter_init(void *adapter)

And here.

> +void telephony_adapter_exit(void *adapter)

And here.

Johan
