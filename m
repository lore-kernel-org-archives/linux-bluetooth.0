Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Possible security vulnerability in hcid when
 calling pin helper
Message-Id: <20050805063927.3d714a89.henryk@ploetzli.ch>
In-Reply-To: <1123211794.8331.104.camel@pegasus>
References: <20050805050932.3111586d.henryk@ploetzli.ch>
	<1123211794.8331.104.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__5_Aug_2005_06_39_27_+0200_NKwzzAn=rr40Lbzg"
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
Date: Fri, 5 Aug 2005 06:39:27 +0200

--Signature=_Fri__5_Aug_2005_06_39_27_+0200_NKwzzAn=rr40Lbzg
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__5_Aug_2005_06_39_27_+0200_GXy2KcNU2bVcdoe0"


--Multipart=_Fri__5_Aug_2005_06_39_27_+0200_GXy2KcNU2bVcdoe0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Fri, 05 Aug 2005 05:16:34 +0200 schrieb Marcel Holtmann:

> thanks for catching this problem. Do you have a fix for it?

Now I have, I think. Doing string escaping in C is really awkward, but
this patch should prefix all occurences of ", \, $ or ` in the name with
an \, and will also change the enclosing single quotes to double quotes
(because no escaping is possible in single quotes). There would also be
an alternative way to fix it: remove the popen() and instead do a
pipe()/fork()/dup2()/execv() combination. That should be more clean, but
likely more complicated.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Multipart=_Fri__5_Aug_2005_06_39_27_+0200_GXy2KcNU2bVcdoe0
Content-Type: text/x-patch;
 name="callpinhelper.patch"
Content-Disposition: attachment;
 filename="callpinhelper.patch"
Content-Transfer-Encoding: quoted-printable

--- security.c.orig	2005-08-05 05:34:15.000000000 +0200
+++ security.c	2005-08-05 06:18:14.000000000 +0200
@@ -306,7 +306,7 @@ static void call_pin_helper(int dev, bda
 {
 	pin_code_reply_cp pr;
 	struct sigaction sa;
-	char addr[18], str[255], *pin, name[249];
+	char addr[18], str[255], *pin, name[249], escapename[498];
 	FILE *pipe;
 	int ret, len;
=20
@@ -331,9 +331,28 @@ static void call_pin_helper(int dev, bda
 	read_device_name(sba, &ci->bdaddr, name);
 	//hci_remote_name(dev, &ci->bdaddr, sizeof(name), name, 0);
=20
+	/* Escape special chars from the remote name */
+	{
+		char *src =3D name, *dest =3D escapename,=20
+		    *end =3D name + sizeof(name) - 1;
+		while (src < end && *src !=3D 0) {
+			switch(*src) {
+				case '\"': /* fall-through */
+				case '$':
+				case '`':
+				case '\\':=20
+					*dest++ =3D '\\';
+				default:
+					*dest++ =3D *src++;
+	    		}
+		}
+		*dest =3D 0;
+	}
+
 	ba2str(&ci->bdaddr, addr);
-	snprintf(str, sizeof(str), "%s %s %s \'%s\'", hcid.pin_helper,
-					ci->out ? "out" : "in", addr, name);
+	snprintf(str, sizeof(str), "%s %s %s \"%s\"", hcid.pin_helper,
+					ci->out ? "out" : "in", addr,=20
+					escapename);
=20
 	setenv("PATH", "/bin:/usr/bin:/usr/local/bin", 1);
=20

--Multipart=_Fri__5_Aug_2005_06_39_27_+0200_GXy2KcNU2bVcdoe0--

--Signature=_Fri__5_Aug_2005_06_39_27_+0200_NKwzzAn=rr40Lbzg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC8u2DIjWgKE0OA2gRAg1NAJ4qBYApmWsvQEe6aSPJJiK9RkbuuQCcCpOp
R0MPbMLRAtHEeRrslA8VfeU=
=yE++
-----END PGP SIGNATURE-----

--Signature=_Fri__5_Aug_2005_06_39_27_+0200_NKwzzAn=rr40Lbzg--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
