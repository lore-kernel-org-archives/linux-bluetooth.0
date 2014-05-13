Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMudyAvpA2aLoP62B4ZibdD+MFUpmJwDQN2Nuu574ze_LFu_LQ@mail.gmail.com>
References: <1399977868-31937-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1399977868-31937-2-git-send-email-lukasz.rymanowski@tieto.com>
	<0C9B7B6F-E3B6-453A-86B2-3ECE979A7796@holtmann.org>
	<CAMudyAvpA2aLoP62B4ZibdD+MFUpmJwDQN2Nuu574ze_LFu_LQ@mail.gmail.com>
Date: Tue, 13 May 2014 22:59:40 +0200
Message-ID: <CAMudyAtGHDJYH6oHG_zcYM+s2btmkUv9RU4xoZV0BE7burx=-Q@mail.gmail.com>
Subject: Re: [RFC 1/2] shared/aes-cmac: Add support for AES-CMAC-128
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 13 May 2014 15:44, Lukasz Rymanowski <lukasz.rymanowski@tieto.com> wrote:
> Hi Marcel,
>
> On 13 May 2014 15:24, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Lukasz,
>>
>>> This patch adds handling AES-CMAC-128 signing as specified in the NIST
>>> Special Publication 800-38B
>>> ---
>>> src/shared/aes-cmac.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>> src/shared/aes-cmac.h |  38 ++++++
>>> 2 files changed, 384 insertions(+)
>>> create mode 100644 src/shared/aes-cmac.c
>>> create mode 100644 src/shared/aes-cmac.h
>>
>> I really like to see it included in src/shared/crypto.c. Lets try that one first. It is meant to provide the whole crypto toolbox for us.
>
> I tried but it did not look good to me then.
>
> Anyway, what I need to do is to add to struct bt_crypro a member which
> will contain aes-cmac session data (key, sub keys, sign_counter)
> I need to also mess a bit with bt_crypto_new and add there parameters
> needed to initialize AES-CMAC ?
> Is that a good way?
>

Looks like I did way too much. I will use AF_ALG type "hash" name
"cmac(aes)" - that should work fine. And also should fit crypto.c very
well.

>>
>>>
>>> diff --git a/src/shared/aes-cmac.c b/src/shared/aes-cmac.c
>>> new file mode 100644
>>> index 0000000..660ceff
>>> --- /dev/null
>>> +++ b/src/shared/aes-cmac.c
>>> @@ -0,0 +1,346 @@
>>> +/*
>>> + *
>>> + *  BlueZ - Bluetooth protocol stack for Linux
>>> + *
>>> + *  Copyright (C) 2014  Intel Corporation. All rights reserved.
>>> + *
>>> + *
>>> + *  This library is free software; you can redistribute it and/or
>>> + *  modify it under typedef struct {
>>> +     uint64_t a, b;
>>> +} u128;the terms of the GNU Lesser General Public
>>
>> Something is broken here.
>>
> How that happen (?) Thanks.
>
>> Regards
>>
>> Marcel
>>
> BR
> \Łukasz

BR
Lukasz
