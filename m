Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 2 May 2007 15:25:07 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zEJOGGgkKipR6Oo"
Message-Id: <200705021525.07661.dgollub@suse.de>
Subject: [Bluez-devel] [PATCH] Input Service support for phones
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_zEJOGGgkKipR6Oo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

attachted is a simple patch for the input service, which allows (again - 
changed since 3.9 release) using a phone as input device. Current code only 
allows devices with major class of "Peripheral" and "Fake Input" 
(Audio/Video).

best regards,
Daniel

--Boundary-00=_zEJOGGgkKipR6Oo
Content-Type: text/x-diff; charset="us-ascii";
	name="bluez-utils_input_phone.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluez-utils_input_phone.diff"

diff -u -p -r1.43 device.c
--- input/device.c	18 Apr 2007 19:33:34 -0000	1.43
+++ input/device.c	2 May 2007 13:12:54 -0000
@@ -195,6 +195,28 @@ static const char *create_input_path(uin
 	static int next_id = 0;
 
 	switch (major) {
+	case 0x02: /* Phone */	
+		switch (minor) {
+		case 0x01: /* Cellular */
+			strcpy(subpath, "celluar");
+			break;
+		case 0x02: /* Cordless */	
+			strcpy(subpath, "cordless");
+			break;
+		case 0x03: /* Smart Phone */
+			strcpy(subpath, "smartphone");
+			break;
+		case 0x04: /* Modem */ 	
+			strcpy(subpath, "modem");
+			break;
+		case 0x05: /* ISDN */	
+			strcpy(subpath, "isdn");
+			break;
+		default:
+			strcpy(subpath, "phone");	
+			break;
+		}
+		break;
 	case 0x04: /* Audio */
 		switch (minor) {
 		/* FIXME: Testing required */
Index: input/manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/manager.c,v
retrieving revision 1.22
diff -u -p -r1.22 manager.c
--- input/manager.c	18 Apr 2007 19:33:34 -0000	1.22
+++ input/manager.c	2 May 2007 13:12:54 -0000
@@ -800,6 +800,7 @@ static DBusHandlerResult create_device(D
 
 	switch (cls & 0x1f00) {
 		case 0x0500: /* Peripheral */
+		case 0x0200: /* Phone */
 			if (get_handles(pr, pnp_uuid, pnp_handle_reply) < 0) {
 				pending_req_free(pr);
 				return err_not_supported(conn, msg);

--Boundary-00=_zEJOGGgkKipR6Oo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--Boundary-00=_zEJOGGgkKipR6Oo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_zEJOGGgkKipR6Oo--
