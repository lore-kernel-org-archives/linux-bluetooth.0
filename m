Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-nrDs4347e1yaoq6heVo5"
Date: Wed, 23 May 2007 16:24:15 +0100
Message-Id: <1179933855.3629.75.camel@cookie.hadess.net>
Mime-Version: 1.0
Cc: twaugh@redhat.com
Subject: [Bluez-devel] CUPS plugin discovery bits
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


--=-nrDs4347e1yaoq6heVo5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

Here's a patch against CVS bluez-utils to add discovery to the CUPS
backend. With this, it means that most CUPS front-end will be able to
list visible printers when adding a new one, be it through the web
interface or other front-ends (like Fedora' system-config-printer).

It adds D-Bus and glib as dependencies for the backend (not that it
matters that much...).

There are 2 things left:
- First, printer model/make detection. Does anyone know how this works
over HCRP or SPP? I would think that it would be something accessible
over HCRP as some other OSes are able to autodetect the necessary
printer driver (IEEE1284?).
Links to the specs appreciated.
- Secondly, does this detection require the devices to be paired? If it
does, then I'd want to add something like "--identify" to the bluetooth
backend so that front-ends can get make/model _after_ the printer has
been added to the queues and paired (if we did this during discovery we
might get flooded in auths).

Comments welcome.

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 

--=-nrDs4347e1yaoq6heVo5
Content-Disposition: attachment;
	filename=bluez-utils-cups-printer-listing.patch
Content-Type: text/x-patch; name=bluez-utils-cups-printer-listing.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: acinclude.m4
===================================================================
RCS file: /cvsroot/bluez/utils/acinclude.m4,v
retrieving revision 1.107
diff -u -p -r1.107 acinclude.m4
--- acinclude.m4	8 Apr 2007 19:56:52 -0000	1.107
+++ acinclude.m4	23 May 2007 15:11:31 -0000
@@ -78,6 +78,8 @@ AC_DEFUN([AC_PATH_GLIB], [
 	PKG_CHECK_MODULES(GLIB, glib-2.0, glib_found=yes, glib_found=no)
 	AC_SUBST(GLIB_CFLAGS)
 	AC_SUBST(GLIB_LIBS)
+	GLIB_GENMARSHAL=`$PKG_CONFIG --variable=glib_genmarshal glib-2.0`
+	AC_SUBST(GLIB_GENMARSHAL)
 ])
 
 AC_DEFUN([AC_PATH_DBUS], [
Index: cups/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/cups/Makefile.am,v
retrieving revision 1.9
diff -u -p -r1.9 Makefile.am
--- cups/Makefile.am	20 Aug 2006 02:21:03 -0000	1.9
+++ cups/Makefile.am	23 May 2007 15:11:31 -0000
@@ -7,9 +7,19 @@ else
 noinst_PROGRAMS = bluetooth
 endif
 
-bluetooth_SOURCES = main.c sdp.c spp.c hcrp.c
-bluetooth_LDADD = @BLUEZ_LIBS@
+MARSHAL_FILES = bluez-cups-marshal.h bluez-cups-marshal.c
 
-AM_CFLAGS = @BLUEZ_CFLAGS@
+bluetooth_SOURCES = main.c sdp.c spp.c hcrp.c $(MARSHAL_FILES)
+bluetooth_LDADD = @DBUS_GLIB_LIBS@ @BLUEZ_LIBS@
 
-MAINTAINERCLEANFILES = Makefile.in
+bluez-cups-marshal.h: bluez-cups-marshal.list
+	$(GLIB_GENMARSHAL) --prefix=bluez_cups_marshal $< --header > $@
+bluez-cups-marshal.c: bluez-cups-marshal.list
+	$(GLIB_GENMARSHAL) --prefix=bluez_cups_marshal $< --body > $@
+main.c: $(MARSHAL_FILES)
+
+AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_GLIB_CFLAGS@
+
+MAINTAINERCLEANFILES = Makefile.in $(MARSHAL_FILES)
+CLEANFILES = $(MARSHAL_FILES)
+EXTRA_DIST = bluez-cups-marshal.list
Index: cups/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/cups/main.c,v
retrieving revision 1.6
diff -u -p -r1.6 main.c
--- cups/main.c	3 Jan 2006 13:28:57 -0000	1.6
+++ cups/main.c	23 May 2007 15:11:31 -0000
@@ -38,12 +38,257 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include <dbus/dbus-glib.h>
+#include <glib/gi18n.h>
+#include "bluez-cups-marshal.h"
+
 extern int sdp_search_spp(sdp_session_t *sdp, uint8_t *channel);
 extern int sdp_search_hcrp(sdp_session_t *sdp, unsigned short *ctrl_psm, unsigned short *data_psm);
 
 extern int spp_print(bdaddr_t *src, bdaddr_t *dst, uint8_t channel, int fd, int copies);
 extern int hcrp_print(bdaddr_t *src, bdaddr_t *dst, unsigned short ctrl_psm, unsigned short data_psm, int fd, int copies);
 
+#define PRINTER_SERVICE_CLASS_NAME "printer"
+
+typedef struct {
+	char *bdaddr;
+	char *name;
+} BluezCupsDevice;
+
+static GList *device_list = NULL;
+static GMainLoop *loop = NULL;
+
+static void
+add_device_to_list(const char *name, const char *bdaddr)
+{
+	BluezCupsDevice *device;
+	GList *l;
+
+	/* Look for the device in the list */
+	for (l = device_list; l != NULL; l = l->next) {
+		device = (BluezCupsDevice *) l->data;
+
+		if (strcmp(device->bdaddr, bdaddr) == 0) {
+			g_free(device->name);
+			device->name = g_strdup(name);
+			return;
+		}
+	}
+
+	/* Or add it to the list if it's not there */
+	device = g_new0(BluezCupsDevice, 1);
+	device->bdaddr = g_strdup(bdaddr);
+	device->name = g_strdup(name);
+
+	device_list = g_list_prepend(device_list, device);
+}
+
+static void
+print_printer_details(const char *name, const char *bdaddr)
+{
+	char *uri, *escaped;
+
+	escaped = g_strdelimit(g_strdup(name), "\"", '\'');
+
+	uri = g_strdup_printf("bluetooth://%c%c%c%c%c%c%c%c%c%c%c%c",
+			       bdaddr[0], bdaddr[1],
+			       bdaddr[3], bdaddr[4],
+			       bdaddr[6], bdaddr[7],
+			       bdaddr[9], bdaddr[10],
+			       bdaddr[12], bdaddr[13],
+			       bdaddr[15], bdaddr[16]);
+	g_print("network %s \"Unknown\" \"%s (Bluetooth)\"\n", uri, escaped);
+	g_free(escaped);
+}
+
+static void
+discovery_started(DBusGProxy *object, gpointer user_data)
+{
+	/* Discovery started! */
+}
+
+static void
+remote_device_found(DBusGProxy *object,
+		     const char *bdaddr, guint class, int rssi,
+		     gpointer user_data)
+{
+	GError *e = NULL;
+	const char *name;
+
+	dbus_g_proxy_call(object, "GetRemoteName", &e,
+			   G_TYPE_STRING, bdaddr, G_TYPE_INVALID,
+			   G_TYPE_STRING, &name, G_TYPE_INVALID);
+	if(e != NULL) {
+		const char *name;
+
+		name = dbus_g_error_get_name(e);
+		if (g_str_equal(name, "org.bluez.Error.RequestDeferred") != FALSE) {
+			add_device_to_list(NULL, bdaddr);
+		}
+		g_error_free(e);
+	} else {
+		add_device_to_list(name, bdaddr);
+	}
+}
+
+static void
+remote_name_updated(DBusGProxy *object,
+		     const char *bdaddr, const char *name,
+		     gpointer user_data)
+{
+	add_device_to_list(name, bdaddr);
+}
+
+static gboolean
+device_is_printer(DBusGProxy *object, const char *bdaddr)
+{
+	GError *e = NULL;
+	char *class;
+
+	dbus_g_proxy_call(object, "GetRemoteMinorClass", &e,
+			   G_TYPE_STRING, bdaddr, G_TYPE_INVALID,
+			   G_TYPE_STRING, &class, G_TYPE_INVALID);
+
+	if (e == NULL && g_str_equal(class, PRINTER_SERVICE_CLASS_NAME)) {
+		return TRUE;
+	} else if(e != NULL) {
+		g_error_free(e);
+	}
+
+	return FALSE;
+}
+
+static void
+discovery_completed(DBusGProxy *object, gpointer user_data)
+{
+	GList *l;
+
+	for (l = device_list; l != NULL; l = l->next) {
+		BluezCupsDevice *device = (BluezCupsDevice *) l->data;
+
+		if (device_is_printer(object, device->bdaddr))
+			print_printer_details(device->name, device->bdaddr);
+		g_free(device->name);
+		g_free(device->bdaddr);
+		g_free(device);
+	}
+
+	g_list_free(device_list);
+	device_list = NULL;
+
+	g_main_loop_quit(loop);
+}
+
+static void
+remote_device_disappeared(DBusGProxy *object,
+			   const char *bdaddr,
+			   gpointer user_data)
+{
+	GList *l;
+
+	for (l = device_list; l != NULL; l = l->next) {
+		BluezCupsDevice *device = (BluezCupsDevice *) l->data;
+
+		if (strcmp(device->bdaddr, bdaddr) == 0) {
+			g_free(device->name);
+			g_free(device->bdaddr);
+			g_free(device);
+			device_list = g_list_delete_link(device_list, l);
+			return;
+		}
+	}
+}
+
+static void
+list_printers(void)
+{
+	/* 1. Connect to the bus
+	 * 2. Get the manager
+	 * 3. Get the default adapter
+	 * 4. Get a list of devices
+	 * 5. Get the class of each device
+	 * 6. Print the details from each printer device
+	 */
+	GError *e = NULL;
+	DBusGConnection *conn;
+	DBusGProxy *object;
+	const char *adapter;
+
+	g_type_init();
+
+	conn = dbus_g_bus_get(DBUS_BUS_SYSTEM, &e);
+	if (e != NULL) {
+		g_warning("Couldn't connect to bus: %s", e->message);
+		g_error_free(e);
+		return;
+	}
+
+	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+					    "/org/bluez", "org.bluez.Manager");
+	dbus_g_proxy_call(object, "DefaultAdapter", &e,
+			   G_TYPE_INVALID, G_TYPE_STRING, &adapter, G_TYPE_INVALID);
+	if (e != NULL) {
+		const char *name;
+
+		name = dbus_g_error_get_name(e);
+
+		/* No adapter */
+		if (g_str_equal(name, "org.bluez.Error.NoSuchAdapter") != FALSE) {
+			g_error_free(e);
+			return;
+		}
+
+		g_warning("Couldn't get default bluetooth adapter: %s",
+			   e->message);
+		g_error_free(e);
+		return;
+	}
+
+	object = dbus_g_proxy_new_for_name(conn, "org.bluez",
+					    adapter, "org.bluez.Adapter");
+
+	dbus_g_proxy_add_signal(object, "DiscoveryStarted", G_TYPE_INVALID);
+	dbus_g_proxy_connect_signal(object, "DiscoveryStarted",
+				     G_CALLBACK(discovery_started), NULL, NULL);
+
+	dbus_g_object_register_marshaller(bluez_cups_marshal_VOID__STRING_UINT_INT,
+					  G_TYPE_NONE, G_TYPE_STRING, G_TYPE_UINT,
+					  G_TYPE_INT, G_TYPE_INVALID);
+	dbus_g_proxy_add_signal(object, "RemoteDeviceFound",
+				 G_TYPE_STRING, G_TYPE_UINT, G_TYPE_INT, G_TYPE_INVALID);
+	dbus_g_proxy_connect_signal(object, "RemoteDeviceFound",
+				     G_CALLBACK(remote_device_found), NULL, NULL);
+
+	dbus_g_object_register_marshaller(bluez_cups_marshal_VOID__STRING_STRING,
+					  G_TYPE_NONE, G_TYPE_STRING,
+					  G_TYPE_STRING, G_TYPE_INVALID);
+	dbus_g_proxy_add_signal(object, "RemoteNameUpdated",
+				 G_TYPE_STRING, G_TYPE_STRING, G_TYPE_INVALID);
+	dbus_g_proxy_connect_signal(object, "RemoteNameUpdated",
+				     G_CALLBACK(remote_name_updated), NULL, NULL);
+
+	dbus_g_proxy_add_signal(object, "RemoteDeviceDisappeared",
+				 G_TYPE_STRING, G_TYPE_INVALID);
+	dbus_g_proxy_connect_signal(object, "RemoteDeviceDisappeared",
+				     G_CALLBACK(remote_device_disappeared), NULL, NULL);
+
+	dbus_g_proxy_add_signal(object, "DiscoveryCompleted", G_TYPE_INVALID);
+	dbus_g_proxy_connect_signal(object, "DiscoveryCompleted",
+				     G_CALLBACK(discovery_completed), NULL, NULL);
+
+	dbus_g_proxy_call(object, "DiscoverDevices", &e,
+			   G_TYPE_INVALID, G_TYPE_INVALID);
+	if (e != NULL) {
+		g_warning("Couldn't start discovery: %s: %s",
+			   dbus_g_error_get_name(e), e->message);
+		g_error_free(e);
+		return;
+	}
+
+	loop = g_main_loop_new(NULL, TRUE);
+	g_main_loop_run(loop);
+}
+
 /*
  *  Usage: printer-uri job-id user title copies options [file]
  *
@@ -73,7 +318,7 @@ int main(int argc, char *argv[])
 #endif /* HAVE_SIGSET */
 
 	if (argc == 1) {
-		puts("network bluetooth \"Unknown\" \"Bluetooth printer\"");
+		list_printers();
 		return 0;
 	}
 
--- /dev/null	2007-05-22 10:58:00.668244955 +0100
+++ cups/bluez-cups-marshal.list	2007-05-23 11:51:07.000000000 +0100
@@ -0,0 +1,2 @@
+VOID:STRING,UINT,INT
+VOID:STRING,STRING

--=-nrDs4347e1yaoq6heVo5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-nrDs4347e1yaoq6heVo5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-nrDs4347e1yaoq6heVo5--
