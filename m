Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+7_aSpaaZKuwEF8S3vukn6S1bKZZWf2BO3A7s5TWZBSQ@mail.gmail.com>
References: <1415102382-18458-1-git-send-email-luiz.dentz@gmail.com>
	<CAHrH25TVqxJ_gE9D0TmwxKpf7FXZdyLnC54LDn3nn-snqRK28Q@mail.gmail.com>
	<CABBYNZ+7_aSpaaZKuwEF8S3vukn6S1bKZZWf2BO3A7s5TWZBSQ@mail.gmail.com>
Date: Wed, 5 Nov 2014 14:10:45 -0800
Message-ID: <CAHrH25QTnTy-7V-hXc26Uis6=cPQn7KQuc28tCrDsY3A6T38Rg@mail.gmail.com>
Subject: Re: [RFC v2 BlueZ] shared/gatt-db: Rework API
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Wed, Nov 5, 2014 at 6:00 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Tue, Nov 4, 2014 at 9:25 PM, Arman Uguray <armansito@chromium.org> wrote:
>>> +static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
>>> +                                       const uint8_t *value, size_t length,
>>> +                                       void *user_data)
>>> +{
>>> +       struct iovec *iov = user_data;
>>> +
>>> +       iov->iov_base = (void *) value;
>>> +       iov->iov_len = length;
>>
>> I guess now we're depending on the fact that this code will execute
>> before gatt_db_attribute_read returns below. I would have this
>> function drive the state machine instead, since we wouldn't want this
>> code to break in case we ever decide to execute this via an idle
>> callback in gatt-db.
>
> This one we will probably have to figure out later otherwise I will
> have to change quite a lot in read_by_grp_type_cb since it will
> probably not be possible to respond directly, instead we need to wait
> the reads to complete, I really want to avoid unnecessary changes
> because this patch will be quite big.
>

Sounds good to me. I'll probably end up doing this refactor anyway, so
don't worry about it.

>>> +}
>>> +
>>>  static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
>>>                                                 uint16_t mtu,
>>>                                                 uint8_t *pdu, uint16_t *len)
>>>  {
>>>         int iter = 0;
>>>         uint16_t start_handle, end_handle;
>>> -       uint8_t *value;
>>> -       int value_len;
>>> +       struct iovec value;
>>>         uint8_t data_val_len;
>>>
>>>         *len = 0;
>>>
>>>         while (queue_peek_head(q)) {
>>> -               start_handle = PTR_TO_UINT(queue_pop_head(q));
>>> -               value = NULL;
>>> -               value_len = 0;
>>> +               struct gatt_db_attribute *attrib = queue_pop_head(q);
>>> +
>>> +               value.iov_base = NULL;
>>> +               value.iov_len = 0;
>>>
>>>                 /*
>>>                  * This should never be deferred to the read callback for
>>>                  * primary/secondary service declarations.
>>>                  */
>>> -               if (!gatt_db_read(db, start_handle, 0,
>>> +               if (!gatt_db_attribute_read(attrib, 0,
>>>                                                 BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
>>> -                                               NULL, &value,
>>> -                                               &value_len) || value_len < 0)
>>> +                                               NULL, attribute_read_cb,
>>> +                                               &value) || !value.iov_len)
>>>                         return false;
>>>
>>>                 /*
>>> @@ -124,21 +136,22 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
>>>                  * value is seen.
>>>                  */
>>>                 if (iter == 0) {
>>> -                       data_val_len = value_len;
>>> +                       data_val_len = value.iov_len;
>>>                         pdu[0] = data_val_len + 4;
>>>                         iter++;
>>> -               } else if (value_len != data_val_len)
>>> +               } else if (value.iov_len != data_val_len)
>>>                         break;
>>>
>>>                 /* Stop if this unit would surpass the MTU */
>>>                 if (iter + data_val_len + 4 > mtu)
>>>                         break;
>>>
>>> -               end_handle = gatt_db_get_end_handle(db, start_handle);
>>> +               gatt_db_attribute_get_service_handles(attrib, &start_handle,
>>> +                                                               &end_handle);
>>>
>>>                 put_le16(start_handle, pdu + iter);
>>>                 put_le16(end_handle, pdu + iter + 2);
>>> -               memcpy(pdu + iter + 4, value, value_len);
>>> +               memcpy(pdu + iter + 4, value.iov_base, value.iov_len);
>>>
>>>                 iter += data_val_len + 4;
>>>         }
>>> --
>>> 1.9.3
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> Apart from the few comments that I left above, I'm fine with this. Let
>> me know when you've decided to go ahead with it and I'll start
>> rebasing my work on top of your patch right away since I don't depend
>> on the android/gatt changes that you'll have to make.
>>
>> Cheers,
>> Arman
>
>
>
> --
> Luiz Augusto von Dentz

Cheers,
Arman
