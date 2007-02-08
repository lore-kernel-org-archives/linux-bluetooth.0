Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Jon Barnett <jbarnett@pobox.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45CB36E2.7000406@free.fr>
References: <1170700026.3240.56.camel@localhost>
	<eq9ugs$63s$1@sea.gmane.org>  <45CB36E2.7000406@free.fr>
Date: Thu, 08 Feb 2007 11:54:33 -0500
Message-Id: <1170953673.3329.11.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Plugz with Dell inbuilt-BT
Reply-To: jbarnett@pobox.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0953636732=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0953636732==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-970H/Zc9y0wYjD3wGgAT"


--=-970H/Zc9y0wYjD3wGgAT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The problem with the bt-hijacker approach is that it is based on the
snd-bt-sco module which creates the necessary /dev/dspX entry for
re-routing sound. The plugz approach doesn't result in the creation of
a /dev/dspX. So the hijacker can't reroute the sound as far as I can
see. Or am I missing something?

Cheers,

JonB

On Thu, 2007-02-08 at 15:42 +0100, Fabien Chevalier wrote:
> Hi,
>=20
> Mark Hellman wrote:
> > Jon Barnett wrote:
> >=20
> >> The only problem is that skype can't use the plugz device as it doesn'=
t
> >> recognize it  - since it doesn't do detection of available pcm devices=
.
> >=20
> >>From a user's perspective that is, in my opinion, the main problem with
> > using plugz instead of btsco. Skype and Ekiga are the reasons why 90% o=
f
> > users want to install plugz.
> >=20
> > Is this an ALSA limitation, or isn't Skype using the right functions fr=
om
> > the ALSA's API to enumerate all available devices? Who must be fixes: S=
kype
> > of ALSA?
>=20
> Thing is : sadly, there is no ALSA function to enumerate available PCMs=20
> on the system. There are only features to enumerate hardware cards.=20
> That's a known ALSA weakness, but this is how things are as of to today=20
> in Linux world :-(
>=20
> > Could some developer enlighten us on this issue?
>=20
> Just use Skype in OSS mode, and use skype_bt_hijacker available in=20
> contrib directory to redirect sound to ALSA headset. I haven't tested it=20
> myself recently, but theorically this should work.
>=20
> Cheers,
>=20
> Fabien
>=20
>=20
>=20

--=-970H/Zc9y0wYjD3wGgAT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFy1XJu2cEic/xsEARAhG7AJ9+CcqWYTB2NqFywKFFxQz1Ni3mhgCeKcT/
eU6aiKDmYnX3mrAdw1TzT9Q=
=e2rm
-----END PGP SIGNATURE-----

--=-970H/Zc9y0wYjD3wGgAT--



--===============0953636732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0953636732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0953636732==--
