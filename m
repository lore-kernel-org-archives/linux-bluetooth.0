Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC BlueZ 1/1] src/shared/gatt: Introduce bt_gatt skeleton.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400272636-31555-2-git-send-email-armansito@chromium.org>
Date: Sat, 24 May 2014 23:01:58 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <75980FDA-BF07-4EC7-A978-B3D41BA39610@holtmann.org>
References: <1400272636-31555-1-git-send-email-armansito@chromium.org> <1400272636-31555-2-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch introduces src/shared/gatt, which provides an interface for
> GATT client operations. bt_gatt will internally use src/shared/att for
> ATT protocol client-side operations. bt_gatt is meant to be used
> together with src/shared/gatt-db to implement a complete GATT client.
> ---
> Makefile.am       |   3 +-
> src/shared/gatt.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> src/shared/gatt.h | 189 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 383 insertions(+), 1 deletion(-)
> create mode 100644 src/shared/gatt.c
> create mode 100644 src/shared/gatt.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index 04be6c4..8b731f0 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -156,7 +156,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
> 			src/shared/queue.h src/shared/queue.c \
> 			src/shared/util.h src/shared/util.c \
> 			src/shared/mgmt.h src/shared/mgmt.c \
> -			src/shared/att.h src/shared/att.c
> +			src/shared/att.h src/shared/att.c \
> +			src/shared/gatt.h src/shared/gatt.c
> src_bluetoothd_LDADD = lib/libbluetooth-internal.la gdbus/libgdbus-internal.la \
> 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
> src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
> diff --git a/src/shared/gatt.c b/src/shared/gatt.c
> new file mode 100644
> index 0000000..2e701dc
> --- /dev/null
> +++ b/src/shared/gatt.c
> @@ -0,0 +1,192 @@
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
> +#include "lib/uuid.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/gatt.h"
> +#include "src/shared/att.h"
> +
> +struct bt_gatt {
> +	struct bt_att *att;
> +};
> +
> +struct bt_gatt *bt_gatt_new(int fd)
> +{
> +	/* TODO: Implement. */
> +	return NULL;
> +}
> +
> +void bt_gatt_destroy(struct bt_gatt *gatt)
> +{
> +	/* TODO: Implement. */
> +}
> +
> +
> +unsigned int bt_gatt_register(struct bt_gatt *gatt, uint16_t value_handle,
> +					bt_gatt_event_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return 0;
> +}
> +
> +bool bt_gatt_unregister(unsigned int id)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_exchange_mtu(struct bt_gatt *gatt, uint16_t mtu,
> +				bt_gatt_exchange_mtu_callback_t callback,
> +				void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +uint16_t get_mtu(struct bt_gatt *gatt)
> +{
> +	/* TODO: Implement. */
> +	return 0;
> +}
> +
> +bool bt_gatt_discover_primary_services(struct bt_gatt *gatt, bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_discover_included_services(struct bt_gatt *gatt,
> +					struct bt_gatt_handle_range range,
> +					bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_discover_characteristics(struct bt_gatt *gatt,
> +					struct bt_gatt_handle_range range,
> +					bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_discover_descriptors(struct bt_gatt *gatt,
> +					struct bt_gatt_handle_range range,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_read_characteristic_value(struct bt_gatt *gatt,
> +					uint16_t value_handle,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_read_long_characteristic_values(struct bt_gatt *gatt,
> +					uint16_t value_handle, uint16_t offset,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_write_without_response(struct bt_gatt *gatt,
> +					uint16_t value_handle,
> +					uint8_t *value, uint16_t length)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_write_characteristic_value(struct bt_gatt *gatt,
> +					uint16_t value_handle,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_write_long_characteristic_values(struct bt_gatt *gatt,
> +					uint16_t value_handle, uint16_t offset,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_read_characteristic_descriptors(struct bt_gatt *gatt,
> +					uint16_t value_handle,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_read_long_characteristic_descriptors(struct bt_gatt *gatt,
> +					uint16_t value_handle, uint16_t offset,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_write_characteristic_descriptors(struct bt_gatt *gatt,
> +					uint16_t value_handle,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> +
> +bool bt_gatt_write_long_characteristic_descriptors(struct bt_gatt *gatt,
> +					uint16_t value_handle, uint16_t offset,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data)
> +{
> +	/* TODO: Implement. */
> +	return false;
> +}
> diff --git a/src/shared/gatt.h b/src/shared/gatt.h
> new file mode 100644
> index 0000000..624bd87
> --- /dev/null
> +++ b/src/shared/gatt.h
> @@ -0,0 +1,189 @@
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
> +/*
> + * An instance of struct bt_gatt comprises a client-side implementation
> + * of the Generic Attribute Profile (GATT) with regards to a specific remote
> + * GATT server. Each instance is created with a file descriptor that represents
> + * the logical link to the server, which must be configured s.t. communication
> + * via the Attribute Protocol is possible (e.g. an L2CAP LE connection over the
> + * ATT channel). bt_gatt provides functions to perform GATT client
> + * operations, such as primary service discovery, characteristic reads and
> + * writes, etc which are performed over the given connection.
> + *
> + * Most GATT clients will implement some sort of attribute caching to reduce the
> + * number operations performed over-the-air. While an instance of bt_gatt does
> + * not maintain a cache of attributes, it provides the means to get notified
> + * when notifications/indications are received. This can be used to maintain and
> + * update a separate database following events such as indications from the
> + * Service Changed characteristic or based on updates to the underlying
> + * connection (e.g. a disconnect event).
> + */

I do not like to have these ones in the header. At least not at the top right after the copyright notice. Put them into the code or closer to the actual structs. In most cases I found to have these kind of detailed comments really useful close to the area of the code that uses it. Since that is where you normally end up tracing the bug to.

> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +
> +struct bt_gatt;
> +
> +struct bt_gatt_handle_range {
> +	uint16_t start;
> +	uint16_t end;
> +};

Should we just do start + end in the parameter list? What good is a struct doing here?

> +
> +struct bt_gatt_service {
> +	bt_uuid_t uuid;
> +	struct bt_gatt_handle_range handle_range;
> +};

The bt_gatt_handle_range gets pretty long here. Feels not right and might turn the code unreadable.

> +
> +struct bt_gatt_characteristic {
> +	uint8_t properties;
> +	uint16_t value_handle;
> +	bt_uuid_t uuid;
> +	struct bt_gatt_handle_range handle_range;
> +};
> +
> +struct bt_gatt_descriptor {
> +	uint16_t handle;
> +	bt_uuid_t uuid;
> +};

I am trying to get away from the bt_uuid_t. In my new SDP code I just have it has uint8_t uuid[16] and have the code internally convert from 16-bit / 32-bit to 128-bit on the fly. Meaning I always store the 128-bit version. And that is what we should do anyway. If we can shorten the UUID, we do that. Otherwise we just send the 128-bit version.

> +
> +typedef enum {
> +	BT_GATT_EVENT_TYPE_HANDLE_VALUE_NOTIFICATION,
> +	BT_GATT_EVENT_TYPE_HANDLE_VALUE_INDICATION,
> +} bt_gatt_event_type_t;

Long long names. Don’t really like that. I thin we need to be a bit more creative here.

> +
> +typedef void (*bt_gatt_confirmation_callback_t)(void);
> +
> +typedef void (*bt_gatt_event_callback_t)(bt_gatt_event_type_t event_type,
> +				uint16_t value_handle,
> +				uint8_t *value, uint16_t length,
> +				bt_gatt_confirmation_callback_t conf_callback,
> +				void *user_data);
> +
> +typedef void (*bt_gatt_exchange_mtu_callback_t)(uint16_t final_mtu,
> +							void *user_data);
> +
> +/*
> + * "status" is set to 0 if the operation was successful. Otherwise, it is set
> + * to the ATT protocol error code. See the error codes defined in
> + * src/shared/att.h.
> + */
> +typedef void (*bt_gatt_discovery_callback_t)(uint8_t status,
> +							struct queue *list,
> +							void *user_data);

Might want to call it results instead of list. Or call it services.

> +
> +typedef void (*bt_gatt_read_callback_t)(uint8_t status, uint8_t *value,
> +					uint16_t length, void *user_data);
> +
> +typedef void (*bt_gatt_result_callback_t)(uint8_t status, void *user_data);
> +
> +struct bt_gatt *bt_gatt_new(int fd);
> +void bt_gatt_destroy(struct bt_gatt *gatt);
> +
> +
> +/******* Notifications/Indications *******/

Please do not use these style of comments in the header files. They just get messy over time.

> +unsigned int bt_gatt_register(struct bt_gatt *gatt, uint16_t value_handle,
> +					bt_gatt_event_callback_t callback,
> +					void *user_data);
> +bool bt_gatt_unregister(unsigned int id);
> +
> +/******* Server Configuration *******/
> +bool bt_gatt_exchange_mtu(struct bt_gatt *gatt, uint16_t mtu,
> +				bt_gatt_exchange_mtu_callback_t callback,
> +				void *user_data);
> +
> +uint16_t get_mtu(struct bt_gatt *gatt);

This is wrong in the header. We need namespacing. Or a gatt-private.h header.

> +
> +/******* Primary Service/Relationship/Characteristic/Descriptor discovery *****/
> +bool bt_gatt_discover_primary_services(struct bt_gatt *gatt, bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data);
> +
> +bool bt_gatt_discover_included_services(struct bt_gatt *gatt,
> +					struct bt_gatt_handle_range range,
> +					bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data);
> +
> +bool bt_gatt_discover_characteristics(struct bt_gatt *gatt,
> +					struct bt_gatt_handle_range range,
> +					bt_uuid_t *uuid,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data);
> +
> +bool bt_gatt_discover_descriptors(struct bt_gatt *gatt,
> +					struct bt_gatt_handle_range range,
> +					bt_gatt_discovery_callback_t callback,
> +					void *user_data);

Should we really expose these low-level operations? Why not just have one bt_gatt_discover() that does all the magic for us. At the end of the day, that is what most devices do when they connect to a remote device. They will update the services they either know or have to discover new ones.

> +
> +/******* Characteristic Value Read *******/
> +bool bt_gatt_read_characteristic_value(struct bt_gatt *gatt,
> +					uint16_t value_handle,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data);
> +
> +bool bt_gatt_read_long_characteristic_values(struct bt_gatt *gatt,
> +					uint16_t value_handle, uint16_t offset,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data);

Function names get longer and longer. We need better names and more important shorter ones.

> +
> +/******* Characteristic Value Write *******/
> +bool bt_gatt_write_without_response(struct bt_gatt *gatt,
> +					uint16_t value_handle,
> +					uint8_t *value, uint16_t length);
> +
> +bool bt_gatt_write_characteristic_value(struct bt_gatt *gatt,
> +					uint16_t value_handle,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data);
> +
> +bool bt_gatt_write_long_characteristic_values(struct bt_gatt *gatt,
> +					uint16_t value_handle, uint16_t offset,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data);
> +
> +/******* Characteristic Descriptor Value Read *******/
> +bool bt_gatt_read_characteristic_descriptors(struct bt_gatt *gatt,
> +					uint16_t value_handle,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data);
> +
> +bool bt_gatt_read_long_characteristic_descriptors(struct bt_gatt *gatt,
> +					uint16_t value_handle, uint16_t offset,
> +					bt_gatt_read_callback_t callback,
> +					void *user_data);
> +
> +/******* Characteristic Descriptor Value Write *******/
> +bool bt_gatt_write_characteristic_descriptors(struct bt_gatt *gatt,
> +					uint16_t value_handle,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data);
> +
> +bool bt_gatt_write_long_characteristic_descriptors(struct bt_gatt *gatt,
> +					uint16_t value_handle, uint16_t offset,
> +					uint8_t *value, uint16_t length,
> +					bt_gatt_result_callback_t callback,
> +					void *user_data);

Regards

Marcel

