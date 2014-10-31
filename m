Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25RoARWR4+5uf3H+-8WOx1KZtdsJACy18eVRMiz2uw6p+w@mail.gmail.com>
References: <1414677465-19862-1-git-send-email-luiz.dentz@gmail.com>
	<1414677465-19862-9-git-send-email-luiz.dentz@gmail.com>
	<CAJLTA8gEuk+P+V+OhzA3H9LcsBWKf+rFYApP5BbDhctrORjDWA@mail.gmail.com>
	<CAHrH25RoARWR4+5uf3H+-8WOx1KZtdsJACy18eVRMiz2uw6p+w@mail.gmail.com>
Date: Fri, 31 Oct 2014 13:07:45 +0200
Message-ID: <CABBYNZJrc=604-qTnBO8qJFWwgxOeniJ=MPa5LV+=vNto8iMSA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 9/9] shared/gatt-db: Add gatt_db_attribute_get_end_handle
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: Michael Janssen <jamuraa@google.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Thu, Oct 30, 2014 at 7:54 PM, Arman Uguray <armansito@chromium.org> wrote:
> Hi Luiz & Michael,
>
>> On Thu, Oct 30, 2014 at 10:17 AM, Michael Janssen <jamuraa@google.com> wrote:
>> Hi Luiz,
>>
>> On Thu, Oct 30, 2014 at 6:57 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> ---
>>>  src/shared/gatt-db.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>>> index 60a1b23..74cd0be 100644
>>> --- a/src/shared/gatt-db.c
>>> +++ b/src/shared/gatt-db.c
>>> @@ -841,7 +841,10 @@ uint16_t gatt_db_attribute_get_start_handle(struct gatt_db_attribute *attrib)
>>>
>>>  uint16_t gatt_db_attribute_get_end_handle(struct gatt_db_attribute *attrib)
>>>  {
>>> -       return 0;
>>> +       if (!attrib)
>>> +               return 0;
>>> +
>>> +       return attrib->handle + attrib->service->num_handles - 1;
>>
>> Is this right?  If I have a non-first handle (one created by
>> gatt_db_add_characteristic) this will give me a handle off the end of
>> the service. I'm not sure of the meaning of start/end handle here.
>>
>
> Good catch, the logic here is incorrect if attrib is not a service
> declaration. I think this method should basically return the end
> handle of the group the attribute belongs to. I don't know if this is
> what Luiz originally intended but since the only two legitimate
> attribute group types allowed by GATT are primary and secondary
> service declarations, I take the end handle here to mean the
> corresponding service end handle.

Yep, I think I will change this to
gatt_db_attribute_get_service_handles(attrib, start_handle,
end_handle) the original code had this as gatt_db_get_end_handle which
don't mention it is service handles we are talking about.


-- 
Luiz Augusto von Dentz
