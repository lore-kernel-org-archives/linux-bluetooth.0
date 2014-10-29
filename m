Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25QSxe2L7ixyiT30e19sLDQQ_MyXEH7qObTDmuCHFVbJPw@mail.gmail.com>
References: <1414513123-5689-1-git-send-email-luiz.dentz@gmail.com>
	<1414513123-5689-6-git-send-email-luiz.dentz@gmail.com>
	<CAHrH25QSxe2L7ixyiT30e19sLDQQ_MyXEH7qObTDmuCHFVbJPw@mail.gmail.com>
Date: Wed, 29 Oct 2014 11:15:11 +0200
Message-ID: <CABBYNZ+cJwcQFKtt0Tg5Cn7++2=X7SSz3sO_USEcCR20chwy_g@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] shared/gatt-db: Add gatt_db_attribute_read
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Oct 29, 2014 at 12:20 AM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
> On Tue, Oct 28, 2014 at 9:18 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  src/shared/gatt-db.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index f43cac3..b5b6c72 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -891,7 +891,23 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>>                                 uint8_t opcode, bdaddr_t *bdaddr,
>>                                 gatt_db_attribute_read_t func, void *user_data)
>>  {
>> -       return false;
>> +       if (!attrib || !func)
>> +               return false;
>> +
>> +       if (attrib->read_func) {
>> +               attrib->read_func(attrib->handle, offset, opcode, bdaddr,
>> +                                                       attrib->user_data);
>> +               return true;
>> +       }
>> +
>> +       /* Check length boundary if value is stored in the db */
>> +       if (offset >= attrib->value_len)
>> +               return false;
>
> Thanks for moving this after the callback check. As for valid
> boundaries, I've actually seen devices that allow sending an offset
> that is the same as the length of the value. They just return an empty
> value PDU back. So maybe return NULL for the value if offset ==
> attrib->value_len? What I had in mind was:

But then this would be valid for any offset past value_len doesn't it
or this is specific to determine the side of the value, in the other
hand there does exist an error for invalid offset which I thought
would be preferable, well if we can distinct this error which
currently we do not because of the bool return.

>   if (offset > attrib->value_len)
>       return false;
>
>   func(attrib, 0, (offset == attrib->value_len) ? NULL :
> &attrib->value[offset], ...);
>
>   return true;
>
> Then we would guard against the invalid access but the large offset
> would still be a valid. I guess it really comes down to what we
> consider to be a "valid" offset but I've seen implementations that do
> this. Up to you.
>
>> +
>> +       func(attrib, 0, &attrib->value[offset], attrib->value_len - offset,
>> +                                                               user_data);
>> +
>> +       return true;
>>  }
>>
>>  bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>> --
>> 1.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Cheers,
> Arman



-- 
Luiz Augusto von Dentz
