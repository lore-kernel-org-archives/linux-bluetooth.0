Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/2] android/gatt: Refactor gatt_db_attribute_get_permissions()
Date: Tue, 13 Jan 2015 12:09:19 +0200
Message-Id: <1421143759-32586-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1421143759-32586-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <2133713.7aeGTCSDGs@uw000953>
 <1421143759-32586-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Refactoring makes code cleaner and consistent with other code like
function gatt_db_attribute_get_handle(), etc. Also removes compile
warnings related to unneeded checks like check for !permissions and
warnings related to dead check for construction below:
(!gatt_db_attribute_get_permissions(attr, &perm)
those checks are useless since attr is always checked before and check
for &perm is really stupid.
---
 android/gatt.c           | 10 +++++-----
 src/shared/gatt-db.c     | 11 ++++-------
 src/shared/gatt-db.h     |  3 +--
 src/shared/gatt-server.c | 20 ++++----------------
 4 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8542f45..1d65c2a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4817,7 +4817,7 @@ static void read_requested_attributes(void *data, void *user_data)
 		return;
 	}
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	/*
 	 * Check if it is attribute we didn't declare permissions, like service
@@ -6355,7 +6355,7 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return;
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
@@ -6403,7 +6403,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return;
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
@@ -6474,7 +6474,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return ATT_ECODE_ATTR_NOT_FOUND;
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	error = check_device_permissions(dev, cmd[0], permissions);
 	if (error)
@@ -6530,7 +6530,7 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (!attrib)
 		return ATT_ECODE_ATTR_NOT_FOUND;
 
-	gatt_db_attribute_get_permissions(attrib, &permissions);
+	permissions = gatt_db_attribute_get_permissions(attrib);
 
 	error = check_device_permissions(dev, cmd[0], permissions);
 	if (error)
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 9a9cadc..2b997f1 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1345,15 +1345,12 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
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
+	if (!attrib)
+		return 0;
 
-	return true;
+	return attrib->permissions;
 }
 
 static void pending_read_result(struct pending_read *p, int err,
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 1f4005e..169108a 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -181,8 +181,7 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
 							uint16_t *start_handle,
 							uint16_t *end_handle);
 
-bool gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib,
-							uint32_t *permissions);
+uint32_t gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib);
 
 typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
 						int err, const uint8_t *value,
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index ed1b274..f12ac47 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -391,10 +391,7 @@ static void process_read_by_type(struct async_read_op *op)
 		return;
 	}
 
-	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
-		ecode = BT_ATT_ERROR_UNLIKELY;
-		goto error;
-	}
+	perm = gatt_db_attribute_get_permissions(attr);
 
 	/*
 	 * Check for the READ access permission. Encryption,
@@ -791,10 +788,7 @@ static void write_cb(uint8_t opcode, const void *pdu,
 				(opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd",
 				handle);
 
-	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
-		ecode = BT_ATT_ERROR_INVALID_HANDLE;
-		goto error;
-	}
+	perm = gatt_db_attribute_get_permissions(attr);
 
 	if (!(perm & BT_ATT_PERM_WRITE)) {
 		ecode = BT_ATT_ERROR_WRITE_NOT_PERMITTED;
@@ -907,10 +901,7 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 			opcode == BT_ATT_OP_READ_BLOB_REQ ? "Blob " : "",
 			handle);
 
-	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
-		ecode = BT_ATT_ERROR_INVALID_HANDLE;
-		goto error;
-	}
+	perm = gatt_db_attribute_get_permissions(attr);
 
 	if (perm && !(perm & BT_ATT_PERM_READ)) {
 		ecode = BT_ATT_ERROR_READ_NOT_PERMITTED;
@@ -1013,10 +1004,7 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
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

