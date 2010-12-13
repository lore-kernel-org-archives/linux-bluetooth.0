Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10] serial: use btd_error_failed()
Date: Mon, 13 Dec 2010 19:33:06 -0200
Message-Id: <1292275987-13799-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1292275987-13799-9-git-send-email-padovan@profusion.mobi>
References: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-2-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-3-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-4-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-5-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-6-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-7-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-8-git-send-email-padovan@profusion.mobi>
 <1292275987-13799-9-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 serial/port.c  |   20 +++++++++-----------
 serial/proxy.c |    8 ++------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/serial/port.c b/serial/port.c
index 0d1e600..1458f06 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -248,7 +248,7 @@ static void open_notify(int fd, int err, struct serial_port *port)
 	if (err) {
 		/* Max tries exceeded */
 		port_release(port);
-		reply = failed(port->msg, strerror(err));
+		reply = btd_error_failed(port->msg, strerror(err));
 	} else {
 		port->fd = fd;
 		reply = g_dbus_create_reply(port->msg,
@@ -316,7 +316,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 
 	if (conn_err) {
 		error("%s", conn_err->message);
-		reply = failed(port->msg, conn_err->message);
+		reply = btd_error_failed(port->msg, conn_err->message);
 		goto fail;
 	}
 
@@ -335,7 +335,7 @@ static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
 	if (port->id < 0) {
 		int err = errno;
 		error("ioctl(RFCOMMCREATEDEV): %s (%d)", strerror(err), err);
-		reply = failed(port->msg, strerror(err));
+		reply = btd_error_failed(port->msg, strerror(err));
 		g_io_channel_shutdown(chan, TRUE, NULL);
 		goto fail;
 	}
@@ -378,13 +378,13 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 	if (err < 0) {
 		error("Unable to get service record: %s (%d)", strerror(-err),
 			-err);
-		reply = failed(port->msg, strerror(-err));
+		reply = btd_error_failed(port->msg, strerror(-err));
 		goto failed;
 	}
 
 	if (!recs || !recs->data) {
 		error("No record found");
-		reply = failed(port->msg, "No record found");
+		reply = btd_error_failed(port->msg, "No record found");
 		goto failed;
 	}
 
@@ -392,7 +392,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 	if (sdp_get_access_protos(record, &protos) < 0) {
 		error("Unable to get access protos from port record");
-		reply = failed(port->msg, "Invalid channel");
+		reply = btd_error_failed(port->msg, "Invalid channel");
 		goto failed;
 	}
 
@@ -409,7 +409,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
 				BT_IO_OPT_INVALID);
 	if (!port->io) {
 		error("%s", gerr->message);
-		reply = failed(port->msg, gerr->message);
+		reply = btd_error_failed(port->msg, gerr->message);
 		g_error_free(gerr);
 		goto failed;
 	}
@@ -505,13 +505,11 @@ static DBusMessage *port_connect(DBusConnection *conn,
 
 	err = connect_port(port);
 	if (err < 0) {
-		DBusMessage *reply;
-
 		error("%s", strerror(-err));
 		g_dbus_remove_watch(conn, port->listener_id);
 		port->listener_id = 0;
-		reply = failed(msg, strerror(-err));
-		return reply;
+
+		return btd_error_failed(msg, strerror(-err));
 	}
 
 	return NULL;
diff --git a/serial/proxy.c b/serial/proxy.c
index c779c4e..20aea7d 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -553,11 +553,8 @@ static DBusMessage *proxy_enable(DBusConnection *conn,
 	err = enable_proxy(prx);
 	if (err == -EALREADY)
 		return failed(msg, "Already enabled");
-	else if (err == -ENOMEM)
-		return failed(msg, "Unable to allocate new service record");
 	else if (err < 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE "Failed",
-				"Proxy enable failed (%s)", strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 
 	return dbus_message_new_method_return(msg);
 }
@@ -1051,8 +1048,7 @@ static DBusMessage *create_proxy(DBusConnection *conn,
 	else if (err == -EALREADY)
 		return btd_error_already_exists(msg);
 	else if (err < 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE "Failed",
-				"Proxy creation failed (%s)", strerror(-err));
+		return btd_error_failed(msg, strerror(-err));
 
 	proxy->owner = g_strdup(dbus_message_get_sender(msg));
 	proxy->watch = g_dbus_add_disconnect_watch(conn, proxy->owner,
-- 
1.7.3.2

