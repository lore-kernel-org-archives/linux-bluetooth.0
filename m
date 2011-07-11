Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jul 2011 11:37:34 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mickael Chazaux <mickael.chazaux@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Compile failure
Message-ID: <20110711143734.GB2816@joana>
References: <CAAbSJMWHNbSV9r7Cw3+3NHoZMzWth3h1_GWrxDf9ANGA=cLnfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAAbSJMWHNbSV9r7Cw3+3NHoZMzWth3h1_GWrxDf9ANGA=cLnfQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Mickael Chazaux <mickael.chazaux@gmail.com> [2011-07-10 16:10:22 +0200]:

> git://git.kernel.org/pub/scm/bluetooth/bluez.git, branch master,
> commit c34e7956441 fails to build :
> 
>   CC     tools/lexer.o
> cc1: warnings being treated as errors
> tools/lexer.c: In function ‘yy_get_next_buffer’:
> tools/lexer.c:1095: erreur: comparaison entre des expressions entières
> signée et non signée
> tools/lexer.c: In function ‘yy_init_buffer’:
> tools/lexer.c:1415: erreur: implicit declaration of function ‘isatty’
> make[1]: *** [tools/lexer.o] Erreur 1

Are you using gentoo? There is a bug in gentoo flex ebuild that cause this.

	Gustavo
