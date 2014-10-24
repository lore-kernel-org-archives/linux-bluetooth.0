Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <CABBYNZLE_xxoaPXZ=9LY2AwT-Pa_mqEYRD8v4_TgMTdo77j-Qw@mail.gmail.com>
References: <CAHrH25S3h=LjaXSFkJiz5X41JD9-1zNJiD1R7hQNfA3aSbO0sg@mail.gmail.com>
	<CABBYNZLE_xxoaPXZ=9LY2AwT-Pa_mqEYRD8v4_TgMTdo77j-Qw@mail.gmail.com>
Date: Fri, 24 Oct 2014 12:26:23 -0700
Message-ID: <CAHrH25T1eNAXwhVm51CgfFPL9n3htc7EFZYxj6ych7gz16mbdw@mail.gmail.com>
Subject: Re: Attribute security permissions and CCC descriptors in shared/gatt-server.
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Marcin Kraglak <marcin.kraglak@tieto.com>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Oct 23, 2014 at 12:51 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Wed, Oct 22, 2014 at 11:12 PM, Arman Uguray <armansito@chromium.org> wrote:
>> Hi all,
>>
>> I have some unresolved questions about two aspects of
>> shared/gatt-server and I thought it might be better to discuss them
>> before moving on with the related parts of the implementation.
>>
>> *** 1. Who will be responsible for Attribute Permission checks? ***
>>
>> These mainly come in play when the remote end wants to read or write
>> the value of a characteristic/descriptor. We currently have read &
>> write callbacks that get assigned by the upper-layer to a
>> characteristic/descriptor definition in shared/gatt-db. Since these
>> callbacks already handle the read/write it initially made sense to me
>> that this is where encryption/authentication/authorization permission
>> checks can be performed. I then realized that there are cases where we
>> may want to perform this check before we invoke the read/write
>> callback. For instance, the Prepare Write request requires attribute
>> permission checks to be performed, however (in the current design) we
>> wouldn't actually call the write callback until a subsequent Execute
>> Write request is received.
>
> I believe this should be handle by the db, perhaps with a dedicated
> prepare function that should probably call a callback so the
> implementation can really tell when a write is about to happen. The
> weird thing here is that the gatt_db_add_characteristic take
> permissions but never really use it for anything except in
> gatt_db_get_attribute_permissions, I thought the idea would be to do
> the permission checks with it or Im missing something.
>

My impression was that gatt-db simple acts as a place to store the
permission data. It currently doesn't define a standard format for
storing those permissions and android uses the Android platform API's
permission enum values directly. I'm now defining standard values for
these, though again, gatt-db still would only be able to check for the
access permissions and not encryption/authentication/authorization
permissions, which should really be checked by bt_gatt_server since
it's already associated with the relevant bt_att.


>> The main problem here is the fact that shared/att is designed to be
>> transport agnostic: it doesn't know whether the underlying connection
>> is AF_BLUETOOTH or something else, so it can't make assumptions on the
>> nature of the connection to obtain security level information. We
>> could add some sort of delegate callback to this end, perhaps
>> something like:
>
> Then we should probably have some functions to set and get the
> security level, but Im sure it needs to be a callback as it does not
> looks like it gonna change without us noticing it, then we can
> automatically check with security level against the permissions
> provided by the profile when registering the characteristic.
>

Do you mean that you're sure it needs to be a callback or you're NOT sure? :)


>> static uint8_t my_sec_handler(void *user_data)
>> {
>>         ....
>>         return sec;
>> }
>> ...
>> bt_att_register_security_handler(att, my_sec_handler);
>>
>> And then bt_gatt_server can obtain the current security level like this:
>>
>> uint8_t sec = bt_att_get_security_level(att);
>>
>> where bt_att_get_security_level is implemented as:
>>
>> static uint8_t bt_att_get_security_level(struct bt_att *att)
>> {
>>       if (!att || !att->security_callback)
>>               return 0;
>>
>>       return att->security_callback(att->security_data);
>> }
>>
>>
>> I'm mostly thinking out loud here; would something like this make sense?
>>
>>
>> *** 2. Is shared/gatt-server responsible for keeping track of Client
>> Characteristic Configuration descriptor states for each bonded client?
>> ***
>>
>> Currently, the descriptor read/write operations need to be handled by
>> the upper layer via the read/write callbacks anyway, since the
>> side-effects of a writing to a particular CCC descriptor need to be
>> implemented by the related profile. In the bonding case, the
>> read/write callbacks could determine what value to return and how to
>> cache the value on a per-device basis without shared/gatt-db having a
>> notion of "per-client CCC descriptors".
>
> Well making gatt_db have the notion of CCC would make things a little
> bit simpler for storing and reloading but it would probably force us
> to rethink how the db access the values, perhaps the db could cache
> CCC values per client so it could detect changes and send
> notifications automatically whenever the profiles tell it values has
> changed or when a write succeeds.
>

Things start getting tricky here since automatically sending
notifications to the correct clients requires gatt-db to send these
through the correct bt_gatt_server/bt_att structures, which means then
it needs to somehow keep track of or access these. I think this goes
beyond what gatt-db was built for which is to just act as an attribute
cache.

Regardless, all profiles will already have to separately implement the
side effects of writing to a CCC descriptor and sending out the
notifications/indications when needed. That said, leaving the
management of which clients enabled notifications and which didn't
entirely to profiles will lead to a lot of duplicate code among
profile implementations.

One thing we could do is have bt_gatt_server keep track of CCC
descriptors, similar to how bt_gatt_client takes care of writing to a
remote CCC. Since bt_gatt_server is already a per-connection entity,
calling bt_gatt_server_send_notification could check to see if the
given handle matches a characteristic with a CCC descriptor and send
the notification only if that CCC descriptor was written earlier
through a write request through its internal bt_att.

Also, think of how all of this code will fit together in the future.
Take bluetoothd for example. It makes sense to me that a gatt-db will
be initialized by src/adapter, while there will be a separate instance
of bt_gatt_server for each src/device. So if a profile wants to notify
all connected GATT clients of a characteristic value with a single
function call, it'll probably have to call some API function through
src/adapter. So either there will need to be a higher-level entity
that owns gatt-db and has access to all bt_gatt_server instances, or
all bt_gatt_server instances will need to be registered with gatt-db
somehow. So, we will have to think of an interesting GATT-specific
client & server role profile API.

We should probably keep things all simple for now and revisit this in
the future. So I'm not going to focus on managing per-client CCC
descriptors for now and leave the notion of CCC up to the higher
levels of the stack until we have enough solid code to actually
implement something.


>> Does this make sense? If so, is there a point of keeping the "bdaddr_t
>> *bdaddr" arguments of gatt_db_read_t, gatt_db_write_t, gatt_db_read,
>> and gatt_db_write? Note that I'm currently passing NULL to all of
>> these calls for this parameter in shared/gatt-server, since bt_att
>> doesn't have a notion of a BD_ADDR.
>
> I guess this was inspired by Android, I would agree that if you
> register a characteristic and set the permission properly then it does
> not matter who is attempting to read/write as long as they are fulfill
> the requirements it should be okay but perhaps Android have pushed the
> notion of CCC up in the stack which force it to expose the remote
> address. Anyway for unit test I will have to address it since that
> will be using a socket pair, perhaps passing NULL is fine if we have
> CCC caching but in case of Android I don't think we can do much about
> it.
>

Well, in the Android case, could the device address be somehow
propagated as part of user_data?

>
> --
> Luiz Augusto von Dentz

Cheers,
Arman
