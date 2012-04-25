Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120425090505.GA25179@x220>
References: <1335340311-25057-1-git-send-email-vishal.agarwal@stericsson.com>
	<20120425090505.GA25179@x220>
Date: Wed, 25 Apr 2012 15:29:27 +0530
Message-ID: <CA+_sZW-SWqjgyM7y-czsjdAw=d2T+0uvscGTvCXN4K87SYvXVw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: eir_append_data should take care of padding
From: vishal agarwal <vishal.bluez@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Apr 25, 2012 at 2:35 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Vishal,
>
> On Wed, Apr 25, 2012, Vishal Agarwal wrote:
>> EIR data received from controller might contain padding zeros.
>> In this case data should be appended in the starting of padding
>> instead of at the end of padding. Data added after the padding will
>> be discarded by user space.
>>
>> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
>> ---
>>  include/net/bluetooth/hci_core.h |   21 +++++++++++++++++----
>>  1 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index ef6e654..9e42e2b 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -938,11 +938,24 @@ static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
>>  static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
>>                                 u8 data_len)
>>  {
>> -     eir[eir_len++] = sizeof(type) + data_len;
>> -     eir[eir_len++] = type;
>> -     memcpy(&eir[eir_len], data, data_len);
>> -     eir_len += data_len;
>> +     u8 field_len;
>> +     size_t parsed = 0;
>> +
>> +     while (parsed < eir_len - 1) {
>> +             field_len = eir[0];
>>
>> +             if (field_len == 0) {
>> +                     eir[0] = sizeof(type) + data_len;
>> +                     eir[1] = type;
>> +                     memcpy(&eir[2], data, data_len);
>> +                     /* data_len + 1 byte for size + 1 byte for type */
>> +                     eir_len = parsed + data_len + 2;
>> +                     break;
>> +             }
>> +
>> +             parsed += field_len + 1;
>> +             eir += field_len + 1;
>> +     }
>>       return eir_len;
>
> I don't really see the point of this. The eir_len parameter passed to
> this function is supposed to be the length of the significant
> (non-padded) data. I.e. it should already indicate the start of the
> padded zeroes. If you see misuse of this somewhere please submit a patch
> for that instead.
>

In function mgmt_device_found, which is called from
hci_extended_inquiry_result_evt eir_append_data function is called
without taking care of padding bytes. I will create a new function
which will return the padding offset in the EIR data andit will be
called in function mgmt_device_found before calling the
eir_append_data function.

> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks
Vishal
