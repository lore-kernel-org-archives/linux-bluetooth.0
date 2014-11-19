Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 19 Nov 2014 13:48:32 -0800
Message-ID: <CAHrH25Q2w48UX5Bi2qLq0uHfGsH+k2AzecXgfrn=QgZKoT1K4A@mail.gmail.com>
Subject: RFC: Populating shared/gatt-client from storage.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

In the case where bluez is bonded with a remote device we don't want
to always perform service discovery, but instead to cache the
attribute data permanently and just use that on reconnections.
Currently shared/gatt-client automatically discovers all services when
created (via bt_gatt_client_new) so we need to add support to populate
a shared/gatt-client based on cached data in storage, since a
bt_gatt_client instance acts as our in-memory attribute cache for the
client role.

I initially thought about storing everything in INI format and loading
things directly from a file, via some function like
bt_gatt_client_new_from_storage. The biggest problem with this
approach is parsing the INI format; since we don't want to pull in any
external dependencies into shared/gatt (e.g. glib) we would possibly
have to write our own key-value file parser for shared/ which seems
like overkill. We could possibly invent some simpler blob format for
shared/gatt-client but people brought to my attention on IRC that we
may want to leave the exact storage format to the upper-layer, e.g.
desktop and android versions of bluetoothd may want to use different
formats for their attribute cache that's consistent with the platform.

So I decided to go with something generic instead. We would basically
add functions to manually populate a gatt-client and mark the client
as ready only after it's services have been populated. So we would
have these API changes:

1. A new argument to bt_gatt_client_new, to tell it not to perform
discovery. Something like "bool discover_services".

    /* Don't perform discovery */
    bt_gatt_client_new(att, mtu, false);

This would basically just leave the structure in "init" state and not
become ready.

2. We would then add a new structure to populate a gatt-client.

    struct bt_gatt_populate { .. };  /* Probably something with a better name */

    bool bt_gatt_populate_start(struct bt_gatt_populate *, struct
bt_gatt_client *);
    bool bt_gatt_populate_add_service(....)
    bool bt_gatt_populate_add_characteristic(...)
    bool bt_gatt_populate_add_descriptor(....)
    bool bt_gatt_populate_add_include(....)
    bool bt_gatt_populate_cancel(...)
    bool bt_gatt_populate_commit(struct bt_gatt_populate *);

The start function would tell gatt-client that it's being populated so
it would prevent this from being called twice. All of the _add_*
functions would create a temporary tree owned by the populate
structure, using the same internal structures defined in
shared/gatt-client.c. Calling bt_gatt_populate_commit would then pass
the ownership of the services to the bt_gatt_client, and
bt_gatt_client would perform the MTU exchange, subscribe to
notifications from the "Service Changed" characteristic if one exists,
mark itself as ready and invoke the ready handler.

If the upper-layer wants to store the current contents of gatt-client,
they can do so by iterating through its services and caching them to a
file directly. This way, shared/gatt-client would remain agnostic to
any storage format.

Comments requested.
Arman
