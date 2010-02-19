Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1266592077.5249.21.camel@localhost.localdomain>
References: <2a9506371002190701o2d46102bpd50f9a95b37a816e@mail.gmail.com>
	 <1266592077.5249.21.camel@localhost.localdomain>
Date: Fri, 19 Feb 2010 14:24:04 -0300
Message-ID: <2a9506371002190924p2ff4ff6eq243dc3031ae3b3a7@mail.gmail.com>
Subject: Re: obexd-0.21: configure doesn't work as expected
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: pacho@condmat1.ciencias.uniovi.es
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pacho,

2010/2/19 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>:
> Ah, then, why is plugins folder being created even if nothing will be
> installed in it?
>

Nothing is installed right now. But it doesn't mean that nothing will
ever be ;-)

And if you want to have a custom plugin for some application, you just write
it and install it there, no need to mess with core obexd.

>> Thanks for the report, this is a bug. There's a patch for it in my
>> development tree. Waiting for review.
>>
>> But before the next release happens, disabling a plugin is equivalent
>> to setting its value to dummy, i.e.
>> --without-phonebook (if it worked ;-) would be the same as
>> --with-phonebook=dummy.
>>
>
> Great, where could I see your development tree?
>

Sure. Forgot the link, here it is:
http://git.infradead.org/users/vcgomes/obexd.git (devel branch)

> Thanks a lot :-)
>


Cheers,
-- 
Vinicius Gomes
INdT - Instituto Nokia de Tecnologia
