Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <75980FDA-BF07-4EC7-A978-B3D41BA39610@holtmann.org>
References: <1400272636-31555-1-git-send-email-armansito@chromium.org>
	<1400272636-31555-2-git-send-email-armansito@chromium.org>
	<75980FDA-BF07-4EC7-A978-B3D41BA39610@holtmann.org>
Date: Tue, 27 May 2014 23:20:05 -0700
Message-ID: <CAHrH25RYxG=qgaPc+j4zCwZ==0gpd9-zZqgPvfS9-OUu8tmAog@mail.gmail.com>
Subject: Re: [RFC BlueZ 1/1] src/shared/gatt: Introduce bt_gatt skeleton.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> +bool bt_gatt_discover_primary_services(struct bt_gatt *gatt, bt_uuid_t =
*uuid,
>> +                                     bt_gatt_discovery_callback_t callb=
ack,
>> +                                     void *user_data);
>> +
>> +bool bt_gatt_discover_included_services(struct bt_gatt *gatt,
>> +                                     struct bt_gatt_handle_range range,
>> +                                     bt_uuid_t *uuid,
>> +                                     bt_gatt_discovery_callback_t callb=
ack,
>> +                                     void *user_data);
>> +
>> +bool bt_gatt_discover_characteristics(struct bt_gatt *gatt,
>> +                                     struct bt_gatt_handle_range range,
>> +                                     bt_uuid_t *uuid,
>> +                                     bt_gatt_discovery_callback_t callb=
ack,
>> +                                     void *user_data);
>> +
>> +bool bt_gatt_discover_descriptors(struct bt_gatt *gatt,
>> +                                     struct bt_gatt_handle_range range,
>> +                                     bt_gatt_discovery_callback_t callb=
ack,
>> +                                     void *user_data);
>
> Should we really expose these low-level operations? Why not just have one=
 bt_gatt_discover() that does all the magic for us. At the end of the day, =
that is what most devices do when they connect to a remote device. They wil=
l update the services they either know or have to discover new ones.

I think we should have them. I pretty much see bt_gatt as an interface
that translates GATT feature procedures to the underlying ATT protocol
operations. I leave the magic to be the responsibility of the of the
upper-layer, where we will have a client implementation that brings
together src/shared/gatt and src/shared/gatt-db. I'm thinking
something along the lines of a btd_gatt_client for bluetoothd, that
discovers everything, caches all attributes, and makes them accessible
to all the profiles/plugins (this is actually what I'm doing initially
on Chrome OS using GAttrib, since we're against a deadline for
Chrome). Eventually we could use this to remove the attio callbacks.

So, to answer your question, I think having these functions at this
level will be useful, especially for testing when we start writing PTS
style tests for GATT.

As for your other comments, I will make names shorter. I'm used to
writing long and very explicit function names, but I figured I would
upload them and see if someone yells at me :P

Cheers,
Arman
