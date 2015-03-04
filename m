Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <260CDA8B-2CB3-4AC0-83E5-30710A56CEB3@holtmann.org>
References: <CALMby5ZjoCqCirOcUPXN38mhAE5KEsVTdh8MMpjvKsL+w59k9g@mail.gmail.com>
	<20150304085023.GA17887@t440s.lan>
	<260CDA8B-2CB3-4AC0-83E5-30710A56CEB3@holtmann.org>
Date: Wed, 4 Mar 2015 09:06:27 -0800
Message-ID: <CALMby5ZX29VY3bkX+EYyUw_uE68mB6r6myJK4KcZKn9EHdEumw@mail.gmail.com>
Subject: Re: Patch to bluez/src/shared/att.c
From: =?UTF-8?B?0JLQvtC70L7QtNC40LzQuNGAINCe0YHRgtCw0L8=?= <volodymyr.ostap@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

Thank you for response.
I am ok with single thread implementation but I fixed API, a
particular function which is used to send notification.
It definitely cannot be called from internal thread.
Other thread is updating characteristic and pushes notification into
internal queue. Next, internal thread gets the notification from queue
and transfers it.
As you can see two thread is involved. I have no idea how to send
notification using internal thread.

Anyway this fix for sure doesn't break logic.

2015-03-04 7:18 GMT-08:00 Marcel Holtmann <marcel@holtmann.org>:
> Hi Johan,
>
>>> Fix of thread racing in bt_att_send()
>>>
>>> In case bt_att_send() is called from other thread, internal thread
>>> could complete
>>> just added operation before  bt_att_send() returns. So, the function
>>> return 0 as in error case.
>>
>> I don't think any of our libraries have been designed to be used in a
>> multi-threaded context. We could try fixing individual issues like this
>> but it's a slippery slope which will lead you to find more and more
>> things to fix - ultimately leading to greatly increased code complexity
>> because the fundamental design doesn't take multi-threading into account.
>
> the whole BlueZ internal code is not thread safe. And that is on purpose. We want to keep the tools and daemons single threaded.
>
> Regards
>
> Marcel
>
