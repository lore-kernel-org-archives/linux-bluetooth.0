Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Filippo Giunchedi <filippo@esaurito.net>
To: 297566@bugs.debian.org
Cc: 297566-submitter@bugs.debian.org, bluez-devel@lists.sf.net
Message-ID: <20060113160524.GD10969@esaurito.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Subject: [Bluez-devel] Re: bluez-utils: hcid.conf(5) manpage has incomplete description of pin_helper parameter
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
Date: Fri, 13 Jan 2006 17:05:24 +0100


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I've added a few lines to hcid.conf.5, please see if they are okay (bluez-d=
evel:
could you confirm that this information is correct and eventually commit it=
?)

Index: hcid.conf.5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- hcid.conf.5 (revision 136)
+++ hcid.conf.5 (working copy)
@@ -49,6 +49,9 @@
 \fBpin_helper\fP "\fIfile\fP"
 =20
The path to the PIN helper application. The default is "/bin/bluepin".
+The PIN helper is invoked with the direction of request (in/out), the blue=
tooth
+destination address and the device name as parameters.
+(e.g. /bin/bluepin out aa:bb:cc:dd:ee:ff "my device")
The following output is expected from the PIN helper:
    =20
PIN:12345678

thanks,
filippo
--
Filippo Giunchedi
PGP key: 0x6B79D401
random quote follows:

In God we trust, everybody else pays cash.
-- somewhere in England=20

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDx8/EABzeamt51AERAoUfAKC7Y1W55twSrPESe/yKKd7U3673rQCgqQkj
BiDyU+LvGmKKE6ZhOYh8C/k=
=h0qn
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
