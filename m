Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <41D7DE0B-C63B-4AD5-9C53-B323E787219A@holtmann.org>
References: <1408565737-8187-1-git-send-email-armansito@chromium.org>
	<1408565737-8187-4-git-send-email-armansito@chromium.org>
	<41D7DE0B-C63B-4AD5-9C53-B323E787219A@holtmann.org>
Date: Thu, 21 Aug 2014 12:26:21 -0700
Message-ID: <CAHrH25QxTU7i+hq0Sd6htboQkA5Y8WGtkT7w7HSHCdmvOJYwtQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 03/11] shared/gatt-client: Added initial skeleton
 and simple functions.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


> great idea with the TODO. However please just use top-level TODO and patches modifying the TODO should be all by itself.
>

The top-level TODO has an ATT/GATT section though I don't know how
up-to-date that is. For now, I can create a separate shared/gatt
section for the work that I'm doing.


>> +struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client);
>
> I really hope that we do not need this. Lets try really hard to avoid it.
>

I'll go ahead and remove this.


>> +bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
>> +                                     bt_gatt_client_callback_t callback,
>> +                                     void *user_data,
>> +                                     bt_gatt_client_destroy_func_t destroy);
>
> Do not bother with it like this. Let do it like this:
>
>         client = bt_gatt_client_new(att);
>
>         bt_gatt_client_set_mtu(client, mtu);
>         bt_gatt_client_set_ready_handler(client, callback, my_data, my_destroy);
>
> Since we are not multi-threaded this will be safe and a lot cleaner to read.
>

We can have a single ready handler but I kind of like a general
initialize function that first does the MTU exchange and then
discovers all the attributes (this is what bt_gatt_client_init does
though it's not really clear from the name that it also performs
discovery, so I can change that).


>> +
>> +unsigned int bt_gatt_client_register_service_changed(
>> +                             struct bt_gatt_client *client,
>> +                             uint16_t handle,
>> +                             bt_gatt_client_service_changed_func_t callback,
>> +                             void *user_data,
>> +                             bt_gatt_client_destroy_func_t destroy);
>> +bool bt_gatt_client_unregister_service_changed(struct bt_gatt_client *client,
>> +                                                     unsigned int id);
>
> Are we expecting more than one here. If not, then better use bt_gatt_client_set_changed_handler.
>

My idea here was that each profile/plugin can register its own handler
for the handles that they are interested in and get notified of a
changed service. We could also have a single service changed handler
here and the daemon code can then use that to go and probe each
plugin/profile based on that.


> Actually it make make sense to set ready handler and services changed handler with the same call. Try it out.
>

Having separate functions would be a bit cleaner I think. I'll send a
revised patch and we can discuss it there.

-Arman
