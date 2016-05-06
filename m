Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] doc/gatt-api: Add secure flags
Date: Fri,  6 May 2016 22:11:01 +0300
Message-Id: <1462561862-500-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1462561862-500-1-git-send-email-luiz.dentz@gmail.com>
References: <1462561862-500-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add secure-{read,write} which shall be used by servers that want
to restrict attribute access to secure connection only (BT_SECURITY_FIPS)
---
 doc/gatt-api.txt         |  4 +++
 lib/bluetooth.h          |  1 +
 src/gatt-database.c      | 90 ++++++++++++++++++++----------------------------
 src/shared/att-types.h   |  5 +++
 src/shared/gatt-server.c |  3 ++
 5 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 9404986..cb4e196 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -150,6 +150,8 @@ Properties	string UUID [read-only]
 				"encrypt-write"
 				"encrypt-authenticated-read"
 				"encrypt-authenticated-write"
+				"secure-read" (Server only)
+				"secure-write" (Server only)
 
 Characteristic Descriptors hierarchy
 ====================================
@@ -217,6 +219,8 @@ Properties	string UUID [read-only]
 				"encrypt-write"
 				"encrypt-authenticated-read"
 				"encrypt-authenticated-write"
+				"secure-read" (Server Only)
+				"secure-write" (Server Only)
 
 GATT Profile hierarcy
 =====================
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 852a6b2..eb27926 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -69,6 +69,7 @@ struct bt_security {
 #define BT_SECURITY_LOW		1
 #define BT_SECURITY_MEDIUM	2
 #define BT_SECURITY_HIGH	3
+#define BT_SECURITY_FIPS	4
 
 #define BT_DEFER_SETUP	7
 
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 594972a..627a416 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -116,6 +116,7 @@ struct external_chrc {
 	GDBusProxy *proxy;
 	uint8_t props;
 	uint8_t ext_props;
+	uint32_t perm;
 	struct gatt_db_attribute *attrib;
 	struct gatt_db_attribute *ccc;
 	struct queue *pending_reads;
@@ -1113,7 +1114,7 @@ static bool incr_attr_count(struct external_service *service, uint16_t incr)
 }
 
 static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
-							uint8_t *ext_props)
+					uint8_t *ext_props, uint32_t *perm)
 {
 	const char *flag;
 
@@ -1127,34 +1128,51 @@ static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
 
 		if (!strcmp("broadcast", flag))
 			*props |= BT_GATT_CHRC_PROP_BROADCAST;
-		else if (!strcmp("read", flag))
+		else if (!strcmp("read", flag)) {
 			*props |= BT_GATT_CHRC_PROP_READ;
-		else if (!strcmp("write-without-response", flag))
+			*perm |= BT_ATT_PERM_READ;
+		} else if (!strcmp("write-without-response", flag)) {
 			*props |= BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP;
-		else if (!strcmp("write", flag))
+			*perm |= BT_ATT_PERM_WRITE;
+		} else if (!strcmp("write", flag)) {
 			*props |= BT_GATT_CHRC_PROP_WRITE;
-		else if (!strcmp("notify", flag))
+			*perm |= BT_ATT_PERM_WRITE;
+		} else if (!strcmp("notify", flag)) {
 			*props |= BT_GATT_CHRC_PROP_NOTIFY;
-		else if (!strcmp("indicate", flag))
+		} else if (!strcmp("indicate", flag)) {
 			*props |= BT_GATT_CHRC_PROP_INDICATE;
-		else if (!strcmp("authenticated-signed-writes", flag))
+		} else if (!strcmp("authenticated-signed-writes", flag)) {
 			*props |= BT_GATT_CHRC_PROP_AUTH;
-		else if (!strcmp("reliable-write", flag))
+			*perm |= BT_ATT_PERM_WRITE;
+		} else if (!strcmp("reliable-write", flag)) {
 			*ext_props |= BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE;
-		else if (!strcmp("writable-auxiliaries", flag))
+			*perm |= BT_ATT_PERM_WRITE;
+		} else if (!strcmp("writable-auxiliaries", flag)) {
 			*ext_props |= BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX;
-		else if (!strcmp("encrypt-read", flag)) {
+		} else if (!strcmp("encrypt-read", flag)) {
 			*props |= BT_GATT_CHRC_PROP_READ;
 			*ext_props |= BT_GATT_CHRC_EXT_PROP_ENC_READ;
+			*perm |= BT_ATT_PERM_READ | BT_ATT_PERM_READ_ENCRYPT;
 		} else if (!strcmp("encrypt-write", flag)) {
 			*props |= BT_GATT_CHRC_PROP_WRITE;
 			*ext_props |= BT_GATT_CHRC_EXT_PROP_ENC_WRITE;
+			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_ENCRYPT;
 		} else if (!strcmp("encrypt-authenticated-read", flag)) {
 			*props |= BT_GATT_CHRC_PROP_READ;
 			*ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_READ;
+			*perm |= BT_ATT_PERM_READ | BT_ATT_PERM_READ_AUTHEN;
 		} else if (!strcmp("encrypt-authenticated-write", flag)) {
 			*props |= BT_GATT_CHRC_PROP_WRITE;
 			*ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_WRITE;
+			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_AUTHEN;
+		} else if (!strcmp("secure-read", flag)) {
+			*props |= BT_GATT_CHRC_PROP_READ;
+			*ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_READ;
+			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_READ_SECURE;
+		} else if (!strcmp("secure-write", flag)) {
+			*props |= BT_GATT_CHRC_PROP_WRITE;
+			*ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_WRITE;
+			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_SECURE;
 		} else {
 			error("Invalid characteristic flag: %s", flag);
 			return false;
@@ -1191,6 +1209,10 @@ static bool parse_desc_flags(DBusMessageIter *array, uint32_t *perm)
 			*perm |= BT_ATT_PERM_READ | BT_ATT_PERM_READ_AUTHEN;
 		else if (!strcmp("encrypt-authenticated-write", flag))
 			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_AUTHEN;
+		else if (!strcmp("secure-read", flag))
+			*perm |= BT_ATT_PERM_READ | BT_ATT_PERM_READ_AUTHEN;
+		else if (!strcmp("secure-write", flag))
+			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_AUTHEN;
 		else {
 			error("Invalid descriptor flag: %s", flag);
 			return false;
@@ -1204,6 +1226,7 @@ static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props,
 								uint32_t *perm)
 {
 	DBusMessageIter iter, array;
+	const char *iface;
 
 	if (!g_dbus_proxy_get_property(proxy, "Flags", &iter))
 		return false;
@@ -1213,10 +1236,11 @@ static bool parse_flags(GDBusProxy *proxy, uint8_t *props, uint8_t *ext_props,
 
 	dbus_message_iter_recurse(&iter, &array);
 
-	if (perm)
+	iface = g_dbus_proxy_get_interface(proxy);
+	if (!strcmp(iface, GATT_DESC_IFACE))
 		return parse_desc_flags(&array, perm);
 
-	return parse_chrc_flags(&array, props, ext_props);
+	return parse_chrc_flags(&array, props, ext_props, perm);
 }
 
 static struct external_chrc *chrc_create(struct gatt_app *app,
@@ -1264,7 +1288,7 @@ static struct external_chrc *chrc_create(struct gatt_app *app,
 	 * are used to determine if any special descriptors should be
 	 * created.
 	 */
-	if (!parse_flags(proxy, &chrc->props, &chrc->ext_props, NULL)) {
+	if (!parse_flags(proxy, &chrc->props, &chrc->ext_props, &chrc->perm)) {
 		error("Failed to parse characteristic properties");
 		goto fail;
 	}
@@ -1754,37 +1778,6 @@ static void send_write(struct btd_device *device,
 	gatt_db_attribute_write_result(attrib, id, ecode);
 }
 
-static uint32_t permissions_from_props(uint8_t props, uint8_t ext_props)
-{
-	uint32_t perm = 0;
-
-	if (props & BT_GATT_CHRC_PROP_WRITE ||
-			props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP ||
-			ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE ||
-			ext_props & BT_GATT_CHRC_EXT_PROP_ENC_WRITE ||
-			ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_WRITE)
-		perm |= BT_ATT_PERM_WRITE;
-
-	if (props & BT_GATT_CHRC_PROP_READ ||
-			ext_props & BT_GATT_CHRC_EXT_PROP_ENC_READ ||
-			ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_READ)
-		perm |= BT_ATT_PERM_READ;
-
-	if (ext_props & BT_GATT_CHRC_EXT_PROP_ENC_READ)
-		perm |= BT_ATT_PERM_READ_ENCRYPT;
-
-	if (ext_props & BT_GATT_CHRC_EXT_PROP_ENC_WRITE)
-		perm |= BT_ATT_PERM_WRITE_ENCRYPT;
-
-	if (ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_READ)
-		perm |= BT_ATT_PERM_READ_AUTHEN;
-
-	if (ext_props & BT_GATT_CHRC_EXT_PROP_AUTH_WRITE)
-		perm |= BT_ATT_PERM_WRITE_AUTHEN;
-
-	return perm;
-}
-
 static uint8_t ccc_write_cb(uint16_t value, void *user_data)
 {
 	struct external_chrc *chrc = user_data;
@@ -2086,7 +2079,6 @@ static bool database_add_chrc(struct external_service *service,
 						struct external_chrc *chrc)
 {
 	bt_uuid_t uuid;
-	uint32_t perm;
 	const struct queue_entry *entry;
 
 	if (!parse_uuid(chrc->proxy, &uuid)) {
@@ -2099,14 +2091,8 @@ static bool database_add_chrc(struct external_service *service,
 		return false;
 	}
 
-	/*
-	 * TODO: Once shared/gatt-server properly supports permission checks,
-	 * set the permissions based on a D-Bus property of the external
-	 * characteristic.
-	 */
-	perm = permissions_from_props(chrc->props, chrc->ext_props);
 	chrc->attrib = gatt_db_service_add_characteristic(service->attrib,
-						&uuid, perm,
+						&uuid, chrc->perm,
 						chrc->props, chrc_read_cb,
 						chrc_write_cb, chrc);
 	if (!chrc->attrib) {
diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index c3062c0..4a9b67f 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -31,6 +31,7 @@
 #define BT_ATT_SECURITY_LOW	1
 #define BT_ATT_SECURITY_MEDIUM	2
 #define BT_ATT_SECURITY_HIGH	3
+#define BT_ATT_SECURITY_FIPS	4
 
 #define BT_ATT_DEFAULT_LE_MTU	23
 #define BT_ATT_MAX_LE_MTU	517
@@ -123,6 +124,10 @@ struct bt_att_pdu_error_rsp {
 					BT_ATT_PERM_WRITE_AUTHEN)
 #define BT_ATT_PERM_AUTHOR		0x40
 #define BT_ATT_PERM_NONE		0x80
+#define BT_ATT_PERM_READ_SECURE		0x0100
+#define BT_ATT_PERM_WRITE_SECURE	0x0200
+#define BT_ATT_PERM_SECURE		(BT_ATT_PERM_READ_SECURE | \
+					BT_ATT_PERM_WRITE_SECURE)
 
 /* GATT Characteristic Properties Bitfield values */
 #define BT_GATT_CHRC_PROP_BROADCAST			0x01
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 123d9c1..79e01c8 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -398,6 +398,9 @@ static uint8_t check_permissions(struct bt_gatt_server *server,
 		return 0;
 
 	security = bt_att_get_security(server->att);
+	if (perm & BT_ATT_PERM_SECURE && security < BT_ATT_SECURITY_FIPS)
+		return BT_ATT_ERROR_AUTHENTICATION;
+
 	if (perm & BT_ATT_PERM_AUTHEN && security < BT_ATT_SECURITY_HIGH)
 		return BT_ATT_ERROR_AUTHENTICATION;
 
-- 
2.5.5

