Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] Fix not setting class of device in adapter
Date: Mon, 30 Jul 2012 11:01:19 +0200
Message-ID: <1343638879-31253-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set class of device in adapter when new class is received from kernel.
This fix adapters property Class being always zero.
---
 lib/mgmt.h    |    4 ++++
 src/adapter.c |   25 +++++++++++++++----------
 src/adapter.h |    2 +-
 src/mgmt.c    |   33 +++++++++++++++++++++++++++++++--
 4 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index a58915b..83dcd84 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -109,6 +109,10 @@ struct mgmt_mode {
 	uint8_t val;
 } __packed;
 
+struct mgmt_cod {
+	uint8_t val[3];
+} __packed;
+
 #define MGMT_OP_SET_POWERED		0x0005
 
 #define MGMT_OP_SET_DISCOVERABLE	0x0006
diff --git a/src/adapter.c b/src/adapter.c
index 1c6e57b..b7691d0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -684,27 +684,32 @@ static DBusMessage *set_pairable_timeout(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-void btd_adapter_class_changed(struct btd_adapter *adapter, uint32_t new_class)
+void btd_adapter_class_changed(struct btd_adapter *adapter, uint8_t *new_class)
 {
-	uint8_t class[3];
+	uint32_t class;
 
-	class[2] = (new_class >> 16) & 0xff;
-	class[1] = (new_class >> 8) & 0xff;
-	class[0] = new_class & 0xff;
+	class = new_class[0] | (new_class[1] << 8) | (new_class[2] << 16);
 
-	write_local_class(&adapter->bdaddr, class);
+	if (class == adapter->dev_class)
+		return;
+
+	write_local_class(&adapter->bdaddr, new_class);
 
-	adapter->dev_class = new_class;
+	adapter->dev_class = class;
 
 	if (main_opts.gatt_enabled) {
+		uint8_t cls[3];
+
+		memcpy(cls, new_class, sizeof(cls));
+
 		/* Removes service class */
-		class[1] = class[1] & 0x1f;
-		attrib_gap_set(adapter, GATT_CHARAC_APPEARANCE, class, 2);
+		cls[1] = cls[1] & 0x1f;
+		attrib_gap_set(adapter, GATT_CHARAC_APPEARANCE, cls, 2);
 	}
 
 	emit_property_changed(connection, adapter->path,
 				ADAPTER_INTERFACE, "Class",
-				DBUS_TYPE_UINT32, &new_class);
+				DBUS_TYPE_UINT32, &class);
 }
 
 void adapter_name_changed(struct btd_adapter *adapter, const char *name)
diff --git a/src/adapter.h b/src/adapter.h
index 602bb6f..d8a1bb1 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -120,7 +120,7 @@ void adapter_name_changed(struct btd_adapter *adapter, const char *name);
 void adapter_service_insert(struct btd_adapter *adapter, void *rec);
 void adapter_service_remove(struct btd_adapter *adapter, void *rec);
 void btd_adapter_class_changed(struct btd_adapter *adapter,
-							uint32_t new_class);
+							uint8_t *new_class);
 void btd_adapter_pairable_changed(struct btd_adapter *adapter,
 							gboolean pairable);
 
diff --git a/src/mgmt.c b/src/mgmt.c
index c55b1a8..c893972 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1308,6 +1308,30 @@ static void handle_pending_uuids(uint16_t index)
 	g_free(pending);
 }
 
+static void mgmt_update_cod(uint16_t index, void *buf, size_t len)
+{
+	struct mgmt_cod *rp = buf;
+	struct controller_info *info;
+	struct btd_adapter *adapter;
+
+	DBG("index %d", index);
+
+	if (len < sizeof(*rp)) {
+		error("Too small class of device reply");
+		return;
+	}
+
+	info = &controllers[index];
+
+	adapter = manager_find_adapter(&info->bdaddr);
+	if (adapter == NULL) {
+		DBG("Adapter not found");
+		return;
+	}
+
+	btd_adapter_class_changed(adapter, rp->val);
+}
+
 static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
 								size_t len)
 {
@@ -1318,6 +1342,7 @@ static void mgmt_add_uuid_complete(int sk, uint16_t index, void *buf,
 		return;
 	}
 
+	mgmt_update_cod(index, buf, len);
 	handle_pending_uuids(index);
 }
 
@@ -1370,9 +1395,11 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 		break;
 	case MGMT_OP_REMOVE_UUID:
 		DBG("remove_uuid complete");
+		mgmt_update_cod(index, buf, len);
 		break;
 	case MGMT_OP_SET_DEV_CLASS:
 		DBG("set_dev_class complete");
+		mgmt_update_cod(index, buf, len);
 		break;
 	case MGMT_OP_LOAD_LINK_KEYS:
 		DBG("load_link_keys complete");
@@ -1735,7 +1762,7 @@ static void mgmt_new_ltk(int sk, uint16_t index, void *buf, size_t len)
 		bonding_complete(info, &ev->key.addr.bdaddr, 0);
 }
 
-static void mgmt_cod_changed(int sk, uint16_t index)
+static void mgmt_cod_changed(int sk, uint16_t index, void *buf, size_t len)
 {
 	struct controller_info *info;
 
@@ -1752,6 +1779,8 @@ static void mgmt_cod_changed(int sk, uint16_t index)
 		info->pending_cod_change = FALSE;
 		handle_pending_uuids(index);
 	}
+
+	mgmt_update_cod(index, buf, len);
 }
 
 static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data)
@@ -1817,7 +1846,7 @@ static gboolean mgmt_event(GIOChannel *io, GIOCondition cond, gpointer user_data
 		mgmt_new_settings(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_CLASS_OF_DEV_CHANGED:
-		mgmt_cod_changed(sk, index);
+		mgmt_cod_changed(sk, index, buf + MGMT_HDR_SIZE, len);
 		break;
 	case MGMT_EV_NEW_LINK_KEY:
 		mgmt_new_link_key(sk, index, buf + MGMT_HDR_SIZE, len);
-- 
1.7.9.5

