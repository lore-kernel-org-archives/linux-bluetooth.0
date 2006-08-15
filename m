Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 15 Aug 2006 19:12:40 -0300
From: redondos <redondos@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060815221240.GG15576@refinery.twat.com.ar>
References: <20060803043158.GA13259@refinery.twat.com.ar>
	<20060815020521.GE15576@refinery.twat.com.ar>
	<1155622848.11881.4.camel@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <1155622848.11881.4.camel@localhost.localdomain>
Subject: Re: [Bluez-users] Cannot transfer files via OBEX
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0955102526=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0955102526==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j2AXaZ4YhVcLc+PQ"
Content-Disposition: inline


--j2AXaZ4YhVcLc+PQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14 23:20, Steven Yap wrote:
> On Mon, 2006-14-08 at 23:05 -0300, redondos wrote:
> >                                                            =20
> > Summary: Can *always* download, can *never* upload.=20
> >=20
> > redondos@injector redondos $ obexftp -b 00:16:20:F1:47:68 -B 6 -c Sound=
s -p Overdub2.mp3
>=20
> For some reason, with Sony Ericsson phones, you need to use -C instead
> of -c to upload, even if the directory already exist.

Thanks for your reply, Steven. Unfortunately, that didn't help, either.

After testing on my laptop, then on my desktop, reconnects,
enabling/disabling bluetooth, installing packages and testing some more,
it started working. Magically[1].

[533] # obexftp -b 00:16:20:F1:47:68 -B 6 -p AppleZ52046400.thm=20
Browsing 00:16:20:F1:47:68 ...
Channel: 6
Connecting...done
Sending "AppleZ52046400.thm"...|done
Disconnecting...done

[524] # ussp-push /dev/rfcomm0 MailaRed47045.thm Themes/Maila.thm
name=3DMailaRed47045.thm, size=3D266240
Connection established

It looks like the phone is deciding where to put the files. If I try to
name them "Themes/themename.thm", then that's the exact name they get,
inside the Themes folder. Same thing for Pictures, Sounds, etc.

[1] Not so magically. I think my USB dongle is of a questionable
quality, or maybe it is the phone. Suspended opinion until further
investigation.

I have to move the phone *very* close to the USB dongle for the transfer
to work. Almost touching it. Otherwise it just stalls for a few seconds
then it exits as it did in my previous logs.

One curiosity: l2ping replies are received even if I move the phone 3
meters away from the computer, without affecting the latency
substantially. Shouldn't the OBEX protocol be more friendly to
connection errors? Or is it not the protocol but the programs? ussp-push
behaves in the same way.

Thanks everyone for all the fish, will come back to this issue if more
problems arise, which means I guess I'll definitely be back soon.

--=20
redondos

--j2AXaZ4YhVcLc+PQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFE4kbYJZ/yCc25j3IRAjoUAJ9NFlU7hthoci+FkteO8Er1rFN3ngCffAQ+
DkjmmOdhzW2IeOehMnQUmc4=
=M1VX
-----END PGP SIGNATURE-----

--j2AXaZ4YhVcLc+PQ--


--===============0955102526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0955102526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0955102526==--
