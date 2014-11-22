Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: RFC: Populating shared/gatt-client from storage.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25Q2w48UX5Bi2qLq0uHfGsH+k2AzecXgfrn=QgZKoT1K4A@mail.gmail.com>
Date: Sat, 22 Nov 2014 10:26:16 +0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <E774ECE7-226D-427D-8FFB-CB3BF8C41428@holtmann.org>
References: <CAHrH25Q2w48UX5Bi2qLq0uHfGsH+k2AzecXgfrn=QgZKoT1K4A@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> In the case where bluez is bonded with a remote device we don't want
> to always perform service discovery, but instead to cache the
> attribute data permanently and just use that on reconnections.
> Currently shared/gatt-client automatically discovers all services when
> created (via bt_gatt_client_new) so we need to add support to populate
> a shared/gatt-client based on cached data in storage, since a
> bt_gatt_client instance acts as our in-memory attribute cache for the
> client role.
> 
> I initially thought about storing everything in INI format and loading
> things directly from a file, via some function like
> bt_gatt_client_new_from_storage. The biggest problem with this
> approach is parsing the INI format; since we don't want to pull in any
> external dependencies into shared/gatt (e.g. glib) we would possibly
> have to write our own key-value file parser for shared/ which seems
> like overkill. We could possibly invent some simpler blob format for
> shared/gatt-client but people brought to my attention on IRC that we
> may want to leave the exact storage format to the upper-layer, e.g.
> desktop and android versions of bluetoothd may want to use different
> formats for their attribute cache that's consistent with the platform.

what we could do is just store the plain binary data. These are cache files and if you remove them, that just means next time we have to do full service discovery again.

> So I decided to go with something generic instead. We would basically
> add functions to manually populate a gatt-client and mark the client
> as ready only after it's services have been populated. So we would
> have these API changes:
> 
> 1. A new argument to bt_gatt_client_new, to tell it not to perform
> discovery. Something like "bool discover_services".
> 
>    /* Don't perform discovery */
>    bt_gatt_client_new(att, mtu, false);
> 
> This would basically just leave the structure in "init" state and not
> become ready.

Adding tons of parameters to a _new() is not really a good idea. I would always add a special _new_without_discovery() or something similar to our API. If we decide to go this route.

> 
> 2. We would then add a new structure to populate a gatt-client.
> 
>    struct bt_gatt_populate { .. };  /* Probably something with a better name */
> 
>    bool bt_gatt_populate_start(struct bt_gatt_populate *, struct
> bt_gatt_client *);
>    bool bt_gatt_populate_add_service(....)
>    bool bt_gatt_populate_add_characteristic(...)
>    bool bt_gatt_populate_add_descriptor(....)
>    bool bt_gatt_populate_add_include(....)
>    bool bt_gatt_populate_cancel(...)
>    bool bt_gatt_populate_commit(struct bt_gatt_populate *);
> 
> The start function would tell gatt-client that it's being populated so
> it would prevent this from being called twice. All of the _add_*
> functions would create a temporary tree owned by the populate
> structure, using the same internal structures defined in
> shared/gatt-client.c. Calling bt_gatt_populate_commit would then pass
> the ownership of the services to the bt_gatt_client, and
> bt_gatt_client would perform the MTU exchange, subscribe to
> notifications from the "Service Changed" characteristic if one exists,
> mark itself as ready and invoke the ready handler.
> 
> If the upper-layer wants to store the current contents of gatt-client,
> they can do so by iterating through its services and caching them to a
> file directly. This way, shared/gatt-client would remain agnostic to
> any storage format.

One other way of doing something like this is doing it this way:

	struct bt_gatt_storage;

	struct bt_gatt_storage *bt_gatt_storage_new()
	bt_gatt_storage_add_x

	struct bt_gatt_client *bt_gatt_client_from_storage(struct bt_gatt_storage);

I am not sure this is actually any better. It is just an idea, but we might want to just store plain binary data of cached services in a binary cached file. I think that we can have a binary storage format for the cached data and then we just point the bt_gatt_client_new_with_cahce() to that file and let it load if present. So the upper layers would just decide where that file is located.

Regards

Marcel

