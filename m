Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ6r8rtqGw6gDe3Ye7KGwXGF0fYykBDuiBR5qdviMUOFQ@mail.gmail.com>
References: <1441319996-8675-1-git-send-email-jpawlowski@google.com>
	<CABBYNZJ6r8rtqGw6gDe3Ye7KGwXGF0fYykBDuiBR5qdviMUOFQ@mail.gmail.com>
Date: Fri, 4 Sep 2015 16:26:40 -0700
Message-ID: <CAD0=r8yrEBwP9g3uaBTnith93bdPjB_xd+Anqn_xWXWudivpxw@mail.gmail.com>
Subject: Re: [PATCH] core/gatt-client: unregister DBus services on disconnect
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Sep 4, 2015 at 1:06 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jakub,
>
> On Fri, Sep 4, 2015 at 1:39 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> Currently when LE device is disconnected, all services and characteristics
>> are still registered and visible through DBus. Those objects aren't
>> usable, reading properties or calling methods on them is not usable at
>> all. However those services cause issues for clients re-connecting to
>> device that try to read/write characteristic right after connecting.
>> Read/write operation right after reconnecting ends with "Not connected"
>> error, due to dev->client not being ready. Workaround is to wait a fixed
>> time, around 1 second after connecting before issuing read/write commands.
>> Unregistering services and characteristic from  DBus after disconnect
>> fixes this issue.
>>
>> This patch also fixes bug:
>> 1. Connect to unpaired LE device, or paired LE device that have
>>    "Service Changed" notifications broken (i.e. all Android phones
>>    including version L).
>
> Isn't this solve by the cache validation?
>
>> 2. Disconnect from device, add more services to its GATT database.
>
> Ditto.
>
>> 3. Re-connect to the device. Discovery of primary services will find
>>    newly added services, and bluetoothd will keep them in its internal
>>    structures.
>
> You are saying this is not reflected in D-Bus, iirc I tested this and
> should cause new objects being added and the old being removed.
>

After I applied your patch "core/gatt: Fix not exporting new services"
it works fine. Thanks.

>> 4. Newly addes services will never be exported to DBus due to check
>>    in btd_gatt_client_ready if (queue_isempty(client->services))
>
> Sounds like a different bug
>
>> Having client->services cleared when disconnecting fixes this bug.
>
> That has some shortcomings for notifications, since you always remove
> the object on disconnect the configuration may stay active in the
> remote then once reconnecting they would be lost, and this is used by
> a lot profiles, in fact I don't think we can even implement a heart
> rate properly without this behavior since it may start notifying
> changes as soon it connects.

Thanks for pointing that, I was unaware of that part. I fought you
have to re-register for notifications each time you re-connect to
device (not on Bluetooth level, because CCC should be persistent, but
on DBus level).

If you restart your machine, or just restart bluetoothd services are
not re-created untill you connect to device anyway. Would that also
break profiles and notifications behaviour then ? If no then removing
services from DBus shouldn't have impact.

>
> Instead what I would probably do is drop the line that checks if queue
> is empty and start and using gatt_db_service_set_claimed so the next
> time we can skip them. For the 'Not connected' error we may have to
> find another solution, either we delay the connected signal or we
> change the logic so that cache validation don't hold other commands
> the problem is that we may find out the attribute was removed during
> cache validation which can cause other errors but I guess there is no
> better way.
>

So removing GATT services would solve all those issues, if it wouldn't
break notifications...

Maybe adding new property, like GattReady that would notify when gatt
is ready would be good solution ?
There is already similar property. If "GattServices" is set on
org.bluez.Device1, that means that Services are ready to be used.
"GattServices" is set when gatt client is ready:

http://git.kernel.org/cgit/bluetooth/bluez.git/tree/src/device.c?id=324c585bfa277f72eb57255cbf1ee8620910758d#n968

Would making this property notify about changes and adding doc be good
solution ?

>> ---
>>  src/gatt-client.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/src/gatt-client.c b/src/gatt-client.c
>> index 3356ee4..abcec7c 100644
>> --- a/src/gatt-client.c
>> +++ b/src/gatt-client.c
>> @@ -1951,6 +1951,8 @@ void btd_gatt_client_disconnected(struct btd_gatt_client *client)
>>         queue_foreach(client->all_notify_clients, clear_notify_id, NULL);
>>         queue_foreach(client->services, cancel_ops, client->gatt);
>>
>> +       queue_remove_all(client->services, NULL, NULL, unregister_service);
>> +
>>         bt_gatt_client_unref(client->gatt);
>>         client->gatt = NULL;
>>  }
>> --
>> 2.1.4
>
>
>
>
> --
> Luiz Augusto von Dentz
