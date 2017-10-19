Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLZFNkS9KNAyOmuFhrQS7jW6sCq9WtbWj_GEmUqzO=SAA@mail.gmail.com>
References: <CAOVXOEbDLdQ75i4=1rNW+8TP5TkN8ounvf=nKm5xQbbf2efNZQ@mail.gmail.com>
 <66df77f7-90e1-ff00-3aa0-51a82d3c4351@jp.fujitsu.com> <CABBYNZLZFNkS9KNAyOmuFhrQS7jW6sCq9WtbWj_GEmUqzO=SAA@mail.gmail.com>
From: Michael Simon <michael.simon.at@gmail.com>
Date: Thu, 19 Oct 2017 22:53:51 +0200
Message-ID: <CAOVXOEbvA=4n1GgGJsZkDDR-mFaEJQiyZQ+nAKJ8E5tSu3A90w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] dbus: Fix for unused parameter in WriteValue
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


2017-10-19 10:22 GMT+02:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi Michael,
>
> On Tue, Oct 17, 2017 at 7:30 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> Hi Michael,
>>
>> On 10/16/2017 10:47 PM, Michael Simon wrote:
>>> The glib iterator was not moved to the second array,
>>> which contains the parameter.
>>> ---
>>>  src/gatt-client.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/src/gatt-client.c b/src/gatt-client.c
>>> index 32b3a87..58f14b8 100644
>>> --- a/src/gatt-client.c
>>> +++ b/src/gatt-client.c
>>> @@ -596,6 +596,8 @@ static DBusMessage
>>> *descriptor_write_value(DBusConnection *conn,
>>>         if (parse_value_arg(&iter, &value, &value_len))
>>>                 return btd_error_invalid_args(msg);
>>>
>>> +        dbus_message_iter_next (&iter);
>>> +
>>>         if (parse_options(&iter, &offset))
>>>                 return btd_error_invalid_args(msg);
>>>
>>> @@ -986,6 +988,8 @@ static DBusMessage
>>> *characteristic_write_value(DBusConnection *conn,
>>>         if (parse_value_arg(&iter, &value, &value_len))
>>>                 return btd_error_invalid_args(msg);
>>>
>>> +        dbus_message_iter_next (&iter);
>>> +
>>>         if (parse_options(&iter, &offset))
>>>                 return btd_error_invalid_args(msg);
>>>
>>
>> This patch can not be applied, and the following messages output:
>>
>>   Applying: dbus: Fix for unused parameter in WriteValue
>>   fatal: corrupt patch at line 10
>>   Patch failed at 0001 dbus: Fix for unused parameter in WriteValue
>>
>> Since this patch perhaps has extra line feeds and uses spaces as indent.
>
> I went ahead pushed the patch after fixing the patch myself, not sure
> why the patch got malformed perhaps your mail client is mangling it or
> something.
>
> --
> Luiz Augusto von Dentz

thanks for fixing this.
I will try to find out what went wrong, my guess would be that
something went wrong as i copied the text from the virtual machine to
the host.

Regards,
Michael
