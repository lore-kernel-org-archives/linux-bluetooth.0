Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <089F41B2-DBC5-483E-A6C9-F413E18DF38B@nokia.com>
References: <1179933855.3629.75.camel@cookie.hadess.net>
	<1179935471.19944.6.camel@aeonflux.holtmann.net>
	<1179936924.3629.88.camel@cookie.hadess.net>
	<1179937606.3629.92.camel@cookie.hadess.net>
	<59278C28-851A-44FF-AE01-25D8F074CE1E@nokia.com>
	<1180013992.3151.6.camel@cookie.hadess.net>
	<089F41B2-DBC5-483E-A6C9-F413E18DF38B@nokia.com>
Content-Type: multipart/mixed; boundary="=-M69p/EqRrZNfeT6Bzfa2"
Date: Thu, 24 May 2007 19:49:57 +0100
Message-Id: <1180032597.14752.13.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] CUPS plugin discovery bits
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


--=-M69p/EqRrZNfeT6Bzfa2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2007-05-24 at 17:31 +0200, Johan Hedberg wrote:
> Hi Bastien,
> 
> On May 24, 2007, at 15:39, Bastien Nocera wrote:
> > On Wed, 2007-05-23 at 18:56 +0200, Johan Hedberg wrote:
> >> Hi Bastien,
> >>
> >> On May 23, 2007, at 18:26, Bastien Nocera wrote:
> >>> Updated patch attached.
> >>
> >> A little about optimizing the device discovery.
> >
> > Fixed in this version, and also added recent devices (through
> > ListRemoteDevices and ListBondings).
> 
> I see you're now using the manual name resolving discovery and  
> deciding from the device class whether to get the name or not. Great!  
> However, you are causing an unecessary roundtrip back to hcid by  
> calling GetRemoteMinorClass because you in fact already have the  
> necessary information encoded in the class parameter of the  
> RemoteDeviceFound signal. It's not as convenient as a string to do a  
> strcmp on, but you can just take example from hcid code how it  
> converts the 3 byte value to the string.

This is most ugly. There should really be a helper function for that, or
hcid should pass a decoded argument.

Anyway, it's implemented now, along with a port to pure D-Bus, and can
use the builtin eglib instead of the system one.

Marcel

-- 
Bastien Nocera <hadess@hadess.net> 

--=-M69p/EqRrZNfeT6Bzfa2
Content-Disposition: attachment;
	filename=bluez-utils-cups-printer-listing-8.patch
Content-Type: text/x-patch; name=bluez-utils-cups-printer-listing-8.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: cups/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/cups/Makefile.am,v
retrieving revision 1.9
diff -u -p -r1.9 Makefile.am
--- cups/Makefile.am	20 Aug 2006 02:21:03 -0000	1.9
+++ cups/Makefile.am	24 May 2007 18:50:13 -0000
@@ -8,8 +8,9 @@ noinst_PROGRAMS = bluetooth
 endif
 
 bluetooth_SOURCES = main.c sdp.c spp.c hcrp.c
-bluetooth_LDADD = @BLUEZ_LIBS@
+bluetooth_LDADD = @DBUS_LIBS@ @GLIB_LIBS@ @BLUEZ_LIBS@ $(top_builddir)/common/libhelper.a
 
-AM_CFLAGS = @BLUEZ_CFLAGS@
+AM_CFLAGS = @BLUEZ_CFLAGS@ @DBUS_CFLAGS@ @GLIB_CFLAGS@ -I$(top_srcdir)/common
 
 MAINTAINERCLEANFILES = Makefile.in
+
Index: cups/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/cups/main.c,v
retrieving revision 1.6
diff -u -p -r1.6 main.c
--- cups/main.c	3 Jan 2006 13:28:57 -0000	1.6
+++ cups/main.c	24 May 2007 18:50:14 -0000
@@ -38,12 +38,414 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include <glib.h>
+#include <dbus/dbus.h>
+#include "dbus.h"
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
+static GSList *device_list = NULL;
+static GMainLoop *loop = NULL;
+static DBusConnection *conn = NULL;
+
+static void
+add_device_to_list(const char *name, const char *bdaddr)
+{
+	BluezCupsDevice *device;
+	GSList *l;
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
+	device_list = g_slist_prepend(device_list, device);
+}
+
+static char *
+escape_name(const char *str, char orig, char dest)
+{
+	char *ret, *s;
+
+	ret = g_strdup(str);
+	while ((s = strchr(ret, orig)) != NULL)
+		s[0] = dest;
+	return ret;
+}
+
+static void
+print_printer_details(const char *name, const char *bdaddr)
+{
+	char *uri, *escaped;
+	guint len;
+
+	escaped = escape_name(name, '\"', '\'');
+	len = strlen("bluetooth://") + 12 + 1;
+	uri = g_malloc(len);
+	snprintf(uri, len, "bluetooth://%c%c%c%c%c%c%c%c%c%c%c%c",
+		 bdaddr[0], bdaddr[1],
+		 bdaddr[3], bdaddr[4],
+		 bdaddr[6], bdaddr[7],
+		 bdaddr[9], bdaddr[10],
+		 bdaddr[12], bdaddr[13],
+		 bdaddr[15], bdaddr[16]);
+	printf("network %s \"Unknown\" \"%s (Bluetooth)\"\n", uri, escaped);
+	g_free(escaped);
+	g_free(uri);
+}
+
+static gboolean
+device_is_printer(const char *adapter, const char *bdaddr)
+{
+	char *class;
+	DBusMessage *message, *reply;
+	DBusMessageIter iter, reply_iter;
+
+	message = dbus_message_new_method_call("org.bluez", adapter,
+					       "org.bluez.Adapter",
+					       "GetRemoteMinorClass");
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+
+	reply = dbus_connection_send_with_reply_and_block(conn,
+							  message, -1, NULL);
+	if (!reply) {
+		dbus_message_unref(message);
+		return FALSE;
+	}
+
+	dbus_message_iter_init(reply, &reply_iter);
+	dbus_message_iter_get_basic(&reply_iter, &class);
+
+	if (class != NULL && strcmp(class, PRINTER_SERVICE_CLASS_NAME) == 0) {
+		dbus_message_unref(reply);
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static char *
+device_get_name(const char *adapter, const char *bdaddr)
+{
+	char *name;
+	DBusMessage *message, *reply;
+	DBusMessageIter iter, reply_iter;
+
+	message = dbus_message_new_method_call("org.bluez", adapter,
+					       "org.bluez.Adapter",
+					       "GetRemoteName");
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+
+	reply = dbus_connection_send_with_reply_and_block(conn,
+							  message, -1, NULL);
+	dbus_message_unref(message);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init(reply, &reply_iter);
+	dbus_message_iter_get_basic(&reply_iter, &name);
+
+	name = g_strdup(name);
+	dbus_message_unref(reply);
+	return name;
+}
+
+static void
+remote_device_found(const char *adapter, const char *bdaddr, guint class, int rssi)
+{
+	uint8_t major_index = (class >> 8) & 0x1F;
+	uint8_t minor_index;
+	uint8_t shift_minor = 0;
+	gboolean found = FALSE;
+	char *name;
+
+	/* Check if we have a printer
+	 * From hcid/dbus-adapter.c minor_class_str() */
+	if (major_index != 6)
+		return;
+
+	minor_index = (class >> 4) & 0x0F;
+	while (shift_minor < 4) {
+		if (((minor_index >> shift_minor) & 0x01) == 0x01) {
+			if (shift_minor == 3) {
+				found = TRUE;
+				break;
+			}
+		}
+		shift_minor++;
+	}
+
+	if (!found)
+		return;
+
+	name = device_get_name(adapter, bdaddr);
+	add_device_to_list(name, bdaddr);
+	g_free(name);
+}
+
+static void
+remote_name_updated(const char *bdaddr, const char *name)
+{
+	add_device_to_list(name, bdaddr);
+}
+
+static void
+discovery_completed(void)
+{
+	GSList *l;
+
+	for (l = device_list; l != NULL; l = l->next) {
+		BluezCupsDevice *device = (BluezCupsDevice *) l->data;
+
+		if (device->name == NULL) {
+			device->name = escape_name(device->bdaddr,
+						   ':', '-');
+		}
+		print_printer_details(device->name, device->bdaddr);
+		g_free(device->name);
+		g_free(device->bdaddr);
+		g_free(device);
+	}
+
+	g_slist_free(device_list);
+	device_list = NULL;
+
+	g_main_loop_quit(loop);
+}
+
+static void
+remote_device_disappeared(const char *bdaddr)
+{
+	GSList *l;
+
+	for (l = device_list; l != NULL; l = l->next) {
+		BluezCupsDevice *device = (BluezCupsDevice *) l->data;
+
+		if (strcmp(device->bdaddr, bdaddr) == 0) {
+			g_free(device->name);
+			g_free(device->bdaddr);
+			g_free(device);
+			device_list = g_slist_delete_link(device_list, l);
+			return;
+		}
+	}
+}
+
+static gboolean
+list_known_printers(const char *adapter)
+{
+	DBusMessageIter reply_iter, iter_array;
+	DBusError error;
+	DBusMessage *message, *reply;
+
+	message = dbus_message_new_method_call ("org.bluez", adapter,
+						"org.bluez.Adapter",
+						"ListRemoteDevices");
+	if (message == NULL)
+		return FALSE;
+
+	dbus_error_init(&error);
+	reply = dbus_connection_send_with_reply_and_block(conn,
+							  message, -1,
+							  &error);
+	dbus_message_unref(message);
+	if (&error != NULL && dbus_error_is_set(&error))
+		return FALSE;
+
+	dbus_message_iter_init(reply, &reply_iter);
+	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_ARRAY) {
+		dbus_message_unref(reply);
+		return FALSE;
+	}
+
+	dbus_message_iter_recurse(&reply_iter, &iter_array);
+	while (dbus_message_iter_get_arg_type(&iter_array) == DBUS_TYPE_STRING) {
+		char *bdaddr;
+
+		dbus_message_iter_get_basic(&iter_array, &bdaddr);
+		if (device_is_printer(adapter, bdaddr)) {
+			char *name;
+			name = device_get_name(adapter, bdaddr);
+			add_device_to_list(name, bdaddr);
+			g_free(name);
+		}
+		dbus_message_iter_next(&iter_array);
+	}
+
+	dbus_message_unref(reply);
+
+	return FALSE;
+}
+
+static DBusHandlerResult
+filter_func(DBusConnection *connection,
+	    DBusMessage *message,
+	    void *user_data)
+{
+	const char *adapter;
+
+	if (dbus_message_is_signal(message, "org.bluez.Adapter",
+				   "RemoteDeviceFound")) {
+		char *bdaddr;
+		guint class;
+		int rssi;
+
+		dbus_message_get_args(message, NULL,
+				      DBUS_TYPE_STRING, &bdaddr,
+				      DBUS_TYPE_UINT32, &class,
+				      DBUS_TYPE_INT32, &rssi,
+				      DBUS_TYPE_INVALID);
+		adapter = dbus_message_get_path(message);
+		remote_device_found(adapter, bdaddr, class, rssi);
+	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
+					  "RemoteNameUpdated")) {
+		char *bdaddr, *name;
+
+		dbus_message_get_args(message, NULL,
+				      DBUS_TYPE_STRING, &bdaddr,
+				      DBUS_TYPE_STRING, &name,
+				      DBUS_TYPE_INVALID);
+		remote_name_updated(bdaddr, name);
+	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
+					  "RemoteDeviceDisappeared")) {
+		char *bdaddr;
+
+		dbus_message_get_args(message, NULL,
+				      DBUS_TYPE_STRING, &bdaddr,
+				      DBUS_TYPE_INVALID);
+		remote_device_disappeared(bdaddr);
+	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
+					  "DiscoveryCompleted")) {
+		discovery_completed();
+	}
+
+	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
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
+	DBusError error;
+	dbus_bool_t hcid_exists;
+	DBusMessage *reply, *message;
+	DBusMessageIter reply_iter;
+	char *adapter, *match;
+	guint len;
+
+	conn = init_dbus(NULL, NULL, NULL);
+	if (conn == NULL)
+		return;
+
+	dbus_error_init(&error);
+	hcid_exists = dbus_bus_name_has_owner(conn, "org.bluez", &error);
+	if (&error != NULL && dbus_error_is_set(&error))
+		return;
+
+	if (!hcid_exists)
+		return;
+
+	/* Get the default adapter */
+	message = dbus_message_new_method_call("org.bluez", "/org/bluez",
+					       "org.bluez.Manager",
+					       "DefaultAdapter");
+	if (message == NULL) {
+		dbus_connection_unref(conn);
+		return;
+	}
+	reply = dbus_connection_send_with_reply_and_block(conn,
+							  message, -1,
+							  &error);
+	dbus_message_unref(message);
+	if (&error != NULL && dbus_error_is_set(&error)) {
+		dbus_connection_unref(conn);
+		return;
+	}
+
+	dbus_message_iter_init(reply, &reply_iter);
+	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_STRING) {
+		dbus_message_unref(reply);
+		dbus_connection_unref(conn);
+		return;
+	}
+	dbus_message_iter_get_basic(&reply_iter, &adapter);
+	adapter = g_strdup(adapter);
+	dbus_message_unref(reply);
+
+	if (!dbus_connection_add_filter(conn, filter_func, adapter, g_free)) {
+		g_free(adapter);
+		dbus_connection_unref(conn);
+		return;
+	}
+
+#define MATCH_FORMAT				\
+	"type='signal',"			\
+	"interface='org.bluez.Adapter',"	\
+	"sender='org.bluez',"			\
+	"path='%s'"
+
+	len = strlen(MATCH_FORMAT) - 2 + strlen(adapter) + 1;
+	match = g_malloc(len);
+	snprintf(match, len, "type='signal',"
+		 "interface='org.bluez.Adapter',"
+		 "sender='org.bluez',"
+		 "path='%s'",
+		 adapter);
+	dbus_bus_add_match(conn, match, &error);
+	g_free(match);
+
+	message = dbus_message_new_method_call("org.bluez", adapter,
+					       "org.bluez.Adapter",
+					       "DiscoverDevicesWithoutNameResolving");
+
+	if (!dbus_connection_send_with_reply(conn,
+					     message, NULL, -1)) {
+		dbus_message_unref(message);
+		dbus_connection_unref(conn);
+		g_free(adapter);
+		return;
+	}
+	dbus_message_unref(message);
+
+	/* Also add the the recent devices */
+	g_timeout_add(0, (GSourceFunc) list_known_printers, adapter);
+
+	loop = g_main_loop_new(NULL, TRUE);
+	g_main_loop_run(loop);
+
+	dbus_connection_unref(conn);
+}
+
 /*
  *  Usage: printer-uri job-id user title copies options [file]
  *
@@ -73,7 +475,7 @@ int main(int argc, char *argv[])
 #endif /* HAVE_SIGSET */
 
 	if (argc == 1) {
-		puts("network bluetooth \"Unknown\" \"Bluetooth printer\"");
+		list_printers();
 		return 0;
 	}
 
Index: eglib/gmain.c
===================================================================
RCS file: /cvsroot/bluez/utils/eglib/gmain.c,v
retrieving revision 1.27
diff -u -p -r1.27 gmain.c
--- eglib/gmain.c	3 May 2007 15:41:42 -0000	1.27
+++ eglib/gmain.c	24 May 2007 18:50:17 -0000
@@ -1127,6 +1127,48 @@ void g_slist_free(GSList *list)
 	}
 }
 
+static inline GSList*
+_g_slist_remove_link (GSList *list,
+		      GSList *link)
+{
+	GSList *tmp;
+	GSList *prev;
+
+	prev = NULL;
+	tmp = list;
+
+	while (tmp)
+	{
+		if (tmp == link)
+		{
+			if (prev)
+				prev->next = tmp->next;
+			if (list == tmp)
+				list = list->next;
+
+			tmp->next = NULL;
+			break;
+		}
+
+		prev = tmp;
+		tmp = tmp->next;
+	}
+
+	return list;
+}
+
+
+GSList*
+g_slist_delete_link (GSList *list,
+		     GSList *link)
+{
+	list = _g_slist_remove_link(list, link);
+	g_free(link);
+
+	return list;
+}
+
+
 /* Memory allocation functions */
 
 gpointer g_malloc(gulong n_bytes)
Index: eglib/gmain.h
===================================================================
RCS file: /cvsroot/bluez/utils/eglib/gmain.h,v
retrieving revision 1.12
diff -u -p -r1.12 gmain.h
--- eglib/gmain.h	3 May 2007 15:41:43 -0000	1.12
+++ eglib/gmain.h	24 May 2007 18:50:17 -0000
@@ -191,6 +191,7 @@ int g_slist_length(GSList *list);
 
 void g_slist_foreach(GSList *list, GFunc func, void *user_data);
 void g_slist_free(GSList *list);
+GSList *g_slist_delete_link (GSList *list, GSList *link);
 
 /* End GSList declarations */
 

--=-M69p/EqRrZNfeT6Bzfa2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--=-M69p/EqRrZNfeT6Bzfa2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-M69p/EqRrZNfeT6Bzfa2--
