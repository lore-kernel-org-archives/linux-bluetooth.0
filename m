Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25SZZZ_Kb_cmJPetKpoTsLzBJk5wTLNmu40GUFEQQbx=FA@mail.gmail.com>
References: <1414425900-21784-1-git-send-email-luiz.dentz@gmail.com>
	<1414425900-21784-7-git-send-email-luiz.dentz@gmail.com>
	<CAHrH25SZZZ_Kb_cmJPetKpoTsLzBJk5wTLNmu40GUFEQQbx=FA@mail.gmail.com>
Date: Tue, 28 Oct 2014 11:14:14 +0200
Message-ID: <CABBYNZJDwL=VOEJi1YBwY+nF+TbiOSprQJX_1W1Lp91k6FRkFQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 7/9] shared/gatt-db: Add gatt_db_attribute_write
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Oct 27, 2014 at 8:43 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
>
>>
>> ---
>>  src/shared/gatt-db.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index acd2e9a..4ff7358 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -906,5 +906,20 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
>>                                         gatt_db_attribute_write_t func,
>>                                         void *user_data)
>>  {
>> -       return false;
>> +       if (!attrib)
>> +               return false;
>> +
>> +       if (offset > attrib->value_len ||
>> +                               len > (unsigned) (attrib->value_len - offset))
>> +               return false;
>
> Won't this incorrectly fail if the attribute value has a variable
> length? Quoted from Core v4.1 Vol 3 ATT: 3.4.5.1 Write Request: "If
> the attribute value has a variable length, then the attribute value
> shall be truncated or lengthened to match the length of the Attribute
> Value parameter". So we can't really make assumptions on value_len
> here.

True, the these check cannot be done here except if we store the value
and have some means to identify it use a variable length but I guess
we can leave this for later once we have a better understanding how
this API works in practice.

> Also, if the attribute value is being implemented by the higher layer,
> then won't the value_len field of the attribute structure be invalid
> in general? Unless we always cache the full value in the attribute
> structure based on the last time gatt-db invoked the read callback but
> then this would still incorrectly fail if we never read the attribute
> value beforehand.

I guess the idea here would be to store locally if no write callback
was provided, but you are right regarding value_len it cannot be used
like that, at least not without having some way to check that it is
valid.

> I think we can assume that all attributes that are created without a
> write callback are not writable. I think we should always delegate
> writes to a callback and just return false here if the callback was
> never set (this would mean that the attribute is not writable). The
> callback can perform the necessary offset and length checks as needed
> by the service it's implementing, so we wouldn't end up making any
> assumptions there.

Well this would make it read and write not consistent with each other
since on for read the callback is optional, btw I though about using
gatt_db_attribute_write exactly to fill values locally stored in the
db so read without callback would use it and if Im not mistaken we
perform the permissions check before calling write on Android so I
guess bt_gatt_server can do the same, we just need to make sure the
permissions used are the same so we can check them in bt_gatt_server
before reaches the callback with the possibility to bypass these
checks by not providing any permissions.

>> +
>> +       if (attrib->write_func) {
>> +               attrib->write_func(attrib->handle, offset, value, len, opcode,
>> +                                               bdaddr, attrib->user_data);
>> +               return true;
>> +       }
>> +
>> +       memcpy(&attrib->value[offset], value, len);
>> +
>> +       return true;
>>  }
>> --
>
> Cheers,
> Arman



-- 
Luiz Augusto von Dentz
