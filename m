Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMudyAucJ2-nvu=o08QEkQTd3adztpGxgynYWOReGbU3_pnByw@mail.gmail.com>
References: <1421223444-9374-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZKGuUa8AFo53QTs6Un=uGN0=jH63x4in=k+5uu55OqSAA@mail.gmail.com>
	<CAMudyAuDt+apnn5e+PO+3cGokoL9Hw_tc=KrEM5dBmXMDm4kig@mail.gmail.com>
	<CABBYNZ+K0D-ywU=fsJv4gwz6PV9LyZ79U++1hv=7zq5Z4j9T=g@mail.gmail.com>
	<CAMudyAsFuw7vt1myK3XHGvXRXYUaie+JxYi5y9YTiWmwT1sBow@mail.gmail.com>
	<CABBYNZJU_LEyrnpsRfCEpEpn7cu-wZ+NVgYhY+hZTS4UA3+vKw@mail.gmail.com>
	<CAMudyAucJ2-nvu=o08QEkQTd3adztpGxgynYWOReGbU3_pnByw@mail.gmail.com>
Date: Wed, 21 Jan 2015 13:10:12 +0200
Message-ID: <CABBYNZJJUBj0Ft5cmy0FihiGNni9jikvFVst6wgH8bJ6YNn76g@mail.gmail.com>
Subject: Re: [PATCH 1/2] shared/gatt-client: Add write prepare and execute
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Jan 21, 2015 at 12:06 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> Hi Luiz,
>
> On 21 January 2015 at 10:27, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Lukasz,
>>
>> On Wed, Jan 21, 2015 at 10:28 AM, Lukasz Rymanowski
>> <lukasz.rymanowski@tieto.com> wrote:
>>>>>> I think it is better to leave execute flag to be handled internally by
>>>>>> bt_gatt_client_cancel (which seems already handle that).
>>>>>
>>>>> Ah I see that bt_gatt_client_cancel send write execute 0x00 if there
>>>>> was ongoing long write.
>>>>> Maybe we could consider do same when does prepare write "manulay"
>>>>
>>>> One thing Im not getting is what bt_gatt_client_prepare_write has to
>>>> be so different than bt_gatt_client_write_long_value, IMO it would
>>>> make sense to reuse code perhaps by calling
>>>> bt_gatt_client_prepare_write in bt_gatt_client_write_long_value as it
>>>> seems the only difference is that bt_gatt_client_write_long_value auto
>>>> execute while bt_gatt_client_prepare_write requires
>>>> bt_gatt_client_write_execute to be called manually.
>>>>
>>> Yes. Write long make use of write prepare as this is one of the use case.
>>> Other use case for wrtie prepare is e.g. you what write a set of
>>> characterisctics in "atomic" way.
>>> In this use case you would like to have control when to send write execute.
>>> IMHO we should not  mix those use cases.
>>
>> The problem is that in case of error you cannot assume anything from
>> execute, so I would not classify it as atomic as you may have to read
>> all the values to verify what has happened. For Android perhaps this
>> is not a problem since it doesn't keep everything is sync, it leaves
>> to the application to do whatever it is pleased, anyway my point is
>> that internally in gatt-client.c this could be made to reuse code
>> whether it is for the same handle or different handles it is something
>> we can handle generically I suppose.
>
> Ok. You mentioned previously that we could remove execute parameter
> from write execute and reuse bt_gatt_client_cancel to cover write
> execute 0x00
>
> Main problem here is if all prepare writes are already done. At that
> time there is actually no outstanding request in the queue to be
> cancel. To support write execute 0x00 we would have to add some
> parameter to bt_gatt_client_cancel. Is that fine for you? For me
> execute parameter in write_execute is much cleaner. I do really
> believe that what we do now is OK. We have ATT methods write
> prepare/execute and we expose over gatt-client two different scenarios
> :)

Well then anyone could cancel or execute write without consent of the
original caller of prepare write so this could cause bugs if any
application misbehave, IMO it would be much better if prepare write id
is also passed to execute write which means we would have to hold a
prepare write id that identify the whole operation, the means the API
would look like this:

unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
                               unsigned int id,
                               uint16_t value_handle, uint16_t offset,
                               uint8_t *value, uint16_t length,
                               bt_gatt_client_write_long_callback_t callback,
                               void *user_data,
                               bt_gatt_client_destroy_func_t destroy);
unsigned int bt_gatt_client_write_execute(struct bt_gatt_client *client,
                                       unsigned int id,
                                       bt_gatt_client_callback_t callback,
                                       void *user_data,
                                       bt_gatt_client_destroy_func_t destroy);

It entirely up to you whether you will let applications reuse the same
id in Android, but from the API point of view I think this would be
better and bt_gatt_client_write_long_value can then just create it own
queue, obviously this will affect how we handle ids on
bt_gatt_client_cancel because this would be queued at bt_gatt_client
level not in bt_att.

>>
>>>>> However I would keep write_execute with execute flag as it is now.
>>>>> Android has API for that and it just makes things easy. Otherwise,
>>>>> Android GATT part would have to keep track on the req_id of prepared
>>>>> writes in order to use it when application does write execute 0x00. Is
>>>>> that fine?
>>>>
>>>> Don't you have to track it anyway, in case it is still outstanding in
>>>> the queue you would have to wait the prepare write to complete to send
>>>> the execute but if it still in the queue there is no reason even to
>>>> proceed with prepare.
>>>
>>> Actually Android waits for the write complete so I would not expect
>>> write execute before
>>> all write prepare are done. I would not be paranoid on that, unless we
>>> found out Android does different.
>>>
>>>>
>>>>> BTW. What happens in case we have really long write. Then in between
>>>>> prepare writes user sends regular write request and  then user cancel
>>>>> that regular write before long write is finished?
>>>>
>>>> Well there is no cancel at ATT level, besides execute 0x00, so we can
>>>> only remove from the outgoing queue, but perhaps you had something
>>>> else in mind.
>>>>
>>> Nevermind, I  double now check and code is fine.
>>> I thought that by canceling some regular write we can incorrectly
>>> cancel ongoing long write.
>>> But it will not happen since long_write flag is in the struct request
>>> which is defined by request_id used by client.
>>>
>>> \Lukasz
>>>
>>>>>
>>>>> BR
>>>>> \Lukasz
>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Luiz Augusto von Dentz
>>>>
>>>>
>>>>
>>>> --
>>>> Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Luiz Augusto von Dentz-- Luiz Augusto von Dentz
