Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 29 Nov 2007 13:44:42 -0700
From: Rob Sims <bluez-z@robsims.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20071129204442.GC17661@robsims.com>
References: <20070522161255.GA9813@robsims.com>
	<20071129155526.GA17661@robsims.com>
	<d89ddf300711290845l5162bca2l16dfdf6c902cfa92@mail.gmail.com>
	<d89ddf300711291206g56544e3cud237a2f71355fc93@mail.gmail.com>
	<81AD8A6B-9825-4641-951F-FEE9A0DE20C4@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <81AD8A6B-9825-4641-951F-FEE9A0DE20C4@holtmann.org>
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
Content-Type: multipart/mixed; boundary="===============0412491921=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0412491921==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2007 at 09:15:23PM +0100, Marcel Holtmann wrote:
> > fwiw, the only thing I could find would work only for csr chips using
> > bccmd from bluez-utils/tools (configure --enable-bccmd). Get the
> > bdaddr to see how the bytes are swapped around:

> > bccmd psget bdaddr

> > then set and reset the adapter (sometimes these commands take two =20
> > goes to take)

> > bccmd psset -r bdaddr 0x2000 0xaf9b 0xf400 0x0800

> > I could give this a whack tonight.
=20
> using the bdaddr command is much simpler. It does the magic of =20
> bringing the address into the right format.
=20
> > fyi, bccmd can brick the adapter (eg if you use "-s" to make bad
> > settings permanent). It would be nice if someone who fiddles with csr
> > stuff can verify this approach.

> Take this warning serious. You can really brick your dongle.

It appears from the behavior described above and a sample CSR datasheet
that PS is "Persistent Store."  This means that not only would I have to
run this each time starting Linux, I'd have to restore the original
bdaddr in Linux before booting to Windows.

Also, this is a built-in adapter in a Thinkpad; it's significantly more
expensive than a dongle to fix, even if it might be a CSR core. =20

Thanks for settling this - there is no way to soft-set (change
disappears on reset) the bdaddr of existing bluetooth adapters.
--=20
Rob

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHTyS6nvKppSZW8osRAu5/AJ9Bpf1hGtUOZB1iRSi9UFuJI2DJGwCcCRHD
Pk7t0r2mcJu35ba8HPJ7jr0=
=9G5p
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--


--===============0412491921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============0412491921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0412491921==--
