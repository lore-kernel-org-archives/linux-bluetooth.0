Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALevQMbHt9aFxAKbj8LAA3kcUYB+t9Na8bBE6YLqTfRR37n56A@mail.gmail.com>
References: <20180419140312.22707-1-grzegorz.kolodziejczyk@codecoup.pl>
 <20180419140312.22707-4-grzegorz.kolodziejczyk@codecoup.pl>
 <CABBYNZK98ZsQ8oa6DHm-CsNZvLkALR6H-Vp8eg0xSp5aU5cY4A@mail.gmail.com> <CALevQMbHt9aFxAKbj8LAA3kcUYB+t9Na8bBE6YLqTfRR37n56A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Apr 2018 14:19:00 +0300
Message-ID: <CABBYNZJb=fS-f09yX6XiUEOf2u=MeHgPboVMYt45UfcJ3CUtJw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 4/4] shared/gatt-server: Fix prepare write queuing
To: =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?=
        <grzegorz.kolodziejczyk@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Fri, Apr 20, 2018 at 11:11 AM, Grzegorz Ko=C5=82odziejczyk
<grzegorz.kolodziejczyk@codecoup.pl> wrote:
> Hi Luiz,
>
> I did this fix while testing it agains PTS test case "4.6.39
> GATT/SR/GAW/BV-10-C [Nested Long Characteristic Value Reliable Writes
> - to Server]"
>
> Without this fix bluez behaves as described:
> 1) PTS do prepare write to CHARACTERISTIC1 with offset =3D 0 and value
> with size =3D ATT_MTU-5.
> 2) Bluez do new prepare write for CHARACTERISTIC1
> 3) PTS do prepare write to CHARACTERISTIC2 with offset =3D 0 and value
> with size =3D ATT_MTU-5.
> 4) Bluez do new prepare write for CHARACTERISTIC2
> 5) PTS do prepare write to CHARACTERISTIC1 with offset =3D ATT_MTU-5 and
> value with size < ATT_MTU-5.
> 6) Bluez do new prepare write for CHARACTERISTIC1
> 7) PTS do prepare write to CHARACTERISTIC2 with offset =3D ATT_MTU-5 and
> value with size < ATT_MTU-5.
> 8) Bluez do new prepare write for CHARACTERISTIC2
>
> 9) Execut write is issued with flag "Immediately write all pend-ing
> prepared values".
> 10) PTS do read of those two CHARACTERISTICS and got response with
> value from last prepare write to CHARACTERISTIC (this from second
> prepare write form offset ATT_MTU-5) cause thos are 4 seperate prepare
> writes queues (bluez appends only if last prepare write was to the
> same handle).
> 11) Test result fails cause expected value isn't the same as read.


Have you checked what went wrong with the value written? Perhaps this
is broken on the client side, afaik you do have a fix for that as
well? I imagine when you changed to do the aggregation only one write
will be send, so perhaps the client is not really appeding data using
the offset. Also if the characteristic do support AcquireWrite then
this whole thing is guaranteed not to work because writing to the pipe
fd does not support setting an offset currently, so perhaps that is
the real issue. Fixing that shall be possible using sendmsg and
setting the offset in the msg_control then the client has to read that
back with recvmsg.

> What's more, spec says"
> "If a Characteristic Value is prepared two or more times during this sub-
> procedure, then all prepared values are written to the same Characteristi=
c
> Value in the order that they were prepared." BLUETOOTH SPECIFICATION
> Version 5.0 | Vol 3, Part G (4.9.5)
>
> "Each client=E2=80=99s queued values are separate; the execution of one q=
ueue shall not
> affect the preparation or execution of any other client=E2=80=99s queued
> values." BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part F (3.4.6.1)
>
> Regards,
> Grzegorz
>
> 2018-04-19 17:11 GMT+02:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>> Hi Grzegorz,
>>
>> On Thu, Apr 19, 2018 at 5:03 PM, Grzegorz Kolodziejczyk
>> <grzegorz.kolodziejczyk@codecoup.pl> wrote:
>>> Multiple prepare writes may be done for multiple attributes. Queue
>>> mechanism must be aware of handle under which preparation is done.
>>> ---
>>>  src/shared/gatt-server.c | 15 ++++++++++++---
>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
>>> index 4b554f665..d1efa83a1 100644
>>> --- a/src/shared/gatt-server.c
>>> +++ b/src/shared/gatt-server.c
>>> @@ -1190,6 +1190,14 @@ static bool prep_data_new(struct bt_gatt_server =
*server,
>>>         return true;
>>>  }
>>>
>>> +static bool match_prep_attr_handle(const void *data, const void *match=
_data)
>>> +{
>>> +       const struct prep_write_data *prep_data =3D data;
>>> +       const uint16_t *match_handle =3D match_data;
>>> +
>>> +       return prep_data->handle =3D=3D *match_handle;
>>> +}
>>> +
>>>  static bool store_prep_data(struct bt_gatt_server *server,
>>>                                         uint16_t handle, uint16_t offse=
t,
>>>                                         uint16_t length, uint8_t *value=
)
>>> @@ -1200,9 +1208,10 @@ static bool store_prep_data(struct bt_gatt_serve=
r *server,
>>>          * Now lets check if prep write is a continuation of long write
>>>          * If so do aggregation of data
>>>          */
>>> -       prep_data =3D queue_peek_tail(server->prep_queue);
>>> -       if (prep_data && (prep_data->handle =3D=3D handle) &&
>>> -                       (offset =3D=3D (prep_data->length + prep_data->=
offset)))
>>> +       prep_data =3D queue_find(server->prep_queue, match_prep_attr_ha=
ndle,
>>> +                                                               &handle=
);
>>
>> If I got this right it is not that the code is broken, it just don't
>> group together the writes if there are other handles in the prepare
>> queue. Afaik that was done because the order we write the handles may
>> matter, so it is up to the remote stack to make the order proper if it
>> wants long writes to all be executed in sequence, or interleaved which
>> means we would have to store new chunks in the order they are
>> prepared.
>>
>>> +       if (prep_data && (offset =3D=3D (prep_data->length + prep_data-=
>offset)))
>>>                 return append_prep_data(prep_data, handle, length, valu=
e);
>>>
>>>         return prep_data_new(server, handle, offset, length, value);
>>> --
>>> 2.13.6
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoo=
th" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
