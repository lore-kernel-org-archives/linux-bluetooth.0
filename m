Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 29 Nov 2007 11:37:46 -0700
From: Rob Sims <bluez-z@robsims.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20071129183746.GB17661@robsims.com>
References: <20070522161255.GA9813@robsims.com>
	<20071129155526.GA17661@robsims.com>
	<d89ddf300711290845l5162bca2l16dfdf6c902cfa92@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <d89ddf300711290845l5162bca2l16dfdf6c902cfa92@mail.gmail.com>
Subject: Re: [Bluez-users] Sharing devices with dual-booted Windows
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0549111156=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0549111156==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2007 at 09:45:02AM -0700, Brad Midgley wrote:
> > If it's soft, how does one assign the desired "fake" bdaddr to the host
> > adapter?  With network devices, 'ifconfig hw' does the job.
=20
> Sorry I didn't really answer this before. I'm trying to remember who
> told me about bdaddr hacks.
=20
It would be appreciated. =20

> > Alternatively, can the pairing info be extracted from the Windows side
> > and translated to the Linux side?
>=20
> That would require digging into some registry etc internals in
> windows, so this list would only be helpful once you've dug up the
> credentials there first.

I did some digging in May and was unable to find where Windows hides its
pairing info.  I'd probably have to diff the registry before and after a
pairing to narrow it down. =20

This list seemed to be the most likely candidate for users of both
stacks; Windows fora users would have no reason to extract such data.
--=20
Rob

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHTwb6nvKppSZW8osRAl2OAJ9eXI/6O7qChPQ7vbLQj5pJerWCtACfaoe7
m2IJGELuh8CNnwg29H6+dbM=
=Z2aE
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--


--===============0549111156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============0549111156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0549111156==--
