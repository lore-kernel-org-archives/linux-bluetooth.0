Return-Path: <grantma@anathoth.gen.nz>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Matthew Grant <grantma@anathoth.gen.nz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1099943605.29330.21.camel@pegasus>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>  <1099721547.5132.70.camel@localhost>
	 <1099744491.6919.39.camel@pegasus>  <1099771915.4563.9.camel@localhost>
	 <1099776680.6919.104.camel@pegasus>  <1099788984.4543.5.camel@localhost>
	 <1099795084.6896.3.camel@pegasus>  <1099942733.5806.7.camel@localhost>
	 <1099943605.29330.21.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AzK2nB+r6T+AQ16ec5tZ"
Message-Id: <1100326156.6216.29.camel@localhost>
Mime-Version: 1.0
Date: Sat, 13 Nov 2004 19:09:17 +1300
List-ID: <bluez-users.lists.sourceforge.net>


--=-AzK2nB+r6T+AQ16ec5tZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

My first ideas about the kernel realigning things are wrong, its actually t=
he=20
struct hidp_connlist_req definitions not matching.

Real reason for it is this, user-space thinks cnum field is 16 bit, kernel=20
thinks it is 32 bit.  Bug only shows up in big-endian architectures as resu=
lt
count is returned in top byte of what is received from the kernel, whereas =
on
i386 it is in the lowest where by fluke it works...

Mismatch in the kernel and user-space  header files:

in the kernel, net/bluetooth/hid/hdip.h:=20

struct hidp_connlist_req {
        __u32  cnum;
        struct hidp_conninfo __user *ci;
};

in libbluetoth, include/bluetooth/hidp.h:

struct hidp_connlist_req {
        uint16_t cnum;
        struct hidp_conninfo *ci;
};

Which way should we go here?  We need to fix kernel or user-space, and I ne=
ed your=20
'official' touch before I post a patch in the Debian bug report I am going =
to submit.
The fix I prefer affects the user-space bluetooth include files.

My inclination is to convert user space from uint16_t=20
to uint32_t for the cnum field as this will properly byte-align the followi=
ng pointer
on a 4-byte boundary.  Some architectures throw exceptions on non-aligned p=
ointer
dereferences and accesses, and this is why I suspect the kernel may have be=
en changed.


Cheers,

Matthew Grant

PS: Following is here for reference.


Found what is wrong with hidd --show on powerpc. =20

In function do_show(), main.c, hidd

The kernel is converting the size of the cnum record entry of struct
hidp_connlist_req from 2 bytes to 4, probably in an attempt to align the
pointer on a 4 byte boundary.  The program has not been compiled to take
account of this and thinks req.cnum is zero.... If this happens on Intel
it would not show up as the returned count would be written into the
first byte of the returned 4 byte integer...  I don't know what effect
this would be having on the programs stack, but more than 15 BT
connections could result in a buffer overflow.

Need to change cnum field of struct hidp_connlist_req to a uint32 to
stop this, and it should all start working...

gdb session output follows.

(gdb) run
The program being debugged has been started already.
Start it from the beginning? (y or n) y

Starting program: /usr/src/bluetooth/debug/bluez-utils-2.11/hidd/hidd
--show

Breakpoint 1, do_show (ctl=3D7) at main.c:364
364             printf("do_show(): req.cnum %d, req.ci 0x%x\n",
req.cnum, req.ci);
(gdb) n
361             req.cnum =3D 16;
(gdb) n
355     {
(gdb) n
362             req.ci   =3D ci;
(gdb) n
364             printf("do_show(): req.cnum %d, req.ci 0x%x\n",
req.cnum, req.ci);
(gdb) n
do_show(): req.cnum 16, req.ci 0x7fffedd0
365             if (ioctl(ctl, HIDPGETCONNLIST, &req) < 0) {
(gdb) x/8xb 0x7ffff730
0x7ffff730:     0x00    0x10    0xf7    0x70    0x7f    0xff    0xed  =20
0xd0
(gdb) n
371             printf("do_show(): req.cnum %d, req.ci 0x%x\n",
req.cnum, req.ci);
(gdb) x/8xb 0x7ffff730
0x7ffff730:     0x00    0x00    0x00    0x01    0x7f    0xff    0xee  =20
0x64
(gdb)

Cheers,

Matthew Grant


On Tue, 2004-11-09 at 08:53, Marcel Holtmann wrote:
> Hi Matthew,
>=20
> > Just got debug going.  Going to put printks into hidp_get_connlist to
> > see what is happening.
> >=20
> > Your comment on the big endian bug in the L2CAP you noticed below, and
> > some of the debug I have seen with the other BT problems make it look
> > like I am having endianess issues.=20
> >=20
> > I am going to print the kernel code tonight and read it through as it i=
s
> > obvious I have to understand the stack if I am get things fixed - you
> > don't have access to an Apple machine to test things on.  In the past I
> > was a commercial router programmer, doing OSPF and IPX development.
> >=20
> > Any good places to find protocol specs?  I especially need
> > specifications on the endianess of the incoming BT data so I can audit
> > and check the debug for that sort of thing.
>=20
> everything is in the Bluetooth core and HID profile specification.
>=20
> It must not be an endian problem, because other people with Apple
> machines are using HID. May you wanna try another compiler.
>=20
> Regards
>=20
> Marcel
>=20
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Matthew Grant        /\  ^/\^   grantma@anathoth.gen.nz      /~~~~\
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\
=3D=3D=3DGPG KeyID: 2EE20270  FingerPrint: 8C2535E1A11DF3EA5EA19125BA4E790E=
2EE20270=3D=3D


--=-AzK2nB+r6T+AQ16ec5tZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBlaUMuk55Di7iAnARAsaDAJ9K0JM3pYItug3bFewsD5YIb5tUiACcC5I2
GcFFV02v6mDqug5BFIMxBrA=
=rri9
-----END PGP SIGNATURE-----

--=-AzK2nB+r6T+AQ16ec5tZ--
