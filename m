Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Philip Blundell <pb@nexus.co.uk>
To: bluez-devel@lists.sourceforge.net
Message-Id: <1056040950.3518.18.camel@mill.nexus.co.uk>
Mime-Version: 1.0
Subject: [Bluez-devel] patch for d-bus support in hcid
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
Date: 19 Jun 2003 17:42:30 +0100
Content-Type: multipart/mixed; boundary="=-RXsGmAQd7owVYGoi4XuW"


--=-RXsGmAQd7owVYGoi4XuW
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

This patch adds support to hcid for PIN requests using D-BUS.  (See
http://www.freedesktop.org/software/dbus/ if you don't know what D-BUS
is about.)

The advantage of this is that the UI for PIN entry runs as the logged-in
user, rather than root.  There's then no need for the helper application
to try to guess the value for $DISPLAY or anything like that.

To use this mechanism, you need to configure bluez-utils with
--enable-dbus, and set pin-helper to "*dbus" in hcid.conf.

Thanks

p.


--=-RXsGmAQd7owVYGoi4XuW
Content-Disposition: attachment; filename=bluez-dbus.diff
Content-Transfer-Encoding: 7bit
Content-Type: text/x-patch; NAME=bluez-dbus.diff; CHARSET=ISO-8859-1

diff -uprN clean/bluez-utils-2.3/configure.in bluez-utils-2.3/configure.in
--- clean/bluez-utils-2.3/configure.in	2003-03-20 06:28:26.000000000 +0000
+++ bluez-utils-2.3/configure.in	2003-06-18 17:36:22.000000000 +0100
@@ -44,6 +44,12 @@ AC_ARG_WITH(bluez-includes,
 	BLUEZ_INCDIR='../libs/include /usr/include'
 )
 
+AC_ARG_ENABLE(dbus,
+	--enable-dbus		  use D-BUS,
+	BLUEZ_DBUS="$enableval",
+	BLUEZ_DBUS="no"
+)
+
 AC_SEARCH_HEADERS(bluetooth/bluetooth.h, $BLUEZ_INCDIR,,
 	AC_MSG_ERROR(Bluetooth headers not found.
 		Please compile and install bluez-libs package.)
@@ -71,4 +77,13 @@ AC_ARG_ENABLE(pcmcia,
            AC_TEST_DIR(/etc/pcmcia, PCMCIA=pcmcia, PCMCIA=)
     fi ])
 
+if test x"$BLUEZ_DBUS" == "xyes"; then
+  PKG_CHECK_MODULES(DBUS, dbus-1, have_dbus=yes, have_dbus=no)
+
+  CFLAGS="$CFLAGS $DBUS_CFLAGS -DDBUS_API_SUBJECT_TO_CHANGE -DENABLE_DBUS"
+  LIBS="$LIBS $DBUS_LIBS"
+fi
+
+AM_CONDITIONAL(ENABLE_DBUS, test x$BLUEZ_DBUS = xyes)
+
 AC_OUTPUT(Makefile hcid/Makefile tools/Makefile rfcomm/Makefile test/Makefile scripts/Makefile pcmcia/Makefile)
diff -uprN clean/bluez-utils-2.3/hcid/Makefile.am bluez-utils-2.3/hcid/Makefile.am
--- clean/bluez-utils-2.3/hcid/Makefile.am	2003-03-20 05:58:11.000000000 +0000
+++ bluez-utils-2.3/hcid/Makefile.am	2003-06-18 17:32:34.000000000 +0100
@@ -4,7 +4,13 @@
 
 sbin_PROGRAMS = hcid
 
-hcid_SOURCES = main.c security.c hcid.h lib.c lib.h parser.h parser.y lexer.l kword.h kword.c glib-ectomy.h glib-ectomy.c
+if ENABLE_DBUS
+dbus_hcid_sources = dbus.c
+else
+dbus_hcid_sources =
+endif
+
+hcid_SOURCES = main.c security.c hcid.h lib.c lib.h parser.h parser.y lexer.l kword.h kword.c glib-ectomy.h glib-ectomy.c $(dbus_hcid_sources)
 hcid_CONFIG  = hcid.conf
 
 YFLAGS   = -d
diff -uprN clean/bluez-utils-2.3/hcid/glib-ectomy.h bluez-utils-2.3/hcid/glib-ectomy.h
--- clean/bluez-utils-2.3/hcid/glib-ectomy.h	2003-03-07 23:13:27.000000000 +0000
+++ bluez-utils-2.3/hcid/glib-ectomy.h	2003-06-18 17:38:48.000000000 +0100
@@ -87,6 +87,8 @@ guint     g_io_add_watch        (GIOChan
 				 GIOCondition     condition,
 				 GIOFunc          func,
 				 gpointer         user_data);
+void  g_io_remove_watch (guint id);
+
 
 
 GMainLoop *g_main_loop_new        (GMainContext *context,
diff -uprN clean/bluez-utils-2.3/hcid/hcid.h bluez-utils-2.3/hcid/hcid.h
--- clean/bluez-utils-2.3/hcid/hcid.h	2003-03-20 05:58:11.000000000 +0000
+++ bluez-utils-2.3/hcid/hcid.h	2003-06-17 17:12:35.000000000 +0100
@@ -91,3 +91,8 @@ void init_security_data(void);
 void start_security_manager(int hdev);
 void stop_security_manager(int hdev);
 void toggle_pairing(int enable);
+#ifdef ENABLE_DBUS
+struct hci_conn_info;
+void hcid_dbus_request_pin(int dev, struct hci_conn_info *ci);
+gboolean hcid_dbus_init(void);
+#endif
diff -uprN clean/bluez-utils-2.3/hcid/main.c bluez-utils-2.3/hcid/main.c
--- clean/bluez-utils-2.3/hcid/main.c	2003-03-20 05:58:11.000000000 +0000
+++ bluez-utils-2.3/hcid/main.c	2003-06-17 17:09:25.000000000 +0100
@@ -451,6 +451,13 @@ int main(int argc, char *argv[], char *e
 	if (read_config(hcid.config_file) < 0)
 		syslog(LOG_ERR, "Config load failed");
 
+#ifdef ENABLE_DBUS
+	if (hcid_dbus_init () == FALSE) {
+		syslog (LOG_ERR, "Unable to get on D-BUS");
+		exit (1);
+	}
+#endif
+
 	init_security_data();
 
 	/* Create event loop */
diff -uprN clean/bluez-utils-2.3/hcid/parser.y bluez-utils-2.3/hcid/parser.y
--- clean/bluez-utils-2.3/hcid/parser.y	2002-08-20 19:42:12.000000000 +0100
+++ bluez-utils-2.3/hcid/parser.y	2003-06-17 17:54:19.000000000 +0100
@@ -97,7 +97,7 @@ hcid_opt: 
 				hcid.pairing = $2;
 			}
 
-  | K_PINHELP  PATH	{
+  | K_PINHELP  WORD	{
 				if (hcid.pin_helper)
 					free(hcid.pin_helper);
 				hcid.pin_helper = strdup($2);
diff -uprN clean/bluez-utils-2.3/hcid/security.c bluez-utils-2.3/hcid/security.c
--- clean/bluez-utils-2.3/hcid/security.c	2003-03-20 05:58:12.000000000 +0000
+++ bluez-utils-2.3/hcid/security.c	2003-06-17 17:12:59.000000000 +0100
@@ -289,6 +289,17 @@ reject:
 	exit(0);
 }
 
+static void request_pin(int dev, struct hci_conn_info *ci)
+{
+#ifdef ENABLE_DBUS
+	if (!strcmp (hcid.pin_helper, "*dbus")) {
+		hcid_dbus_request_pin (dev, ci);
+		return;
+	}
+#endif
+	call_pin_helper (dev, ci);
+}
+
 static void pin_code_request(int dev, bdaddr_t *sba, bdaddr_t *dba)
 {
 	struct hci_conn_info_req *cr;
@@ -335,11 +346,11 @@ static void pin_code_request(int dev, bd
 			/* Outgoing connection */
 		
 			/* Let PIN helper handle that */ 
-			call_pin_helper(dev, ci);
+			request_pin(dev, ci);
 		}
 	} else {
 		/* Let PIN helper handle that */ 
-		call_pin_helper(dev, ci);
+		request_pin(dev, ci);
 	}	
 	free(cr);
 	return;
--- clean/bluez-utils-2.3/hcid/glib-ectomy.c	2003-03-20 06:29:20.000000000 +0000
+++ bluez-utils-2.3/hcid/glib-ectomy.c	2003-06-19 17:27:28.000000000 +0100
@@ -84,6 +84,19 @@
 
 static struct watch watch_head = { .id = 0, .next = 0 };
 
+void  g_io_remove_watch (guint id)
+{
+	struct watch *w, *p;
+
+	for (p = &watch_head, w = watch_head.next; w; w = w->next) {
+		if (w->id == id) {
+			p->next = w->next;
+			free (w);
+			return;
+		}
+	}
+}
+
 guint     g_io_add_watch        (GIOChannel      *channel,
 				 GIOCondition     condition,
 				 GIOFunc          func,
--- clean/bluez-utils-2.3/hcid/dbus.c	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.3/hcid/dbus.c	2003-06-19 17:12:43.000000000 +0100
@@ -0,0 +1,232 @@
+/* 
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (C) 2003 Phil Blundell <pb@nexus.co.uk>
+   
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+   
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+   OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER
+   RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
+   NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
+   USE OR PERFORMANCE OF THIS SOFTWARE.
+   
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, COPYRIGHTS,
+   TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS SOFTWARE IS DISCLAIMED.
+*/
+
+#include <stdio.h>
+#include <sys/socket.h>
+#include <sys/syslog.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+
+#include <dbus/dbus.h>
+
+#include "hcid.h"
+#include "glib-ectomy.h"
+
+static DBusConnection *connection;
+
+#define TIMEOUT (30*1000)		// 30 seconds
+
+#define REQUEST_NAME "org.handhelds.gpe.bluez.pin-request"
+
+struct pin_request
+{
+	int dev;
+	bdaddr_t bda;
+};
+
+static DBusHandlerResult
+reply_handler_function (DBusMessageHandler *handler,
+			DBusConnection     *connection,
+			DBusMessage        *message,
+			void               *user_data)
+{
+	struct pin_request *req = (struct pin_request *)user_data;
+	pin_code_reply_cp pr;
+	DBusMessageIter iter;
+	int type;
+	size_t len;
+	char *pin;
+	
+	if (dbus_message_get_is_error (message)) {
+		syslog (LOG_ERR, "Received D-BUS error response");
+		goto error;
+	}
+	
+	dbus_message_iter_init (message, &iter);
+	
+	type = dbus_message_iter_get_arg_type (&iter);
+	if (type != DBUS_TYPE_STRING) {
+		syslog (LOG_ERR, "Received malformed D-BUS reply");
+		goto error;
+	}
+
+	pin = dbus_message_iter_get_string (&iter);
+	len = strlen (pin);
+
+	memset (&pr, 0, sizeof(pr));
+	bacpy (&pr.bdaddr, &req->bda);
+	memcpy (pr.pin_code, pin, len);
+	pr.pin_len = len;
+	hci_send_cmd(req->dev, OGF_LINK_CTL, OCF_PIN_CODE_REPLY,
+		     PIN_CODE_REPLY_CP_SIZE, &pr);
+	
+	return DBUS_HANDLER_RESULT_REMOVE_MESSAGE;
+	
+ error:
+	hci_send_cmd(req->dev, OGF_LINK_CTL, OCF_PIN_CODE_NEG_REPLY, 6, &req->bda);
+	return DBUS_HANDLER_RESULT_REMOVE_MESSAGE;
+}
+
+static void
+free_pin_req (void *req)
+{
+	free (req);
+}
+     
+void
+hcid_dbus_request_pin (int dev, struct hci_conn_info *ci)
+{
+	DBusMessage *message;
+	DBusMessageIter iter;
+	DBusMessageHandler *reply_handler;
+	struct pin_request *req;
+	bdaddr_t ba;
+	int i;
+	
+	message = dbus_message_new (REQUEST_NAME, DBUS_SERVICE_BROADCAST);
+	if (message == NULL) {
+		syslog (LOG_ERR, "Couldn't allocate D-BUS message");
+		goto failed;
+	}
+	
+	req = malloc (sizeof (*req));
+	req->dev = dev;
+	bacpy (&req->bda, &ci->bdaddr);
+	
+	reply_handler = dbus_message_handler_new (reply_handler_function, req, free_pin_req);
+	
+	dbus_message_append_iter_init (message, &iter);
+	
+	dbus_message_iter_append_boolean (&iter, ci->out);
+	for (i = 0; i < 6; i++) {
+		unsigned char *d = (unsigned char *)&ci->bdaddr;
+		dbus_message_iter_append_byte (&iter, d[i]);
+	}
+	
+	baswap (&ba, &ci->bdaddr);
+	
+	if (dbus_connection_send_with_reply (connection, message, reply_handler, TIMEOUT) == FALSE) {
+		syslog (LOG_ERR, "D-BUS send failed");
+		goto failed;
+	}
+
+	dbus_connection_flush (connection);
+
+	return;
+
+ failed:
+	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_NEG_REPLY, 6, &ci->bdaddr);
+}
+
+gboolean
+watch_func (GIOChannel *chan, GIOCondition cond, gpointer data)
+{
+	int flags = 0;
+	DBusWatch *watch = (DBusWatch *)data;
+
+	if (cond & G_IO_IN) flags |= DBUS_WATCH_READABLE;
+	if (cond & G_IO_OUT) flags |= DBUS_WATCH_WRITABLE;
+	if (cond & G_IO_HUP) flags |= DBUS_WATCH_HANGUP;
+	if (cond & G_IO_ERR) flags |= DBUS_WATCH_ERROR;
+	
+	dbus_watch_handle (watch, flags);
+  
+	dbus_connection_ref (connection);
+  
+	/* Dispatch messages */
+	while (dbus_connection_dispatch (connection) == DBUS_DISPATCH_DATA_REMAINS)
+		;
+
+	dbus_connection_unref (connection);
+
+	return TRUE;
+}
+
+dbus_bool_t
+add_watch (DBusWatch *watch, void *data)
+{
+	GIOCondition cond = G_IO_HUP | G_IO_ERR;
+	int fd;
+	GIOChannel *io;
+	int flags;
+	guint id;
+	
+	if (!dbus_watch_get_enabled (watch))
+		return TRUE;
+
+	fd = dbus_watch_get_fd (watch);
+	io = g_io_channel_unix_new (fd);
+	flags = dbus_watch_get_flags (watch);
+  
+	if (flags & DBUS_WATCH_READABLE) cond |= G_IO_IN;
+	if (flags & DBUS_WATCH_WRITABLE) cond |= G_IO_OUT;
+  
+	id = g_io_add_watch (io, cond, watch_func, watch);
+	
+	dbus_watch_set_data (watch, (void *)id, NULL);
+	
+	return TRUE;
+}
+
+static void
+remove_watch (DBusWatch *watch, void *data)
+{
+	guint id = (guint)dbus_watch_get_data (watch);
+
+	dbus_watch_set_data (watch, NULL, NULL);
+
+	if (id)
+		g_io_remove_watch (id);
+}
+
+static void
+watch_toggled (DBusWatch *watch, void *data)
+{
+	/* Because we just exit on OOM, enable/disable is
+	 * no different from add/remove
+	 */
+	if (dbus_watch_get_enabled (watch))
+		add_watch (watch, data);
+	else
+		remove_watch (watch, data);
+}
+
+gboolean
+hcid_dbus_init (void)
+{
+	DBusError error;
+
+	dbus_error_init (&error);
+	connection = dbus_bus_get (DBUS_BUS_SYSTEM, &error);
+	if (connection == NULL) {
+		syslog (LOG_ERR, "Failed to open connection to system message bus: %s\n",
+			 error.message);
+		dbus_error_free (&error);
+		return FALSE;
+	}
+
+	dbus_connection_set_watch_functions (connection, add_watch, remove_watch,
+					     watch_toggled, NULL, NULL);
+	
+	return TRUE;
+}

--=-RXsGmAQd7owVYGoi4XuW--
