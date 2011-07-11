Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110711143734.GB2816@joana>
References: <CAAbSJMWHNbSV9r7Cw3+3NHoZMzWth3h1_GWrxDf9ANGA=cLnfQ@mail.gmail.com>
	<20110711143734.GB2816@joana>
Date: Mon, 11 Jul 2011 16:56:58 +0200
Message-ID: <CAAbSJMV234PfDQEoH+0WqTaWcyOtzSKUb_vzhgm8S8JXByWXxQ@mail.gmail.com>
Subject: Re: Compile failure
From: Mickael Chazaux <mickael.chazaux@gmail.com>
To: Mickael Chazaux <mickael.chazaux@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/7/11 Gustavo Padovan <padovan@profusion.mobi>:
> * Mickael Chazaux <mickael.chazaux@gmail.com> [2011-07-10 16:10:22 +0200]:
>
>> git://git.kernel.org/pub/scm/bluetooth/bluez.git, branch master,
>> commit c34e7956441 fails to build :
>>
>>   CC     tools/lexer.o
>> cc1: warnings being treated as errors
>> tools/lexer.c: In function ‘yy_get_next_buffer’:
>> tools/lexer.c:1095: erreur: comparaison entre des expressions entières
>> signée et non signée
>> tools/lexer.c: In function ‘yy_init_buffer’:
>> tools/lexer.c:1415: erreur: implicit declaration of function ‘isatty’
>> make[1]: *** [tools/lexer.o] Erreur 1
>
> Are you using gentoo? There is a bug in gentoo flex ebuild that cause this.
>
Yes I am using Gentoo. Removing -Werror in the makefile works around
this problem at the moment.

Thanks,

Regards,

Mickael
