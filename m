Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABD6X-+sbmNDnWmhYcQH6bwj6m9AmYuTgO-DnmEC_36VFeS+3Q@mail.gmail.com>
References: <1412238337-23289-1-git-send-email-marcin.kraglak@tieto.com>
	<1412238337-23289-3-git-send-email-marcin.kraglak@tieto.com>
	<CAHrH25RR_Cc3yPuMrU8mEiH64mu485AdJsiGSZdFMP_xR_+vNg@mail.gmail.com>
	<CABD6X-+sbmNDnWmhYcQH6bwj6m9AmYuTgO-DnmEC_36VFeS+3Q@mail.gmail.com>
Date: Fri, 3 Oct 2014 08:37:58 -0700
Message-ID: <CAHrH25TshWdxPOxXgBioz2vxN9NZqQj-0eHgg92Qz1QwK_ExsQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] shared/gatt: Add included service iterator
From: Arman Uguray <armansito@chromium.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

>>> +bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
>>> +                               uint16_t *handle, uint16_t *start_handle,
>>> +                               uint16_t *end_handle, uint8_t uuid[16])
>>> +{
>>> +       struct bt_gatt_result *read_result;
>>> +       const void *pdu_ptr;
>>> +       int i = 0;
>>> +
>>> +       if (!iter || !iter->result || !handle || !start_handle || !end_handle
>>> +                                                               || !uuid)
>>> +               return false;
>>> +
>>> +       if (iter->result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
>>> +               return false;
>>
>> Remember that characteristics are also obtained via a Read By Type
>> request. I think we should make it so that
>> bt_gatt_iter_next_included_service and
>> bt_gatt_iter_next_characteristic return false if called on the
>> incorrect PDU. So it might make sense to add a flag to bt_gatt_result
>> such as "is_include" and check against that in both functions.
>>
>
> I think we can use data_length instead of flag. For characteristics
> data_len is 7 or 21, for included it is 6 or 8.
> Is it ok?

Yeah, that would work too (probably might be better actually, since
it's consistent with the ATT protocol PDU approach in those
iterators). So yeah, let's go with your suggestion.

Cheers,
Arman
