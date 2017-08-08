Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHgsZ+g50QQXF_tcM5kcqR00+EcdoGS=oEr+Ms4RZQNTX_9yfw@mail.gmail.com>
References: <20170804212552.185384-1-mcchou@chromium.org> <20170804221959.193552-1-mcchou@chromium.org>
 <CAHgsZ+g50QQXF_tcM5kcqR00+EcdoGS=oEr+Ms4RZQNTX_9yfw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Aug 2017 14:20:57 +0300
Message-ID: <CABBYNZKFXuetjWaxUUKAqqPqNGSF7j5_8kA04J13Knh3eTGvHw@mail.gmail.com>
Subject: Re: [PATCH] shared/gatt-db: Fix memory comparison error
To: Miao-chen Chou <mcchou@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        josephsih@chromium.org, Dmitry Grinberg <dmitrygr@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Miao,

On Tue, Aug 8, 2017 at 12:17 AM, Miao-chen Chou <mcchou@chromium.org> wrote:
> Hi,
>
> Please see the full description of the issue at
> https://bugs.chromium.org/p/chromium/issues/detail?id=748216#c4.
>
> Thanks,
> Miao
>
> On Fri, Aug 4, 2017 at 3:19 PM,  <mcchou@chromium.org> wrote:
>> From: Miao-chen Chou <mcchou@chromium.org>
>>
>> This fixes the use of memcmp where the length of comparison is longer than the
>> memories to be compared. Since unit/test-gatt make use of gatt-db, if compiled
>> with ASan, unit/test-gatt would fail.
>> ---
>>  src/shared/gatt-db.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index 8ef6f3bca..2dd73b997 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -1013,10 +1013,15 @@ static void find_by_type(void *data, void *user_data)
>>                         continue;
>>
>>                 /* TODO: fix for read-callback based attributes */
>> -               if (search_data->value && memcmp(attribute->value,
>> -                                                       search_data->value,
>> -                                                       search_data->value_len))
>> -                       continue;
>> +               if (search_data->value) {
>> +                       if (search_data->value_len != attribute->value_len)
>> +                               continue;
>> +
>> +                       if (memcmp(attribute->value, search_data->value,
>> +                                       search_data->value_len)) {
>> +                               continue;
>> +                       }
>> +               }
>>
>>                 search_data->num_of_res++;
>>                 search_data->func(attribute, search_data->user_data);
>> --
>> 2.14.0.rc1.383.gd1ce394fe2-goog
>>

Applied, thanks.

-- 
Luiz Augusto von Dentz
