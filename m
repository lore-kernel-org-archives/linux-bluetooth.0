Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-w0x4ly/0UYG3fCzOK66G"
Message-Id: <1053620481.17764.129.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Changes to inquiry
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 22 May 2003 18:21:15 +0200


--=-w0x4ly/0UYG3fCzOK66G
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

the inquiry process have some problems if devices report Bluetooth
addresses more than once. This can be seen with the Nokia cards. The
kernel inside inquiry cache is able to handle this, but the number of
responses parameter will mess this up. The most problem case is if you
want to set the number of inquiry responses to zero, which means
unlimted number of inquiry reponses until the specified time is over.

Currently a value of zero will be recoded as 200, but if you use a large
time value this number can be reached very quick and not all devices
will be found. I suppose the attached change to the Bluetooth library
and fix the kernel code to dump up to 255 devices if the num_rsp
parameter is zero.

Comments?

Regards

Marcel


--=-w0x4ly/0UYG3fCzOK66G
Content-Disposition: attachment; filename=patch-libs-inq
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch-libs-inq; charset=ISO-8859-15

diff -urN libs/src/hci.c libs-mh/src/hci.c
--- libs/src/hci.c	Mon May 19 20:41:00 2003
+++ libs-mh/src/hci.c	Thu May 22 18:02:41 2003
@@ -473,8 +473,10 @@
 	void *buf;
 	int s, err;
=20
-	if (nrsp <=3D 0)
-		nrsp =3D 200; // enough ?
+	if (nrsp < 0) {
+		errno =3D EINVAL;
+		return -1;
+	}
=20
 	if (dev_id < 0 && (dev_id =3D hci_get_route(NULL)) < 0) {
 		errno =3D ENODEV;
@@ -485,7 +487,11 @@
 	if (s < 0)
 		return -1;
=20
-	buf =3D malloc(sizeof(*ir) + (sizeof(inquiry_info) * (nrsp)));
+	if (nrsp =3D=3D 0)
+		buf =3D malloc(sizeof(*ir) + (sizeof(inquiry_info) * 255));
+	else
+		buf =3D malloc(sizeof(*ir) + (sizeof(inquiry_info) * nrsp));
+
 	if (!buf) {
 		close(s);
 		return -1;

--=-w0x4ly/0UYG3fCzOK66G--



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
