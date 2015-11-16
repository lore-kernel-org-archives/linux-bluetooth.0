Return-Path: <andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
In-Reply-To: <20151113115332.GA10089@t440s.lan>
References: <1447360987-4129-1-git-send-email-andrzej.kaczmarek@codecoup.pl> <20151113115332.GA10089@t440s.lan>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Date: Mon, 16 Nov 2015 09:31:09 +0100
Message-ID: <CADAkoF4kyBe3Or9VE64aM_DEn=Z6UTbvrjPds+EMwxy3N52=dw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix powering on with privacy and advertising
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>, linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Nov 13, 2015 at 12:53 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andrzej,
>
> On Thu, Nov 12, 2015, Andrzej Kaczmarek wrote:
>> In order to enable advertising with privacy enabled, SMP has to be
>> registered in order to generate new RPA. During power on, it will be
>> registered at the very end which is the reason why advertising is not
>> enabled and it's not possible to enable it anymore due to mismatch
>> between hci_dev settings and actual controller state.
>>
>> This fixes this problem by postponing advertising enable after SMP is
>> registered in case of power on.
>> ---
>>  net/bluetooth/mgmt.c | 70 ++++++++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 54 insertions(+), 16 deletions(-)
>
> Instead of postponing advertising, did you consider simply moving
> smp_register() earlier? Wouldn't it be possible to move it to
> mgmt_powered() before powered_update_hci() is called?

smp_register() was already moved in 162a3bac8d0 so I assumed this is
the right place for it and didn't want to move it again. But it seems
it could be moved as you suggested, identity address is already know
at that point. And this will make whole fix simple. I'll send v2
later, unless Marcel disagrees with this proposal.

BR,
Andrzej
