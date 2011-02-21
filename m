Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 1/5] Add read/write callbacks to attribute server
Date: Mon, 21 Feb 2011 18:30:39 -0300
Message-Id: <1298323843-31106-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These callbacks will allow profiles to act before an attribute is read
and after it is written, to e.g. update the attribute value to/from an
external source.

Note that by the time the callback is called, the necessary security
checks (attribute permissions, authentication and encryption) were
already performed by the core attribute server.

The callback can optionally return an ATT status code, which will be
sent to the client using an Error Response PDU.
---
 attrib/att.h        |    7 +++++++
 src/attrib-server.c |   29 ++++++++++++++++++++++++++---
 src/attrib-server.h |    4 ++--
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 7d9afeb..05ae606 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -118,11 +118,18 @@ enum {
 	ATT_NOT_PERMITTED,	/* Operation not permitted */
 };
 
+struct attribute;
+
+typedef uint8_t (*att_cb_t)(struct attribute *, gpointer);
+
 struct attribute {
 	uint16_t handle;
 	uuid_t uuid;
 	int read_reqs;
 	int write_reqs;
+	att_cb_t read_cb;
+	att_cb_t write_cb;
+	gpointer cb_user_data;
 	int len;
 	uint8_t data[0];
 };
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 7ec0f56..28649f1 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -229,6 +229,10 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 
 		status = att_check_reqs(channel, ATT_OP_READ_BY_GROUP_REQ,
 								a->read_reqs);
+
+		if (status == 0x00 && a->read_cb)
+			status = a->read_cb(a, a->cb_user_data);
+
 		if (status) {
 			g_slist_foreach(groups, (GFunc) g_free, NULL);
 			g_slist_free(groups);
@@ -317,6 +321,10 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 
 		status = att_check_reqs(channel, ATT_OP_READ_BY_TYPE_REQ,
 								a->read_reqs);
+
+		if (status == 0x00 && a->read_cb)
+			status = a->read_cb(a, a->cb_user_data);
+
 		if (status) {
 			g_slist_free(types);
 			return enc_error_resp(ATT_OP_READ_BY_TYPE_REQ,
@@ -564,6 +572,10 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 	a = l->data;
 
 	status = att_check_reqs(channel, ATT_OP_READ_REQ, a->read_reqs);
+
+	if (status == 0x00 && a->read_cb)
+		status = a->read_cb(a, a->cb_user_data);
+
 	if (status)
 		return enc_error_resp(ATT_OP_READ_REQ, handle, status, pdu,
 									len);
@@ -591,6 +603,10 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 					ATT_ECODE_INVALID_OFFSET, pdu, len);
 
 	status = att_check_reqs(channel, ATT_OP_READ_BLOB_REQ, a->read_reqs);
+
+	if (status == 0x00 && a->read_cb)
+		status = a->read_cb(a, a->cb_user_data);
+
 	if (status)
 		return enc_error_resp(ATT_OP_READ_BLOB_REQ, handle, status,
 								pdu, len);
@@ -623,6 +639,13 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 	memcpy(&uuid, &a->uuid, sizeof(uuid_t));
 	attrib_db_update(handle, &uuid, value, vlen);
 
+	if (a->write_cb) {
+		status = a->write_cb(a, a->cb_user_data);
+		if (status)
+			return enc_error_resp(ATT_OP_WRITE_REQ, handle, status,
+								pdu, len);
+	}
+
 	return enc_write_resp(pdu, len);
 }
 
@@ -1013,8 +1036,8 @@ void attrib_free_sdp(uint32_t sdp_handle)
 	remove_record_from_server(sdp_handle);
 }
 
-int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
-						const uint8_t *value, int len)
+struct attribute *attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs,
+				int write_reqs, const uint8_t *value, int len)
 {
 	struct attribute *a;
 
@@ -1030,7 +1053,7 @@ int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
 
 	database = g_slist_insert_sorted(database, a, attribute_cmp);
 
-	return 0;
+	return a;
 }
 
 int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
diff --git a/src/attrib-server.h b/src/attrib-server.h
index ecd695c..85f3bdb 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -25,8 +25,8 @@
 int attrib_server_init(void);
 void attrib_server_exit(void);
 
-int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
-						const uint8_t *value, int len);
+struct attribute *attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs,
+				int write_reqs, const uint8_t *value, int len);
 int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
 								int len);
 int attrib_db_del(uint16_t handle);
-- 
1.7.0.4

