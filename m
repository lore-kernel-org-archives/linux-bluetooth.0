Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] GATT: Fixed PTS issues for multiple write request
Date: Mon, 18 Aug 2014 11:41:09 +0530
Message-id: <1408342269-25170-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updates gatt attribute db using offset value. This fixes below
PTS TCs.

TP/GAW/SR/BV-06-C
TP/GAW/SR/BV-10-C
TP/GAW/SR/BI-14-C
TP/GAW/SR/BI-15-C
TP/GAW/SR/BV-05-C
TP/GAW/SR/BI-07-C
TP/GAW/SR/BI-08-C
TP/GAW/SR/BI-34-C
TP/GAW/SR/BI-25-C
TP/GAW/SR/BI-26-C
---
 plugins/gatt-example.c        |  2 +-
 profiles/alert/server.c       | 16 ++++++-------
 profiles/proximity/linkloss.c |  2 +-
 profiles/time/server.c        |  6 ++---
 src/attrib-server.c           | 53 +++++++++++++++++++++++++++++++++++--------
 src/attrib-server.h           |  2 +-
 6 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 6e20b1f..f6c0ba0 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -101,7 +101,7 @@ static uint8_t battery_state_read(struct attribute *a,
 	uint8_t value;
 
 	value = 0x04;
-	attrib_db_update(adapter, a->handle, NULL, &value, sizeof(value), NULL);
+	attrib_db_update(adapter, a->handle, NULL, &value, sizeof(value), NULL, 0);
 
 	return 0;
 }
diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 1612d6c..4004ddc 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -302,12 +302,12 @@ static void update_supported_categories(gpointer data, gpointer user_data)
 	}
 
 	attrib_db_update(adapter, al_adapter->supp_new_alert_cat_handle, NULL,
-						value, sizeof(value), NULL);
+						value, sizeof(value), NULL, 0);
 
 	/* FIXME: For now report all registered categories as supporting unread
 	 * status, until it is known which ones should be supported */
 	attrib_db_update(adapter, al_adapter->supp_unread_alert_cat_handle,
-					NULL, value, sizeof(value), NULL);
+					NULL, value, sizeof(value), NULL, 0);
 }
 
 static void watcher_disconnect(DBusConnection *conn, void *user_data)
@@ -522,7 +522,7 @@ static void update_new_alert(gpointer data, gpointer user_data)
 	uint8_t *value = user_data;
 
 	attrib_db_update(adapter, al_adapter->hnd_value[NOTIFY_NEW_ALERT], NULL,
-						&value[1], value[0], NULL);
+						&value[1], value[0], NULL, 0);
 
 	notify_devices(al_adapter, NOTIFY_NEW_ALERT, &value[1], value[0]);
 }
@@ -682,7 +682,7 @@ static void update_unread_alert(gpointer data, gpointer user_data)
 
 	attrib_db_update(adapter,
 			al_adapter->hnd_value[NOTIFY_UNREAD_ALERT], NULL, value,
-			2, NULL);
+			2, NULL, 0);
 
 	notify_devices(al_adapter, NOTIFY_UNREAD_ALERT, value, 2);
 }
@@ -776,7 +776,7 @@ static uint8_t alert_status_read(struct attribute *a,
 
 	if (a->data == NULL || a->data[0] != alert_status)
 		attrib_db_update(adapter, a->handle, NULL, &alert_status,
-						sizeof(alert_status), NULL);
+						sizeof(alert_status), NULL, 0);
 
 	return 0;
 }
@@ -791,7 +791,7 @@ static uint8_t ringer_setting_read(struct attribute *a,
 
 	if (a->data == NULL || a->data[0] != ringer_setting)
 		attrib_db_update(adapter, a->handle, NULL, &ringer_setting,
-						sizeof(ringer_setting), NULL);
+						sizeof(ringer_setting), NULL, 0);
 
 	return 0;
 }
@@ -843,7 +843,7 @@ static uint8_t supp_new_alert_cat_read(struct attribute *a,
 
 	if (a->data == NULL)
 		attrib_db_update(adapter, a->handle, NULL, value, sizeof(value),
-									NULL);
+									NULL, 0);
 
 	return 0;
 }
@@ -859,7 +859,7 @@ static uint8_t supp_unread_alert_cat_read(struct attribute *a,
 
 	if (a->data == NULL)
 		attrib_db_update(adapter, a->handle, NULL, value, sizeof(value),
-									NULL);
+									NULL, 0);
 
 	return 0;
 }
diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index 476803a..daf1156 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -165,7 +165,7 @@ out:
 
 	/* update the alert level according to the requesting device */
 	attrib_db_update(la->adapter, a->handle, NULL, &alert_level,
-						sizeof(alert_level), NULL);
+						sizeof(alert_level), NULL, 0);
 
 	return 0;
 }
diff --git a/profiles/time/server.c b/profiles/time/server.c
index 1716a5e..3a3ab2f 100644
--- a/profiles/time/server.c
+++ b/profiles/time/server.c
@@ -116,7 +116,7 @@ static uint8_t current_time_read(struct attribute *a,
 	if (encode_current_time(value) < 0)
 		return ATT_ECODE_IO;
 
-	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
+	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL, 0);
 
 	return 0;
 }
@@ -139,7 +139,7 @@ static uint8_t local_time_info_read(struct attribute *a,
 	 * is DST for the local time or not. The offset is unknown. */
 	value[1] = daylight ? 0xff : 0x00;
 
-	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
+	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL, 0);
 
 	return 0;
 }
@@ -202,7 +202,7 @@ static uint8_t time_update_status(struct attribute *a,
 
 	value[0] = UPDATE_STATE_IDLE;
 	value[1] = UPDATE_RESULT_SUCCESSFUL;
-	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL);
+	attrib_db_update(adapter, a->handle, NULL, value, sizeof(value), NULL, 0);
 
 	return 0;
 }
diff --git a/src/attrib-server.c b/src/attrib-server.c
index e65fff2..9e099ae 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -871,7 +871,7 @@ static uint16_t read_blob(struct gatt_channel *channel, uint16_t handle,
 
 static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 					const uint8_t *value, size_t vlen,
-					uint8_t *pdu, size_t len)
+					uint8_t *pdu, size_t len, uint16_t offset)
 {
 	struct attribute *a;
 	uint8_t status;
@@ -894,7 +894,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 	if (bt_uuid_cmp(&ccc_uuid, &a->uuid) != 0) {
 
 		attrib_db_update(channel->server->adapter, handle, NULL,
-							value, vlen, NULL);
+							value, vlen, NULL, offset);
 
 		if (a->write_cb) {
 			status = a->write_cb(a, channel->device,
@@ -994,6 +994,7 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 	uint8_t *value = g_attrib_get_buffer(channel->attrib, &vlen);
 
 	DBG("op 0x%02x", ipdu[0]);
+	length = 0;
 
 	if (len > vlen) {
 		error("Too much data on ATT socket");
@@ -1071,13 +1072,13 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 		}
 
 		length = write_value(channel, start, value, vlen, opdu,
-								channel->mtu);
+								channel->mtu, 0);
 		break;
 	case ATT_OP_WRITE_CMD:
 		length = dec_write_cmd(ipdu, len, &start, value, &vlen);
 		if (length > 0)
 			write_value(channel, start, value, vlen, opdu,
-								channel->mtu);
+								channel->mtu, 0);
 		return;
 	case ATT_OP_FIND_BY_TYPE_REQ:
 		length = dec_find_by_type_req(ipdu, len, &start, &end,
@@ -1096,9 +1097,20 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 	case ATT_OP_HANDLE_NOTIFY:
 		/* The attribute client is already handling these */
 		return;
-	case ATT_OP_READ_MULTI_REQ:
 	case ATT_OP_PREP_WRITE_REQ:
+		length = dec_prep_write_req(ipdu, len, &start, &offset, value, &vlen);
+		if (length == 0) {
+			status = ATT_ECODE_INVALID_PDU;
+			goto done;
+		}
+
+		length = write_value(channel, start, value, vlen, opdu,
+									channel->mtu, offset);
+		break;
+
 	case ATT_OP_EXEC_WRITE_REQ:
+		break;
+	case ATT_OP_READ_MULTI_REQ:
 	default:
 		DBG("Unsupported request 0x%02x", ipdu[0]);
 		status = ATT_ECODE_REQ_NOT_SUPP;
@@ -1562,7 +1574,7 @@ struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
 
 int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 					bt_uuid_t *uuid, const uint8_t *value,
-					size_t len, struct attribute **attr)
+					size_t len, struct attribute **attr, uint16_t offset)
 {
 	struct gatt_server *server;
 	struct attribute *a;
@@ -1585,12 +1597,33 @@ int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 
 	a = dl->data;
 
-	a->data = g_try_realloc(a->data, len);
+	if (offset) {
+		uint8_t *temp;
+		temp = malloc(sizeof(uint8_t) * a->len);
+		if (temp == NULL) {
+			DBG("Unable to allocate memory");
+			return -ENOMEM;
+		}
+		memcpy(temp, a->data, a->len);
+		a->data = g_try_realloc(a->data, (a->len + (a->len - offset) + len));
+		memcpy(a->data, temp, a->len);
+		free(temp);
+	}
+	else {
+		a->data = g_try_realloc(a->data, len);
+	}
+
 	if (len && a->data == NULL)
 		return -ENOMEM;
 
-	a->len = len;
-	memcpy(a->data, value, len);
+	if (offset) {
+		a->len = a->len + (a->len - offset) + len;
+		memcpy((a->data + offset), value, len);
+	}
+	else {
+		a->len = len;
+		memcpy(a->data, value, len);
+	}
 
 	if (uuid != NULL)
 		a->uuid = *uuid;
@@ -1656,5 +1689,5 @@ int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
 		return -ENOSYS;
 	}
 
-	return attrib_db_update(adapter, handle, NULL, value, len, NULL);
+	return attrib_db_update(adapter, handle, NULL, value, len, NULL, 0);
 }
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 063cb66..8b9e26e 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -30,7 +30,7 @@ struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
 				size_t len);
 int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 					bt_uuid_t *uuid, const uint8_t *value,
-					size_t len, struct attribute **attr);
+					size_t len, struct attribute **attr, uint16_t offset);
 int attrib_db_del(struct btd_adapter *adapter, uint16_t handle);
 int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
 					const uint8_t *value, size_t len);
-- 
1.9.1

