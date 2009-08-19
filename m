Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4A8BF5AB.2040206@inbd.com.br>
References: <4A8BF5AB.2040206@inbd.com.br>
Date: Wed, 19 Aug 2009 19:10:04 -0300
Message-ID: <2d5a2c100908191510g727eb701v71abcdf596ee2f1e@mail.gmail.com>
Subject: Re: Cross compile bluez 4.47
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andre Thiago Souza <andre.souza@inbd.com.br>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Wed, Aug 19, 2009 at 9:52 AM, Andre Thiago
Souza<andre.souza@inbd.com.br> wrote:
> Hi, i'm trying to cross compile the bluez 4.47 on ARM platform and i have
> some problems.
> To configure i set the following comand and all works fine:
> $ ./configure --prefix=/usr/bt/ --host=arm-linux CC=arm-linux-gcc
> CPP=arm-linux-cpp AR=arm-linux-ar STRIP=arm-linux-strip
> RANLIB=arm-linux-ranlib LD=arm-linux-ld
>
>
> But when i try to make the library:
> $ make && make install
>
> i got the following error:
>
> make[2]: Entering directory `/usr/bluez-4.47/common'
>  CCLD   test_textfile
> /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/lib/libc_nonshared.a(elf-init.oS)(.text+0x44):
> In function `__libc_csu_init':
> : undefined reference to `__init_array_end'
> /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/lib/libc_nonshared.a(elf-init.oS)(.text+0x48):
> In function `__libc_csu_init':
> : undefined reference to `__init_array_start'
> /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/lib/libc_nonshared.a(elf-init.oS)(.text+0x8c):
> In function `__libc_csu_fini':
> : undefined reference to `__fini_array_end'
> /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/lib/libc_nonshared.a(elf-init.oS)(.text+0x90):
> In function `__libc_csu_fini':
> : undefined reference to `__fini_array_start'
> collect2: ld returned 1 exit status
> make[2]: *** [test_textfile] Error 1
> make[2]: Leaving directory `/usr/bluez-4.47/common'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/usr/bluez-4.47'
> make: *** [all] Error 2


It doesn't look like this is our problem, never really tried to cross
compile that way you did (normally I use boostrap-configure on
scratchbox and that just work) but it seems your chaintool is not
right. If you don't like the idea of having to install scratchbox you
can try mamona on a chroot:  http://dev.openbossa.org/trac/mamona/


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
