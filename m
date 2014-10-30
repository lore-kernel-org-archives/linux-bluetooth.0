Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25Sr5LmHv_QcNjrfX78ak1d0z+0B_n5Yc4-ZQm-DG_nE7w@mail.gmail.com>
References: <1414513123-5689-1-git-send-email-luiz.dentz@gmail.com>
	<1414513123-5689-6-git-send-email-luiz.dentz@gmail.com>
	<CAHrH25QSxe2L7ixyiT30e19sLDQQ_MyXEH7qObTDmuCHFVbJPw@mail.gmail.com>
	<CABBYNZ+cJwcQFKtt0Tg5Cn7++2=X7SSz3sO_USEcCR20chwy_g@mail.gmail.com>
	<CAHrH25Sr5LmHv_QcNjrfX78ak1d0z+0B_n5Yc4-ZQm-DG_nE7w@mail.gmail.com>
Date: Thu, 30 Oct 2014 15:44:50 +0200
Message-ID: <CABBYNZ+hDAsTUv+Eu+a59nMJME7zTfy_EzrZ3BHDPPeSsMm-=Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] shared/gatt-db: Add gatt_db_attribute_read
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Oct 29, 2014 at 4:59 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
> On Wed, Oct 29, 2014 at 2:15 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Arman,
>>
>> On Wed, Oct 29, 2014 at 12:20 AM, Arman Uguray <armansito@chromium.org> wrote:
>>> Hi Luiz,
>>>
>>> On Tue, Oct 28, 2014 at 9:18 AM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>
>>>> ---
>>>>  src/shared/gatt-db.c | 18 +++++++++++++++++-
>>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>>>> index f43cac3..b5b6c72 100644
>>>> --- a/src/shared/gatt-db.c
>>>> +++ b/src/shared/gatt-db.c
>>>> @@ -891,7 +891,23 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
>>>>                                 uint8_t opcode, bdaddr_t *bdaddr,
>>>>                                 gatt_db_attribute_read_t func, void *user_data)
>>>>  {
>>>> -       return false;
>>>> +       if (!attrib || !func)
>>>> +               return false;
>>>> +
>>>> +       if (attrib->read_func) {
>>>> +               attrib->read_func(attrib->handle, offset, opcode, bdaddr,
>>>> +                                                       attrib->user_data);
>>>> +               return true;
>>>> +       }
>>>> +
>>>> +       /* Check length boundary if value is stored in the db */
>>>> +       if (offset >= attrib->value_len)
>>>> +               return false;
>>>
>>> Thanks for moving this after the callback check. As for valid
>>> boundaries, I've actually seen devices that allow sending an offset
>>> that is the same as the length of the value. They just return an empty
>>> value PDU back. So maybe return NULL for the value if offset ==
>>> attrib->value_len? What I had in mind was:
>>
>> But then this would be valid for any offset past value_len doesn't it
>> or this is specific to determine the side of the value, in the other
>> hand there does exist an error for invalid offset which I thought
>> would be preferable, well if we can distinct this error which
>> currently we do not because of the bool return.
>>
>
> So for your first point, the offset should be valid for the side of
> the value only but invalid beyond that. E.g. the CSR uEnergy device I
> have does the following:
>
>    offset == value_len - 1 --->  result is 1 byte (the last byte)
>    offset == value_len ---> result is 0 bytes
>    offset > value_len ---> result is ERROR_INVALID_OFFSET
>
> I'm not exactly sure if the spec dictates that it be this way but this
> is how I've seen several devices behave.
>
> As for the bool return problem, maybe we can report the error in the
> callback instead? When the read is being handled by read_func, we will
> use the "err" argument gatt_db_attribute_read_t to report ATT errors
> in the future, so maybe we should do the same here. If the offset is
> invalid, we call func(attrib, BT_ATT_ERROR_INVALID_OFFSET, NULL, 0,
> user_data); and return true.

Fair enough, I will fix it in v3.

-- 
Luiz Augusto von Dentz
