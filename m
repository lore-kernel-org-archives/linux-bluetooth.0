Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <61c23c74e4beaa75fd2cf48a13012190@mail.hendrik-sattler.de>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
	<1320835923-10989-2-git-send-email-sancane@gmail.com>
	<CAJdJm_OVgJbGrBmTgTUFaRHazDBweSagPJE0UP0eXa4MVFm61A@mail.gmail.com>
	<61c23c74e4beaa75fd2cf48a13012190@mail.hendrik-sattler.de>
Date: Wed, 9 Nov 2011 09:30:02 -0400
Message-ID: <CAJdJm_PDwZNJM2Ws2=bO_kF=vVASaBY3nPjEDgS3xWqLtPXv+A@mail.gmail.com>
Subject: Re: [PATCH 1/6] Manage GATT attribute indications in handle callback.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Hendrik Sattler <post@hendrik-sattler.de>
Cc: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hendrik,

On Wed, Nov 9, 2011 at 8:54 AM, Hendrik Sattler <post@hendrik-sattler.de> wrote:
> Am 09.11.2011 13:00, schrieb Anderson Lizardo:
>>
>> Hi Santiago,
>>
>> On Wed, Nov 9, 2011 at 6:51 AM, Santiago Carot-Nemesio
>> <sancane@gmail.com> wrote:
>>>
>>> +static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
>>> +{
>>> +       const struct characteristic *ch = a;
>>> +       const uint16_t *handle = b;
>>> +
>>> +       if (ch->attr.value_handle == *handle)
>>> +               return 0;
>>> +
>>> +       return -1;
>>> +}
>>
>> Usually we implement the function above as:
>>
>> return ch->attr.value_handle - *handle;
>>
>> It will work exactly as your code.
>
> You can do it this way with signed integers but not with unsigned integers,
> unless you cast both to signed first.
> Still, the above code completely misses the +1 case.

The idea here is to return 0 if they are same or non zero if they are
not same. The actual sign is not relevant because the comparison is
for finding items, not sorting them (in this case).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
