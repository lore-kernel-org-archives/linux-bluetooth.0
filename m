Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090824151514.6eb4f1f6@stoetzler>
References: <20090824151514.6eb4f1f6@stoetzler>
Date: Mon, 24 Aug 2009 10:52:18 -0300
Message-ID: <2d5a2c100908240652l179a6ad3mc6195db710ae069a@mail.gmail.com>
Subject: Re: bluez-4.49 does not build for me.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 24, 2009 at 10:15 AM, Stefan
Seyfried<stefan.seyfried@googlemail.com> wrote:
> In file included from lib/sdp.c:50:
> lib/sdp_lib.h:31:33: error: bluetooth/bluetooth.h: No such file or directory
> lib/sdp_lib.h:32:27: error: bluetooth/hci.h: No such file or directory
> make[1]: *** [lib/sdp.lo] Error 1
> make: *** [all] Error 2
>

Strange I just compiled it using ./boostrap-configure but I did have
it installed so
it is maybe the case where include/ were not being include when
compiling lib, so
it only works when one already have those files installed.

> [...]
> rm -rf src/.libs src/_libs
> rm -rf test/.libs test/_libs
> rm -rf tools/.libs tools/_libs
> gcc -Wall -O2 -D_FORTIFY_SOURCE=2 -fPIC  -pie  lib/bluetooth.c   -o lib/bluetooth
> /usr/lib64/gcc/x86_64-suse-linux/4.4/../../../../lib64/Scrt1.o: In function `_start':
> /usr/src/packages/BUILD/glibc-2.10.1/csu/../sysdeps/x86_64/elf/start.S:99: undefined reference to `main'
> collect2: ld returned 1 exit status
> make: *** [lib/bluetooth] Error 1

No idea!

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
