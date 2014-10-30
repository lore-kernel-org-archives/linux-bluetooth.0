Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJLTA8gEuk+P+V+OhzA3H9LcsBWKf+rFYApP5BbDhctrORjDWA@mail.gmail.com>
References: <1414677465-19862-1-git-send-email-luiz.dentz@gmail.com>
	<1414677465-19862-9-git-send-email-luiz.dentz@gmail.com>
	<CAJLTA8gEuk+P+V+OhzA3H9LcsBWKf+rFYApP5BbDhctrORjDWA@mail.gmail.com>
Date: Thu, 30 Oct 2014 10:54:24 -0700
Message-ID: <CAHrH25RoARWR4+5uf3H+-8WOx1KZtdsJACy18eVRMiz2uw6p+w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 9/9] shared/gatt-db: Add gatt_db_attribute_get_end_handle
From: Arman Uguray <armansito@chromium.org>
To: Michael Janssen <jamuraa@google.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz & Michael,

> On Thu, Oct 30, 2014 at 10:17 AM, Michael Janssen <jamuraa@google.com> wrote:
> Hi Luiz,
>
> On Thu, Oct 30, 2014 at 6:57 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  src/shared/gatt-db.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>> index 60a1b23..74cd0be 100644
>> --- a/src/shared/gatt-db.c
>> +++ b/src/shared/gatt-db.c
>> @@ -841,7 +841,10 @@ uint16_t gatt_db_attribute_get_start_handle(struct gatt_db_attribute *attrib)
>>
>>  uint16_t gatt_db_attribute_get_end_handle(struct gatt_db_attribute *attrib)
>>  {
>> -       return 0;
>> +       if (!attrib)
>> +               return 0;
>> +
>> +       return attrib->handle + attrib->service->num_handles - 1;
>
> Is this right?  If I have a non-first handle (one created by
> gatt_db_add_characteristic) this will give me a handle off the end of
> the service. I'm not sure of the meaning of start/end handle here.
>

Good catch, the logic here is incorrect if attrib is not a service
declaration. I think this method should basically return the end
handle of the group the attribute belongs to. I don't know if this is
what Luiz originally intended but since the only two legitimate
attribute group types allowed by GATT are primary and secondary
service declarations, I take the end handle here to mean the
corresponding service end handle.

>>  }
>>
>>  const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib)
>> --
>> 1.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Michael Janssen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
Arman
