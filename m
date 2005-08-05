Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20050805050932.3111586d.henryk@ploetzli.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__5_Aug_2005_05_09_32_+0200_7he+o9mtEMpn0SbP"
Subject: [Bluez-devel] Possible security vulnerability in hcid when calling pin helper
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
Date: Fri, 5 Aug 2005 05:09:32 +0200

--Signature=_Fri__5_Aug_2005_05_09_32_+0200_7he+o9mtEMpn0SbP
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

(I'm using a Gentoo Linux box with kernel 2.6.12.1, hcid 2.18 and
kbluepin from kbluetoothd 0.99-beta1; although the problem seems=20
to still exist in current CVS hcid and should be independent of=20
the pin helper used.)

I just stumbled upon a bug in hcid that can possibly be used as a
security vulnerability: In hcid/security.c (around line 335 in current
CVS) the device name from the remote device is copied straight into the
command line that is used to call the pin helper, only surrounded by a
pair of single quotes with _no_ _escaping_ done:

| read_device_name(sba, &ci->bdaddr, name);
| //hci_remote_name(dev, &ci->bdaddr, sizeof(name), name, 0);
|
| ba2str(&ci->bdaddr, addr);
| snprintf(str, sizeof(str), "%s %s %s \'%s\'", hcid.pin_helper,
|                                 ci->out ? "out" : "in", addr, name);

At the very least this leads to failures when the remote device uses
single quotes in its name. E.g. something like "Henryk's Phone" (without=20
the double quotes) will give=20

Aug  5 03:41:03 gleam hcid[24398]: PIN helper exited abnormally with code 5=
12

in the syslog and=20

sh: -c: line 0: unexpected EOF while looking for matching `''
sh: -c: line 1: syntax error: unexpected end of file

at stderr when running hcid -n (this is how I originally found the=20
problem).

However, something more creative like "';touch '/tmp/foo23" (again=20
without the double quotes) will actually execute a program on the=20
attacked box (and create a file /tmp/foo23 in this case). For=20
reference: in strace this looks like this:

execve("/bin/sh", ["sh", "-c", "/usr/lib/kdebluetooth/kbluepin out 00:0E:ED=
:00:23:42 \'\';touch \'/tmp/foo23\'"], [/* 62 vars */]) =3D 0

(note that the conversion from ' to \' was done by strace)

Using this vulnerability one can also create pairings without approval
of the user: Setting the bluetooth device name to something like
"'>/dev/null&echo 'PIN:42" (without the double quotes) and then trying=20
to create a pairing with a bluez box will override the decision of the=20
pin helper and always set 42 as the PIN.

PS: Thanks to roh and Sascha from the CCC Berlin.
--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Fri__5_Aug_2005_05_09_32_+0200_7he+o9mtEMpn0SbP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC8thwIjWgKE0OA2gRAsphAJ9p5viBY1fJyohTAM8pxqNIDBsLIgCeO/31
nolrcmmUtiopdhX5m9YaILE=
=IC4T
-----END PGP SIGNATURE-----

--Signature=_Fri__5_Aug_2005_05_09_32_+0200_7he+o9mtEMpn0SbP--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
