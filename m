Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-4.49 does not build for me.
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20090824151514.6eb4f1f6@stoetzler>
References: <20090824151514.6eb4f1f6@stoetzler>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 13:05:22 -0700
Message-Id: <1251144322.2950.64.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> In file included from lib/sdp.c:50:
> lib/sdp_lib.h:31:33: error: bluetooth/bluetooth.h: No such file or directory
> lib/sdp_lib.h:32:27: error: bluetooth/hci.h: No such file or directory
> make[1]: *** [lib/sdp.lo] Error 1
> make: *** [all] Error 2

this got fixed now.

> a following "make clean" or "make distclean" is also interesting:
> 
> [...]
> rm -rf src/.libs src/_libs
> rm -rf test/.libs test/_libs
> rm -rf tools/.libs tools/_libs
> gcc -Wall -O2 -D_FORTIFY_SOURCE=2 -fPIC  -pie  lib/bluetooth.c   -o lib/bluetooth
> /usr/lib64/gcc/x86_64-suse-linux/4.4/../../../../lib64/Scrt1.o: In function `_start':
> /usr/src/packages/BUILD/glibc-2.10.1/csu/../sysdeps/x86_64/elf/start.S:99: undefined reference to `main'
> collect2: ld returned 1 exit status
> make: *** [lib/bluetooth] Error 1

Have seen that once and the never again.

Regards

Marcel


