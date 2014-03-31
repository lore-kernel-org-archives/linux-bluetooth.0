Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 3/3] tools: Add emitting descriptor PropertiesChanged
Date: Mon, 31 Mar 2014 09:13:15 -0300
Message-Id: <1396267995-17271-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396267995-17271-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
 <1396267995-17271-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch forces emitting PropertiesChanged signal when the descriptor
Value changes. Internally, BlueZ tracks the signal emitted to update
the GDBusProxy properties.
---
 tools/gatt-service.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index ee37ef3..6bca404 100644
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
 
@@ -286,8 +292,6 @@ static gboolean register_characteristic(const char *chr_uuid,
 	struct characteristic *chr;
 	struct descriptor *desc;
 	static int id = 1;
-	char *desc_path;
-	gboolean ret = TRUE;
 
 	chr = g_new0(struct characteristic, 1);
 	chr->uuid = g_strdup(chr_uuid);
@@ -309,9 +313,9 @@ static gboolean register_characteristic(const char *chr_uuid,
 
 	desc = g_new0(struct descriptor, 1);
 	desc->uuid = g_strdup(desc_uuid);
+	desc->path = g_strdup_printf("%s/descriptor%d", chr->path, id++);
 
-	desc_path = g_strdup_printf("%s/descriptor%d", chr->path, id++);
-	if (!g_dbus_register_interface(connection, desc_path,
+	if (!g_dbus_register_interface(connection, desc->path,
 					GATT_DESCRIPTOR_IFACE,
 					NULL, NULL, desc_properties,
 					desc, desc_iface_destroy)) {
@@ -320,12 +324,10 @@ static gboolean register_characteristic(const char *chr_uuid,
 							GATT_CHR_IFACE);
 
 		desc_iface_destroy(desc);
-		ret = FALSE;
+		return FALSE;
 	}
 
-	g_free(desc_path);
-
-	return ret;
+	return TRUE;
 }
 
 static char *register_service(const char *uuid)
-- 
1.8.3.1

