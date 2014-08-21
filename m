Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKkMiOErfLsApUYprYaBO4TywDAvpFS7XTe9cDcMnUASQ@mail.gmail.com>
References: <1408565737-8187-1-git-send-email-armansito@chromium.org>
	<1408565737-8187-4-git-send-email-armansito@chromium.org>
	<CABBYNZKkMiOErfLsApUYprYaBO4TywDAvpFS7XTe9cDcMnUASQ@mail.gmail.com>
Date: Thu, 21 Aug 2014 09:42:42 -0700
Message-ID: <CAHrH25TBKpkoJ3EGwEOYK6YDoxeTpoDz=3Q86Ft=jA64ptS0dw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 03/11] shared/gatt-client: Added initial skeleton
 and simple functions.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Luiz,

I'm fine with merging some of the gatt-helpers with gatt-client later;
so that gatt-helpers would only be used internally for discovery and
all the read/write functions can accept a bt_gatt_client instead of a
bt_att directly. And, the bt_gatt_client_get_att function could go
away.

I'm building this one step at a time and wanted to get the general
GATT procedures out of the way first; hence I sent out gatt-helpers
before gatt-client.

Let me know if that makes sense.

On Thu, Aug 21, 2014 at 6:23 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Wed, Aug 20, 2014 at 11:15 PM, Arman Uguray <armansito@chromium.org> wrote:
>> This patch introduces shared/gatt-client, which provides a central/client side
>> implementation of the Generic Attribute Profile. An instance of bt_gatt_client
>> will provide a central database of all GATT services, characteristics, and
>> descriptors that have been discovered on a peripheral and will provide API
>> functions to obtain information about discovered attributes, registering
>> handlers for "Service Changed" indications, as well as providing
>> reference-counted access to "Client Characteristic Configuration" descriptors.
>> ---
>>  Makefile.am              |   3 +-
>>  src/shared/TODO          |  13 ++++++
>>  src/shared/gatt-client.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++
>>  src/shared/gatt-client.h |  54 +++++++++++++++++++++++++
>>  4 files changed, 170 insertions(+), 1 deletion(-)
>>  create mode 100644 src/shared/TODO
>>  create mode 100644 src/shared/gatt-client.c
>>  create mode 100644 src/shared/gatt-client.h
>>
>> diff --git a/Makefile.am b/Makefile.am
>> index 88fcb49..6aed8e2 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -158,7 +158,8 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
>>                         src/shared/util.h src/shared/util.c \
>>                         src/shared/mgmt.h src/shared/mgmt.c \
>>                         src/shared/att-types.h src/shared/att.h src/shared/att.c \
>> -                       src/shared/gatt-helpers.h src/shared/gatt-helpers.c
>> +                       src/shared/gatt-helpers.h src/shared/gatt-helpers.c \
>> +                       src/shared/gatt-client.h src/shared/gatt-client.c
>>  src_bluetoothd_LDADD = lib/libbluetooth-internal.la gdbus/libgdbus-internal.la \
>>                         @GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
>>  src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
>> diff --git a/src/shared/TODO b/src/shared/TODO
>> new file mode 100644
>> index 0000000..2881c97
>> --- /dev/null
>> +++ b/src/shared/TODO
>> @@ -0,0 +1,13 @@
>> +TODOs for shared/gatt-client
>> +
>> +* Add util_debug support.
>> +* Add high-level abstraction for services, characteristics, and descriptors.
>> +* Implement service discovery.
>> +* Implement characteristic discovery.
>> +* Implement descriptor discovery.
>> +* Handle request timeouts.
>> +* Make bt_gatt_client observe disconnect events. Handle bonded/non-bonded cases.
>> +* Add support for auto-connects using a different bt_att.
>> +* Add functions for reference counted access to enable/disable
>> +  notifications/indications.
>> +* Add support for "Service Changed".
>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>> new file mode 100644
>> index 0000000..53a7de1
>> --- /dev/null
>> +++ b/src/shared/gatt-client.c
>> @@ -0,0 +1,101 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2014  Google Inc.
>> + *
>> + *
>> + *  This library is free software; you can redistribute it and/or
>> + *  modify it under the terms of the GNU Lesser General Public
>> + *  License as published by the Free Software Foundation; either
>> + *  version 2.1 of the License, or (at your option) any later version.
>> + *
>> + *  This library is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  Lesser General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU Lesser General Public
>> + *  License along with this library; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + *
>> + */
>> +
>> +#include "src/shared/att.h"
>> +#include "src/shared/gatt-client.h"
>> +#include "src/shared/util.h"
>> +
>> +struct bt_gatt_client {
>> +       struct bt_att *att;
>> +       bool persist;
>> +};
>> +
>> +struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att)
>> +{
>> +       struct bt_gatt_client *client;
>> +
>> +       if (!att)
>> +               return NULL;
>> +
>> +       client = new0(struct bt_gatt_client, 1);
>> +       if (!client)
>> +               return NULL;
>> +
>> +       client->att = bt_att_ref(att);
>> +
>> +       return client;
>> +}
>> +
>> +void bt_gatt_client_destroy(struct bt_gatt_client *client)
>> +{
>> +       if (!client)
>> +               return;
>> +
>> +       bt_att_unref(client->att);
>> +       free(client);
>> +}
>> +
>> +bool bt_gatt_client_set_persist(struct bt_gatt_client *client,
>> +                                                       bool do_persist)
>> +{
>> +       if (!client)
>> +               return false;
>> +
>> +       client->persist = do_persist;
>> +
>> +       return true;
>> +}
>> +
>> +struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client)
>> +{
>> +       if (!client)
>> +               return NULL;
>> +
>> +       return client->att;
>> +}
>> +
>> +bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
>> +                                       bt_gatt_client_callback_t callback,
>> +                                       void *user_data,
>> +                                       bt_gatt_client_destroy_func_t destroy)
>> +{
>> +       // TODO
>> +}
>> +
>> +unsigned int bt_gatt_client_register_service_changed(
>> +                               struct bt_gatt_client *client,
>> +                               uint16_t handle,
>> +                               bt_gatt_client_service_changed_func_t callback,
>> +                               void *user_data,
>> +                               bt_gatt_client_destroy_func_t destroy)
>> +{
>> +       // TODO
>> +       return 0;
>> +}
>> +
>> +bool bt_gatt_client_unregister_service_changed(struct bt_gatt_client *client,
>> +                                                       unsigned int id)
>> +{
>> +       // TODO
>> +       return false;
>> +}
>> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
>> new file mode 100644
>> index 0000000..a978691
>> --- /dev/null
>> +++ b/src/shared/gatt-client.h
>> @@ -0,0 +1,54 @@
>> +/*
>> + *
>> + *  BlueZ - Bluetooth protocol stack for Linux
>> + *
>> + *  Copyright (C) 2014  Google Inc.
>> + *
>> + *
>> + *  This library is free software; you can redistribute it and/or
>> + *  modify it under the terms of the GNU Lesser General Public
>> + *  License as published by the Free Software Foundation; either
>> + *  version 2.1 of the License, or (at your option) any later version.
>> + *
>> + *  This library is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + *  Lesser General Public License for more details.
>> + *
>> + *  You should have received a copy of the GNU Lesser General Public
>> + *  License along with this library; if not, write to the Free Software
>> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> + *
>> + */
>> +
>> +#include <stdbool.h>
>> +#include <stdint.h>
>> +
>> +struct bt_gatt_client;
>> +
>> +struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att);
>> +void bt_gatt_client_destroy(struct bt_gatt_client *client);
>> +
>> +bool bt_gatt_client_set_persist(struct bt_gatt_client *client,
>> +                                                       bool do_persist);
>> +
>> +struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client);
>> +
>> +typedef void (*bt_gatt_client_destroy_func_t)(void *user_data);
>> +typedef void (*bt_gatt_client_callback_t)(void *user_data);
>> +typedef void (*bt_gatt_client_service_changed_func_t)(uint16_t handle,
>> +                                                       void *user_data);
>> +
>> +bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
>> +                                       bt_gatt_client_callback_t callback,
>> +                                       void *user_data,
>> +                                       bt_gatt_client_destroy_func_t destroy);
>> +
>> +unsigned int bt_gatt_client_register_service_changed(
>> +                               struct bt_gatt_client *client,
>> +                               uint16_t handle,
>> +                               bt_gatt_client_service_changed_func_t callback,
>> +                               void *user_data,
>> +                               bt_gatt_client_destroy_func_t destroy);
>> +bool bt_gatt_client_unregister_service_changed(struct bt_gatt_client *client,
>> +                                                       unsigned int id);
>> --
>> 2.1.0.rc2.206.gedb03e5
>
> Perhaps I lost track during my holidays but I was expecting a very
> different API, one that does not expose bt_att instance to begin with,
> it seems like the user will need to managed both bt_att instance and
> bt_gatt_client instance at same time? It does seems more logical to me
> that gatt-helper and gatt-client should be part of the same API using
> the same instance (e.g. bt_gatt), with this type of design you can do
> a proper queuing if one is necessary like for example detect if an
> operation is already ongoing and just attach the callback and user
> data to the existing operation instead of queuing another command in
> bt_att.
>
>
> --
> Luiz Augusto von Dentz
