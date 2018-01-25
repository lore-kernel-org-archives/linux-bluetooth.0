Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <79ff061a-46ad-a0b9-70f6-16d407b9170f@jp.fujitsu.com>
References: <20180124130930.1539-1-luiz.dentz@gmail.com> <79ff061a-46ad-a0b9-70f6-16d407b9170f@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 Jan 2018 09:25:20 -0200
Message-ID: <CABBYNZ+kJqsau3n_9JAojqEC7vnafVM9nUwWHmiN8dP9P2cLdg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] obexd: Fix property Size of server transfer
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jan 25, 2018 at 2:43 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Luiz,
>
> Thanks for your great work.
>
> After applying this patch, on my box obexctl retrieves the Size property
> correctly even if it is run before starting to transfer a file.
>
>
> Regards,
> Eramoto
>
> On 01/24/2018 10:09 PM, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> OBJECT_SIZE_DELETE is shall not be consider a valid size.
>> ---
>>  obexd/src/manager.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
>> index 78b138c85..70265e445 100644
>> --- a/obexd/src/manager.c
>> +++ b/obexd/src/manager.c
>> @@ -377,7 +377,8 @@ static gboolean transfer_size_exists(const GDBusPropertyTable *property,
>>       struct obex_transfer *transfer = data;
>>       struct obex_session *session = transfer->session;
>>
>> -     return session->size != OBJECT_SIZE_UNKNOWN;
>> +     return (session->size != OBJECT_SIZE_UNKNOWN &&
>> +                             session->size != OBJECT_SIZE_DELETE);
>>  }
>>
>>  static gboolean transfer_get_size(const GDBusPropertyTable *property,
>> @@ -386,7 +387,8 @@ static gboolean transfer_get_size(const GDBusPropertyTable *property,
>>       struct obex_transfer *transfer = data;
>>       struct obex_session *session = transfer->session;
>>
>> -     if (session->size == OBJECT_SIZE_UNKNOWN)
>> +     if (session->size == OBJECT_SIZE_UNKNOWN ||
>> +                             session->size == OBJECT_SIZE_DELETE)
>>               return FALSE;
>>
>>       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT64, &session->size);
>>

Applied.


-- 
Luiz Augusto von Dentz
