Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] android/gatt: Simplify gatt_db_attribute_get_permissions()
Date: Thu, 13 Nov 2014 19:13:37 +0200
Message-Id: <1415898817-13154-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1584207.SFKaHYrozt@leonov>
References: <1584207.SFKaHYrozt@leonov>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Condition checks inside gatt_db_attribute_get_permissions() do not make
sense. Simplify function.
---
 android/gatt.c           | 11 +++++------
 src/shared/gatt-db.c     | 10 ++--------
 src/shared/gatt-db.h     |  3 +--
 src/shared/gatt-server.c | 20 ++++----------------
 4 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 086bb94..085b1e5 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4753,7 +4753,7 @@ static void read_requested_attributes(void *data, void *user_data)
 		return;
 	}
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	/*
 	 * Check if it is attribute we didn't declare permissions, like service
@@ -5992,8 +5992,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return;
 
-	if (!gatt_db_attribute_get_permissions(attrib, &permissions))
-		return;
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
@@ -6041,7 +6040,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return;
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
@@ -6109,7 +6108,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return ATT_ECODE_ATTR_NOT_FOUND;
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	error = check_device_permissions(dev, cmd[0], permissions);
 	if (error)
@@ -6165,7 +6164,7 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return ATT_ECODE_ATTR_NOT_FOUND;
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	error = check_device_permissions(dev, cmd[0], permissions);
 	if (error)
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index a39eec2..3c916f9 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -769,15 +769,9 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
 	return true;
 }
 
-bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
-							uint32_t *permissions)
+uint32_t gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib)
 {
-	if (!attrib || !permissions)
-		return false;
-
-	*permissions = attrib->permissions;
-
-	return true;
+	return attrib->permissions;
 }
 
 static void pending_read_result(struct pending_read *p, int err,
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 9c71814..03eebd4 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -103,8 +103,7 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
 						uint16_t *start_handle,
 						uint16_t *end_handle);
 
-bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
-							uint32_t *permissions);
+uint32_t gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib);
 
 typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
 						int err, const uint8_t *value,
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 2ca318a..dbcb89a 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -412,10 +412,7 @@ static void process_read_by_type(struct async_read_op *op)
 		goto done;
 	}
 
-	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
-		ecode = BT_ATT_ERROR_UNLIKELY;
-		goto error;
-	}
+	perm = gatt_db_attribute_get_permissions(attr);
 
 	/*
 	 * Check for the READ access permission. Encryption,
@@ -739,10 +736,7 @@ static void write_cb(uint8_t opcode, const void *pdu,
 				(opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd",
 				handle);
 
-	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
-		ecode = BT_ATT_ERROR_INVALID_HANDLE;
-		goto error;
-	}
+	perm = gatt_db_attribute_get_permissions(attr);
 
 	if (!(perm & BT_ATT_PERM_WRITE)) {
 		ecode = BT_ATT_ERROR_WRITE_NOT_PERMITTED;
@@ -863,10 +857,7 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 			opcode == BT_ATT_OP_READ_BLOB_REQ ? "Blob " : "",
 			handle);
 
-	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
-		ecode = BT_ATT_ERROR_INVALID_HANDLE;
-		goto error;
-	}
+	perm = gatt_db_attribute_get_permissions(attr);
 
 	if (perm && !(perm & BT_ATT_PERM_READ)) {
 		ecode = BT_ATT_ERROR_READ_NOT_PERMITTED;
@@ -980,10 +971,7 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	util_debug(server->debug_callback, server->debug_data,
 				"Prep Write Req - handle: 0x%04x", handle);
 
-	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
-		ecode = BT_ATT_ERROR_INVALID_HANDLE;
-		goto error;
-	}
+	perm = gatt_db_attribute_get_permissions(attr);
 
 	/*
 	 * TODO: The "Prepare Write" request requires security permission checks
-- 
2.1.0

