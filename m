Return-Path: <cyrus@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: Re: [PATCH 1/6] Manage GATT attribute indications in handle callback.
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Date: Wed, 09 Nov 2011 13:54:01 +0100
From: Hendrik Sattler <post@hendrik-sattler.de>
Cc: Santiago Carot-Nemesio <sancane@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
In-Reply-To: <CAJdJm_OVgJbGrBmTgTUFaRHazDBweSagPJE0UP0eXa4MVFm61A@mail.gmail.com>
References: <1320835923-10989-1-git-send-email-sancane@gmail.com>
 <1320835923-10989-2-git-send-email-sancane@gmail.com>
 <CAJdJm_OVgJbGrBmTgTUFaRHazDBweSagPJE0UP0eXa4MVFm61A@mail.gmail.com>
Message-ID: <61c23c74e4beaa75fd2cf48a13012190@mail.hendrik-sattler.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 09.11.2011 13:00, schrieb Anderson Lizardo:
> Hi Santiago,
>
> On Wed, Nov 9, 2011 at 6:51 AM, Santiago Carot-Nemesio
> <sancane@gmail.com> wrote:
>> +static gint cmp_char_val_handle(gconstpointer a, gconstpointer b)
>> +{
>> +       const struct characteristic *ch = a;
>> +       const uint16_t *handle = b;
>> +
>> +       if (ch->attr.value_handle == *handle)
>> +               return 0;
>> +
>> +       return -1;
>> +}
>
> Usually we implement the function above as:
>
> return ch->attr.value_handle - *handle;
>
> It will work exactly as your code.

You can do it this way with signed integers but not with unsigned 
integers, unless you cast both to signed first.
Still, the above code completely misses the +1 case.

HS

