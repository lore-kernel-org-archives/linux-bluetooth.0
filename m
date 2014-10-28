Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25RYSNwQWc0byw2LSB9mcGtw7ND5F2cL9+T64-_3KJv+gg@mail.gmail.com>
References: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
	<1414425900-21784-6-git-send-email-luiz.dentz@gmail.com>
	<CAHrH25RYSNwQWc0byw2LSB9mcGtw7ND5F2cL9+T64-_3KJv+gg@mail.gmail.com>
Date: Tue, 28 Oct 2014 18:04:42 +0200
Message-ID: <CABBYNZKkJ5cy7gFL85V6sQbnJZDyK2rWRKsPwHVNTyw+PHBqbQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 6/9] shared/gatt-db: Add gatt_db_attribute_read
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Oct 27, 2014 at 8:46 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
>>
>> ---
>>  src/shared/gatt-db.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index 9ead5e3..acd2e9a 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -882,7 +882,22 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>>                                 uint8_t opcode, bdaddr_t *bdaddr,
>>                                 gatt_db_attribute_read_t func, void *user_data)
>>  {
>> -       return false;
>> +       if (!attrib || !func)
>> +               return false;
>> +
>> +       if (offset > attrib->value_len)
>> +               return false;
>> +
>> +       if (attrib->read_func) {
>> +               attrib->read_func(attrib->handle, offset, opcode, bdaddr,
>> +                                                       attrib->user_data);
>> +               return true;
>> +       }
>> +
>> +       func(attrib, 0, &attrib->value[offset], attrib->value_len - offset,
>> +                                                               user_data);
>
> Wouldn't this potentially cause an invalid access if value_len ==
> offset? I would just do a check here and pass NULL to func if that's
> the case.

Yep, thanks to point it out, I actually pushed the boundary check
after the callback check if the value is not stored in the db itself.

>> +
>> +       return true;
>>  }
>>
>>  bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>> --
>
> Cheers,
> Arman



-- 
Luiz Augusto von Dentz
