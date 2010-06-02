Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 24/32] Disconnect health link petition
Date: Wed,  2 Jun 2010 15:19:20 +0200
Message-Id: <1275484768-25838-25-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1275484768-25838-24-git-send-email-santoscadenas@gmail.com>
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
 <1275484768-25838-15-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-16-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-17-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-18-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-19-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-20-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-21-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-22-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-23-git-send-email-santoscadenas@gmail.com>
 <1275484768-25838-24-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/hdp.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/health/hdp.c b/health/hdp.c
index 25a644c..a38cbe0 100644
--- a/health/hdp.c
+++ b/health/hdp.c
@@ -401,13 +401,10 @@ static void health_link_free(struct hdp_link *hdpl)
 	if (hdpl->mcl) {
 		mcap_close_mcl(hdpl->mcl, FALSE);
 		mcap_mcl_unref(hdpl->mcl);
-		hdpl->mcl = NULL;
 	}
 
-	if (hdpl->path) {
+	if (hdpl->path)
 		g_free(hdpl->path);
-		hdpl->path = NULL;
-	}
 
 	hdpl->hdpi->hlink = g_slist_remove(hdpl->hdpi->hlink, hdpl);
 	g_free(hdpl);
@@ -623,32 +620,37 @@ static DBusMessage *hdp_disconnect(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct hdp_device *device = user_data;
-	struct hdp_link *hlink;
+	struct hdp_link *hdpl;
 	const char *path;
-	const gboolean *del;
+	gboolean cache;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-							DBUS_TYPE_BOOLEAN, &del,
-							DBUS_TYPE_INVALID)){
+						DBUS_TYPE_BOOLEAN, &cache,
+						DBUS_TYPE_INVALID)){
 		return g_dbus_create_error(msg,
 					ERROR_INTERFACE ".InvalidArguments",
 					"Invalid arguments in method call");
 	}
 
-	hlink = find_health_link(device->hdp_adapter, path);
-	if (!hlink)
+	hdpl = find_health_link(device->hdp_adapter, path);
+	if (!hdpl)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
 						"Health link does not found");
 
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".HealthError",
-							"Not yet implemented");
+	if (cache) {
+		mcap_close_mcl(hdpl->mcl, cache);
+		hdpl->closed = TRUE;
+	} else
+		g_dbus_unregister_interface(conn, hdpl->path, HEALTH_LINK);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
 static GDBusMethodTable device_methods[] = {
 	{ "GetHealthInstances", "", "aa{sv}", get_health_instances,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Connect", "uu", "o", hdp_connect, G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Diconnect", "ob", "", hdp_disconnect },
+	{ "Disconnect", "ob", "", hdp_disconnect },
 	{ NULL }
 };
 
-- 
1.6.3.3

