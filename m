Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Filippo Giunchedi <filippo@debian.org>
To: 322732@bugs.debian.org, 322732-submitter@bugs.debian.org
Cc: bluez-devel@lists.sf.net, control@bugs.debian.org
Message-ID: <20060519204815.GA8424@esaurito.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Subject: [Bluez-devel] more on this bug (was: rfcomm bind fails with obscure error message)
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
Date: Fri, 19 May 2006 15:48:15 -0500


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

tags 322732 + upstream
thanks

> Hello
>=20
> When the 'rfcomm' kernel module isn't compiled with CONFIG_BT_RFCOMM_TTY
> enabled, 'rfcomm bind' will fail with an obscure error message, "Can't
> create device: Operation not supported".  It does this when it's trying to
> bind to a device in /dev.
>=20
> Could this be changed to report something more useful, such as "Check
> rfcomm.ko is compiled with TTY support"?

Hi,
I agree with this bug and the ioctl is mostly likely to fail when there is =
no
rfcomm tty support, here is my proposed patch:

--- rfcomm/main.c       (revision 154)
+++ rfcomm/main.c       (working copy)
@@ -172,8 +172,10 @@
                        req.channel =3D 1;
        }

-       if ((err =3D ioctl(ctl, RFCOMMCREATEDEV, &req)) < 0 )
+       if ((err =3D ioctl(ctl, RFCOMMCREATEDEV, &req)) < 0 ){
                perror("Can't create device");
+               fprintf(stderr, "Check RFCOMM TTY availabily");
+    }

        return err;
 }

comments?=20

thanks,
filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

What a strange illusion it is to suppose that beauty is goodness.
-- Lev Tolstoj

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEbi8PABzeamt51AERAv29AKC5PztbVvEhaVZD++k6BrXmjRtg9wCgl0zY
slzVlPFU33OucGszgMmIRJk=
=FBmy
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
