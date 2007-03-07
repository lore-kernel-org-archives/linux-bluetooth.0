Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Jon Barnett <jbarnett@pobox.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <mailman.164002.1173227580.20110.bluez-devel@lists.sourceforge.net>
References: <mailman.164002.1173227580.20110.bluez-devel@lists.sourceforge.net>
Date: Wed, 07 Mar 2007 11:42:23 -0500
Message-Id: <1173285743.4194.10.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Ekiga pwlib patch for plugz operation
Reply-To: jbarnett@pobox.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0876421316=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0876421316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-KAgS/uow3MMpRpAaj4jc"


--=-KAgS/uow3MMpRpAaj4jc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Version 1.10.4 of pwlib has some slight changes in the sound_alsa.cxx
code so the old plugz patch doesn't work any more. I think the new patch sh=
ould
look something like this.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
--- plugins/sound_alsa/sound_alsa.cxx.old       2007-02-04 16:21:32.0000000=
00 -0500
+++ plugins/sound_alsa/sound_alsa.cxx   2007-03-07 11:17:06.000000000 -0500
@@ -284,6 +284,8 @@
     for (PINDEX j =3D 0 ; j < playback_devices.GetSize () ; j++)=20
       devices +=3D playback_devices.GetKeyAt (j);
   }
+
+  devices +=3D "Bluetooth headset";
  =20
   return devices;
 }
@@ -331,6 +333,10 @@
     real_device_name =3D "default";
     card_nr =3D -2;
   }
+  else if(_device =3D=3D "Bluetooth headset") {
+    real_device_name =3D "headset";
+    card_nr =3D -3;
+  }
   else {
=20
   if ((_dir =3D=3D Recorder && capture_devices.IsEmpty ())
@@ -841,10 +847,15 @@
   if (!os_handle)
     return FALSE;
=20
-  if (card_nr =3D=3D -2)
+  if (card_nr =3D=3D -2) {
     card_name =3D "default";
-  else
+  }
+  else if(card_nr =3D=3D -3) {
+    card_name =3D "headset";
+  }=20
+  else {
     card_name =3D "hw:" + PString (card_nr);
+  }
=20
   //allocate simple id
   snd_mixer_selem_id_alloca (&sid);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Submitted for consideration.

Cheers,

JonB

--=-KAgS/uow3MMpRpAaj4jc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBF7utvu2cEic/xsEARAjm5AKCSAIbvGzgRz3jbVQ9r6qsyLWkaGACaA1D8
q5sTy6qp9bPmvRDCmkc3eRU=
=fj8N
-----END PGP SIGNATURE-----

--=-KAgS/uow3MMpRpAaj4jc--



--===============0876421316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0876421316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0876421316==--
