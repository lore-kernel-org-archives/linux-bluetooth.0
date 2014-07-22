Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 01/11] shared/gatt: Introduce gatt-helpers.h skeleton.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405718037-15401-2-git-send-email-armansito@chromium.org>
Date: Wed, 23 Jul 2014 01:23:31 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2774A89A-B2EE-4346-BAD1-DBA0E3014661@holtmann.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org> <1405718037-15401-2-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch introduces the skeleton for src/shared/gatt-helpers, which defines
> helper functions for over-the-air GATT client-side procedures that will be
> frequently used by clients. Most of these functions require several sequential
> ATT protocol requests and it is useful to abstract these details away from the
> upper layer.
> ---
> Makefile.am               |   3 +-
> src/shared/gatt-helpers.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++
> src/shared/gatt-helpers.h | 133 +++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 276 insertions(+), 1 deletion(-)
> create mode 100644 src/shared/gatt-helpers.c
> create mode 100644 src/shared/gatt-helpers.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index 4588ce8..e4f7df2 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -157,7 +157,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
> 			src/shared/queue.h src/shared/queue.c \
> 			src/shared/util.h src/shared/util.c \
> 			src/shared/mgmt.h src/shared/mgmt.c \
> -			src/shared/att-types.h src/shared/att.h src/shared/att.c
> +			src/shared/att-types.h src/shared/att.h src/shared/att.c \
> +			src/shared/gatt-helpers.h src/shared/gatt-helpers.c
> src_bluetoothd_LDADD = lib/libbluetooth-internal.la gdbus/libgdbus-internal.la \
> 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
> src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> new file mode 100644
> index 0000000..3d85868
> --- /dev/null
> +++ b/src/shared/gatt-helpers.c
> @@ -0,0 +1,141 @@
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
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include "src/shared/queue.h"
> +#include "src/shared/att.h"
> +#include "lib/uuid.h"
> +#include "src/shared/gatt-helpers.h"
> +
> +bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_gatt_discover_primary_services(struct bt_att *att,
> +					bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_gatt_discover_included_services(struct bt_att *att,
> +					uint16_t start, uint16_t end,
> +					bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_gatt_discover_characteristics(struct bt_att *att,
> +					uint16_t start, uint16_t end,
> +					bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_gatt_discover_descriptors(struct bt_att *att,
> +					uint16_t start, uint16_t end,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_gatt_read_value(struct bt_att *att, uint16_t value_handle,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_gatt_read_long_value(struct bt_att *att,
> +					uint16_t value_handle, uint16_t offset,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_gatt_write_without_response(struct bt_att *att,
> +					uint16_t value_handle,
> +                                        bool signed_write,
> +					uint8_t *value, uint16_t length)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_gatt_write_value(struct bt_att *att, uint16_t value_handle,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +bool bt_gatt_write_long_value(struct bt_att *att, bool reliable,
> +					uint16_t value_handle, uint16_t offset,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> +
> +unsigned int bt_gatt_register(struct bt_att *att, bool indications,
> +					bt_gatt_notify_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy)
> +{
> +	/* TODO */
> +	return false;
> +}
> diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
> new file mode 100644
> index 0000000..b711324
> --- /dev/null
> +++ b/src/shared/gatt-helpers.h
> @@ -0,0 +1,133 @@
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
> +/* This file defines helpers for performing client-side procedures defined by
> + * the Generic Attribute Profile.
> + */
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +struct bt_gatt_service {
> +	uint16_t start;
> +	uint16_t end;
> +	uint8_t uuid[16];
> +};
> +
> +struct bt_gatt_characteristic {
> +	uint16_t start;
> +	uint16_t end;
> +	uint16_t value;
> +	uint8_t properties;
> +	uint8_t uuid[16];
> +};
> +
> +struct bt_gatt_descriptor {
> +	uint16_t handle;
> +	uint8_t uuid[16];
> +};
> +
> +/* Operations can report two kinds of errors:
> + *
> + *  1. ATT protocol error codes
> + *  2. bluetoothd defined errors
> + *
> + * The callbacks below encode the operation status in a 16-bit unsigned integer,
> + * where 0-255 are allocated for ATT protocol errors.
> + *
> + *  - 0x0000: Success
> + *  - 0x0001: Invalid handle (ATT protocol error)
> + *  - 0x0100: Unknown failure (bluetoothd defined)

do we really need this? I am feeling a bit uneasy about these kind of error splits where we are overloading wire protocol errors with internal errors.

> + *
> + */
> +#define BT_GATT_ERROR_UNKNOWN		0x0100
> +#define BT_GATT_ERROR_INVALID_RSP	0x0101

Especially with the background of invalid response as listed here, I think the only real result is a disconnect anyway, so we might better introduce a disconnect reason with the disconnect callback. Just an idea.

> +
> +typedef void (*bt_gatt_destroy_func_t)(void *user_data);
> +
> +typedef void (*bt_gatt_result_callback_t)(uint16_t status, void *user_data);
> +typedef void (*bt_gatt_discovery_callback_t)(uint16_t status,
> +					struct queue *results, void *user_data);

Can we please avoid internal data structures exposed here. I would say this needs to provide its own GATT specific data structure for the result. Most likely an allocated array or pointer array with a dedicated free function.

> +typedef void (*bt_gatt_read_callback_t)(uint16_t status, const uint8_t *value,
> +					uint16_t length, void *user_data);
> +
> +typedef void (*bt_gatt_notify_callback_t)(uint16_t value_handle,
> +					const uint8_t *value, uint16_t length,
> +					void *user_data);
> +
> +bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy);
> +
> +bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy);
> +bool bt_gatt_discover_included_services(struct bt_att *att,
> +					uint16_t start, uint16_t end,
> +					bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy);
> +bool bt_gatt_discover_characteristics(struct bt_att *att,
> +					uint16_t start, uint16_t end,
> +					bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy);
> +bool bt_gatt_discover_descriptors(struct bt_att *att,
> +					uint16_t start, uint16_t end,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy);
> +
> +bool bt_gatt_read_value(struct bt_att *att, uint16_t value_handle,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy);
> +bool bt_gatt_read_long_value(struct bt_att *att,
> +					uint16_t value_handle, uint16_t offset,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy);

Does this need an explicit function? Wouldn't it make more sense to handle the long reads (and writes for that matter) internally.

> +
> +bool bt_gatt_write_without_response(struct bt_att *att, uint16_t value_handle,
> +					bool signed_write,
> +					uint8_t *value, uint16_t length);
> +bool bt_gatt_write_value(struct bt_att *att, uint16_t value_handle,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy);
> +bool bt_gatt_write_long_value(struct bt_att *att, bool reliable,
> +					uint16_t value_handle, uint16_t offset,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy);
> +
> +unsigned int bt_gatt_register(struct bt_att *att, bool indications,
> +					bt_gatt_notify_callback_t callback,
> +					void *user_data,
> +					bt_gatt_destroy_func_t destroy);

Regards

Marcel

