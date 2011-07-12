Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 02/11] Remove storing device path in gatt_service
Date: Tue, 12 Jul 2011 17:28:32 -0300
Message-Id: <1310502521-462-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 0d828c0..f7c78d3 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -56,7 +56,6 @@
 struct gatt_service {
 	struct btd_device *dev;
 	DBusConnection *conn;
-	char *path;
 	GSList *primary;
 	GAttrib *attrib;
 	DBusMessage *msg;
@@ -152,7 +151,6 @@ static void gatt_service_free(void *user_data)
 
 	g_slist_free_full(gatt->primary, primary_free);
 	g_attrib_unref(gatt->attrib);
-	g_free(gatt->path);
 	btd_device_unref(gatt->dev);
 	dbus_connection_unref(gatt->conn);
 	g_free(gatt);
@@ -1043,7 +1041,11 @@ static GDBusMethodTable prim_methods[] = {
 
 static GSList *register_primaries(struct gatt_service *gatt, GSList *primaries)
 {
+	struct btd_device *device = gatt->dev;
 	GSList *l, *paths;
+	const char *device_path;
+
+	device_path = device_get_path(device);
 
 	for (paths = NULL, l = primaries; l; l = l->next) {
 		struct att_primary *att = l->data;
@@ -1052,7 +1054,7 @@ static GSList *register_primaries(struct gatt_service *gatt, GSList *primaries)
 		prim = g_new0(struct primary, 1);
 		prim->att = att;
 		prim->gatt = gatt;
-		prim->path = g_strdup_printf("%s/service%04x", gatt->path,
+		prim->path = g_strdup_printf("%s/service%04x", device_path,
 								att->start);
 
 		g_dbus_register_interface(gatt->conn, prim->path,
@@ -1072,14 +1074,12 @@ GSList *attrib_client_register(DBusConnection *connection,
 					struct btd_device *device, int psm,
 					GAttrib *attrib, GSList *primaries)
 {
-	const char *path = device_get_path(device);
 	struct gatt_service *gatt;
 
 	gatt = g_new0(struct gatt_service, 1);
 	gatt->dev = btd_device_ref(device);
 	gatt->conn = dbus_connection_ref(connection);
 	gatt->listen = FALSE;
-	gatt->path = g_strdup(path);
 	gatt->psm = psm;
 
 	if (attrib)
-- 
1.7.6

