Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Add read callback support to attribute server
Date: Fri, 28 Jan 2011 12:26:12 -0400
Message-Id: <1296231972-6070-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This callback will allow profiles to act before an attribute is read,
to e.g. update the attribute value from an external source.

Note that by the time the callback is called, the necessary security
checks (attribute permissions, authentication and encryption) were
already performed by the core attribute server.

The callback can optionally return an ATT status code, which will be
sent to the client.
---
 attrib/att.h        |    5 +++++
 src/attrib-server.c |   13 ++++++++++---
 src/attrib-server.h |    4 ++--
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 1caa62a..448c66b 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -118,11 +118,16 @@ enum {
 	ATT_NOT_PERMITTED,	/* Operation not permitted */
 };
 
+struct attribute;
+
+typedef uint8_t (*att_read_cb_t)(struct attribute *);
+
 struct attribute {
 	uint16_t handle;
 	uuid_t uuid;
 	int read_reqs;
 	int write_reqs;
+	att_read_cb_t read_cb;
 	int len;
 	uint8_t data[0];
 };
diff --git a/src/attrib-server.c b/src/attrib-server.c
index f03a5b9..b8264e2 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -543,6 +543,13 @@ static uint16_t read_value(struct gatt_channel *channel, uint16_t handle,
 		return enc_error_resp(ATT_OP_READ_REQ, handle, status, pdu,
 									len);
 
+	if (a->read_cb) {
+		status = a->read_cb(a);
+		if (status)
+			return enc_error_resp(ATT_OP_READ_REQ, handle, status,
+								pdu, len);
+	}
+
 	return enc_read_resp(a->data, a->len, pdu, len);
 }
 
@@ -918,8 +925,8 @@ void attrib_server_exit(void)
 		remove_record_from_server(sdp_handle);
 }
 
-int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
-						const uint8_t *value, int len)
+struct attribute *attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs,
+				int write_reqs, const uint8_t *value, int len)
 {
 	struct attribute *a;
 
@@ -935,7 +942,7 @@ int attrib_db_add(uint16_t handle, uuid_t *uuid, int read_reqs, int write_reqs,
 
 	database = g_slist_insert_sorted(database, a, attribute_cmp);
 
-	return 0;
+	return a;
 }
 
 int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
diff --git a/src/attrib-server.h b/src/attrib-server.h
index ba90ff4..6caea64 100644
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

