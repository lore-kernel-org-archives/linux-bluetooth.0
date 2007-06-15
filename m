Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <467297DF.2030401@access-company.com>
Date: Fri, 15 Jun 2007 15:45:03 +0200
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------020508090700070408040202"
Subject: [Bluez-devel] Input service signals
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

This is a multi-part message in MIME format.
--------------020508090700070408040202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I am using the Input service. It is very helpful.

But Connected/Disconnected signals from Device interface are currently 
only sent when connection/disconnection are done through the Device 
interface methods. They are not sent when remote device 
connects/disconnects.

I wrote a patch that move common code between server.c and device.c into 
a new file session.c. This allows to send those signals for all 
connect/disconnect.

Hope this is OK.

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic                   Access Company
Software engineer
Mail : mailto:frederic.danis@access-company.com
-----------------------------------------------


--------------020508090700070408040202
Content-Type: text/x-patch;
 name="signals_input.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="signals_input.patch"

? utils/input/Makefile.in
Index: utils/input/Makefile.am
===================================================================
RCS file: /cvsroot/bluez/utils/input/Makefile.am,v
retrieving revision 1.17
diff -d -u -p -r1.17 Makefile.am
--- utils/input/Makefile.am	9 May 2007 07:09:58 -0000	1.17
+++ utils/input/Makefile.am	15 Jun 2007 12:38:44 -0000
@@ -12,7 +12,7 @@ service_PROGRAMS = bluetoothd-service-in
 
 bluetoothd_service_input_SOURCES = main.c \
 	manager.h manager.c error.h error.c \
-	server.h server.c device.h device.c storage.h storage.c
+	server.h server.c device.h device.c storage.h storage.c session.c session.h
 
 LDADD = $(top_builddir)/common/libhelper.a \
 		@GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
Index: utils/input/device.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/device.c,v
retrieving revision 1.52
diff -d -u -p -r1.52 device.c
--- utils/input/device.c	29 May 2007 03:58:10 -0000	1.52
+++ utils/input/device.c	15 Jun 2007 12:38:45 -0000
@@ -52,6 +52,7 @@
 #include "error.h"
 #include "manager.h"
 #include "storage.h"
+#include "session.h"
 
 #define INPUT_DEVICE_INTERFACE	"org.bluez.input.Device"
 
@@ -77,9 +78,11 @@ struct device {
 	char			*name;
 	uint8_t			major;
 	uint8_t			minor;
-	struct hidp_connadd_req hidp; /* FIXME: Use dynamic alloc? */
+	uint16_t		vendor;
+	uint16_t		product;
 	struct fake_input	*fake;
 	struct pending_connect *pending_connect;
+	struct session_data *session;
 };
 
 static struct device *device_new(bdaddr_t *src, bdaddr_t *dst)
@@ -98,9 +101,6 @@ static struct device *device_new(bdaddr_
 	idev->major = (cls >> 8) & 0x1f;
 	idev->minor = (cls >> 2) & 0x3f;
 
-	/* FIXME:  hidp could be alloc dynamically */
-	snprintf(idev->hidp.name, 128, "%s", idev->name);
-
 	return idev;
 }
 
@@ -121,8 +121,6 @@ static void device_free(struct device *i
 		return;
 	if (idev->name)
 		g_free(idev->name);
-	if (idev->hidp.rd_data)
-		g_free(idev->hidp.rd_data);
 	if (idev->fake)
 		g_free(idev->fake);
 	if (idev->pending_connect) 
@@ -512,8 +510,7 @@ failed:
 static gboolean interrupt_connect_cb(GIOChannel *chan,
 			GIOCondition cond, struct device *idev)
 {
-	int ctl, isk, ret, err;
-	const char *path;
+	int isk, ret, err;
 	socklen_t len;
 
 	isk = g_io_channel_unix_get_fd(chan);
@@ -531,9 +528,6 @@ static gboolean interrupt_connect_cb(GIO
 
 	}
 
-	idev->hidp.intr_sock = isk;
-	idev->hidp.idle_to = 30 * 60;	/* 30 minutes */
-
 	len = sizeof(ret);
 	if (getsockopt(isk, SOL_SOCKET, SO_ERROR, &ret, &len) < 0) {
 		err = errno;
@@ -547,54 +541,24 @@ static gboolean interrupt_connect_cb(GIO
 		goto failed;
 	}
 
-	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
-	if (ctl < 0) {
-		err = errno;
-		error("Can't open HIDP control socket");
-		goto failed;
-	}
-
-	if (idev->hidp.subclass & 0x40) {
-		int ret;
-		ret = encrypt_link(&idev->src, &idev->dst);
-		if (ret < 0 && ret != -ENOKEY) {
-			err = -ret;
-			close(ctl);
-			goto failed;
-		}
-	}
-
-	if (ioctl(ctl, HIDPCONNADD, &idev->hidp) < 0) {
-		err = errno;
-		close(ctl);
-		goto failed;
-	}
+	create_device(idev->session);
 
 	/* Replying to the requestor */
 	send_message_and_unref(idev->pending_connect->conn,
 		dbus_message_new_method_return(idev->pending_connect->msg));
 
-	/* Sending the Connected signal */
-	path = dbus_message_get_path(idev->pending_connect->msg);
-	dbus_connection_emit_signal(idev->pending_connect->conn, path,
-			INPUT_DEVICE_INTERFACE, "Connected" ,
-			DBUS_TYPE_INVALID); 
-
-	close (ctl);
 	goto cleanup;
+
 failed:
 	err_connection_failed(idev->pending_connect->conn,
 				idev->pending_connect->msg, strerror(err));
 
-cleanup:
 	if (isk > 0)
 		close(isk);
 
-	close(idev->hidp.ctrl_sock);
-
-	idev->hidp.intr_sock = -1;
-	idev->hidp.ctrl_sock = -1;
+	remove_session(idev->session);
 
+cleanup:
 	pending_connect_free(idev->pending_connect);
 	idev->pending_connect = NULL;
 
@@ -604,7 +568,7 @@ cleanup:
 static gboolean control_connect_cb(GIOChannel *chan,
 			GIOCondition cond, struct device *idev)
 {
-	int ret, csk, err;
+	int ret, csk, isk, err;
 	socklen_t len;
 
 	csk = g_io_channel_unix_get_fd(chan);
@@ -621,9 +585,6 @@ static gboolean control_connect_cb(GIOCh
 		goto failed;
 	}
 
-	/* Set HID control channel */
-	idev->hidp.ctrl_sock = csk;
-
 	len = sizeof(ret);
 	if (getsockopt(csk, SOL_SOCKET, SO_ERROR, &ret, &len) < 0) {
 		err = errno;
@@ -638,12 +599,14 @@ static gboolean control_connect_cb(GIOCh
 	}
 
 	/* Connect to the HID interrupt channel */
-	if (l2cap_connect(&idev->src, &idev->dst, L2CAP_PSM_HIDP_INTR,
-				(GIOFunc) interrupt_connect_cb, idev) < 0) {
+	if ((isk = l2cap_connect(&idev->src, &idev->dst, L2CAP_PSM_HIDP_INTR,
+				(GIOFunc) interrupt_connect_cb, idev)) < 0) {
 
 		err = errno;
 		error("L2CAP connect failed:%s (%d)", strerror(errno), errno);
 		goto failed;
+	} else {
+		add_intr_sk(idev->session, isk);
 	}
 
 	return FALSE;
@@ -652,7 +615,6 @@ failed:
 	if (csk > 0)
 		close(csk);
 
-	idev->hidp.ctrl_sock = -1;
 	err_connection_failed(idev->pending_connect->conn,
 			idev->pending_connect->msg, strerror(err));
 	pending_connect_free(idev->pending_connect);
@@ -666,6 +628,7 @@ static int disconnect(struct device *ide
 	struct fake_input *fake = idev->fake;
 	struct hidp_conndel_req req;
 	struct hidp_conninfo ci;
+	struct session_data *session;
 	int ctl, err;
 
 	/* Fake input disconnect */
@@ -713,15 +676,16 @@ static int disconnect(struct device *ide
 
 	close(ctl);
 
+	session = find_session(&idev->src, &idev->dst);
+	if (session)
+		remove_session(session);
+
 	return 0;
 fail:
 	err = errno;
 	close(ctl);
 	errno = err;
 
-	idev->hidp.intr_sock = -1;
-	idev->hidp.ctrl_sock = -1;
-
 	return -err;
 }
 
@@ -766,10 +730,14 @@ static DBusHandlerResult device_connect(
 					DBusMessage *msg, void *data)
 {
 	struct device *idev = data;
+	int csk;
 
 	if (idev->pending_connect)
 		return err_connection_failed(conn, msg, "Connection in progress");
 
+	if (find_session(&idev->src, &idev->dst) != NULL)
+		return err_connection_failed(conn, msg, "Connection in progress");
+
 	if (is_connected(idev))
 		return err_already_connected(conn, msg);
 
@@ -795,14 +763,16 @@ static DBusHandlerResult device_connect(
 	}
 
 	/* HID devices */
-	if (l2cap_connect(&idev->src, &idev->dst, L2CAP_PSM_HIDP_CTRL,
-				(GIOFunc) control_connect_cb, idev) < 0) {
+	if ((csk = l2cap_connect(&idev->src, &idev->dst, L2CAP_PSM_HIDP_CTRL,
+				(GIOFunc) control_connect_cb, idev)) < 0) {
 		int err = errno;
 
 		error("L2CAP connect failed: %s(%d)", strerror(err), err);
 		pending_connect_free(idev->pending_connect);
 		idev->pending_connect = NULL;
 		return err_connection_failed(conn, msg, strerror(err));
+	} else {
+		idev->session = create_session(&idev->src, &idev->dst, csk, idev->pending_connect->conn, dbus_message_get_path(idev->pending_connect->msg));
 	}
 
 	return DBUS_HANDLER_RESULT_HANDLED;
@@ -812,7 +782,6 @@ static DBusHandlerResult device_disconne
 						DBusMessage *msg, void *data)
 {
 	struct device *idev = data;
-	const char *path;
 
 	if (disconnect(idev, 0) < 0)
 		return err_failed(conn, msg, strerror(errno));
@@ -821,12 +790,6 @@ static DBusHandlerResult device_disconne
 	send_message_and_unref(conn,
 			dbus_message_new_method_return(msg));
 
-	/* Sending the Disconnect signal */ 
-	path = dbus_message_get_path(msg);
-	dbus_connection_emit_signal(conn, path,
-			INPUT_DEVICE_INTERFACE, "Disconnected",
-			DBUS_TYPE_INVALID); 
-
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
@@ -896,14 +859,13 @@ static DBusHandlerResult device_get_name
 {
 	struct device *idev = data;
 	DBusMessage *reply;
-	const char *pname = idev->hidp.name;
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 
 	dbus_message_append_args(reply,
-			DBUS_TYPE_STRING, &pname,
+			DBUS_TYPE_STRING, &idev->name,
 			DBUS_TYPE_INVALID);
 
 	return send_message_and_unref(conn, reply);
@@ -920,7 +882,7 @@ static DBusHandlerResult device_get_prod
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 
 	dbus_message_append_args(reply,
-			DBUS_TYPE_UINT16, &idev->hidp.product,
+			DBUS_TYPE_UINT16, &idev->product,
 			DBUS_TYPE_INVALID);
 
 	return send_message_and_unref(conn, reply);
@@ -937,7 +899,7 @@ static DBusHandlerResult device_get_vend
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 
 	dbus_message_append_args(reply,
-			DBUS_TYPE_UINT16, &idev->hidp.vendor,
+			DBUS_TYPE_UINT16, &idev->vendor,
 			DBUS_TYPE_INVALID);
 
 	return send_message_and_unref(conn, reply);
@@ -1011,8 +973,8 @@ int input_device_register(DBusConnection
 	idev = device_new(src, dst);
 	path = create_input_path(idev->major, idev->minor);
 
-	/* rd_data must not be deallocated since the memory address is copied */
-	memcpy(&idev->hidp, hid, sizeof(struct hidp_connadd_req));
+	idev->vendor = hid->vendor;
+	idev->product = hid->product;
 
 	err = register_path(conn, path, idev);
 
@@ -1139,7 +1101,7 @@ int l2cap_connect(bdaddr_t *src, bdaddr_
 
 	g_io_channel_unref(io);
 
-	return 0;
+	return sk;
 
 failed:
 	err = errno;
Index: utils/input/manager.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/manager.c,v
retrieving revision 1.25
diff -d -u -p -r1.25 manager.c
--- utils/input/manager.c	9 May 2007 14:53:34 -0000	1.25
+++ utils/input/manager.c	15 Jun 2007 12:38:45 -0000
@@ -68,7 +68,7 @@ struct pending_req {
 	int		ctrl_sock;
 };
 
-static GSList *device_paths = NULL;	/* Input registered paths */
+GSList *device_paths = NULL;	/* Input registered paths */
 
 static DBusConnection *connection = NULL;
 
@@ -323,6 +323,9 @@ cleanup:
 	close(pr->ctrl_sock);
 	pending_req_free(pr);
 
+	if (hidp.rd_data)
+		g_free(hidp.rd_data);
+
 	return FALSE;
 }
 
@@ -778,7 +781,7 @@ done:
 	dbus_message_unref(reply);
 }
 
-static int path_bdaddr_cmp(const char *path, const bdaddr_t *bdaddr)
+int path_bdaddr_cmp(const char *path, const bdaddr_t *bdaddr)
 {
 	bdaddr_t src, dst;
 
@@ -954,9 +957,13 @@ static void stored_input(char *key, char
 	 * acceptable since the source is different.
 	 */
 	if (input_device_register(connection, src, &dst, &hidp, &path) < 0)
-		return;
+		goto cleanup;
 
 	device_paths = g_slist_append(device_paths, g_strdup(path));
+
+cleanup:
+	if (hidp.rd_data)
+		g_free(hidp.rd_data);
 }
 
 static void register_stored_inputs(void)
Index: utils/input/server.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/server.c,v
retrieving revision 1.13
diff -d -u -p -r1.13 server.c
--- utils/input/server.c	10 May 2007 13:57:15 -0000	1.13
+++ utils/input/server.c	15 Jun 2007 12:38:45 -0000
@@ -44,100 +44,12 @@
 
 #include "server.h"
 #include "storage.h"
+#include "session.h"
 
-struct session_data {
-	bdaddr_t src;
-	bdaddr_t dst;
-	int ctrl_sk;
-	int intr_sk;
-};
-
-static GSList *sessions = NULL;
 static DBusConnection *connection = NULL;
 
-static struct session_data *find_session(bdaddr_t *src, bdaddr_t *dst)
-{
-	GSList *list;
-
-	for (list = sessions; list != NULL; list = list->next) {
-		struct session_data *session = list->data;
-
-		if (!bacmp(&session->src, src) && !bacmp(&session->dst, dst))
-			return session;
-	}
-
-	return NULL;
-}
-
-static gboolean session_event(GIOChannel *chan, GIOCondition cond, gpointer data)
-{
-	if (cond & G_IO_NVAL)
-		return FALSE;
-
-	if (cond & (G_IO_HUP | G_IO_ERR)) {
-		g_io_channel_close(chan);
-		return FALSE;
-	}
-
-	return TRUE;
-}
-
-static void create_device(struct session_data *session)
-{
-	struct hidp_connadd_req req;
-	char addr[18];
-	int ctl, err, timeout = 30;
-
-	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
-	if (ctl < 0) {
-		error("Can't open HIDP interface");
-		goto cleanup;
-	}
-
-	ba2str(&session->dst, addr);
-
-	memset(&req, 0, sizeof(req));
-	req.ctrl_sock = session->ctrl_sk;
-	req.intr_sock = session->intr_sk;
-	req.flags     = 0;
-	req.idle_to   = timeout * 60;
-
-	if (get_stored_device_info(&session->src, &session->dst, &req) < 0) {
-		error("Rejected connection from unknown device %s", addr);
-		goto cleanup;
-	}
-
-	if (req.subclass & 0x40) {
-		err = encrypt_link(&session->src, &session->dst);
-		if (err < 0 && err != -ENOKEY) {
-			if (req.rd_data)
-				free(req.rd_data);
-			goto cleanup;
-		}
-	}
-
-	info("New input device %s (%s)", addr, req.name);
-
-	if (req.vendor == 0x054c && req.product == 0x0268) {
-		unsigned char buf[] = { 0x53, 0xf4,  0x42, 0x03, 0x00, 0x00 };
-		err = write(session->ctrl_sk, buf, sizeof(buf));
-	}
-
-	err = ioctl(ctl, HIDPCONNADD, &req);
-
-	close(ctl);
-
-	if (req.rd_data)
-		free(req.rd_data);
-
-cleanup:
-	sessions = g_slist_remove(sessions, session);
-
-	close(session->intr_sk);
-	close(session->ctrl_sk);
-
-	g_free(session);
-}
+extern GSList *device_paths;	/* Input registered paths */
+int path_bdaddr_cmp(const char *path, const bdaddr_t *bdaddr);
 
 static void cancel_authorization(const char *addr)
 {
@@ -177,12 +89,7 @@ static void authorization_callback(DBusP
 		}
 		dbus_error_free(&derr);
 
-		sessions = g_slist_remove(sessions, session);
-
-		close(session->intr_sk);
-		close(session->ctrl_sk);
-
-		g_free(session);
+		remove_session(session);
 	} else {
 		create_device(session);
 	}
@@ -223,18 +130,6 @@ static int authorize_device(struct sessi
 	return 0;
 }
 
-static void create_watch(int sk, struct session_data *session)
-{
-	GIOChannel *io;
-
-	io = g_io_channel_unix_new(sk);
-
-	g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-						session_event, session);
-
-	g_io_channel_unref(io);
-}
-
 static gboolean connect_event(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct session_data *session;
@@ -243,6 +138,7 @@ static gboolean connect_event(GIOChannel
 	bdaddr_t src, dst;
 	unsigned char psm;
 	int sk, nsk;
+	GSList *l;
 
 	sk = g_io_channel_unix_get_fd(chan);
 
@@ -271,15 +167,10 @@ static gboolean connect_event(GIOChannel
 	session = find_session(&src, &dst);
 	if (session) {
 		if (psm == 19) {
-			session->intr_sk = nsk;
+			add_intr_sk(session, nsk);
 			if (authorize_device(session) < 0) {
 				error("Authorization request failed");
-				sessions = g_slist_remove(sessions, session);
-
-				close(session->intr_sk);
-				close(session->ctrl_sk);
-
-				g_free(session);
+				remove_session(session);
 
 				return TRUE;
 			}
@@ -290,16 +181,17 @@ static gboolean connect_event(GIOChannel
 		}
 	} else {
 		if (psm == 17) {
-			session = g_new0(struct session_data, 1);
-
-			bacpy(&session->src, &src);
-			bacpy(&session->dst, &dst);
-			session->ctrl_sk = nsk;
-			session->intr_sk = -1;
-
-			sessions = g_slist_append(sessions, session);
-
-			create_watch(nsk, session);
+			l = g_slist_find_custom(device_paths, &dst, (GCompareFunc) path_bdaddr_cmp);
+			if (!l) {
+				error("Unknown remote");
+				close(nsk);
+			} else {
+				session = create_session(&src, &dst, nsk, connection, l->data);
+				if (session == NULL) {
+					error("Session exists");
+					close(nsk);
+				}
+			}
 		} else {
 			error("No control channel available");
 			close(nsk);
Index: utils/input/session.c
===================================================================
RCS file: utils/input/session.c
diff -N utils/input/session.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ utils/input/session.c	15 Jun 2007 12:38:45 -0000
@@ -0,0 +1,197 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2007  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hidp.h>
+
+#include <glib.h>
+
+#include "logging.h"
+#include "dbus.h"
+#include "dbus-helper.h"
+
+#include "session.h"
+#include "storage.h"
+
+#define INPUT_DEVICE_INTERFACE	"org.bluez.input.Device"
+
+static GSList *sessions = NULL;
+
+struct session_data *find_session(bdaddr_t *src, bdaddr_t *dst)
+{
+	GSList *list;
+
+	for (list = sessions; list != NULL; list = list->next) {
+		struct session_data *session = list->data;
+
+		if (!bacmp(&session->src, src) && !bacmp(&session->dst, dst))
+			return session;
+	}
+
+	return NULL;
+}
+
+static gboolean session_event(GIOChannel *chan, GIOCondition cond, gpointer data)
+{
+	struct session_data *session = (struct session_data *)data;
+	gboolean result = TRUE;
+
+	if (cond & G_IO_NVAL)
+		result = FALSE;
+	else if (cond & (G_IO_HUP | G_IO_ERR)) {
+		g_io_channel_close(chan);
+		result = FALSE;
+	}
+
+	if ((result == FALSE) && (session != NULL)) {
+		dbus_connection_emit_signal(session->connection, session->path,
+				INPUT_DEVICE_INTERFACE, "Disconnected" ,
+				DBUS_TYPE_INVALID); 
+
+		remove_session(session);
+		sessions = g_slist_remove(sessions, session);
+		g_free(session);
+	}
+
+	return result;
+}
+
+void create_device(struct session_data *session)
+{
+	struct hidp_connadd_req req;
+	char addr[18];
+	int ctl, err, timeout = 30;
+
+	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
+	if (ctl < 0) {
+		error("Can't open HIDP interface");
+		goto cleanup;
+	}
+
+	ba2str(&session->dst, addr);
+
+	memset(&req, 0, sizeof(req));
+	req.ctrl_sock = session->ctrl_sk;
+	req.intr_sock = session->intr_sk;
+	req.flags     = 0;
+	req.idle_to   = timeout * 60;
+
+	if (get_stored_device_info(&session->src, &session->dst, &req) < 0) {
+		error("Rejected connection from unknown device %s", addr);
+		goto cleanup;
+	}
+
+	if (req.subclass & 0x40) {
+		err = encrypt_link(&session->src, &session->dst);
+		if (err < 0 && err != -ENOKEY) {
+			if (req.rd_data)
+				free(req.rd_data);
+			goto cleanup;
+		}
+	}
+
+	info("New input device %s (%s)", addr, req.name);
+
+	if (req.vendor == 0x054c && req.product == 0x0268) {
+		unsigned char buf[] = { 0x53, 0xf4,  0x42, 0x03, 0x00, 0x00 };
+		err = write(session->ctrl_sk, buf, sizeof(buf));
+	}
+
+	err = ioctl(ctl, HIDPCONNADD, &req);
+
+	close(ctl);
+
+	dbus_connection_emit_signal(session->connection, session->path,
+			INPUT_DEVICE_INTERFACE, "Connected" ,
+			DBUS_TYPE_INVALID); 
+
+	if (req.rd_data)
+		free(req.rd_data);
+
+	return;
+
+cleanup:
+	remove_session(session);
+}
+
+static void create_watch(int sk, struct session_data *session)
+{
+	GIOChannel *io;
+
+	io = g_io_channel_unix_new(sk);
+
+	g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+						session_event, session);
+
+	g_io_channel_unref(io);
+}
+
+struct session_data* create_session(bdaddr_t *src, bdaddr_t *dst, int ctrl_sk, DBusConnection *connection, const char *path)
+{
+	struct session_data *session = NULL;
+
+	if (find_session(src, dst) != NULL)
+		return NULL;
+
+	session = g_new0(struct session_data, 1);
+
+	bacpy(&session->src, src);
+	bacpy(&session->dst, dst);
+	session->ctrl_sk = ctrl_sk;
+	session->intr_sk = -1;
+	session->connection = connection;
+	session->path = path;
+
+	sessions = g_slist_append(sessions, session);
+
+	create_watch(ctrl_sk, session);
+
+	return session;
+}
+
+void add_intr_sk(struct session_data *session, int intr_sk)
+{
+	session->intr_sk = intr_sk;
+}
+
+void remove_session(struct session_data *session)
+{
+	if (!session)
+		return;
+
+	if (session->intr_sk != -1)
+		close(session->intr_sk);
+	if (session->ctrl_sk != -1)
+		close(session->ctrl_sk);
+}
+
Index: utils/input/session.h
===================================================================
RCS file: utils/input/session.h
diff -N utils/input/session.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ utils/input/session.h	15 Jun 2007 12:38:45 -0000
@@ -0,0 +1,40 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2007  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <bluetooth/bluetooth.h>
+
+struct session_data {
+	bdaddr_t src;
+	bdaddr_t dst;
+	int ctrl_sk;
+	int intr_sk;
+	DBusConnection *connection;
+	const char *path;
+};
+
+struct session_data *find_session(bdaddr_t *src, bdaddr_t *dst);
+void create_device(struct session_data *session);
+struct session_data* create_session(bdaddr_t *src, bdaddr_t *dst, int ctrl_sk, DBusConnection *connection, const char *path);
+void add_intr_sk(struct session_data *session, int intr_sk);
+void remove_session(struct session_data *session);
+

--------------020508090700070408040202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------020508090700070408040202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020508090700070408040202--
