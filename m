Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0406222219c5d442b@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_15_9104397.1087967986687"
Subject: [Bluez-devel] how well supported is hci_read_rssi and hci_read_link_quality?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 23 Jun 2004 01:19:46 -0400

------=_Part_15_9104397.1087967986687
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Does anyone have a rough estimate, or even a list, of the devices that
support hci_read_rssi and hci_read_link_quality?  Am I correct in
assuming that some devices supoprt it and some don't?  For example, a
program that reads rssi and link quality that works beautifully on an
x86 with a d-link usb bluetooth dongle doesn't seem to work at all on
an HP ipaq h5550.  On the ipaq, the link quality is always 0 and rssi
is always 255.

The attached patch changes cmd_lq in hcitool.c to print out an
unsigned integer instead of a signed integer.

thanks.
-albert

------=_Part_15_9104397.1087967986687
Content-Type: text/plain; name="cmd_lq.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="cmd_lq.diff"

Index: tools/hcitool.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/bluez/utils/tools/hcitool.c,v
retrieving revision 1.44
diff -u -r1.44 hcitool.c
--- tools/hcitool.c=0912 Jun 2004 09:41:17 -0000=091.44
+++ tools/hcitool.c=0923 Jun 2004 05:17:27 -0000
@@ -982,7 +982,7 @@
 =09=09=09=09rp.status);
 =09=09exit(1);
 =09}
-=09printf("Link quality: %d\n", rp.link_quality);
+=09printf("Link quality: %u\n", rp.link_quality);
=20
 =09close(dd);
 =09free(cr);

------=_Part_15_9104397.1087967986687--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
