Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Cc: keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v2] core: Expose HIDNormallyConnectable and HIDReconnectInitiate properties
Date: Mon,  1 Apr 2013 14:39:51 -0700
Message-Id: <1364852391-15929-1-git-send-email-deymo@chromium.org>
In-Reply-To: <1363655144-9705-1-git-send-email-deymo@chromium.org>
References: <1363655144-9705-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The "Connectability" of a HID device, as defined by the HID spec,
governs the way the host may and should connect to a HID device or
expect a connection from it. In the comon case of mice and keyboards
the HIDNormallyConnectable is FALSE and HIDReconnectInitiate is TRUE,
since those devices only attempt a connection to the host when they
have some data to transfer. A connection attempt initiated from the
host after the device drops the connection (while still paired) will
result in a Page timeout.

This patch exposes these two HID properties as Device properties, updates
them every time new SDP records are available and persists them in the
device's info file. This patch also shows this information in the
bluetoothctl "info <dev>" command.
For non-HID devices and when no information is available (i.e. a cached
device after upgrade from a version without this patch) both properties
are set to the comon case: HIDNormallyConnectable is FALSE and
HIDReconnectInitiate is TRUE.
---
 doc/input-api.txt       |  29 ++++++++
 profiles/input/device.c | 175 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 doc/input-api.txt

diff --git a/doc/input-api.txt b/doc/input-api.txt
new file mode 100644
index 0000000..dffd9fb
--- /dev/null
+++ b/doc/input-api.txt
@@ -0,0 +1,29 @@
+BlueZ D-Bus Input API description
+*********************************
+
+Input hierarchy
+===============
+
+Service		org.bluez
+Interface	org.bluez.Input1
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties	boolean NormallyConnectable [readonly, optional]
+
+			Exposes the value of HIDNormallyConnectable as defined
+			by the HID profile specification. If this optional value
+			is not specified by the HID device, the value is asumend
+			as FALSE.
+
+			If the value of the property is unknown, for example
+			upgrading from a previous version of BlueZ, the property
+			is missing.
+
+		boolean ConnectInitiate [readonly, optional]
+
+			Exposes the value of ConnectInitiate as defined by the
+			HID profile specification.
+
+			If the value of the property is unknown, for example
+			upgrading from a previous version of BlueZ, the property
+			is missing.
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 1da9d99..dd2a3ab 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -54,6 +54,8 @@
 
 #include "sdp-client.h"
 
+#define INPUT_INTERFACE "org.bluez.Input1"
+
 struct input_device {
 	struct btd_device	*device;
 	char			*path;
@@ -71,6 +73,9 @@ struct input_device {
 	guint			dc_id;
 	gboolean		disable_sdp;
 	char			*name;
+	gboolean		hid_props_present;
+	gboolean		normally_connectable;
+	gboolean		reconnect_initiate;
 };
 
 static GSList *devices = NULL;
@@ -116,6 +121,83 @@ static void input_device_free(struct input_device *idev)
 	g_free(idev);
 }
 
+static void input_device_config_filename(struct input_device *idev,
+						char *filename, size_t maxlen)
+{
+	char adapter_addr[18];
+	char device_addr[18];
+
+	ba2str(device_get_address(idev->device), device_addr);
+	ba2str(adapter_get_address(device_get_adapter(idev->device)),
+								adapter_addr);
+	snprintf(filename, maxlen, STORAGEDIR "/%s/%s/info", adapter_addr,
+								device_addr);
+	filename[maxlen-1] = '\0';
+}
+
+static void input_device_load_props(struct input_device *idev)
+{
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	GError *err = NULL;
+
+	input_device_config_filename(idev, filename, PATH_MAX + 1);
+
+	key_file = g_key_file_new();
+	if (!key_file)
+		return;
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	/* Load HID connectivity properties */
+	idev->normally_connectable = g_key_file_get_boolean(key_file,
+				"Input", "NormallyConnectable", &err);
+	if (err) {
+		idev->normally_connectable = FALSE;
+		g_error_free(err);
+		err = NULL;
+	} else
+		idev->hid_props_present = TRUE;
+
+	idev->reconnect_initiate = g_key_file_get_boolean(key_file,
+				"Input", "ReconnectInitiate", &err);
+	if (err) {
+		idev->reconnect_initiate = TRUE;
+		g_error_free(err);
+		err = NULL;
+	} else
+		idev->hid_props_present = TRUE;
+
+	g_key_file_free(key_file);
+}
+
+static void input_device_store_props(struct input_device *idev)
+{
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char *str;
+	gsize length = 0;
+
+	input_device_config_filename(idev, filename, PATH_MAX + 1);
+
+	key_file = g_key_file_new();
+	if (!key_file)
+		return;
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	g_key_file_set_boolean(key_file, "Input",
+		"NormallyConnectable", idev->normally_connectable);
+	g_key_file_set_boolean(key_file, "Input",
+		"ReconnectInitiate", idev->reconnect_initiate);
+
+	create_file(filename, S_IRUSR | S_IWUSR);
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, str, length, NULL);
+	g_free(str);
+
+	g_key_file_free(key_file);
+}
+
 static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct input_device *idev = data;
@@ -694,6 +776,9 @@ static struct input_device *input_device_new(struct btd_device *device,
 	if (strlen(name) > 0)
 		idev->name = g_strdup(name);
 
+	idev->hid_props_present = FALSE;
+	input_device_load_props(idev);
+
 	return idev;
 }
 
@@ -706,6 +791,81 @@ static gboolean is_device_sdp_disable(const sdp_record_t *rec)
 	return data && data->val.uint8;
 }
 
+static void update_hid_props(struct input_device *idev,
+		gboolean normally_connectable, gboolean reconnect_initiate)
+{
+	gboolean update_nc, update_ri;
+	DBusConnection *dbus_conn = btd_get_dbus_connection();
+
+	update_nc = !idev->hid_props_present ||
+			idev->normally_connectable != normally_connectable;
+	idev->normally_connectable = normally_connectable;
+	if (update_nc)
+		g_dbus_emit_property_changed(dbus_conn, idev->path,
+				DEVICE_INTERFACE, "HIDNormallyConnectable");
+
+	update_ri = !idev->hid_props_present ||
+				idev->reconnect_initiate != reconnect_initiate;
+	idev->reconnect_initiate = reconnect_initiate;
+	if (update_ri)
+		g_dbus_emit_property_changed(dbus_conn, idev->path,
+				DEVICE_INTERFACE, "HIDReconnectInitiate");
+
+	idev->hid_props_present = TRUE;
+	if (update_nc || update_ri)
+		input_device_store_props(idev);
+}
+
+static void extract_hid_props(struct input_device *idev,
+							const sdp_record_t *rec)
+{
+	/* Extract HID connectability */
+	bool hid_nc, hid_ri;
+	sdp_data_t *pdlist;
+
+	/* HIDNormallyConnectable is optional and assumed FALSE
+	* if not present. */
+	pdlist = sdp_data_get(rec, SDP_ATTR_HID_NORMALLY_CONNECTABLE);
+	hid_nc = pdlist ? pdlist->val.uint8 : FALSE;
+
+	pdlist = sdp_data_get(rec, SDP_ATTR_HID_RECONNECT_INITIATE);
+	hid_ri = pdlist ? pdlist->val.uint8 : TRUE;
+
+	update_hid_props(idev, hid_nc, hid_ri);
+}
+
+static gboolean property_get_normally_connectable(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct input_device *idev = data;
+
+	if (idev->hid_props_present)
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+						&idev->normally_connectable);
+
+	return TRUE;
+}
+
+static gboolean property_get_reconnect_initiate(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct input_device *idev = data;
+
+	if (idev->hid_props_present)
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+						&idev->reconnect_initiate);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable input_properties[] = {
+	{ "NormallyConnectable", "b", property_get_normally_connectable },
+	{ "ReconnectInitiate", "b", property_get_reconnect_initiate },
+	{ }
+};
+
 int input_device_register(struct btd_device *device,
 					const char *path, const char *uuid,
 					const sdp_record_t *rec, int timeout)
@@ -723,6 +883,18 @@ int input_device_register(struct btd_device *device,
 	if (!idev)
 		return -EINVAL;
 
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+					idev->path, INPUT_INTERFACE,
+					NULL, NULL,
+					input_properties, idev,
+					NULL) == FALSE) {
+		error("Unable to register %s interface", INPUT_INTERFACE);
+		input_device_free(idev);
+		return -EINVAL;
+	}
+
+	extract_hid_props(idev, rec);
+
 	idev->timeout = timeout;
 	idev->uuid = g_strdup(uuid);
 
@@ -761,6 +933,9 @@ int input_device_unregister(const char *path, const char *uuid)
 		return -EBUSY;
 	}
 
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						idev->path, INPUT_INTERFACE);
+
 	devices = g_slist_remove(devices, idev);
 	input_device_free(idev);
 
-- 
1.8.1.3
