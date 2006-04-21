Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0604211458s3cccaca3q47555f9af8418582@mail.gmail.com>
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3813_13753207.1145656718372"
Subject: [Bluez-devel] hcid doesn't compile without --enable-dbus
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
Date: Fri, 21 Apr 2006 17:58:38 -0400

------=_Part_3813_13753207.1145656718372
Content-Type: multipart/alternative;
	boundary="----=_Part_3814_27228580.1145656718372"

------=_Part_3814_27228580.1145656718372
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I get the following error when trying to compile utils from CVS without
--enable-dbus

security.c: In function 'disconn_complete':
security.c:614: warning: passing argument 2 of 'hcid_dbus_disconn_complete'
makes pointer from integer without a cast
security.c:614: error: too many arguments to function
'hcid_dbus_disconn_complete'

Attached patch appears to fix it.

Regards,
albert

------=_Part_3814_27228580.1145656718372
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I get the following error when trying to compile utils from CVS without --e=
nable-dbus<br>
<br>
security.c: In function 'disconn_complete':<br>security.c:614: warning: pas=
sing argument 2 of 'hcid_dbus_disconn_complete' makes pointer from integer =
without a cast<br>security.c:614: error: too many arguments to function 'hc=
id_dbus_disconn_complete'
<br><br>
Attached patch appears to fix it.<br>
<br>
Regards,<br>
albert<br>

------=_Part_3814_27228580.1145656718372--

------=_Part_3813_13753207.1145656718372
Content-Type: text/plain; name=hcid-nodbus-disconn-complete.patch.txt;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_emb2e8dh
Content-Disposition: attachment; filename="hcid-nodbus-disconn-complete.patch.txt"

Index: hcid/hcid.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/hcid.h,v
retrieving revision 1.57
diff -u -r1.57 hcid.h
--- hcid/hcid.h	29 Mar 2006 12:12:25 -0000	1.57
+++ hcid/hcid.h	21 Apr 2006 21:26:14 -0000
@@ -128,7 +128,7 @@
 static inline void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi) {}
 static inline void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, uint8_t status, char *name) {}
 static inline void hcid_dbus_conn_complete(bdaddr_t *local, uint8_t status, uint16_t handle, bdaddr_t *peer) {}
-static inline void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t reason) {}
+static inline void hcid_dbus_disconn_complete(bdaddr_t *local, bdaddr_t *peer, uint16_t handle, uint8_t reason) {}
 static inline void hcid_dbus_bonding_process_complete(bdaddr_t *local, bdaddr_t *peer, const uint8_t status) {}
 static inline void hcid_dbus_create_conn_cancel(bdaddr_t *local, void *ptr) {}
 static inline void hcid_dbus_setname_complete(bdaddr_t *local) {}

------=_Part_3813_13753207.1145656718372--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
