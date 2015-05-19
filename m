Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLWJqRsJ-2kYkKjSFUvSDbHdibX+KTDWMKcDSQhsrkwiA@mail.gmail.com>
References: <1431696620-4762-1-git-send-email-luiz.dentz@gmail.com>
	<CAJLTA8gcGVoRaHpiYzLNBgYjZFGGdocnt=g0rZ+qh9S34X2eFA@mail.gmail.com>
	<CAJLTA8jZi=f-Eh5n1EmQjf3z8BJ_kRjB9t8q1EfAvP8OZM-FQg@mail.gmail.com>
	<CABBYNZKHn0dLOrO3NR6rWukt6ZxTwUdBwA8Pzt3j5_Ucej5nsg@mail.gmail.com>
	<CAJLTA8iMwgXkEtMgEejWuHrUiDsaQsN5UXqxXMi_YpisfZqnEw@mail.gmail.com>
	<CABBYNZLWJqRsJ-2kYkKjSFUvSDbHdibX+KTDWMKcDSQhsrkwiA@mail.gmail.com>
Date: Tue, 19 May 2015 10:41:12 -0700
Message-ID: <CAJLTA8ipsGK65jOW0F2oWiSHb21xRB2WxCBkwV-XncxsufimVg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/ad: Replace data if already exists
From: Marie Janssen <jamuraa@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, May 19, 2015 at 10:35 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Marie,
>
> On Tue, May 19, 2015 at 8:16 PM, Marie Janssen <jamuraa@chromium.org> wrote:
>> Hi Luiz,
>>
>> On Mon, May 18, 2015 at 4:14 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Marie,
>>>
>>> On Fri, May 15, 2015 at 7:04 PM, Marie Janssen <jamuraa@chromium.org> wrote:
>>>> On Fri, May 15, 2015 at 9:02 AM, Marie Janssen <jamuraa@chromium.org> wrote:
>>>>> Hi Luiz,
>>>>>
>>>>> On Fri, May 15, 2015 at 6:30 AM, Luiz Augusto von Dentz
>>>>> <luiz.dentz@gmail.com> wrote:
>>>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>>>
>>>>>> If either manufacturer or service data already exist but the content
>>>>>> is different replace with the new data.
>>>>>> ---
>>>>>>  src/shared/ad.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>>>>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/src/shared/ad.c b/src/shared/ad.c
>>>>>> index 00d138d..dfc6b9a 100644
>>>>>> --- a/src/shared/ad.c
>>>>>> +++ b/src/shared/ad.c
>>>>>> @@ -431,6 +431,14 @@ void bt_ad_clear_service_uuid(struct bt_ad *ad)
>>>>>>         queue_remove_all(ad->service_uuids, NULL, NULL, free);
>>>>>>  }
>>>>>>
>>>>>> +static bool manufacturer_id_data_match(const void *data, const void *user_data)
>>>>>> +{
>>>>>> +       const struct bt_ad_manufacturer_data *m = data;
>>>>>> +       uint16_t id = PTR_TO_UINT(user_data);
>>>>>> +
>>>>>> +       return m->manufacturer_id == id;
>>>>>> +}
>>>>>> +
>>>>>>  bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
>>>>>>                                                         void *data, size_t len)
>>>>>>  {
>>>>>> @@ -442,6 +450,17 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
>>>>>>         if (len > (MAX_ADV_DATA_LEN - 2 - sizeof(uint16_t)))
>>>>>>                 return false;
>>>>>>
>>>>>> +       new_data = queue_find(ad->manufacturer_data, manufacturer_id_data_match,
>>>>>> +                                               UINT_TO_PTR(manufacturer_id));
>>>>>> +       if (new_data) {
>>>>>> +               if (new_data->len == len && !memcmp(new_data->data, data, len))
>>>>>> +                       return false;
>>>>>
>>>>> I don't think we want this check. If the data is different but length
>>>>> the same, we still want to update the data.
>>>>
>>>> Sorry I read this wrong.  We would want to return true here because
>>>> the data in the ad is as expected.
>>>
>>> This is to prevent emitting duplicated signals since in fact it did
>>> not change anything.
>>>
>>
>> Previously the false return value meant that some error had occurred,
>> such as memory allocation failure or the data being too long for the
>> ad.  Having nothing change and the ad be basically intact seems like
>> not a problem.  I guess this is a API semantics question, whether a
>> true return value means "the data is set correctly" vs "the data is
>> updated".
>
> While this is true there is also the convenience side of things, lets
> say we return true then I will need to check if the same data exists
> before calling this function because otherwise I can't tell if
> anything has changed and that basically means we have 2 checks instead
> of one. Beside the action here is to some data, if we are not adding
> or replacing anything Id say returning false is fine, btw if you look
> at the blocks Im removing that is already the behavior we have.
>

All right, this makes sense then I don't have any problems with it otherwise.

>>>>>> +               new_data->data = realloc(new_data->data, len);
>>>>>> +               memcpy(new_data->data, data, len);
>>>>>> +               new_data->len = len;
>>>>>> +               return true;
>>>>>> +       }
>>>>>> +
>>>>>>         new_data = new0(struct bt_ad_manufacturer_data, 1);
>>>>>>         if (!new_data)
>>>>>>                 return false;
>>>>>> @@ -458,11 +477,6 @@ bool bt_ad_add_manufacturer_data(struct bt_ad *ad, uint16_t manufacturer_id,
>>>>>>
>>>>>>         new_data->len = len;
>>>>>>
>>>>>> -       if (bt_ad_has_manufacturer_data(ad, new_data)) {
>>>>>> -               manuf_destroy(new_data);
>>>>>> -               return false;
>>>>>> -       }
>>>>>> -
>>>>>>         if (queue_push_tail(ad->manufacturer_data, new_data))
>>>>>>                 return true;
>>>>>>
>>>>>> @@ -556,6 +570,15 @@ void bt_ad_clear_solicit_uuid(struct bt_ad *ad)
>>>>>>         queue_remove_all(ad->solicit_uuids, NULL, NULL, free);
>>>>>>  }
>>>>>>
>>>>>> +
>>>>>> +static bool service_uuid_match(const void *data, const void *user_data)
>>>>>> +{
>>>>>> +       const struct bt_ad_service_data *s = data;
>>>>>> +       const bt_uuid_t *uuid = user_data;
>>>>>> +
>>>>>> +       return bt_uuid_cmp(&s->uuid, uuid);
>>>>>> +}
>>>>>> +
>>>>>>  bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
>>>>>>                                                                 size_t len)
>>>>>>  {
>>>>>> @@ -567,6 +590,16 @@ bool bt_ad_add_service_data(struct bt_ad *ad, const bt_uuid_t *uuid, void *data,
>>>>>>         if (len > (MAX_ADV_DATA_LEN - 2 - (size_t)bt_uuid_len(uuid)))
>>>>>>                 return false;
>>>>>>
>>>>>> +       new_data = queue_find(ad->service_uuids, service_uuid_match, uuid);
>>>>>> +       if (new_data) {
>>>>>> +               if (new_data->len == len && !memcmp(new_data->data, data, len))
>>>>>> +                       return false;
>>>>>
>>>>> Similarly here as from above, it would be better to replace the data.
>>>>>
>>>>>> +               new_data->data = realloc(new_data->data, len);
>>>>>> +               memcpy(new_data->data, data, len);
>>>>>> +               new_data->len = len;
>>>>>> +               return true;
>>>>>> +       }
>>>>>> +
>>>>>>         new_data = new0(struct bt_ad_service_data, 1);
>>>>>>         if (!new_data)
>>>>>>                 return false;
>>>>>> --
>>>>>> 2.1.0
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Marie Janssen
>>>
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Marie Janssen
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Marie Janssen
