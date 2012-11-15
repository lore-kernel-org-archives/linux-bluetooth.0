Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Nov 2012 11:31:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 01/20] cyclingspeed: Add CSC profile plugin skeleton
Message-ID: <20121115093126.GA4414@x220>
References: <1352105705-13988-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1352105705-13988-2-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352105705-13988-2-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Mon, Nov 05, 2012, Andrzej Kaczmarek wrote:
> This patch adds stub profile driver plugin for CSC profile.
> ---
>  Makefile.am                          |   9 +-
>  lib/uuid.h                           |   2 +
>  profiles/cyclingspeed/cyclingspeed.c | 163 +++++++++++++++++++++++++++++++++++
>  profiles/cyclingspeed/cyclingspeed.h |  26 ++++++
>  profiles/cyclingspeed/main.c         |  53 ++++++++++++
>  profiles/cyclingspeed/manager.c      |  79 +++++++++++++++++
>  profiles/cyclingspeed/manager.h      |  24 ++++++
>  7 files changed, 354 insertions(+), 2 deletions(-)
>  create mode 100644 profiles/cyclingspeed/cyclingspeed.c
>  create mode 100644 profiles/cyclingspeed/cyclingspeed.h
>  create mode 100644 profiles/cyclingspeed/main.c
>  create mode 100644 profiles/cyclingspeed/manager.c
>  create mode 100644 profiles/cyclingspeed/manager.h

You'll need to rebase these against latest git since this one doesn't
apply cleanly (due to Makefile.am) and doesn't compile either (due to
main_opts.gatt_enabled having been removed).

> +struct csc_adapter {
> +	struct btd_adapter	*adapter;
> +	GSList			*devices;	/* list of registered devices */
> +};
> +
> +struct csc {
> +	struct btd_device	*dev;
> +	struct csc_adapter	*cadapter;
> +};

I'm a bit worried that we've failed to create proper internal GATT APIs
if they require this kind of per-profile tracking of devices and
adapters. You can already get a list of btd_device from btd_adapter and
the btd_adapter from a btd_device. Profiles should only need to track a
very minimal amount of context.

> +++ b/profiles/cyclingspeed/main.c
> @@ -0,0 +1,53 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2012 Tieto Poland
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdint.h>
> +#include <glib.h>
> +#include <errno.h>
> +
> +#include "plugin.h"
> +#include "manager.h"
> +#include "hcid.h"
> +#include "log.h"
> +
> +static int cyclingspeed_init(void)
> +{
> +	if (!main_opts.gatt_enabled) {
> +		DBG("GATT is disabled");
> +		return -ENOTSUP;
> +	}
> +
> +	return cyclingspeed_manager_init();
> +}
> +
> +static void cyclingspeed_exit(void)
> +{
> +	cyclingspeed_manager_exit();
> +}
> +
> +BLUETOOTH_PLUGIN_DEFINE(cyclingspeed, VERSION,
> +					BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
> +					cyclingspeed_init, cyclingspeed_exit)

If this is all the main.c file does seems like it should be merged into
manager.c or even cyclingspeed.c.

> +++ b/profiles/cyclingspeed/manager.c
> @@ -0,0 +1,79 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2012 Tieto Poland
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#include <gdbus.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <bluetooth/uuid.h>
> +
> +#include "adapter.h"
> +#include "device.h"
> +#include "profile.h"
> +#include "att.h"
> +#include "gattrib.h"
> +#include "gatt.h"
> +#include "cyclingspeed.h"
> +#include "manager.h"
> +
> +static int csc_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
> +{
> +	return csc_adapter_register(adapter);
> +}
> +
> +static void csc_adapter_remove(struct btd_profile *p,
> +						struct btd_adapter *adapter)
> +{
> +	csc_adapter_unregister(adapter);
> +}
> +
> +static int csc_device_probe(struct btd_profile *p,
> +				struct btd_device *device, GSList *uuids)
> +{
> +	return csc_device_register(device);
> +}
> +
> +static void csc_device_remove(struct btd_profile *p,
> +						struct btd_device *device)
> +{
> +	csc_device_unregister(device);
> +}
> +
> +static struct btd_profile cscp_profile = {
> +	.name		= "Cycling Speed and Cadence GATT Driver",
> +	.remote_uuids	= BTD_UUIDS(CYCLING_SC_UUID),
> +
> +	.adapter_probe	= csc_adapter_probe,
> +	.adapter_remove	= csc_adapter_remove,
> +
> +	.device_probe	= csc_device_probe,
> +	.device_remove	= csc_device_remove,
> +};
> +
> +int cyclingspeed_manager_init(void)
> +{
> +	return btd_profile_register(&cscp_profile);
> +}
> +
> +void cyclingspeed_manager_exit(void)
> +{
> +	btd_profile_unregister(&cscp_profile);
> +}

Are these functions ever going to do anything else than make single
Vcalls into cyclingspeed.c? If not it seems to me like all this should
be merged into that file.

Btw, I do realize that other profiles might have similar brain dead
design but that's not a good enough excuse to keep replicating the bad
design. Instead the other profiles should be fixed.

Johan
