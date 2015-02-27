Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5548555.j9qucFdfti@uw000953>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1424943583-30061-16-git-send-email-lukasz.rymanowski@tieto.com>
	<5548555.j9qucFdfti@uw000953>
Date: Fri, 27 Feb 2015 16:14:42 +0100
Message-ID: <CAN_7+YYgLWbnbduJz1XazpEio3a69eqk33ZJhcwXgc_+6HK7SQ@mail.gmail.com>
Subject: Re: [PATCH 15/16] shared/gatt-helpers: Improve robustness read by
 type request
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Feb 27, 2015 at 4:07 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Łukasz,
>
> On Thursday 26 of February 2015 10:39:42 Lukasz Rymanowski wrote:
>> This patch makes sure that we do get into infinite loop when doing
>> read by type request.
>>
>> It could happen if we got bogus read by type response
>> ---
>>  src/shared/gatt-helpers.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
>> index 8858e58..6e5cf30 100644
>> --- a/src/shared/gatt-helpers.c
>> +++ b/src/shared/gatt-helpers.c
>> @@ -1331,10 +1331,22 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
>>       }
>>
>>       last_handle = get_le16(pdu + length - data_length);
>> +
>> +     /*
>> +      * If last handle is lower from previous start handle then it is smth
>> +      * wrong. Let's stop search, otherwise we might enter infinite loop.
>> +      */
>> +     if (last_handle < op->start_handle) {
>> +             success = true;
>> +             goto done;
>> +     }
>
> Shouldn't this be success = false ?

True, my bad. Can you fix that or should I send v2?
>
>> +
>> +     op->start_handle = last_handle + 1;
>> +
>>       if (last_handle != op->end_handle) {
>>               uint8_t pdu[4 + get_uuid_len(&op->uuid)];
>>
>> -             put_le16(last_handle + 1, pdu);
>> +             put_le16(op->start_handle, pdu);
>>               put_le16(op->end_handle, pdu + 2);
>>               bt_uuid_to_le(&op->uuid, pdu + 4);
>>
>> @@ -1376,6 +1388,7 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
>>       op->callback = callback;
>>       op->user_data = user_data;
>>       op->destroy = destroy;
>> +     op->start_handle = start;
>>       op->end_handle = end;
>>       op->uuid = *uuid;
>>
>>
>
> --
> Best regards,
> Szymon Janc
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
