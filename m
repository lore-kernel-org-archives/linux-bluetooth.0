Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] confusion about libs/sdp.c -
	sdp_service_search_req()
From: Stephen Crane <steve.crane@rococosoft.com>
To: albert@csail.mit.edu
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <ef9938ec0503020048272b98c7@mail.gmail.com>
References: <ef9938ec05022511243993f46d@mail.gmail.com>
	 <1109579650.17256.29.camel@pegasus>
	 <1109593239.14742.131.camel@baroque.rococosoft.com>
	 <ef9938ec0503020048272b98c7@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7gJOUqpXCJgBk6xLVOZR"
Message-Id: <1109759008.23661.178.camel@baroque.rococosoft.com>
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
Date: Wed, 02 Mar 2005 10:23:28 +0000


--=-7gJOUqpXCJgBk6xLVOZR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Albert,
I have made the changes as you suggest. In future, it would probably be
just as easy for you to send patches, right?

Thanks,
Steve

On Wed, 2005-03-02 at 03:48 -0500, Albert Huang wrote:
> it appears that the internal documentation for sdp_record_register is
> also incorrect.
>=20
> libs/src/sdp.c:2288
>  *
>  * Returns a non-null value (a pointer) to a service
>  * record if successful, else -1 setting errno
>  */
>=20
> I think it should read something like:
>  *
>  * Returns zero if successful, also setting rec->handle=20
>  * else -1 setting erro
>  */
>=20
> You may also want to update libs/include/sdp_lib.h to indicate the
> behavior of sdp_record_register
>=20
> Regards,
> Albert
>=20
> On Mon, 28 Feb 2005 12:20:38 +0000, Stephen Crane
> <steve.crane@rococosoft.com> wrote:
> > Hi Albert, Marcel,
> >=20
> > The documentation is incorrect: the correct behaviour of
> > sdp_service_search_req() is that it returns a list of service record
> > handles --- you then use sdp_search_attr_req() to fetch attributes of
> > interest. Alternatively, you can use sdp_search_attr_req() to perform a
> > combined search.
> >=20
> > I have fixed the comment in CVS.
> >=20
> > Thanks,
> > Steve
> >=20
> > On Mon, 2005-02-28 at 09:34 +0100, Marcel Holtmann wrote:
> > > Hi Albert,
> > >
> > > > the documentation for sdp_service_search_req() states that it outpu=
ts
> > > > an sdp_list_t * of sdp_record_t * (list of sdp service records)
> > > >
> > > > reading through the code, it appears that it actually returns a lis=
t
> > > > of uint32_t * data structures.
> > > >
> > > > line 2721:
> > > >         extract_record_handle_seq(pdata, rsp, rec_count, &scanned);
> > > >
> > > >
> > > > line 2523:
> > > > static void extract_record_handle_seq(char *pdu, sdp_list_t **seq, =
int
> > > > count, int *scanned)
> > > > {
> > > >     sdp_list_t *pSeq =3D *seq;
> > > >     char *pdata =3D pdu;
> > > >     int n;
> > > >
> > > >     for (n =3D 0; n < count; n++) {
> > > >         uint32_t *pSvcRec =3D (uint32_t *) malloc(sizeof(uint32_t))=
;
> > > >         *pSvcRec =3D ntohl(bt_get_unaligned((uint32_t *) pdata));
> > > >         pSeq =3D sdp_list_append(pSeq, pSvcRec);
> > > >         pdata +=3D sizeof(uint32_t);
> > > >         *scanned +=3D sizeof(uint32_t);
> > > >     }
> > > >     *seq =3D pSeq;
> > > > }
> > > >
> > > > I think this will cause segfaults when you try to sdp_record_free t=
he
> > > > records in the list (it does for me).
> > > >
> > > > perhaps it shold read something more like:
> > > >         sdp_record_t *pSvcRec =3D (sdp_record_t*) malloc(sizeof(sdp=
_record_t));
> > > >         pSvcRec->attrlist =3D pSvcRec->pattern =3D 0;
> > > >         pSvcRec->handle =3D ntohl(bt_get_unaligned((uint32_t *) pda=
ta));
> > > >         pSeq =3D sdp_list_append(pSeq, pSvcRec);
> > >
> > > Steve, any thoughts on this one?
> > >
> > > Regards
> > >
> > > Marcel
> > >
> > >
> >=20
> > -------------------------------------------------------
> > SF email is sponsored by - The IT Product Guide
> > Read honest & candid reviews on hundreds of IT Products from real users=
.
> > Discover which products truly live up to the hype. Start reading now.
> > http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >

--=-7gJOUqpXCJgBk6xLVOZR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCJZQglgMqgVzLyWcRAhFoAJ9r4JoBHiQ2GKqjUN0eU6FJAiedowCfenOe
J5ME/YHHZ42F7WX9LocnXxo=
=fvX3
-----END PGP SIGNATURE-----

--=-7gJOUqpXCJgBk6xLVOZR--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
