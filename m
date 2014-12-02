Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJFYQXW0hrADBGj2j6TOxx1ZKSphvxx1=4oHjvLcGO9Gw@mail.gmail.com>
References: <1417196962-3876-1-git-send-email-armansito@chromium.org>
	<1417196962-3876-4-git-send-email-armansito@chromium.org>
	<CABBYNZ+16OLiVHB5msL7uXErhbKCR022J=jKbXNCsPeu-6uaZw@mail.gmail.com>
	<CAHrH25TBYTioi7NXb6utMHqtzUhaFg_DvNRnRaEsUdLz_r3yow@mail.gmail.com>
	<CABBYNZKRpgrdfFqKaeXwUSR6njnYaUFzfAE=gGX+JkVQ9yviNA@mail.gmail.com>
	<CAHrH25Q3ZYB6PKoStwcG_gUSgR2BJHqt1_Wvf0ZPrK3NQ7mZrw@mail.gmail.com>
	<ADB9F0AE-DABA-4530-8133-20437111A716@holtmann.org>
	<CAHrH25RNoACmhTVQ+DTBPUDW19KhcE3pqybeQNaeB=DubSxyjA@mail.gmail.com>
	<CABBYNZJFYQXW0hrADBGj2j6TOxx1ZKSphvxx1=4oHjvLcGO9Gw@mail.gmail.com>
Date: Tue, 2 Dec 2014 17:12:58 +0200
Message-ID: <CABBYNZJ7LOOmTx_4xyBkET5zQr6bcA32dnNB6gubrDmzxw5OzA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/8] shared/gatt-client: Store services in gatt_db.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Dec 2, 2014 at 12:46 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Mon, Dec 1, 2014 at 7:57 PM, Arman Uguray <armansito@chromium.org> wro=
te:
>> Hi Marcel & Luiz,
>>
>>> On Mon, Dec 1, 2014 at 9:19 AM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
>>> Hi Arman,
>>>
>>>>>>>> This patch rewrites the service discovery logic inside
>>>>>>>> shared/gatt-client. The internal service_list structure has been
>>>>>>>> entirely removed and services are stored in a gatt_db instance.
>>>>>>>> Initially, gatt-client creates and owns the life-time of the gatt_=
db.
>>>>>>>
>>>>>>> Im trying to figure out the reason why you want to start with your =
own
>>>>>>> gatt_db, is it because it lacks reference counting, if that is the
>>>>>>> case it should be trivial to add it.
>>>>>>>
>>>>>>
>>>>>> Initially, yes, the lack of reference counting is one reason, which =
I
>>>>>> was thinking of adding to gatt-db eventually. Though, what I had in
>>>>>> mind was that, the gatt-db would be created by gatt-client if you wa=
nt
>>>>>> it to perform discovery, otherwise if you construct it with gatt-db
>>>>>> then it wouldn't do discovery, which would address the permanent cac=
he
>>>>>> case. So, we would have two "new" functions:
>>>>>>
>>>>>>   bt_gatt_client_new
>>>>>>   bt_gatt_client_new_from_db
>>>>>>
>>>>>> In the first case, if the upper layer wants to make the gatt-db
>>>>>> outlive the gatt-client, in the future they can just add a reference
>>>>>> to it and own it and in the next connection they can create the clie=
nt
>>>>>> using that same db instance. This is kind of a rough idea right now
>>>>>> but I think it makes sense.
>>>>>>
>>>>>> We can also keep both functions but have both accept a gatt-db as a
>>>>>> parameter. Not sure what's best here really.
>>>>>
>>>>> For unit test maybe we can have bt_gatt_client_new_default, iirc
>>>>> Marcel suggested something like this for naming, but for the core
>>>>> daemon it can create a empty db when pairing so even the initial
>>>>> discovery would use it. This comes back to the idea of having the
>>>>> callbacks in the db to attribute added/removed, with this logic we
>>>>> could start creating D-Bus objects by the time a services is
>>>>> discovered (provided we discover everything necessary) and not only
>>>>> when bt_gatt_client signals it is done discovering, actually with the
>>>>> current concept we could be spamming the bus a little too much since
>>>>> the objects would be created all at same time this would cause severa=
l
>>>>> InterfacesAdded signals in a row at the end of pairing.
>>>>>
>>>>
>>>> I don't know about "_default" naming but are we talking about somethin=
g like:
>>>>
>>>>  bt_gatt_client_new(att, mtu, db)  /* Does discovery */
>>>>  bt_gatt_client_new_from_cache(att, mtu, db)  /* No discovery */
>>>>
>>>> So both functions get passed a db either way?
>>>
>>> actually we might just better only use bt_gatt_client_new() and provide=
 functionality to flush certain devices from the cache. In case we do want =
to trigger a discovery or re-discovery of devices.
>>>
>>> The cache should just work and do the right thing. We should be able se=
t max cacheable service, devices etc. So lets just give the GATT client a c=
ache to work with and that is it. Everything else is an implementation deta=
il between the client and the cache.
>>>
>>> I prefer that every client has a cache attached to it (or allow NULL in=
 case we really want to run without a cache). If the cache is independent, =
it can easily do the right thing for us.
>>>
>>
>> After our brief chat on IRC, please confirm that this is more or less
>> what we want:
>>
>>   bt_gatt_client_new(att, mtu, db) -> adds ref to db.
>>   bt_gatt_client_new(att, mtu, NULL) -> creates its own db
>>
>> Either function might cause discovery based on whether or not the db
>> is empty. If it's empty, client always starts discovery, otherwise it
>> skips it.
>
> Sounds good. Sorry for not responding on IRC yesterday, I was away and
> only noticed today that you have been there.

I went ahead and implemented the reference counting for gatt_db, I
will try to be online later today in case you want some to discuss
more about this.

>>   bt_gatt_client_get_db -> returns db. This would be necessary if we
>> want to allow passing NULL to bt_gatt_client_new.
>
> Hmm, but if we pass NULL, which I suppose is to enable things like
> unit tests, why would we want to pull the db out of it? As I mention
> from the core we would probably create the db when pairing so we get
> notification regarding services changes from discovery, with this mind
> I guess if the client pass NULL this means the db would be internal.
>
> Btw, I guess we should associate a valid db if service changed CCC has
> been written or perhaps we clear the db if discovery is interrupted
> before that happens but I guess in some cases we may have a db without
> a service changed, in case we don't pair for example, in that case we
> need to rediscover the handles before letting any profile connect
> otherwise they may end up using invalid handles.
>
>> I think all of these are minor details that can be revised later, but
>> I still need something as a starting point.
>>
>> In addition, I'm thinking that gatt-db should have service added and
>> removed events that can be triggered by set_active and the clear
>> functions. Something like
>>
>>   gatt_db_register_service_callbacks(db, added_cb, removed_cb);
>>
>> In the client case, added_cb would only be called once all attributes
>> belonging to the service have been discovered and inserted into the
>> db. Client would also communicate services that are affected by a
>> "Service Changed" indication via these callbacks. Either way, I
>> suggest adding the service callback mechanism in a later patch set.
>
> Sounds good, but we might have to introduce this before we start doing
> changing the core since this will probably be the preferable way the
> discovery interact with core.
>
>> Let me know of this makes sense to everyone.
>>
>>> Regards
>>>
>>> Marcel
>>>
>>
>> Arman
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
