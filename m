Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Max Krasnyansky'" <maxk@qualcomm.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
Date: Wed, 14 May 2003 15:24:09 -0700
Message-ID: <001801c31a67$8a8288b0$1a01010a@baked>
MIME-Version: 1.0
In-Reply-To: <001401c31a5d$7ba2bf90$1a01010a@baked>
Content-Type: text/plain; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Max,

Got to it a bit quicker than expected. I haven't needed to change rctest fo=
r
testing, so I haven't modified that one yet.

Here's the diff.

-Daryl.

*** /home/daryl/bluez/bluez-utils-2.3/test/l2test.c	Wed May 14 15:11:32
2003
--- l2test.c	Wed May 14 15:10:58 2003
***************
*** 71,76 ****
--- 71,79 ----
  bdaddr_t bdaddr;
  unsigned short psm =3D 10;
 =20
+ /* Default number of blocks to send */
+ int num_blocks =3D -1; // Infinite
+=20
  int master =3D 0;
  int auth =3D 0;
  int encrypt =3D 0;
***************
*** 324,330 ****
  		buf[i]=3D0x7f;
 =20
  	seq =3D 0;
! 	while (1) {
  		*(uint32_t *) buf =3D htobl(seq++);
  		*(uint16_t *)(buf+4) =3D htobs(data_size);
  	=09
--- 327,333 ----
  		buf[i]=3D0x7f;
 =20
  	seq =3D 0;
! 	while ((num_blocks =3D=3D -1) || (num_blocks-- > 0)) {
  		*(uint32_t *) buf =3D htobl(seq++);
  		*(uint16_t *)(buf+4) =3D htobs(data_size);
  	=09
***************
*** 386,394 ****
  	printf("Options:\n"
  		"\t[-b bytes] [-S bdaddr] [-P psm]\n"
  	       	"\t[-I imtu] [-O omtu]\n"
  		"\t[-D] use connectionless channel (datagram)\n"
  		"\t[-E] request encryption\n"
- 		"\t[-E] request encryption\n"
  	       	"\t[-M] become master\n");
  }
 =20
--- 389,397 ----
  	printf("Options:\n"
  		"\t[-b bytes] [-S bdaddr] [-P psm]\n"
  	       	"\t[-I imtu] [-O omtu]\n"
+ 	        "\t[-N num] send num blocks (default =3D infinite)\n"
  		"\t[-D] use connectionless channel (datagram)\n"
  		"\t[-E] request encryption\n"
  	       	"\t[-M] become master\n");
  }
 =20
***************
*** 402,408 ****
 =20
  	mode =3D RECV; need_addr =3D 0;
  =09
! 	while ((opt=3Dgetopt(argc,argv,"rdscuwmnb:P:I:O:S:MAED")) !=3D EOF) {
  		switch(opt) {
  		case 'r':
  			mode =3D RECV;
--- 405,411 ----
 =20
  	mode =3D RECV; need_addr =3D 0;
  =09
! 	while ((opt=3Dgetopt(argc,argv,"rdscuwmnb:P:I:O:S:N:MAED")) !=3D EOF) {
  		switch(opt) {
  		case 'r':
  			mode =3D RECV;
***************
*** 477,482 ****
--- 480,489 ----
  			socktype =3D SOCK_DGRAM;
  			break;
 =20
+ 		case 'N':
+ 			num_blocks =3D atoi(optarg);
+ 			break;
+=20
  		default:
  			usage();
  			exit(1);



> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net=20
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of=20
> Daryl Van Vorst
> Sent: May 14, 2003 2:12 PM
> To: 'Max Krasnyansky'; 'Marcel Holtmann'
> Cc: 'BlueZ Mailing List'
> Subject: RE: [Bluez-devel] Qualification Testing
>=20
>=20
> Max,
>=20
> > >Another addition to l2test (and maybe rctest) that would be
> > handy for
> > >testing is an option to specify how many packets to send. It
> > would be
> > >nice to have the option of sending only a few packets=20
> rather than an
> > >infinite number. None of the tests that I've encountered so=20
> > far require
> > >sending large amounts of data... Just a packet or two. For rfcomm
> > >testing I could probably just do an "rfcomm connect /dev/something=20
> > >etc.." and redirect something small to /dev/something if rctest is=20
> > >causing trouble.
> > Go for it. I mean l2test/rctest changes. And sent us a patch(es).
>=20
> Ok. Will do. I probably won't be able to get to it for a=20
> while, but I don't
> think anyone else cares at the moment anyway. ;)
>=20
> -Daryl.
>=20
>=20
>=20
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
> The only event dedicated to issues related to Linux=20
> enterprise solutions
> www.enterpriselinuxforum.com
>=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20
