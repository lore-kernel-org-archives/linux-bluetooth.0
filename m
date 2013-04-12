Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH] Make "Powered" property persistent across reboots.
Date: Fri, 12 Apr 2013 14:51:33 -0700
Message-Id: <1365803493-6716-2-git-send-email-deymo@chromium.org>
In-Reply-To: <1365803493-6716-1-git-send-email-deymo@chromium.org>
References: <1365803493-6716-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

As part of the daemon shutdown the adapter is powered off. Restarting the
daemon will recover the current status from the adapter, but those will
always show the adapter as powered off. This patch adds a new property to
the "settings" adapter's file storing the desired powered status for the
adapter on adapter_start. This setting ignores the power status changes from
sources other than the DBus client. Among those ignored sources we have
deamon shutdown, adapter removal (in case of an USB dongle) and suspend.
The adapter's power status is restored on daemon startup and adapter reinsert.
Also, the powered status is migrated from BlueZ 4 config file if the new
config file is not present.
---
 src/adapter.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 6255da6..f469d52 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -133,6 +133,7 @@ struct btd_adapter {
 	char *short_name;		/* controller short name */
 	uint32_t supported_settings;	/* controller supported settings */
 	uint32_t current_settings;	/* current controller settings */
+	bool desired_powered;		/* powered status desired by clients */
 
 	char *path;			/* adapter object path */
 	uint8_t major_class;		/* configured major class */
@@ -384,6 +385,10 @@ static void store_adapter_info(struct btd_adapter *adapter)
 		g_key_file_set_string(key_file, "General", "Alias",
 							adapter->stored_alias);
 
+	/* Always store the powered status */
+	g_key_file_set_boolean(key_file, "General", "Powered",
+						adapter->desired_powered);
+
 	ba2str(&adapter->bdaddr, address);
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/settings", address);
 	filename[PATH_MAX] = '\0';
@@ -441,6 +446,12 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 	        g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Powered");
 
+		/* Don't store the adapter information during daemon shutdown.
+		 * It will store the adapter as powered "off" as part of the
+		 * shutdown. */
+		if (!powering_down)
+			store_adapter_info(adapter);
+
 		if (adapter->current_settings & MGMT_SETTING_POWERED) {
 			adapter_start(adapter);
 		} else {
@@ -1957,6 +1968,7 @@ static void property_set_powered(const GDBusPropertyTable *property,
 				GDBusPendingPropertySet id, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
+	dbus_bool_t enabled;
 
 	if (powering_down) {
 		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
@@ -1964,6 +1976,9 @@ static void property_set_powered(const GDBusPropertyTable *property,
 		return;
 	}
 
+	dbus_message_iter_get_basic(iter, &enabled);
+	adapter->desired_powered = enabled;
+
 	property_set_mode(adapter, MGMT_SETTING_POWERED, iter, id);
 }
 
@@ -3739,6 +3754,8 @@ static void convert_config(struct btd_adapter *adapter, const char *filename,
 		mode = get_mode(str);
 		g_key_file_set_boolean(key_file, "General", "Discoverable",
 					mode == MODE_DISCOVERABLE);
+		g_key_file_set_boolean(key_file, "General", "Powered",
+			mode == MODE_DISCOVERABLE || mode == MODE_CONNECTABLE);
 	}
 
 	if (read_local_name(&adapter->bdaddr, str) == 0)
@@ -3837,6 +3854,7 @@ static void load_config(struct btd_adapter *adapter)
 	char address[18];
 	struct stat st;
 	GError *gerr = NULL;
+	gboolean powered;
 
 	ba2str(&adapter->bdaddr, address);
 
@@ -3888,6 +3906,17 @@ static void load_config(struct btd_adapter *adapter)
 		gerr = NULL;
 	}
 
+	/* Get power status */
+	powered = g_key_file_get_boolean(key_file, "General", "Powered", &gerr);
+	if (gerr) {
+		powered = false;
+		g_error_free(gerr);
+		gerr = NULL;
+	}
+	/* Update the power status for this adapter */
+	adapter->desired_powered = powered;
+	set_mode(adapter, MGMT_OP_SET_POWERED, powered ? 0x01 : 0x00);
+
 	g_key_file_free(key_file);
 }
 
-- 
1.8.1.3
