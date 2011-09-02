Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] Prevents sending Write Local Name when not needed
Date: Fri,  2 Sep 2011 13:45:09 -0300
Message-Id: <1314981909-12966-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1314981909-12966-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1314981909-12966-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix unneeded Write Local Name command being sent when bluetoothd starts
or switching the adapter on. Using an array of chars it is not possible
to distinguish if there is a valid value to be set since empty is a
valid value.
---
 src/adapter.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 30c17be..9b142b9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -110,7 +110,7 @@ struct btd_adapter {
 	char *path;			/* adapter object path */
 	bdaddr_t bdaddr;		/* adapter Bluetooth Address */
 	uint32_t dev_class;		/* Class of Device */
-	char name[MAX_NAME_LENGTH + 1]; /* adapter name */
+	char *name;			/* adapter name */
 	gboolean allow_name_changes;	/* whether the adapter name can be changed */
 	guint discov_timeout_id;	/* discoverable timeout id */
 	guint stop_discov_id;		/* stop inquiry/scanning id */
@@ -864,7 +864,8 @@ void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 	if (g_strcmp0(adapter->name, name) == 0)
 		return;
 
-	strncpy(adapter->name, name, MAX_NAME_LENGTH);
+	g_free(adapter->name);
+	adapter->name = g_strdup(name);
 
 	if (connection)
 		emit_property_changed(connection, adapter->path,
@@ -878,21 +879,25 @@ void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 
 int adapter_set_name(struct btd_adapter *adapter, const char *name)
 {
-	if (strncmp(name, adapter->name, MAX_NAME_LENGTH) == 0)
+	char maxname[MAX_NAME_LENGTH + 1];
+
+	if (g_strcmp0(adapter->name, name) == 0)
 		return 0;
 
-	if (!g_utf8_validate(name, -1, NULL)) {
+	memset(maxname, 0, sizeof(maxname));
+	strncpy(maxname, name, MAX_NAME_LENGTH);
+	if (!g_utf8_validate(maxname, -1, NULL)) {
 		error("Name change failed: supplied name isn't valid UTF-8");
 		return -EINVAL;
 	}
 
 	if (adapter->up) {
-		int err = adapter_ops->set_name(adapter->dev_id, name);
+		int err = adapter_ops->set_name(adapter->dev_id, maxname);
 		if (err < 0)
 			return err;
 	}
 
-	write_local_name(&adapter->bdaddr, name);
+	write_local_name(&adapter->bdaddr, maxname);
 
 	return 0;
 }
@@ -1233,7 +1238,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
-	char str[MAX_NAME_LENGTH + 1], srcaddr[18];
+	char srcaddr[18];
 	gboolean value;
 	char **devices, **uuids;
 	int i;
@@ -1261,9 +1266,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	dict_append_entry(&dict, "Address", DBUS_TYPE_STRING, &property);
 
 	/* Name */
-	memset(str, 0, sizeof(str));
-	strncpy(str, (char *) adapter->name, MAX_NAME_LENGTH);
-	property = str;
+	property = (adapter->name ? : "");
 
 	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &property);
 
@@ -2277,7 +2280,8 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	adapter->off_timer = 0;
 
 	/* Forcing: Name is lost when adapter is powered off */
-	adapter_ops->set_name(adapter->dev_id, adapter->name);
+	if (adapter->name)
+		adapter_ops->set_name(adapter->dev_id, adapter->name);
 
 	if (read_local_class(&adapter->bdaddr, cls) < 0) {
 		uint32_t class = htobl(main_opts.class);
@@ -2471,6 +2475,7 @@ static void adapter_free(gpointer user_data)
 	g_slist_free(adapter->oor_devices);
 
 	g_free(adapter->path);
+	g_free(adapter->name);
 	g_free(adapter);
 }
 
-- 
1.7.6

