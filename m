Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/6] android/gatt: Store proper attributes permissions in database
Date: Mon, 26 May 2014 11:10:27 +0200
Message-Id: <1401095429-28432-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401095429-28432-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401095429-28432-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Convert Android HAL permissions to GATT server permissions and store
them in database.
---
 android/gatt.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 70cd5fe..bfcbb62 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -57,6 +57,17 @@
 
 #define BASE_UUID16_OFFSET     12
 
+#define GATT_PERM_READ			0x00000001
+#define GATT_PERM_READ_ENCRYPTED	0x00000002
+#define GATT_PERM_READ_MITM		0x00000004
+#define GATT_PERM_READ_AUTHORIZATION	0x00000008
+#define GATT_PERM_WRITE			0x00000100
+#define GATT_PERM_WRITE_ENCRYPTED	0x00000200
+#define GATT_PERM_WRITE_MITM		0x00000400
+#define GATT_PERM_WRITE_AUTHORIZATION	0x00000800
+#define GATT_PERM_WRITE_SIGNED		0x00010000
+#define GATT_PERM_WRITE_SIGNED_MITM	0x00020000
+
 static const uint8_t BLUETOOTH_UUID[] = {
 	0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
 	0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
@@ -4013,6 +4024,40 @@ failed:
 								bdaddr);
 }
 
+static uint32_t android_to_gatt_permissions(int32_t hal_permissions)
+{
+	uint32_t permissions = 0;
+
+	if (hal_permissions & HAL_GATT_PERMISSION_READ)
+		permissions |= GATT_PERM_READ;
+
+	if (hal_permissions & HAL_GATT_PERMISSION_READ_ENCRYPTED)
+		permissions |= GATT_PERM_READ_ENCRYPTED | GATT_PERM_READ;
+
+	if (hal_permissions & HAL_GATT_PERMISSION_READ_ENCRYPTED_MITM)
+		permissions |= GATT_PERM_READ_MITM | GATT_PERM_READ_ENCRYPTED |
+								GATT_PERM_READ;
+
+	if (hal_permissions & HAL_GATT_PERMISSION_WRITE)
+		permissions |= GATT_PERM_WRITE;
+
+	if (hal_permissions & HAL_GATT_PERMISSION_WRITE_ENCRYPTED)
+		permissions |= GATT_PERM_WRITE_ENCRYPTED | GATT_PERM_WRITE;
+
+	if (hal_permissions & HAL_GATT_PERMISSION_WRITE_ENCRYPTED_MITM)
+		permissions |= GATT_PERM_WRITE_MITM |
+				GATT_PERM_WRITE_ENCRYPTED | GATT_PERM_WRITE;
+
+	if (hal_permissions & HAL_GATT_PERMISSION_WRITE_SIGNED)
+		permissions |= GATT_PERM_WRITE_SIGNED;
+
+	if (hal_permissions & HAL_GATT_PERMISSION_WRITE_SIGNED_MITM)
+		permissions |= GATT_PERM_WRITE_SIGNED_MITM |
+							GATT_PERM_WRITE_SIGNED;
+
+	return permissions;
+}
+
 static void handle_server_add_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_characteristic *cmd = buf;
@@ -4020,6 +4065,7 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 	struct gatt_app *server;
 	bt_uuid_t uuid;
 	uint8_t status;
+	uint32_t permissions;
 	int32_t app_id = cmd->server_if;
 
 	DBG("");
@@ -4033,11 +4079,11 @@ static void handle_server_add_characteristic(const void *buf, uint16_t len)
 	}
 
 	android2uuid(cmd->uuid, &uuid);
+	permissions = android_to_gatt_permissions(cmd->permissions);
 
-	/*FIXME: Handle properties. Register callback if needed. */
 	ev.char_handle = gatt_db_add_characteristic(gatt_db,
 							cmd->service_handle,
-							&uuid, cmd->permissions,
+							&uuid, permissions,
 							cmd->properties,
 							read_cb, write_cb,
 							INT_TO_PTR(app_id));
@@ -4067,6 +4113,7 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
 	struct gatt_app *server;
 	bt_uuid_t uuid;
 	uint8_t status;
+	uint32_t permissions;
 	int32_t app_id = cmd->server_if;
 
 	DBG("");
@@ -4080,11 +4127,11 @@ static void handle_server_add_descriptor(const void *buf, uint16_t len)
 	}
 
 	android2uuid(cmd->uuid, &uuid);
+	permissions = android_to_gatt_permissions(cmd->permissions);
 
-	/*FIXME: Handle properties. Register callback if needed. */
 	ev.descr_handle = gatt_db_add_char_descriptor(gatt_db,
 							cmd->service_handle,
-							&uuid, cmd->permissions,
+							&uuid, permissions,
 							read_cb, write_cb,
 							INT_TO_PTR(app_id));
 	if (!ev.descr_handle)
-- 
1.9.0

