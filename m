Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMudyAsFuw7vt1myK3XHGvXRXYUaie+JxYi5y9YTiWmwT1sBow@mail.gmail.com>
References: <1421223444-9374-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZKGuUa8AFo53QTs6Un=uGN0=jH63x4in=k+5uu55OqSAA@mail.gmail.com>
	<CAMudyAuDt+apnn5e+PO+3cGokoL9Hw_tc=KrEM5dBmXMDm4kig@mail.gmail.com>
	<CABBYNZ+K0D-ywU=fsJv4gwz6PV9LyZ79U++1hv=7zq5Z4j9T=g@mail.gmail.com>
	<CAMudyAsFuw7vt1myK3XHGvXRXYUaie+JxYi5y9YTiWmwT1sBow@mail.gmail.com>
Date: Wed, 21 Jan 2015 11:27:31 +0200
Message-ID: <CABBYNZJU_LEyrnpsRfCEpEpn7cu-wZ+NVgYhY+hZTS4UA3+vKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] shared/gatt-client: Add write prepare and execute
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Jan 21, 2015 at 10:28 AM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
>>>> I think it is better to leave execute flag to be handled internally by
>>>> bt_gatt_client_cancel (which seems already handle that).
>>>
>>> Ah I see that bt_gatt_client_cancel send write execute 0x00 if there
>>> was ongoing long write.
>>> Maybe we could consider do same when does prepare write "manulay"
>>
>> One thing Im not getting is what bt_gatt_client_prepare_write has to
>> be so different than bt_gatt_client_write_long_value, IMO it would
>> make sense to reuse code perhaps by calling
>> bt_gatt_client_prepare_write in bt_gatt_client_write_long_value as it
>> seems the only difference is that bt_gatt_client_write_long_value auto
>> execute while bt_gatt_client_prepare_write requires
>> bt_gatt_client_write_execute to be called manually.
>>
> Yes. Write long make use of write prepare as this is one of the use case.
> Other use case for wrtie prepare is e.g. you what write a set of
> characterisctics in "atomic" way.
> In this use case you would like to have control when to send write execute.
> IMHO we should not  mix those use cases.

The problem is that in case of error you cannot assume anything from
execute, so I would not classify it as atomic as you may have to read
all the values to verify what has happened. For Android perhaps this
is not a problem since it doesn't keep everything is sync, it leaves
to the application to do whatever it is pleased, anyway my point is
that internally in gatt-client.c this could be made to reuse code
whether it is for the same handle or different handles it is something
we can handle generically I suppose.

>>> However I would keep write_execute with execute flag as it is now.
>>> Android has API for that and it just makes things easy. Otherwise,
>>> Android GATT part would have to keep track on the req_id of prepared
>>> writes in order to use it when application does write execute 0x00. Is
>>> that fine?
>>
>> Don't you have to track it anyway, in case it is still outstanding in
>> the queue you would have to wait the prepare write to complete to send
>> the execute but if it still in the queue there is no reason even to
>> proceed with prepare.
>
> Actually Android waits for the write complete so I would not expect
> write execute before
> all write prepare are done. I would not be paranoid on that, unless we
> found out Android does different.
>
>>
>>> BTW. What happens in case we have really long write. Then in between
>>> prepare writes user sends regular write request and  then user cancel
>>> that regular write before long write is finished?
>>
>> Well there is no cancel at ATT level, besides execute 0x00, so we can
>> only remove from the outgoing queue, but perhaps you had something
>> else in mind.
>>
> Nevermind, I  double now check and code is fine.
> I thought that by canceling some regular write we can incorrectly
> cancel ongoing long write.
> But it will not happen since long_write flag is in the struct request
> which is defined by request_id used by client.
>
> \Lukasz
>
>>>
>>> BR
>>> \Lukasz
>>>>
>>>>
>>>>
>>>> --
>>>> Luiz Augusto von Dentz
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
