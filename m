Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1396518234-8375-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396518234-8375-1-git-send-email-marcin.kraglak@tieto.com>
Date: Thu, 3 Apr 2014 09:34:38 -0400
Message-ID: <CAJdJm_P+OjFYyggY4g_TTZJ7V1H7a46k45KntCZxnTwFRCE4ZA@mail.gmail.com>
Subject: Re: [RFC] gatt: Add API for creating services
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Thu, Apr 3, 2014 at 5:43 AM, Marcin Kraglak <marcin.kraglak@tieto.com> wrote:
> It will allow to construct services, which can be later started
> stopped and removed. Function for creating services will reserve
> handles for service's attributes. Start service will put service
> and attributes to local database. Stop method will remove it,
> Remove method will completely remove service and free handles.
> ---
>  src/gatt.c | 38 ++++++++++++++++++++++++++++++++++
>  src/gatt.h | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
>
> diff --git a/src/gatt.c b/src/gatt.c
> index bfd083a..7260ffa 100644
> --- a/src/gatt.c
> +++ b/src/gatt.c
> @@ -27,6 +27,7 @@
>
>  #include <glib.h>
>
> +#include <stdbool.h>
>  #include "log.h"
>  #include "lib/uuid.h"
>  #include "attrib/att.h"
> @@ -263,6 +264,43 @@ uint16_t btd_gatt_add_char_desc(const bt_uuid_t *uuid,
>         return attr->handle;
>  }
>
> +uint16_t btd_gatt_create_service(const bt_uuid_t *uuid, uint16_t num_handles)
> +{
> +       return 0;
> +}

Looking at android/hardware/bt_gatt_server.h and your proposed GATT
server HAL IPC in android/hal-msg.h, I now wonder whether is it worth
the trouble attempting to use the API from src/gatt.c for Android. It
seems to me that for Android, BlueZ needs only to manage the attribute
database for the GATT server. Compare that to BlueZ on Linux, where
you have to handle ATT packet encoding/decoding, D-Bus API, internal
plugins. Attempting to add the btd_attribute abstraction on Android
will just add unnecessary complexity IMHO.

So here is my *personal* proposal: you create an attribute database
management API in src/shared (e.g. src/shared/gatt-db.c), which could
be shared by src/gatt.c and Android's android/gatt.c. This API would
reference attributes and attribute groups (i.e. services and
characteristics) by handle.

This API needs functions for:

- adding/removing attributes. I was thinking on something like:

/* define att_db_read_t , att_read_result_t , att_db_write_t and
att_db_write_result_t see src/gatt.h for similar callbacks */

/* Append an attribute to an existing handle group. If 0x0000 is
given, initiate a new group at the end of the database. Return the
handle for the new attribute, or zero if there is no room for the new
attribute on the current group location */
uint16_t att_db_add(uint16_t handle_group, const bt_uuid_t *uuid,
const uint8_t *value, size_t len);
/* Add a dynamic attribute: instead of a static value, read/write
callbacks are used. Needed for attributes that read value from a
dynamic source */
uint16_t att_db_add_dynamic(uint16_t handle_group, const bt_uuid_t
*uuid, att_db_read_t read_cb, att_db_write_t write_cb);
/* If a handle for an attribute group is given, remove the whole
group. Otherwise, remove the single attribute. Return the handle for
the last removed attribute in the group, or 0x0000 on error. */
uint16_t att_db_remove(uint16_t handle);
/* Resize given handle group, relocating to a new position in the
database if necessary. Return the new location for the group, or
0x0000 if the group could not be resized. */
uint16_t att_db_resize_group(uint16_t handle_group);

So how to detect attribute groups? The GATT specification (2.5.3
Attribute Grouping) and ATT spec (3.2.3 Attribute Handle Grouping)
briefly describe what are the valid groups. Note that the
"Characteristic" group is only valid inside a "Primary Service" or
"Secondary Service" group, so this is important if
att_db_resize_group() is to be used on a characteristic, it can only
be relocated inside its parent service.

- Functions for operating on attributes. While Android seems to need
only read/writing attributes based on handle, for BlueZ on Linux we
need all those operations available on the ATT specification (read by
group, read by type etc.). We could simply implement those operations
as database functions. At minimum:

/* Read/write to attribute with given handle */
void att_db_read(uint16_t handle, att_db_read_result_t result_cb, void
*user_data);
void att_db_write(uint16_t handle, att_db_write_result_t result_cb,
const uint8_t *value, size_t len, void *user_data);

- implement proper database "defragmentation". One idea is to always
append new services to the end, and once there are no available
handles, find free "holes" to reuse.
- Implement support for both 16-bit and 128-bit UUIDs. This is *very*
important for custom profiles. This means grouping 16-bit UUIDs
services separately from 128-bit UUIDs on the database. See the Core
spec for details. One idea is to keep 16-bit UUIDs at the lowest
handles (0x0001 , 0x0002 etc.) and 128-bit UUIDs at highest handles
(... 0xfffd, 0xfffe, 0xffff). src/attrib-server.c currently implements
an algorithm where 128-bit UUID services are added "backwards" so they
always get highest possible handles.
- attribute permissions: I not sure how Android handles permissions.
For Linux, we can handle permissions on top of the database API.
- service changed: I don't know how Android handles this, but for
bonded devices, you need to report service changed indication on
reconnection, giving a range that contains all services which have
been added/removed/modified. Maybe this can be left out of the initial
API.

A few things I could not figure out from Android API:

- Descriptors are added to services? I hope it is just a typo. From
android/hardware/bt_gatt_server.h:

    /** Add a descriptor to a given service */
    bt_status_t (*add_descriptor)(int server_if, int service_handle,
                                  bt_uuid_t *uuid, int permissions);

- How attribute permissions are handled?


Any thoughts?


Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil
