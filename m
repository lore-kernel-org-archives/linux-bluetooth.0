Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 15 Aug 2006 19:17:19 -0300
From: redondos <redondos@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060815221719.GH15576@refinery.twat.com.ar>
References: <44E237D5.50202@zubrowka.org>
MIME-Version: 1.0
In-Reply-To: <44E237D5.50202@zubrowka.org>
Subject: Re: [Bluez-users] Problem transferring file to a Sony T630 cellular
	phone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2059774752=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============2059774752==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15 23:08, Emmanuel Lesouef wrote:
> Hello bluez-users list,
>=20
> I'm currently trying to setup the communication between my laptop and my
> cell phone (Sony Ericsson T630)
>=20
> elesouef@lothlorien:~$ hcitool scan
> Scanning ...
>         00:0F:DE:CB:D4:04       Manu-T630
> elesouef@lothlorien:~$ sdptool browse 00:0F:DE:CB:D4:04 |grep "Service Na=
me"
> Service Name: Dial-up Networking
> Service Name: Voice gateway
> Service Name: Serial Port 1
> Service Name: Serial Port 2
> Service Name: OBEX Object Push
> Service Name: IrMC Synchronization
> Service Name: HF Voice gateway
> Service Name: OBEX Basic Imaging
> Service Name: OBEX File Transfer
>=20
> Everything seems to be OK for now.
>=20
> I tried the simple way (gnome-bluetooth, "Send file to..." etc...) but
> that didn't work and I didn't saw any messages on the cellular.
>=20
> I then tried obexftp :
>=20
> elesouef@lothlorien:~$ obexftp -b -l
> Scanning ...
> Using   00:0F:DE:CB:D4:04       Manu-T630
> Failed to connect to SDP server: Operation already in progress

Maybe the error message was exactly the answer to your question. Give it
a few seconds and try again. If it doesn't work, try restarting the sdp
daemon, as well.

But maybe not, maybe you need to specify the channel number in which
your phone listens for OBEX-push transfers. sdptool should tell you that,=
=20
without the grepping, of course. :)

Once you find that out, try:

$ obexftp -b 00:0F:DE:CB:D4:04 -B <channel> -l

I think that'll work.

> I suppose there's something wrong in my setup.

I don't think so. I have been experiencies more or less the same
problems. Most of them can be worked around by knowing (with a little
experience) when/what to do when something fails. Usually, waiting until
my phone's Bluetooth icon "idles" is enough, but sometimes a little more
fiddling is required.

> Anyone got an idea ?

--=20
redondos

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFE4kfvJZ/yCc25j3IRAm9dAKCUxUEYtudbykOkcpxz6pFiXibvdACfV6s0
26apA+HlnH8FQCccAs1MHyo=
=Z8uP
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--


--===============2059774752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2059774752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2059774752==--
