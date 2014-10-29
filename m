Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25SZshncGdAC7ECLq0XYs81R1HHkNOp_HNhA3Z9G-+w96g@mail.gmail.com>
References: <1414513123-5689-1-git-send-email-luiz.dentz@gmail.com>
	<1414513123-5689-2-git-send-email-luiz.dentz@gmail.com>
	<CAHrH25SZshncGdAC7ECLq0XYs81R1HHkNOp_HNhA3Z9G-+w96g@mail.gmail.com>
Date: Wed, 29 Oct 2014 10:36:34 +0200
Message-ID: <CABBYNZJeyN6hMYmtH3M3A8JdG2sOPc9_fXKUwmj0oiXwNuhhBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] shared/gatt-db: Add gatt_db_get_attribute
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Tue, Oct 28, 2014 at 11:59 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz,
>
> On Tue, Oct 28, 2014 at 9:18 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  src/shared/gatt-db.c | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index 19784d1..bfc7bfa 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -806,7 +806,25 @@ bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
>>  struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
>>                                                         uint16_t handle)
>>  {
>> -       return NULL;
>> +       struct gatt_db_service *service;
>> +       uint16_t service_handle;
>> +
>> +       if (!db || !handle)
>> +               return NULL;
>> +
>> +       service = queue_find(db->services, find_service_for_handle,
>> +                                                       INT_TO_PTR(handle));
>
> Shouldn't this be UINT_TO_PTR?

Yep, apparently it was broken in the original code as well, I will fix them.

>
>> +       if (!service)
>> +               return NULL;
>> +
>> +       service_handle = service->attributes[0]->handle;
>> +
>> +       /*
>> +        * We can safely get attribute from attributes array with offset,
>> +        * because find_service_for_handle() check if given handle is
>> +        * in service range.
>> +        */
>> +       return service->attributes[handle - service_handle];
>>  }
>>
>>  uint16_t gatt_db_attribute_get_start_handle(struct gatt_db_attribute *attrib)
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
