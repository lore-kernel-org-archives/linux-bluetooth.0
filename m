Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Tim Hurman <kano@kano.org.uk>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050106145723.GA10565@zorg.kano.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Subject: [Bluez-devel] patch: new card
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
Date: Thu, 6 Jan 2005 14:57:23 +0000


--H1spWtNR+x+ondvy
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have attached a patch for a new card, the CC&C/Bulemonkey CF card.
Unfortunately the card silly and does not set the vendor/device IDs
properly, instead they are set to 0x0000,0x0000. I have had to create a
fudge table in /etc/pcmcia/bluetooth as this device/vendor ID is
used by hciattach. To do this I have detected the a $MANFID of "0000,0000"
and converted it to "bcsp" (the card is CSR BlueCore).

I have also added some detection for the hciattach executable as on some
platforms (notably OpenEmbedded), it does not reside in /usr/sbin/.
Finally I have also added some backup in case fuser is non existant, which
happens busybox based platforms (again OpenEmbedded).

Tim

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bluez.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN bluez-utils-2.13.orig/pcmcia/bluetooth bluez-utils-2.13/pcmcia/bl=
uetooth
--- bluez-utils-2.13.orig/pcmcia/bluetooth	2004-06-17 17:05:36.000000000 +0=
100
+++ bluez-utils-2.13/pcmcia/bluetooth	2005-01-06 14:43:44.000000000 +0000
@@ -19,16 +19,52 @@
 get_info $DEVICE
=20
 #
+# Where are the executables
+#
+if [ -x /sbin/hciattach ]; then
+	HCIATTACH=3D/sbin/hciattach
+elif [ -x /usr/sbin/hciattach ]; then
+	HCIATTACH=3D/usr/sbin/hciattach
+elif [ -x /usr/local/sbin/hciattach ]; then
+	HCIATTACH=3D/usr/local/sbin/hciattach
+else
+	HCIATTACH=3D""
+fi
+
+#
 # Serial devices
 #
 start_serial() {
+    if [ -z $HCIATTACH ]; then
+		log hciattach: command not found
+        return
+    fi
+
     IRQ=3D`setserial /dev/$DEVICE | sed -e 's/.*IRQ: //'`
     setserial /dev/$DEVICE irq 0 ; setserial /dev/$DEVICE irq $IRQ
-=20
-    /usr/sbin/hciattach $DEVICE $MANFID
+
+    # some replacements - This is because hciattach only knows of a few
+    # cards. Worse, some have broken vendor/device IDs
+    case $MANFID in
+    "0000,0000")
+        # Bluemonkey/CC&C Tech bluetooth card.
+        MANFID=3D"bcsp"
+        ;;
+    esac
+    $HCIATTACH $DEVICE $MANFID
 }
 stop_serial() {
     do_fuser -k -HUP /dev/$DEVICE > /dev/null
+    hcilist=3D`ps -ef | grep hciattach | grep -v grep`
+    if [ "x$hcilist" =3D "x" ]; then
+        return
+    fi
+    killall $HCIATTACH > /dev/null 2>&1
+    hcilist=3D`ps -ef | grep hciattach | grep -v grep`
+    if [ "x$hcilist" =3D "x" ]; then
+        return
+    fi
+    killall hciattach > /dev/null 2>&1
 }
 suspend_serial() {
     stop_serial
diff -urN bluez-utils-2.13.orig/pcmcia/bluetooth.conf bluez-utils-2.13/pcmc=
ia/bluetooth.conf
--- bluez-utils-2.13.orig/pcmcia/bluetooth.conf	2004-12-25 18:06:01.0000000=
00 +0000
+++ bluez-utils-2.13/pcmcia/bluetooth.conf	2005-01-06 14:20:54.000000000 +0=
000
@@ -106,3 +106,8 @@
 card "Cyber-blue Compact Flash Card"
   version "BT", "", "", ""
   bind "btuart_cs"
+
+card "Bluetooth BT0100M"
+  version "Bluetooth BT0100M", ""
+  bind "serial_cs" class "bluetooth"
+

--y0ulUmNC+osPPQO6--

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (SunOS)

iD8DBQFB3VHSUfWwtAyNAP8RAuKIAJ4yGcmDdadklUg4rd/S7s45O4SPhACdHcP5
ORoUn+65gAlcdRkYsYChcYc=
=FORL
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
