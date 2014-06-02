Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFCv2 1/2] shared/gatt-db: Add databse dump
Date: Mon,  2 Jun 2014 15:19:30 +0200
Message-Id: <1401715171-29175-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401715171-29175-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401715171-29175-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is usefull to execute and verify PTS test cases, and will be called
from haltest using gatt client 'test_command'.
---
 src/shared/gatt-db.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index c11c5d1..7405998 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -761,3 +761,55 @@ bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
 	return true;
 
 }
+
+static void dump_data(const char *str, void *user_data)
+{
+	if (user_data)
+		printf("%s%s", (char *) user_data, str);
+	else
+		printf("%s", str);
+}
+
+static void dump_attribute(struct gatt_db_attribute *attr)
+{
+	char uuidstr[MAX_LEN_UUID_STR + 1];
+
+	if (!attr) {
+		util_debug(dump_data, NULL, " <empty>\n");
+		return;
+	}
+
+	bt_uuid_to_string(&attr->uuid, uuidstr, sizeof(uuidstr));
+	util_debug(dump_data, NULL,
+			"attr_hnd: %.5d, uuid: %s, perm: %.7d, val_len: %.5d, ",
+			attr->handle, uuidstr, attr->permissions,
+			attr->value_len);
+
+	if (attr->value_len) {
+		util_hexdump(':', attr->value, attr->value_len, dump_data,
+								"attr_value");
+	} else {
+		util_debug(dump_data, "attr_value:",
+					attr->read_func ? " <read_cb>" : "");
+		util_debug(dump_data, NULL,
+					attr->write_func ? " <write_cb>" : "");
+	}
+
+	util_debug(dump_data, NULL, "\n");
+}
+
+static void dump_service(void *data, void *user_data)
+{
+	struct gatt_db_service *srvc = data;
+	int i;
+
+	for (i = 0; i < srvc->num_handles; i++)
+		dump_attribute(srvc->attributes[i]);
+}
+
+void gatt_db_dump(struct gatt_db *db)
+{
+	util_debug(dump_data, NULL, "[ att database dump start ]\n");
+	queue_foreach(db->services, dump_service, NULL);
+	util_debug(dump_data, NULL, "[ att database dump end ]\n");
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index a88f637..dad8b11 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -94,3 +94,4 @@ uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
 
 bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
 							uint32_t *permissions);
+void gatt_db_dump(struct gatt_db *db);
-- 
2.0.0

