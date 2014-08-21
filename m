Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ 03/11] shared/gatt-client: Added initial skeleton and simple functions.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1408565737-8187-4-git-send-email-armansito@chromium.org>
Date: Thu, 21 Aug 2014 13:35:51 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <41D7DE0B-C63B-4AD5-9C53-B323E787219A@holtmann.org>
References: <1408565737-8187-1-git-send-email-armansito@chromium.org> <1408565737-8187-4-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch introduces shared/gatt-client, which provides a central/client side
> implementation of the Generic Attribute Profile. An instance of bt_gatt_client
> will provide a central database of all GATT services, characteristics, and
> descriptors that have been discovered on a peripheral and will provide API
> functions to obtain information about discovered attributes, registering
> handlers for "Service Changed" indications, as well as providing
> reference-counted access to "Client Characteristic Configuration" descriptors.
> ---
> Makefile.am              |   3 +-
> src/shared/TODO          |  13 ++++++
> src/shared/gatt-client.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++
> src/shared/gatt-client.h |  54 +++++++++++++++++++++++++
> 4 files changed, 170 insertions(+), 1 deletion(-)
> create mode 100644 src/shared/TODO
> create mode 100644 src/shared/gatt-client.c
> create mode 100644 src/shared/gatt-client.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index 88fcb49..6aed8e2 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -158,7 +158,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
> 			src/shared/util.h src/shared/util.c \
> 			src/shared/mgmt.h src/shared/mgmt.c \
> 			src/shared/att-types.h src/shared/att.h src/shared/att.c \
> -			src/shared/gatt-helpers.h src/shared/gatt-helpers.c
> +			src/shared/gatt-helpers.h src/shared/gatt-helpers.c \
> +			src/shared/gatt-client.h src/shared/gatt-client.c
> src_bluetoothd_LDADD = lib/libbluetooth-internal.la gdbus/libgdbus-internal.la \
> 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
> src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
> diff --git a/src/shared/TODO b/src/shared/TODO
> new file mode 100644
> index 0000000..2881c97
> --- /dev/null
> +++ b/src/shared/TODO
> @@ -0,0 +1,13 @@
> +TODOs for shared/gatt-client
> +
> +* Add util_debug support.
> +* Add high-level abstraction for services, characteristics, and descriptors.
> +* Implement service discovery.
> +* Implement characteristic discovery.
> +* Implement descriptor discovery.
> +* Handle request timeouts.
> +* Make bt_gatt_client observe disconnect events. Handle bonded/non-bonded cases.
> +* Add support for auto-connects using a different bt_att.
> +* Add functions for reference counted access to enable/disable
> +  notifications/indications.
> +* Add support for "Service Changed".

great idea with the TODO. However please just use top-level TODO and patches modifying the TODO should be all by itself.

> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> new file mode 100644
> index 0000000..53a7de1
> --- /dev/null
> +++ b/src/shared/gatt-client.c
> @@ -0,0 +1,101 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Google Inc.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-client.h"
> +#include "src/shared/util.h"
> +
> +struct bt_gatt_client {
> +	struct bt_att *att;
> +	bool persist;
> +};
> +
> +struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att)
> +{
> +	struct bt_gatt_client *client;
> +
> +	if (!att)
> +		return NULL;
> +
> +	client = new0(struct bt_gatt_client, 1);
> +	if (!client)
> +		return NULL;
> +
> +	client->att = bt_att_ref(att);
> +
> +	return client;
> +}
> +
> +void bt_gatt_client_destroy(struct bt_gatt_client *client)
> +{
> +	if (!client)
> +		return;
> +
> +	bt_att_unref(client->att);
> +	free(client);
> +}
> +
> +bool bt_gatt_client_set_persist(struct bt_gatt_client *client,
> +							bool do_persist)
> +{
> +	if (!client)
> +		return false;
> +
> +	client->persist = do_persist;
> +
> +	return true;
> +}
> +
> +struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client)
> +{
> +	if (!client)
> +		return NULL;
> +
> +	return client->att;
> +}
> +
> +bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
> +					bt_gatt_client_callback_t callback,
> +					void *user_data,
> +					bt_gatt_client_destroy_func_t destroy)
> +{
> +	// TODO
> +}
> +
> +unsigned int bt_gatt_client_register_service_changed(
> +				struct bt_gatt_client *client,
> +				uint16_t handle,
> +				bt_gatt_client_service_changed_func_t callback,
> +				void *user_data,
> +				bt_gatt_client_destroy_func_t destroy)
> +{
> +	// TODO
> +	return 0;
> +}
> +
> +bool bt_gatt_client_unregister_service_changed(struct bt_gatt_client *client,
> +							unsigned int id)
> +{
> +	// TODO
> +	return false;
> +}
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> new file mode 100644
> index 0000000..a978691
> --- /dev/null
> +++ b/src/shared/gatt-client.h
> @@ -0,0 +1,54 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014  Google Inc.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +struct bt_gatt_client;
> +
> +struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att);
> +void bt_gatt_client_destroy(struct bt_gatt_client *client);

lets keep using bt_gatt_client_{ref,unref} here as well. No _destroy please.

> +
> +bool bt_gatt_client_set_persist(struct bt_gatt_client *client,
> +							bool do_persist);
> +
> +struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client);

I really hope that we do not need this. Lets try really hard to avoid it.

> +
> +typedef void (*bt_gatt_client_destroy_func_t)(void *user_data);
> +typedef void (*bt_gatt_client_callback_t)(void *user_data);
> +typedef void (*bt_gatt_client_service_changed_func_t)(uint16_t handle,
> +							void *user_data);
> +
> +bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
> +					bt_gatt_client_callback_t callback,
> +					void *user_data,
> +					bt_gatt_client_destroy_func_t destroy);

Do not bother with it like this. Let do it like this:

	client = bt_gatt_client_new(att);

	bt_gatt_client_set_mtu(client, mtu);
	bt_gatt_client_set_ready_handler(client, callback, my_data, my_destroy);

Since we are not multi-threaded this will be safe and a lot cleaner to read.

> +
> +unsigned int bt_gatt_client_register_service_changed(
> +				struct bt_gatt_client *client,
> +				uint16_t handle,
> +				bt_gatt_client_service_changed_func_t callback,
> +				void *user_data,
> +				bt_gatt_client_destroy_func_t destroy);
> +bool bt_gatt_client_unregister_service_changed(struct bt_gatt_client *client,
> +							unsigned int id);

Are we expecting more than one here. If not, then better use bt_gatt_client_set_changed_handler.

Actually it make make sense to set ready handler and services changed handler with the same call. Try it out.

Regards

Marcel

