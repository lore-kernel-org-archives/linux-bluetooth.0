Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] Fix loop when setting adapter name
Date: Fri,  2 Sep 2011 13:45:08 -0300
Message-Id: <1314981909-12966-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When management interface is enabled, name changed event comes when the
adapter is initialized as consequence of the Read Local Name. Use the
same function to set and handle event causes looping when bluetoothd
starts if the name stored in the controller is different from the name
provided by the adapter name plugin.

Splitting the adapter_update_local_name also fix the PropertyChanged
(for Name) signal being sent before AdapterAdded.
---
 plugins/adaptername.c |    6 +++---
 plugins/hciops.c      |    2 +-
 plugins/mgmtops.c     |    6 +++---
 src/adapter.c         |   43 +++++++++++++++++++++++--------------------
 src/adapter.h         |    3 ++-
 5 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index 9e99e6a..e154e92 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -184,12 +184,12 @@ static void set_pretty_name(struct btd_adapter *adapter,
 							current_id + 1);
 		DBG("Setting name '%s' for device 'hci%d'", str, current_id);
 
-		adapter_update_local_name(adapter, str);
+		adapter_set_name(adapter, str);
 		g_free(str);
 	} else {
 		DBG("Setting name '%s' for device 'hci%d'", pretty_hostname,
 								current_id);
-		adapter_update_local_name(adapter, pretty_hostname);
+		adapter_set_name(adapter, pretty_hostname);
 	}
 
 	/* And disable the name change now */
@@ -218,7 +218,7 @@ static int adaptername_probe(struct btd_adapter *adapter)
 		expand_name(name, MAX_NAME_LENGTH, main_opts.name, current_id);
 
 	DBG("Setting name '%s' for device 'hci%d'", name, current_id);
-	adapter_update_local_name(adapter, name);
+	adapter_set_name(adapter, name);
 
 	return 0;
 }
diff --git a/plugins/hciops.c b/plugins/hciops.c
index ddff544..c3fbf85 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1457,7 +1457,7 @@ static void update_name(int index, const char *name)
 
 	adapter = manager_find_adapter_by_id(index);
 	if (adapter)
-		adapter_update_local_name(adapter, name);
+		adapter_name_changed(adapter, name);
 
 	update_ext_inquiry_response(index);
 }
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 0f0cfd5..b54f166 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -835,7 +835,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 	else
 		mgmt_set_powered(index, TRUE);
 
-	adapter_update_local_name(adapter, (char *) rp->name);
+	adapter_name_changed(adapter, (char *) rp->name);
 
 	btd_adapter_unref(adapter);
 }
@@ -1062,7 +1062,7 @@ static void set_local_name_complete(int sk, uint16_t index, void *buf,
 		return;
 	}
 
-	adapter_update_local_name(adapter, (char *) rp->name);
+	adapter_name_changed(adapter, (char *) rp->name);
 }
 
 static void read_local_oob_data_complete(int sk, uint16_t index, void *buf,
@@ -1290,7 +1290,7 @@ static void mgmt_local_name_changed(int sk, uint16_t index, void *buf, size_t le
 
 	adapter = manager_find_adapter(&info->bdaddr);
 	if (adapter)
-		adapter_update_local_name(adapter, (char *) ev->name);
+		adapter_name_changed(adapter, (char *) ev->name);
 }
 
 static void mgmt_device_found(int sk, uint16_t index, void *buf, size_t len)
diff --git a/src/adapter.c b/src/adapter.c
index 7ee970c..30c17be 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -859,13 +859,25 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint32_t new_class)
 				DBUS_TYPE_UINT32, &new_class);
 }
 
-int adapter_update_local_name(struct btd_adapter *adapter, const char *name)
+void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 {
-	char *name_ptr;
+	if (g_strcmp0(adapter->name, name) == 0)
+		return;
 
-	if (adapter->allow_name_changes == FALSE)
-		return -EPERM;
+	strncpy(adapter->name, name, MAX_NAME_LENGTH);
+
+	if (connection)
+		emit_property_changed(connection, adapter->path,
+					ADAPTER_INTERFACE, "Name",
+					DBUS_TYPE_STRING, &name);
 
+	if (main_opts.attrib_server)
+		attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
+				(const uint8_t *) name, strlen(name));
+}
+
+int adapter_set_name(struct btd_adapter *adapter, const char *name)
+{
 	if (strncmp(name, adapter->name, MAX_NAME_LENGTH) == 0)
 		return 0;
 
@@ -874,27 +886,14 @@ int adapter_update_local_name(struct btd_adapter *adapter, const char *name)
 		return -EINVAL;
 	}
 
-	strncpy(adapter->name, name, MAX_NAME_LENGTH);
-
-	if (main_opts.attrib_server)
-		attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
-			(const uint8_t *) adapter->name, strlen(adapter->name));
-
-	name_ptr = adapter->name;
-
-	write_local_name(&adapter->bdaddr, adapter->name);
-
-	if (connection)
-		emit_property_changed(connection, adapter->path,
-					ADAPTER_INTERFACE, "Name",
-					DBUS_TYPE_STRING, &name_ptr);
-
 	if (adapter->up) {
 		int err = adapter_ops->set_name(adapter->dev_id, name);
 		if (err < 0)
 			return err;
 	}
 
+	write_local_name(&adapter->bdaddr, name);
+
 	return 0;
 }
 
@@ -904,7 +903,10 @@ static DBusMessage *set_name(DBusConnection *conn, DBusMessage *msg,
 	struct btd_adapter *adapter = data;
 	int ret;
 
-	ret = adapter_update_local_name(adapter, name);
+	if (adapter->allow_name_changes == FALSE)
+		return btd_error_failed(msg, strerror(EPERM));
+
+	ret = adapter_set_name(adapter, name);
 	if (ret == -EINVAL)
 		return btd_error_invalid_args(msg);
 	else if (ret < 0)
@@ -2274,6 +2276,7 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	adapter->mode = MODE_CONNECTABLE;
 	adapter->off_timer = 0;
 
+	/* Forcing: Name is lost when adapter is powered off */
 	adapter_ops->set_name(adapter->dev_id, adapter->name);
 
 	if (read_local_class(&adapter->bdaddr, cls) < 0) {
diff --git a/src/adapter.h b/src/adapter.h
index f1f546c..76f41b1 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -117,7 +117,8 @@ int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
-int adapter_update_local_name(struct btd_adapter *adapter, const char *name);
+int adapter_set_name(struct btd_adapter *adapter, const char *name);
+void adapter_name_changed(struct btd_adapter *adapter, const char *name);
 void adapter_service_insert(struct btd_adapter *adapter, void *rec);
 void adapter_service_remove(struct btd_adapter *adapter, void *rec);
 void btd_adapter_class_changed(struct btd_adapter *adapter,
-- 
1.7.6

