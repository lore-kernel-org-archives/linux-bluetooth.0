Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 14/32] Manage mcap instances
Date: Wed,  2 Jun 2010 15:19:10 +0200
Message-Id: <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
References: <1275484768-25838-1-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-2-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-3-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-4-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-5-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-6-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-7-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-8-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-9-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-10-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-11-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-12-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-13-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-14-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c      |   73 ++++++++++++++++++++++++++++++++++++++++------------
 health/hdp_util.c |    3 +-
 2 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index f5487c2..a15667b 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -457,6 +457,30 @@ static void client_disconnected(DBusConnection *connection, void *user_data)
 	hdp_instance_free(hdpi);
 }
 
+static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
+{
+	/* struct hdp_instance *hdpi = data; */
+	debug("TODO: implement mcl_connected");
+}
+
+static void mcl_reconnected(struct mcap_mcl *mcl, gpointer data)
+{
+	/* struct hdp_instance *hdpi = data; */
+	debug("TODO: implement mcl_reconnected");
+}
+
+static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
+{
+	/* struct hdp_instance *hdpi = data; */
+	debug("TODO: implement mcl_disconnected");
+}
+
+static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
+{
+	/* struct hdp_instance *hdpi = data; */
+	debug("TODO: implement mcl_uncached");
+}
+
 static DBusMessage *hdp_create_instance(DBusConnection *conn,
 				      DBusMessage *msg, void *user_data)
 {
@@ -472,17 +496,24 @@ static DBusMessage *hdp_create_instance(DBusConnection *conn,
 	dbus_message_iter_init(msg, &iter);
 	ctype = dbus_message_iter_get_arg_type(&iter);
 	if (ctype != DBUS_TYPE_OBJECT_PATH)
-		goto error;
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 	dbus_message_iter_get_basic(&iter, &path);
 	dbus_message_iter_next(&iter);
 	config = hdp_get_config(&iter, &err);
-	if (err)
-		goto error;
+	if (err) {
+		reply = g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments: %s", err->message);
+		g_error_free(err);
+		return reply;
+	}
 	name = dbus_message_get_sender(msg);
 	if (!name) {
-		g_set_error(&err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
-						"Can't get sender name");
-		goto error;
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Can't get sender name");
 	}
 
 	hdpi = g_new0(struct hdp_instance, 1);
@@ -494,7 +525,20 @@ static DBusMessage *hdp_create_instance(DBusConnection *conn,
 	hdpi->dbus_watcher = g_dbus_add_disconnect_watch(adapter->conn, name,
 					client_disconnected, hdpi, NULL);
 
-	/* TODO: Create mcap instance */
+	hdpi->mi = mcap_create_instance(adapter->btd_adapter, BT_IO_SEC_MEDIUM,
+					0, 0, &err, mcl_connected,
+					mcl_reconnected, mcl_disconnected,
+					mcl_uncached, hdpi);
+	if (err)
+		goto error;
+
+	hdpi->ccpsm = mcap_get_ctrl_psm(hdpi->mi, &err);
+	if (err)
+		goto error;
+
+	hdpi->dcpsm = mcap_get_data_psm(hdpi->mi, &err);
+	if (err)
+		goto error;
 
 	if (!hdp_register_sdp_record(hdpi)) {
 		hdp_instance_free(hdpi);
@@ -503,19 +547,14 @@ static DBusMessage *hdp_create_instance(DBusConnection *conn,
 	}
 
 	adapter->instances = g_slist_prepend(adapter->instances, hdpi);
-	info("HDP instance created with path %d", hdpi->id);
+	debug("HDP instance created with id %d", hdpi->id);
 	return g_dbus_create_reply(msg, DBUS_TYPE_UINT32, &hdpi->id,
 							DBUS_TYPE_INVALID);
 error:
-	if (err) {
-		reply = g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments: %s", err->message);
-		g_error_free(err);
-	} else
-		reply = g_dbus_create_error(msg,
-					ERROR_INTERFACE ".InvalidArguments",
-					"Invalid arguments in method call");
+	reply = g_dbus_create_error(msg,ERROR_INTERFACE ".HealthError",
+					err->message);
+	g_error_free(err);
+	hdp_instance_free(hdpi);
 	return reply;
 }
 
diff --git a/health/hdp_util.c b/health/hdp_util.c
index 844cd8c..5ba61dc 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -123,7 +123,8 @@ void hdp_instance_free(struct hdp_instance *hdpi)
 		g_dbus_remove_watch(hdpi->adapter->conn, hdpi->dbus_watcher);
 	if (hdpi->sdp_handler)
 		remove_record_from_server(hdpi->sdp_handler);
-	/* TODO: stop mcap instance */
+	if (hdpi->mi)
+		mcap_release_instance(hdpi->mi);
 	if (hdpi->apath)
 		g_free(hdpi->apath);
 	if (hdpi->aname)
-- 
1.6.3.3

