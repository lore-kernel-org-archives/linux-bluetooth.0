Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Elimar Riesebieter <riesebie@lxtec.de>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Cc: debian-powerpc <debian-powerpc@lists.debian.org>
Subject: Re: [Bluez-users] Apple bluetooth mouse
Message-ID: <20031230205918.GA946@samweis.home.lxtec.de>
References: <20031228012502.GA16798@samweis.home.lxtec.de> <20031228170349.GA1460@samweis.home.lxtec.de> <m3fzf47oa3.fsf@neo.loria> <20031230182456.GA3035@samweis.home.lxtec.de> <1072813766.2542.28.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
In-Reply-To: <1072813766.2542.28.camel@pegasus> <20031229175358.GA801@samweis.home.lxtec.de>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 30 Dec 2003 21:59:18 +0100


--LyciRD1jyfeSSjG0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Dec 2003 the mental interface of=20
Marcel Holtmann told:

> Hi Elimar,
>=20
[...] (as posted to debian-powerppc as well)
> send us "lspci -vvv" (as root) and the content of /proc/bus/usb/devices.
                                                    ^^^^^^^^^^^^^^^^^^^^^
                                                    Uuuuuuaaa grrrrr damn

Neither OHCI nor EHCI was enabled in my kernel. Changed that and the
mouse works like a charm at console and X ;-)

Thank you for that hint!

But anyway: hcitool inq like shown at
http://www.holtmann.org/linux/bluetooth/hid.html tells:
Inquiring ...
Inquiry failed.: No such device

Please find attched lspci_procdev.tar.gz:
8520 lspci_vvv.txt
2337 usb_dev.txt

Ciao

Elimar

--=20
  It's a good thing we don't get all=20
  the government we pay for.

--VS++wcV0S1rZb1Fb
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="lspci_procdev.tar.gz"
Content-Transfer-Encoding: base64

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
AA==

--VS++wcV0S1rZb1Fb--

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/8ecm3Ig8bsVPf7ARAqd3AJ4+iLMVkU1wwMqQvNA/AHXLHFgV4ACgokbQ
aS42Nv1wKvzVgFFgdHXEIEw=
=CtK5
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
