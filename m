Return-Path: <cyrus@holtmann.org>
Message-ID: <542A9244.3000207@tieto.com>
Date: Tue, 30 Sep 2014 13:21:40 +0200
From: Tyszkowski Jakub <jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
To: Arman Uguray <armansito@chromium.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 0/2] shared/gatt-client: ATT invalidation handler interface
References: <1411724807-4842-1-git-send-email-jakub.tyszkowski@tieto.com> <CAHrH25TONDoORUAsNizLUJvMUg0FXC4XKvyC9SvQvYg-GQA-YA@mail.gmail.com>
In-Reply-To: <CAHrH25TONDoORUAsNizLUJvMUg0FXC4XKvyC9SvQvYg-GQA-YA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On 09/29/2014 09:48 PM, Arman Uguray wrote:
> Hi Jakub,
>
>
>> Even though the following patches propose the solution for this TODO entry if I
>> understood it correctly, I'm not sure if it is really needed to have this
>> in shared/gatt-client, as this would only be wrapping the shared/att code.
>> As shared/gatt-client is not directly handling the connection, nor is
>> initialising the shared/att, its up to user, which does that
>> (tools/btgatt-client for now) to handle this events, as it is using the
>> shared/att API directly anyway. And btw. 'bt_att_register_disconnect()' was
>> designed to be 'user ready/user friendly' as it can handle multiple
>> users/callbacks. If we realy need this multiple user notifications we could
>> extend the 'bt_att_set_timeout_cb()' to work in similar way.
>>
>> Is there a good reason to have this functionality on shared/gatt-client level?
>> If we really want this, then what about the gatt-server? We duplicate the
>> wrapping we have in gatt-client?
>
> I guess you're right in that it might be unnecessary to add an extra
> layer of abstraction for something that is already pretty simple to
> use. So let's not add a callback mechanism into shared/gatt-client.

It really depends on how gatt-client should be used by multiple users.

I thought about some 'master entity' like bluetooth profile owning the 
link and creating bt_att and gatt_client/gatt_server instances, while 
exposing function to get their references for the given bdaddr. 
Something like:

	bt_gatt_connection_state_cb_t gatt_connection_state_cb
			(gatt_connection_state_t, void *user_data) {}
	bt_connect_gatt(&bdaddr, role, gatt_connection_state_cb);

Where gatt_client reference is passed as user_data argument for the 
gatt_connection_state_cb when connecting and NULL is passed on 
disconnection. This makes tracking gatt_client's life cycle quite 
simple, as gatt-client is created on the firs connect call and other 
users calling connect just receives the reference in callback when it's 
already connected.

With such solution the 'master entity' deals with bt_att callback API 
and calls the registered gatt_connection_state_cb so no need to expose 
callback mechanism on gatt-client level. As we don't want to expose 
bt_att API to users, bt_att callback mechanism would be wrapped anyway, 
but on a different level.

Probably we could also make 'master entity' have just something like:

	gatt_client *bt_get_gatt_client(bdaddr);

and let the users do the connect_cb registration using gatt-client API 
but I'm not sure if this is a better solution.

Just thinking out loud. :)

>
> That being said, shared/gatt-client still needs to properly handle
> disconnections. So, at least internally, gatt-client should probably
> clear its service cache and make sure that all registered notify
> handlers have been unregistered. This is assuming that the same
> instance of gatt-client will be used across multiple connections. I
> guess we should discuss whether we expect users to create a new
> gatt-client for each connection or whether to extend gatt-client to
> allow a new bt_att structure to be assigned to it.

This would be irrelevant with the first solution proposed above, as 
users would not care about it as they are getting the reference on each 
connection. I think we should go with the simplest solution.

Should we think here also about the caching?

>
> As for timeouts, bt_att automatically destroys the underlying io,
> which should close the connection. So it maybe enough for the
> upper-layer to just call bt_att_register_disconnect.

Right. We don't care about the disconnect reason anyway.

>
> Cheers,
> Arman
>

Regards,
Jakub
