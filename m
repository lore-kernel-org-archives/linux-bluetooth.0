Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJZnjMEpdnzmsdRb6_8v+yp9SpHuBkBLSop9=ggagA-Zg@mail.gmail.com>
References: <1427470759-30114-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<1427470759-30114-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
	<CAMv5GbdTE9btr_CE=3czJPH6axVE36F25NswSjEoVG+nVX5d+A@mail.gmail.com>
	<CABBYNZJZnjMEpdnzmsdRb6_8v+yp9SpHuBkBLSop9=ggagA-Zg@mail.gmail.com>
Date: Mon, 30 Mar 2015 11:38:10 +0200
Message-ID: <CAMv5GbdBTQ+P5C0yxsHb3B2NCd69Ls9AsDjKTQSiFetBegEbhQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] shared/gatt-db: Use bt_uuid_to_le instead of local function
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 30 March 2015 at 09:49, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Grzegorz,
>
> On Fri, Mar 27, 2015 at 5:42 PM, Grzegorz Kolodziejczyk
> <grzegorz.kolodziejczyk@tieto.com> wrote:
>> Hi,
>>
>> One more comment here.
>>
>> On 27 March 2015 at 16:39, Grzegorz Kolodziejczyk
>> <grzegorz.kolodziejczyk@tieto.com> wrote:
>>> This patch use lib/uuid library for uuids instead of local functions.
>>> ---
>>>  src/shared/gatt-db.c | 36 ++++++++++++++++++------------------
>>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
>>> index 2b2090c..323ce91 100644
>>> --- a/src/shared/gatt-db.c
>>> +++ b/src/shared/gatt-db.c
>>> @@ -335,20 +335,6 @@ bool gatt_db_isempty(struct gatt_db *db)
>>>         return queue_isempty(db->services);
>>>  }
>>>
>>> -static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
>>> -{
>>> -       bt_uuid_t uuid128;
>>> -
>>> -       if (uuid->type == BT_UUID16) {
>>> -               put_le16(uuid->value.u16, dst);
>>> -               return bt_uuid_len(uuid);
>>> -       }
>>> -
>>> -       bt_uuid_to_uuid128(uuid, &uuid128);
>>> -       bswap_128(&uuid128.value.u128, dst);
>>> -       return bt_uuid_len(&uuid128);
>>> -}
>>> -
>>>  static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t *uuid)
>>>  {
>>>         uint128_t u128;
>>> @@ -379,8 +365,8 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
>>>  {
>>>         struct gatt_db_service *service;
>>>         const bt_uuid_t *type;
>>> +       bt_uuid_t uuid128;
>>>         uint8_t value[16];
>>> -       uint16_t len;
>>>
>>>         if (num_handles < 1)
>>>                 return NULL;
>>> @@ -400,10 +386,23 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
>>>         else
>>>                 type = &secondary_service_uuid;
>>>
>>> -       len = uuid_to_le(uuid, value);
>>> +       switch (uuid->type) {
>>> +       case BT_UUID16:
>>> +       case BT_UUID128:
>>> +               bt_uuid_to_le(uuid, value);
>>> +               break;
>>> +       case BT_UUID32:
>>> +               bt_uuid_to_uuid128(uuid, &uuid128);
>>> +               bt_uuid_to_le(&uuid128, value);
>
> bt_uuid_to_le already does this conversion, so this switch is not
> actually needed.
>
lib/uuid library is only gatt oriented ? Specification 2.5.4 - says
that "All 32-bit UUIDs shall be converted to 128-bit UUIDs when the
UUID is contained in an ATT PDU". I've sent patch, few minutes ago
which changes functionality of bt_uuid_to_le. I think it should only
convert value to le order.
>>> +               break;
>>> +       case BT_UUID_UNSPEC:
>>> +       default:
>>> +               gatt_db_service_destroy(service);
>>> +               return NULL;
>>> +       }
>> I'm not sure if we should generally handle 32bit uuids.
>>>
>>>         service->attributes[0] = new_attribute(service, handle, type, value,
>>> -                                                                       len);
>>> +                                                               uuid->type/8);
>
> Maybe we should make bt_uuid_to_le return how much it has written so
> we don't have to guess with uuid->type / 8.
>
Yes, I agree.
>>>         if (!service->attributes[0]) {
>>>                 gatt_db_service_destroy(service);
>>>                 return NULL;
>>> @@ -698,7 +697,8 @@ service_insert_characteristic(struct gatt_db_service *service,
>>>         /* We set handle of characteristic value, which will be added next */
>>>         put_le16(handle, &value[1]);
>>>         len += sizeof(uint16_t);
>>> -       len += uuid_to_le(uuid, &value[3]);
>>> +       len += uuid->type/8;
>>> +       bt_uuid_to_le(uuid, &value[3]);
>>>
>>>         service->attributes[i] = new_attribute(service, handle - 1,
>>>                                                         &characteristic_uuid,
>>> --
>>> 2.1.0
>>>
>>
>> BR,
>> Grzegorz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz

BR,
Grzegorz
