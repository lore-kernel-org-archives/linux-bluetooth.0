Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH BlueZ 03/11] shared/gatt-client: Added initial skeleton and simple functions.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25QxTU7i+hq0Sd6htboQkA5Y8WGtkT7w7HSHCdmvOJYwtQ@mail.gmail.com>
Date: Thu, 21 Aug 2014 15:22:58 -0500
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Message-Id: <BF6538CE-3F1E-4F73-8E9C-6BE256482E55@holtmann.org>
References: <1408565737-8187-1-git-send-email-armansito@chromium.org> <1408565737-8187-4-git-send-email-armansito@chromium.org> <41D7DE0B-C63B-4AD5-9C53-B323E787219A@holtmann.org> <CAHrH25QxTU7i+hq0Sd6htboQkA5Y8WGtkT7w7HSHCdmvOJYwtQ@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> great idea with the TODO. However please just use top-level TODO and patches modifying the TODO should be all by itself.
>> 
> 
> The top-level TODO has an ATT/GATT section though I don't know how
> up-to-date that is. For now, I can create a separate shared/gatt
> section for the work that I'm doing.

create a new section if you find it clearer. Otherwise stick it into the existing section.

>>> +struct bt_att *bt_gatt_client_get_att(struct bt_gatt_client *client);
>> 
>> I really hope that we do not need this. Lets try really hard to avoid it.
>> 
> 
> I'll go ahead and remove this.
> 
> 
>>> +bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
>>> +                                     bt_gatt_client_callback_t callback,
>>> +                                     void *user_data,
>>> +                                     bt_gatt_client_destroy_func_t destroy);
>> 
>> Do not bother with it like this. Let do it like this:
>> 
>>        client = bt_gatt_client_new(att);
>> 
>>        bt_gatt_client_set_mtu(client, mtu);
>>        bt_gatt_client_set_ready_handler(client, callback, my_data, my_destroy);
>> 
>> Since we are not multi-threaded this will be safe and a lot cleaner to read.
>> 
> 
> We can have a single ready handler but I kind of like a general
> initialize function that first does the MTU exchange and then
> discovers all the attributes (this is what bt_gatt_client_init does
> though it's not really clear from the name that it also performs
> discovery, so I can change that).

I do not like the fact of _new() an object and have to call _init() to use. Actually calling _new() should trigger all needed transaction. We might want to just do this:

	client = bt_gatt_client_new(att, mtu);

And it will start the service discovery right away. As I said, it is fine to start the service discovery and set the ready handler later. Since we are main loop and single threaded this is totally fine.

>>> +
>>> +unsigned int bt_gatt_client_register_service_changed(
>>> +                             struct bt_gatt_client *client,
>>> +                             uint16_t handle,
>>> +                             bt_gatt_client_service_changed_func_t callback,
>>> +                             void *user_data,
>>> +                             bt_gatt_client_destroy_func_t destroy);
>>> +bool bt_gatt_client_unregister_service_changed(struct bt_gatt_client *client,
>>> +                                                     unsigned int id);
>> 
>> Are we expecting more than one here. If not, then better use bt_gatt_client_set_changed_handler.
>> 
> 
> My idea here was that each profile/plugin can register its own handler
> for the handles that they are interested in and get notified of a
> changed service. We could also have a single service changed handler
> here and the daemon code can then use that to go and probe each
> plugin/profile based on that.

I am not sure about this. The services changed should be handled centrally in the client itself. It might be better than allow to register a changed notifier on the bt_gatt_service that we get.

Lets not bring handles into the game right here. It might be better to push this detail to later when the code is more complete.

Regards

Marcel

