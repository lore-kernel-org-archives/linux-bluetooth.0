Return-Path: <sre@kernel.org>
Date: Thu, 13 Apr 2017 02:26:41 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>,
	Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv3 00/10] Nokia H4+ support
Message-ID: <20170413002641.ypeofsh57fdiis5g@earth>
References: <20170328155939.31566-1-sre@kernel.org>
 <CAL_JsqJcQ9ANtt71KRitOJ9spKD1SaeoL4RDftiCEPs8TjLJGA@mail.gmail.com>
 <C1A408F2-1DF8-4F49-B399-B936542DE6BC@holtmann.org>
 <20170331133353.GA32267@kroah.com>
 <CAL_Jsq+NU3M5yuBpK1UGgzCVvq0eABMApCqEe3_d5+tDaABsgQ@mail.gmail.com>
 <20170410231041.vz35anezpzhscu4t@earth>
 <4FEFA1D8-BE23-40FB-BAA3-3EC910FE9F96@holtmann.org>
 <20170411140637.GA4388@kroah.com>
 <C16140C4-0264-411B-9058-0B9013AAC82F@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zyphekhu7hwajixy"
In-Reply-To: <C16140C4-0264-411B-9058-0B9013AAC82F@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--zyphekhu7hwajixy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Wed, Apr 12, 2017 at 10:19:21PM +0200, Marcel Holtmann wrote:
> Hi Sebastian,
>=20
> >>>>>>>> Here is PATCHv3 for the Nokia bluetooth patchset. I addressed al=
l comments from
> >>>>>>>> Rob and Pavel regarding the serdev patches and dropped the *.dts=
 patches, since
> >>>>>>>> they were queued by Tony. I also changed the patch order, so tha=
t the serdev
> >>>>>>>> patches come first. All of them have Acked-by from Rob, so I thi=
nk it makes
> >>>>>>>> sense to merge them to serdev subsystem (now) and provide an imm=
utable branch
> >>>>>>>> for the bluetooth subsystem.
> >>>>>>>=20
> >>>>>>> Greg doesn't read cover letters generally and since the serdev pa=
tches
> >>>>>>> are Cc rather than To him, he's probably not planning to pick the=
m up.
> >>>>>>=20
> >>>>>> I wonder actually if we should merge all of these via bluetooth-ne=
xt
> >>>>>> tree with proper Ack from Greg. However it would be good to also g=
et
> >>>>>> buy in from Dave for merging this ultimately through net-next.
> >>>>>=20
> >>>>> I don't really care where it goes.  I can take the whole thing in my
> >>>>> tty/serial tree now if no one objects and I get an ack from the rel=
evant
> >>>>> maintainers {hint...}
> >>>>=20
> >>>> I think it is better if it goes thru BT tree. I have another driver
> >>>> converted that is dependent on this series. There's a couple other
> >>>> serdev changes on the list too, but this shouldn't depend on them.
> >>>=20
> >>> Is this waiting for something, or could it be queued to
> >>> bluetooth-next then? It would be nice to finally have
> >>> this in 4.12 :)
> >>=20
> >> I would prefer if we can get an ACK from Greg. Then I merge it through=
 the bluetooth-next tree.
> >=20
> > Sorry thought this was coming through mine:
> > 	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >=20
> > Merge away!
>=20
> so I have applied patches 1-8 to bluetooth-next tree.
>=20
> The last 2 I left out since they do cause build issues on non-DT
> platforms. We need to be able to build the driver on all platforms
> so that sanity compile checks happen all the time.
>=20
>   CC      drivers/bluetooth/hci_nokia.o
> drivers/bluetooth/hci_nokia.c:802:34: error: array type has incomplete el=
ement type =E2=80=98struct of_device_id=E2=80=99
>  static const struct of_device_id nokia_bluetooth_of_match[] =3D {
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/bluetooth/hci_nokia.c:803:4: error: field name not in record or u=
nion initializer
>   { .compatible =3D "nokia,h4p-bluetooth", },
>     ^
> drivers/bluetooth/hci_nokia.c:803:4: note: (near initialization for =E2=
=80=98nokia_bluetooth_of_match=E2=80=99)
> drivers/bluetooth/hci_nokia.c:815:21: error: implicit declaration of func=
tion =E2=80=98of_match_ptr=E2=80=99 [-Werror=3Dimplicit-function-declaratio=
n]
>    .of_match_table =3D of_match_ptr(nokia_bluetooth_of_match),
>                      ^~~~~~~~~~~~
> drivers/bluetooth/hci_nokia.c:802:34: warning: =E2=80=98nokia_bluetooth_o=
f_match=E2=80=99 defined but not used [-Wunused-variable]
>  static const struct of_device_id nokia_bluetooth_of_match[] =3D {
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~

Building without CONFIG_OF should work already. Note, that its
actually enabled in your build, since nokia_bluetooth_of_match
is guarded by "#ifdef CONFIG_OF". The actual problem is, that
<linux/of.h> is not included in your build. Looks like it was
implicitly included in my configurations, so I didn't notice.
I will send PATCHv4 with the added include and includes sorted
alphabetically.

-- Sebastian

--zyphekhu7hwajixy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljuxb8ACgkQ2O7X88g7
+ppH8g//Wv9ukhxEOa2T0ZCLhhWnIL0i7k80USILvnJpP3pwBSQt2uHxOQ+ILlYe
h7Z6jN2uoGOaB4KYz2satUTdNZJHZyZ2ikWyczlMUmEjuvBWfvVPJdygowbar8zM
N/4O1BO+tLPYg90GslwodNIip67cJPk7tsUcfsz5Hnwh5FvFrt47x24ejBcXhjN3
WjUEyLMzZxLktdSMGO64Az3udsdgcfbcQTHmzSAeQVKzDpz5k52p+zOwdbTkPvFA
fUW1my2deNXOopn9mTeLRg1qVVAimq3V01JEoQcozKEXFCRsnx0DRQzDi4ShMoP2
jkrqwbfxGLoqLFr80AZAMrQbXYPyHawGmtu1xufvLqvWViwUvcn/vT07oPgGQSvr
5UUeLCXOxPgDM1l2BtWNr1Ddn3hNF4zSns7xJHDyHwOSmGWqXX89Gqw1/H7gTBz+
O2v+T0mFf88QRVLLsHrPV+DUEknQO+US0sjFQuwxhyFN0++a/BDE6u9ggWGCBSMY
4cO+r863UcXVsPipx2g1ixuWEpVscuFVybu63nobfHX92FQTI8QNrRFcHZKgBuY9
HpRtk21Q7S/7vxBPm+jKtbbJXwJ3lGOBSX7uPLOTK1fZpOmk4YEPWMe1vQa6uM4R
zkt6B3SeqVpZttERT1TKA1lulCWaegF99faFh80DfJenMqKMkgI=
=LMr4
-----END PGP SIGNATURE-----

--zyphekhu7hwajixy--
