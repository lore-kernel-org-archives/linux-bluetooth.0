Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43CBC736.4070501@andric.com>
From: Dimitry Andric <dimitry@andric.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problems with smart phones when using a"silent"kernel
References: <C70061B183DE09419568AB2060C52A950177D435@arion.intra.local>
In-Reply-To: <C70061B183DE09419568AB2060C52A950177D435@arion.intra.local>
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig99492DDA3998F88E1C31A754"
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
Date: Mon, 16 Jan 2006 17:17:58 +0100

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig99492DDA3998F88E1C31A754
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Victor Shcherbatyuk wrote:
> This fixes the problem with console redirected to /dev/null.
---snip---
> +		dup2(fd, STDIN_FILENO);
> +		dup2(fd, STDOUT_FILENO);
> +		dup2(fd, STDERR_FILENO);

Heheh, yet another reason to always use daemon(3) instead of rolling your=
 own!



--------------enig99492DDA3998F88E1C31A754
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iD8DBQFDy8c5sF6jCi4glqMRA16zAKDacWjXdYP7EwCAMpgcRnBRaDYr6ACfaYpu
ycpNZJZD81l2XssHG5oY7fQ=
=qafl
-----END PGP SIGNATURE-----

--------------enig99492DDA3998F88E1C31A754--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
