Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Simplify gatt_db_attribute_get_permissions()
Date: Fri, 19 Dec 2014 12:18:29 +0200
Message-Id: <1418984309-29896-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1971447.3gPWfdfUJW@uw000953>
References: <1971447.3gPWfdfUJW@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Condition checks inside gatt_db_attribute_get_permissions() do not make
sense. Simplify function.
---
 android/gatt.c           | 10 +++++-----
 src/shared/gatt-db.c     | 10 ++--------
 src/shared/gatt-db.h     |  3 +--
 src/shared/gatt-server.c | 20 ++++----------------
 4 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 169f6db..6828f2f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4790,7 +4790,7 @@ static void read_requested_attributes(void *data, void *user_data)
 		return;
 	}
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	/*
 	 * Check if it is attribute we didn't declare permissions, like service
@@ -6311,7 +6311,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return;
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
@@ -6359,7 +6359,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return;
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
@@ -6430,7 +6430,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return ATT_ECODE_ATTR_NOT_FOUND;
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	error = check_device_permissions(dev, cmd[0], permissions);
 	if (error)
@@ -6486,7 +6486,7 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return ATT_ECODE_ATTR_NOT_FOUND;
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	error = check_device_permissions(dev, cmd[0], permissions);
 	if (error)
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index bb60904..4b91ae6 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1301,15 +1301,9 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
 	return true;
 }
 
-bool gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib,
-							uint32_t *permissions)
+uint32_t gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib)
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
index e5fe6bb..1379aae 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -171,8 +171,7 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
 							uint16_t *start_handle,
 							uint16_t *end_handle);
 
-bool gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib,
-							uint32_t *permissions);
+uint32_t gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib);
 
 typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
 						int err, const uint8_t *value,
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 00f36fd..f9e412d 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -389,10 +389,7 @@ static void process_read_by_type(struct async_read_op *op)
 		return;
 	}
 
-	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
-		ecode = BT_ATT_ERROR_UNLIKELY;
-		goto error;
-	}
+	perm = gatt_db_attribute_get_permissions(attr);
 
 	/*
 	 * Check for the READ access permission. Encryption,
@@ -697,10 +694,7 @@ static void write_cb(uint8_t opcode, const void *pdu,
 				(opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd",
 				handle);
 
-	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
-		ecode = BT_ATT_ERROR_INVALID_HANDLE;
-		goto error;
-	}
+	perm = gatt_db_attribute_get_permissions(attr);
 
 	if (!(perm & BT_ATT_PERM_WRITE)) {
 		ecode = BT_ATT_ERROR_WRITE_NOT_PERMITTED;
@@ -813,10 +807,7 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 			opcode == BT_ATT_OP_READ_BLOB_REQ ? "Blob " : "",
 			handle);
 
-	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
-		ecode = BT_ATT_ERROR_INVALID_HANDLE;
-		goto error;
-	}
+	perm = gatt_db_attribute_get_permissions(attr);
 
 	if (perm && !(perm & BT_ATT_PERM_READ)) {
 		ecode = BT_ATT_ERROR_READ_NOT_PERMITTED;
@@ -919,10 +910,7 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
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

