Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <ADB9F0AE-DABA-4530-8133-20437111A716@holtmann.org>
References: <1417196962-3876-1-git-send-email-armansito@chromium.org>
	<1417196962-3876-4-git-send-email-armansito@chromium.org>
	<CABBYNZ+16OLiVHB5msL7uXErhbKCR022J=jKbXNCsPeu-6uaZw@mail.gmail.com>
	<CAHrH25TBYTioi7NXb6utMHqtzUhaFg_DvNRnRaEsUdLz_r3yow@mail.gmail.com>
	<CABBYNZKRpgrdfFqKaeXwUSR6njnYaUFzfAE=gGX+JkVQ9yviNA@mail.gmail.com>
	<CAHrH25Q3ZYB6PKoStwcG_gUSgR2BJHqt1_Wvf0ZPrK3NQ7mZrw@mail.gmail.com>
	<ADB9F0AE-DABA-4530-8133-20437111A716@holtmann.org>
Date: Mon, 1 Dec 2014 09:57:41 -0800
Message-ID: <CAHrH25RNoACmhTVQ+DTBPUDW19KhcE3pqybeQNaeB=DubSxyjA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/8] shared/gatt-client: Store services in gatt_db.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel & Luiz,

> On Mon, Dec 1, 2014 at 9:19 AM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Arman,
>
>>>>>> This patch rewrites the service discovery logic inside
>>>>>> shared/gatt-client. The internal service_list structure has been
>>>>>> entirely removed and services are stored in a gatt_db instance.
>>>>>> Initially, gatt-client creates and owns the life-time of the gatt_db=
.
>>>>>
>>>>> Im trying to figure out the reason why you want to start with your ow=
n
>>>>> gatt_db, is it because it lacks reference counting, if that is the
>>>>> case it should be trivial to add it.
>>>>>
>>>>
>>>> Initially, yes, the lack of reference counting is one reason, which I
>>>> was thinking of adding to gatt-db eventually. Though, what I had in
>>>> mind was that, the gatt-db would be created by gatt-client if you want
>>>> it to perform discovery, otherwise if you construct it with gatt-db
>>>> then it wouldn't do discovery, which would address the permanent cache
>>>> case. So, we would have two "new" functions:
>>>>
>>>>   bt_gatt_client_new
>>>>   bt_gatt_client_new_from_db
>>>>
>>>> In the first case, if the upper layer wants to make the gatt-db
>>>> outlive the gatt-client, in the future they can just add a reference
>>>> to it and own it and in the next connection they can create the client
>>>> using that same db instance. This is kind of a rough idea right now
>>>> but I think it makes sense.
>>>>
>>>> We can also keep both functions but have both accept a gatt-db as a
>>>> parameter. Not sure what's best here really.
>>>
>>> For unit test maybe we can have bt_gatt_client_new_default, iirc
>>> Marcel suggested something like this for naming, but for the core
>>> daemon it can create a empty db when pairing so even the initial
>>> discovery would use it. This comes back to the idea of having the
>>> callbacks in the db to attribute added/removed, with this logic we
>>> could start creating D-Bus objects by the time a services is
>>> discovered (provided we discover everything necessary) and not only
>>> when bt_gatt_client signals it is done discovering, actually with the
>>> current concept we could be spamming the bus a little too much since
>>> the objects would be created all at same time this would cause several
>>> InterfacesAdded signals in a row at the end of pairing.
>>>
>>
>> I don't know about "_default" naming but are we talking about something =
like:
>>
>>  bt_gatt_client_new(att, mtu, db)  /* Does discovery */
>>  bt_gatt_client_new_from_cache(att, mtu, db)  /* No discovery */
>>
>> So both functions get passed a db either way?
>
> actually we might just better only use bt_gatt_client_new() and provide f=
unctionality to flush certain devices from the cache. In case we do want to=
 trigger a discovery or re-discovery of devices.
>
> The cache should just work and do the right thing. We should be able set =
max cacheable service, devices etc. So lets just give the GATT client a cac=
he to work with and that is it. Everything else is an implementation detail=
 between the client and the cache.
>
> I prefer that every client has a cache attached to it (or allow NULL in c=
ase we really want to run without a cache). If the cache is independent, it=
 can easily do the right thing for us.
>

After our brief chat on IRC, please confirm that this is more or less
what we want:

  bt_gatt_client_new(att, mtu, db) -> adds ref to db.
  bt_gatt_client_new(att, mtu, NULL) -> creates its own db

Either function might cause discovery based on whether or not the db
is empty. If it's empty, client always starts discovery, otherwise it
skips it.

  bt_gatt_client_get_db -> returns db. This would be necessary if we
want to allow passing NULL to bt_gatt_client_new.

I think all of these are minor details that can be revised later, but
I still need something as a starting point.

In addition, I'm thinking that gatt-db should have service added and
removed events that can be triggered by set_active and the clear
functions. Something like

  gatt_db_register_service_callbacks(db, added_cb, removed_cb);

In the client case, added_cb would only be called once all attributes
belonging to the service have been discovered and inserted into the
db. Client would also communicate services that are affected by a
"Service Changed" indication via these callbacks. Either way, I
suggest adding the service callback mechanism in a later patch set.

Let me know of this makes sense to everyone.

> Regards
>
> Marcel
>

Arman
