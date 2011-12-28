Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/8] attrib-server: Add bluetooth adapter in attrib_db_update function
Date: Wed, 28 Dec 2011 11:24:46 +0100
Message-Id: <1325067890-6953-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1325067890-6953-4-git-send-email-sancane@gmail.com>
References: <1325067890-6953-1-git-send-email-sancane@gmail.com>
 <1325067890-6953-2-git-send-email-sancane@gmail.com>
 <1325067890-6953-3-git-send-email-sancane@gmail.com>
 <1325067890-6953-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/gatt-example.c |    3 ++-
 src/attrib-server.c    |   17 ++++++++++-------
 src/attrib-server.h    |    3 ++-
 time/server.c          |    6 ++++--
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 27d3d13..332c190 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -97,7 +97,8 @@ static uint8_t battery_state_read(struct attribute *a, gpointer user_data)
 	uint8_t value;
 
 	value = 0x04;
-	attrib_db_update(a->handle, NULL, &value, sizeof(value), NULL);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_update(NULL, a->handle, NULL, &value, sizeof(value), NULL);
 
 	return 0;
 }
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 0ddcf49..486dd83 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -844,7 +844,8 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 
 	if (bt_uuid_cmp(&ccc_uuid, &a->uuid) != 0) {
 
-		attrib_db_update(handle, NULL, value, vlen, NULL);
+		attrib_db_update(channel->server->adapter, handle, NULL,
+							value, vlen, NULL);
 
 		if (a->write_cb) {
 			status = a->write_cb(a, a->cb_user_data);
@@ -1330,7 +1331,8 @@ struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
 								value, len);
 }
 
-int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
+int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
+					bt_uuid_t *uuid, const uint8_t *value,
 					int len, struct attribute **attr)
 {
 	struct gatt_server *server;
@@ -1338,12 +1340,12 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 	GSList *l;
 	guint h = handle;
 
-	DBG("Deprecated function!");
-
-	server = get_default_gatt_server();
-	if (server == NULL)
+	l = g_slist_find_custom(servers, adapter, adapter_cmp);
+	if (l == NULL)
 		return -ENOENT;
 
+	server = l->data;
+
 	DBG("handle=0x%04x", handle);
 
 	l = g_slist_find_custom(server->database, GUINT_TO_POINTER(h),
@@ -1416,5 +1418,6 @@ int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
 		return -ENOSYS;
 	}
 
-	return attrib_db_update(handle, NULL, value, len, NULL);
+	/* FIXME: Provide the adapter in next function */
+	return attrib_db_update(NULL, handle, NULL, value, len, NULL);
 }
diff --git a/src/attrib-server.h b/src/attrib-server.h
index ac1c388..1265bd1 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -26,7 +26,8 @@ uint16_t attrib_db_find_avail(struct btd_adapter *adapter, uint16_t nitems);
 struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
 				bt_uuid_t *uuid, int read_reqs, int write_reqs,
 				const uint8_t *value, int len);
-int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
+int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
+					bt_uuid_t *uuid, const uint8_t *value,
 					int len, struct attribute **attr);
 int attrib_db_del(uint16_t handle);
 int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len);
diff --git a/time/server.c b/time/server.c
index 839b33a..4ed9cf2 100644
--- a/time/server.c
+++ b/time/server.c
@@ -85,7 +85,8 @@ static uint8_t current_time_read(struct attribute *a, gpointer user_data)
 	if (encode_current_time(value) < 0)
 		return ATT_ECODE_IO;
 
-	attrib_db_update(a->handle, NULL, value, sizeof(value), NULL);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_update(NULL, a->handle, NULL, value, sizeof(value), NULL);
 
 	return 0;
 }
@@ -106,7 +107,8 @@ static uint8_t local_time_info_read(struct attribute *a, gpointer user_data)
 	 * format (offset from UTC in number of 15 minutes increments). */
 	value[1] = (uint8_t) (-1 * timezone / (60 * 15));
 
-	attrib_db_update(a->handle, NULL, value, sizeof(value), NULL);
+	/* FIXME: Provide the adapter in next function */
+	attrib_db_update(NULL, a->handle, NULL, value, sizeof(value), NULL);
 
 	return 0;
 }
-- 
1.7.8.1

