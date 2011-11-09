Return-Path: <cyrus@holtmann.org>
To: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/6] Manage GATT attribute indications in handle callback.
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Wed, 09 Nov 2011 14:53:05 +0100
From: Hendrik Sattler <post@hendrik-sattler.de>
In-Reply-To: <CAJdJm_PDwZNJM2Ws2=bO_kF=vVASaBY3nPjEDgS3xWqLtPXv+A@mail.gmail.com>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
 <1320835923-10989-2-git-send-email-sancane@gmail.com>
 <CAJdJm_OVgJbGrBmTgTUFaRHazDBweSagPJE0UP0eXa4MVFm61A@mail.gmail.com>
 <61c23c74e4beaa75fd2cf48a13012190@mail.hendrik-sattler.de>
 <CAJdJm_PDwZNJM2Ws2=bO_kF=vVASaBY3nPjEDgS3xWqLtPXv+A@mail.gmail.com>
Message-ID: <5b8fef65004ab00b22b5bb4484d0d79e@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 09.11.2011 14:30, schrieb Anderson Lizardo:
> Hi Hendrik,
>
> On Wed, Nov 9, 2011 at 8:54 AM, Hendrik Sattler
> <post@hendrik-sattler.de> wrote:
>> Am 09.11.2011 13:00, schrieb Anderson Lizardo:
>>>
>>> Hi Santiago,
>>>
>>> On Wed, Nov 9, 2011 at 6:51 AM, Santiago Carot-Nemesio
>>> <sancane@gmail.com> wrote:
>>>>
>>>> +static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
>>>> +{
>>>> +       const struct characteristic *ch = a;
>>>> +       const uint16_t *handle = b;
>>>> +
>>>> +       if (ch->attr.value_handle == *handle)
>>>> +               return 0;
>>>> +
>>>> +       return -1;
>>>> +}
>>>
>>> Usually we implement the function above as:
>>>
>>> return ch->attr.value_handle - *handle;
>>>
>>> It will work exactly as your code.
>>
>> You can do it this way with signed integers but not with unsigned 
>> integers,
>> unless you cast both to signed first.
>> Still, the above code completely misses the +1 case.
>
> The idea here is to return 0 if they are same or non zero if they are
> not same. The actual sign is not relevant because the comparison is
> for finding items, not sorting them (in this case).

Kind of a lazy approach, no?
Ah well...

HS

