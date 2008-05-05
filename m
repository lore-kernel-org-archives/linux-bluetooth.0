Return-Path: <cyrus@holtmann.org>
From: Valmantas <walmis@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-2DCT+ijhxREQqoqBx57L"
Date: Mon, 05 May 2008 23:42:10 +0300
Message-Id: <1210020130.10069.5.camel@ubuntu>
Mime-Version: 1.0
Subject: [Bluez-devel] network - NAP (pan1) bridge is not initialized (patch)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-2DCT+ijhxREQqoqBx57L
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The subject says it all. Don't know whether it was by design, but NAP
connections simply did not work.

Patch attached.

--=-2DCT+ijhxREQqoqBx57L
Content-Disposition: attachment; filename=nap_bridge_fix.patch
Content-Type: text/x-patch; name=nap_bridge_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- network/bridge.c.orig	2008-05-05 14:37:28.000000000 +0300
+++ network/bridge.c	2008-05-05 14:31:39.000000000 +0300
@@ -53,7 +53,7 @@
 	if (stat("/sys/module/bridge", &st) < 0)
 		return -EOPNOTSUPP;
 #endif
-
+	info("bridge init");
 	bridge_socket = socket(AF_INET, SOCK_STREAM, 0);
 	if (bridge_socket < 0)
 		return -errno;
@@ -74,7 +74,7 @@
 {
 	int err;
 	const char *name = bridge_get_name(id);
-
+	info("bridge create %s", name);
 	err = ioctl(bridge_socket, SIOCBRADDBR, name);
 	if (err < 0)
 		return -errno;
@@ -86,7 +86,7 @@
 {
 	int err;
 	const char *name = bridge_get_name(id);
-
+	info("remove from bridge");
 	err = bnep_if_down(name);
 	if (err < 0)
 		return err;
@@ -118,9 +118,7 @@
 	if (err < 0)
 		return err;
 
-	/* Only run scripts in GN bridges */
-	if (id != BNEP_SVC_GN)
-		return 0;
+	info("bridge_add_interface %s", dev);
 
 	err = bnep_if_up(name, id);
 	if (err < 0)
--- network/server.c.orig	2008-05-05 14:37:17.000000000 +0300
+++ network/server.c	2008-05-03 11:57:39.000000000 +0300
@@ -665,6 +665,9 @@
 
 	if (bridge_create(BNEP_SVC_GN) < 0)
 		error("Can't create GN bridge");
+		
+	if (bridge_create(BNEP_SVC_NAP) < 0)
+		error("Can't create NAP bridge");
 
 	return 0;
 fail:
@@ -690,6 +693,9 @@
 
 	if (bridge_remove(BNEP_SVC_GN) < 0)
 		error("Can't remove GN bridge");
+		
+	if (bridge_remove(BNEP_SVC_NAP) < 0)
+		error("Can't remove NAP bridge");
 
 	dbus_connection_unref(connection);
 	connection = NULL;

--=-2DCT+ijhxREQqoqBx57L
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--=-2DCT+ijhxREQqoqBx57L
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-2DCT+ijhxREQqoqBx57L--
