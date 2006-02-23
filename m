Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602231233t1656b085xfbb430ad612a69d9@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7113_10797808.1140726807216"
Subject: [Bluez-devel] hciconfig service class listing patch
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
Date: Thu, 23 Feb 2006 17:33:27 -0300

------=_Part_7113_10797808.1140726807216
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

while I was developing the service class for D-Bus I noticed that
there is a small bug in the hciconfig service class listing.

The sizeof is getting the pointer size instead of check the number of
array elements.


Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_7113_10797808.1140726807216
Content-Type: text/x-patch; name=hciconfig-service-class.patch;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek1j7w9y
Content-Disposition: attachment; filename="hciconfig-service-class.patch"

Index: tools/hciconfig.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hciconfig.c,v
retrieving revision 1.78
diff -u -r1.78 hciconfig.c
--- tools/hciconfig.c	15 Feb 2006 09:17:52 -0000	1.78
+++ tools/hciconfig.c	23 Feb 2006 20:27:45 -0000
@@ -666,7 +666,7 @@
 		printf("\tService Classes: ");
 		if (cls[2]) {
 			int first = 1;
-			for (s = 0; s < sizeof(*services); s++)
+			for (s = 0; s < (sizeof(services) / sizeof(*services)); s++)
 				if (cls[2] & (1 << s)) {
 					if (!first)
 						printf(", ");

------=_Part_7113_10797808.1140726807216--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
