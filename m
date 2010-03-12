Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1268153872.3712.54.camel@localhost.localdomain>
References: <508e92ca1002260126r600ff956hb18c333504fe6525@mail.gmail.com>
	 <1268096416.3712.34.camel@localhost.localdomain>
	 <508e92ca1003090034y53871120n928f62573f56417d@mail.gmail.com>
	 <1268153872.3712.54.camel@localhost.localdomain>
Date: Fri, 12 Mar 2010 16:14:56 +0200
Message-ID: <508e92ca1003120614k5e441c6bl8dcc0b011057a400@mail.gmail.com>
Subject: Re: lockdep warns: inconsistent lock state ({IN-SOFTIRQ-W} ->
	{SOFTIRQ-ON-W})
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Mar 9, 2010 at 6:57 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andrei,
>
>> > is this still present with 2.6.34-rc1 kernel?
>>
>> We are using 2.6.32-XX kernel so far.
>
> please check with 2.6.34-rc1 to ensure it is still present. And do you
> have instructions on how to re-produce it?

One strange here is that I see this when
CONFIG_PROVE_LOCKING is enabled and CONFIG_DEBUG_LOCKDEP is not enabled.

When I enabled both CONFIG_DEBUG_LOCKDEP and CONFIG_PROVE_LOCKING I
see no warnings.

We use stress tests so I am not sure that it is easy to reproduce.

Regards,
Andrei
