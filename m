Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-4.49 does not build for me.
From: Valmantas =?UTF-8?Q?Palik=C5=A1a?= <walmis@gmail.com>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <2d5a2c100908240652l179a6ad3mc6195db710ae069a@mail.gmail.com>
References: <20090824151514.6eb4f1f6@stoetzler>
	 <2d5a2c100908240652l179a6ad3mc6195db710ae069a@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 17:27:08 +0300
Message-Id: <1251124029.19970.1.camel@walmis-desktop>
Mime-Version: 1.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here's my errors:

make[1]: *** No rule to make target `tools/bccmd.8', needed by `all-am'.
Stop.
make: *** [all] Error 2

same with hid2hci.

On Mon, 2009-08-24 at 10:52 -0300, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Aug 24, 2009 at 10:15 AM, Stefan
> Seyfried<stefan.seyfried@googlemail.com> wrote:
> > In file included from lib/sdp.c:50:
> > lib/sdp_lib.h:31:33: error: bluetooth/bluetooth.h: No such file or directory
> > lib/sdp_lib.h:32:27: error: bluetooth/hci.h: No such file or directory
> > make[1]: *** [lib/sdp.lo] Error 1
> > make: *** [all] Error 2
> >
> 
> Strange I just compiled it using ./boostrap-configure but I did have
> it installed so
> it is maybe the case where include/ were not being include when
> compiling lib, so
> it only works when one already have those files installed.
> 
> > [...]
> > rm -rf src/.libs src/_libs
> > rm -rf test/.libs test/_libs
> > rm -rf tools/.libs tools/_libs
> > gcc -Wall -O2 -D_FORTIFY_SOURCE=2 -fPIC  -pie  lib/bluetooth.c   -o lib/bluetooth
> > /usr/lib64/gcc/x86_64-suse-linux/4.4/../../../../lib64/Scrt1.o: In function `_start':
> > /usr/src/packages/BUILD/glibc-2.10.1/csu/../sysdeps/x86_64/elf/start.S:99: undefined reference to `main'
> > collect2: ld returned 1 exit status
> > make: *** [lib/bluetooth] Error 1
> 
> No idea!
> 

