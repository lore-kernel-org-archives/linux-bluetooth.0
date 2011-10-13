Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 22:14:32 +1100
From: NeilBrown <neilb@suse.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Help understanding Agent 'capabilities'.
Message-ID: <20111013221432.625e1bfd@notabene.brown>
In-Reply-To: <CABBYNZJs4zXqhPkSV6HUbLzFk7_-cuf-+kVgmw+A0hcMRCXLxw@mail.gmail.com>
References: <20111013165526.0dbbe0fc@notabene.brown>
	<CABBYNZJs4zXqhPkSV6HUbLzFk7_-cuf-+kVgmw+A0hcMRCXLxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/+/vxOvdwX.ep6dejjZsGsIN"; protocol="application/pgp-signature"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Sig_/+/vxOvdwX.ep6dejjZsGsIN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Oct 2011 10:39:22 +0300 Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

> Hi Neil,
>=20
> On Thu, Oct 13, 2011 at 8:55 AM, NeilBrown <neilb@suse.de> wrote:
> >
> > Hi,
> > =A0I've been trying enhance my understanding of bluetooth and as part o=
f that
> > =A0I have been experimenting with simple-agent to create pairing betwee=
n two
> > =A0Linux hosts (a phone and a laptop as it happens).
> >
> > =A0My understanding of Secure Simple Pairing is that there are a number=
 of
> > =A0authentication mechanism and that the "best" would be chosen based o=
n the
> > =A0that capabilities given to the agent.
> >
> > =A0So if both devices tell the monitor "DisplayYesNo", it would not be =
able to
> > =A0do Passkey entry and would choose Numeric comparison.
> > =A0So both agents would get RequestConfirmation call backs.
> >
> > =A0But I cannot make that happen.
> >
> > =A0No matter what capability I give to simple-agent, one of them asks m=
e for a
> > =A0pass key, then the other one does, and they have to match. =A0i.e. t=
hey both
> > =A0get RequestPinCode.
> > =A0So they seem to be assuming at least one device has a keyboard (the =
first
> > =A0could generate a number in the agent and display it I guess).
> >
> > =A0Is there something else I have to change to force it to use Numeric
> > =A0comparison (or even 'just works') authentication? =A0Is this documen=
ted
> > =A0somewhere?
> >
> > =A0I'm using 4.88 on one system and 4.96 on the other.
>=20
> For SSP you need both controllers to be >=3D 2.1, if you are seeing
> pincode requests then probably one or both controller are using legacy
> pairing.
>=20

Thanks.  That does explain it.

I knew about that but must have been confusing 'pass code' and 'pin code' in
my mind and so thought it didn't look like the legacy version.

What is the easiest way to find out what bluetooth version the controller is
using?  I tried looking around and didn't find anything obvious.
Or is the LegacyPairing property the best hint?

Thanks again (and to Johan).

NeilBrown


--Sig_/+/vxOvdwX.ep6dejjZsGsIN
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTpbIIDnsnt1WYoG5AQJpQBAAn9WxgLNjSSBAO/C2OZt9JafC6fufULwj
A5WeQDzaLZR/xW1JghT8mbQ9SE6/ONuiUxLptirNTlN5j8wxy8MveXMdQALH3vOW
4/VffECHl01LiTQ6snCF9ccdOC+SJtJMgnm0kOk7gKiN+omRsihrviLXfiw6FFOs
mgzrcDnQgFPAGKUIzE9I1dX22VkNHZmjNyJgEK0Cy3udpJlieFp5NNZp07jEPwWl
kDruG4uuisBkBD85DQ93ohUkc4VovJCaejWWbc0hsRzXm06sM/ywHpLGEnZQnXSO
jpPmHp7ur1nsh7SV612wfHbQSIZJsvY7F3RREmx9rj23bEG2BMYgqYcW1fQonul2
fI9UliIwQuqke4fEjNOs95mMfiXDrxpWVg/fgjEAT8fJyc6iSAGju1w1AF9hCAFk
FYOz+o76bWhKyLC8zuseijsmFiNO1UDfuwcUtiaCo4dZLgBakjHOj7YeSYUcQUnz
j7TiIVqch0CVQREJayCNhUnwB8koZOVXBG/XRjY5Gh9dVtpSjiS8q30iN1DmP8SH
k9ELsInvQBfiY6BVWC+90imyaeNZvSWQcPNm8YYksApo1KIDqKgMe2GXZurDly9M
5qriHkBuD9ISQ67Srx/lzh+9an/cwQZbQaARRaIIaSkmeOa95S6fhgnxVzUE6aZO
3vi0PX8PVCM=
=knXY
-----END PGP SIGNATURE-----

--Sig_/+/vxOvdwX.ep6dejjZsGsIN--
