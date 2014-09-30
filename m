Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <542A9244.3000207@tieto.com>
References: <1411724807-4842-1-git-send-email-jakub.tyszkowski@tieto.com>
	<CAHrH25TONDoORUAsNizLUJvMUg0FXC4XKvyC9SvQvYg-GQA-YA@mail.gmail.com>
	<542A9244.3000207@tieto.com>
Date: Tue, 30 Sep 2014 09:53:58 -0700
Message-ID: <CAHrH25Q=o1eyNEBcVQtk+UA8z+nhECNWM6VODKiqhGr=bmRGPg@mail.gmail.com>
Subject: Re: [RFC 0/2] shared/gatt-client: ATT invalidation handler interface
From: Arman Uguray <armansito@chromium.org>
To: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,


> It really depends on how gatt-client should be used by multiple users.
>
> I thought about some 'master entity' like bluetooth profile owning the link
> and creating bt_att and gatt_client/gatt_server instances, while exposing
> function to get their references for the given bdaddr. Something like:
>
>         bt_gatt_connection_state_cb_t gatt_connection_state_cb
>                         (gatt_connection_state_t, void *user_data) {}
>         bt_connect_gatt(&bdaddr, role, gatt_connection_state_cb);
>
> Where gatt_client reference is passed as user_data argument for the
> gatt_connection_state_cb when connecting and NULL is passed on
> disconnection. This makes tracking gatt_client's life cycle quite simple, as
> gatt-client is created on the firs connect call and other users calling
> connect just receives the reference in callback when it's already connected.
>
> With such solution the 'master entity' deals with bt_att callback API and
> calls the registered gatt_connection_state_cb so no need to expose callback
> mechanism on gatt-client level. As we don't want to expose bt_att API to
> users, bt_att callback mechanism would be wrapped anyway, but on a different
> level.
>
> Probably we could also make 'master entity' have just something like:
>
>         gatt_client *bt_get_gatt_client(bdaddr);
>
> and let the users do the connect_cb registration using gatt-client API but
> I'm not sure if this is a better solution.
>
> Just thinking out loud. :)

Yeah, this overall makes sense, since in both the desktop and android
implementations, somebody will need to put together the different
pieces from shared. In bluetoothd, src/device.c will probably own
these, via something like:

int fd = socket(...).
connect(fd);

att = bt_att_new(att);
bt_att_set_close_on_unref(att);
bt_att_register_disconnect(att, disconnect_cb);

client = bt_gatt_client_new(att, mtu);

This would be internal to bluetoothd. Currently the D-Bus API for the
desktop daemon doesn't have a "per-application GATT connect"
interface. It just has a generic UI connect. So this is something that
will need to change and your proposal makes sense I think.

Now when the link gets disconnected (either via bt_att_unref(att) or
it's terminated unexpectedly), the bt_att instance becomes no longer
valid and a new bt_att needs to be created. At this point we need to
decide what happens to the bt_gatt_client. Obviously none of the
discovery/read/write operations will work since the bt_att is invalid
and the attribute cache stored in bt_gatt_client is also technically
invalid unless we are bonded. So maybe, as you said, we simply
invalidate the existing bt_gatt_client (mark it as invalid
internally), and expect users to obtain a new instance by requesting
to connect.


> This would be irrelevant with the first solution proposed above, as users
> would not care about it as they are getting the reference on each
> connection. I think we should go with the simplest solution.
>
> Should we think here also about the caching?
>

Yeah, so it seems like we're limiting the lifetime/validity of a
bt_gatt_client object to the lifetime of the physical link itself.
Hence the cache is valid as long the connection is up and a new
connection would warrant service discovery from scratch. A feature
that we can add later is long-term caching in the bonding case. We
would basically persist the attribute cache in a file and next time
there is a new connection we would instantiate a bt_gatt_client from
the file:

client = bt_gatt_client_create_from_storage(att, mtu, keyfile);

Though this is something we can worry about later. For now, let's have
bt_gatt_client register a disconnect handler and mark itself as
invalid. I guess we can keep the service cache alive there but the
gatt_client would be unusable at this point and creating a new one
would be necessary for the next connection.

I hope this makes sense :)

Cheers,
Arman
