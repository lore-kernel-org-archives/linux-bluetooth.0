Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B245A4EE-35B1-442A-AE5D-55DDF441AA12@holtmann.org>
References: <CAHrH25Q2w48UX5Bi2qLq0uHfGsH+k2AzecXgfrn=QgZKoT1K4A@mail.gmail.com>
	<E774ECE7-226D-427D-8FFB-CB3BF8C41428@holtmann.org>
	<CAHrH25R0C0-xBCTQOvAC=qnyZBFZxaahe_4ywQwNqv1dL9gFjQ@mail.gmail.com>
	<B245A4EE-35B1-442A-AE5D-55DDF441AA12@holtmann.org>
Date: Mon, 24 Nov 2014 20:13:14 +0200
Message-ID: <CABBYNZ+=UdOGsvTqoyw071DGoGTrfxq7wpewoofhGHpK4ppmmg@mail.gmail.com>
Subject: Re: RFC: Populating shared/gatt-client from storage.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Nov 22, 2014 at 5:17 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Arman,
>
>>>> In the case where bluez is bonded with a remote device we don't want
>>>> to always perform service discovery, but instead to cache the
>>>> attribute data permanently and just use that on reconnections.
>>>> Currently shared/gatt-client automatically discovers all services when
>>>> created (via bt_gatt_client_new) so we need to add support to populate
>>>> a shared/gatt-client based on cached data in storage, since a
>>>> bt_gatt_client instance acts as our in-memory attribute cache for the
>>>> client role.
>>>>
>>>> I initially thought about storing everything in INI format and loading
>>>> things directly from a file, via some function like
>>>> bt_gatt_client_new_from_storage. The biggest problem with this
>>>> approach is parsing the INI format; since we don't want to pull in any
>>>> external dependencies into shared/gatt (e.g. glib) we would possibly
>>>> have to write our own key-value file parser for shared/ which seems
>>>> like overkill. We could possibly invent some simpler blob format for
>>>> shared/gatt-client but people brought to my attention on IRC that we
>>>> may want to leave the exact storage format to the upper-layer, e.g.
>>>> desktop and android versions of bluetoothd may want to use different
>>>> formats for their attribute cache that's consistent with the platform.
>>>
>>> what we could do is just store the plain binary data. These are cache f=
iles and if you remove them, that just means next time we have to do full s=
ervice discovery again.
>>>
>>>> So I decided to go with something generic instead. We would basically
>>>> add functions to manually populate a gatt-client and mark the client
>>>> as ready only after it's services have been populated. So we would
>>>> have these API changes:
>>>>
>>>> 1. A new argument to bt_gatt_client_new, to tell it not to perform
>>>> discovery. Something like "bool discover_services".
>>>>
>>>>   /* Don't perform discovery */
>>>>   bt_gatt_client_new(att, mtu, false);
>>>>
>>>> This would basically just leave the structure in "init" state and not
>>>> become ready.
>>>
>>> Adding tons of parameters to a _new() is not really a good idea. I woul=
d always add a special _new_without_discovery() or something similar to our=
 API. If we decide to go this route.
>>>
>>>>
>>>> 2. We would then add a new structure to populate a gatt-client.
>>>>
>>>>   struct bt_gatt_populate { .. };  /* Probably something with a better=
 name */
>>>>
>>>>   bool bt_gatt_populate_start(struct bt_gatt_populate *, struct
>>>> bt_gatt_client *);
>>>>   bool bt_gatt_populate_add_service(....)
>>>>   bool bt_gatt_populate_add_characteristic(...)
>>>>   bool bt_gatt_populate_add_descriptor(....)
>>>>   bool bt_gatt_populate_add_include(....)
>>>>   bool bt_gatt_populate_cancel(...)
>>>>   bool bt_gatt_populate_commit(struct bt_gatt_populate *);
>>>>
>>>> The start function would tell gatt-client that it's being populated so
>>>> it would prevent this from being called twice. All of the _add_*
>>>> functions would create a temporary tree owned by the populate
>>>> structure, using the same internal structures defined in
>>>> shared/gatt-client.c. Calling bt_gatt_populate_commit would then pass
>>>> the ownership of the services to the bt_gatt_client, and
>>>> bt_gatt_client would perform the MTU exchange, subscribe to
>>>> notifications from the "Service Changed" characteristic if one exists,
>>>> mark itself as ready and invoke the ready handler.
>>>>
>>>> If the upper-layer wants to store the current contents of gatt-client,
>>>> they can do so by iterating through its services and caching them to a
>>>> file directly. This way, shared/gatt-client would remain agnostic to
>>>> any storage format.
>>>
>>> One other way of doing something like this is doing it this way:
>>>
>>>        struct bt_gatt_storage;
>>>
>>>        struct bt_gatt_storage *bt_gatt_storage_new()
>>>        bt_gatt_storage_add_x
>>>
>>>        struct bt_gatt_client *bt_gatt_client_from_storage(struct bt_gat=
t_storage);
>>>
>>> I am not sure this is actually any better. It is just an idea, but we m=
ight want to just store plain binary data of cached services in a binary ca=
ched file. I think that we can have a binary storage format for the cached =
data and then we just point the bt_gatt_client_new_with_cahce() to that fil=
e and let it load if present. So the upper layers would just decide where t=
hat file is located.
>>>
>>
>> I think in the end the exact format of the data should be up to the
>> upper layer, whether its binary data or INI format. After some
>> discussions on IRC we decided that this storage could be represented
>> by shared/gatt-db, which already has these functions to add services,
>> characteristics, etc. But we would need to make shared/gatt-db provide
>> a client role abstraction as well, since it's more meant for the
>> server role at the moment.
>>
>> This way bluetoothd could for example just read the INI file, create a
>> gatt_db and do something like bt_gatt_client_from_db(db, mtu);
>
> following up on my other email, then yes, we could have a bt_gatt_cache t=
hat is a collection of bt_gatt_db objects. That however is an implementatio=
n detail to me. I think it is important that we have a global concept of a =
cache. And as said, just having an in-memory cache will already solve 99% o=
f the use cases where we want to avoid service discovery for already known =
devices. Only cold-boot would be an issue and honestly that is a penalty th=
at I would happily accept for a first iteration. Which means we do not have=
 to bother with file formats in the beginning.

I guess we are more or less in the same page then, I just did not
thought about the global cache but yes it could well be a collection
of bt_gatt_db per device. I also agree we could have a in-memory cache
to start with until we decide a good format to store persistently,
Szymon actually suggested doing the cache in binary format like we
have for SDP, perhaps one service per line, but that is something we
can give more thought. I guess we can experiment with HoG here, since
once you configure CCC we should not miss any event from the point we
connect.


--=20
Luiz Augusto von Dentz
