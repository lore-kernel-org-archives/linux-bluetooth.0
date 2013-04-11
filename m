Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH 6/6] autopair: Add the autopair plugin.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1365628753-16774-7-git-send-email-deymo@chromium.org>
Date: Wed, 10 Apr 2013 22:11:27 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <92759276-C5D5-437D-8FB0-4089DA14E749@holtmann.org>
References: <1365628753-16774-1-git-send-email-deymo@chromium.org> <1365628753-16774-7-git-send-email-deymo@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> The autopair plugin tries standard pincodes for different devices with dumb
> pincodes. It also generates a random 6 digit pincode for keyboards that
> support any pincode but fallbacks to the agent call in case the random
> generated pincode didn't work.
> ---
> Makefile.plugins   |   3 ++
> plugins/autopair.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 148 insertions(+)
> create mode 100644 plugins/autopair.c
> 
> diff --git a/Makefile.plugins b/Makefile.plugins
> index f497782..651a970 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -5,6 +5,9 @@ builtin_sources += plugins/hostname.c
> builtin_modules += wiimote
> builtin_sources += plugins/wiimote.c
> 
> +builtin_modules += autopair
> +builtin_sources += plugins/autopair.c
> +
> if MAINTAINER_MODE
> builtin_modules += gatt_example
> builtin_sources += plugins/gatt-example.c
> diff --git a/plugins/autopair.c b/plugins/autopair.c
> new file mode 100644
> index 0000000..40b8f8b
> --- /dev/null
> +++ b/plugins/autopair.c
> @@ -0,0 +1,145 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2012-2013 Google Inc.
> + *
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
> +#include <stdbool.h>
> +#include <stdlib.h>
> +
> +#include <bluetooth/bluetooth.h>
> +#include <glib.h>
> +
> +#include "plugin.h"
> +#include "adapter.h"
> +#include "device.h"
> +#include "log.h"
> +#include "storage.h"
> +
> +/*
> + * Plugin to handle automatic pairing of devices with reduced user
> + * interaction, including implementing the recommendation of the HID spec
> + * for keyboard devices.
> + *
> + * The plugin works by intercepting the PIN request for devices; if the
> + * device is a keyboard a random six-digit numeric PIN is generated and
> + * returned, flagged for displaying using DisplayPinCode.
> + *
> + */
> +
> +static ssize_t autopair_pincb(struct btd_adapter *adapter,
> +					struct btd_device *device,
> +					char *pinbuf, gboolean *display,
> +					int count)
> +{
> +	char addr[18];
> +	char pinstr[7];
> +	uint32_t class;
> +
> +	ba2str(device_get_address(device), addr);
> +
> +	class = btd_device_get_class(device);
> +
> +	DBG("device %s 0x%x", addr, class);
> +
> +	/* This is a class-based pincode guesser. Ignore devices with an unknown
> +	 * class. */
> +	if (class == 0)
> +		return 0;
> +
> +	switch ((class & 0x1f00) >> 8) {
> +	case 0x04:		/* Audio/Video */
> +		switch ((class & 0xfc) >> 2) {
> +		case 0x01:		/* Wearable Headset Device */
> +		case 0x02:		/* Hands-free Device */
> +		case 0x06:		/* Headphones */
> +		case 0x07:		/* Portable Audio */
> +		case 0x0a:		/* HiFi Audio Device */
> +			if (count == 0)
> +				memcpy(pinbuf, "0000", 4);
> +			else if (count == 1)
> +				memcpy(pinbuf, "1234", 4);
> +			else
> +				return 0;

as mentioned earlier, I do not like the count naming. Here it makes it even worse.

And what I would be doing is creating a string array { "0000", "1234" } that just can be walked and not this hardcoded if statement.

Regards

Marcel

