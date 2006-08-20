Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 20 Aug 2006 15:00:01 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060820130001.GA30473@esaurito.net>
References: <20060820103420.GB11669@esaurito.net>
	<1156083893.23331.3.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
In-Reply-To: <1156083893.23331.3.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] handling of default outgoing pin in hcid
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0716987130=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0716987130==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Marcel,

On Sun, Aug 20, 2006 at 04:24:53PM +0200, Marcel Holtmann wrote:
> the idea of a default PIN for outgoing connections is actually kinda
> stupid. You don't wanna do this on a system with input capabilities. And
> so far we never had a default PIN for outgoing connections.

I was thinking more of a "fallback" pin, also I don't see how it is stupid to do
have a default outgoing pin, it is not obvious whether you have input
capabilities. Do you mind expanding on this? I would like to understand your
point better.

> Check the bluez-gnome CVS repository. It now contains a fully
> replacement for the bluez-pin that works with the new passkey agent
> interface of hcid. It is only based on GTK and the D-Bus GLib bindings
> and works pretty well so far.

thanks! I was just looking for a replacement, is it released somewhere or just
onto cvs?

filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

UNIX IS user friendly, it is just selective who his friends are.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE6FzRABzeamt51AERAuB8AKC7KsDXFszzZsYGrGsUNOe99EGqJwCcDasp
fGQLE6fklYYummHPEEg52K0=
=ArL1
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--


--===============0716987130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0716987130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0716987130==--
