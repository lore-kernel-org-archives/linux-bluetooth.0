Return-Path: <cyrus@holtmann.org>
Subject: Re: [pulseaudio-discuss] [PATCH] sbc_math.h: add explicit check
 for ARMv6 instructions
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: pulseaudio-discuss@mail.0pointer.de
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTi=wTkJ654Zo0SEuzLi3MBjvee54HvToxmeYGMF1@mail.gmail.com>
References: <1298226004.3712.1.camel@mattotaupa>
	 <1298320304.6159.21.camel@snowflake> <ik00pv$8d8$1@dough.gmane.org>
	 <1298374409.3861.32.camel@mattotaupa> <1298403438.6736.26.camel@snowflake>
	 <1300531488.6875.3.camel@snowflake> <1301052849.7592.15.camel@mattotaupa>
	 <AANLkTi=wTkJ654Zo0SEuzLi3MBjvee54HvToxmeYGMF1@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-N/8PwzHNc+IOjvd3rEia"
Date: Tue, 29 Mar 2011 01:00:57 +0200
Message-ID: <1301353257.6649.6.camel@mattotaupa>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-N/8PwzHNc+IOjvd3rEia
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear BlueZ folks,


Am Montag, den 28.03.2011, 18:41 +0300 schrieb Luiz Augusto von Dentz:

> On Fri, Mar 25, 2011 at 1:34 PM, Paul Menzel wrote:

> > Am Samstag, den 19.03.2011, 16:14 +0530 schrieb Arun Raghavan:
> >
> >> On Wed, 2011-02-23 at 01:07 +0530, Arun Raghavan wrote:
> >> [...]
> >> > The correct fix for this, imo, is in bluez (there is a new
> >> > sbc_primitives_armv6.h that can probably be used at least as a
> >> > template). We need to do an sbc-udpate on the PA side anyway, and ca=
n
> >> > pull this when we do.
> >>
> >> Could you see if the attached patch works for you? If it does, I can
> >> push this to the bluez folks.
> >
> > My tag on the other thread [1] is ambiguous. The error is indeed caused
> > by your patch. I will try to implement your recommended changes but wil=
l
> > probably not get to it before Sunday.
>=20
> Im including Siarhei Siamashka since he did most, if not all, of this
> code and linux-bluetooth to cc.

to fix [1] I tried to add `#include "sbc_tables.h"` to
`src/modules/bluetooth/sbc/sbc_primitives.h`

        diff --git a/src/modules/bluetooth/sbc/sbc_primitives.h b/src/modul=
es/bluetooth/
        index 3fec8d5..9544826 100644
        --- a/src/modules/bluetooth/sbc/sbc_primitives.h
        +++ b/src/modules/bluetooth/sbc/sbc_primitives.h
        @@ -24,6 +24,8 @@
          *
          */
        =20
        +#include "sbc_tables.h"
        +
         #ifndef __SBC_PRIMITIVES_H
         #define __SBC_PRIMITIVES_H

But this seems to result in a need for `sbc_math.h` which leads to a
circular inclusion.

        [=E2=80=A6]
        In file included from modules/bluetooth/sbc/sbc_primitives.h:27:0,
                         from modules/bluetooth/sbc/sbc_primitives_armv6.h:=
30,
                         from modules/bluetooth/sbc/sbc_math.h:27,
                         from modules/bluetooth/sbc/sbc.c:46:
        modules/bluetooth/sbc/sbc_tables.h:50:2: warning: implicit declarat=
ion of function 'ASR' [-Wimplicit-function-declaration]
        modules/bluetooth/sbc/sbc_tables.h:50:2: error: 'SCALE_SPROTO4_TBL'=
 undeclared here (not in a function)
        modules/bluetooth/sbc/sbc_tables.h:58:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:58:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[0]')
        modules/bluetooth/sbc/sbc_tables.h:58:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:58:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[1]')
        modules/bluetooth/sbc/sbc_tables.h:58:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:58:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[2]')
        modules/bluetooth/sbc/sbc_tables.h:58:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:58:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[3]')
        modules/bluetooth/sbc/sbc_tables.h:59:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:59:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[4]')
        modules/bluetooth/sbc/sbc_tables.h:59:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:59:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[5]')
        modules/bluetooth/sbc/sbc_tables.h:59:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:59:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[6]')
        modules/bluetooth/sbc/sbc_tables.h:59:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:59:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[7]')
        modules/bluetooth/sbc/sbc_tables.h:60:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:60:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[8]')
        modules/bluetooth/sbc/sbc_tables.h:60:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:60:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[9]')
        modules/bluetooth/sbc/sbc_tables.h:60:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:60:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[10]')
        modules/bluetooth/sbc/sbc_tables.h:60:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:60:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[11]')
        modules/bluetooth/sbc/sbc_tables.h:61:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:61:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[12]')
        modules/bluetooth/sbc/sbc_tables.h:61:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:61:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[13]')
        modules/bluetooth/sbc/sbc_tables.h:61:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:61:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[14]')
        modules/bluetooth/sbc/sbc_tables.h:61:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:61:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[15]')
        modules/bluetooth/sbc/sbc_tables.h:62:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:62:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[16]')
        modules/bluetooth/sbc/sbc_tables.h:62:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:62:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[17]')
        modules/bluetooth/sbc/sbc_tables.h:62:2: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:62:2: error: (near initializatio=
n for 'sbc_proto_4_40m1[18]')
        modules/bluetooth/sbc/sbc_tables.h:63:1: error: initializer element=
 is not constant
        modules/bluetooth/sbc/sbc_tables.h:63:1: error: (near initializatio=
n for 'sbc_proto_4_40m1[19]')
        [ goes on =E2=80=A6 ]

> Btw, the sbc subdir should be in sync with sbc subdir in BlueZ tree.

The question is how often should the updates be made. As far as I know
`make update-sbc` is only run once in a while.

        commit b676f89d8579c7ec1629892342a330f1e4c35657
        Author: Colin Guthrie <cguthrie@mandriva.org>
        Date:   Sun Mar 20 11:44:53 2011 +0000
       =20
            bluetooth: Run 'make update-sbc'
           =20
            Note that changes to ipc.h from 8f3ef04b had to be manually rea=
pplied.


Thanks,

Paul


[1] https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-March/00959=
4.html

--=-N/8PwzHNc+IOjvd3rEia
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2REyMACgkQPX1aK2wOHVgnWACgjKrs4ZK9Dh7lpKDMgV4iM+NW
BFAAoIzKYysFa6Lc5CWcZYf9GvWZ8U7m
=2ss6
-----END PGP SIGNATURE-----

--=-N/8PwzHNc+IOjvd3rEia--

