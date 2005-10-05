Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem install packages Bluetooth!!!
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <96c186cf0510041630i679033b1r@mail.gmail.com>
References: <96c186cf0510041630i679033b1r@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1128485289.26362.24.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 05 Oct 2005 06:08:09 +0200

Hi Rubi,

> I have problems when I tried install the packages Bluetooth. The
> problems with hcidump I compiling how said the README file but I typed
> make install the display show next error:
>=20
> gcc -I/usr/include -Wall -O2   -o bpasniff  bpasniff.o -L/usr/lib
> -lbluetooth ../parser/libparser.a
> ../parser/libparser.a(lmp.o)(.text+0x7b9): En la funci=C3=B3n `lmp_dump=
':
> : undefined reference to `bt_get_unaligned'
> ../parser/libparser.a(lmp.o)(.text+0x844): En la funci=C3=B3n `lmp_dump=
':
> : undefined reference to `bt_get_unaligned'
> ../parser/libparser.a(lmp.o)(.text+0x85b): En la funci=C3=B3n `lmp_dump=
':
> : undefined reference to `bt_get_unaligned'
> ../parser/libparser.a(lmp.o)(.text+0xb11): En la funci=C3=B3n `lmp_dump=
':
> : undefined reference to `bt_get_unaligned'
> ../parser/libparser.a(lmp.o)(.text+0xd1f): En la funci=C3=B3n `lmp_dump=
':
> : undefined reference to `bt_get_unaligned'
> ../parser/libparser.a(lmp.o)(.text+0xd40): more undefined references
> to `bt_get_unaligned' follow
> collect2: ld devolvi=C3=B3 el estado de salida 1
> make[1]: *** [bpasniff] Error 1
> make[1]: Leaving directory `/root/BlueZ/bluez-hcidump-1.25/src'
> make: *** [install-recursive] Error 1

install the correct bluez-libs packages as described in ChangeLog.

> How I compiling and run bluez-pin-0.26? Can you explain me please?

This can be a little bit tricky, because of the D-Bus API version
mismatches.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
