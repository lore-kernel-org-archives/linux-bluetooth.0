Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <CABBYNZJ7LOOmTx_4xyBkET5zQr6bcA32dnNB6gubrDmzxw5OzA@mail.gmail.com>
References: <1417196962-3876-1-git-send-email-armansito@chromium.org>
	<1417196962-3876-4-git-send-email-armansito@chromium.org>
	<CABBYNZ+16OLiVHB5msL7uXErhbKCR022J=jKbXNCsPeu-6uaZw@mail.gmail.com>
	<CAHrH25TBYTioi7NXb6utMHqtzUhaFg_DvNRnRaEsUdLz_r3yow@mail.gmail.com>
	<CABBYNZKRpgrdfFqKaeXwUSR6njnYaUFzfAE=gGX+JkVQ9yviNA@mail.gmail.com>
	<CAHrH25Q3ZYB6PKoStwcG_gUSgR2BJHqt1_Wvf0ZPrK3NQ7mZrw@mail.gmail.com>
	<ADB9F0AE-DABA-4530-8133-20437111A716@holtmann.org>
	<CAHrH25RNoACmhTVQ+DTBPUDW19KhcE3pqybeQNaeB=DubSxyjA@mail.gmail.com>
	<CABBYNZJFYQXW0hrADBGj2j6TOxx1ZKSphvxx1=4oHjvLcGO9Gw@mail.gmail.com>
	<CABBYNZJ7LOOmTx_4xyBkET5zQr6bcA32dnNB6gubrDmzxw5OzA@mail.gmail.com>
Date: Tue, 2 Dec 2014 11:35:02 -0800
Message-ID: <CAHrH25RUigTasNdGy9ne16EvtxC7_pEdRj-bUnE=yNGwzuMqRA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/8] shared/gatt-client: Store services in gatt_db.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Tue, Dec 2, 2014 at 7:12 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.=
com> wrote:
> Hi Arman,
>
> On Tue, Dec 2, 2014 at 12:46 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Arman,
>>
>> On Mon, Dec 1, 2014 at 7:57 PM, Arman Uguray <armansito@chromium.org> wr=
ote:
>>> Hi Marcel & Luiz,
>>>
>>>> On Mon, Dec 1, 2014 at 9:19 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>>>> Hi Arman,
>>>>
>>>>>>>>> This patch rewrites the service discovery logic inside
>>>>>>>>> shared/gatt-client. The internal service_list structure has been
>>>>>>>>> entirely removed and services are stored in a gatt_db instance.
>>>>>>>>> Initially, gatt-client creates and owns the life-time of the gatt=
_db.
>>>>>>>>
>>>>>>>> Im trying to figure out the reason why you want to start with your=
 own
>>>>>>>> gatt_db, is it because it lacks reference counting, if that is the
>>>>>>>> case it should be trivial to add it.
>>>>>>>>
>>>>>>>
>>>>>>> Initially, yes, the lack of reference counting is one reason, which=
 I
>>>>>>> was thinking of adding to gatt-db eventually. Though, what I had in
>>>>>>> mind was that, the gatt-db would be created by gatt-client if you w=
ant
>>>>>>> it to perform discovery, otherwise if you construct it with gatt-db
>>>>>>> then it wouldn't do discovery, which would address the permanent ca=
che
>>>>>>> case. So, we would have two "new" functions:
>>>>>>>
>>>>>>>   bt_gatt_client_new
>>>>>>>   bt_gatt_client_new_from_db
>>>>>>>
>>>>>>> In the first case, if the upper layer wants to make the gatt-db
>>>>>>> outlive the gatt-client, in the future they can just add a referenc=
e
>>>>>>> to it and own it and in the next connection they can create the cli=
ent
>>>>>>> using that same db instance. This is kind of a rough idea right now
>>>>>>> but I think it makes sense.
>>>>>>>
>>>>>>> We can also keep both functions but have both accept a gatt-db as a
>>>>>>> parameter. Not sure what's best here really.
>>>>>>
>>>>>> For unit test maybe we can have bt_gatt_client_new_default, iirc
>>>>>> Marcel suggested something like this for naming, but for the core
>>>>>> daemon it can create a empty db when pairing so even the initial
>>>>>> discovery would use it. This comes back to the idea of having the
>>>>>> callbacks in the db to attribute added/removed, with this logic we
>>>>>> could start creating D-Bus objects by the time a services is
>>>>>> discovered (provided we discover everything necessary) and not only
>>>>>> when bt_gatt_client signals it is done discovering, actually with th=
e
>>>>>> current concept we could be spamming the bus a little too much since
>>>>>> the objects would be created all at same time this would cause sever=
al
>>>>>> InterfacesAdded signals in a row at the end of pairing.
>>>>>>
>>>>>
>>>>> I don't know about "_default" naming but are we talking about somethi=
ng like:
>>>>>
>>>>>  bt_gatt_client_new(att, mtu, db)  /* Does discovery */
>>>>>  bt_gatt_client_new_from_cache(att, mtu, db)  /* No discovery */
>>>>>
>>>>> So both functions get passed a db either way?
>>>>
>>>> actually we might just better only use bt_gatt_client_new() and provid=
e functionality to flush certain devices from the cache. In case we do want=
 to trigger a discovery or re-discovery of devices.
>>>>
>>>> The cache should just work and do the right thing. We should be able s=
et max cacheable service, devices etc. So lets just give the GATT client a =
cache to work with and that is it. Everything else is an implementation det=
ail between the client and the cache.
>>>>
>>>> I prefer that every client has a cache attached to it (or allow NULL i=
n case we really want to run without a cache). If the cache is independent,=
 it can easily do the right thing for us.
>>>>
>>>
>>> After our brief chat on IRC, please confirm that this is more or less
>>> what we want:
>>>
>>>   bt_gatt_client_new(att, mtu, db) -> adds ref to db.
>>>   bt_gatt_client_new(att, mtu, NULL) -> creates its own db
>>>
>>> Either function might cause discovery based on whether or not the db
>>> is empty. If it's empty, client always starts discovery, otherwise it
>>> skips it.
>>
>> Sounds good. Sorry for not responding on IRC yesterday, I was away and
>> only noticed today that you have been there.

No worries. I haven't uploaded the next round yet until we have a good
idea of what we want.

>
> I went ahead and implemented the reference counting for gatt_db, I
> will try to be online later today in case you want some to discuss
> more about this.
>

Cool, I'll rebase and make the code work with ref counts.

>>>   bt_gatt_client_get_db -> returns db. This would be necessary if we
>>> want to allow passing NULL to bt_gatt_client_new.
>>
>> Hmm, but if we pass NULL, which I suppose is to enable things like
>> unit tests, why would we want to pull the db out of it? As I mention
>> from the core we would probably create the db when pairing so we get
>> notification regarding services changes from discovery, with this mind
>> I guess if the client pass NULL this means the db would be internal.
>>

I guess the idea with passing NULL is that you're basically saying
"there is no existing database around for this device, create a new
one and I'll get it from you later". So, if we allow passing NULL and
having gatt-client create the db, then we would want to pull the db
out of it, since we can't browse any of the handles or get events
otherwise. I don't have a particular opinion on this; I think it's
equally fine to disallow passing NULL and always have the upper layer
instantiate the db. Then we wouldn't need the getter I guess.

>> Btw, I guess we should associate a valid db if service changed CCC has
>> been written or perhaps we clear the db if discovery is interrupted
>> before that happens but I guess in some cases we may have a db without
>> a service changed, in case we don't pair for example, in that case we
>> need to rediscover the handles before letting any profile connect
>> otherwise they may end up using invalid handles.
>>

Yeah, I think if we always require that a db is passed in to
bt_gatt_client_new, then we can have the client make the correct
decision. If there was no service changed characteristic for instance,
then the upper layer may want to skip discovery and reuse the same db
(with the assumption that the services won't change) or pass an empty
db to have client discover everything.

>>> I think all of these are minor details that can be revised later, but
>>> I still need something as a starting point.
>>>
>>> In addition, I'm thinking that gatt-db should have service added and
>>> removed events that can be triggered by set_active and the clear
>>> functions. Something like
>>>
>>>   gatt_db_register_service_callbacks(db, added_cb, removed_cb);
>>>
>>> In the client case, added_cb would only be called once all attributes
>>> belonging to the service have been discovered and inserted into the
>>> db. Client would also communicate services that are affected by a
>>> "Service Changed" indication via these callbacks. Either way, I
>>> suggest adding the service callback mechanism in a later patch set.
>>
>> Sounds good, but we might have to introduce this before we start doing
>> changing the core since this will probably be the preferable way the
>> discovery interact with core.
>>

OK, sounds good to me. I might actually just add this into v1 of this set.

>>> Let me know of this makes sense to everyone.
>>>
>>>> Regards
>>>>
>>>> Marcel
>>>>
>>>
>>> Arman
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Arman
