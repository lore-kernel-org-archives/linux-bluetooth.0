Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/7] client: add driver support
Date: Thu, 11 Aug 2011 16:49:48 +0300
Message-Id: <1313070594-31068-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am      |    4 +-
 client/driver.c  |   85 ++++++++++++++++++++++++++++++++++++++
 client/driver.h  |   35 ++++++++++++++++
 client/ftp.c     |    2 +
 client/pbap.c    |    2 +
 client/session.c |  120 +++++++++++++++++++++++++-----------------------------
 client/session.h |    3 -
 7 files changed, 182 insertions(+), 69 deletions(-)
 create mode 100644 client/driver.c
 create mode 100644 client/driver.h

diff --git a/Makefile.am b/Makefile.am
index d412f02..314afc4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -131,8 +131,8 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/sync.h client/sync.c \
 				client/ftp.h client/ftp.c \
 				client/transfer.h client/transfer.c \
-				client/agent.h client/agent.c
-
+				client/agent.h client/agent.c \
+				client/driver.h client/driver.c
 
 client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @OPENOBEX_LIBS@ @BLUEZ_LIBS@
 endif
diff --git a/client/driver.c b/client/driver.c
new file mode 100644
index 0000000..54c5c3b
--- /dev/null
+++ b/client/driver.c
@@ -0,0 +1,85 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <string.h>
+#include <errno.h>
+#include <glib.h>
+
+#include "session.h"
+#include "driver.h"
+#include "log.h"
+
+static GSList *drivers = NULL;
+
+struct driver_data *driver_find(const char *pattern)
+{
+	GSList *l;
+
+	for (l = drivers; l; l = l->next) {
+		struct driver_data *driver = l->data;
+
+		if (strcasecmp(pattern, driver->service) == 0)
+			return driver;
+
+		if (strcasecmp(pattern, driver->uuid) == 0)
+			return driver;
+	}
+
+	return NULL;
+}
+
+int driver_register(struct driver_data *driver)
+{
+	if (!driver) {
+		error("Invalid driver");
+		return -EINVAL;
+	}
+
+	if (driver_find(driver->service)) {
+		error("Permission denied: service %s already registered",
+			driver->service);
+		return -EPERM;
+	}
+
+	DBG("driver %p service %s registered", driver, driver->service);
+
+	drivers = g_slist_append(drivers, driver);
+
+	return 0;
+}
+
+void driver_unregister(struct driver_data *driver)
+{
+	if (!g_slist_find(drivers, driver)) {
+		error("Unable to unregister: No such driver %p", driver);
+		return;
+	}
+
+	DBG("driver %p service %s unregistered", driver, driver->service);
+
+	drivers = g_slist_remove(drivers, driver);
+}
diff --git a/client/driver.h b/client/driver.h
new file mode 100644
index 0000000..5979fe8
--- /dev/null
+++ b/client/driver.h
@@ -0,0 +1,35 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
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
+struct driver_data {
+	const char *service;
+	const char *uuid;
+	void *target;
+	int target_len;
+	int (*probe) (struct session_data *session);
+	void (*remove) (struct session_data *session);
+};
+
+int driver_register(struct driver_data *driver);
+void driver_unregister(struct driver_data *driver);
+struct driver_data *driver_find(const char *pattern);
diff --git a/client/ftp.c b/client/ftp.c
index d8557f2..98514fd 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -25,6 +25,8 @@
 #include <config.h>
 #endif
 
+#include <string.h>
+
 #include "session.h"
 #include "transfer.h"
 #include "ftp.h"
diff --git a/client/pbap.c b/client/pbap.c
index 38d5a47..a87ec07 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -27,6 +27,8 @@
 #endif
 
 #include <errno.h>
+#include <string.h>
+#include <stdio.h>
 #include <glib.h>
 #include <gdbus.h>
 
diff --git a/client/session.c b/client/session.c
index a89c760..79c178d 100644
--- a/client/session.c
+++ b/client/session.c
@@ -48,6 +48,7 @@
 #include "session.h"
 #include "btio.h"
 #include "agent.h"
+#include "driver.h"
 
 #define SESSION_INTERFACE  "org.openobex.Session"
 #define SESSION_BASEPATH   "/org/openobex"
@@ -61,10 +62,6 @@
 
 static guint64 counter = 0;
 
-static unsigned char pcsuite_uuid[] = { 0x00, 0x00, 0x50, 0x05, 0x00, 0x00,
-					0x10, 0x00, 0x80, 0x00, 0x00, 0x02,
-					0xEE, 0x00, 0x00, 0x01 };
-
 struct callback_data {
 	struct session_data *session;
 	sdp_session_t *sdp;
@@ -93,10 +90,7 @@ struct session_data {
 	bdaddr_t src;
 	bdaddr_t dst;
 	uint8_t channel;
-	char *service;		/* Service friendly name */
-	const char *target;	/* OBEX Target UUID */
-	int target_len;
-	uuid_t uuid;		/* Bluetooth Service Class */
+	struct driver_data *driver;
 	gchar *path;		/* Session path */
 	DBusConnection *conn;
 	DBusConnection *conn_system; /* system bus connection */
@@ -139,16 +133,8 @@ static void session_unregistered(struct session_data *session)
 {
 	char *path;
 
-	switch (session->uuid.value.uuid16) {
-	case OBEX_FILETRANS_SVCLASS_ID:
-		ftp_unregister_interface(session->conn, session->path);
-		break;
-	case PBAP_PSE_SVCLASS_ID:
-		pbap_unregister_interface(session->conn, session->path);
-		break;
-	case IRMC_SYNC_SVCLASS_ID:
-		sync_unregister_interface(session->conn, session->path);
-	}
+	if (session->driver && session->driver->remove)
+		session->driver->remove(session);
 
 	path = session->path;
 	session->path = NULL;
@@ -229,7 +215,6 @@ static void session_free(struct session_data *session)
 	g_free(session->adapter);
 	g_free(session->callback);
 	g_free(session->path);
-	g_free(session->service);
 	g_free(session->owner);
 	g_free(session);
 }
@@ -306,6 +291,7 @@ static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct callback_data *callback = user_data;
 	struct session_data *session = callback->session;
+	struct driver_data *driver = session->driver;
 	GwObex *obex;
 	int fd;
 
@@ -323,8 +309,8 @@ static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 
 	fd = g_io_channel_unix_get_fd(io);
 
-	obex = gw_obex_setup_fd(fd, session->target,
-			session->target_len, NULL, NULL);
+	obex = gw_obex_setup_fd(fd, driver->target, driver->target_len,
+								NULL, NULL);
 
 	session->obex = obex;
 
@@ -458,6 +444,37 @@ static gboolean process_callback(GIOChannel *io, GIOCondition cond,
 	return TRUE;
 }
 
+static int bt_string2uuid(uuid_t *uuid, const char *string)
+{
+	uint32_t data0, data4;
+	uint16_t data1, data2, data3, data5;
+
+	if (sscanf(string, "%08x-%04hx-%04hx-%04hx-%08x%04hx",
+				&data0, &data1, &data2, &data3, &data4, &data5) == 6) {
+		uint8_t val[16];
+
+		data0 = g_htonl(data0);
+		data1 = g_htons(data1);
+		data2 = g_htons(data2);
+		data3 = g_htons(data3);
+		data4 = g_htonl(data4);
+		data5 = g_htons(data5);
+
+		memcpy(&val[0], &data0, 4);
+		memcpy(&val[4], &data1, 2);
+		memcpy(&val[6], &data2, 2);
+		memcpy(&val[8], &data3, 2);
+		memcpy(&val[10], &data4, 4);
+		memcpy(&val[14], &data5, 2);
+
+		sdp_uuid128_create(uuid, val);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static gboolean service_callback(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -466,6 +483,7 @@ static gboolean service_callback(GIOChannel *io, GIOCondition cond,
 	sdp_list_t *search, *attrid;
 	uint32_t range = 0x0000ffff;
 	GError *gerr = NULL;
+	uuid_t uuid;
 
 	if (cond & (G_IO_NVAL | G_IO_ERR))
 		goto failed;
@@ -473,7 +491,10 @@ static gboolean service_callback(GIOChannel *io, GIOCondition cond,
 	if (sdp_set_notify(callback->sdp, search_callback, callback) < 0)
 		goto failed;
 
-	search = sdp_list_append(NULL, &callback->session->uuid);
+	if (bt_string2uuid(&uuid, session->driver->uuid) < 0)
+		goto failed;
+
+	search = sdp_list_append(NULL, &uuid);
 	attrid = sdp_list_append(NULL, &range);
 
 	if (sdp_service_search_attr_async(callback->sdp,
@@ -594,7 +615,7 @@ static struct session_data *session_find(const char *source,
 		if (bacmp(&session->dst, &adr))
 			continue;
 
-		if (g_strcmp0(service, session->service))
+		if (g_strcmp0(service, session->driver->service))
 			continue;
 
 		if (channel && session->channel != channel)
@@ -730,6 +751,7 @@ struct session_data *session_create(const char *source,
 	struct session_data *session;
 	struct callback_data *callback;
 	struct pending_req *req;
+	struct driver_data *driver;
 
 	if (destination == NULL)
 		return NULL;
@@ -740,6 +762,10 @@ struct session_data *session_create(const char *source,
 		goto proceed;
 	}
 
+	driver = driver_find(service);
+	if (!driver)
+		return NULL;
+
 	session = g_try_malloc0(sizeof(*session));
 	if (session == NULL)
 		return NULL;
@@ -765,27 +791,9 @@ struct session_data *session_create(const char *source,
 		str2ba(source, &session->src);
 
 	str2ba(destination, &session->dst);
-	session->service = g_strdup(service);
-
-	if (!g_ascii_strncasecmp(service, "OPP", 3)) {
-		sdp_uuid16_create(&session->uuid, OBEX_OBJPUSH_SVCLASS_ID);
-	} else if (!g_ascii_strncasecmp(service, "FTP", 3)) {
-		sdp_uuid16_create(&session->uuid, OBEX_FILETRANS_SVCLASS_ID);
-		session->target = OBEX_FTP_UUID;
-		session->target_len = OBEX_FTP_UUID_LEN;
-	} else if (!g_ascii_strncasecmp(service, "PBAP", 4)) {
-		sdp_uuid16_create(&session->uuid, PBAP_PSE_SVCLASS_ID);
-		session->target = OBEX_PBAP_UUID;
-		session->target_len = OBEX_PBAP_UUID_LEN;
-	} else if (!g_ascii_strncasecmp(service, "SYNC", 4)) {
-		sdp_uuid16_create(&session->uuid, IRMC_SYNC_SVCLASS_ID);
-		session->target = OBEX_SYNC_UUID;
-		session->target_len = OBEX_SYNC_UUID_LEN;
-	} else if (!g_ascii_strncasecmp(service, "PCSUITE", 7)) {
-		sdp_uuid128_create(&session->uuid, pcsuite_uuid);
-	} else {
-		return NULL;
-	}
+	session->driver = driver;
+
+	DBG("driver %s", driver->service);
 
 proceed:
 	callback = g_try_malloc0(sizeof(*callback));
@@ -1286,8 +1294,6 @@ int session_pull(struct session_data *session,
 const char *session_register(struct session_data *session,
 						GDBusDestroyFunction destroy)
 {
-	gboolean result = FALSE;
-
 	if (session->path)
 		return session->path;
 
@@ -1299,23 +1305,9 @@ const char *session_register(struct session_data *session,
 					NULL, NULL, session, destroy) == FALSE)
 		goto fail;
 
-	switch (session->uuid.value.uuid16) {
-	case OBEX_FILETRANS_SVCLASS_ID:
-		result = ftp_register_interface(session->conn, session->path,
-								session);
-		break;
-	case PBAP_PSE_SVCLASS_ID:
-		result = pbap_register_interface(session->conn, session->path,
-								session);
-		break;
-	case IRMC_SYNC_SVCLASS_ID:
-		result = sync_register_interface(session->conn, session->path,
-								session);
-	}
-
-	if (result == FALSE) {
-		g_dbus_unregister_interface(session->conn,
-					session->path, SESSION_INTERFACE);
+	if (session->driver == NULL || session->driver->probe(session) < 0) {
+		g_dbus_unregister_interface(session->conn, session->path,
+							SESSION_INTERFACE);
 		goto fail;
 	}
 
@@ -1432,7 +1424,7 @@ const char *session_get_path(struct session_data *session)
 
 const char *session_get_target(struct session_data *session)
 {
-	return session->target;
+	return session->driver->target;
 }
 
 GwObex *session_get_obex(struct session_data *session)
diff --git a/client/session.h b/client/session.h
index 081a2c3..014daaf 100644
--- a/client/session.h
+++ b/client/session.h
@@ -25,9 +25,6 @@
 #include <gdbus.h>
 #include <gw-obex.h>
 
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-
 struct session_data;
 
 typedef void (*session_callback_t) (struct session_data *session,
-- 
1.7.6

