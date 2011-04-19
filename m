Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 3/4] Move adapter name from struct hci_dev to struct btd_adapter
Date: Tue, 19 Apr 2011 16:34:02 -0400
Message-Id: <1303245243-12116-4-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1303245243-12116-1-git-send-email-bruna.moreira@openbossa.org>
References: <1303245243-12116-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It makes more sense to have this information on the adapter structure,
as it is not HCI specific.
---
 src/adapter.c |   30 ++++++++++++++----------------
 src/adapter.h |    1 -
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6707241..2b9f719 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -113,6 +113,7 @@ struct btd_adapter {
 	char *path;			/* adapter object path */
 	bdaddr_t bdaddr;		/* adapter Bluetooth Address */
 	uint32_t dev_class;		/* Class of Device */
+	char name[MAX_NAME_LENGTH + 1]; /* adapter name */
 	guint discov_timeout_id;	/* discoverable timeout id */
 	guint stop_discov_id;		/* stop inquiry/scanning id */
 	uint32_t discov_timeout;	/* discoverable time(sec) */
@@ -926,21 +927,19 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint32_t new_class)
 
 void adapter_update_local_name(struct btd_adapter *adapter, const char *name)
 {
-	struct hci_dev *dev = &adapter->dev;
-
-	if (strncmp(name, dev->name, MAX_NAME_LENGTH) == 0)
+	if (strncmp(name, adapter->name, MAX_NAME_LENGTH) == 0)
 		return;
 
-	strncpy(dev->name, name, MAX_NAME_LENGTH);
+	strncpy(adapter->name, name, MAX_NAME_LENGTH);
 
 	if (main_opts.attrib_server)
 		attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
-			(const uint8_t *) dev->name, strlen(dev->name));
+			(const uint8_t *) adapter->name, strlen(adapter->name));
 
 	if (!adapter->name_stored) {
-		char *name_ptr = dev->name;
+		char *name_ptr = adapter->name;
 
-		write_local_name(&adapter->bdaddr, dev->name);
+		write_local_name(&adapter->bdaddr, adapter->name);
 
 		if (connection)
 			emit_property_changed(connection, adapter->path,
@@ -955,18 +954,17 @@ static DBusMessage *set_name(DBusConnection *conn, DBusMessage *msg,
 					const char *name, void *data)
 {
 	struct btd_adapter *adapter = data;
-	struct hci_dev *dev = &adapter->dev;
-	char *name_ptr = dev->name;
+	char *name_ptr = adapter->name;
 
 	if (!g_utf8_validate(name, -1, NULL)) {
 		error("Name change failed: supplied name isn't valid UTF-8");
 		return btd_error_invalid_args(msg);
 	}
 
-	if (strncmp(name, dev->name, MAX_NAME_LENGTH) == 0)
+	if (strncmp(name, adapter->name, MAX_NAME_LENGTH) == 0)
 		goto done;
 
-	strncpy(dev->name, name, MAX_NAME_LENGTH);
+	strncpy(adapter->name, name, MAX_NAME_LENGTH);
 	write_local_name(&adapter->bdaddr, name);
 	emit_property_changed(connection, adapter->path,
 					ADAPTER_INTERFACE, "Name",
@@ -1362,7 +1360,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 
 	/* Name */
 	memset(str, 0, sizeof(str));
-	strncpy(str, (char *) adapter->dev.name, MAX_NAME_LENGTH);
+	strncpy(str, (char *) adapter->name, MAX_NAME_LENGTH);
 	property = str;
 
 	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &property);
@@ -2454,7 +2452,7 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	if (main_opts.le)
 		adapter_ops->enable_le(adapter->dev_id);
 
-	adapter_ops->set_name(adapter->dev_id, adapter->dev.name);
+	adapter_ops->set_name(adapter->dev_id, adapter->name);
 
 	if (read_local_class(&adapter->bdaddr, cls) < 0) {
 		uint32_t class = htobl(main_opts.class);
@@ -2698,13 +2696,13 @@ gboolean adapter_init(struct btd_adapter *adapter)
 		return FALSE;
 	}
 
-	if (read_local_name(&adapter->bdaddr, adapter->dev.name) < 0)
-		expand_name(adapter->dev.name, MAX_NAME_LENGTH, main_opts.name,
+	if (read_local_name(&adapter->bdaddr, adapter->name) < 0)
+		expand_name(adapter->name, MAX_NAME_LENGTH, main_opts.name,
 							adapter->dev_id);
 
 	if (main_opts.attrib_server)
 		attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
-			(const uint8_t *) dev->name, strlen(dev->name));
+			(const uint8_t *) adapter->name, strlen(adapter->name));
 
 	sdp_init_services_list(&adapter->bdaddr);
 	load_drivers(adapter);
diff --git a/src/adapter.h b/src/adapter.h
index 01659f1..4d8824e 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -93,7 +93,6 @@ struct hci_dev {
 	uint8_t  features[8];
 	uint8_t  extfeatures[8];
 
-	char     name[MAX_NAME_LENGTH + 1];
 };
 
 void btd_adapter_start(struct btd_adapter *adapter);
-- 
1.7.0.4

