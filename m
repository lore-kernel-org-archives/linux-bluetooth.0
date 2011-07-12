Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 04/11] Cleanup of primary service registration
Date: Tue, 12 Jul 2011 17:28:34 -0300
Message-Id: <1310502521-462-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |   47 ++++++++++++++++++++++++-----------------------
 1 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 93d0da7..98e25c7 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -1032,35 +1032,28 @@ static GDBusMethodTable prim_methods[] = {
 	{ }
 };
 
-static GSList *register_primaries(struct gatt_service *gatt, GSList *primaries)
+static struct primary *primary_register(struct gatt_service *gatt,
+						struct att_primary *prim)
 {
 	struct btd_device *device = gatt->dev;
-	GSList *l, *paths;
 	const char *device_path;
+	struct primary *data;
 
 	device_path = device_get_path(device);
 
-	for (paths = NULL, l = primaries; l; l = l->next) {
-		struct att_primary *att = l->data;
-		struct primary *prim;
+	data = g_new0(struct primary, 1);
+	data->att = prim;
+	data->gatt = gatt;
+	data->path = g_strdup_printf("%s/service%04x", device_path,
+								prim->start);
 
-		prim = g_new0(struct primary, 1);
-		prim->att = att;
-		prim->gatt = gatt;
-		prim->path = g_strdup_printf("%s/service%04x", device_path,
-								att->start);
+	g_dbus_register_interface(gatt->conn, data->path,
+					CHAR_INTERFACE, prim_methods,
+					NULL, NULL, data, NULL);
 
-		g_dbus_register_interface(gatt->conn, prim->path,
-				CHAR_INTERFACE, prim_methods,
-				NULL, NULL, prim, NULL);
-		DBG("Registered: %s", prim->path);
+	load_characteristics(data, gatt);
 
-		gatt->primary = g_slist_append(gatt->primary, prim);
-		paths = g_slist_append(paths, g_strdup(prim->path));
-		load_characteristics(prim, gatt);
-	}
-
-	return paths;
+	return data;
 }
 
 GSList *attrib_client_register(DBusConnection *connection,
@@ -1068,6 +1061,7 @@ GSList *attrib_client_register(DBusConnection *connection,
 					GAttrib *attrib, GSList *primaries)
 {
 	struct gatt_service *gatt;
+	GSList *l;
 
 	gatt = g_new0(struct gatt_service, 1);
 	gatt->dev = btd_device_ref(device);
@@ -1075,12 +1069,19 @@ GSList *attrib_client_register(DBusConnection *connection,
 	gatt->listen = FALSE;
 	gatt->psm = psm;
 
-	if (attrib)
-		gatt->attrib = g_attrib_ref(attrib);
+	for (l = primaries; l; l = l->next) {
+		struct att_primary *prim = l->data;
+		struct primary *data;
+
+		data = primary_register(gatt, prim);
+		gatt->primary = g_slist_append(gatt->primary, data);
+
+		DBG("Registered: %s", data->path);
+	}
 
 	gatt_services = g_slist_append(gatt_services, gatt);
 
-	return register_primaries(gatt, primaries);
+	return gatt_services;
 }
 
 void attrib_client_unregister(struct btd_device *device)
-- 
1.7.6

