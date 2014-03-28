Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 5/5] tools: Add emitting descriptor PropertiesChanged
Date: Fri, 28 Mar 2014 11:19:10 -0300
Message-Id: <1396016350-16943-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch forces emitting PropertiesChanged signal when the descriptor
Value changes. Internally, BlueZ tracks the signal emitted to update
the GDBusProxy properties.
---
 tools/gatt-service.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index c304b60..c4c358c 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -63,6 +63,7 @@ struct characteristic {
 
 struct descriptor {
 	char *uuid;
+	char *path;
 	uint8_t *value;
 	int vlen;
 };
@@ -125,6 +126,10 @@ static void desc_set_value(const GDBusPropertyTable *property,
 	desc->vlen = vlen;
 
 	g_dbus_pending_property_success(id);
+
+	g_dbus_emit_property_changed(connection, desc->path,
+					GATT_DESCRIPTOR_IFACE, "Value");
+
 }
 
 static const GDBusPropertyTable desc_properties[] = {
@@ -274,6 +279,7 @@ static void desc_iface_destroy(gpointer user_data)
 
 	g_free(desc->uuid);
 	g_free(desc->value);
+	g_free(desc->path);
 	g_free(desc);
 }
 
@@ -309,10 +315,12 @@ static gboolean register_characteristic(const char *chr_uuid,
 	if (!desc_uuid)
 		return ret;
 
+	desc_path = g_strdup_printf("%s/descriptor%d", chr_path, id++);
+
 	desc = g_new0(struct descriptor, 1);
 	desc->uuid = g_strdup(desc_uuid);
+	desc->path = desc_path;
 
-	desc_path = g_strdup_printf("%s/descriptor%d", chr_path, id++);
 	if (!g_dbus_register_interface(connection, desc_path,
 					GATT_DESCRIPTOR_IFACE,
 					NULL, NULL, desc_properties,
@@ -320,7 +328,6 @@ static gboolean register_characteristic(const char *chr_uuid,
 		printf("Couldn't register descriptor interface\n");
 		g_dbus_unregister_interface(connection, chr_path,
 							GATT_CHR_IFACE);
-		g_free(desc_path);
 		desc_iface_destroy(desc);
 
 		ret = FALSE;
-- 
1.8.3.1

