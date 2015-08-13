Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <000601d0d5a6$bf7e3070$3e7a9150$@samsung.com>
References: <1439282325-24882-1-git-send-email-gowtham.ab@samsung.com>
	<000601d0d5a6$bf7e3070$3e7a9150$@samsung.com>
Date: Thu, 13 Aug 2015 15:39:05 +0300
Message-ID: <CABBYNZJxe7SO4cnRX_SMisY+hM0=M+Pg_ACJSJ_sOeNbkEGTtg@mail.gmail.com>
Subject: Re: [PATCH v1] gatt-database: Return meaningful ecodes for ccc write
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Thu, Aug 13, 2015 at 12:01 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Ping.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Tuesday, August 11, 2015 2:09 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: bharat.panda@samsung.com; Gowtham Anandha Babu
>> Subject: [PATCH v1] gatt-database: Return meaningful ecodes for ccc write
>>
>> Removed generic ATT protocol error codes and added Common Profile and
>> Service Error Codes.
>> ---
>>  src/gatt-database.c | 12 +++---------
>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/src/gatt-database.c b/src/gatt-database.c index
> 69a814d..91aba2f
>> 100644
>> --- a/src/gatt-database.c
>> +++ b/src/gatt-database.c
>> @@ -1783,22 +1783,16 @@ static uint8_t ccc_write_cb(uint16_t value, void
>> *user_data)
>>               return 0;
>>       }
>>
>> -     /*
>> -      * TODO: All of the errors below should fall into the so called
>> -      * "Application Error" range. Since there is no well defined error
> for
>> -      * these, we return a generic ATT protocol error for now.
>> -      */
>> -
>>       if (chrc->ntfy_cnt == UINT_MAX) {
>>               /* Maximum number of per-device CCC descriptors
>> configured */
>> -             return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
>> +             return BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
>>       }
>>
>>       /* Don't support undefined CCC values yet */
>>       if (value > 2 ||
>>               (value == 1 && !(chrc->props &
>> BT_GATT_CHRC_PROP_NOTIFY)) ||
>>               (value == 2 && !(chrc->props &
>> BT_GATT_CHRC_PROP_INDICATE)))
>> -             return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
>> +             return BT_ERROR_CCC_IMPROPERLY_CONFIGURED;
>>
>>       /*
>>        * Always call StartNotify for an incoming enable and ignore the
>> return @@ -1807,7 +1801,7 @@ static uint8_t ccc_write_cb(uint16_t value,
>> void *user_data)
>>       if (g_dbus_proxy_method_call(chrc->proxy,
>>                                               "StartNotify", NULL, NULL,
>>                                               NULL, NULL) == FALSE)
>> -             return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
>> +             return BT_ATT_ERROR_UNLIKELY;
>>
>>       __sync_fetch_and_add(&chrc->ntfy_cnt, 1);
>>
>> --
>> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
