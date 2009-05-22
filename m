Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: ext Marcin Kijewski <marcin.kijewski@pruftechnik.com.pl>
Subject: Re: cross compile bluez 4.40 for ARM
Date: Fri, 22 May 2009 18:58:18 +0300
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <9BC2E7448C24410C8868C690FF4C21E8@kijewski>
In-Reply-To: <9BC2E7448C24410C8868C690FF4C21E8@kijewski>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200905221858.18742.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 22 May 2009 17:36:17 ext Marcin Kijewski wrote:
[...]
> mv -f .deps/sbcdec.Tpo .deps/sbcdec.Po
> /bin/sh ../libtool --tag=CC   --mode=link arm-linux-gcc  -Wall -O2
> -D_FORTIFY_SOURCE=2 -D_FORTIFY_SOURCE=2   -o sbcdec sbcdec.o libsbc.la
> arm-linux-gcc -Wall -O2 -D_FORTIFY_SOURCE=2 -D_FORTIFY_SOURCE=2 -o sbcdec
> sbcdec.o  ./.libs/libsbc.a
> ./.libs/libsbc.a(libsbc_la-sbc_primitives.o)(.text+0x1f20): In function
>
> `sbc_calc_scalefactors':
> : undefined reference to `__builtin_clz'

You can take a look at sbc_clz wrapper function. It uses __builtin_clz
if __GNUC__ is defined (assuming that this builtin function is supported
by gcc) and an alternative implementation otherwise. A right solution
would be to check what is the earliest version of gcc where __builtin_clz
was introduced and update this check.

> collect2: ld returned 1 exit status
> make[2]: *** [sbcdec] Error 1
> make[2]: Leaving directory `/projects/bluetooth/bluez-4.40/sbc'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/projects/bluetooth/bluez-4.40'
> make: *** [all] Error 2
>
> I use arm compiler version 3.2.1
>
> Can anybody help me ?
> Should I use arm-compiler newer than 3.2.1 ?

Newer compiler would probably solve at least part of the problems. But you
can still try to use your compiler. No guarantee that you will not encounter
further breakages using it though.

-- 
Best regards,
Siarhei Siamashka
