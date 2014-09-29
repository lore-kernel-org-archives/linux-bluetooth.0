Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1411724807-4842-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411724807-4842-1-git-send-email-jakub.tyszkowski@tieto.com>
Date: Mon, 29 Sep 2014 12:48:31 -0700
Message-ID: <CAHrH25TONDoORUAsNizLUJvMUg0FXC4XKvyC9SvQvYg-GQA-YA@mail.gmail.com>
Subject: Re: [RFC 0/2] shared/gatt-client: ATT invalidation handler interface
From: Arman Uguray <armansito@chromium.org>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,


> Even though the following patches propose the solution for this TODO entry if I
> understood it correctly, I'm not sure if it is really needed to have this
> in shared/gatt-client, as this would only be wrapping the shared/att code.
> As shared/gatt-client is not directly handling the connection, nor is
> initialising the shared/att, its up to user, which does that
> (tools/btgatt-client for now) to handle this events, as it is using the
> shared/att API directly anyway. And btw. 'bt_att_register_disconnect()' was
> designed to be 'user ready/user friendly' as it can handle multiple
> users/callbacks. If we realy need this multiple user notifications we could
> extend the 'bt_att_set_timeout_cb()' to work in similar way.
>
> Is there a good reason to have this functionality on shared/gatt-client level?
> If we really want this, then what about the gatt-server? We duplicate the
> wrapping we have in gatt-client?

I guess you're right in that it might be unnecessary to add an extra
layer of abstraction for something that is already pretty simple to
use. So let's not add a callback mechanism into shared/gatt-client.

That being said, shared/gatt-client still needs to properly handle
disconnections. So, at least internally, gatt-client should probably
clear its service cache and make sure that all registered notify
handlers have been unregistered. This is assuming that the same
instance of gatt-client will be used across multiple connections. I
guess we should discuss whether we expect users to create a new
gatt-client for each connection or whether to extend gatt-client to
allow a new bt_att structure to be assigned to it.

As for timeouts, bt_att automatically destroys the underlying io,
which should close the connection. So it maybe enough for the
upper-layer to just call bt_att_register_disconnect.

Cheers,
Arman
