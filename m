Return-Path: <cyrus@holtmann.org>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 16 Jan 2008 10:34:48 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oEVjHQ58+Jjpk6+"
Message-Id: <200801161034.48078.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] [PATCH] Fix crash when registering / unregistering
	external service
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

--Boundary-00=_oEVjHQ58+Jjpk6+
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch fixes a crash in hcid when an external service is registered and 
then unregistered (either via UnregisterService method or due to service 
exiting)

-Denis

--Boundary-00=_oEVjHQ58+Jjpk6+
Content-Type: text/x-diff; charset="us-ascii";
	name="external-service-unregister-crash-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="external-service-unregister-crash-fix.patch"

Index: dbus-service.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-service.c,v
retrieving revision 1.142
diff -u -5 -r1.142 dbus-service.c
--- dbus-service.c	26 Nov 2007 13:43:18 -0000	1.142
+++ dbus-service.c	16 Jan 2008 00:31:52 -0000
@@ -63,10 +63,12 @@
 #define SERVICE_SUFFIX ".service"
 #define SERVICE_GROUP "Bluetooth Service"
 
 #define NAME_MATCH "interface=" DBUS_INTERFACE_DBUS ",member=NameOwnerChanged"
 
+static void external_service_exit(const char *name, struct service *service);
+
 static GSList *services = NULL;
 static GSList *removed = NULL;
 
 static void service_free(struct service *service)
 {
@@ -758,28 +760,31 @@
 	debug("Unregistering service object: %s", service->object_path);
 
 	if (!conn)
 		goto cleanup;
 
-	if (service->bus_name)
+	if (service->bus_name) {
+		name_cb_t cb = (name_cb_t) (service->external ? 
+			external_service_exit : service_exit);
 		name_listener_remove(connection, service->bus_name,
-					(name_cb_t) service_exit, service);
+					cb, service);
+	}
 
 	dbus_connection_emit_signal(conn, service->object_path,
 					SERVICE_INTERFACE,
 					"Stopped", DBUS_TYPE_INVALID);
 
-	if (!dbus_connection_destroy_object_path(conn, service->object_path)) {
-		error("D-Bus failed to unregister %s object", service->object_path);
-		return -1;
-	}
-
 	dbus_connection_emit_signal(conn, BASE_PATH, MANAGER_INTERFACE,
 					"ServiceRemoved",
 					DBUS_TYPE_STRING, &service->object_path,
 					DBUS_TYPE_INVALID);
 
+	if (!dbus_connection_destroy_object_path(conn, service->object_path)) {
+		error("D-Bus failed to unregister %s object", service->object_path);
+		return -1;
+	}
+
 cleanup:
 	if (service->pid) {
 		if (service->startup_timer) {
 			abort_startup(service, conn, ECANCELED);
 			services = g_slist_remove(services, service);
@@ -1040,23 +1045,23 @@
 
 static void external_service_exit(const char *name, struct service *service)
 {
 	DBusConnection *conn = get_dbus_connection();
 
-	service_exit(name, service);
-
 	if (!conn)
 		return;
 
-	if (!dbus_connection_destroy_object_path(conn, service->object_path))
-		return;
+	service_exit(name, service);
 
 	dbus_connection_emit_signal(conn, BASE_PATH, MANAGER_INTERFACE,
 					"ServiceRemoved",
 					DBUS_TYPE_STRING, &service->object_path,
 					DBUS_TYPE_INVALID);
 
+	if (!dbus_connection_destroy_object_path(conn, service->object_path))
+		return;
+
 	services = g_slist_remove(services, service);
 	service_free(service);
 }
 
 int service_register(DBusConnection *conn, const char *bus_name, const char *ident,

--Boundary-00=_oEVjHQ58+Jjpk6+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--Boundary-00=_oEVjHQ58+Jjpk6+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_oEVjHQ58+Jjpk6+--
