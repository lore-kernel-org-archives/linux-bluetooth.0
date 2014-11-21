Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKnPw0-rX2X=DfSwL2FMRqM+c=uDHwh9trVMGZHxvaLgg@mail.gmail.com>
References: <CAHrH25Q2w48UX5Bi2qLq0uHfGsH+k2AzecXgfrn=QgZKoT1K4A@mail.gmail.com>
	<CAHrH25SxyYWhKEHSM_+Z2Ybrekf+fHWUpAYj-YxDrbC5OUp_+w@mail.gmail.com>
	<CABBYNZKnPw0-rX2X=DfSwL2FMRqM+c=uDHwh9trVMGZHxvaLgg@mail.gmail.com>
Date: Fri, 21 Nov 2014 07:42:44 -0800
Message-ID: <CAHrH25S6bhZ2wcoefFmC2=FrBpC__RFyr1mqeE9WhPREPsiuuw@mail.gmail.com>
Subject: Re: RFC: Populating shared/gatt-client from storage.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Fri, Nov 21, 2014 at 6:24 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Thu, Nov 20, 2014 at 5:08 AM, Arman Uguray <armansito@chromium.org> wrote:
>> Hi,
>>
>>> On Wed, Nov 19, 2014 at 1:48 PM, Arman Uguray <armansito@chromium.org> wrote:
>>> Hi all,
>>>
>>> In the case where bluez is bonded with a remote device we don't want
>>> to always perform service discovery, but instead to cache the
>>> attribute data permanently and just use that on reconnections.
>>> Currently shared/gatt-client automatically discovers all services when
>>> created (via bt_gatt_client_new) so we need to add support to populate
>>> a shared/gatt-client based on cached data in storage, since a
>>> bt_gatt_client instance acts as our in-memory attribute cache for the
>>> client role.
>>>
>>> I initially thought about storing everything in INI format and loading
>>> things directly from a file, via some function like
>>> bt_gatt_client_new_from_storage. The biggest problem with this
>>> approach is parsing the INI format; since we don't want to pull in any
>>> external dependencies into shared/gatt (e.g. glib) we would possibly
>>> have to write our own key-value file parser for shared/ which seems
>>> like overkill. We could possibly invent some simpler blob format for
>>> shared/gatt-client but people brought to my attention on IRC that we
>>> may want to leave the exact storage format to the upper-layer, e.g.
>>> desktop and android versions of bluetoothd may want to use different
>>> formats for their attribute cache that's consistent with the platform.
>>>
>>> So I decided to go with something generic instead. We would basically
>>> add functions to manually populate a gatt-client and mark the client
>>> as ready only after it's services have been populated. So we would
>>> have these API changes:
>>>
>>> 1. A new argument to bt_gatt_client_new, to tell it not to perform
>>> discovery. Something like "bool discover_services".
>>>
>>>     /* Don't perform discovery */
>>>     bt_gatt_client_new(att, mtu, false);
>>>
>>> This would basically just leave the structure in "init" state and not
>>> become ready.
>>>
>>> 2. We would then add a new structure to populate a gatt-client.
>>>
>>>     struct bt_gatt_populate { .. };  /* Probably something with a better name */
>>>
>>>     bool bt_gatt_populate_start(struct bt_gatt_populate *, struct
>>> bt_gatt_client *);
>>>     bool bt_gatt_populate_add_service(....)
>>>     bool bt_gatt_populate_add_characteristic(...)
>>>     bool bt_gatt_populate_add_descriptor(....)
>>>     bool bt_gatt_populate_add_include(....)
>>>     bool bt_gatt_populate_cancel(...)
>>>     bool bt_gatt_populate_commit(struct bt_gatt_populate *);
>>>
>>> The start function would tell gatt-client that it's being populated so
>>> it would prevent this from being called twice. All of the _add_*
>>> functions would create a temporary tree owned by the populate
>>> structure, using the same internal structures defined in
>>> shared/gatt-client.c. Calling bt_gatt_populate_commit would then pass
>>> the ownership of the services to the bt_gatt_client, and
>>> bt_gatt_client would perform the MTU exchange, subscribe to
>>> notifications from the "Service Changed" characteristic if one exists,
>>> mark itself as ready and invoke the ready handler.
>>>
>>> If the upper-layer wants to store the current contents of gatt-client,
>>> they can do so by iterating through its services and caching them to a
>>> file directly. This way, shared/gatt-client would remain agnostic to
>>> any storage format.
>>>
>>> Comments requested.
>>> Arman
>
> I discussed with Johan about this, perhaps we should reuse bt_gatt_db
> also for client which could simplify the API quite a bit, and remove
> the need of iterators. So basically each device would have a instance
> of bt_gatt_db which can be populated from the storage on init but more
> importantly we can keep it alive as longs as the device is paired so
> it became very similar to what we are already doing with
> bt_gatt_server. We probably gonna need to adapt a little bit
> bt_gatt_db, perhaps a reset is needed if service changes, etc, for the
> iterators we could probably replace with gatt_db_find_by_type then you
> pass the type you want: primary, secondary, etc, which in my opinion
> is a much simpler API. Also we could take advantage of
> gatt_db_attribute so that the read and write callbacks are registered
> by the core which takes care of invoking bt_gatt_client that way the
> interface between core and plugins could be done entirely with
> gatt_db_attribute.
>
> What do you thing? It probably sets us back a little bit in terms of
> converting the core but I think it is worth it considering since it
> would align server and client db abstraction.
>

I'm not against simplifying the iterators or perhaps making db and
client look similar but I think that the current gatt_db API is too
low-level for client usage. Every time a profile wants to iterate
through characteristics, or query a characteristics descriptors, they
are going to have to make multiple calls to read_by_type,
find_information, etc, which will return partial information, then
obtain the attribute values, decode and interpret them. I don't see
this as a clean GATT abstraction. To be frank, if that's what we're
going to end up doing, the new shared/ code won't be much of an
improvement over attrib/ which at least provides this kind of
abstraction.

Also note that from the perspective of a user of gatt_db, this
wouldn't make client/server cases consistent. A user of gatt_db
registers services, characteristics, descriptors, not individual
"attributes" so to say. The user is still dealing with a higher level
abstraction, and functions like read_by_type, which map to ATT
protocol operations, are only called by bt_gatt_server, so the user
doesn't have to interact with them.

So, I think we're going to need to stick with the iterators or if
we're going to use gatt_db for pre-populating a bt_gatt_client or
perhaps use one to store remote attributes in general, then we'll want
to provide a similar abstraction for gatt_db, so that one can iterate
through its services, characteristics, etc.

> --
> Luiz Augusto von Dentz

-Arman

On Fri, Nov 21, 2014 at 6:24 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Thu, Nov 20, 2014 at 5:08 AM, Arman Uguray <armansito@chromium.org> wrote:
>> Hi,
>>
>>> On Wed, Nov 19, 2014 at 1:48 PM, Arman Uguray <armansito@chromium.org> wrote:
>>> Hi all,
>>>
>>> In the case where bluez is bonded with a remote device we don't want
>>> to always perform service discovery, but instead to cache the
>>> attribute data permanently and just use that on reconnections.
>>> Currently shared/gatt-client automatically discovers all services when
>>> created (via bt_gatt_client_new) so we need to add support to populate
>>> a shared/gatt-client based on cached data in storage, since a
>>> bt_gatt_client instance acts as our in-memory attribute cache for the
>>> client role.
>>>
>>> I initially thought about storing everything in INI format and loading
>>> things directly from a file, via some function like
>>> bt_gatt_client_new_from_storage. The biggest problem with this
>>> approach is parsing the INI format; since we don't want to pull in any
>>> external dependencies into shared/gatt (e.g. glib) we would possibly
>>> have to write our own key-value file parser for shared/ which seems
>>> like overkill. We could possibly invent some simpler blob format for
>>> shared/gatt-client but people brought to my attention on IRC that we
>>> may want to leave the exact storage format to the upper-layer, e.g.
>>> desktop and android versions of bluetoothd may want to use different
>>> formats for their attribute cache that's consistent with the platform.
>>>
>>> So I decided to go with something generic instead. We would basically
>>> add functions to manually populate a gatt-client and mark the client
>>> as ready only after it's services have been populated. So we would
>>> have these API changes:
>>>
>>> 1. A new argument to bt_gatt_client_new, to tell it not to perform
>>> discovery. Something like "bool discover_services".
>>>
>>>     /* Don't perform discovery */
>>>     bt_gatt_client_new(att, mtu, false);
>>>
>>> This would basically just leave the structure in "init" state and not
>>> become ready.
>>>
>>> 2. We would then add a new structure to populate a gatt-client.
>>>
>>>     struct bt_gatt_populate { .. };  /* Probably something with a better name */
>>>
>>>     bool bt_gatt_populate_start(struct bt_gatt_populate *, struct
>>> bt_gatt_client *);
>>>     bool bt_gatt_populate_add_service(....)
>>>     bool bt_gatt_populate_add_characteristic(...)
>>>     bool bt_gatt_populate_add_descriptor(....)
>>>     bool bt_gatt_populate_add_include(....)
>>>     bool bt_gatt_populate_cancel(...)
>>>     bool bt_gatt_populate_commit(struct bt_gatt_populate *);
>>>
>>> The start function would tell gatt-client that it's being populated so
>>> it would prevent this from being called twice. All of the _add_*
>>> functions would create a temporary tree owned by the populate
>>> structure, using the same internal structures defined in
>>> shared/gatt-client.c. Calling bt_gatt_populate_commit would then pass
>>> the ownership of the services to the bt_gatt_client, and
>>> bt_gatt_client would perform the MTU exchange, subscribe to
>>> notifications from the "Service Changed" characteristic if one exists,
>>> mark itself as ready and invoke the ready handler.
>>>
>>> If the upper-layer wants to store the current contents of gatt-client,
>>> they can do so by iterating through its services and caching them to a
>>> file directly. This way, shared/gatt-client would remain agnostic to
>>> any storage format.
>>>
>>> Comments requested.
>>> Arman
>
> I discussed with Johan about this, perhaps we should reuse bt_gatt_db
> also for client which could simplify the API quite a bit, and remove
> the need of iterators. So basically each device would have a instance
> of bt_gatt_db which can be populated from the storage on init but more
> importantly we can keep it alive as longs as the device is paired so
> it became very similar to what we are already doing with
> bt_gatt_server. We probably gonna need to adapt a little bit
> bt_gatt_db, perhaps a reset is needed if service changes, etc, for the
> iterators we could probably replace with gatt_db_find_by_type then you
> pass the type you want: primary, secondary, etc, which in my opinion
> is a much simpler API. Also we could take advantage of
> gatt_db_attribute so that the read and write callbacks are registered
> by the core which takes care of invoking bt_gatt_client that way the
> interface between core and plugins could be done entirely with
> gatt_db_attribute.
>
> What do you thing? It probably sets us back a little bit in terms of
> converting the core but I think it is worth it considering since it
> would align server and client db abstraction.
>
> --
> Luiz Augusto von Dentz
