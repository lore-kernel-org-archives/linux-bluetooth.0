Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/2] Simplify "SetName" D-Bus call
Date: Thu,  9 Jun 2011 14:53:09 +0100
Message-Id: <1307627589-25786-2-git-send-email-hadess@hadess.net>
In-Reply-To: <1307627589-25786-1-git-send-email-hadess@hadess.net>
References: <1307627589-25786-1-git-send-email-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

By merging most of the functionality into adapter_update_local_name()
This also allows us to drop the adapter->name_stored struct member
as in any calls to adapter_update_local_name(), we would want to
write out the adapter name.
---
 src/adapter.c |   59 ++++++++++++++++++++++++--------------------------------
 src/adapter.h |    2 +-
 2 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b189841..31f1f37 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -148,8 +148,6 @@ struct btd_adapter {
 
 	GSList *powered_callbacks;
 
-	gboolean name_stored;
-
 	GSList *loaded_drivers;
 };
 
@@ -916,10 +914,17 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint32_t new_class)
 				DBUS_TYPE_UINT32, &new_class);
 }
 
-void adapter_update_local_name(struct btd_adapter *adapter, const char *name)
+int adapter_update_local_name(struct btd_adapter *adapter, const char *name)
 {
+	char *name_ptr;
+
 	if (strncmp(name, adapter->name, MAX_NAME_LENGTH) == 0)
-		return;
+		return 0;
+
+	if (!g_utf8_validate(name, -1, NULL)) {
+		error("Name change failed: supplied name isn't valid UTF-8");
+		return -EINVAL;
+	}
 
 	strncpy(adapter->name, name, MAX_NAME_LENGTH);
 
@@ -927,18 +932,22 @@ void adapter_update_local_name(struct btd_adapter *adapter, const char *name)
 		attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
 			(const uint8_t *) adapter->name, strlen(adapter->name));
 
-	if (!adapter->name_stored) {
-		char *name_ptr = adapter->name;
+	name_ptr = adapter->name;
 
-		write_local_name(&adapter->bdaddr, adapter->name);
+	write_local_name(&adapter->bdaddr, adapter->name);
 
-		if (connection)
-			emit_property_changed(connection, adapter->path,
-						ADAPTER_INTERFACE, "Name",
-						DBUS_TYPE_STRING, &name_ptr);
+	if (connection)
+		emit_property_changed(connection, adapter->path,
+				      ADAPTER_INTERFACE, "Name",
+				      DBUS_TYPE_STRING, &name_ptr);
+
+	if (adapter->up) {
+		int err = adapter_ops->set_name(adapter->dev_id, name);
+		if (err < 0)
+			return err;
 	}
 
-	adapter->name_stored = FALSE;
+	return 0;
 }
 
 static DBusMessage *set_name(DBusConnection *conn, DBusMessage *msg,
@@ -947,29 +956,12 @@ static DBusMessage *set_name(DBusConnection *conn, DBusMessage *msg,
 	struct btd_adapter *adapter = data;
 	char *name_ptr = adapter->name;
 
-	if (!g_utf8_validate(name, -1, NULL)) {
-		error("Name change failed: supplied name isn't valid UTF-8");
+	ret = adapter_update_local_name(adapter, name);
+	if (ret == -EINVAL)
 		return btd_error_invalid_args(msg);
-	}
-
-	if (strncmp(name, adapter->name, MAX_NAME_LENGTH) == 0)
-		goto done;
-
-	strncpy(adapter->name, name, MAX_NAME_LENGTH);
-	write_local_name(&adapter->bdaddr, name);
-	emit_property_changed(connection, adapter->path,
-					ADAPTER_INTERFACE, "Name",
-					DBUS_TYPE_STRING, &name_ptr);
-
-	if (adapter->up) {
-		int err = adapter_ops->set_name(adapter->dev_id, name);
-		if (err < 0)
-			return btd_error_failed(msg, strerror(-err));
-
-		adapter->name_stored = TRUE;
-	}
+	else if (ret < 0)
+		return btd_error_failed(msg, strerror(-err));
 
-done:
 	return dbus_message_new_method_return(msg);
 }
 
@@ -2498,7 +2490,6 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	adapter->mode = MODE_OFF;
 	adapter->state = STATE_IDLE;
 	adapter->off_requested = FALSE;
-	adapter->name_stored = FALSE;
 
 	call_adapter_powered_callbacks(adapter, FALSE);
 
diff --git a/src/adapter.h b/src/adapter.h
index 3526849..13971bf 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -115,7 +115,7 @@ int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
-void adapter_update_local_name(struct btd_adapter *adapter, const char *name);
+int adapter_update_local_name(struct btd_adapter *adapter, const char *name);
 void adapter_service_insert(struct btd_adapter *adapter, void *rec);
 void adapter_service_remove(struct btd_adapter *adapter, void *rec);
 void btd_adapter_class_changed(struct btd_adapter *adapter,
-- 
1.7.5.1

