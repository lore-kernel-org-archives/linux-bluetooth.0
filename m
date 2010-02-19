Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1266578028.5249.1.camel@localhost.localdomain>
References: <1266578028.5249.1.camel@localhost.localdomain>
Date: Fri, 19 Feb 2010 12:01:57 -0300
Message-ID: <2a9506371002190701o2d46102bpd50f9a95b37a816e@mail.gmail.com>
Subject: Re: obexd-0.21: configure doesn't work as expected
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: pacho@condmat1.ciencias.uniovi.es
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pacho,

2010/2/19 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>:
> Hello all!
>
> The problem we are suffering downstream is the following:
> http://bugs.gentoo.org/show_bug.cgi?id=305063#c5
>
> In summary, the same files are being *installed* with
> --with-phonebook=ebook and --with-phonebook=dummy (in both cases,
> phonebook files are not being installed at all). A
> $PREFIX/lib/obex/plugins directory is created but nothing is installed
> on it.
>

This is not a bug, it is by design, the phonebook driver is a built-in
module. In fact, all the plugins
we have currently are built-in. That's why nothing gets installed in
the plugins folder.

> Another problem is that, when passing --without-phonebook to configure,
> build fails with:
> $ make
> make --no-print-directory all-am
>  CC     gdbus/mainloop.o
>  CC     gdbus/object.o
>  CC     gdbus/watch.o
>  CC     plugins/filesystem.o
>  CC     plugins/opp.o
>  CC     plugins/ftp.o
>  CC     plugins/pbap.o
>  CC     plugins/syncevolution.o
>  CC     src/main.o
>  GEN    src/builtin.h
>  CC     src/plugin.o
>  CC     src/logging.o
>  CC     src/btio.o
>  CC     src/manager.o
>  CC     src/obex.o
>  CC     src/bluetooth.o
>  CC     src/mimetype.o
>  CC     src/service.o
> make[1]: *** No rule to make target `plugins/phonebook-no.c', needed by
> `plugins/phonebook.c'.  Stop.
> make: *** [all] Error 2
>

Thanks for the report, this is a bug. There's a patch for it in my
development tree. Waiting for review.

But before the next release happens, disabling a plugin is equivalent
to setting its value to dummy, i.e.
--without-phonebook (if it worked ;-) would be the same as
--with-phonebook=dummy.

>
> Thanks a lot for your help :-)
>


Cheers,
-- 
Vinicius Gomes
INdT - Instituto Nokia de Tecnologia
