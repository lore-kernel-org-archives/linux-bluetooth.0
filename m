Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 06/11] Register the ATT connection callbacks
Date: Tue, 12 Jul 2011 17:28:36 -0300
Message-Id: <1310502521-462-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Registers the ATT connection and disconnection callbacks in the generic
attribute API. First commit to remove implicit L2CAP connection
establishment.
---
 attrib/client.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 482aff1..29cb34a 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -48,6 +48,7 @@
 
 #include "att.h"
 #include "gattrib.h"
+#include "attio.h"
 #include "gatt.h"
 #include "client.h"
 
@@ -66,6 +67,7 @@ struct gatt_service {
 	struct att_primary *prim;
 	DBusConnection *conn;
 	GAttrib *attrib;
+	guint attioid;
 	int psm;
 	char *path;
 	GSList *chars;
@@ -976,6 +978,20 @@ static GDBusMethodTable prim_methods[] = {
 	{ }
 };
 
+static void attio_connected(GAttrib *attrib, gpointer user_data)
+{
+	struct gatt_service *gatt = user_data;
+
+	gatt->attrib = attrib;
+}
+
+static void attio_disconnected(gpointer user_data)
+{
+	struct gatt_service *gatt = user_data;
+
+	gatt->attrib = NULL;
+}
+
 static struct gatt_service *primary_register(DBusConnection *conn,
 						struct btd_device *device,
 						struct att_primary *prim,
@@ -995,6 +1011,9 @@ static struct gatt_service *primary_register(DBusConnection *conn,
 	gatt->path = g_strdup_printf("%s/service%04x", device_path,
 								prim->start);
 
+	gatt->attioid = btd_device_add_attio_callback(device, attio_connected,
+						attio_disconnected, gatt);
+
 	g_dbus_register_interface(gatt->conn, gatt->path,
 					CHAR_INTERFACE, prim_methods,
 					NULL, NULL, gatt, NULL);
@@ -1020,6 +1039,7 @@ GSList *attrib_client_register(DBusConnection *connection,
 
 		services = g_slist_append(services, g_strdup(gatt->path));
 		gatt_services = g_slist_append(gatt_services, gatt);
+
 	}
 
 	return services;
@@ -1029,6 +1049,8 @@ static void primary_unregister(struct gatt_service *gatt)
 {
 	GSList *l;
 
+	btd_device_remove_attio_callback(gatt->dev, gatt->attioid);
+
 	for (l = gatt->chars; l; l = l->next) {
 		struct characteristic *chr = l->data;
 		g_dbus_unregister_interface(gatt->conn, chr->path,
-- 
1.7.6

